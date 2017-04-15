describe 'PHP FPM' do
  it 'php70-fpm installed' do
    expect(package('php70-fpm')).to be_installed
  end

  it 'php70-fpm service' do
    expect(service('php-fpm-7.0')).to be_enabled
    expect(service('php-fpm-7.0')).to be_running
  end

  it 'nginx:nginx set to run service' do
    expect(file('/etc/php-fpm-7.0.d/www.conf').content).to match(/^user = nginx/)
    expect(file('/etc/php-fpm-7.0.d/www.conf').content).to match(/^group = nginx/)
  end

  it 'nginx owns /var/log/php-fpm' do
    expect(file('/var/log/php-fpm')).to be_owned_by('nginx')
    expect(file('/var/log/php-fpm/7.0')).to be_owned_by('nginx')
  end

  it 'nginx owns /var/lib/php/7.0' do
    expect(file('/var/lib/php/7.0')).to be_grouped_into('nginx')
  end
end
