# Helper script for ssh related operations
#
# Author: Kaiwen Xu <kevin@kevxu.net>
#

cb_scp() {
    if $VERBOSE; then
        "$CB_SCP" -P "$CB_SSH_PORT" "$@"
    else
        "$CB_SCP" -P "$CB_SSH_PORT" "$@" >/dev/null
    fi
}

cb_scp_upload() {
    cb_scp "$1" "$CB_USER"@"$CB_REMOTE":"$2"
}

cb_scp_download() {
    cb_scp "$CB_USER"@"$CB_REMOTE":"$1" "$2"
}

cb_ssh() {
    if $VERBOSE; then
        "$CB_SSH" -p "$CB_SSH_PORT" -l "$CB_USER" "$CB_REMOTE" "$@"
    else
        "$CB_SSH" -p "$CB_SSH_PORT" -l "$CB_USER" "$CB_REMOTE" "$@" >/dev/null
    fi
}
