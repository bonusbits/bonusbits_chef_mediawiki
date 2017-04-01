# Install CloudWatch Logs Agent
package 'awslogs'

# Deploy AWS CLI Config
template '/etc/awslogs/awscli.conf' do
  source 'cloudwatch_logs/awscli.conf.erb'
  owner 'root'
  group 'root'
  mode '0644'
end

# Deploy AWS CloudWatch Logs Config
template_folder = node['bonusbits_mediawiki_nginx']['role']
template '/etc/awslogs/awslogs.conf' do
  source "#{template_folder}/awslogs.conf.erb"
  owner 'root'
  group 'root'
  mode '0644'
  notifies :restart, 'service[awslogs]', :delayed
  only_if { node['bonusbits_mediawiki_nginx']['aws']['inside'] } # Ohai EC2 Plugin Used
end

# Define Service for Notifications
service 'awslogs' do
  service_name 'awslogs'
  action [:enable, :start]
  only_if { node['bonusbits_mediawiki_nginx']['aws']['inside'] }
end
