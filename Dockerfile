FROM amazonlinux:latest
MAINTAINER Levon Becker "levon.docker@bonusbits.com"

# Arguments
ARG chef_client_version=12.18.31
ARG cookbook_version=latest
ARG cookbook_name=bonusbits_mediawiki_nginx
ARG chef_role=bonusbits_mediawiki_nginx
ARG chef_environment=docker_environment

# Install Basics
RUN yum clean all
RUN yum update -y
RUN yum install -y sudo openssh-server openssh-clients which curl vim-enhanced openssl ca-certificates mlocate net-tools htop git gzip aws-cfn-bootstrap aws-cli cloud-init

## Create SSH Key Pair
#RUN ssh-keygen -t rsa -f /etc/ssh/ssh_host_rsa_key -N ''
#RUN ssh-keygen -t dsa -f /etc/ssh/ssh_host_dsa_key -N ''

## Create Docker-user
#RUN if ! getent passwd docker-user; then useradd -d /home/docker-user -m -s /bin/bash -p '*' docker-user; fi
#RUN echo "docker-user ALL=(ALL) NOPASSWD: ALL" >> /etc/sudoers
#RUN echo "Defaults !requiretty" >> /etc/sudoers
#RUN mkdir -p /home/docker-user/.ssh
#RUN chown -R kitchen /home/docker-user/.ssh
#RUN chmod 0700 /home/docker-user/.ssh
#RUN touch /home/docker-user/.ssh/authorized_keys
#RUN chown kitchen /home/docker-user/.ssh/authorized_keys
#RUN chmod 0600 /home/docker-user/.ssh/authorized_keys

# Bash Profile Basics

# Install Chef Client
RUN curl -L https://omnitruck.chef.io/install.sh | bash -s -- -v ${chef_client_version}

# Setup Chef Client
RUN mkdir -p /opt/chef-repo
WORKDIR /opt/chef-repo
RUN mkdir -p cookbooks checksums environments cache backup data_bags roles downloads
RUN git clone --branch ${cookbook_version} https://github.com/bonusbits/${cookbook_name}.git cookbooks/${cookbook_name}
RUN cp -R cookbooks/${cookbook_name}/test/data_bags/${cookbook_name} data_bags/
#RUN cp cookbooks/${cookbook_name}/test/roles/${chef_role}.json roles/${chef_role}.json
#COPY ./test/environments/${chef_environment} /opt/chef-repo/environments/${chef_environment}.json
# TODO: Create Environment File

# Run Chef
#RUN /opt/chef/bin/chef-client -z -o role[${chef_role}] --environment ${chef_environment} --config /opt/chef-repo/client.rb --log_level info --force-formatter --chef-zero-port 8889

# Update DNS
#RUN /usr/sbin/update-dns

EXPOSE 80 443