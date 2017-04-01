default['bonusbits_mediawiki_nginx']['sudoers']['configure'] = true

# Debug
if node['bonusbits_mediawiki_nginx']['deployment_type'] == 'ec2'
  message_list = [
    '',
    '** Sudoers **',
    "INFO: Configure             (#{node['bonusbits_mediawiki_nginx']['sudoers']['configure']})"
  ]
  message_list.each do |message|
    Chef::Log.warn(message)
  end
end
