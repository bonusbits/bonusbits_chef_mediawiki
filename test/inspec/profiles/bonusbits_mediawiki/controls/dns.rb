require_relative '../helpers/os_queries'

inside_aws = aws?

control 'dns' do
  impact 1.0
  title ''

  describe file('/usr/sbin/update-dns') do
    it { should exist }
    it { should be_file }
    it { should be_owned_by 'root' }
    it { should be_grouped_into 'root' }
    its(:mode) { should cmp '00755' }
  end

  if inside_aws
    describe file('/tmp/route53-upsert.json') do
      it { should exist }
      it { should be_file }
      it { should be_owned_by 'root' }
      it { should be_grouped_into 'root' }
      its(:mode) { should cmp '00755' }
    end
  end
end
