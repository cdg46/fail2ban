#!/bin/bash
INSTALL=0
# Require git
clear
echo "#########################################";
echo "#                                       #";
echo "#          Fail2ban postinstall         #";
echo "#                                       #";
echo "#########################################";
echo "";
echo "Install curl git fail2ban if necessary."
apt-get -qq --assume-yes install curl git fail2ban > /dev/null

if [[ ! -e /opt/fail2ban/installed ]]; then
    INSTALL=1
    echo "Installing fail2ban post install"
    git clone https://github.com/cdg46/fail2ban.git /opt/fail2ban
    touch /opt/fail2ban/installed

    else
        cd /opt/fail2ban
        git pull origin master
fi

echo "Please insert the email's receiver, then your structure"
read -p "Email's receiver : " destemail
read -p "Structure  : " structure

# Install in system
cd /opt/fail2ban/config
cp -r filter.d/* /etc/fail2ban/filter.d/
cp -r action.d/* /etc/fail2ban/action.d/
cp *.local /etc/fail2ban/
cp *.conf /etc/fail2ban/

sed -i -e "s/root@localhost/$destemail/" /etc/fail2ban/jail.local
sed -i -e "s/__STRUCTURE__/$structure/" /etc/fail2ban/jail.local
sed -i -e "s/__VM__/$(hostname)/" /etc/fail2ban/jail.local

# Register blocklist key
echo "Please insert your blocklist apikey"
read -p "blocklist.de key  : " blocklost_de_apikey
if [[ $blocklist_de_apikey != '' ]]; then
    sed -i -e "s/\# \[Init\]\n\# blocklist_de_apikey = \{api key from registration\}/[Init]\nblocklist_de_apikey = $(blocklist_de_paikey)/" /etc/fail2ban/jail.conf
    sed -i -e "s/\# blocklist_de_apikey = \{api key from registration\}/$(blocklist_de_paikey)/" /etc/fail2ban/jail.conf
fi

if [[ $INSTALL == 1 ]] ; then
    service fail2ban start
else
    service fail2ban restart
fi
#done
