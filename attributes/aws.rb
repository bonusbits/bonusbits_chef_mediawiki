default['bonusbits_mediawiki_nginx']['aws'].tap do |aws|
  aws['az'] = node['ec2']['placement_availability_zone']
  aws['region'] = node['ec2']['placement_availability_zone'].slice(0..-2)
  aws['efs_filesystem_id'] = nil
  aws['logs_group_name'] = nil
end
