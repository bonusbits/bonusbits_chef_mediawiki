# Base Setup
include_recipe 'bonusbits_base'

# Fetch Data Bag
data_bag = node['bonusbits_mediawiki']['data_bag']
data_bag_item = node['bonusbits_mediawiki']['data_bag_item']
node.run_state['data_bag'] = data_bag_item(data_bag, data_bag_item)

# Install Software Packages
package node['bonusbits_mediawiki']['packages']

# Install and Configure Nginx
include_recipe 'bonusbits_mediawiki::nginx'

# Install and Configure Php Fpm
include_recipe 'bonusbits_mediawiki::php_fpm'

# Install and Configure Nginx
include_recipe 'bonusbits_mediawiki::mediawiki'

# Setup Sendmail
include_recipe 'bonusbits_mediawiki::sendmail' if node['bonusbits_mediawiki']['sendmail']['configure']

# Deploy DNS Update Script
include_recipe 'bonusbits_mediawiki::dns' if node['bonusbits_mediawiki']['dns']['configure']
