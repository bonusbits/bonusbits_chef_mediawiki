# Install CloudWatch Logs Agent
package 'awslogs'

# Deploy AWS CLI Config
template '/etc/awslogs/awscli.conf' do
  source 'awscli.conf.erb'
  owner 'root'
  group 'root'
  mode '0755'
end

# Deploy AWS CloudWatch Logs Config
template '/etc/awslogs/awslogs.conf' do
  source 'awslogs.conf.erb'
  owner 'root'
  group 'root'
  mode '0755'
  notifies :restart, 'service[awslogs]', :delayed
end

# Deploy AWS CloudWatch Metrics Cron Script
template '/usr/sbin/publish-squid-metrics' do
  source 'publish-squid-metrics.sh.erb'
  owner 'root'
  group 'root'
  mode '0755'
  notifies :restart, 'service[awslogs]', :delayed
end

# Create Cron Job for Rotate Squid Logs Hourly
cron 'rotate_squid_logs' do
  action :create
  minute '0'
  hour '0'
  user 'root'
  command 'squid -k rotate'
end

# Create Cron Job for Squid Metrics
cron 'publish_squid_metrics' do
  action :create
  minute '*/5'
  user 'root'
  command 'bash /usr/sbin/publish-squid-metrics'
end

# Define Service for Notifications
service 'awslogs' do
  service_name 'awslogs'
  action [:enable, :start]
end
