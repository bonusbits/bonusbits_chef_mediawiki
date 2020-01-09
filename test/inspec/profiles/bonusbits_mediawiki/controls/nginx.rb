require_relative '../helpers/os_queries'

control 'nginx' do
  impact 1.0
  title ''

  describe package('nginx') do
    it { should be_installed }
  end

  describe service('nginx') do
    it { should be_enabled }
    it { should be_running }
  end

  describe file('/var/www/html') do
    it { should be_directory }
    it { should be_owned_by 'root' }
    it { should be_grouped_into 'root' }
  end
end
