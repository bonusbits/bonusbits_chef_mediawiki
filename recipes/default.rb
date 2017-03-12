# Fetch Data Bag
data_bag = node['bonusbits_mediawiki_nginx']['data_bag']
data_bag_item = node['bonusbits_mediawiki_nginx']['data_bag_item']
node.run_state['data_bag'] = data_bag_item(data_bag, data_bag_item)

# Add /usr/local/bin to sudoers Secure Path
ruby_block 'Add /usr/local/bin to sudoers Secure Path' do
  block do
    bash_command = 'sed -i "s/secure_path = \/sbin:\/bin:\/usr\/sbin:\/usr\/bin/secure_path = \/sbin:\/bin:\/usr\/sbin:\/usr\/bin:\/usr\/local\/bin/g" /etc/sudoers'

    # Run Bash Script and Capture StrOut, StrErr, and Status
    require 'open3'
    Chef::Log.warn("Open3: BASH Command (#{bash_command})")
    out, err, status = Open3.capture3(bash_command)
    Chef::Log.warn("Open3: Status (#{status})")
    unless status.success?
      Chef::Log.warn("Open3: Standard Out (#{out})")
      Chef::Log.warn("Open3: Error Out (#{err})")
      raise 'Failed!'
    end
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
