

bucket_name = node['bonusbits_mediawiki_nginx']['s3']['deploy_bucket_name']
download_filename = node['bonusbits_mediawiki_nginx']['web_content']['download_filename']
local_download_path = node['bonusbits_mediawiki_nginx']['local_donwload_path']

unless ::File.exist?("#{local_download_path}/#{download_filename}")
  # Download Mediawiki Tar
  ruby_block 'Download Mediawiki Tar' do
    block do
      require 'open3'
      bash_command = "aws s3 cp s3://#{bucket_name}/web_content/#{download_filename} #{local_download_path}/#{download_filename} --sse"
      BonusBits::Output.report("Open3 BASH Command (#{bash_command})")

      # Run Bash Script and Capture StrOut, StrErr, and Status
      out, err, status = Open3.capture3(bash_command)
      BonusBits::Output.report("Open3 Status (#{status})")
      BonusBits::Output.report("Open3 Standard Out (#{out})")
      BonusBits::Output.report("Open3 Error Out (#{err})")
      raise 'Failed!' unless status.success?
    end
    action :run
  end

  # Extract Web Content
  ruby_block 'Extract Mediawiki Tar' do
    block do
      require 'open3'
      bash_command = "tar -zxvf #{local_download_path}/#{download_filename} -C /"
      BonusBits::Output.report("Open3 BASH Command (#{bash_command})")

      # Run Bash Script and Capture StrOut, StrErr, and Status
      out, err, status = Open3.capture3(bash_command)
      BonusBits::Output.report("Open3 Status (#{status})")
      BonusBits::Output.report("Open3 Standard Out (#{out})")
      BonusBits::Output.report("Open3 Error Out (#{err})")
      raise 'Failed!' unless status.success?
    end
    action :run
    notifies :restart, 'service[apache]', :delayed
    # TODO: Add restart only on change condition check
  end
end

# Deploy LocalSettings.php
template '/var/www/html/mediawiki/LocalSettings.php' do
  source 'LocalSettings.php.erb'
  owner node['bonusbits_mediawiki_nginx']['user']
  group node['bonusbits_mediawiki_nginx']['group']
  mode '0644'
  notifies :restart, 'service[apache]', :delayed
  only_if { node['bonusbits_mediawiki_nginx']['mediawiki']['localsettings']['configure'] }
end
