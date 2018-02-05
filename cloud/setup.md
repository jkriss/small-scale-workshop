---
layout: ../layout.html
---

# [small scale tech / altcloud](../) / cloud

1. Sign up with a cloud hosting provider, like [Vultr](https://vultr.com) ($2.5/month servers available in their Miami and New York locations), [Ramnode](https://ramnode.com/), [Linode](https://linode.com), [DigitalOcean](https://digitalocean.com), or [Amazon Lightsail](https://lightsail.aws.amazon.com)
1. Create a new server using the most recent version of Ubuntu
1. Connect to your instance following the instructions for your provider
1. Run `sudo apt-get update && apt-get install -y curl`
1. As root, run `bash <(curl -s https://workshop.altcloud.io/setup.sh)`

When the script finishes, you'll see the IP addresses for your server, as well as the generated password for the altcloud user. The server root will be `/home/altcloud/webroot`.

## Bonus points

1. Set up DNS so that you have a domain for your server. (Your hosting provider may do this, or you can use a service like [Namecheap](https://www.namecheap.com) or [AWS Route53](https://aws.amazon.com/route53/).)
1. Now you should be able to access your server at https://your-domain-name.com

## Double bonus

1. Assign a wildcard DNS entry (e.g. `*.your-domain-name.com`) that resolves to your server's IP address, and all subdomains will automatically be served by your altcloud server.
