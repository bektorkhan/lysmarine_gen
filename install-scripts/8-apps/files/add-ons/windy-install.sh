#!/bin/bash -e

bash -c 'cat << EOF > /usr/local/share/applications/windy.desktop
[Desktop Entry]
Type=Application
Name=Windy
GenericName=Windy
Comment=Windy
Exec=gnome-www-browser https://www.windy.com/
Terminal=false
Icon=weather-windy-symbolic
Categories=Network;
EOF'

