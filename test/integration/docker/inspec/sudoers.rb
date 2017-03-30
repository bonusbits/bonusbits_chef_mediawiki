describe 'Sudoers Config' do
  it 'has /usr/local/bin in sudoers secure path' do
    expect(file('/etc/sudoers').content).to match(%r{secure_path = /sbin:/bin:/usr/sbin:/usr/bin:/usr/local/bin$})
  end
end
