default['bonusbits_mediawiki']['adsense']['configure'] = true

# Debug
message_list = [
  '',
  '** AdSense **',
  "Configure                   (#{node['bonusbits_mediawiki']['adsense']['configure']})"
]
message_list.each do |message|
  Chef::Log.warn(message)
end
