default['bonusbits_mediawiki_nginx']['docker']['deploy_sysconfig_network'] = true

# Debug

if node['bonusbits_mediawiki_nginx']['role'] == 'web' && node['bonusbits_mediawiki_nginx']['deployment_type'] == 'docker'
  message_list = [
    '',
    '** Docker **',
    "INFO: Deploy Sysconfig Network (#{node['bonusbits_mediawiki_nginx']['docker']['deploy_sysconfig_network']})"
  ]
  message_list.each do |message|
    Chef::Log.warn(message)
  end
end
