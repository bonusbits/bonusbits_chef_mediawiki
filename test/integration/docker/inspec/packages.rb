package_list = %w(
  apr
  apr-util
  enchant
  git
  htop
  ImageMagick
  json-c
  mlocate
  mysql56
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
  vim-enhanced
)

describe 'Packages Install' do
  it 'package list' do
    package_list.each do |package|
      expect(package(package)).to be_installed
    end
  end
end
