class platform::base {
  include '::ruby'

  file { '/root/.ssh/authorized_keys':
    require => File['/root/.ssh/'],
    ensure  => present,
    mode    => '600',
    source  => 'puppet:///modules/platform/authorized_keys'
  }

  package { 'openssh-server':
    ensure => latest,
  }

  # ensure rvm doesn't timeout finding binary rubies
  # the umask line is the default content when installing rvm if file does not exist
  file { '/root/rvmrc':
    content => 'umask u=rwx,g=rwx,o=rx
                export rvm_max_time_flag=20',
    mode    => '0664',
    before  => Class['rvm'],
  }

  class { '::rvm': }

  rvm_system_ruby {
    'ruby-2.3.1':
      ensure      => 'present',
      default_use => true
  }

  file { '/root/.ssh/':
      ensure => 'directory',
  }

  package { 'mysql-devel':
    ensure => latest,
  }

  package { 'cmake':
    ensure => latest,
  }

  include '::codedeploy'
}
