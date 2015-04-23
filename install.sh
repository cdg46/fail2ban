#!/bin/bash

# Require git
apt-get -qq --assume-yes install curl git fail2ban > /dev/null

if [[ ! -e /opt/fail2ban/installed ]]; then

    git clone https://github.com/cdg46/fail2ban.git /opt/fail2ban
    cd /opt/fail2ban

    # Install in system
    cp -r filter.d/*.conf /etc/fail2ban/filter.d/
    cp jail.local /etc/fail2ban/jail.local

    touch /opt/fail2ban/installed
fi
#done
