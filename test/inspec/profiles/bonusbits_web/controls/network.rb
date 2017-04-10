require_relative '../helpers/os_queries'

deployment_type = attribute('deployment_type', default: 'ec2', description: 'Deployment Type')

if deployment_type == 'ec2'
  describe 'Network Settings' do
    it 'somaxconn 1024' do
      expect(file('/proc/sys/net/core/somaxconn').content).to match(/^1024/)
      expect(file('/etc/sysctl.conf').content).to match(/^net.core.somaxconn = 1024/)
    end

    it 'tcp_syncookies 4096' do
      expect(file('/etc/sysctl.conf').content).to match(/^net.ipv4.tcp_syncookies = 4096/)
    end
  end
end
