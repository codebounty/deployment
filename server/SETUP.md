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

### Run Commands

```
# Login as root
sudo -i

apt-get update && apt-get -y upgrade

# Configure timezone
dpkg-reconfigure tzdata

# Install packages
apt-get -y install vim curl

apt-get -y install fail2ban monit

# Install Nginx
cat << EOF >> /etc/apt/sources.list
deb http://nginx.org/packages/debian/ wheezy nginx
deb-src http://nginx.org/packages/debian/ wheezy nginx
EOF

curl http://nginx.org/keys/nginx_signing.key > /tmp/nginx_signing.key

apt-key add /tmp/nginx_signing.key && rm -f /tmp/nginx_signing.key

apt-get update && apt-get -y install nginx
```