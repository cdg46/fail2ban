#!/bin/bash

# Require git
apt-get -qq --assume-yes install curl git fail2ban > /dev/null

if [[ ! -e /opt/fail2ban/installed ]]; then

    git clone https://github.com/cdg46/fail2ban.git /opt/fail2ban
    touch /opt/fail2ban/installed

    else
        cd /opt/fail2ban
        git pull origin master
fi

# Install in system
cd /opt/fail2ban/config
cp -r filter.d/*.conf /etc/fail2ban/filter.d/
cp *.local /etc/fail2ban/
cp *.conf /etc/fail2ban/

service fail2ban restart
#done
