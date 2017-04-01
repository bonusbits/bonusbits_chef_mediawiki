default['bonusbits_mediawik_nginx']['packages']['web'] = %w(
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

# TODO: Check list on EC2 and make sure all needed in list for Docker
default['bonusbits_mediawik_nginx']['packages']['base_packages'] = %w(
  aws-cli
  ca-certificates
  curl
  git
  gzip
  htop
  mlocate
  net-tools
  openssh-clients
  openssh-server
  openssl
  passwd
  procps
  sudo
  upstart
  util-linux
  vim-enhanced
  which
)
