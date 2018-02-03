#!/bin/bash

echo -e "\nWhat's your email address (used for Let's Encrypt SSL cert registration)?"

read email

if ! which wget
  then echo -e "\n-- installing wget\n" ; sudo apt-get update ; sudo apt-get install -y wget
fi

arch=`uname -m`

case $arch in
  x86_64)
    suffix="x64"
    ;;
  armv6l)
    suffix="armv6"
    ;;
esac

cd ~
if [ ! -f /usr/local/bin/altcloud ]; then
  echo -e "\n-- downloading altcloud executable for $arch\n"
  wget https://altcloud.io/linux-$suffix/altcloud
  chmod a+x altcloud
  sudo mv altcloud /usr/local/bin
fi

# set up altcloud user
echo -e "\n-- setting up altcloud user\n"
altcloudPassword=`openssl rand -base64 12`
sudo adduser --disabled-password --gecos ""  altcloud ; true
echo -e "$altcloudPassword\n$altcloudPassword\n" | sudo passwd altcloud
sudo setcap cap_net_bind_service=+ep `readlink -f \`which altcloud\``

echo -e "\n-- setting up altcloud service\n"
# set up service
sudo tee /etc/systemd/system/altcloud.service <<- EOM
[Service]
ExecStart=/usr/local/bin/altcloud server
WorkingDirectory=/home/altcloud/webroot/
Restart=always
StandardOutput=syslog
StandardError=syslog
SyslogIdentifier=altcloud
User=altcloud
Group=altcloud
Environment=NODE_ENV=production

[Install]
WantedBy=multi-user.target
EOM

# switch to that user, make stuff
echo -e "\n-- creating webroot, keys, config, index page (as altcloud)\n"
cd /home/altcloud
sudo -u altcloud mkdir -p webroot
cd webroot
sudo -u altcloud altcloud keys
echo "Hello world!" | sudo -u altcloud tee index.html
sudo -u altcloud tee .config <<- EOM
letsencrypt:
  email: $email
EOM

# switch back to root, start service
cd ~
echo -e "\n-- starting altcloud service\n"
sudo systemctl enable altcloud
sudo systemctl daemon-reload
sudo systemctl restart altcloud

echo -e "done!\n"

ips=`hostname -I`
echo "Listening at:"
for ip in $ips
do
    echo "https://$ip"
done

echo -e "\nConnect with ssh (or scp or sftp) using:\n\nusername: altcloud\npassword: $altcloudPassword\n"
