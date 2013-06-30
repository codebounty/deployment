# Previous Deployment Issues

## Meteor and Nginx

* Requires `Nginx >= 1.3.1` for websocket forwarding to work.
	1. Since nginx package from official debian repository is only version `1.2.1`, use packages from nginx instead.
	2. To add following two lines into `/etc/apt/sources.list` (If you are using debian 7. Change `wheezy` accordingly if you are using different version of debian)
		* `deb http://nginx.org/packages/debian/ wheezy nginx`
		* `deb-src http://nginx.org/packages/debian/ wheezy nginx`
	3. Download and add nginx package pgp signing key
		* `wget http://nginx.org/keys/nginx_signing.key`
		* `apt-key add nginx_signing.key && rm nginx_signing.key`
	4. Update repository and install nginx
		* `apt-get update && apt-get install nginx`

* When meteor package `force-ssl` is used, `x-forwarded-proto` header must be passed to meteor so that it knows https is successfully redirected to.
	* So in the nginx configuration file, adding the line `proxy_set_header X-Forwarded-Proto $scheme;` will do the trick.

* DO NOT mount any files exists on ephemeral storage in /etc/fstab !!!
	* If the instance is stopped, ephemeral storage will be deleted and system will fail to boot because of missing file.
