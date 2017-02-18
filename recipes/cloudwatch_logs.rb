# Install CloudWatch Logs Agent
package 'awslogs'

# Deploy AWS CLI Config
template '/etc/awslogs/awscli.conf' do
  source 'awscli.conf.erb'
  owner 'root'
  group 'root'
  mode '0644'
end

# Deploy AWS CloudWatch Logs Config
template '/etc/awslogs/awslogs.conf' do
  source 'awslogs.conf.erb'
  owner 'root'
  group 'root'
  mode '0644'
  notifies :restart, 'service[awslogs]', :delayed
end

# Define Service for Notifications
service 'awslogs' do
  service_name 'awslogs'
  action [:enable, :start]
end

# TODO: Create the Logs Group with Expiration Settings
