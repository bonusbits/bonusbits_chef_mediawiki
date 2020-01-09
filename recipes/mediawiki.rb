mediawiki_path = node['bonusbits_mediawiki']['mediawiki']['mediawiki_path']
uploads_path = node['bonusbits_mediawiki']['mediawiki']['uploads_path']
mediawiki_user = node['bonusbits_mediawiki']['nginx']['user']
mediawiki_group = node['bonusbits_mediawiki']['nginx']['group']

# Create Logs Directory
directory '/var/log/mediawiki' do
  owner mediawiki_user
  group mediawiki_group
  mode '0755'
end

# Download Mediawiki
release = node['bonusbits_mediawiki']['mediawiki']['release']
git mediawiki_path do
  repository 'https://gerrit.wikimedia.org/r/p/mediawiki/core.git'
  revision release
  action :checkout
  ignore_failure true
  not_if { ::File.exist?(mediawiki_path) }
end

# Workaround for their ghetto git that drops the connection periodically
# (returns 128 - The remote end hung up unexpectedly)
ruby_block 'sleep when I say to' do
  block do
    Chef::Log.warn('Sleeping Because Core Git Clone Failed')
    sleep 30
  end
  action :run
  not_if { ::File.exist?(mediawiki_path) }
end

# Directory won't be there if failed above
git mediawiki_path do
  repository 'https://gerrit.wikimedia.org/r/p/mediawiki/core.git'
  revision release
  action :checkout
  not_if { ::File.exist?(mediawiki_path) }
end

# Download Vector Skin
git "#{mediawiki_path}/skins/Vector" do
  repository 'https://gerrit.wikimedia.org/r/p/mediawiki/skins/Vector.git'
  revision release
  action :checkout
  not_if { ::File.exist?("#{mediawiki_path}/skins/Vector") }
end

# Download Vendor Packages
git "#{mediawiki_path}/vendor" do
  repository 'https://gerrit.wikimedia.org/r/p/mediawiki/vendor.git'
  revision release
  action :checkout
  not_if { ::File.exist?("#{mediawiki_path}/vendor") }
end

# TODO: Symlinks are using full path. Do I want only relative?
# Symlink Favicon
link "#{mediawiki_path}/favicon.ico" do
  to "#{uploads_path}/favicon.ico"
  owner mediawiki_user
  group mediawiki_group
end

# Symlink sitemap.xml
link "#{mediawiki_path}/sitemap.xml" do
  to "#{uploads_path}/sitemap.xml"
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
bonusbits_extensions_list = %w[HideNamespace AutoSitemap]
bonusbits_extensions_list.each do |extension|
  git "#{mediawiki_path}/extensions/#{extension}" do
    repository "https://github.com/bonusbits/#{extension}.git"
    revision release
    action :checkout
    not_if { ::File.exist?("#{mediawiki_path}/extensions/#{extension}") }
  end
end

# Download Extensions
if node['bonusbits_mediawiki']['mediawiki']['extensions']['configure']
  extensions_list = node['bonusbits_mediawiki']['mediawiki']['extensions']['list']
  extensions_list.each do |extension|
    git "#{mediawiki_path}/extensions/#{extension}" do
      repository "https://gerrit.wikimedia.org/r/p/mediawiki/extensions/#{extension}.git"
      revision release
      action :checkout
      not_if { ::File.exist?("#{mediawiki_path}/extensions/#{extension}") }
    end
  end
end

# Download Widgets Extension Submodules TODO: Better Logic?
ruby_block 'Download Widgets Extension Submodules' do
  block do
    bash_command = "cd #{mediawiki_path}/extensions/Widgets/ && git submodule init && git submodule update"

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
  not_if { ::File.exist?("#{mediawiki_path}/extensions/Widgets/smarty/libs") }
end

# Deploy Corrected NewsRenderer (Replace Underscores with Whitespace)
vector_template = "#{mediawiki_path}/extensions/News/NewsRenderer.php"
version = node['bonusbits_mediawiki']['mediawiki']['version']
template vector_template do
  source "mediawiki/NewsRenderer-#{version}.php.erb"
  owner mediawiki_user
  group mediawiki_group
  mode '0644'
  notifies :restart, 'service[nginx]', :delayed
end

# Deploy LocalSettings.php
## In case We want to completely override the Logo Paths in the Environment File and Skip the Data Bag Value
desktop_logo = "{$wgScriptPath}/#{node['bonusbits_mediawiki']['mediawiki']['uploads_folder_name']}/#{node.run_state['data_bag']['mediawiki']['desktop_logo_filename']}"
node.default['bonusbits_mediawiki']['mediawiki']['localsettings']['wgLogo'] = desktop_logo
mobile_logo = "{$wgScriptPath}/#{node['bonusbits_mediawiki']['mediawiki']['uploads_folder_name']}/#{node.run_state['data_bag']['mediawiki']['mobile_logo_filename']}"
node.default['bonusbits_mediawiki']['mediawiki']['localsettings']['wgMobileFrontendLogo'] = mobile_logo

template "#{mediawiki_path}/LocalSettings.php" do
  source 'mediawiki/LocalSettings.php.erb'
  owner mediawiki_user
  group mediawiki_group
  mode '0644'
  sensitive true
  notifies :restart, 'service[nginx]', :delayed
  only_if { node['bonusbits_mediawiki']['mediawiki']['localsettings']['configure'] }
end

# Set Ownership on Mediawiki Home
ruby_block 'Set Ownership on Mediawiki Home' do
  block do
    bash_command = "chown -R nginx:nginx #{mediawiki_path}"

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
  not_if { ::File.exist?(uploads_path) } # So doesn't reset uploads ownership every time
end

# Mount and Configure EFS Uploads Share
include_recipe 'bonusbits_mediawiki::efs' if node['bonusbits_mediawiki']['efs']['configure']

# Add AdSense PHP Snippets
include_recipe 'bonusbits_mediawiki::adsense' if node['bonusbits_mediawiki']['adsense']['configure']

# Setup Log Rotate for Mediawiki Logs
include_recipe 'bonusbits_mediawiki::logrotate' if node['bonusbits_mediawiki']['logrotate']['configure']
