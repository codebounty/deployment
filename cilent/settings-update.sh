#! /bin/sh
#
# Script for updating codebounty server side settings.json
#
# Usage: update-settings.sh [file]
#

# Load and validate configurations
. `dirname $0`/config.sh
. `dirname $0`/config-test.sh
test_config_all

usage() {
    echo "Usage: $0 [file]"
}

# Check argument
[ -z "$1" ] && { usage; exit 3; }
[ ! -f "$1" ] && { echo "$0: $1 not found"; exit 2; }

# Upload settings file
