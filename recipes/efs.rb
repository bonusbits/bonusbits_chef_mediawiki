# Ensure NFS Utils Installed
package 'nfs-utils'

if node['bonusbits_base']['aws']['inside']
  # Create Mount Directory
  efs_mount_point = node['bonusbits_mediawiki_nginx']['mediawiki']['uploads_path']
  directory efs_mount_point do
    owner node['bonusbits_mediawiki_nginx']['nginx']['user']
    group node['bonusbits_mediawiki_nginx']['nginx']['group']
    mode '0755'
    recursive true
  end

  # Mount Upload Share
  efs_filesystem_id = node['bonusbits_mediawiki_nginx']['efs']['filesystem_id']
  region = node['ec2']['placement_availability_zone'].slice(0..-2)

  mount efs_mount_point do
    device "#{efs_filesystem_id}.efs.#{region}.amazonaws.com:/"
    fstype 'nfs4'
    options 'nfsvers=4.1,rsize=1048576,wsize=1048576,hard,timeo=600,retrans=2'
    action [:mount, :enable]
  end
end
