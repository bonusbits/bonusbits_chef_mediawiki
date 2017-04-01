default['bonusbits_mediawiki_nginx']['yum_cron']['configure'] = true

# Debug
message_list = [
  '',
  '** Yum Cron **',
  "INFO: Configure             (#{node['bonusbits_mediawiki_nginx']['yum_cron']['configure']})"
]
message_list.each do |message|
  Chef::Log.warn(message)
end
