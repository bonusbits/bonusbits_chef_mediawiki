mediawiki_user = node['bonusbits_mediawiki']['nginx']['user']
mediawiki_group = node['bonusbits_mediawiki']['nginx']['group']

# Switch User and Group
ruby_block 'Switch Php Fpm Ownership' do
  block do
    bash_command = "sed -i 's/apache/#{mediawiki_user}/g' /etc/php-fpm-7.0.d/www.conf"

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
  not_if { ::File.readlines('/etc/php-fpm-7.0.d/www.conf').grep(/^user = nginx/).any? }
end

# Switch User and Group
php_fpm_log_path = '/var/log/php-fpm'
ruby_block "Change Ownership of PHP FPM Logs Folder (#{php_fpm_log_path})" do
  block do
    bash_command = "chown -R #{mediawiki_user}:#{mediawiki_group} #{php_fpm_log_path}"

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
  not_if do
    require 'etc'
    file_uid = ::File.stat(php_fpm_log_path).uid
    Etc.getpwuid(file_uid).name == mediawiki_user
  end
end

# Switch User and Group
php_fpm_lib_path = '/var/lib/php/7.0'
ruby_block "Change Ownership of PHP FPM Lib Directory (#{php_fpm_lib_path})" do
  block do
    bash_command = "chown -R root:#{mediawiki_group} #{php_fpm_lib_path}"

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
  not_if do
    require 'etc'
    file_gid = ::File.stat(php_fpm_lib_path).gid
    Etc.getgrgid(file_gid).name == mediawiki_group
  end
end

# Enable and Start Service
service 'php-fpm-7.0' do
  action [:enable, :start]
end
