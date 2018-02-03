---
layout: ../layout.html
---

# [small scale tech / altcloud](../) / cloud

1. Sign up with a cloud hosting provider, like [Linode](https://linode.com), [DigitalOcean](https://digitalocean.com), or [Amazon Lightsail](https://lightsail.aws.amazon.com)
1. Create a new server using the most recent version of Ubuntu
1. Connect to your instance following the instructions for your provider
1. As root, run `bash <(curl -s https://workshop.altcloud.io/setup.sh)`
1. Open up https://your.ip.address (you'll get a certificate warning until you assign a domain name)
1. Add files to `/home/altcloud/webroot/` as you desire

## Bonus points

1. Set up DNS so that you have a domain for your server. (Your hosting provider may do this, or you can use a service like [Namecheap](https://www.namecheap.com) or [AWS Route53](https://aws.amazon.com/route53/)).
1. Now you should be able to access your server at https://your-domain-name.com

## Double bonus

1. Assign a wildcard DNS entry (e.g. `*.your-domain-name.com`) that resolves to your server's IP address, and all subdomains will automatically be served by your altcloud server.
