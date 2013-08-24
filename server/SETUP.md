# EC2 Setup Log

## Launch instance

### Choose an AMI
* Image Id: ami-ab3c57c2
* Owner: aws-marketplace
* Manifest: aws-marketplace/debian-wheezy-amd64-20130507-8e939b13-41b6-40bc-b2ba-481f2d6c5d79-ami-1d620e74.1
* Platform: Debian
* Architecture: x86_64
* Root Device Type: ebs

### Instance Details

* Number of Instances 1
* Instance Type: M1 Medium (m1.medium, 3.7 GiB)
* Launch Instances
    * Launch into: EC2-Classic
        * Availability Zone: us-east-1a
* Kernel ID: Use Default
* RAM Disk ID: Use Default
* Termination Protection: Prevention against accidental termination.
* Shutdown Behavior: Stop
* IAM Role: None
* Root Volume:
    * Volume Size: 8 GiB
    * Volume Type: Standard
    * Delete on Termination: false
    * Save
* Instance Store Volumes:
    * Instance Store: 0
    * Device: /dev/sdd
    * Add
* [{ 'Key': 'Name', 'Value': 'Codebounty' }]

### Configure Firewall

* Choose one or more of your existing Security Groups
    * sg-abb260c0 - codebounty

### Launch Instance

## Configure Instance

### Log into Instance

* Follow instructions
* Login use user ```admin```

### Stop and Attach EBS Volumes

* Run ```sudo poweroff```
* Go to Volumes
    * Attach ```vol-2426d17e - CbHome - in us-east-1a``` to Device ```/dev/sdb```
    * Attach ```vol-ca26d190 - CbSrv - in us-east-1a``` to Device ```/dev/sdc```
* Start instance

### Run Commands

```
# Login as root
sudo -i

apt-get update && apt-get -y upgrade

# Configure timezone
dpkg-reconfigure tzdata

cat << EOF >> /etc/fstab
/dev/xvdb   /home   ext4    defaults,nosuid,nodev   0 2
/dev/xvdc   /srv    ext4    defaults,nosuid,nodev   0 2
EOF

reboot

# Login as root
sudo -i

# Fix tmp folder permission
chown root:root /tmp && chmod 1777 /tmp

# Install packages
apt-get -y install vim curl git bzip2

apt-get -y install fail2ban monit unattended-upgrades apticron

apt-get -y install libcairo2-dev libjpeg8-dev libpango1.0-dev libgif-dev build-essential g++

# Install Nginx
cat << EOF >> /etc/apt/sources.list
deb http://nginx.org/packages/debian/ wheezy nginx
deb-src http://nginx.org/packages/debian/ wheezy nginx
EOF

curl http://nginx.org/keys/nginx_signing.key > /tmp/nginx_signing.key

apt-key add /tmp/nginx_signing.key && rm -f /tmp/nginx_signing.key

apt-get update && apt-get -y install nginx

# Add users
useradd bitcoind -d /home/bitcoind -r -s /bin/false -U -m

useradd bitcoind-test -d /home/bitcoind-test -r -s /bin/false -U -m

useradd codebounty -d /home/codebounty -s /bin/bash -U -m

useradd deploymentuser -d /home/deploymentuser -s /bin/bash -U -m

useradd clabot -d /home/clabot -s /bin/bash -U -m

chown -R bitcoind:bitcoind /home/bitcoind

chown -R bitcoind-test:bitcoind-test /home/bitcoind-test

chown -R codebounty:codebounty /home/codebounty /srv/codebounty

chown -R clabot:clabot /home/clabot /srv/clabot

chmod 700 /home/bitcoind /home/bitcoind-test /home/codebounty /home/codebounty-test /home/clabot

chmod 755 /home/deploymentuser

chmod 755 /srv/codebounty /srv/clabot

# Configure GRUB
# Copy /etc/default/grub into server

update-grub

# Configure fail2ban
# Copy /etc/fail2ban into server (merge folder, don't overwrite)

/etc/init.d/fail2ban reload

# Configure nginx
rm -f /etc/nginx/conf.d/*.conf

# Copy /etc/nginx into server (merge folder, don't overwrite)
# Copy decrypted ssl key into /etc/nginx/conf/ssl.key

chown root:root /etc/nginx/conf/ssl.key && chmod 400 /etc/nginx/conf/ssl.key

/etc/init.d/nginx reload

# Configure bitcoind
# Copy /etc/init.d/bitcoind into server

/etc/init.d/bitcoind start

update-rc.d bitcoind defaults

# Configure codebounty
# Copy /etc/init.d/codebounty into server
# Copy /etc/default/codebounty into server and add database password

mkdir -p /var/log/codebounty

/etc/init.d/codebounty start

update-rc.d codebounty defaults

# Configure bitcoind-test
# Copy /etc/init.d/bitcoind-test into server

/etc/init.d/bitcoind-test start

update-rc.d bitcoind-test defaults

# Configure codebounty-test
# Copy /etc/init.d/codebounty-test into server
# Copy /etc/default/codebounty-test into server and add database password

/etc/init.d/codebounty-test start

update-rc.d codebounty-test defaults

# Configure node-inspector
# Copy /etc/init.d/node-inspector into server

/etc/init.d/node-inspector start

update-rc.d node-inspector defaults

# Configure monit
# Copy /etc/monit into server (merge folder, don't overwrite)

/etc/init.d/monit reload

# Configure logrotate
# Copy /etc/logrotate.d into server (merge folder, don't overwrite)

# Fix log permissions (if not correct)
chown nginx:adm /var/log/nginx/*.log && chmod 640 /var/log/nginx/*.log

# Setup clabot
cd /srv/clabot

/opt/node/default/bin/npm install clabot

# Copy /srv/clabot/main.js into server

chown -R clabot:clabot /srv/clabot

# Copy /etc/init.d/clabot into server

update-rc.d clabot defaults

# Reboot server to test if everything works
reboot
```
