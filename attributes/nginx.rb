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
  "User                        (#{node['bonusbits_mediawiki_nginx']['nginx']['user']})",
  "Group                       (#{node['bonusbits_mediawiki_nginx']['nginx']['group']})",
  "Root Path                   (#{node['bonusbits_mediawiki_nginx']['nginx']['root_site_path']})",
  "X Forward Traffic           (#{node['bonusbits_mediawiki_nginx']['nginx']['x_forwarded_traffic']})",
  "Rewrite Wiki Alias          (#{node['bonusbits_mediawiki_nginx']['nginx']['rewrite_wiki_alias']})"
]
message_list.each do |message|
  Chef::Log.warn(message)
end
