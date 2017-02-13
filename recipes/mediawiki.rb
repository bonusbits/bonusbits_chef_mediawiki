mediawiki_path = node['bonusbits_mediawiki_nginx']['mediawiki']['mediawiki_path']

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

# Download Logos
s3_content_path = node['bonusbits_mediawiki_nginx']['aws']['s3_content_path']
logo_list = %w(
  desktop_logo.png
  mobile_logo.png
)

ruby_block 'Download Logos' do
  block do
    logo_list.each do |content|
      require 'open3'
      bash_command = "aws s3 cp s3://#{s3_content_path}/#{content} #{mediawiki_path}/images/#{content} --sse"
      Chef::Log.warn("REPORT: Open3 BASH Command (#{bash_command})")

      # Run Bash Script and Capture StrOut, StrErr, and Status
      out, err, status = Open3.capture3(bash_command)
      Chef::Log.warn("REPORT: Open3 Status (#{status})")
      Chef::Log.warn("REPORT: Open3 Standard Out (#{out})")
      Chef::Log.warn("REPORT: Open3 Error Out (#{err})")
      raise 'Failed!' unless status.success?
    end
  end
  action :run
end

# Deploy favicon
ruby_block 'Download Logos' do
  block do
    require 'open3'
    bash_command = "aws s3 cp s3://#{s3_content_path}/favicon.ico #{mediawiki_path}/favicon.ico --sse"
    Chef::Log.warn("REPORT: Open3 BASH Command (#{bash_command})")

    # Run Bash Script and Capture StrOut, StrErr, and Status
    out, err, status = Open3.capture3(bash_command)
    Chef::Log.warn("REPORT: Open3 Status (#{status})")
    Chef::Log.warn("REPORT: Open3 Standard Out (#{out})")
    Chef::Log.warn("REPORT: Open3 Error Out (#{err})")
    raise 'Failed!' unless status.success?
  end
  action :run
end

# Deploy Robots.txt
template "#{mediawiki_path}/robots.txt" do
  source 'robots.txt.erb'
  owner node['bonusbits_mediawiki_nginx']['user']
  group node['bonusbits_mediawiki_nginx']['group']
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

# Deploy LocalSettings.php
template "#{mediawiki_path}/LocalSettings.php" do
  source 'LocalSettings.php.erb'
  owner node['bonusbits_mediawiki_nginx']['user']
  group node['bonusbits_mediawiki_nginx']['group']
  mode '0644'
  notifies :restart, 'service[nginx]', :delayed
  only_if { node['bonusbits_mediawiki_nginx']['mediawiki']['localsettings']['configure'] }
end

# Set Ownership
ruby_block 'Set Ownership' do
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
end
