name 'bonusbits_mediawiki_nginx'
maintainer 'Levon Becker'
maintainer_email 'levon.becker.github@bonusbits.com'
license 'MIT'
description 'Deploy Mediawiki on Amazon Linux running Nginx and Php-Fpm'
long_description IO.read(File.join(File.dirname(__FILE__), 'README.md'))
version '1.0.7'
issues_url 'https://github.com/bonusbits/bonusbits_mediawiki_nginx/issues'
source_url 'https://github.com/bonusbits/bonusbits_mediawiki_nginx'

%w(
  amazon
).each do |os|
  supports os
end
