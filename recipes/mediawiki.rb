# Download Mediawiki

# Deploy LocalSettings.php
template '/var/www/html/mediawiki/LocalSettings.php' do
  source 'LocalSettings.php.erb'
  owner node['bonusbits_mediawiki_nginx']['user']
  group node['bonusbits_mediawiki_nginx']['group']
  mode '0644'
  notifies :restart, 'service[nginx]', :delayed
  only_if { node['bonusbits_mediawiki_nginx']['mediawiki']['localsettings']['configure'] }
end
