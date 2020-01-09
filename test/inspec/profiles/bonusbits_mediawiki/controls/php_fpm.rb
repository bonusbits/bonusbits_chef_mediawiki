require_relative '../helpers/os_queries'

control 'php_fpm' do
  impact 1.0
  title ''

  describe package('php70-fpm') do
    it { should be_installed }
  end

  describe service('php-fpm-7.0') do
    it { should be_enabled }
    it { should be_running }
  end

  describe file('/etc/php-fpm-7.0.d/www.conf') do
    it { should exist }
    it { should be_owned_by 'root' }
    it { should be_grouped_into 'root' }
    its('content') { should include /^user = nginx/ }
    its('content') { should include /^group = nginx/ }
  end

  describe file('/var/log/php-fpm') do
    it { should exist }
    it { should be_owned_by 'nginx' }
    it { should be_grouped_into 'nginx' }
  end

  describe file('/var/log/php-fpm/7.0') do
    it { should exist }
    it { should be_owned_by 'nginx' }
    it { should be_grouped_into 'nginx' }
  end
end
