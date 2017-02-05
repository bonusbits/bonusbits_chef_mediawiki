# Determine Environment
run_state['detected_environment'] =
  if /dev|qa|stg|prd/ =~ node['chef_environment']
    /dev|qa|stg|prd/.match(node['chef_environment']).to_s.downcase
  else
    # Consider _default as 'Dev'
    'dev'
  end

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

default['bonusbits_mediawiki_nginx'].tap do |root|
  # Paths
  root['local_download_path'] = '/opt/chef-repo/downloads'

  # UID
  root['user'] = 'nginx'
  root['group'] = 'nginx'

  # NodeInfo Script
  root['nodeinfo_script']['deploy'] = true

  root['nodeinfo_script']['content'] = [
    '## Local ##',
    "IP Address:           (#{node['ipaddress']})",
    "Hostname:             (#{node['hostname']})",
    "FQDN:                 (#{node['fqdn']})",
    '',
    '## AWS ##',
    "Instance ID:          (#{node['ec2']['instance_id']})",
    "Region:               (#{node['ec2']['placement_availability_zone'].slice(0..-2)})",
    "Availability Zone:    (#{node['ec2']['placement_availability_zone']})",
    "AMI ID:               (#{node['ec2']['ami_id']})",
    '',
    '## HARDWARE ##',
    "Platform:             (#{node['platform']})",
    "Platform Version:     (#{node['platform_version']})",
    "Platform Family:      (#{node['platform_family']})",
    "CPU Count:            (#{node['cpu']['total']})",
    "Memory:               (#{memory_in_megabytes}MB)",
    '',
    '## CHEF ##',
    "Detected Environment: (#{node.run_state['detected_environment']})",
    "Chef Environment:     (#{node.environment})",
    "Chef Roles:           (#{node['roles']})",
    "Chef Recipes:         (#{node['recipes']})"
  ]
end
