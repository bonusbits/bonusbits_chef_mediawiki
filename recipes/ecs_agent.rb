# Install ECS Agent
package 'ecs-init'

# Create Config Directory if Missing
directory '/etc/ecs' do
  owner 'root'
  group 'root'
  mode '0755'
end

# Deploy ECS Agent Config
template '/etc/ecs/ecs.config' do
  source 'ecs_agent/ecs.config.erb'
  owner 'root'
  group 'root'
  mode '0600'
  notifies :restart, 'service[ecs]', :delayed
end

# Start Docker Service
service 'docker' do
  action :start
end

# Start ECS Agent
service 'ecs' do
  provider Chef::Provider::Service::Upstart
  action :start
end
