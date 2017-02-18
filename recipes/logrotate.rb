# Ensure Logrotate is installed
package 'logrotate'

# Deploy Mediawiki Logs Rotate Config
template '/etc/logrotate.d/mediawiki' do
  source 'mediawiki.logrotate.erb'
  owner 'root'
  group 'root'
  mode '0644'
end
