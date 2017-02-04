# Determine Availability Zone & Region
availability_zone = BonusBits::AWS.fetch_metadata('availability-zone')

# Deploy Backup Script
template '/etc/cron.daily/backup-web' do
  source 'backup-web.sh.erb'
  owner 'root'
  group 'root'
  mode '0755'
  only_if { availability_zone.match(/a$/) }
end

# TODO: Log Rotate

# TODO: Stream Backup Log to Cloudwatch Logs
