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

cb_admin_start_server() {
    cb_admin_ssh "sudo" "$CB_INIT_SCRIPT" "start"
}

cb_admin_restart_server() {
    cb_admin_ssh "sudo" "$CB_INIT_SCRIPT" "restart"
}

cb_admin_stop_server() {
    cb_admin_ssh "sudo" "$CB_INIT_SCRIPT" "stop"
}

cb_admin_start_test_server() {
    cb_admin_ssh "sudo" "$CB_INIT_SCRIPT_TEST" "start"
}

cb_admin_restart_test_server() {
    cb_admin_ssh "sudo" "$CB_INIT_SCRIPT_TEST" "restart"
}

cb_admin_stop_test_server() {
    cb_admin_ssh "sudo" "$CB_INIT_SCRIPT_TEST" "stop"
}
