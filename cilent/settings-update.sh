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
    echo "Usage: $ME [file]"
    exit 3
}

# Check argument
[ -z "$1" ] && usage
[ ! -f "$1" ] && { echo "$ME: $1 not found"; exit 2; }

# Upload settings file
