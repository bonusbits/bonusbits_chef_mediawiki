default['bonusbits_mediawiki']['sendmail']['configure'] = true

# Debug
message_list = [
  '',
  '** Sendmail **',
  "Configure                   (#{node['bonusbits_mediawiki']['sendmail']['configure']})"
]
message_list.each do |message|
  Chef::Log.warn(message)
end
