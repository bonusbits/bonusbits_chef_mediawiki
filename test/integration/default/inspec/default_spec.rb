require 'spec_helper'

describe 'bonusbits_mediawiki_nginx::default' do
  it 'Include CloudWatch Logs Recipe' do
    have_entry(cron('0 0 * * * yum -y update --security')).with_user('root')
  end
end
