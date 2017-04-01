default['bonusbits_mediawiki_nginx']['logrotate']['configure'] = true

# Debug
if node['bonusbits_mediawiki_nginx']['role'] == 'web'
  message_list = [
    '',
    '** Log Rotate **',
    "INFO: Configure             (#{node['bonusbits_mediawiki_nginx']['logrotate']['configure']})"
  ]
  message_list.each do |message|
    Chef::Log.warn(message)
  end
end
