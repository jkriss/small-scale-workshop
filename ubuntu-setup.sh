echo -e "\nWhat's your email address (used for Let's Encrypt SSL cert registration)?"

read email

echo -e "\n-- installing wget and sudo if needed\n"
apt-get update
apt-get install -y wget sudo

cd ~
echo -e "\n-- downloading altcloud executable\n"
wget https://altcloud.io/linux-x64/altcloud
chmod a+x altcloud
sudo mv altcloud /usr/local/bin


# set up altcloud user
echo -e "\n-- setting up altcloud user\n"
sudo adduser --disabled-password --gecos ""  altcloud ; true
sudo setcap cap_net_bind_service=+ep `readlink -f \`which altcloud\``

echo -e "\n-- setting up altcloud service\n"
# set up service
sudo cat > /etc/systemd/system/altcloud.service <<- EOM
[Service]
ExecStart=/usr/local/bin/altcloud server /home/altcloud/webroot
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
sudo -u altcloud mkdir -p /home/altcloud/webroot
cd /home/altcloud/webroot
sudo -u altcloud altcloud keys
sudo -u altcloud echo -e "Hello world!" > index.html
sudo -u altcloud cat > .config <<- EOM
letsencrypt:
  email: $email
EOM

# switch back to root, start service
cd ~
echo -e "\n-- starting altcloud service\n"
systemctl enable altcloud
systemctl start altcloud

echo -e "done!"
