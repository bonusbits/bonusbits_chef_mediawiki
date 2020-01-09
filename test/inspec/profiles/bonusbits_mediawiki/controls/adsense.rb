require_relative '../helpers/os_queries'

control 'adsense' do
  impact 1.0
  title ''

  describe file('/var/www/html/mediawiki/extensions/MobileFrontend/includes/skins/minerva.mustache') do
    it { should exist }
    it { should be_owned_by 'nginx' }
    its('content') { should include 'bonusbits_mobile_responsive' }
  end

  describe file('/var/www/html/mediawiki/skins/Vector/VectorTemplate.php') do
    it { should exist }
    it { should be_owned_by 'nginx' }
    its('content') { should include 'bonusbits_header' }
    its('content') { should include 'bonusbits_footer' }
    its('content') { should include 'bonusbits_sidebar_1' }
    its('content') { should include 'bonusbits_sidebar_2' }
    its('content') { should include 'bonusbits_sidebar_3' }
  end
end
