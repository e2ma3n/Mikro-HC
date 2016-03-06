#! /bin/bash
# Programming and idea by : E2MA3N [Iman Homayouni]
# Gitbub : https://github.com/e2ma3n
# Email : e2ma3n@Gmail.com
# Website : http://OSLearn.ir
# License : GPL v3.0
# Mikro-HC v1.0 - core [Mikrotik RouterOS Health Control]
# ----------------------------------------------------------- #

username=`cat /opt/Mikro-HC_v1/Mikro-HC.conf | head -n 10 | tail -n 1 | cut -d "=" -f 2`
ip_address=`cat /opt/Mikro-HC_v1/Mikro-HC.conf | head -n 12 | tail -n 1 | cut -d "=" -f 2`
ssh_port=`cat /opt/Mikro-HC_v1/Mikro-HC.conf | head -n 14 | tail -n 1 | cut -d "=" -f 2`
password=`cat /opt/Mikro-HC_v1/Mikro-HC.conf | head -n 16 | tail -n 1 | cut -d "=" -f 2`
smtp_srv=`cat /opt/Mikro-HC_v1/Mikro-HC.conf | head -n 18 | tail -n 1 | cut -d "=" -f 2`
smtp_user=`cat /opt/Mikro-HC_v1/Mikro-HC.conf | head -n 20 | tail -n 1 | cut -d "=" -f 2`
smtp_pass=`cat /opt/Mikro-HC_v1/Mikro-HC.conf | head -n 22 | tail -n 1 | cut -d "=" -f 2`
mail_to=`cat /opt/Mikro-HC_v1/Mikro-HC.conf | head -n 24 | tail -n 1 | cut -d "=" -f 2`
delay=`cat /opt/Mikro-HC_v1/Mikro-HC.conf | head -n 26 | tail -n 1 | cut -d "=" -f 2`


function send-mail {
	text=`date '+DATE: %m/%d/%y TIME: %H:%M:%S' ; echo "Router ip : $ip_address" ; echo "$temperature_text" ; echo "$voltage_text"`
	echo "$text" | mailx -v -r "$smtp_user" -s "Mikro-HC - `date '+%m/%d/%y'`" -S smtp=$smtp_srv -S smtp-use-starttls -S smtp-auth=login -S smtp-auth-user="$smtp_user" -S smtp-auth-password="$smtp_pass" -S ssl-verify=ignore -S nss-config-dir=/etc/pki/nssdb/ $mail_to &> /dev/null
	if [ "$?" != "0" ] ; then
		echo -n "[-] " >> /opt/Mikro-HC_v1/log/errors.log ; date >> /opt/Mikro-HC_v1/log/errors.log
		echo "[-] Error: we have problem on send-mail" >> /opt/Mikro-HC_v1/log/errors.log
		echo "[-] ------------------------------------------------ [-]" >> /opt/Mikro-HC_v1/log/errors.log
	fi
}

voltage_b=0
temperature_b=0
for (( j=0 ;; j++ )) ; do

	sshpass -p "$password" ssh -o StrictHostKeyChecking=no -l $username $ip_address -p $ssh_port "system health print" > /tmp/Mikro-HC
	voltage[$j]=`cat -v /tmp/Mikro-HC | tr -d " " | grep voltage | cut -d ":" -f 2 | tr -d V | tr -d ^M | cut -d '.' -f 1`
	temperature[$j]=`cat -v /tmp/Mikro-HC | tr -d " " | grep temperature | cut -d ":" -f 2 | tr -d C | tr -d ^M | cut -d '.' -f 1`

	if [ "${voltage[$j]}" -gt "$voltage_b" ] ; then
		voltage_text=`echo "Maximum router voltage is ${voltage[$j]}"V`
		voltage_b=`echo ${voltage[$j]}`
	fi

	if [ "${temperature[$j]}" -gt "$temperature_b" ] ; then
		temperature_text=`echo "Maximum router temperature is ${temperature[$j]}"C`
		temperature_b=`echo ${temperature[$j]}`
	fi

	if [ ! -z "$voltage_text" ] ; then
		send-mail
	else
		if [ ! -z "$temperature_text" ] ; then
			send-mail
		fi
	fi

	unset voltage_text &> /dev/null
	unset temperature_text &> /dev/null

	sleep $delay
done
