default['bonusbits_mediawiki']['logrotate']['configure'] = true

# Debug
message_list = [
  '',
  '** Log Rotate **',
  "Configure                   (#{node['bonusbits_mediawiki']['logrotate']['configure']})"
]
message_list.each do |message|
  Chef::Log.warn(message)
end
