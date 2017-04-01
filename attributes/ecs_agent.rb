if node['bonusbits_mediawiki_nginx']['role'] == 'ecs_agent'
  default['bonusbits_mediawiki_nginx']['aws']['ecs_cluster_name'] = 'mediawiki-nginx-kitchen'

  # Debug
  message_list = [
    '',
    '** ECS Agent **',
    "INFO: ECS Cluster Name        (#{node['bonusbits_mediawiki_nginx']['aws']['ecs_cluster_name']})"
  ]
  message_list.each do |message|
    Chef::Log.warn(message)
  end
end
