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

  # it 'somaxconn 1024' do
  #   expect(file('/proc/sys/net/core/somaxconn').content).to match(/^1024/)
  #   expect(file('/etc/sysctl.conf').content).to match(/^net.core.somaxconn = 1024/)
  # end
  #
  # it 'tcp_syncookies 4096' do
  #   expect(file('/etc/sysctl.conf').content).to match(/^net.ipv4.tcp_syncookies = 4096/)
  # end
  #
  # it 'pip 9.x' do
  #   expect(command('pip --version').stdout).to match(/^pip 9.*/)
  # end
  #
  # it 'has /usr/local/bin/ngxtop' do
  #   expect(file('/usr/local/bin/ngxtop')).to exist
  # end
end
