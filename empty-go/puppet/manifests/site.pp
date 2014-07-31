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

package { 'ruby1.9.3':
	ensure		=>	present,
}

package { 'make':
	ensure		=>	present,
}

package { 'go-server' :
	provider	=>	'dpkg',
	source		=>	'/vagrant/go-server-14.2.0-377.deb',
	ensure		=>	'present',
}

package { 'go-agent' :
	provider	=>	'dpkg',
	source		=>	'/vagrant/go-agent-14.2.0-377.deb',
	ensure		=>	'present',
}

package { 'rake' :
	ensure		=>	'present',
	provider	=>	'gem',
}

package { 'rails' :
	ensure		=>	'present',
	provider	=>	'gem',
}

Exec['apt-get update'] -> 
	Package['default-jre-headless'] -> 
	Package['unzip'] -> 
	Package['ruby1.9.3'] -> 
	Package['make'] -> 
	Package['rails'] -> 
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
