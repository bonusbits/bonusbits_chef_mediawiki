require_relative 'node_attributes'

def amazon_linux?
  os[:name] == 'amazon'
end

def amazon_linux1?
  os[:release] == '2018.03'
end

def amazon_linux2?
  os[:release] == '2'
end

def aws?
  ec2?
end

def debian_family?
  %w[debian ubuntu].include?(os[:family])
end

def docker?
  # File.exist?('/.dockerenv') || File.readlines('/proc/self/cgroup').grep(/docker/).any?
  node_attributes['bonusbits_base']['deployment_type'] == 'docker'
end

def ec2?
  # File.directory?('/home/ec2-user')
  node_attributes['bonusbits_base']['deployment_type'] == 'ec2'
end

def release?(test_version)
  os[:release] == test_version
end

def redhat?
  os[:name] == 'redhat'
end

def rhel_family?
  %w[redhat amazon].include?(os[:family])
end

def rhel6?
  redhat? && os[:release].to_f.between?(6.0, 6.9)
end

def rhel7?
  redhat? && os[:release].to_f.between?(7.0, 7.9)
end

def ubuntu?
  %w[ubuntu].include?(os[:family])
end

def ubuntu1404?
  ubuntu? && release?('14.04')
end

def ubuntu1604?
  ubuntu? && release?('16.04')
end

def ubuntu1804?
  ubuntu? && release?('18.04')
end
