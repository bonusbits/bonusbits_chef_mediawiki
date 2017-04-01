role = attribute('role', default: 'web', description: 'Server Role')

if role == 'web'
  describe 'Log Rotate' do
    it 'logrotate installed' do
      expect(package('logrotate')).to be_installed
    end

    it 'has /etc/logrotate.d/mediawiki' do
      expect(file('/etc/logrotate.d/mediawiki')).to exist
    end
  end
end
