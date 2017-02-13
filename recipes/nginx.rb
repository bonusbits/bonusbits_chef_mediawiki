# Create Web Directory
directory '/var/www/html' do
  recursive true
end

# Deploy Web Config
template '/etc/nginx/conf.d/mediawiki.conf' do
  source 'mediawiki.conf.erb'
  owner node['bonusbits_mediawiki_nginx']['user']
  group node['bonusbits_mediawiki_nginx']['group']
  mode '0644'
  notifies :restart, 'service[nginx]', :delayed
end

# TODO: Set Network Backlog
# set_backlog_commands = %w(
#   sysctl -w net.core.somaxconn=1024
#   echo 'net.core.somaxconn = 1024' >> /etc/sysctl.conf
#   sysctl -w net.ipv4.tcp_syncookies=4096
#   echo 'net.ipv4.tcp_syncookies = 4096' >> /etc/sysctl.conf
# )

# Enable and Start Service
service 'nginx' do
  action [:enable, :nothing]
end
