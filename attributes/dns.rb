default['bonusbits_mediawiki']['dns']['configure'] = true
default['bonusbits_mediawiki']['dns']['ttl'] = '60'

# Debug
message_list = [
  '',
  '** DNS **',
  "Configure                   (#{node['bonusbits_mediawiki']['dns']['configure']})",
  "TTL                         (#{node['bonusbits_mediawiki']['dns']['ttl']})"
]
message_list.each do |message|
  Chef::Log.warn(message)
end
