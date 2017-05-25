class lap_tracker::service {
  file { '/etc/systemd/system/lap-tracker.service':
    ensure  => present,
    source  => 'puppet:///lap-tracker.service'
  }

  file { '/etc/systemd/system/lap-tracker.service.d':
    ensure  => directory,
  }

  service { 'lap-tracker':
    require => File['/etc/systemd/system/lap-tracker.service'],
    enable => true
  }
}
