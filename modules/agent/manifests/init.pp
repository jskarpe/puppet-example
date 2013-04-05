# Class: agent
#
# This module manages agent
#
# == Actions
#
#
# == Examples
#
# You can use this class in 2 ways:
# - Set variables (at top scope level) and "include agent"
# - Call agent as a parametrized class
#
# == Author
#   Jon Skarpeteig <jon.skarpeteig@gmail.com>
#
class agent {
# Agent install
	service {
		'agent' :
			ensure => running,
			name => 'agent',
			require => [File['agent.init'], File['agent']],
	}
	file {
		'agent.init' :
			source => 'puppet:///agent/agent.init',
			target => '/etc/init.d/agent.init',
			owner => 'root',
			group => 'root',
			mode => 0755,
			notify => Service['agent']
	}
	file {
		'agent' :
			source => 'puppet:///agent/agent',
			target => '/usr/local/bin/agent',
			owner => 'root',
			group => 'root',
			mode => 0755,
			notify => Service['agent']
	}
}
