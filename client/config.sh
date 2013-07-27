# Global configuration file

# Client side settings
CB_SSH="/usr/bin/ssh"
CB_SCP="/usr/bin/scp"

# Server side settings
CB_REMOTE="app.codebounty.co"
CB_REMOTE_TEST="x.codebounty.co"
CB_SSH_PORT="22"
CB_USER="codebounty"
CB_GROUP="$CB_USER"                             # Group CB_USER belongs to, usually same as CB_USER. Used for chown.
CB_ROOT="/srv/codebounty"                       # Server directory root
CB_REPO="$CB_ROOT/repo"                         # Directory for storing generated bundle
CB_GIT_REPO="/home/deploymentuser/codebounty.git"   # Git repository on server
CB_REPO_DEPLOY="$CB_ROOT/deployed"            # Deployed symbolic link
CB_REPO_TEST="$CB_ROOT/testing"              # Testing symbolic

# Server side admin related settings
CB_ADMIN_USER="admin"                           # Admin user who has sudo privilege
CB_INIT_SCRIPT="/etc/init.d/codebounty"
CB_INIT_SCRIPT_TEST="/etc/init.d/codebounty-test"

# Misc settings
VERBOSE=false

#####################
# DO NOT EDIT BELOW #
#####################
ME=`basename $0`
