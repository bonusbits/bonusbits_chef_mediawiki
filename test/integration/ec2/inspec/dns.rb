describe 'DNS Update' do
  it 'has /usr/sbin/update-dns' do
    expect(file('/usr/sbin/update-dns')).to exist
  end

  it 'has /tmp/route53-upsert.json' do
    expect(file('/tmp/route53-upsert.json')).to exist
  end
end
