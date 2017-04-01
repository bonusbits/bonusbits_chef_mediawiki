if node['bonusbits_mediawiki_nginx']['role'] == 'web'
  default['bonusbits_mediawiki_nginx']['sendmail']['configure'] = true

  # Debug
  message_list = [
    '',
    '** Sendmail **',
    "INFO: Configure             (#{node['bonusbits_mediawiki_nginx']['sendmail']['configure']})"
  ]
  message_list.each do |message|
    Chef::Log.warn(message)
  end
end
