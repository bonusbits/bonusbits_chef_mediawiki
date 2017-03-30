default['bonusbits_mediawiki_nginx']['dns']['configure'] = true
default['bonusbits_mediawiki_nginx']['dns']['ttl'] = '60'

# Debug
message_list = [
  '** DNS **',
  "INFO: Configure             (#{node['bonusbits_mediawiki_nginx']['dns']['configure']})",
  "INFO: TTL                   (#{node['bonusbits_mediawiki_nginx']['dns']['ttl']})"
]
message_list.each do |message|
  Chef::Log.warn(message)
end
