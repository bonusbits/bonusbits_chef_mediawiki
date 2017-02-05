require 'spec_helper'

describe 'bonusbits_mediawiki_nginx::default' do
  linux_platform_list = {
      Amazon: '2016.03',
      CentOS: '7.2.1511',
      Redhat: '7.1',
      Ubuntu: '16.04'
  }

  linux_platform_list.each do |platform, version|
    plat = platform.to_s
    context "#{plat} #{version}" do
      let(:chef_run) do
        runner = ChefSpec::ServerRunner.new(
            platform: plat.downcase,
            version: version
        )
        runner.converge(described_recipe)
      end

      it 'should include bonusbits_mediawiki_nginx::packages recipe' do
        expect(chef_run).to include_recipe('bonusbits_mediawiki_nginx::packages')
      end
    end
  end
end
