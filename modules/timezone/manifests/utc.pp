# Class: timezone::utc
#
# This class sets timezone to UTC
class timezone::utc inherits timezone {
    file { "/etc/localtime":
        require => Package["tzdata"],
        source => "file:///usr/share/zoneinfo/UTC",
    }
}
