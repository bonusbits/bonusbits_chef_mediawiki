require_relative '../helpers/os_queries'

control 'nginx' do
  impact 1.0
  title ''

  # Packages
  describe package('nginx') do
    it { should be_installed }
  end

  # Service
  describe service('nginx') do
    it { should be_enabled }
    it { should be_running }
  end

  # Web Root
  describe file('/var/www/html') do
    it { should be_directory }
    it { should be_owned_by 'root' }
    it { should be_grouped_into 'root' }
  end
end
