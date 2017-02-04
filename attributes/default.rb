# Determine Environment
run_state['detected_environment'] =
  if /dev|qa|stg|prd/ =~ node['chef_environment']
    /dev|qa|stg|prd/.match(node['chef_environment']).to_s.downcase
  else
    # Consider _default as 'Dev'
    'dev'
  end

default['bonusbits_mediawiki_nginx'].tap do |root|
  # S3
  root['s3']['deploy_bucket_name'] = 'bonusbits-deploy'

  # Paths
  root['local_download_path'] = '/opt/chef-repo/downloads'

  # Data Bag
  root['connections']['data_bag'] = 'bonusbits_mediawiki_nginx'
  root['connections']['data_bag_item'] = 'connections'
end
