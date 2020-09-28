fx_version "adamant"
game "gta5"

client_script {
	'@es_extended/locale.lua',
	'client/client.lua',
	'locales/*lua'
}

shared_script {
    'config.lua'
}

server_script {
	'@es_extended/locale.lua',
	'server/server.lua',
	'locales/*lua'
}