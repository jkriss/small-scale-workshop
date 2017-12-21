---
layout: ../layout.html
---

## Raspberry Pi setup

These instructions assume a Raspberry Pi Zero W and a microSD card that's already set up to join a wifi network and run in OTG Ethernet mode. (This is easiest to do with [PiBakery](pibakery.org) if you're starting from scratch.)

### Plug in directly

1. Connect the Pi to your laptop, making sure to use the "USB" port (not "PWR")
1. After it boots, open a terminal window and connect with `ssh pi@raspberrypi.local` (initial password: raspberry)
1. Change the password by running `passwd` (making note of the new password)
1. Change the hostname to something like `yournamepi.local` by editing two files:
  1. `sudo pico /etc/hostname`
  1. `sudo pico /etc/hosts`
1. Reboot by running `sudo shutdown -r now`

### Free standing

1. Join the "smallscale" wifi network (password: ursulafranklin) on your laptop
1. Run `ssh pi@newhostname.local` (use new password) from your laptop (at this point, the Pi just needs to be powered)
1. Make an index file with `pico index.html` and type some stuff in it. Save and exit.
1. Run `altcloud`, and wait for some terminal output
1. Open `http://yourhostname.local:3000` on your laptop

### Add files

1. Download and install [Cyberduck](https://cyberduck.io)
1. Connect to your Pi
  1. Open connection
  1. Choose "SFTP"
  1. Add your hostname, username, and password
1. Upload files, and they'll be served by altcloud
