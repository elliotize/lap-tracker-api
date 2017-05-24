class platform::general {
  include '::ruby'
  include '::codedeploy'

  package { 'dejavu-lgc-sans-fonts':
    ensure => installed,
  }
  package { 'openssh-server':
    ensure => installed,
  }
  package { 'xauth':
    ensure => installed,
  }
  file { '/root/.ssh/':
      ensure => 'directory',
  }
  file { '/root/.ssh/authorized_keys':
    require => File['/root/.ssh/'],
    ensure  => present,
    mode    => '600',
    source  => 'puppet:///modules/platform/authorized_keys'
  }
}
