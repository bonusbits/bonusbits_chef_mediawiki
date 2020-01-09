name 'bonusbits_mediawiki'
maintainer 'Levon Becker'
maintainer_email 'levon.becker.github@bonusbits.com'
license 'MIT'
description 'Deploy Mediawiki on Amazon Linux running Nginx and Php-Fpm'
long_description IO.read(File.join(File.dirname(__FILE__), 'README.md'))
version '2.0.0'
chef_version '~> 15.4' if respond_to?(:chef_version)
issues_url 'https://github.com/bonusbits/bonusbits_mediawiki/issues'
source_url 'https://github.com/bonusbits/bonusbits_mediawiki'

depends 'bonusbits_base', '~> 3.0.1'

supports 'amazon'
