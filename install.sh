#! /bin/bash
# Programming and idea by : E2MA3N [Iman Homayouni]
# Gitbub : https://github.com/e2ma3n
# Email : e2ma3n@Gmail.com
# Website : http://OSLearn.ir
# License : GPL v3.0
# Mikro-HC v1.0 - installer [Mikrotik RouterOS Health Control]
# ----------------------------------------------------------- #

# check root privilege
[ "`whoami`" != "root" ] && echo -e '[-] Please use root user or sudo' && exit 1

# help function
function help_f {
	echo "Usage: "
	echo "	sudo ./install.sh -i [install program]"
	echo "	sudo ./install.sh -u [help to uninstall program]"
	echo "	sudo ./install.sh -c [check dependencies]"
}

# install program on system
function install_f {
	[ ! -d /opt/Mikro-HC_v1/ ] && mkdir -p /opt/Mikro-HC_v1/ && echo "[+] Directory created" || echo "[-] Error: /opt/Mikro-HC_v1/ exist"
	sleep 1
	[ ! -f /opt/Mikro-HC_v1/Mikro-HC-core.sh ] && cp Mikro-HC-core.sh /opt/Mikro-HC_v1/ && chmod 700 /opt/Mikro-HC_v1/Mikro-HC-core.sh && echo "[+] Mikro-HC-core.sh copied" || echo "[-] Error: /opt/Mikro-HC_v1/Mikro-HC-core.sh exist"
	sleep 1
	[ ! -f /opt/Mikro-HC_v1/Mikro-HC.conf ] && cp Mikro-HC.conf /opt/Mikro-HC_v1/ && chmod 700 /opt/Mikro-HC_v1/Mikro-HC.conf && echo "[+] Mikro-HC.conf copied" || echo "[-] Error: /opt/Mikro-HC_v1/Mikro-HC.conf exist"
	sleep 1
	[ ! -f /opt/Mikro-HC_v1/Mikro-HC.sh ] && cp Mikro-HC.sh /opt/Mikro-HC_v1/ && chmod 700 /opt/Mikro-HC_v1/Mikro-HC.sh && echo "[+] Mikro-HC.sh copied" || echo "[-] Error: /opt/Mikro-HC_v1/Mikro-HC.sh exist"
	sleep 1
	[ -f /opt/Mikro-HC_v1/Mikro-HC.sh ] && ln -s /opt/Mikro-HC_v1/Mikro-HC.sh /usr/bin/Mikro-HC && echo "[+] symbolic link created" || echo "[-] Error: symbolic link not created"
	sleep 1
	[ ! -d /opt/Mikro-HC_v1/log/ ] && mkdir -p /opt/Mikro-HC_v1/log/ && echo "[+] Log Directory created" || echo "[-] /opt/Mikro-HC_v1/log/ exist"
	sleep 1
	echo "[+] Please see README" ; sleep 0.5
	echo "[+] you have two choises : start manually or Starting up Script As a daemon" ; sleep 0.5
	echo "[!] Warning: You should run program as root" ; sleep 0.5
	echo "[!] Warning: You should edit config file" ; sleep 0.5
	echo "[+] Done"
}

# uninstall program from system
function uninstall_f {
	echo "For uninstall program:"
	echo "	sudo rm -rf /opt/Mikro-HC_v1/"
	echo "	sudo rm -f /usr/bin/Mikro-HC"
}

# check dependencies on system
function check_f {
	echo "[+] check dependencies on system:  "
	for program in whoami sleep cat head tail cut pgrep kill mailx sshpass
	do
		sleep 0.5
		if [ ! -z `which $program 2> /dev/null` ] ; then
			echo -e "[+] $program found"
		else
			echo -e "[-] Error: $program not found"
		fi
	done
}

case $1 in
	-i) install_f ;;
	-u) uninstall_f ;;
	-c) check_f ;;
	-h) help_f ;;
	*) help_f ;;
esac
