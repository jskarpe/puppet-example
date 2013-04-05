# Class: timezone
#
# This module manages timezone
class timezone {
    package { "tzdata":
        ensure => installed
    }
}

