# Class: timezone::gmt
#
# This class sets timezone to GMT
class timezone::gmt inherits timezone {
  file { '/etc/localtime':
    require => Package['tzdata'],
    source  => 'file:///usr/share/zoneinfo/GMT',
  }
}
