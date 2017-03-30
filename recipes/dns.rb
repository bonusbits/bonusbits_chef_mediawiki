# Deploy DNS Update Script
template '/usr/sbin/update-dns' do
  source 'dns/update-dns.sh.erb'
  owner 'root'
  group 'root'
  mode '0755'
end

# Run DNS Update Script
ruby_block 'Run DNS Update Script' do
  block do
    bash_command = '/usr/sbin/update-dns'

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
  only_if { node['bonusbits_mediawiki_nginx']['aws']['inside'] }
end
