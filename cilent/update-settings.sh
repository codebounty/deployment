#! /bin/bash
#
# Script for updating codebounty server side settings.json.
#
# Usage: update-settings.sh [file]
#

# Loading configurations
. `dirname $0`/config.sh

usage() {
    echo "Usage: $0 [file]"
}


