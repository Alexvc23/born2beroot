#command to pull up systems information including kernel version
#and computer archicture
system=$(uname -a)
#Command to find number of physical processors in the system
phcpu=$(grep "physical id" /proc/cpuinfo | uniq | wc -l)
#Command to find number of virtual processors in the system
vrcpu=$(grep "^processor" /proc/cpuinfo | wc -l)
#Command to retrieve total amount of ram in the system
ram=$(free -m | awk '$1 == "Mem:" {print $2}')
#Command to retrieve the memory use by the system
uram=$(free -m | awk '$1 == "Mem:" {print $3}')
#Command to print the percentage of memory used by the system
pram=$(free -m | awk '$1 == "Mem:" {printf("%.2f%%"), ($3/$2)*100}')
#Command to retrieve the total amount of storage in the system
 disk=$(df -Bg | grep "^/dev/" | grep -v "/boot$" | awk '{f += $2} END {print f}')
#Command to retrieve the amount of storage used by the system
udisk=$(df -Bg | grep "^/dev/" | grep -v "/boot$" | awk '{u += $3} END {print u}')
#Command to calculate the percentage of storage used by the system
pdisk=$(df -Bg | grep "^/dev/" | grep -v "/boot$" | awk '{u += $3} {f += $2} END {printf("%d%%"), u/f*100}')
#Command to retrieve the actual cpu usage in the system
cpu=$(top -bn1 | grep "^%Cpu" | cut -c 9- | awk '{printf("%.1f%%"), $1 + $3}')
#How to retrieve last reboot date and time of the current user logged in 
lastBoot=$(who -b | awk '$1 == "system" {print $3" "$4}')
#How to verify if we are using the functionality lvm in our system
flvm=$(lsblk | grep "lvm" | wc -l)
plvm=$(if [ $flvm -eq 0 ]; then echo no; else echo yes; fi)
#Command to print the number of TCP connexions in the current system
ptcp=$(cat /proc/net/sockstat | awk ' $1 == "TCP:" {print $3}')
#Number of user logged in on the system
ulogged=$(users | wc -l)
#retreave the ip address of our current machines
ip=$(hostname -I)
#retrieve mac address of our current machine
mac=$(ip link show | grep "link/ether" | awk '{print $2}')
#retrive number of commands executed as sudo
sudoCommands=$(journalctl | grep "sudo" | grep "COMMAND" | wc -l)

wall "
			#Architecture: $system
			#CPU physical : $phcpu
			#vCPU : $vrcpu
			#Memory Usage: $uram/${ram}MB ($pram)
			#Disk Usage: $udisk/${disk}GB ($pdisk)
			#CPU load: $cpu
			#Last boot: $lastBoot
			#LVM use: $plvm
			#Connexion TCP: ${ptcp} ESTABLISHED
			#User log: $ulogged
			#Network: IP $ip ($mac)
			#Sudo: $sudoCommands cmd
		"
