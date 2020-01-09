require_relative '../helpers/os_queries'

control 'logrotate' do
  impact 1.0
  title ''

  # Packages
  describe package('logrotate') do
    it { should be_installed }
  end

  # Configuration File
  describe file('/etc/logrotate.d/mediawiki') do
    it { should exist }
    it { should be_owned_by 'root' }
    it { should be_grouped_into 'root' }
  end
end
