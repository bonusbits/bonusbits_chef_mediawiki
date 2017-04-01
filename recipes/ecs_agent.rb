configure_ecs_agent = node['bonusbits_mediawiki_nginx']['ecs_agent']['configure']
ecs_cluster_name = node['bonusbits_mediawiki_nginx']['aws']['ecs_cluster_name']
Chef::Log.warn("Configure ECS Agent:          (#{configure_ecs_agent})")
Chef::Log.warn("ECS Cluster Name:             (#{ecs_cluster_name})")

# Setup ECS Agent
if configure_ecs_agent
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
end
