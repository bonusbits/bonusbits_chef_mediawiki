title 'Nginx Setup'
role = attribute('role', default: 'web', description: 'Server Role')

if role == 'web'
  describe 'Nginx Setup' do
    it 'nginx installed' do
      expect(package('nginx')).to be_installed
    end

    it 'nginx service' do
      expect(service('nginx')).to be_enabled
      expect(service('nginx')).to be_running
    end

    it 'has /var/www/html' do
      expect(file('/var/www/html')).to be_directory
      expect(file('/var/www/html')).to be_owned_by('root')
      expect(file('/var/www/html')).to be_grouped_into('root')
    end
  end
end
