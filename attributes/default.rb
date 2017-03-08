# Determine Environment
run_state['detected_environment'] =
  if /dev|qa|stg|prd/ =~ node['chef_environment']
    /dev|qa|stg|prd/.match(node['chef_environment']).to_s.downcase
  else
    # Consider _default as 'Dev'
    'dev'
  end

default['bonusbits_mediawiki_nginx'].tap do |root|
  # Paths
  root['local_download_path'] = '/opt/chef-repo/downloads'

  # CloudWatch Logs
  root['cloudwatch_logs']['configure'] = true

  # Data Bag
  root['data_bag'] = 'ec2_databags'
  root['data_bag_item'] = 'ec2_databag'

  # EFS
  root['efs']['configure'] = true

  # Log Rotate
  root['logrotate']['configure'] = true

  # Google AdSense
  root['adsense']['configure'] = false
end
