# Fetch Data Bag
data_bag = node['bonusbits_mediawiki_nginx']['data_bag']
data_bag_item = node['bonusbits_mediawiki_nginx']['data_bag_item']
node.run_state['data_bag'] = data_bag_item(data_bag, data_bag_item)

# # Apply Secret Settings From Data Bag to Node Hash
# node.run_state['data_bag'].each do |key|
#   key.each do |subkey, subvalue|
#     if key == 'localsettings'
#       node.override['bonusbits_mediawiki_nginx']['mediawiki'][key][subkey] = subvalue
#     else
#       node.override['bonusbits_mediawiki_nginx'][key][subkey] = subvalue
#     end
#   end
# end

# node.run_state['data_bag']['mediawiki'].each do |key, value|
#   node.override['bonusbits_mediawiki_nginx']['mediawiki'][key] = value
# end
# node.run_state['data_bag']['localsettings'].each do |key, value|
#   node.override['bonusbits_mediawiki_nginx']['mediawiki']['localsettings'][key] = value
# end
# node.run_state['data_bag']['nginx'].each do |key, value|
#   node.override['bonusbits_mediawiki_nginx']['nginx'][key] = value
# end
# node.run_state['data_bag']['dns'].each do |key, value|
#   node.override['bonusbits_mediawiki_nginx']['dns'][key] = value
# end
# node.run_state['data_bag']['backups'].each do |key, value|
#   node.override['bonusbits_mediawiki_nginx']['backups'][key] = value
# end

# Create Chef Repo Directory (For testing without CFN)
directory node['bonusbits_mediawiki_nginx']['local_download_path'] do
  action :create
  recursive true
end

# Add /usr/local/bin to sudoers Secure Path
ruby_block 'Add /usr/local/bin to sudoers Secure Path' do
  block do
    require 'open3'
    bash_command = 'sed -i "s/secure_path = \/sbin:\/bin:\/usr\/sbin:\/usr\/bin/secure_path = \/sbin:\/bin:\/usr\/sbin:\/usr\/bin:\/usr\/local\/bin/g" /etc/sudoers'
    Chef::Log.warn("REPORT: Open3 BASH Command (#{bash_command})")

    # Run Bash Script and Capture StrOut, StrErr, and Status
    out, err, status = Open3.capture3(bash_command)
    Chef::Log.warn("REPORT: Open3 Status (#{status})")
    Chef::Log.warn("REPORT: Open3 Standard Out (#{out})")
    Chef::Log.warn("REPORT: Open3 Error Out (#{err})")
    raise 'Failed!' unless status.success?
  end
  action :run
  not_if { ::File.readlines('/etc/sudoers').grep(%r{^Defaults    secure_path = /sbin:/bin:/usr/sbin:/usr/bin:/usr/local/bin/}).any? }
end

# Install Software Packages
include_recipe 'bonusbits_mediawiki_nginx::packages'

# Install and Configure Nginx
include_recipe 'bonusbits_mediawiki_nginx::nginx'

# Install and Configure Php Fpm
include_recipe 'bonusbits_mediawiki_nginx::php_fpm'

# Install and Configure Nginx
include_recipe 'bonusbits_mediawiki_nginx::mediawiki'

# Setup CloudWatch Logs
include_recipe 'bonusbits_mediawiki_nginx::cloudwatch_logs' if node['bonusbits_mediawiki_nginx']['cloudwatch_logs']['configure']

# Deploy Backup Script
include_recipe 'bonusbits_mediawiki_nginx::backups' if node['bonusbits_mediawiki_nginx']['backups']['configure']

# Setup Sendmail
# include_recipe 'bonusbits_mediawiki_nginx::sendmail' if node['bonusbits_mediawiki_nginx']['sendmail']['configure']

# Deploy Node Info Script
include_recipe 'bonusbits_mediawiki_nginx::node_info' if node['bonusbits_mediawiki_nginx']['node_info']['deploy']

# Deploy DNS Update Script
include_recipe 'bonusbits_mediawiki_nginx::dns' if node['bonusbits_mediawiki_nginx']['dns']['configure']
