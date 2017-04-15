name 'bonusbits_mediawiki_nginx'
maintainer 'Levon Becker'
maintainer_email 'levon.becker.github@bonusbits.com'
license 'MIT'
description 'Deploy Mediawiki on Amazon Linux running Nginx and Php-Fpm'
long_description IO.read(File.join(File.dirname(__FILE__), 'README.md'))
version '1.2.0'
chef_version '~> 12.5' if respond_to?(:chef_version)
issues_url 'https://github.com/bonusbits/bonusbits_mediawiki_nginx/issues'
source_url 'https://github.com/bonusbits/bonusbits_mediawiki_nginx'

depends 'bonusbits_base'

%w(
  amazon
).each do |os|
  supports os
end
