class platform::docker{
  exec { 'set locale':
    command => "/usr/bin/localedef -i en_US -f UTF-8 en_US.UTF-8",
  }
  package { 'sudo':
    ensure => 'installed',
  }
  package { 'initscripts':
    ensure => 'installed'
  }
  package { 'which':
    ensure => 'installed',
  }
}
