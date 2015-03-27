exec { 'apt-get update':
	command		=>	'/usr/bin/apt-get update'
}

package { 'default-jre-headless':
	name		=>	'default-jre-headless',
	ensure		=>	present,
}

package { 'unzip':
	ensure		=>	present,
}

package { 'patch':
	ensure		=>	present,
}

package { 'make':
	ensure		=>	present,
}

package { 'go-server' :
	provider	=>	'dpkg',
	source		=>	'/vagrant/go-server-14.4.0-1356.deb',
	ensure		=>	'present',
}

package { 'go-agent' :
	provider	=>	'dpkg',
	source		=>	'/vagrant/go-agent-14.4.0-1356.deb',
	ensure		=>	'present',
}

package { 'rake' :
	ensure		=>	'present',
	provider	=>	'gem',
}

Exec['apt-get update'] -> 
	Package['default-jre-headless'] -> 
	Package['unzip'] -> 
	Package['make'] -> 
	Package['patch'] -> 
	Package['rake'] -> 
	Package['go-server'] -> 
	Package['go-agent'] -> 
	Service['go-server'] -> 
	Service['go-agent']

service { 'go-server' :
	ensure		=>	'running'
}
	
service { 'go-agent' :
	ensure		=>	'running'
}
