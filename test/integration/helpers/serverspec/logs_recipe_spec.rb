require 'spec_helper'

describe 'bonusbits_awsapi_proxy::logs' do
  it 'AWS LOGS Package Installed' do
    expect(package('awslogs')).to be_installed
  end
  it 'Deploy awscli.conf' do
    expect(file('/etc/awslogs/awscli.conf')).to exist
  end
  it 'Deploy awslogs.conf' do
    expect(file('/etc/awslogs/awslogs.conf')).to exist
  end
  it 'Deploy publish-squid-metrics' do
    expect(file('/usr/sbin/publish-squid-metrics')).to exist
  end
  it 'Rotate Squid Logs Cron Job' do
    have_entry(cron('0 0 * * * squid -k rotate')).with_user('root')
  end
  it 'Publish Metrics Cron Job' do
    have_entry(cron('*/5 * * * * bash /usr/sbin/publish-squid-metrics')).with_user('root')
  end
  it 'AWS LOGS Service Enabled' do
    expect(service('awslogs')).to be_enabled
  end
  it 'AWS LOGS Service Running' do
    expect(service('awslogs')).to be_running
  end
end
