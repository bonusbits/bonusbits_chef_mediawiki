# Switch User and Group
ruby_block 'Rename Folder' do
  block do
    require 'open3'
    bash_command = 'sed -i "s/apache/nginx/g" /etc/php-fpm-7.0.d/www.conf'
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

# Switch User and Group
ruby_block 'Change Ownership of Nginx Logs Folder' do
  block do
    require 'open3'
    bash_command = 'chown -R nginx:nginx /var/log/php-fpm'
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

# Switch User and Group
ruby_block 'Change Ownership' do
  block do
    require 'open3'
    bash_command = 'chown -R root:nginx /var/lib/php/7.0/'
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

# Enable and Start Service
service 'php-fpm-7.0' do
  action [:enable, :start]
end
