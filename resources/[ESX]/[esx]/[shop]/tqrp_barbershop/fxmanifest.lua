fx_version 'adamant'

game 'gta5'

description 'ESX BarberShop'

version '1.0.1'

server_scripts {
    '@mysql-async/lib/MySQL.lua',
    '@es_extended/locale.lua',
    'locales/br.lua',
    'locales/de.lua',
    'locales/en.lua',
    'locales/fi.lua',
    'locales/fr.lua',
    'locales/es.lua',
    'locales/pl.lua',
    'config.lua',
    'server/main.lua'
}

client_scripts {
    '@es_extended/locale.lua',
    'locales/br.lua',
    'locales/de.lua',
    'locales/en.lua',
    'locales/fi.lua',
    'locales/fr.lua',
    'locales/es.lua',
    'locales/pl.lua',
    'config.lua',
    'client/main.lua'
}
