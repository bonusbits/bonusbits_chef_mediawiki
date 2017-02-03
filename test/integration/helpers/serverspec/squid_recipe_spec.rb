require 'spec_helper'

package_list = %w(
  squid
  libtool-ltdl
)

describe 'bonusbits_awsapi_proxy::squid' do
  it 'Download Directory Created' do
    expect(file('/opt/chef-repo/downloads')).to be_directory
  end
  it 'Squid Packages Installed' do
    package_list.each do |package|
      expect(package(package)).to be_installed
    end
  end
  it 'Squid Cache Directories Created' do
    expect(file('/var/spool/squid/00')).to be_directory
  end
  it 'Deployed Squid Config' do
    expect(file('/etc/squid/squid.conf')).to exist
  end
  it 'Squid Service Enabled' do
    expect(service('squid')).to be_enabled
  end
  it 'Squid Service Running' do
    expect(service('squid')).to be_running
  end
end
