#!/bin/bash

lockfile=/var/lock/check-wlan0.lock
if ( set -o noclobber; echo "locked" > "$lockfile") 2> /dev/null; then

  # Sometimes wlan0 gets an address but won't respond
  # This script checks for this condition and refreshes the interface
  ip a show wlan0 | grep inet > /dev/null
  # If the wlan0 interface is up and has an assigned IP
  if [ $? -eq 0 ]
  then
    echo "wlan0 has IP address"	
    # Get the IP address of the DHCP server
    DHCP_SERVER=$(grep -oP "dhcp-server-identifier \K([^;]*)(?=;)" /var/lib/dhcp/dhclient.wlan0.leases | tail -1)
    if [ $DHCP_SERVER != "" ]
    then
      echo "DHCP server is ${DHCP_SERVER}"
      # Ping the DHCP server
      ping -I wlan0 -c 4 $DHCP_SERVER > /dev/null
      if [ $? -eq 1 ]
      then
        # Refresh the interface if no response
        echo "Refreshing wlan1"
        ifdown wlan0
        sleep 3
        ifup wlan0
      else
	echo "Network is up"
      fi
    fi
  fi

  rm -f "$lockfile"
fi

