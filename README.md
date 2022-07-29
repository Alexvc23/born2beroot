# born2beroot
***in this project we will use virtualization, we will install linux debian in virtualBox and setup the it to use it as a server***

## Defence

### Sudo

Soudo est une logicielle qui nous permet d’exécuter de command autant que superutilisateur ou autant qu'autre utilisateur. Il nous permet également de changer les règles qui gouvernent l’Environnement d’un utilisateur comme par exemple, à quels fichiers il peut avoir accès ou quelles commandes il peut exécuter.

### What is a VM or virtual machine

Is a program in a computer that works like a separate computer inside the main computer. The program that controls virtual machines is called [**hypervisor](https://simple.wikipedia.org/wiki/Hypervisor),** the computer running the virtual machine is called host. ****The hypervisor controls how the virtual machine can access memory, hard drive space, and other resources on the host computer.

### Difference between CentOS and Debian

| Cent-OS | Debian |
| --- | --- |
| Cent-OS has limited packages   | Debian has a vast amount of packages in its default repository to do something |
| Has a complicated GUI | Comes with user friendly applications and GUI |
| It’s better to install a new Cent-OS version rather than go for upgrading this task is cumbersome  | Can be easily upgraded from one stable version to another |
| CentOS is more stable and is supported by a large community | Debian has relatively less market presence  |
|  |  |

## Why to use a virtual machine

- It a simple way to run multiple operating systems on the same computer
- A power server can be splitted into several smaller virtual machines to use its resources better
- It can help with security,  if the virtual machine is affected by a virus, the host operating system is unaffected

### Difference between apt and attitude

| Apt | Attitude |
| --- | --- |
| Apt is a low level  package manager that can be use by other high-level package managers | Attitude is a high level package manager, is vaster in functionality than apt-get and include functionalities of apt-get, apt-mark and apt-cache |
| while apt-get handles all the package installation, system up gradation, purging packages , resolving dependencies etc.    | Attitude handles lot more stuff than apt, searching for a package in a list of installed packages, marking a package to be automatically o manually installed, making a package unavailable for up gradation and so on. |

### Difference between SELinux and APPArmor?

SELinux and APPArmor are security systems that allow us to isolate a programs to from one another, when a program is isolated from the rest of the system we are protected from attacks and viruses that can compromise any application. 

- SELinux is extremely difficult to handle, but with this complexity will give you more control over process to be isolated
- AppArmor is verty straight forward, the profiles can be hand written by humans. AppArmor user path based control, making the system more transparent so it can be independently verified. ([Source](https://security.stackexchange.com/questions/29378/comparison-between-apparmor-and-selinux))

### What is kernel

Kernel is the essential center of a computer system, it can be thought of as the main program which controls all other programs in the computer. Kernel provides services so the programs can request the use of hardware(disk, ram, GPU, CPU etc). Ensure programs don’t interfere with the functioning of other programs, denying access to memory already allocated by other programs, and restricting the amount of CPU time consuming. 

### What is computer architecture

In computer engineering, computer architecture is a set of rules and methods that describe the functionality, organization, and implementation of computer systems. 

For instance: we can find the two most known architecture x86 and x64 the first one representing 32 bits operating system and the second one  64 bits operating system.

### What is LVM

LVM is **logical volume manager** is a functionality that allows you to manage logical volumes for the Linux kernel.

### Communication protocol

A communication protocol is a system of rules that allows two or more identities of a communication system to transmit information via any kind of variation of a physical quantity .

The protocol defines rules, the syntax, semantics and synchronization of communication and possible recovery  methods. 

### Transmission Control Protocol(TCP)

Is one of the main internet protocols of the internet protocol suite which complements the internet protocol (IP). 

TCP provides reliable, ordered, and error-checked delivery of a stream of octets(bytes) between applications running on host communication via an IP network. 

### SSH (secure shell)

Est à la fois un [programme informatique](https://fr.wikipedia.org/wiki/Programme_informatique) et un [protocole de communication](https://fr.wikipedia.org/wiki/Protocole_de_communication) sécurisé. Le protocole de connexion impose un échange de [clés de chiffrement](https://fr.wikipedia.org/wiki/Cl%C3%A9_de_chiffrement) en début de connexion. Ils nous permet de établir une conexion sécurise de manière remote avec un serveur.

Source: [https://fr.wikipedia.org/wiki/Secure_Shell#Implémentations_logicielles](https://fr.wikipedia.org/wiki/Secure_Shell#Impl%C3%A9mentations_logicielles)

### Firewall

A firewall is a computer security system that controls incoming and outgoing network traffick base on determinated security rules.

### UFW (uncomplicated firewall)

It’s basically a user friendly framework that allow us to control easy our firewall, using the command line or the GUI.

### how to see partitions, hard drives

```bash
$ sudo lsblk
```

### Login as root

```bash
$ su -
```

### How to know the actual user logged in

```bash
$ whoami
```

### Check the operating system

```bash
$ uname -a
```

# User setting up

### How to create a new user

```bash
sudo adduser username
```

### How to delete a user

```bash
sudo deluser username
```

### If we want to delete its home directory we add the flag:

```bash
sudo deluser --remove-home username
```

### Where to find all users in my system

```bash
cat /etc/passwd | grep 'bash'
```

# Changing hostname

```bash
# how to know current hostname
hostnamectl

# change hostname in the first file
$ vim /etc/hostname

# Then in the second file
$ vim /etc/hosts

# Then reboot the machine virtuelle
```

# Sudo privileges

### Installing sudo

```bash
$ apt install sudo
```

### Adding user in the sudo group or any other group

```bash
$ su -
$ usermod -aG sudo your_usernamecat
# **A simpler way to do it**
$ adduser <your_username> <group name>
```

### Creating a new group

```bash
$ addgroup <group name>
```

### Checking if user is in the sudo group

```bash
$ getent group sudo
```

### give privilege as super user (su)

```bash
$ su -
$ vim /etc/sudoers

# add **your_user plus ALL=(ALL:ALL) ALL** as follow in the section
# allow members of group sudo to execute any command
$ jvalenci42 ALL=(ALL:ALL) ALL

#we can also execute the following the code instead of vim /etc/sudoers to do the same thing
$ sudo visudo

```

# Set up security policies for sudo group

### What is sudo

sudo command allows you the run command with root privileges, when using sudo command the actual user password will be requested, you won’t need to enter the root password.

The security policy of is driven by **/etc/sudoers** file 

Any file found within the folder **/etc/sudoers** and **/etc/sudoers.d** will be taken into account for sudo security policie

```bash
#Lets create a file in /etc/sudoers.d/ that will allows us to set all the 
# default entry lines which will set up the sudo security policy
$ touch /etc/sudoers.d/sudoconfig

#As convention we will create a folder called /var/log/sudo
#That will contain the historic log of users that used sudo
$ mkdir /var/log/sudo #(we will assign the default entry line later on)

#In order to modify sudo's security policy behavior, we will append
#the following information in the file that we just created 
#early on "/etc/sudoers.d/sudoconfig" 
$ vim /etc/sudoers.d/sudoconfig

************************************************************
* Defaults      passwd_tries=3                             *
* Defaults      badpass_message="Incorrect password"       * <- you can set your
* Defaults      log_input,log_output                       *    own message here
* Defaults      iolog_dir="/var/log/sudo"                  *
* Defaults      requiretty                                 * <- wont allow no-root scrip 
* Defaults      secure_path="that/long/paths/from/subject" *     executing
************************************************************ 

```

### See all the commands executed with sudo program

```bash
# in the folder /var/log/sudo/00/00/ we will find a list of folders enumerated
# in excadecimal order continging the commands used in the system with the program sudo
# one command per folder
$ find /var/log/sudo -name "log" -exec grep "usr" {} \;
```

### See all the sudo users with privileges in the system

```bash
# first option only available just for the sudo users
$ vim /etc/sudoers
#second option
$ sudo visudo
```

### How to change time zone in debian

```bash
$ dpkg-reconfigure tzdata
```

### Set up [monitoring.sh](http://monitoring.sh) scrip

In this scrip implementation we will be using the **wall** command that allow us to write a message to all the user logged in the server.

```bash
df#command to pull up systems information including kernel version
#and computer archicture
system = $(uname -a)
#Command to find number of physical processors in the system
phcpu=$(grep "physical id" /proc/cpuinfo | uniq | wc -l)
#Command to find number of virtual processors in the system
vrcpu=$(grep "^processor" /proc/cpuinfo | wc -l)
#Command to retrieve total amount of ram in the system
ram=$(free -m | awk '$1 == "Mem:" {print $2}')
#Command to retrieve the memory use by the system
uram=$(free -m | awk '$1 == "Mem:" {print $3}')
#Command to print the percentage of memory used by the system
pram=$(free -m | awk '$1 == "Mem:" {printf("%.2f"), ($3/$2)*100}')
#Command to retrieve the total amount of storage in the system
 disk=$(df -Bg | grep "^/dev/" | grep -v "/boot$" | awk '{f += $2} END {print f}')
#Command to retrieve the amount of storage used by the system
udisk=$(df -Bg | grep "^/dev/" | grep -v "/boot$" | awk '{u += $3} END {print u}')
#Command to calculate the percentage of storage used by the system
pdisk=$(df -Bg | grep "^/dev/" | grep -v "/boot$" | awk '{u += $3} {f += $2} END {print u/f*100}')
#Command to retrieve the actual cpu usage in the system
cpu=$(top -bn1 | grep "^%Cpu" | cut -c 9- | awk '{printf("%.1f%%"), $1 + $3}')
#How to retrieve last reboot date and time of the current user logged in 
lastBoot=$(who -b | awk '$1 == "system" {print $2" "$3}'
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
Wall "i
			#Architecture: $system
			#CPU physical : $phcpu
			#vCPU : $vrcpu
			#Memory Usage: $uram/$ram ($pram)
			#Disk Usage: $udisk/$disk ($pdisk)
			#CPU load: $cpu
			#Last boot: $lastBoot
			#LVM use: $plvm
			#Connexion TCP: $ptcp
			#User log: $ulogged
			#Network: IP $ip ($mac)
			#Sudo: $sudoCommands cmd
		"
		

```

### How to set up cron to run scrip every 10 minutes

```bash
# 1. we need to run the comand crontab -e
# if it's the first time we use crontab -e we will be asked to selec an editor
# once the file opened we add the next information

$ */10 * * * * /root/monitoring.sh

# Example of job definition:
# .---------------- minute (0 - 59)
# |  .------------- hour (0 - 23)
# |  |  .---------- day of month (1 - 31)
# |  |  |  .------- month (1 - 12) OR jan,feb,mar,apr ...
# |  |  |  |  .---- day of week (0 - 6) (Sunday=0 or 7) OR sun,mon,tue,wed,thu,fri,sat
# |  |  |  |  |
# *  *  *  *  * user-name  command to be executed
```

### How to stop cron executing scrips

```bash
# how to pause cron services
sudo /etc/init.d/cron stop

# how to start cron services
sudo /etc/init.d/cron start

# how to backup cron file
sudo crontab -l > cron_backup.txt

# how to stop defenitely cron
sudo crontab -r

# how to restore cron file 
sudo crontab cron_back.txt
```

# Strong password policy

### new password for root

&:A}[uJ`K~4rmy2c

### new password for jvalenci

ysha&b`TnX6K#]!e

```bash
1) [$ sudo nano /etc/login.defs]
2) replace next lines:

*************************************************
* PASS_MAX_DAYS    99999 -> PASS_MAX_DAYS    30 * <- line 160 you can easly
* PASS_MIN_DAYS    0     -> PASS_MIN_DAYS    2  *    reach it with ctrl+_ in
*************************************************    nano

PASS_WARN_AGE is 7 by defaults anyway so just ignore it.
3) [$ sudo apt install libpam-pwquality]
4) [$ sudo nano /etc/pam.d/common-password]
5) Add to the end of the "password requisite pam_pwqiality.so retry=3" line next
parameters

****************************************************************************************
* minlen=10 ucredit=-1 dcredit=-1 maxrepeat=3 reject_username difok=7 enforce_for_root *
****************************************************************************************

You should get_next_line(ha-ha):
"password requisite pam_pwqiality.so retry=3 minlen=10 ucredit=-1 dcredit=-1 maxrepeat=3 reject_username difok=7 enforce_for_root"

6) Now you have to change all your passwords according to your new password
policy
***************
* [$ passwd]      * <- change user password
* [$ sudo passwd] * <- change root password
***************
```

Add these values (min lower-case 1 letter, min upper-case 1 letter, min
digit 1, max same letter repetition 3, whether to check if the password
contains the user name in some form (enabled if the value is not 0), the minimum number of characters that must be different from the old
password=7, enforce_for_root: same policy for root users):

### Enable strong security policies to root

```bash
sudo chage -m 2 -M 30 -W 7 root
```

### See security policies avaliable for the current user

```bash
sudo chage -l <user>
```

# Installing SSH (sercure shell)

```bash
# 1) [$ sudo apt install openssh-server]
# 2) [$ sudo nano /etc/ssh/sshd_config] -> change line "#Port 22" to "Port 4242" and
# "#PermitRootLogin prohibit-password" to "PermitRootLogin no" -> save and exit
# (i hope you know how to do it in Nano...)
# 3) [$ sudo nano /etc/ssh/ssh_config] -> change line "#Port 22" to "Port 4242"
# 4) [$ sudo service ssh status]. It's should be active.
```

# Installing ufw

```bash
1) [$ sudo apt install ufw]
2) [$ sudo ufw enable]
3) [$ sudo ufw allow 4242]
4) [$ sudo ufw status]. It's should be active with 4242 and 4242(v6) ports allow
from anywhere
```

### How to delete rule with ufw

```bash
#we list all the rules avaiable
$ sudo ufw status numbered
# then we delelete the rule taking into account the number
$ sudo ufw delete 3
```
