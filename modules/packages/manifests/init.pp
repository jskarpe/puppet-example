# Class: packages
#
# This module manages packages:
# + mysql-server
# + mysql-client
# + openjdk-6-jre
# - sun-java6-jre
# + firefox-10.0.2
#
# == Author
#   Jon Skarpeteig <jon.skarpeteig@gmail.com>
#
class packages {
  # Install packages from repository
  case $::operatingsystem {
    ubuntu  : {
      package { 'mysql-server': ensure => 'latest' }

      package { 'mysql-client': ensure => 'latest' }

      package { 'openjdk-6-jre': ensure => 'latest' }

      package { 'sun-java6-jre':
        # To forcefully remove this, option 'purged' can be used,
        # but this would also remove dependencies
        ensure => 'absent'
      }

      case $::operatingsystemrelease {
        '10.04' : {
          package { 'firefox': ensure => '10.0.2+build1-0ubuntu0.10.04.1' }
        }
        '10.10' : {
          package { 'firefox': ensure => '10.0.2+build1-0ubuntu0.10.10.1' }
        }
        default : {
          fail("Unsupported ubuntu version: ${::operatingsystemrelease}")
        }
      }

      # Ideally, the 'held' keyword should be to hold packages,
      # but you can't specify both version and hold using package type
      exec { 'hold-firefox-version':
        command => 'apt-mark hold firefox',
        require => Package['firefox'],
      }
    }
    default : {
      fail("Unsupported operating system: ${::operatingsystem}")
    }
  }
}

