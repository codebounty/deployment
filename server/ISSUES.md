# Previous Deployment Issues and Suggestions

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

* DO NOT mount and do fsck on normal file in /etc/fstab.
    * If the file is not found (due to certain partition is mounted yet), fsck will exit with error code, which cause the system to prompt you if you want to go to maintenance shell and the system will fail to boot since you do not have physical access to it.

* It's NOT recommended to mount ephemeral storage device in /etc/fstab.
    * Ephemeral store will be cleared out if you stopped the instance.
