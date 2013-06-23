# Admin related operations
#
# Author: Kaiwen Xu <kevin@kevxu.net>
#

cb_admin_ssh() {
    if $VERBOSE; then
        "$CB_SSH" -p "$CB_SSH_PORT" -l "$CB_ADMIN_USER" "$CB_REMOTE" "$@"
    else
        "$CB_SSH" -p "$CB_SSH_PORT" -l "$CB_ADMIN_USER" "$CB_REMOTE" "$@" >/dev/null
    fi
}

cb_admin_restart_server() {
    cb_admin_ssh "sudo" "/etc/init.d/codebounty" "restart"
}
