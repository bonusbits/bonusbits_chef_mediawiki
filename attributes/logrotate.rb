default['bonusbits_mediawiki_nginx']['logrotate']['configure'] = true

# Debug
message_list = [
  '',
  '** Log Rotate **',
  "Configure                   (#{node['bonusbits_mediawiki_nginx']['logrotate']['configure']})"
]
message_list.each do |message|
  Chef::Log.warn(message)
end
