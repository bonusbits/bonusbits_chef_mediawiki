default['bonusbits_mediawiki_nginx']['aws'].tap do |aws|
  aws['az'] = node['ec2']['placement_availability_zone']
  aws['region'] = node['ec2']['placement_availability_zone'].slice(0..-2)
  aws['efs_id'] = nil
  aws['efs_local_mount'] = '/var/www/html/mediawiki/uploads'
  aws['create_logs_group'] = true
  aws['logs_group_name'] = nil
  aws['Logs_retention_days'] = '14'
  aws['s3_backup_bucket'] = nil
end
