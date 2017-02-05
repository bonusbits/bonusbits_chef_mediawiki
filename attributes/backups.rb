default['bonusbits_mediawiki_nginx']['backups'].tap do |backups|
  backups['configure'] = false
  backups['bucket'] = 'bonusbits-backups'
  backups['efs_backup_filename'] = 'bonusbits-efs.tgz'
  backups['web_backup_filename'] = 'bonusbits-webcontent.tgz'
end
