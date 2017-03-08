memory_in_megabytes =
  case node['os']
  when /.*bsd/
    node['memory']['total'].to_i / 1024 / 1024
  when 'linux'
    node['memory']['total'][/\d*/].to_i / 1024
  when 'darwin'
    node['memory']['total'][/\d*/].to_i
  when 'windows', 'solaris', 'hpux', 'aix'
    node['memory']['total'][/\d*/].to_i / 1024
  end

default['bonusbits_mediawiki_nginx']['node_info'].tap do |node_info|
  node_info['deploy'] = true

  node_info['content'] = [
    '## NETWORK ##',
    "IP Address:           (#{node['ipaddress']})",
    "Hostname:             (#{node['hostname']})",
    "FQDN:                 (#{node['fqdn']})",
    '## AWS ##',
    "Instance ID:          (#{node['ec2']['instance_id']})",
    "Region:               (#{node['ec2']['placement_availability_zone'].slice(0..-2)})",
    "Availability Zone:    (#{node['ec2']['placement_availability_zone']})",
    "AMI ID:               (#{node['ec2']['ami_id']})",
    '## PLATFORM ##',
    "Platform:             (#{node['platform']})",
    "Platform Version:     (#{node['platform_version']})",
    "Platform Family:      (#{node['platform_family']})",
    '## HARDWARE ##',
    "CPU Count:            (#{node['cpu']['total']})",
    "Memory:               (#{memory_in_megabytes}MB)",
    '## CHEF ##',
    "Detected Environment: (#{node.run_state['detected_environment']})",
    "Chef Environment:     (#{node.environment})",
    "Chef Roles:           (#{node['roles']})",
    "Chef Recipes:         (#{node['recipes']})",
    # '## MEDIAWIKI ##',
    # "URL:                  (#{node['bonusbits_mediawiki_nginx']['mediawiki']['localsettings']['wgServer']})",
    # "Database:             (#{node['bonusbits_mediawiki_nginx']['mediawiki']['localsettings']['wgDBserver']})"
  ]
end
