def node_attributes
  # Can only be called from control not in helpers

  # This will not work because it will be ran locally and not on the test instance
  # require 'json'
  # JSON.parse(File.read('/etc/chef/.chef-attributes.json'))

  # json is an Inspec Resource so it looks on the instance and not locally
  # Must be called from inspec control
  json('/etc/chef/.chef-attributes.json').params
end

def dev?
  node_attributes['bonusbits_base']['deployment_environment'] == 'dev'
end

def kitchen?
  node_attributes['bonusbits_base']['deployment_method'] == 'kitchen'
end

def base_node_values
  # Can only be called from control not in helpers
  node_attributes['bonusbits_base']
end

def prod?
  node_attributes['bonusbits_base']['deployment_environment'] == 'prod'
end

def install_java?
  node_attributes['bonusbits_base']['java']['install']
end

def proxy_settings
  node = node_attributes

  results = Hash.new
  results['http_proxy'] = node['bonusbits_base']['proxy']['host_port_url']
  results['https_proxy'] = node['bonusbits_base']['proxy']['host_port_url']
  results['no_proxy'] = node['bonusbits_base']['proxy']['no_proxy']
  results
end

def proxy_shell_script_content
  node = node_attributes
  %W[
    http_proxy=#{node['bonusbits_base']['proxy']['host_port_url']}
    https_proxy=#{node['bonusbits_base']['proxy']['host_port_url']}
    no_proxy=#{node['bonusbits_base']['proxy']['no_proxy']}
  ]
end

def server_role
  node_attributes['bonusbits_base']['role']
end

def qa?
  node_attributes['bonusbits_base']['deployment_environment'] == 'qa'
end
