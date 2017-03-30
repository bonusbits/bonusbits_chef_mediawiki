# ChefClientVersion=12.18.31
# CookbookVersion=latest
# CookbookName=bonusbits_mediawiki_nginx

FROM amazonlinux:latest
MAINTAINER Levon Becker "levon.docker@bonusbits.com"

# Install Basics
RUN yum update -y
RUN yum install -y aws-cfn-bootstrap aws-cli cloud-init git

# Install Chef Client
RUN curl -L https://omnitruck.chef.io/install.sh | bash -s -- -v ${ChefClientVersion}

# Setup Chef Client
RUN mkdir -p /opt/chef-repo
RUN cd /opt/chef-repo && mkdir -p cookbooks checksums environments cache backup data_bags roles downloads
RUN cd /opt/chef-repo/cookbooks && git clone --branch ${CookbookVersion} https://github.com/bonusbits/${CookbookName}.git
RUN cd /opt/chef-repo && cp -R cookbooks/${CookbookName}/test/data_bags/${CookbookName} data_bags/
RUN cp /opt/chef-repo/cookbooks/${CookbookName}/test/role/${CookbookName}.json /opt/chef-repo/roles/${CookbookName}.json
# TODO: Create Environment File

# Run Chef
RUN /opt/chef/bin/chef-client -z -o role[${CookbookName}] --environment docker_environment --config /opt/chef-repo/client.rb --log_level info --force-formatter --chef-zero-port 8889

# Update DNS
RUN /usr/sbin/update-dns

EXPOSE [80, 443]