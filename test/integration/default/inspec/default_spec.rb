require 'spec_helper'

describe 'bonusbits_mediawiki_nginx::default' do
  it 'Security Patch Cron Job Created' do
    have_entry(cron('0 0 * * * yum -y update --security')).with_user('root')
  end
end
