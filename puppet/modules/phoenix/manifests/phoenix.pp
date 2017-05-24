
class phoenix::phoenix {
  $erlang_solutions_link = 'http://packages.erlang-solutions.com/erlang-solutions-1.0-1.noarch.rpm'
  $elixir_link = 'https://github.com/elixir-lang/elixir/releases/download/v1.3.4/Precompiled.zip'
  $erlang_solutions_temp_path = '/tmp/erlang-solutions-1.0-1.noarch.rpm'
  $elixir_temp_path = '/usr/bin/elixir/Precompiled.zip'

  group { 'phoenix':
    ensure => 'present',
    gid    => '502',
  }

  user { 'phoenix':
    ensure => 'present',
    gid    => '502',
    home   => '/home/phoenix',
    shell  => '/bin/bash',
    uid    => '502',
    managehome => true
  }

  file { '/home/phoenix/.bash_profile':
    require => User['phoenix'],
    owner => 'phoenix',
    group => 'phoenix',
    source => 'puppet:///modules/phoenix/bash_profile.sh',
  }

  file { '/home/phoenix/.bashrc':
    require => User['phoenix'],
    owner => 'phoenix',
    group => 'phoenix',
    source => 'puppet:///modules/phoenix/bashrc.sh',
  }

  package { 'epel-release':
    ensure => present,
  }

  package { 'erlang-solutions':
    require => Exec['wgetting erlang-solutions'],
    provider => rpm,
    source => $erlang_solutions_temp_path,
    ensure => present
  }

  package { 'erlang':
    ensure => latest,
    require => Package['erlang-solutions']
  }

  package { 'unzip':
    ensure => latest,
  }

  package { 'wget':
    ensure => latest,
  }

  exec { 'wgetting erlang-solutions':
    require => Package['wget'],
    command => "/usr/bin/wget ${erlang_solutions_link} -O ${erlang_solutions_temp_path}",
    creates => $erlang_solutions_temp_path
  }

  file { '/usr/bin/elixir':
    ensure => 'directory'
  }

  exec { 'wgetting elixir':
    require => [File['/usr/bin/elixir'], Package['wget']],
    command => "/usr/bin/wget ${elixir_link} -O ${elixir_temp_path}",
    creates => $elixir_temp_path,
  }

  exec { "unzipping elixir":
    command => "/usr/bin/unzip ${elixir_temp_path} -d /usr/bin/elixir",
    require => [Exec['wgetting elixir'], Package['unzip']],
    creates => '/usr/bin/elixir/bin/elixir',
  }

  file { 'adding elixir environment':
    ensure => present,
    require => Exec["unzipping elixir"],
    path => '/etc/profile.d/elixir_env.sh',
    content => 'export PATH="$PATH:/usr/bin/elixir/bin:/usr/bin/node-v6.1.0-linux-x64/bin"',
  }

  exec {'install phoenix':
    require => [
      File['/home/phoenix/.bashrc'],
      File['/home/phoenix/.bash_profile'],
      User['phoenix'],
      Exec['unzipping elixir'],
      # Exec['install nvm'],
      # File['adding nvm environment']
    ],
    command => '/bin/bash --login -c "/usr/bin/elixir/bin/mix archive.install https://github.com/phoenixframework/archives/raw/master/phoenix_new.ez --force"',
    unless => '/usr/bin/elixir/bin/mix archive | /usr/bin/grep phoenix_new',
    environment => 'HOME=/home/phoenix',
    user => 'phoenix'
  }

  class { '::nodejs':
    manage_package_repo       => false,
    nodejs_dev_package_ensure => 'present',
    npm_package_ensure        => 'present',
  }

  package { 'inotify-tools':
    ensure => latest
  }

  #
  # package { 'postgresql-contrib':
  #   ensure => latest
  # }

  # exec {'build phoenix':
  #   require => [
  #     Exec['unzipping elixir'],
  #   ],
  #   cwd     => '/var/app_name',
  #   command => '/bin/bash --login -c "mix local.hex --force"',
  #   unless => '/usr/bin/elixir/bin/mix archive | /usr/bin/grep phoenix_new',
  #   environment => 'HOME=/home/phoenix',
  #   user => 'phoenix'
  # }

  file { '/etc/systemd/system/app_name.service':
    ensure  => present,
    source  => 'puppet:///modules/phoenix/app_name.service'
  }

  service { 'app_name':
    require => File['/etc/systemd/system/app_name.service'],
    enable => true
  }

  file { '/etc/systemd/system/build_app_name.service':
    ensure  => present,
    source  => 'puppet:///modules/phoenix/build_app_name.service'
  }

  service { 'build_app_name':
    require => File['/etc/systemd/system/build_app_name.service'],
    enable => true
  }
}
