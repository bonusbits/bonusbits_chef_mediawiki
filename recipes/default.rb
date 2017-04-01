# Setup CloudWatch Logs
include_recipe 'bonusbits_mediawiki_nginx::cloudwatch_logs' if node['bonusbits_mediawiki_nginx']['cloudwatch_logs']['configure']

# Install Base Packages
package node['bonusbits_mediawik_nginx']['packages']['base_packages']

if node['bonusbits_mediawiki_nginx']['role'] == 'web'
  # Fetch Data Bag
  data_bag = node['bonusbits_mediawiki_nginx']['data_bag']
  data_bag_item = node['bonusbits_mediawiki_nginx']['data_bag_item']
  node.run_state['data_bag'] = data_bag_item(data_bag, data_bag_item)

  if node['bonusbits_mediawiki_nginx']['deployment_type'] == 'ec2'
    # Configure Sudoers
    include_recipe 'bonusbits_mediawiki_nginx::sudoers' if node['bonusbits_mediawiki_nginx']['sudoers']['configure']
  elsif node['bonusbits_mediawiki_nginx']['deployment_type'] == 'docker'
    # Docker Specific
    include_recipe 'bonusbits_mediawiki_nginx::docker'
  else
    raise 'ERROR: Deployment Type Missing!'
  end

  # Install Software Packages
  package node['bonusbits_mediawik_nginx']['packages']['web']

  # Install and Configure Nginx
  include_recipe 'bonusbits_mediawiki_nginx::nginx'

  # Install and Configure Php Fpm
  include_recipe 'bonusbits_mediawiki_nginx::php_fpm'

  # Install and Configure Nginx
  include_recipe 'bonusbits_mediawiki_nginx::mediawiki'

  # Setup Sendmail
  include_recipe 'bonusbits_mediawiki_nginx::sendmail' if node['bonusbits_mediawiki_nginx']['sendmail']['configure']

  # Deploy DNS Update Script
  include_recipe 'bonusbits_mediawiki_nginx::dns' if node['bonusbits_mediawiki_nginx']['dns']['configure']
elsif node['bonusbits_mediawiki_nginx']['role'] == 'ecs_agent'
  include_recipe 'bonusbits_mediawiki_nginx::ecs_agent'
else
  raise 'ERROR: No Server Role Defined!'
end

# Install & Config Yum Cron
include_recipe 'bonusbits_mediawiki_nginx::yum_cron' if node['bonusbits_mediawiki_nginx']['yum_cron']['configure']

# Deploy Node Info Script
include_recipe 'bonusbits_mediawiki_nginx::node_info' if node['bonusbits_mediawiki_nginx']['node_info']['configure']
