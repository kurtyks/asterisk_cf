#!/bin/bash 

if [ "$EUID" -ne 0 ]
  then echo "Please run as root"
  exit
fi

echo "Updating packages..."
dnf update -q -y
echo "Installing asterisk..."
dnf install -q -y asterisk
echo "Installing asterisk-pjsip..."
dnf install -qy asterisk-pjsip
echo "Installing asterisk-postgresql..."
dnf install -q -y asterisk-postgresql

echo "All installed, configuring DB"
sh ./database_config.sh  

LOGGER_CONF="
[logfiles]
messages => notice,warning,error,security
security => security
full => notice,warning,error,debug,verbose
"

EXTENSIONS_CONF="
[from-internal]
exten => _XXXX,1,NoOp(Internal call to ${EXTEN})
same => n,Dial(PJSIP/${EXTEN})
same => n,Hangup

exten => _XXX,1,NoOp(Internal call to ${EXTEN})
same => n,Dial(PJSIP/${EXTEN},15)

exten => _X.,1,GoTo(to-external, ${EXTEN})

[from-external]
exten => _X.,1,NoOp(External call)

[to-external]
exten => _X.,1,NoOp(CTX to-external, this ll cal via provider to ${EXTEN})
same => n,Hangup"

RES_PGSQL_CONF="
[general]
dbhost=127.0.0.1
dbport=5432
dbname=asterisk_db
schema=pjsip
dbuser=asterisk_ro
dbpass=321321
dbappname=Asterisk_ro
;dbsock=/var/run/postgresql/.s.PGSQL.5432
"

SORCERY_CONF="
[res_pjsip]
endpoint=realtime,ps_endpoints
auth=realtime,ps_auths
aor=realtime,ps_aors
"

EXTCONFIG="
[settings]
ps_endpoints => pgsql,asterisk_db,pjsip.v_endpoints
ps_auths => pgsql,asterisk_db,pjsip.v_auths
ps_aors => pgsql,asterisk_db,pjsip.v_aors
"
PJSIP_CONFIG="
[transport](!)
type=transport

[udp](transport)
protocol=udp
bind=0.0.0.0:5060

[tcp](transport)
protocol=tcp
bind=0.0.0.0:5061
"

echo "Asterisk reconfiguration"
echo "mkdir /etc/asterisk/old"
mkdir /etc/asterisk/old

echo "mv /etc/asterisk/pjsip.conf /etc/asterisk/old/"
cp /etc/asterisk/pjsip.conf /etc/asterisk/old/
echo -e "$PJSIP_CONFIG" > /etc/asterisk/pjsip.conf

echo "mv /etc/asterisk/extensions.conf /etc/asterisk/old/"
cp /etc/asterisk/extensions.conf /etc/asterisk/old/
echo -e "$EXTENSIONS_CONF" > /etc/asterisk/extensions.conf

echo "mv /etc/asterisk/logger.conf /etc/asterisk/old/"
cp /etc/asterisk/logger.conf /etc/asterisk/old/
echo -e "$LOGGER_CONF" > /etc/asterisk/logger.conf

echo "mv /etc/asterisk/res_pgsql.conf /etc/asterisk/old/"
cp /etc/asterisk/res_pgsql.conf /etc/asterisk/old/
echo -e "$RES_PGSQL_CONF" > /etc/asterisk/res_pgsql.conf 

echo ""mv /etc/asterisk/sorcery.conf /etc/asterisk/old/
cp /etc/asterisk/sorcery.conf /etc/asterisk/old/
echo -e "$SORCERY_CONF" > /etc/asterisk/sorcery.conf 

echo "mv /etc/asterisk/extconfig.conf /etc/asterisk/old/"
cp /etc/asterisk/extconfig.conf /etc/asterisk/old/
echo -e "$EXTCONFIG" > /etc/asterisk/extconfig.conf


echo "FILES RECONFIGURED!"
