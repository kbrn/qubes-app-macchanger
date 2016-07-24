#!/bin/bash
hwaddr="$(cat /usr/local/etc/qubes-macchanger/macchanger.conf | grep 'MAC=' | awk -F = '{print $2}')"
iface=$1
date | sudo tee /var/log/macstamp
(
	if [ "$#" != "1" ] 
	then
		echo "mac changer script must be given iface name as argument: $@"
        echo "Using default of wlp0s1 instead." 
        iface="wlp0s1"
	fi

	IFCONFIG="/usr/sbin/ifconfig"
	MACCHANGER="/bin/macchanger"
	GREP="/bin/grep"
	PS="/bin/ps"

	nmisrunning=$($PS auxw | $GREP "NetworkManager" | $GREP -v "grep")

	$IFCONFIG $iface down
	$MACCHANGER -a $iface #change to another WiFi card
	#$MACCHANGER -A $iface #change to any valid MAC address
	#$MACCHANGER -r -b $iface #change to any random MAC address
	$IFCONFIG $iface up

	stillthere=$($IFCONFIG | $GREP "$hwaddr")

	if [ "$stillthere" != "" ]
	then
		$IFCONFIG $iface down
		echo "macchanger: Hardware WLAN MAC still in use.  I took down $iface to (hopefully) prevent infoleaks, but you never know..."
	else
		echo "macchanger: Changed the WLAN MAC..."
	fi

	if [ "$nmisrunning" != "" ]
	then
		echo "macchanger: NetworkManager was already running when we started--infoleak possible."
	fi
) | sudo tee /var/log/macchanger_log
