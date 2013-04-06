node 'basenode' {
	include timezone::utc
	include agent
	include packages 
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
