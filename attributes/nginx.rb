default['bonusbits_mediawiki_nginx']['nginx'].tap do |nginx|
  nginx['user'] = 'nginx'
  nginx['group'] = 'nginx'
  nginx['root_site_path'] = '/var/www/html'
  nginx['x_forwarded_traffic'] = true
  nginx['rewrite_wiki_alias'] = false
end

# Debug
message_list = [
  '',
  '** Nginx **',
  "INFO: User                  (#{node['bonusbits_mediawiki_nginx']['nginx']['user']})",
  "INFO: Group                 (#{node['bonusbits_mediawiki_nginx']['nginx']['group']})",
  "INFO: Root Path             (#{node['bonusbits_mediawiki_nginx']['nginx']['root_site_path']})",
  "INFO: X Forward Traffic     (#{node['bonusbits_mediawiki_nginx']['nginx']['x_forwarded_traffic']})",
  "INFO: Rewrite Wiki Alias    (#{node['bonusbits_mediawiki_nginx']['nginx']['rewrite_wiki_alias']})"
]
message_list.each do |message|
  Chef::Log.warn(message)
end
