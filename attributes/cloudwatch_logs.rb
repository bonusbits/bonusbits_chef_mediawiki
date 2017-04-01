default['bonusbits_mediawiki_nginx']['cloudwatch_logs']['configure'] = true

# Debug
message_list = [
  '',
  '** CloudWatch Logs **',
  "INFO: Configure             (#{node['bonusbits_mediawiki_nginx']['cloudwatch_logs']['configure']})"
]
message_list.each do |message|
  Chef::Log.warn(message)
end
