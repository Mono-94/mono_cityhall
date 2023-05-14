fx_version 'cerulean'
game 'gta5' 
lua54 'yes'


version 		'1.0.2'

client_scripts{
    '@es_extended/locale.lua',
    'client.lua'
} 
server_scripts{
    'server.lua'
} 
shared_script {
    'config.lua',
    '@ox_lib/init.lua',
}

files {
    'locales/*.json',
    'html/*.html',
    'html/apps/*.html',
    'html/css/*.css',
    'html/apps/css/*.css',
    'html/js/*.js',
    'html/img/*.png',
}

ui_page {
 'html/index.html', 
}