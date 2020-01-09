require_relative '../helpers/os_queries'

inside_aws = ec2?

control 'efs' do
  impact 1.0
  title ''
  only_if { inside_aws }

  # Dependency Packages
  describe package('nfs-utils') do
    it { should be_installed }
  end

  # EFS Mount Directory
  describe file('/var/www/html/mediawiki/uploads') do
    it { should be_directory }
    it { should be_owned_by 'nginx' }
    it { should be_grouped_into 'nginx' }
  end

  # EFS Mount File Access Test
  describe file('/var/www/html/mediawiki/uploads/favicon.ico') do
    it { should exist }
    it { should be_owned_by 'nginx' }
    it { should be_grouped_into 'nginx' }
  end

  # FSTab Mount Command
  describe command('cat /etc/fstab') do
    its(:exit_status) { should eq 0 }
    its(:stdout) { should include('/var/www/html/mediawiki/uploads nfs4') }
  end

  # Check Mount
  describe command('mount | grep nfs4') do
    its(:exit_status) { should eq 0 }
    its(:stdout) { should include('amazonaws.com:/ on /var/www/html/mediawiki/uploads type nfs4') }
  end
end
