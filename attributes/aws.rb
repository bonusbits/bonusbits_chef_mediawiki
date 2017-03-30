default['bonusbits_mediawiki_nginx']['aws']['inside'] = true
default['bonusbits_mediawiki_nginx']['aws']['region'] =
  if node['bonusbits_mediawiki_nginx']['aws']['inside']
    node['ec2']['placement_availability_zone'].slice(0..-2)
  else
    'us-west-2'
  end

# Debug
message_list = [
  '** AWS **',
  "INFO: Inside                (#{node['bonusbits_mediawiki_nginx']['aws']['inside']})",
  "INFO: Region                (#{node['bonusbits_mediawiki_nginx']['aws']['region']})"
]
message_list.each do |message|
  Chef::Log.warn(message)
end
