# Global configuration file

CB_SSH="/usr/bin/ssh"
CB_SCP="/usr/bin/scp"

CB_REMOTE="app.codebounty.co"
CB_SSH_PORT="22"
CB_USER="codebounty"
CB_GROUP="$CB_USER"         # Group CB_USER belongs to, usually same as CB_USER. Used for chown.
CB_ROOT="/srv/codebounty"   # Server directory root

VERBOSE=true

# DO NOT EDIT BELOW
ME=`basename $0`
