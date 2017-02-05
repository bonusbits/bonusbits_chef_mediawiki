# Determine Availability Zone & Region
availability_zone = node['ec2']['placement_availability_zone']

# Deploy Backup Script
template '/etc/cron.daily/backup-mediawiki' do
  source 'backup-mediawiki.sh.erb'
  owner 'root'
  group 'root'
  mode '0755'
  only_if { availability_zone.match(/a$/) }
end
