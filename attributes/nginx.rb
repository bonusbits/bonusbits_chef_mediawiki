default['bonusbits_mediawiki_nginx']['nginx'].tap do |nginx|
  nginx['user'] = 'nginx'
  nginx['group'] = 'nginx'
  nginx['root_site_path'] = '/var/www/html'
  nginx['x_forwarded_traffic'] = true
  nginx['rewrite_wiki_alias'] = false
end
