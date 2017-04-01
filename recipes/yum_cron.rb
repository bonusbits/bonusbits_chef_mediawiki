# Install Yum Cron
package 'yum-cron'

template_folder = node['bonusbits_mediawiki_nginx']['role']

# Deploy Yum Cron Config
template '/etc/yum/yum-cron.conf' do
  source "#{template_folder}/yum-cron.conf.erb"
  owner 'root'
  group 'root'
  mode '0644'
  notifies :restart, 'service[yum-cron]', :delayed
end

# Deploy Yum Cron Config
template '/etc/yum/yum-cron-hourly.conf' do
  source "#{template_folder}/yum-cron-hourly.conf.erb"
  owner 'root'
  group 'root'
  mode '0644'
  notifies :restart, 'service[yum-cron]', :delayed
end

# Enable and Start Service
service 'yum-cron' do
  action [:enable, :start]
end
