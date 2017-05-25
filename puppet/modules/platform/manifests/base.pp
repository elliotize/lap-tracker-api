class platform::base {
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
    'ruby-2.4.1':
      ensure      => 'present',
      default_use => true
  }

  # This was a quick hack because why install two versions
  # of ruby when we can just link.
  exec { 'link ruby library':
    command => "/usr/bin/ln -sfn /usr/local/rvm/rubies/ruby-2.3.1/bin/ruby /usr/bin/ruby"
  }

  include '::codedeploy'

  file { '/root/.ssh/':
      ensure => 'directory',
  }
}
