# Server Setup

** Caution: only use sudo when you have to. **

## Deployment

### Manual Deployment

1. Create bundle using `mrt bundle [file.tar.gz]`
2. Upload generated bundle tarball file to `/srv/codebounty` on server
3. Connect to server using user ***`codebounty`***, then `cd /srv/codebounty`
4. Extract bundle using `tar xvf [file.tar.gz]` 
5. Remove previous `deployed` symbolic link using `rm deployed`
6. Create new symbolic link point to latest version, `ln -s [extracted folder] deployed`
7. Log out *(because current user codebounty is not a sudoer, and it shall **NOT** be one)*
8. Connect to server using user ***`admin`***, restart node server using `sudo /etc/init.d/codebounty restart`
