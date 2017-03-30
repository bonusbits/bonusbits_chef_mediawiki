default['bonusbits_mediawiki_nginx']['docker']['deploy_sysconfig_network'] = true

# Debug
message_list = [
  '** Docker **',
  "INFO: Deploy Sysconfig Network (#{node['bonusbits_mediawiki_nginx']['docker']['deploy_sysconfig_network']})"
]
message_list.each do |message|
  Chef::Log.warn(message)
end