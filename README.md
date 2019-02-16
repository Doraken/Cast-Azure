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
sudo yum install wget -y && sudo yum install unzip -y 
sudo rm -rf /tmp/SEC-LNX-master/ && sudo rm -rf /tmp/master.zip* && cd /tmp  && wget https://inari.crampet.net/doraken/SEC-LNX/archive/master.zip && unzip /tmp/master.zip &&sudo rm -rf /srv/admin/scripts && sudo mkdir --parent /srv/admin/scripts/ && sudo mv /tmp/SEC-LNX-master/* /srv/admin/scripts/ && sudo chmod +x /srv/admin/scripts/bin/secure-linux.sh
sudo /srv/admin/scripts/bin/secure-linux.sh