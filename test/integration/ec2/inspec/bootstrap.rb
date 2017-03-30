chef_client_version = '12.18.31'

describe 'Bootstrap Setup' do
  it "chef client version: #{chef_client_version}" do
    expect(command('knife -v').stdout).to include(chef_client_version)
  end
end
