template '/usr/bin/nodeinfo' do
  source 'nodeinfo.sh.erb'
  owner 'root'
  group 'root'
  mode '0755'
end
