FROM amazonlinux:latest
MAINTAINER Levon Becker "levon.docker@bonusbits.com"
ENTRYPOINT ["/bin/bash"]
# SSH Args
ARG ssh_key

# User Args
ARG sudo_user=docker

# Cookbook Args
ARG chef_client_version=12.18.31
ARG cookbook_name=bonusbits_mediawiki_nginx
ARG chef_role=web
ARG chef_environment=docker_web_dev

# Data Bag
ARG data_bag_secret

# Environment Args
ARG data_bag_item=web_dev
ARG aws_inside=false
ARG stack_name=mediawiki-nginx-kitchen
ARG vpc_id=vpc-00000000
ARG logs_group_name=mediawiki-nginx-kitchen
ARG efs_filesystem_id=fs-00000000
ARG version_major=1
ARG version_minor=28
ARG site_folder_name=mediawiki
ARG uploads_folder_name=uploads
ARG root_site_path=/var/www/html
ARG x_forwarded_traffic=false
ARG rewrite_wiki_alias=false
ARG dns_configure=false
ARG hosted_zone_id=00000000000000
ARG record_name=www.example.com
ARG efs_configure=false

# Run Chef when Container Created
CMD ["/opt/chef/bin/chef-client", "-z", "--config /opt/chef-repo/client.rb", "-o recipe[bonusbits_mediawiki_nginx]", "--environment ${chef_environment}", "--log_level info", "--force-formatter", "--chef-zero-port 8889"]

# Install Basics
RUN yum clean all
RUN yum update -y
RUN yum install -y sudo upstart procps util-linux openssh-server openssh-clients which curl vim-enhanced openssl ca-certificates mlocate passwd net-tools htop git gzip aws-cfn-bootstrap aws-cli cloud-init

## Create Sudo User
RUN if ! getent passwd ${sudo_user}; then useradd -d /home/${sudo_user} -m -s /bin/bash -p '*' ${sudo_user}; fi
RUN printf "${sudo_user} ALL=(ALL) NOPASSWD: ALL" >> /etc/sudoers
RUN printf "Defaults !requiretty" >> /etc/sudoers
RUN mkdir -p /home/${sudo_user}/.ssh
RUN chown -R ${sudo_user} /home/${sudo_user}/.ssh
RUN chmod 0700 /home/${sudo_user}/.ssh
RUN touch /home/${sudo_user}/.ssh/authorized_keys
RUN chown ${sudo_user} /home/${sudo_user}/.ssh/authorized_keys
RUN printf ${ssh_key} > /home/${sudo_user}/.ssh/authorized_keys
RUN chmod 0600 /home/${sudo_user}/.ssh/authorized_keys

# Bash Profile Basics

# Install Chef Client
RUN curl -L https://omnitruck.chef.io/install.sh | bash -s -- -v ${chef_client_version}

# Setup Chef Client
RUN mkdir -p /opt/chef-repo
WORKDIR /opt/chef-repo
RUN mkdir -p cookbooks checksums environments cache backup data_bags roles
RUN mkdir cookbooks/${cookbook_name}
COPY . cookbooks/${cookbook_name}/
RUN cp -R cookbooks/${cookbook_name}/test/data_bags/${cookbook_name} data_bags/
RUN cp cookbooks/${cookbook_name}/test/roles/${chef_role}.json roles/${chef_role}.json
COPY test/data_bags/${cookbook_name}/${data_bag_item}.json /opt/chef-repo/data_bags/${cookbook_name}/
RUN echo ${data_bag_secret} > /opt/chef-repo/encrypted_data_bag_secret
COPY test/node/client.rb /opt/chef-repo/client.rb
RUN printf $"{\n\
    \"name\": \"${chef_environment}\",\n\
    \"description\": \"Environment\",\n\
    \"cookbook_versions\": {},\n\
    \"json_class\": \"Chef::Environment\",\n\
    \"chef_type\": \"environment\",\n\
    \"default_attributes\": {\n\
    },\n\
    \"override_attributes\": {\n\
        \"${cookbook_name}\": {\n\
            \"role\": \"web\",\n\
            \"deployment_type\": \"docker\",\n\
            \"data_bag_item\": \"${data_bag_item}\",\n\
            \"aws\": {\n\
                \"inside\": ${aws_inside},\n\
                \"stack_name\": \"${stack_name}\",\n\
                \"vpc_id\": \"${vpc_id}\",\n\
                \"logs_group_name\": \"${logs_group_name}\",\n\
                \"efs_filesystem_id\": \"${efs_filesystem_id}\"\n\
            },\n\
            \"mediawiki\": {\n\
                \"version_major\": \"${version_major}\",\n\
                \"version_minor\": \"${version_minor}\",\n\
                \"site_folder_name\": \"${site_folder_name}\",\n\
                \"uploads_folder_name\": \"${uploads_folder_name}\"\n\
            },\n\
            \"nginx\": {\n\
                \"root_site_path\": \"${root_site_path}\",\n\
                \"x_forwarded_traffic\": ${x_forwarded_traffic},\n\
                \"rewrite_wiki_alias\": ${rewrite_wiki_alias}\n\
            },\n\
            \"dns\": {\n\
                \"configure\": ${dns_configure},\n\
                \"hosted_zone_id\": \"${hosted_zone_id}\",\n\
                \"record_name\": \"${record_name}\"\n\
            },\n\
            \"efs\": {\n\
                \"configure\": ${efs_configure}\n\
            }\n\
        }\n\
    }\n\
}\n"\
>> /opt/chef-repo/environments/${chef_environment}.json

RUN printf $"{\n\
    \"name\": \"image_build\",\n\
    \"description\": \"Environment\",\n\
    \"cookbook_versions\": {},\n\
    \"json_class\": \"Chef::Environment\",\n\
    \"chef_type\": \"environment\",\n\
    \"default_attributes\": {\n\
    },\n\
    \"override_attributes\": {\n\
        \"${cookbook_name}\": {\n\
            \"role\": \"web\",\n\
            \"deployment_type\": \"docker\",\n\
            \"data_bag_item\": \"${data_bag_item}\",\n\
            \"aws\": {\n\
                \"inside\": false,\n\
                \"stack_name\": \"${stack_name}\",\n\
                \"vpc_id\": \"${vpc_id}\",\n\
                \"logs_group_name\": \"${logs_group_name}\",\n\
                \"efs_filesystem_id\": \"${efs_filesystem_id}\"\n\
            },\n\
            \"mediawiki\": {\n\
                \"version_major\": \"${version_major}\",\n\
                \"version_minor\": \"${version_minor}\",\n\
                \"site_folder_name\": \"${site_folder_name}\",\n\
                \"uploads_folder_name\": \"${uploads_folder_name}\"\n\
            },\n\
            \"nginx\": {\n\
                \"root_site_path\": \"${root_site_path}\",\n\
                \"x_forwarded_traffic\": ${x_forwarded_traffic},\n\
                \"rewrite_wiki_alias\": ${rewrite_wiki_alias}\n\
            },\n\
            \"dns\": {\n\
                \"configure\": ${dns_configure},\n\
                \"hosted_zone_id\": \"${hosted_zone_id}\",\n\
                \"record_name\": \"${record_name}\"\n\
            },\n\
            \"efs\": {\n\
                \"configure\": ${efs_configure}\n\
            }\n\
        }\n\
    }\n\
}\n"\
>> /opt/chef-repo/environments/image_build.json

# Run Chef
RUN /opt/chef/bin/chef-client -z --config /opt/chef-repo/client.rb -o recipe[bonusbits_mediawiki_nginx] --environment image_build --log_level info --force-formatter --chef-zero-port 8889

EXPOSE 80 443