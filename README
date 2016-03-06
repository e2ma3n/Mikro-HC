Programming and idea by : E2MA3N [Iman Homayouni]
Gitbub : https://github.com/e2ma3n
Email : e2ma3n@Gmail.com
Website : http://OSLearn.ir
License : GPL v3.0
Mikro-HC v1.0 - readme [Mikrotik RouterOS Health Control]

Description :
This program monitoring routerboard's voltage and temperature and alerting sysadmin with email in emergency conditions.


Dependencies :
	1. whoami
	2. sleep
	3. cat
	4. head
	5. tail
	6. cut
	7. pgrep
	8. kill
	9. mailx
	10. sshpass


Install Mikro-HC v1.0 :
	1. chmod +x install.sh
	2. sudo ./install.sh -i


Check dependencies :
	1. chmod +x install.sh
	2. sudo ./install.sh -c


Install mailx in debian :
	1. sudo apt-get install heirloom-mailx


Install mailx in centos :
	1. sudo yum install mailx


Testing program :
	1. Mikro-HC --test_mail # plaese see varbose


Usage Mikro-HC v1.0 :
	1. sudo Mikro-HC --status # for check program's status
	2. sudo Mikro-HC --start # for start program in background
	3. sudo Mikro-HC --stop # for stop program service


Uninstall Mikro-HC v1.0 :
	1. rm -rf /opt/Mikro-HC_v1/
	2. rm -f /usr/bin/Mikro-HC


Notes :
	1. you have two choises : start manually or starting up script as a daemon
	2. You should run program as root
	3. You should edit config file


Testes Mikro-HC v1.0 in :
	1. Debian 8.1.0 64bit netinst, 3.16.0-4-amd64
	2. Centos 6.3 32bit minimal, 2.6.32-279.el6.i686
	3. Ubuntu 14.04 LTS - desktop


CentOS bug - mailx :
	Error : Missing "nss-config-dir" variable.
	Patch : add '-S nss-config-dir=/etc/pki/nssdb/' to mailx's options
