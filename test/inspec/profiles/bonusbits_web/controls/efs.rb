require_relative '../helpers/os_queries'
inside_aws = ec2?

if inside_aws
  describe 'EFS Mount' do
    it 'nfs-utils installed' do
      expect(package('nfs-utils')).to be_installed
    end

    it 'has /var/www/html/mediawiki/uploads' do
      expect(file('/var/www/html/mediawiki/uploads')).to be_directory
      expect(file('/var/www/html/mediawiki/uploads')).to be_owned_by('nginx')
      expect(file('/var/www/html/mediawiki/uploads')).to be_grouped_into('nginx')
    end

    it 'has fstab entry' do
      expect(command('cat /etc/fstab').stdout).to include('/var/www/html/mediawiki/uploads nfs4')
    end

    it 'mounted' do
      expect(command('mount | grep nfs4').stdout).to include('amazonaws.com:/ on /var/www/html/mediawiki/uploads type nfs4')
    end

    it 'has /var/www/html/mediawiki/uploads/sitemap.xml' do
      expect(file('/var/www/html/mediawiki/uploads/sitemap.xml')).to exist
    end
  end
end
