#!/bin/sh
mkdir -p $HOME/Library/LaunchAgents
cat > $HOME/Library/LaunchAgents/watchpics.plist <<EOF
<?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE plist PUBLIC "-//Apple//DTD PLIST 1.0//EN" "http://www.apple.com/DTDs/PropertyList-1.0.dtd">
<plist version="1.0">
<dict>
    <key>Disabled</key>
    <false/>
    <key>Label</key>
    <string>com.avibryant</string>
    <key>ProgramArguments</key>
    <array>
        <string>$HOME/bin/watchpics</string>
    </array>
    <key>WatchPaths</key>
    <array>
        <string>$HOME/Desktop/screenshot.png</string>
    </array>
    <key>RunAtLoad</key>
    <true/>
    <key>onDemand</key>
    <true/>
</dict>
</plist>
EOF
mkdir -p $HOME/bin
cat > $HOME/bin/watchpics <<EOF
#!/bin/sh
#edit these
REMOTE_USER=da
REMOTE_SERVER=ascher.ca
REMOTE_PATH=/var/www/snaps/
REMOTE_URL=http://snaps.ascher.ca
####
sleep 1
PIC=~/Desktop/screenshot.png
MD5=\`md5 "\$PIC" | cut -d " " -f 4\`
scp ~/Desktop/screenshot.png \$REMOTE_USER@\$REMOTE_SERVER:\$REMOTE_PATH/\$MD5.png
rm "\$PIC"
echo "\$REMOTE_URL/\$MD5.png" | pbcopy 
EOF
chmod u+x $HOME/bin/watchpics
launchctl load -S Aqua $HOME/Library/LaunchAgents/watchpics.plist
echo "Please edit the REMOTE_* variables at the top of $HOME/bin/watchpics"
