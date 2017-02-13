# Deploy DNS Update Script
template '/usr/sbin/update-dns' do
  source 'update-dns.sh.erb'
  owner 'root'
  group 'root'
  mode '0755'
end

# Run DNS Update Script
ruby_block 'Run DNS Update Script' do
  block do
    require 'open3'
    bash_command = '/usr/sbin/update-dns'
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
