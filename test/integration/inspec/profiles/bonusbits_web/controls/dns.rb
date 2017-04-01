inside_aws = attribute('inside_aws', default: false, description: 'Inside AWS')
role = attribute('role', default: 'web', description: 'Server Role')

if role == 'web'
  describe 'DNS Update' do
    it 'has /usr/sbin/update-dns' do
      expect(file('/usr/sbin/update-dns')).to exist
    end

    if inside_aws
      it 'has /tmp/route53-upsert.json (Ran DNS Update)' do
        expect(file('/tmp/route53-upsert.json')).to exist
      end
    end
  end
end
