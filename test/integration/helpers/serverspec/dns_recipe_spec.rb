require 'spec_helper'

describe 'bonusbits_awsapi_proxy::dns' do
  it 'Deploy Update DNS Shell Script' do
    expect(file('/usr/sbin/update-dns')).to exist
  end
  it 'Ran Update DNS Shell Script' do
    expect(file('/opt/chef-repo/route53-upsert.json')).to exist
  end
end
