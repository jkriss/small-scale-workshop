---
layout: ../layout.html
---

# [small scale tech / altcloud](../) / cloud

1. Sign up with a cloud hosting provider, like [Linode](https://linode.com), [DigitalOcean](https://digitalocean.com), or [Amazon Lightsail](https://lightsail.aws.amazon.com)
1. Create a new server using the most recent version of Ubuntu
1. Connect to your instance following the instructions for your provider
1. Download the altcloud binary:

        wget https://altcloud.io/linux-x64/altcloud

1. Change the permissions

        sudo chmod a+x altcloud

1. Copy to /usr/local/bin

        sudo cp altcloud /usr/local/bin/

1. Create a user for altcloud

        sudo adduser --disabled-password --gecos ""  altcloud

1. Let node run on low numbered ports (like 80, 443)

        sudo setcap cap_net_bind_service=+ep `readlink -f \`which altcloud\``

1. Add the service configuration so it starts on every boot.

        sudo pico /etc/systemd/system/altcloud.service

1. Paste the following text into the file and save:

        [Service]
        ExecStart=/usr/local/bin/altcloud server /home/altcloud/webroot
        Restart=always
        StandardOutput=syslog
        StandardError=syslog
        SyslogIdentifier=altcloud
        User=altcloud
        Group=altcloud

        [Install]
        WantedBy=multi-user.target

1. Create a webroot directory as the altcloud user

        su altcloud
        cd ~
        mkdir webroot

1. Create the keys

        altcloud keys

1. Switch back to root and enable the service

        exit
        systemctl enable altcloud
        systemctl start altcloud

1. Put your files in `/home/altcloud/webroot`

1. Open up http://your.ip.address:3000

## Bonus points

1. Set up DNS so that you have a domain for your server. (Your hosting provider may do this, or you can use a service like [Namecheap](https://www.namecheap.com) or [AWS Route53](https://aws.amazon.com/route53/)).

1. Set the NODE_ENV to production to enable SSL:

      sudo pico /etc/systemd/system/altcloud.service

1. Add the following line after `Group=altcloud`:

      Environment=NODE_ENV=production

1. Save the file, then run

      systemctl daemon-reload
      systemctl restart altcloud

1. Now you should be able to access your server at https://your-domain-name.com
