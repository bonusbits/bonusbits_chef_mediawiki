# Determine Environment
run_state['detected_environment'] =
  if /dev|qa|stg|prd/ =~ node['chef_environment']
    /dev|qa|stg|prd/.match(node['chef_environment']).to_s.downcase
  else
    # Consider _default as 'Dev'
    'dev'
  end

default['bonusbits_mediawiki_nginx'].tap do |root|
  # CloudWatch Logs
  root['cloudwatch_logs']['configure'] = true

  # Data Bag
  root['data_bag'] = 'bonusbits_mediawiki_nginx'
  root['data_bag_item'] = 'example_databag_item'

  # EFS
  root['efs']['configure'] = true

  # Log Rotate
  root['logrotate']['configure'] = true

  # Google AdSense
  root['adsense']['configure'] = false
end
