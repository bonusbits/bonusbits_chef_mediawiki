require 'spec_helper'

web_package_list = %w(
  apr
  apr-util
  enchant
  git
  ImageMagick
  json-c
  mysql56
  nginx
  openssl
  openssl-devel
  pcre
  perl-core perl-CPAN
  perl-Crypt-SSLeay
  perl-DateTime
  perl-libwww-perl
  perl-Sys-Syslog
  php70-cli
  php70-common
  php70-enchant
  php70-fpm
  php70-intl
  php70-mbstring
  php70-mcrypt
  php70-mysqlnd
  php70-pdo
  php70-pecl-apcu
  php70-pecl-imagick
  php70-process
  php70-xml
  texlive
)

other_package_list = %w(
  htop
  mlocate
  vim
)

describe 'bonusbits_mediawiki_nginx::packages' do
  it 'Web Packages Installed' do
    web_package_list.each do |package|
      expect(package(package)).to be_installed
    end
  end
  it 'Other Packages Installed' do
    other_package_list.each do |package|
      expect(package(package)).to be_installed
    end
  end
end
