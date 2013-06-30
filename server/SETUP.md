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

# Configure filesystem and reboot
fdisk /dev/xvdd
# Create primary partition 1, size +380G
# Create primary partition 2, size +10G
# Create primary partition 3, use rest of the space
# Change partition 3 to type 82 (Linux swap)
# Write changes

mkfs.ext4 /dev/xvdd1

mkfs.ext4 /dev/xvdd2

mkswap /dev/xvdd3

mkdir /local

cat << EOF >> /etc/fstab
/dev/xvdb   /home   ext4    defaults,nosuid,nodev   0 2
/dev/xvdc   /srv    ext4    defaults,nosuid,nodev   0 2
/dev/xvdd1  /local  ext4    defaults,nosuid,nodev   0 0
/dev/xvdd2  /tmp    ext4    defaults,nosuid,nodev,noexec 0 0
/dev/xvdd3  none    swap    sw 0 0
EOF

reboot

# Login as root
sudo -i

# Fix tmp folder permission
chown root:root /tmp && chmod 1777 /tmp

# Install packages
apt-get -y install vim curl git

apt-get -y install fail2ban monit

# Install Nginx
cat << EOF >> /etc/apt/sources.list
deb http://nginx.org/packages/debian/ wheezy nginx
deb-src http://nginx.org/packages/debian/ wheezy nginx
EOF

curl http://nginx.org/keys/nginx_signing.key > /tmp/nginx_signing.key

apt-key add /tmp/nginx_signing.key && rm -f /tmp/nginx_signing.key

apt-get update && apt-get -y install nginx

# Edit Grub configuration
# Edit file /etc/default/grub
# Change to GRUB_TIMEOUT=0
# Change to GRUB_CMDLINE_LINUX_DEFAULT=""
# Uncomment GRUB_DISABLE_RECOVERY="true"
# Save file

update-grub

```
