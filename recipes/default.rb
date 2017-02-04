# Determine Availability Zone
availability_zone = node['ec2']['']

# Create Chef Repo Directory (For testing without CFN)
directory node['bonusbits_mediawiki_nginx']['local_download_path'] do
  action :create
  recursive true
end

# Install Packages
include_recipe 'bonusbits_mediawiki_nginx::packages'

# Setup Sendmail
include_recipe 'bonusbits_mediawiki_nginx::sendmail'

# Define Apache Service for Notifications
service 'apache' do
  service_name 'httpd'
  action [:enable, :nothing]
end

# Deploy Web Configs
include_recipe 'bonusbits_mediawiki_nginx::apache'

# Deploy Web Content
include_recipe 'bonusbits_mediawiki_nginx::web_content'

# Setup RDS (Restore From Backup)
# include_recipe 'bonusbits_mediawiki_nginx::database' if node['bonusbits_mediawiki_nginx']['database']['configure']

# Switch to Dev RDS (For Kitchen Dev)
include_recipe 'bonusbits_mediawiki_nginx::mediawiki' if node['bonusbits_mediawiki_nginx']['mediawiki']['localsettings']['configure']

# Setup EFS (For Kitchen Dev)
include_recipe 'bonusbits_mediawiki_nginx::efs' if node['bonusbits_mediawiki_nginx']['efs']['configure']

# TODO: Start / Restart Apache

# TODO: Setup Cloudwatch scripts

# TODO: Deploy Backup Script
include_recipe 'bonusbits_mediawiki_nginx::backups' if node['bonusbits_mediawiki_nginx']['backups']['configure'] && availability_zone.match(/a$/)