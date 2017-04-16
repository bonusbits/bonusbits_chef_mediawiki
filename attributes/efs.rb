default['bonusbits_mediawiki_nginx']['efs']['configure'] = true
default['bonusbits_mediawiki_nginx']['efs']['filesystem_id'] = 'fs-00000000'

# Debug
message_list = [
  '',
  '** EFS **',
  "Configure                   (#{node['bonusbits_mediawiki_nginx']['efs']['configure']})",
  "File System ID              (#{node['bonusbits_mediawiki_nginx']['efs']['filesystem_id']})"
]
message_list.each do |message|
  Chef::Log.warn(message)
end
