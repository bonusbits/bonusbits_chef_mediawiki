# Data Bags
default['bonusbits_mediawiki_nginx']['data_bag'] = 'bonusbits_mediawiki_nginx'
default['bonusbits_mediawiki_nginx']['data_bag_item'] = 'example_databag_item'

# Debug
message_list = [
  '',
  '** Default **',
  "Data Bag                    (#{node['bonusbits_mediawiki_nginx']['data_bag']})",
  "Data Bag Item               (#{node['bonusbits_mediawiki_nginx']['data_bag_item']})"
]
message_list.each do |message|
  Chef::Log.warn(message)
end
