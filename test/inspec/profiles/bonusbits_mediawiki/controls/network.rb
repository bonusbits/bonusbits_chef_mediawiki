require_relative '../helpers/os_queries'

control 'network' do
  impact 1.0
  title ''
  only_if { ec2? }

  describe file('/proc/sys/net/core/somaxconn') do
    it { should exist }
    it { should be_owned_by 'nginx' }
    it { should be_grouped_into 'root' }
    its('content') { should include /^1024/ }
  end

  describe file('/etc/sysctl.conf') do
    it { should exist }
    it { should be_owned_by 'nginx' }
    it { should be_grouped_into 'root' }
    its('content') { should include /^net.core.somaxconn = 1024/ }
    its('content') { should include /^net.ipv4.tcp_syncookies = 4096/ }
  end
end
