name 'bonusbits_mediawiki_nginx'
maintainer 'Levon Becker'
maintainer_email 'levon.becker.github@bonusbits.com'
license 'MIT'
description 'Deploy Bundled Web Sites From S3 to Apache httpd24 on Amazon Linux'
long_description IO.read(File.join(File.dirname(__FILE__), 'README.md'))
version '1.0.0'
issues_url 'https://github.com/bonusbits/bonusbits_mediawiki_nginx/issues'
source_url 'https://github.com/bonusbits/bonusbits_mediawiki_nginx'

depends 'bonusbits_library'

%w(
  amazon
).each do |os|
  supports os
end
