fx_version 'cerulean'

games {'gta5' }

lua54 'yes'


shared_scripts {
	'@es_extended/imports.lua',

	'@ox_lib/init.lua',

	'config.lua'
}

server_script {

	'server/*.lua'

}

client_script {

	'client/*.lua'

}


files {

    'locales/*.json'
	
}