role = attribute('role', default: 'web', description: 'Server Role')

if role == 'web'
  describe 'Google Adsense' do
    it 'has header ad' do
      expect(file('/var/www/html/mediawiki/skins/Vector/VectorTemplate.php').content).to match(/bonusbits_header/)
    end

    it 'has footer ad' do
      expect(file('/var/www/html/mediawiki/skins/Vector/VectorTemplate.php').content).to match(/bonusbits_footer/)
    end

    it 'has sidebar ads' do
      expect(file('/var/www/html/mediawiki/skins/Vector/VectorTemplate.php').content).to match(/bonusbits_sidebar_1/)
      expect(file('/var/www/html/mediawiki/skins/Vector/VectorTemplate.php').content).to match(/bonusbits_sidebar_2/)
      expect(file('/var/www/html/mediawiki/skins/Vector/VectorTemplate.php').content).to match(/bonusbits_sidebar_3/)
    end

    it 'has mobile ads' do
      expect(file('/var/www/html/mediawiki/extensions/MobileFrontend/includes/skins/minerva.mustache').content).to match(/bonusbits_mobile_responsive/)
    end
  end
end
