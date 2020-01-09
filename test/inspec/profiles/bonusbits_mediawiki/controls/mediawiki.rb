require_relative '../helpers/os_queries'

inside_aws = aws?

# Fetch Chef Node Attributes
node = node_attributes

control 'mediawiki' do
  impact 1.0
  title ''

  mediawiki_path = node['bonusbits_mediawiki']['mediawiki']['mediawiki_path']
  mediawiki_version = node['bonusbits_mediawiki']['mediawiki']['version']
  extensions_list = node['bonusbits_mediawiki']['mediawiki']['extensions']['list']

  # Web Root
  describe file(mediawiki_path) do
    it { should be_directory }
    it { should be_owned_by 'nginx' }
    it { should be_grouped_into 'nginx' }
  end

  # Logging
  describe file('/var/log/mediawiki') do
    it { should be_directory }
    it { should be_owned_by 'nginx' }
    it { should be_grouped_into 'nginx' }
  end

  # Configuration File
  describe file("#{mediawiki_path}/LocalSettings.php") do
    it { should exist }
    it { should be_owned_by 'nginx' }
    it { should be_grouped_into 'nginx' }
  end

  # Mediawiki Version
  describe file("#{mediawiki_path}/RELEASE-NOTES-#{mediawiki_version}") do
    it { should exist }
    it { should be_owned_by 'nginx' }
    it { should be_grouped_into 'nginx' }
  end

  # Extensions
  extensions_list.each do |extension|
    describe file("#{mediawiki_path}/extensions/#{extension}") do
      it { should be_directory }
      it { should be_owned_by 'nginx' }
      it { should be_grouped_into 'nginx' }
    end
  end

  # Vector Skin
  describe file("#{mediawiki_path}/skins/Vector") do
    it { should be_directory }
    it { should be_owned_by 'nginx' }
    it { should be_grouped_into 'nginx' }
  end

  # Vendor Directory
  describe file("#{mediawiki_path}/vendor") do
    it { should be_directory }
    it { should be_owned_by 'nginx' }
    it { should be_grouped_into 'nginx' }
  end

  # Symlinks
  describe file("#{mediawiki_path}/favicon.ico") do
    it { should be_symlink }
  end
  describe file("#{mediawiki_path}/sitemap.xml") do
    it { should be_symlink }
  end

  # Uploads Files (EFS Mount Required)
  if inside_aws
    describe file("#{mediawiki_path}/uploads/favicon.ico") do
      it { should exist }
      it { should be_owned_by 'nginx' }
      it { should be_grouped_into 'nginx' }
    end
    describe file("#{mediawiki_path}/uploads/sitemap.xml") do
      it { should exist }
      it { should be_owned_by 'nginx' }
      it { should be_grouped_into 'nginx' }
    end
    describe file("#{mediawiki_path}/uploads/desktop_logo.png") do
      it { should exist }
      it { should be_owned_by 'nginx' }
      it { should be_grouped_into 'nginx' }
    end
    describe file("#{mediawiki_path}/uploads/mobile_logo.png") do
      it { should exist }
      it { should be_owned_by 'nginx' }
      it { should be_grouped_into 'nginx' }
    end
  end
end
