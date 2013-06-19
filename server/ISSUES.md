# Previous Deployment Issues

## Meteor and Nginx

* When meteor package `force-ssl` is used, `x-forwarded-proto` header must be passed to meteor so that it knows https is successfully redirected to. So in the nginx configuration file, adding the line `proxy_set_header X-Forwarded-Proto $scheme;` will do the trick.