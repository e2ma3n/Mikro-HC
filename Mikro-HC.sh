#! /bin/bash
# Programming and idea by : E2MA3N [Iman Homayouni]
# Gitbub : https://github.com/e2ma3n
# Email : e2ma3n@Gmail.com
# Website : http://OSLearn.ir
# License : GPL v3.0
# Mikro-HC v1.0 - core [Mikrotik RouterOS Health Control]
# ----------------------------------------------------------- #

# check root privilege
[ "`whoami`" != "root" ] && echo -e '[-] Please use root user or sudo' && exit 1

# check config file
[ ! -f /opt/Mikro-HC_v1/Mikro-HC.conf ] && echo -e "\e[91m[-]\e[0m Error: can not find config file" && exit 1

# check Mikro-HC-core.sh
[ ! -f /opt/Mikro-HC_v1/Mikro-HC-core.sh ] && echo -e "\e[91m[-]\e[0m Error: can not find Mikro-HC-core.sh" && exit 1

# help function
function usage_f {
	echo "Usage: "
	echo "	Mikro-HC --start"
	echo "	Mikro-HC --stop"
	echo "	Mikro-HC --status"
	echo "	Mikro-HC --test_mail"
}

function start_f {
	pgrep -f Mikro-HC-core.sh &> /dev/null
	if [ "$?" = "0" ] ; then
		echo -e "\e[91m[-]\e[0m Error: Mikro-HC service is active"
	else
		/opt/Mikro-HC_v1/Mikro-HC-core.sh &> /dev/null &
		[ "$?" = "0" ] && echo "[+] Starting Mikro-HC ..." && sleep 2 && echo -e "\e[92m[+]\e[0m Ok" || echo -e "\e[91m[-]\e[0m Error: Mikro-HC service not started"
	fi
}

function stop_f {
	kill `pgrep -f Mikro-HC-core.sh` &> /dev/null
	[ "$?" = "0" ] && echo "[+] Stoping Mikro-HC ..." && sleep 2 && echo -e "\e[92m[+]\e[0m Ok" || echo -e "\e[91m[-]\e[0m Error: Mikro-HC service is inactive"
}

function status_f {
	pgrep -f Mikro-HC-core.sh &> /dev/null
        if [ "$?" = "0" ] ; then
		echo -e "\e[92m[+]\e[0m Mikro-HC service is active"
	else
		echo -e "\e[91m[-]\e[0m Mikro-HC service is inactive"
	fi
}

function test_mail {
	smtp_srv=`cat /opt/Mikro-HC_v1/Mikro-HC.conf | head -n 18 | tail -n 1 | cut -d = -f 2`
	smtp_user=`cat /opt/Mikro-HC_v1/Mikro-HC.conf | head -n 20 | tail -n 1 | cut -d = -f 2`
	smtp_pass=`cat /opt/Mikro-HC_v1/Mikro-HC.conf | head -n 22 | tail -n 1 | cut -d = -f 2`
	mail_to=`cat /opt/Mikro-HC_v1/Mikro-HC.conf | head -n 24 | tail -n 1 | cut -d = -f 2`

	text=`date '+DATE: %m/%d/%y TIME: %H:%M:%S' ; echo "Router ip : 127.0.0.1" ; echo "Maximum router voltage is 23V\nMaximum router temperature is 28C"`
	echo "$text" | mailx -v -r "$smtp_user" -s "Mikro-HC - Testing" -S smtp=$smtp_srv -S smtp-use-starttls -S smtp-auth=login -S smtp-auth-user="$smtp_user" -S smtp-auth-password="$smtp_pass" -S ssl-verify=ignore -S nss-config-dir=/etc/pki/nssdb/ $mail_to
}


case $1 in
	--start) start_f ;;
	--stop) stop_f ;;
	--status) status_f ;;
	--test_mail) test_mail ;;
	*) usage_f ;;
esac
