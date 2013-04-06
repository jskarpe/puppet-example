# Class: agent
#
# This module manages agent
#
# == Author
#   Jon Skarpeteig <jon.skarpeteig@gmail.com>
#
class agent {
  # Prerequisite - set timezone
  include timezone::utc

  # Agent install
  service { 'agent':
    ensure   => running,
    name     => 'agent.init',
    provider => 'debian',
    require  => [File['agent.init'], File['agent'], File['/etc/localtime']],
  }

  file { 'agent.init':
    source => 'puppet:///agent/agent.init',
    target => '/etc/init.d/agent.init',
    owner  => 'root',
    group  => 'root',
    mode   => '0755',
    notify => Service['agent']
  }

  file { 'agent':
    source => 'puppet:///agent/agent',
    target => '/usr/local/bin/agent',
    owner  => 'root',
    group  => 'root',
    mode   => '0755',
    notify => Service['agent']
  }
}
