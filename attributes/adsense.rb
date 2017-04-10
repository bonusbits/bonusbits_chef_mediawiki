default['bonusbits_mediawiki_nginx']['adsense']['configure'] = true

# Debug
message_list = [
  '',
  '** AdSense **',
  "Configure                   (#{node['bonusbits_mediawiki_nginx']['adsense']['configure']})"
]
message_list.each do |message|
  Chef::Log.warn(message)
end
