# Determine Environment
run_state['detected_environment'] =
  if /dev|qa|stg|prd/ =~ node['chef_environment']
    /dev|qa|stg|prd/.match(node['chef_environment']).to_s.downcase
  else
    # Consider _default as 'Dev'
    'dev'
  end

# Data Bags
default['bonusbits_mediawiki_nginx']['data_bag'] = 'bonusbits_mediawiki_nginx'
default['bonusbits_mediawiki_nginx']['data_bag_item'] = 'example_databag_item'
