# Class: timezone
#
# This module manages timezone
#
# == Author
#   Jon Skarpeteig <jon.skarpeteig@gmail.com>
#
class timezone {
    package { 'tzdata':
        ensure => installed
    }
}

