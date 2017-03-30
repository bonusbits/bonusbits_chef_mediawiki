describe 'CloudWatch Logs' do
  it 'awslogs installed' do
    expect(package('awslogs')).to be_installed
  end

  it 'has awscli.conf' do
    expect(file('/etc/awslogs/awscli.conf')).to exist
    expect(file('/etc/awslogs/awscli.conf')).to be_owned_by('root')
  end

  it 'has awslogs.conf' do
    expect(file('/etc/awslogs/awslogs.conf')).to exist
    expect(file('/etc/awslogs/awslogs.conf')).to be_owned_by('root')
  end

  # it 'awslogs service' do
  #   expect(service('awslogs')).to be_enabled
  #   expect(service('awslogs')).to be_running
  # end
end
