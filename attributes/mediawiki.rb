default['bonusbits_mediawiki_nginx']['mediawiki'].tap do |mediawiki|
  # Basics
  mediawiki['version_major'] = '1'
  mediawiki['version_minor'] = '28'
  mediawiki['mediawiki_path'] = '/var/www/html/mediawiki'
  mediawiki_path = node['bonusbits_mediawiki_nginx']['mediawiki']['mediawiki_path']
  mediawiki['uploads_folder_name'] = 'images'
  uploads_folder_name = node['bonusbits_mediawiki_nginx']['mediawiki']['uploads_folder_name']
  mediawiki['uploads_path'] = "#{mediawiki_path}/#{uploads_folder_name}"
  mediawiki['desktop_logo_filename'] = 'desktop_logo.png'
  desktop_logo_filename = node['bonusbits_mediawiki_nginx']['mediawiki']['desktop_logo_filename']
  mediawiki['mobile_logo_filename'] = 'mobile_logo.png'
  mobile_logo_filename = node['bonusbits_mediawiki_nginx']['mediawiki']['mobile_logo_filename']

  mediawiki['localsettings']['configure'] = true

  # LocalSettings - Web Settings
  mediawiki['localsettings']['wgSitename'] = 'My Wiki'
  mediawiki['localsettings']['wgMetaNamespace'] = 'My_Wiki'
  mediawiki['localsettings']['wgScriptPath'] = ''
  mediawiki['localsettings']['wgArticlePath'] = '/wiki/$1'
  mediawiki['localsettings']['wgUsePathInfo'] = 'true'
  mediawiki['localsettings']['wgScriptExtension'] = '.php'
  mediawiki['localsettings']['wgFavicon'] = '{$wgScriptPath}/favicon.ico'
  mediawiki['localsettings']['wgServer'] = 'http://mediawiki'
  mediawiki['localsettings']['wgStylePath'] = '{$wgScriptPath}/skins'
  mediawiki['localsettings']['wgLogo'] = "{$wgScriptPath}/#{uploads_folder_name}/#{desktop_logo_filename}"
  mediawiki['localsettings']['wgEnableEmail'] = 'true'
  mediawiki['localsettings']['wgEnableUserEmail'] = 'true'
  mediawiki['localsettings']['wgEmailAuthentication'] = 'true'
  mediawiki['localsettings']['wgEmergencyContact'] = 'nginx@localhost'
  mediawiki['localsettings']['wgPasswordSender'] = 'nginx@localhost'
  mediawiki['localsettings']['wgEnotifUserTalk'] = 'true'
  mediawiki['localsettings']['wgEnotifWatchlist'] = 'true'
  mediawiki['localsettings']['wgExternalLinkTarget'] = '_blank'
  mediawiki['localsettings']['wgUniversalEditButton'] = 'true'

  # LocalSettings - Database
  mediawiki['localsettings']['wgDBtype'] = 'mysql'
  mediawiki['localsettings']['wgDBserver'] = '127.0.0.1'
  mediawiki['localsettings']['wgDBname'] = 'wiki'
  mediawiki['localsettings']['wgDBuser'] = 'wiki'
  mediawiki['localsettings']['wgDBpassword'] = 'Password!'
  mediawiki['localsettings']['wgDBprefix'] = ''
  mediawiki['localsettings']['wgDBTableOptions'] = 'ENGINE=InnoDB, DEFAULT CHARSET=binary'
  mediawiki['localsettings']['wgDBmysql5'] = 'false'

  # LocalSettings - Cache and Uploads
  mediawiki['localsettings']['wgMainCacheType'] = 'CACHE_ACCEL'
  mediawiki['localsettings']['wgMemCachedServers'] = 'array()'
  mediawiki['localsettings']['wgCacheDirectory'] = '{$IP}/cache'
  mediawiki['localsettings']['wgEnableUploads'] = 'true'
  mediawiki['localsettings']['wgUseImageMagick'] = 'true'
  mediawiki['localsettings']['wgImageMagickConvertCommand'] = '/usr/bin/convert'
  mediawiki['localsettings']['wgUseInstantCommons'] = 'true'
  mediawiki['localsettings']['wgShellLocale'] = 'en_US.utf8'
  mediawiki['localsettings']['wgHashedUploadDirectory'] = 'false'
  mediawiki['localsettings']['wgUploadPath'] = "{$wgScriptPath}/#{uploads_folder_name}"
  mediawiki['localsettings']['wgUploadDirectory'] = "{$IP}/#{uploads_folder_name}"

  # LocalSettings - Site Settings
  mediawiki['localsettings']['wgLanguageCode'] = 'en'
  mediawiki['localsettings']['wgSecretKey'] = '123456789012345678901234567890'
  mediawiki['localsettings']['wgUpgradeKey'] = '12345678'
  mediawiki['localsettings']['wgRightsPage'] = ''
  mediawiki['localsettings']['wgRightsUrl'] = 'http://www.gnu.org/copyleft/fdl.html'
  mediawiki['localsettings']['wgRightsText'] = 'GNU Free Documentation License 1.3 or later'
  mediawiki['localsettings']['wgRightsIcon'] = '{$wgResourceBasePath}/resources/assets/licenses/gnu-fdl.png'
  mediawiki['localsettings']['wgDiff3'] = '/usr/bin/diff3'

  # LocalSettings - Permissions
  mediawiki['localsettings']['wgGroupPermissions']['createaccount'] = 'false'
  mediawiki['localsettings']['wgGroupPermissions']['read'] = 'true'
  mediawiki['localsettings']['wgGroupPermissions']['edit'] = 'false'
  mediawiki['localsettings']['wgGroupPermissions']['createpage'] = 'false'
  mediawiki['localsettings']['wgGroupPermissions']['createtalk'] = 'false'
  mediawiki['localsettings']['wgGroupPermissions']['writeapi'] = 'false'

  # LocalSettings - Skin
  mediawiki['localsettings']['wgDefaultSkin'] = 'vector'

  # Extensions
  mediawiki['extensions']['configure'] = true
  mediawiki['extensions']['list'] = %w(
    AntiBot
    AntiSpoof
    Cite
    ConfirmEdit
    Gadgets
    googleAnalytics
    ImageMap
    InputBox
    Interwiki
    LocalisationUpdate
    Mantle
    MobileFrontend
    MultiBoilerplate
    News
    Nuke
    ParserFunctions
    PdfHandler
    Poem
    Renameuser
    ReplaceText
    Scribunto
    SimpleAntiSpam
    SpamBlacklist
    SyntaxHighlight_GeSHi
    TitleBlacklist
    UploadWizard
    Widgets
    WikiEditor
    YouTube
  )

  # Extension Configurations
  mediawiki['localsettings']['configure'] = true
  mediawiki['localsettings']['wgGoogleAnalyticsAccount'] = 'UA-12345678-1'
  mediawiki['localsettings']['wgReCaptchaSiteKey'] = 'VkAbTAsAxbRnLUMQa9H5d5m7nzVYeSrVbFaYXPCy'
  mediawiki['localsettings']['wgReCaptchaSecretKey'] = 'svXnAMft7dUa9VE4VAu3tuTMXNAkCNvjN7yGWqz8'
  mediawiki['localsettings']['wgMobileFrontendLogo'] = "{$wgScriptPath}/#{uploads_folder_name}/#{mobile_logo_filename}"

  # News Extension
  mediawiki['extensions']['news']['replace_underscores_php_insert'] = '$params[\'title\'] = str_replace ( "_", " ", $params[\'title\'] );'
end
