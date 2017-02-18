# vector_template = '/var/www/html/mediawiki/skins/Vector/VectorTemplate.php'

# # Set tcp_syncookies /etc/sysctl.conf
# ruby_block 'Set tcp_syncookies /etc/sysctl.conf' do
#   block do
#     require 'open3'
#     bash_command = 'echo \'net.ipv4.tcp_syncookies = 4096\' >> /etc/sysctl.conf'
#     Chef::Log.warn("REPORT: Open3 BASH Command (#{bash_command})")
#
#     # Run Bash Script and Capture StrOut, StrErr, and Status
#     out, err, status = Open3.capture3(bash_command)
#     Chef::Log.warn("REPORT: Open3 Status (#{status})")
#     Chef::Log.warn("REPORT: Open3 Standard Out (#{out})")
#     Chef::Log.warn("REPORT: Open3 Error Out (#{err})")
#     raise 'Failed!' unless status.success?
#   end
#   action :run
#   not_if { ::File.readlines('/etc/sysctl.conf').grep(/^net\.ipv4\.tcp_syncookies = 4096/).any? }
# end

# mobile_template = '/var/www/htmlmediawiki/extensions/MobileFrontend/includes/skins/MinervaTemplate.php'
