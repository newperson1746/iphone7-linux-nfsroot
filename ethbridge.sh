#!/bin/bash
on() {
  sudo ip link add name usb-bridge type bridge
  sudo ip link set usb-bridge up
  sleep 2
  sudo ip link set enp6s0f0 up
  sudo ip link set enp6s0f0 master usb-bridge
  if [[ -d /sys/class/net/iphone7 ]]
  then
    sudo ip link set iphone7 up
    sudo ip link set iphone7 master usb-bridge
    sleep 5
    sudo /sbin/dhclient -r usb-bridge
    until sudo /sbin/dhclient -I usb-bridge
    do
      echo "Retrying..."
    done
  elif [[ -d /sys/class/net/usb0 ]]
  then
    sudo ip link set usb0 up
    sudo ip link set iphone7 master usb-bridge
    sleep 5
    sudo /sbin/dhclient -r usb-bridge
    until sudo /sbin/dhclient -I usb-bridge
    do
      echo "Retrying..."
    done
  fi
}
off() {
  sudo ip link set enp6s0f0 nomaster
  sudo ip link set iphone7 nomaster
  sudo ip link set usb0 nomaster
  sudo ip link delete usb-bridge type bridge
  sleep 2
  sudo /sbin/dhclient -r enp6s0f0
  #nmcli device reapply enp6s0f0
  until sudo /sbin/dhclient -I enp6s0f0
  do
    echo "Retrying..."
  done
}
#######
if [[ $1 == on ]]
then
  on
fi

if [[ $1 == off ]]
then
  off
fi
