resource_manifest_version '44febabe-d386-4d18-afbe-5e627f4af937'


client_scripts {
	'NativeUI.lua',
	'Config.lua',
	'Client/*.lua'
}

server_scripts {
	'Config.lua',
	'@mysql-async/lib/MySQL.lua',
	'Server/*.lua'
}

exports {
	'GetPlayerWalkStyle'
}
