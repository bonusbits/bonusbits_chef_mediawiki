mediawiki_path = node['bonusbits_mediawiki_nginx']['mediawiki']['mediawiki_path']
uploads_path = node['bonusbits_mediawiki_nginx']['mediawiki']['uploads_path']
mediawiki_user = node['bonusbits_mediawiki_nginx']['nginx']['user']
mediawiki_group = node['bonusbits_mediawiki_nginx']['nginx']['group']

# Create Logs Directory
directory '/var/log/mediawiki' do
  owner mediawiki_user
  group mediawiki_group
  mode '0755'
end

# Download Mediawiki
version_major = node['bonusbits_mediawiki_nginx']['mediawiki']['version_major']
version_minor = node['bonusbits_mediawiki_nginx']['mediawiki']['version_minor']
git mediawiki_path do
  repository 'https://gerrit.wikimedia.org/r/p/mediawiki/core.git'
  revision "REL#{version_major}_#{version_minor}"
  action :checkout
  not_if { ::File.exist?(mediawiki_path) }
end

# Download Vector Skin
git "#{mediawiki_path}/skins/Vector" do
  repository 'https://gerrit.wikimedia.org/r/p/mediawiki/skins/Vector.git'
  revision "REL#{version_major}_#{version_minor}"
  action :checkout
  not_if { ::File.exist?("#{mediawiki_path}/skins/Vector") }
end

# Download Vendor Packages
git "#{mediawiki_path}/vendor" do
  repository 'https://gerrit.wikimedia.org/r/p/mediawiki/vendor.git'
  revision "REL#{version_major}_#{version_minor}"
  action :checkout
  not_if { ::File.exist?("#{mediawiki_path}/vendor") }
end

# Symlink Favicon
link "#{mediawiki_path}/favicon.ico" do
  to "#{uploads_path}/favicon.ico"
  owner mediawiki_user
  group mediawiki_group
end

# Deploy Robots.txt
template "#{mediawiki_path}/robots.txt" do
  source 'mediawiki/robots.txt.erb'
  owner mediawiki_user
  group mediawiki_group
  mode '0644'
  notifies :restart, 'service[nginx]', :delayed
end

# Download Bonusbits Extensions
bonusbits_extensions_list = %w(HideNamespace AutoSitemap)
bonusbits_extensions_list.each do |extension|
  git "#{mediawiki_path}/extensions/#{extension}" do
    repository "https://github.com/bonusbits/#{extension}.git"
    revision "REL#{version_major}_#{version_minor}"
    action :checkout
    not_if { ::File.exist?("#{mediawiki_path}/extensions/#{extension}") }
  end
end

# Download Extensions
if node['bonusbits_mediawiki_nginx']['mediawiki']['extensions']['configure']
  extensions_list = node['bonusbits_mediawiki_nginx']['mediawiki']['extensions']['list']
  extensions_list.each do |extension|
    git "#{mediawiki_path}/extensions/#{extension}" do
      repository "https://gerrit.wikimedia.org/r/p/mediawiki/extensions/#{extension}.git"
      revision "REL#{version_major}_#{version_minor}"
      action :checkout
      not_if { ::File.exist?("#{mediawiki_path}/extensions/#{extension}") }
    end
  end
end

# Download Widgets Extension Submodules TODO: Better Logic?
ruby_block 'Download Widgets Extension Submodules' do
  block do
    require 'open3'
    bash_command = "cd #{mediawiki_path}/extensions/Widgets/ && git submodule init && git submodule update"
    Chef::Log.warn("REPORT: Open3 BASH Command (#{bash_command})")

    # Run Bash Script and Capture StrOut, StrErr, and Status
    out, err, status = Open3.capture3(bash_command)
    Chef::Log.warn("REPORT: Open3 Status (#{status})")
    Chef::Log.warn("REPORT: Open3 Standard Out (#{out})")
    Chef::Log.warn("REPORT: Open3 Error Out (#{err})")
    raise 'Failed!' unless status.success?
  end
  action :run
  not_if { ::File.exist?("#{mediawiki_path}/extensions/Widgets/smarty/libs") }
end

# Deploy Corrected NewsRenderer (Replace Underscores with Whitespace)
vector_template = "#{mediawiki_path}/extensions/News/NewsRenderer.php"
template vector_template do
  source "mediawiki/NewsRenderer-#{version_major}.#{version_minor}.php.erb"
  owner mediawiki_user
  group mediawiki_group
  mode '0644'
  notifies :restart, 'service[nginx]', :delayed
end

# Deploy LocalSettings.php
## In case We want to completely override the Logo Paths in the Environment File and Skip the Data Bag Value
desktop_logo = "{$wgScriptPath}/#{node['bonusbits_mediawiki_nginx']['mediawiki']['uploads_folder_name']}/#{node.run_state['data_bag']['mediawiki']['desktop_logo_filename']}"
node.default['bonusbits_mediawiki_nginx']['mediawiki']['localsettings']['wgLogo'] = desktop_logo
mobile_logo = "{$wgScriptPath}/#{node['bonusbits_mediawiki_nginx']['mediawiki']['uploads_folder_name']}/#{node.run_state['data_bag']['mediawiki']['mobile_logo_filename']}"
node.default['bonusbits_mediawiki_nginx']['mediawiki']['localsettings']['wgMobileFrontendLogo'] = mobile_logo

template "#{mediawiki_path}/LocalSettings.php" do
  source 'mediawiki/LocalSettings.php.erb'
  owner mediawiki_user
  group mediawiki_group
  mode '0644'
  notifies :restart, 'service[nginx]', :delayed
  only_if { node['bonusbits_mediawiki_nginx']['mediawiki']['localsettings']['configure'] }
end

# Set Ownership on Mediawiki Home
ruby_block 'Set Ownership on Mediawiki Home' do
  block do
    require 'open3'
    bash_command = "chown -R nginx:nginx #{mediawiki_path}"
    Chef::Log.warn("REPORT: Open3 BASH Command (#{bash_command})")

    # Run Bash Script and Capture StrOut, StrErr, and Status
    out, err, status = Open3.capture3(bash_command)
    Chef::Log.warn("REPORT: Open3 Status (#{status})")
    Chef::Log.warn("REPORT: Open3 Standard Out (#{out})")
    Chef::Log.warn("REPORT: Open3 Error Out (#{err})")
    raise 'Failed!' unless status.success?
  end
  action :run
  not_if { ::File.exist?(uploads_path) } # So doesn't reset uploads ownership every time
end

# Mount and Configure EFS Uploads Share
include_recipe 'bonusbits_mediawiki_nginx::efs' if node['bonusbits_mediawiki_nginx']['efs']['configure']

# Add AdSense PHP Snippets
include_recipe 'bonusbits_mediawiki_nginx::adsense' if node['bonusbits_mediawiki_nginx']['adsense']['configure']

# Setup Log Rotate for Mediawiki Logs
include_recipe 'bonusbits_mediawiki_nginx::logrotate' if node['bonusbits_mediawiki_nginx']['logrotate']['configure']
