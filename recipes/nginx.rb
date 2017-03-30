# Create Web Directory
directory node['bonusbits_mediawiki_nginx']['nginx']['root_site_path'] do
  recursive true
end

# Deploy Web Config
template '/etc/nginx/conf.d/mediawiki.conf' do
  source 'nginx/mediawiki.conf.erb'
  owner node['bonusbits_mediawiki_nginx']['nginx']['user']
  group node['bonusbits_mediawiki_nginx']['nginx']['group']
  mode '0644'
  notifies :restart, 'service[nginx]', :delayed
end

unless node['bonusbits_mediawiki_nginx']['deployment_type'] == 'docker'
  # Set somaxconn
  ruby_block 'Set somaxconn' do
    block do
      bash_command = 'sysctl -w net.core.somaxconn=1024'

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
    not_if { ::File.readlines('/proc/sys/net/core/somaxconn').grep(/^1024/).any? }
  end

  # Set somaxconn /etc/sysctl.conf
  ruby_block 'Set somaxconn /etc/sysctl.conf' do
    block do
      bash_command = 'echo \'net.core.somaxconn = 1024\' >> /etc/sysctl.conf'

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
    not_if { ::File.readlines('/etc/sysctl.conf').grep(/^net.core.somaxconn = 1024/).any? }
  end

  # Set tcp_syncookies
  ruby_block 'Set tcp_syncookies' do
    block do
      bash_command = 'sysctl -w net.ipv4.tcp_syncookies=4096'

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
    not_if { ::File.readlines('/proc/sys/net/ipv4/tcp_syncookies').grep(/^4096/).any? }
  end

  # Set tcp_syncookies /etc/sysctl.conf
  ruby_block 'Set tcp_syncookies /etc/sysctl.conf' do
    block do
      bash_command = 'echo \'net.ipv4.tcp_syncookies = 4096\' >> /etc/sysctl.conf'

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
    not_if { ::File.readlines('/etc/sysctl.conf').grep(/^net.ipv4.tcp_syncookies = 4096/).any? }
  end
end

# # Upgrade Pip (Brokes pathing to pip)
# ruby_block 'Upgrade Pip' do
#   block do
#     bash_command = 'pip install --upgrade pip'
#
#     # Run Bash Script and Capture StrOut, StrErr, and Status
#     require 'open3'
#     Chef::Log.warn("Open3: BASH Command (#{bash_command})")
#     out, err, status = Open3.capture3(bash_command)
#     Chef::Log.warn("Open3: Status (#{status})")
#     unless status.success?
#       Chef::Log.warn("Open3: Standard Out (#{out})")
#       Chef::Log.warn("Open3: Error Out (#{err})")
#       raise 'Failed!'
#     end
#   end
#   action :run
#   not_if { `pip --version`.match(/^pip 9.*..*/) } # ~FC048
# end
#
# # Install Ngxtop
# ruby_block 'Install Ngxtop' do
#   block do
#     bash_command = 'pip install ngxtop'
#
#     # Run Bash Script and Capture StrOut, StrErr, and Status
#     require 'open3'
#     Chef::Log.warn("Open3: BASH Command (#{bash_command})")
#     out, err, status = Open3.capture3(bash_command)
#     Chef::Log.warn("Open3: Status (#{status})")
#     unless status.success?
#       Chef::Log.warn("Open3: Standard Out (#{out})")
#       Chef::Log.warn("Open3: Error Out (#{err})")
#       raise 'Failed!'
#     end
#   end
#   action :run
#   not_if { ::File.exist?('/usr/local/bin/ngxtop') }
# end

# Enable and Start Service
service 'nginx' do
  action [:enable, :start]
end
