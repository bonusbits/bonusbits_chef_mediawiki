require_relative '../helpers/os_queries'

# Fetch Chef Node Attributes
node = node_attributes

control 'packages' do
  impact 1.0
  title ''

  packages_list = node['bonusbits_mediawiki']['packages']

  packages_list.each do |package|
    describe package(package) do
      it { should be_installed }
    end
  end
end
