# Global configuration file

# Client side settings
CB_SSH="/usr/bin/ssh"
CB_SCP="/usr/bin/scp"

# Server side settings
CB_REMOTE="app.codebounty.co"
CB_SSH_PORT="22"
CB_USER="codebounty"
CB_GROUP="$CB_USER"         # Group CB_USER belongs to, usually same as CB_USER. Used for chown.
CB_ROOT="/srv/codebounty"   # Server directory root

# Server side admin related settings
CB_ADMIN_USER="admin"       # Admin user who has sudo privilege
CB_INIT_SCRIPT="/etc/init.d/codebounty"

# Misc settings
VERBOSE=true

#####################
# DO NOT EDIT BELOW #
#####################
ME=`basename $0`
