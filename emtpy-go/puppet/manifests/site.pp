exec { 'apt-get update':
	command		=>	'/usr/bin/apt-get update'
}

package { 'openjdk':
	name		=>	'openjdk-7-jdk',
	ensure		=>	present,
}

package { 'unzip':
	name		=>	'unzip',
	ensure		=>	present,
}

exec { 'get go-server':
	command		=>	'/usr/bin/wget -nc http://dl.bintray.com/gocd/gocd-deb/go-server-14.2.0-377.deb'
}

package { 'go-server' :
	name		=>	'go-server',
	provider	=>	'dpkg',
	source		=>	'go-server-14.2.0-377.deb',
	ensure		=>	'present',
}


exec { 'get go-agent':
	command		=>	'/usr/bin/wget -nc http://dl.bintray.com/gocd/gocd-deb/go-agent-14.2.0-377.deb'
}

package { 'go-agent' :
	name		=>	'go-agent',
	provider	=>	'dpkg',
	source		=>	'go-agent-14.2.0-377.deb',
	ensure		=>	'present',
}

Exec['apt-get update'] -> Package['openjdk'] -> Package['unzip'] -> Exec['get go-server'] -> Exec['get go-agent'] -> Package['go-server'] -> Package['go-agent']

service { 'go-server' :
	ensure		=>	'running'
}
	
service { 'go-agent' :
	ensure		=>	'running'
}
