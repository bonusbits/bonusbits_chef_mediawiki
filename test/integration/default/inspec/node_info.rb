describe 'Nodeinfo Script' do
  it 'has /usr/bin/nodeinfo' do
    expect(file('/usr/bin/nodeinfo')).to exist
  end
end
