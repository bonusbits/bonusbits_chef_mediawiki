# Create Web Directory
directory '/var/www/html' do
  recursive true
end

# Deploy Web Config
template '/etc/nginx/conf.d/mediawiki.conf' do
  source 'mediawiki.conf.erb'
  owner node['bonusbits_mediawiki_nginx']['nginx']['user']
  group node['bonusbits_mediawiki_nginx']['nginx']['group']
  mode '0644'
  notifies :restart, 'service[nginx]', :delayed
end

# Set somaxconn
ruby_block 'Set somaxconn' do
  block do
    require 'open3'
    bash_command = 'sysctl -w net.core.somaxconn=1024'
    Chef::Log.warn("REPORT: Open3 BASH Command (#{bash_command})")

    # Run Bash Script and Capture StrOut, StrErr, and Status
    out, err, status = Open3.capture3(bash_command)
    Chef::Log.warn("REPORT: Open3 Status (#{status})")
    Chef::Log.warn("REPORT: Open3 Standard Out (#{out})")
    Chef::Log.warn("REPORT: Open3 Error Out (#{err})")
    raise 'Failed!' unless status.success?
  end
  action :run
  not_if { ::File.readlines('/proc/sys/net/core/somaxconn').grep(/^1024/).any? }
end

# Set somaxconn /etc/sysctl.conf
ruby_block 'Set somaxconn /etc/sysctl.conf' do
  block do
    require 'open3'
    bash_command = 'echo \'net.core.somaxconn = 1024\' >> /etc/sysctl.conf'
    Chef::Log.warn("REPORT: Open3 BASH Command (#{bash_command})")

    # Run Bash Script and Capture StrOut, StrErr, and Status
    out, err, status = Open3.capture3(bash_command)
    Chef::Log.warn("REPORT: Open3 Status (#{status})")
    Chef::Log.warn("REPORT: Open3 Standard Out (#{out})")
    Chef::Log.warn("REPORT: Open3 Error Out (#{err})")
    raise 'Failed!' unless status.success?
  end
  action :run
  not_if { ::File.readlines('/etc/sysctl.conf').grep(/^net\.core\.somaxconn = 1024/).any? }
end

# Set tcp_syncookies
ruby_block 'Set tcp_syncookies' do
  block do
    require 'open3'
    bash_command = 'sysctl -w net.ipv4.tcp_syncookies=4096'
    Chef::Log.warn("REPORT: Open3 BASH Command (#{bash_command})")

    # Run Bash Script and Capture StrOut, StrErr, and Status
    out, err, status = Open3.capture3(bash_command)
    Chef::Log.warn("REPORT: Open3 Status (#{status})")
    Chef::Log.warn("REPORT: Open3 Standard Out (#{out})")
    Chef::Log.warn("REPORT: Open3 Error Out (#{err})")
    raise 'Failed!' unless status.success?
  end
  action :run
  not_if { ::File.readlines('/proc/sys/net/ipv4/tcp_syncookies').grep(/^4096/).any? }
end

# Set tcp_syncookies /etc/sysctl.conf
ruby_block 'Set tcp_syncookies /etc/sysctl.conf' do
  block do
    require 'open3'
    bash_command = 'echo \'net.ipv4.tcp_syncookies = 4096\' >> /etc/sysctl.conf'
    Chef::Log.warn("REPORT: Open3 BASH Command (#{bash_command})")

    # Run Bash Script and Capture StrOut, StrErr, and Status
    out, err, status = Open3.capture3(bash_command)
    Chef::Log.warn("REPORT: Open3 Status (#{status})")
    Chef::Log.warn("REPORT: Open3 Standard Out (#{out})")
    Chef::Log.warn("REPORT: Open3 Error Out (#{err})")
    raise 'Failed!' unless status.success?
  end
  action :run
  not_if { ::File.readlines('/etc/sysctl.conf').grep(/^net\.ipv4\.tcp_syncookies = 4096/).any? }
end

# Upgrade Pip (Brokes pathing to pip)
ruby_block 'Upgrade Pip' do
  block do
    require 'open3'
    bash_command = 'pip install --upgrade pip'
    Chef::Log.warn("REPORT: Open3 BASH Command (#{bash_command})")

    # Run Bash Script and Capture StrOut, StrErr, and Status
    out, err, status = Open3.capture3(bash_command)
    Chef::Log.warn("REPORT: Open3 Status (#{status})")
    Chef::Log.warn("REPORT: Open3 Standard Out (#{out})")
    Chef::Log.warn("REPORT: Open3 Error Out (#{err})")
    raise 'Failed!' unless status.success?
  end
  action :run
  not_if { `pip --version`.match(/^pip 9\.*\..*/) } #~FC048
end

# Install Ngxtop
ruby_block 'Install Ngxtop' do
  block do
    require 'open3'
    bash_command = 'pip install ngxtop'
    Chef::Log.warn("REPORT: Open3 BASH Command (#{bash_command})")

    # Run Bash Script and Capture StrOut, StrErr, and Status
    out, err, status = Open3.capture3(bash_command)
    Chef::Log.warn("REPORT: Open3 Status (#{status})")
    Chef::Log.warn("REPORT: Open3 Standard Out (#{out})")
    Chef::Log.warn("REPORT: Open3 Error Out (#{err})")
    raise 'Failed!' unless status.success?
  end
  action :run
  not_if { ::File.exist?('/usr/local/bin/ngxtop') }
end

# Enable and Start Service
service 'nginx' do
  action [:enable, :start]
end
