# Deploy DNS Update Script (For awslogs init script)
template '/etc/sysconfig/network' do
  source 'docker/sysconfig.network.erb'
  owner 'root'
  group 'root'
  mode '0644'
  only_if { node['bonusbits_mediawiki_nginx']['deployment_type'] == 'docker' }
  only_if { node['bonusbits_mediawiki_nginx']['docker']['deploy_sysconfig_network'] }
  not_if { ::File.exist?('/etc/sysconfig/network') }
end
