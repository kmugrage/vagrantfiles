exec { 'apt-get update':
	command => '/usr/bin/apt-get update';
}

package {'ruby1.9.3' :
	ensure 	=>	'installed',
	require	=>	Exec['apt-get update'],
	before	=>	Package['jekyll'],
}

package {'git' :
	ensure	=>	'latest',
	require	=>	Exec['apt-get update'],
}

package {'make' :
	ensure	=>	'latest',
	require	=>	Exec['apt-get update'],
}

package {'jekyll' :
	ensure	=> 	'latest',
	provider => 	'gem',
}
