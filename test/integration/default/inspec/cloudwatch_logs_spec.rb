require 'spec_helper'

describe 'bonusbits_mediawiki_nginx::cloudwatch_logs' do
  it 'AWS LOGS Package Installed' do
    expect(package('awslogs')).to be_installed
  end
  it 'Deploy awscli.conf' do
    expect(file('/etc/awslogs/awscli.conf')).to exist
  end
  it 'Deploy awslogs.conf' do
    expect(file('/etc/awslogs/awslogs.conf')).to exist
  end
  it 'AWS LOGS Service Enabled' do
    expect(service('awslogs')).to be_enabled
  end
  it 'AWS LOGS Service Running' do
    expect(service('awslogs')).to be_running
  end
end
