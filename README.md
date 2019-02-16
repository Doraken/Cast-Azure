SEC-LNX
===============

automated linux securing script based on CAST.

This script may be used to chek or to apply all security rules that have been 
activated in the sonfiguration file . 

This script will générate a complience report. 

/tmp/report.html

And all non spécific part issued from CAST are only property of the owner 
ARNAUD CRAMPET


Arnaud Crampet / Doraken


Mail : arnaud@crampet.net



Install and launch : 
#!/bin/bash
VERSION="1.0.5"
echo "Applying minimal packaages to system"
sudo yum install wget -y && sudo yum install unzip -y
echo "Purgiung old versions"
sudo rm -rf /tmp/SEC-LNX* && sudo rm -rf /tmp/*.zip*
echo "Getting new VERIONS : ${VERSION}"
cd /tmp  && wget https://inari.crampet.net/doraken/SEC-LNX/archive/v${VERSION}.zip && unzip /tmp/v${VERSION}.zip && sudo rm -rf /srv/admin/scripts && sudo mkdir --parent /srv/admin/scripts/
sudo mv /tmp/SEC-LNX-v${VERSION}/* /srv/admin/scripts/ && sudo chmod +x /srv/admin/scripts/bin/secure-linux.sh
echo "Lauching"
sudo su -c "/srv/admin/scripts/bin/secure-linux.sh"