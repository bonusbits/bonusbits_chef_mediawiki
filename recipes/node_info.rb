template '/usr/local/bin/nodeinfo' do
  source 'node_info/nodeinfo.sh.erb'
  owner 'root'
  group 'root'
  mode '0755'
end
