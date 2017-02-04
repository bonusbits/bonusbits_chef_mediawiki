default['bonusbits_mediawiki_nginx']['backups'].tap do |backups|
  backups['configure'] = false
  backups['bucket'] = 'bonusbits-backups'
  backups['subfolder'] = 'bonusbits-dev'
  backups['sql_subfolder'] = 'shareddb'
  backups['web_subfolder'] = 'web'
  backups['sql_filename'] = 'bonusbits-sql.tgz'
  backups['web_filename'] = 'bonusbits-webcontent.tgz'
end
