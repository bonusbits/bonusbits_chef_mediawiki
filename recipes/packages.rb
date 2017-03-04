# Install Required Packages
package node['bonusbits_mediawik_nginx']['packages']

# Install Optional Packages
package node['bonusbits_mediawik_nginx']['optional_packages']

# Install Yum Cron
package 'yum-cron'

# Deploy Yum Cron Config
template '/etc/yum/yum-cron.conf' do
  source 'base/yum-cron.conf.erb'
  owner 'root'
  group 'root'
  mode '0644'
  notifies :restart, 'service[yum-cron]', :delayed
end

# Deploy Yum Cron Config
template '/etc/yum/yum-cron-hourly.conf' do
  source 'base/yum-cron.conf.erb'
  owner 'root'
  group 'root'
  mode '0644'
  notifies :restart, 'service[yum-cron]', :delayed
end

# Enable and Start Service
service 'yum-cron' do
  action [:enable, :start]
end
