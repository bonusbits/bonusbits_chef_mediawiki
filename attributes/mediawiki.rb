default['bonusbits_mediawiki_nginx']['mediawiki'].tap do |mediawiki|
  # Basics
  mediawiki['version_major'] = '1'
  mediawiki['version_minor'] = '28'
  version_major = node['bonusbits_mediawiki_nginx']['mediawiki']['version_major']
  version_minor = node['bonusbits_mediawiki_nginx']['mediawiki']['version_minor']
  mediawiki['version'] = "#{version_major}.#{version_minor}"
  mediawiki['release'] = "REL#{version_major}_#{version_minor}"
  mediawiki['site_folder_name'] = 'mediawiki'
  mediawiki_path = "#{node['bonusbits_mediawiki_nginx']['nginx']['root_site_path']}/#{node['bonusbits_mediawiki_nginx']['mediawiki']['site_folder_name']}"
  mediawiki['mediawiki_path'] = mediawiki_path
  mediawiki['uploads_folder_name'] = 'images'
  uploads_folder_name = node['bonusbits_mediawiki_nginx']['mediawiki']['uploads_folder_name']
  mediawiki['uploads_path'] = "#{mediawiki_path}/#{uploads_folder_name}"

  # LocalSettings
  mediawiki['localsettings']['configure'] = true

  # LocalSettings - Web Settings
  mediawiki['localsettings']['wgScriptPath'] = ''
  mediawiki['localsettings']['wgArticlePath'] = '/wiki/$1'
  mediawiki['localsettings']['wgUsePathInfo'] = 'true'
  mediawiki['localsettings']['wgScriptExtension'] = '.php'
  mediawiki['localsettings']['wgFavicon'] = '{$wgScriptPath}/favicon.ico'
  mediawiki['localsettings']['wgStylePath'] = '{$wgScriptPath}/skins'
  # mediawiki['localsettings']['wgLogo'] = "{$wgScriptPath}/#{uploads_folder_name}/#{desktop_logo_filename}"
  mediawiki['localsettings']['wgEnableEmail'] = 'true'
  mediawiki['localsettings']['wgEnableUserEmail'] = 'true'
  mediawiki['localsettings']['wgEmailAuthentication'] = 'true'
  mediawiki['localsettings']['wgEnotifUserTalk'] = 'true'
  mediawiki['localsettings']['wgEnotifWatchlist'] = 'true'
  mediawiki['localsettings']['wgExternalLinkTarget'] = '_blank'
  mediawiki['localsettings']['wgUniversalEditButton'] = 'true'

  # LocalSettings - Database
  mediawiki['localsettings']['wgDBtype'] = 'mysql'
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
  # mediawiki['localsettings']['wgMobileFrontendLogo'] = "{$wgScriptPath}/#{uploads_folder_name}/#{mobile_logo_filename}"

  # News Extension
  mediawiki['extensions']['news']['replace_underscores_php_insert'] = '$params[\'title\'] = str_replace ( "_", " ", $params[\'title\'] );'
end

# Debug
message_list = [
  '',
  '** Mediawiki **',
  "Version                     (#{node['bonusbits_mediawiki_nginx']['mediawiki']['version']})",
  "Release                     (#{node['bonusbits_mediawiki_nginx']['mediawiki']['release']})",
  "Site Path                   (#{node['bonusbits_mediawiki_nginx']['mediawiki']['mediawiki_path']})",
  "Uploads Path                (#{node['bonusbits_mediawiki_nginx']['mediawiki']['uploads_path']})",
  "Configure Localsettings     (#{node['bonusbits_mediawiki_nginx']['mediawiki']['localsettings']['configure']})",
  "Configure Extensions        (#{node['bonusbits_mediawiki_nginx']['mediawiki']['extensions']['configure']})"
]
message_list.each do |message|
  Chef::Log.warn(message)
end
