node 'basenode' {
	include agent include timezone::utc

	# Install packages from repository
	case $::operatingsystem {
		ubuntu : {
			package {
				'mysql-server' :
					ensure => 'latest'
			}
			package {
				'mysql-client' :
					ensure => 'latest'
			}
			package {
				'openjdk-6-jre' :
					ensure => 'latest'
			}
			package {
				'openjdk-6-jre' :
					ensure => 'latest'
			}
			package {
				'sun-java6-jre' :
				# To forcefully remove this, option 'purged' can be used, 
				# but this would also remove dependencies
					ensure => 'absent'
			}
			case $::operatingsystemrelease {
				'10.04' : {
					package {
						'firefox' :
							ensure => '10.0.2+build1-0ubuntu0.10.04.1'
					}
				}
				'10.10' : {
					package {
						'firefox' :
							ensure => '10.0.2+build1-0ubuntu0.10.10.1'
					}
				}
				default : {
					fail("Unsupported ubuntu version: $::operatingsystemrelease")
				}
			}

			# Ideally, the 'held' keyword should be to hold packages, 
			# but you can't specify both version and hold using package type		
			exec {
				'hold-firefox-version' :
					command => 'apt-mark hold firefox',
					require => Package['firefox'],
			}
		}
		default : {
			fail("Unsupported operating system: $::operatingsystem")
		}
	}
}

# Special nodes with backups enabled 
# FQDN not really needed, but can be added as appropriate
node /^special\d+/ inherits 'basenode' {
	filebucket {
		'main' :
			server => puppetmaster,
			path => false
			# Manual states that due to a known issue, path must be set to false for remote filebuckets.

	}

	# Specify it as the default target
	File {
		backup => main
	}
}

# Any node not special
node /^((?!special\d+).)*$/ inherits 'basenode' {
}
