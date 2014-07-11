exec { 'apt-get update':
	command		=>	'/usr/bin/apt-get update'
}

package { 'openjdk':
	name		=>	'openjdk-7-jdk',
	ensure		=>	present,
	require		=>	Exec['apt-get update'],
	require		=>	Package['unzip'],
}

package { 'unzip':
	name		=>	'unzip',
	ensure		=>	present,
	require		=>	Exec['apt-get update'],
}

exec { 'get go-server':
	command		=>	'/usr/bin/wget -nc http://dl.bintray.com/gocd/gocd-deb/go-server-14.2.0-377.deb'
}

package { 'go-server' :
	name		=>	'go-server',
	provider	=>	'dpkg',
	source		=>	'go-server-14.2.0-377.deb',
	ensure		=>	'present',
	require		=>	Exec['get go-server'],
	require		=>	Package['openjdk'],
}


exec { 'get go-agent':
	command		=>	'/usr/bin/wget -nc http://dl.bintray.com/gocd/gocd-deb/go-agent-14.2.0-377.deb'
}

package { 'go-agent' :
	name		=>	'go-agent',
	provider	=>	'dpkg',
	source		=>	'go-agent-14.2.0-377.deb',
	ensure		=>	'present',
	require		=>	Exec['get go-agent'],
	require		=>	Package['openjdk'],
}

