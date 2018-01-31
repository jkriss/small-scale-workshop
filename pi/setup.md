---
layout: ../layout.html
---

# [small scale tech / altcloud](../) / raspberry pi

These instructions assume a Raspberry Pi Zero W and a microSD card that's already set up to join a wifi network and run in OTG Ethernet mode. (This is easiest to do with [PiBakery](pibakery.org) if you're starting from scratch.)

### Set a hostname and password

Note: On Windows, you'll probably need [Bonjour](/Bonjour64.msi) for the .local domains to work, unless you have [iTunes](https://www.apple.com/lae/itunes/download/) installed already.

1. Connect the Pi to your laptop, making sure to use the "USB" port (not "PWR")
1. After it boots, open a terminal window and connect with `ssh pi@raspberrypi.local` (initial password: raspberry)
1. Change the password by running `passwd` (making note of the new password)
1. Change the hostname by editing two files. Change all values of "raspberrypi" to the hostname you want.
  1. `sudo pico /etc/hostname`
  1. `sudo pico /etc/hosts`
1. Reboot by running `sudo shutdown -r now`

### Get on wifi

1. Run `sudo pico /etc/wpa_supplicant/wpa_supplicant.conf`
1. Add this block for Art Center wifi (or follow [the instructions](https://www.raspberrypi.org/documentation/configuration/wireless/wireless-cli.md) to set up another network):

        network={
            ssid="ACCDPUBNET"
            key_mgmt=NONE
            id_str="artcenter"
            priority=2
        }

1. Save changes and run `sudo wpa_cli -i wlan0 reconfigure`
1. Run `ifconfig wlan0` to make sure you have an IP address assigned

At this point, your Pi only needs power, and you can access it over the network with `ssh pi@yourhostname.local`.

<!-- ### Free standing

1. Join the "smallscale" wifi network (password: ursulafranklin) on your laptop
1. Run `ssh pi@newhostname.local` (use new password) from your laptop (at this point, the Pi just needs to be powered)
1. Make an index file with `pico index.html` and type some stuff in it. Save and exit.
1. Run `altcloud`, and wait for some terminal output
1. Open `http://yourhostname.local:3000` on your laptop -->

### Add files

1. Download and install [Cyberduck](https://cyberduck.io)
1. Connect to your Pi
  1. Open connection
  1. Choose "SFTP"
  1. Add your hostname, username, and password
1. Upload files, and they'll be served by altcloud
