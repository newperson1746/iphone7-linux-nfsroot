# iphone7-linux-nfsroot
Helper files to set up an iPhone 7 on the Sandcastle linux port to boot mainline distros by nfs
https://www.reddit.com/r/linux/comments/kvmsfd/success_iphone_7_booting_ubuntu_2004_to_full/

## firmware/D10.mtprops 
Properties file for hx-touchd. Install in a convenient location like /lib/firmware, and make sure to change it to match in the hx-touchd service file down below.

## 70-iphone7.rules
If you replaced the MAC of g_ether, replace it here as well. Also put the path to `ethbridge.sh` on your computer.

## ethbridge.sh
Replace enp ifname with yours.

## g_ether_dns.service 
Install and enable in /etc/systemd/system to fix DNS not being set on boot 

## hx-touchd.service
Install and enable in /etc/systemd/system to supposedly enable touchscreen, though it did not work for me as it depends on working NAND flash for pulling config. Use with hx-touchd from project sandcastle.

## vino-server.desktop
Install in ~/.config/autostart to autostart Vino VNC on login. To make it work on boot, you'll want to enable automatic login in /etc/gdm3/custom.conf AND run "gsettings set org.gnome.Vino prompt-enabled false" to disable the prompt that you can't interact with (if touchscreen not working)
