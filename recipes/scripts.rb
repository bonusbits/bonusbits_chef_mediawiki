# Deploy Wiki Profile Script
template '/etc/profile.d/wiki_aliases.sh' do
  source 'scripts/wiki_aliases.sh.erb'
  owner 'root'
  group 'root'
  mode '0644'
end
