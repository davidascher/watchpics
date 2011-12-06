This is a utility that Avi Bryant wrote a while back, to automatically take screenshots and publish them on a self-hosted server where one has scp access.

Steps:

1) change OS X to make a predictable name for screenshots (you'll never have more than one!)

  cd /System/Library/CoreServices/SystemUIServer.app/Contents/Resources/English.lproj/
  cp ScreenCapture.strings ScreenCapture.strings.backup
  sudo plutil -convert xml1 ScreenCapture.strings

 edit the ScreenCapture.strings file so that the line that reads "%@ %@ at %@" reads somethings like "%@" using steps described in http://apple.stackexchange.com/questions/27729/changing-the-default-screenshot-filename

 sudo plutil -convert binary1 ScreenCapture.strings
 killall SystemUIServer

(at this point the mac will generate screenshots like "Screenshot.png" (depending on what other plists you've modified)

2) run the install_watchpics.sh script, which will:
 
  - register with OS X a filename to watch for, and launch a script called "watchpics" in your ~/bin directory

3) edit said watchpics to have the right location for the server to scp to.

4) edit your webserver to match.  My relevant nginx.conf file is:

    server {
        server_name snaps.ascher.ca;
        location / {
            root /var/www/snaps/;
        }
    }


