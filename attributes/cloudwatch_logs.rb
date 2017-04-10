# Bonusbits Base
default['bonusbits_base']['cloudwatch_logs']['configure'] = true
default['bonusbits_base']['cloudwatch_logs']['deploy_logs_conf'] = false
default['bonusbits_base']['cloudwatch_logs']['logs_group_name'] = 'kitchen-bonusbits-mediawiki-nginx'

# # Debug
# message_list = [
#   '',
#   '** CloudWatch Logs **',
#   "INFO: Configure             (#{node['bonusbits_mediawiki_nginx']['cloudwatch_logs']['configure']})"
# ]
# message_list.each do |message|
#   Chef::Log.warn(message)
# end
