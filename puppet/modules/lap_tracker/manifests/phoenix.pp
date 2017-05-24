
class phoenix::phoenix {

  file { '/etc/systemd/system/lap-tracker.service':
    ensure  => present,
    source  => 'puppet:///modules/phoenix/app_name.service'
  }

  file { '/etc/systemd/system/lap-tracker.service.d':
    ensure  => directory,
    source  => 'puppet:///modules/phoenix/app_name.service'
  }

  service { 'lap-tracker':
    require => File['/etc/systemd/system/app_name.service'],
    enable => true
  }
}
