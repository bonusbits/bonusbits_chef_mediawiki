require_relative '../helpers/os_queries'

node = node_attributes
nginx_version = node['bonusbits_mediawiki']['nginx']['version']

control 'nginx' do
  impact 1.0
  title ''

  # Packages
  describe package('nginx') do
    it { should be_installed }
    its('version') { should eq nginx_version }
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
