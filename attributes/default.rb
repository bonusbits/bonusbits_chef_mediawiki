# Determine Environment
run_state['detected_environment'] =
  if /dev|qa|stg|prd/ =~ node.environment
    /dev|qa|stg|prd/.match(node.environment).to_s.downcase
  else
    # Consider _default as 'Dev'
    'dev'
  end

# Server Role
default['bonusbits_mediawiki_nginx']['role'] = 'web'

# Deployment Type
default['bonusbits_mediawiki_nginx']['deployment_type'] = 'ec2'

# Data Bags
default['bonusbits_mediawiki_nginx']['data_bag'] = 'bonusbits_mediawiki_nginx'
default['bonusbits_mediawiki_nginx']['data_bag_item'] = 'example_databag_item'

# Debug
message_list = [
  '',
  '** Default **',
  "INFO: Role                  (#{node['bonusbits_mediawiki_nginx']['role']})",
  "INFO: Data Bag              (#{node['bonusbits_mediawiki_nginx']['data_bag']})",
  "INFO: Data Bag Item         (#{node['bonusbits_mediawiki_nginx']['data_bag_item']})",
  "INFO: Deployment Type       (#{node['bonusbits_mediawiki_nginx']['deployment_type']})"
]
message_list.each do |message|
  Chef::Log.warn(message)
end
