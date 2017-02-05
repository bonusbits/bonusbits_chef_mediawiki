# Create Chef Repo Directory (For testing without CFN)
directory node['bonusbits_mediawiki_nginx']['local_download_path'] do
  action :create
  recursive true
end

# Install and Configure Nginx
include_recipe 'bonusbits_mediawiki_nginx::nginx'

# Install and Configure Php Fpm
include_recipe 'bonusbits_mediawiki_nginx::php_fpm'

# Install and Configure Nginx
# include_recipe 'bonusbits_mediawiki_nginx::mediawiki'

# Enable and Start Service
# service 'nginx' do
#   action [:enable, :start]
# end

# Deploy DNS Update Script
# include_recipe 'bonusbits_mediawiki_nginx::dns'

# Setup CloudWatch Logs
include_recipe 'bonusbits_mediawiki_nginx::cloudwatch_logs'

# Setup CloudWatch Logs
# include_recipe 'bonusbits_mediawiki_nginx::logrotate'

# Deploy Backup Script
availability_zone = node['ec2']['placement_availability_zone']
include_recipe 'bonusbits_mediawiki_nginx::backups' if node['bonusbits_mediawiki_nginx']['backups']['configure'] && availability_zone.match(/a$/)

# Setup Sendmail
# include_recipe 'bonusbits_mediawiki_nginx::sendmail'

# Deploy Node Info Script
include_recipe 'bonusbits_mediawiki_nginx::node_info' if node['bonusbits_mediawiki_nginx']['nodeinfo_script']['deploy']
