# Setup CloudWatch Logs
include_recipe 'bonusbits_mediawiki_nginx::cloudwatch_logs' if node['bonusbits_mediawiki_nginx']['cloudwatch_logs']['configure']

# Fetch Data Bag
data_bag = node['bonusbits_mediawiki_nginx']['data_bag']
data_bag_item = node['bonusbits_mediawiki_nginx']['data_bag_item']
node.run_state['data_bag'] = data_bag_item(data_bag, data_bag_item)

# Configure Sudoers
include_recipe 'bonusbits_mediawiki_nginx::sudoers' if node['bonusbits_mediawiki_nginx']['sudoers']['configure']

# Docker Specific
include_recipe 'bonusbits_mediawiki_nginx::docker' if node['bonusbits_mediawiki_nginx']['deployment_type'] == 'docker'

# Install Software Packages
include_recipe 'bonusbits_mediawiki_nginx::packages'

# Install and Configure Nginx
include_recipe 'bonusbits_mediawiki_nginx::nginx'

# Install and Configure Php Fpm
include_recipe 'bonusbits_mediawiki_nginx::php_fpm'

# Install and Configure Nginx
include_recipe 'bonusbits_mediawiki_nginx::mediawiki'

# Setup Sendmail
include_recipe 'bonusbits_mediawiki_nginx::sendmail' if node['bonusbits_mediawiki_nginx']['sendmail']['configure']

# Deploy Node Info Script
include_recipe 'bonusbits_mediawiki_nginx::node_info' if node['bonusbits_mediawiki_nginx']['node_info']['configure']

# Deploy DNS Update Script
include_recipe 'bonusbits_mediawiki_nginx::dns' if node['bonusbits_mediawiki_nginx']['dns']['configure']
