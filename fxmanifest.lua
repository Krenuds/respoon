fx_version 'cerulean'
game 'gta5'
lua54 'yes'

name 'respoon'
author 'Respoon'
description 'Networked Scene Editor for FiveM'
version '0.06'

client_scripts {
    'dist/client.js',
}

server_scripts {
    'dist/server.js',
}

ui_page 'web/build/index.html'

files {
    'web/build/index.html',
    'web/build/**/*',
    'data/*.sql',
}
