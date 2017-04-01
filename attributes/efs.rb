if node['bonusbits_mediawiki_nginx']['role'] == 'web'
  default['bonusbits_mediawiki_nginx']['efs']['configure'] = true

  # Debug
  message_list = [
    '',
    '** EFS **',
    "INFO: Configure             (#{node['bonusbits_mediawiki_nginx']['efs']['configure']})"
  ]
  message_list.each do |message|
    Chef::Log.warn(message)
  end
end
