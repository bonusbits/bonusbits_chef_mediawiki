deployment_type = attribute('deployment_type', default: 'ec2', description: 'Deployment Type')
role = attribute('role', default: 'web', description: 'Server Role')

if role == 'web' && deployment_type == 'ec2'
  describe 'Sudoers Config' do
    it 'has /usr/local/bin in sudoers secure path' do
      expect(file('/etc/sudoers').content).to match(%r{secure_path = /sbin:/bin:/usr/sbin:/usr/bin:/usr/local/bin$})
    end
  end
end
