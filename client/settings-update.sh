#! /bin/sh
#
# Script for updating codebounty server side settings.json
#
# Author: Kaiwen Xu <kevin@kevxu.net>
#
# Usage: update-settings.sh [file]
#

# Load and validate configurations
. `dirname $0`/config.sh
. `dirname $0`/config-test.sh
test_config_all

# Load dependencies
. `dirname $0`/lib/ssh.sh
. `dirname $0`/lib/admin.sh
. `dirname $0`/lib/file.sh

set -e

SETTINGS_FILE="settings.json"
SETTINGS_PATH="$CB_ROOT/$SETTINGS_FILE"
SETTINGS_PERMISSION="0600"

usage() {
    echo "Usage: $ME [file]" >&2
    exit 3
}

# Check argument
[ -z "$1" ] && usage
[ ! -f "$1" ] && { echo "$ME: $1 not found" >&2; exit 2; }

# Upload settings file
if $VERBOSE; then echo "Uploading $1 to $SETTINGS_PATH on server..."; fi
cb_scp_upload "$1" "$SETTINGS_PATH"

if $VERBOSE; then echo "Changing ownership and permission of $SETTINGS_PATH..."; fi
cb_admin_ssh "sudo" "chown" "$CB_USER:$CB_GROUP" "$SETTINGS_PATH"    # Ensure setting file ownership
cb_ssh "chmod" "$SETTINGS_PERMISSION" "$SETTINGS_PATH"

if $VERBOSE; then echo "Verifying file integrity..."; fi
cb_verify_file "$1" "$SETTINGS_PATH"

# Restart server
cb_admin_restart_server

if [ $? -eq 0 ]; then
    echo "Successfully updated settings with $1"
    exit 0
fi
