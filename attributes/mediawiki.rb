default['bonusbits_mediawiki_nginx']['mediawiki'].tap do |mediawiki|
  # Basics
  mediawiki['localsettings']['configure'] = true

  # LocalSettings
  mediawiki['localsettings']['wgSitename'] = 'ChefCore Wiki'
  mediawiki['localsettings']['wgMetaNamespace'] = 'ChefCore_Wiki'
  mediawiki['localsettings']['wgScriptPath'] = ''
  mediawiki['localsettings']['wgArticlePath'] = '/wiki/$1'
  mediawiki['localsettings']['wgUsePathInfo'] = 'true'
  mediawiki['localsettings']['wgServer'] = 'http://mediawiki'
  mediawiki['localsettings']['wgEnableEmail'] = 'true'
  mediawiki['localsettings']['wgEnableUserEmail'] = 'true'
  mediawiki['localsettings']['wgEmergencyContact'] = 'apache@localhost'
  mediawiki['localsettings']['wgPasswordSender'] = 'apache@localhost'
  mediawiki['localsettings']['wgEmailAuthentication'] = 'true'
  mediawiki['localsettings']['wgDBtype'] = 'mysql'
  mediawiki['localsettings']['wgDBserver'] = '127.0.0.1'
  mediawiki['localsettings']['wgDBname'] = 'wiki'
  mediawiki['localsettings']['wgDBuser'] = 'wiki'
  mediawiki['localsettings']['wgDBprefix'] = ''
  mediawiki['localsettings']['wgEnableUploads'] = 'true'
  mediawiki['localsettings']['wgUseImageMagick'] = 'true'
  mediawiki['localsettings']['wgImageMagickConvertCommand'] = '/usr/bin/convert'
  mediawiki['localsettings']['wgUseInstantCommons'] = 'false'
  mediawiki['localsettings']['wgHashedUploadDirectory'] = 'false'
  mediawiki['localsettings']['wgDefaultSkin'] = 'vector'
end
