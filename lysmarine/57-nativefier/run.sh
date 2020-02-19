#!/bin/bash

apt-get -y -q install nodejs libnss3 gnome-icon-theme
npm install nativefier -g --unsafe-perm

install -d -o 1000 -g 1000 "/home/user/.local/share/icons"
install -v -o 1000 -g 1000 -m 644 $FILE_FOLDER/freeboard-sk.png "/home/user/.local/share/icons/freeboard-sk.png"
install -v -o 1000 -g 1000 -m 644 $FILE_FOLDER/signalk.png "/home/user/.local/share/icons/"

if [ $LMBUILD == raspbian ] ;then
	arch=armv7l
fi

if [ $LMBUILD == armbian-pineA64 ] ;then
	arch=arm64
fi

if [ $LMBUILD == debian-vbox ] ;then
	arch=x64
fi

nativefier -a $arch --disable-context-menu --disable-dev-tools --single-instance \
--name "SignalK"   --icon /home/user/.local/share/icons/signalk.png \
"http://localhost:80" /opt/

nativefier -a $arch --disable-context-menu --disable-dev-tools --single-instance \
--name "Freeboard-sk" --icon /home/user/.local/share/icons/freeboard-sk.png \
"http://localhost/@signalk/freeboard-sk/" /opt/

nativefier -a $arch --disable-context-menu --disable-dev-tools --single-instance \
--name "SpeedSample" --icon /usr/share/icons/gnome/256x256/apps/utilities-system-monitor.png \
"http://localhost:4998" /opt/

echo "setTheme('dark')" > ./pypilot_darktheme.js
nativefier -a $arch --inject ./pypilot_darktheme.js --disable-context-menu --disable-dev-tools --single-instance \
--name "Pypilot_webapp" --icon /usr/share/icons/gnome/256x256/actions/go-jump.png  \
"http://localhost:8080" /opt/


cp -r /opt/Freeboard-sk-linux-$arch /opt/Freeboard-sk
cp -r /opt/Pypilot_webapp-linux-$arch /opt/Pypilot_webapp
cp -r /opt/SignalK-linux-$arch /opt/SignalK
cp -r /opt/SpeedSample-linux-$arch /opt/SpeedSample

rm -r /opt/Freeboard-sk-linux-$arch
rm -r /opt/Pypilot_webapp-linux-$arch
rm -r /opt/SignalK-linux-$arch
rm -r /opt/SpeedSample-linux-$arch

if [ $LMBUILD == debian-vbox ] ;then
	chmod 4755 /opt/Freeboard-sk/chrome-sandbox
	chmod 4755 /opt/Pypilot_webapp/chrome-sandbox
	chmod 4755 /opt/SignalK/chrome-sandbox
	chmod 4755 /opt/SpeedSample/chrome-sandbox
fi
install -d /usr/local/share/applications
install -v $FILE_FOLDER/signalk.desktop "/usr/local/share/applications/"