# os helpers beyond built-in methods

def rhel_family?
  %w(redhat amazon).include?(os[:family])
end

def debian_family?
  %w(debian ubuntu).include?(os[:family])
end

def amazon?
  os[:family] == 'amazon'
end

def ubuntu?
  %w(ubuntu).include?(os[:family])
end

def rhel6?
  redhat? && os[:release].to_f.between?(6.0, 6.9)
end

def rhel7?
  redhat? && os[:release].to_f.between?(7.0, 7.9)
end

def ubuntu1404?
  ubuntu? && release?('14.04')
end

def ubuntu1604?
  ubuntu? && release?('16.04')
end

def release?(test_version)
  os[:release] == test_version
end

def docker?
  File.exist?('/.dockerenv')
end
