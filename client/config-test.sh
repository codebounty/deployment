# Helper script for validating configuration file
#
# Author: Kaiwen Xu <kevin@kevxu.net>
#

_PASS_SSH=false
_PASS_SCP=false
_PASS_REMOTE=false
_PASS_GROUP=false
_PASS_ROOT=false
_PASS_ADMIN_USER=false
_PASS_INIT_SCRIPT=false

_error_not_set() {
    echo "$1: variable $2 not set" >&2
    exit 1
}

_error_not_found() {
    if [ -z "$3" ]; then
        echo "$1: $2 not found" >&2
    else
        echo "$1: $2 not found $3" >&2
    fi

    exit 2
}

#
# Non-Admin config tests
#

test_config_ssh() {
    if $_PASS_SSH; then return 0; fi

    [ -z "$CB_SSH" ] && _error_not_set "$ME" "CB_SSH"
    [ ! -f "$CB_SSH" ] && _error_not_found "$ME" "$CB_SSH"

    _PASS_SSH=true
    if $VERBOSE; then echo "test_config_ssh passed"; fi
}

test_config_scp() {
    if $_PASS_SCP; then return 0; fi

    [ -z "$CB_SCP" ] && _error_not_set "$ME" "CB_SCP"
    [ ! -f "$CB_SCP" ] && _error_not_found "$ME" "$CB_SCP"

    _PASS_SCP=true
    if $VERBOSE; then echo "test_config_scp passed"; fi
}

test_config_remote() {
    if $_PASS_REMOTE; then return 0; fi

    # Test CB_REMOTE, CB_SSH_PORT and CB_USER
    [ -z "$CB_REMOTE" ] && _error_not_set "$ME" "CB_REMOTE"
    [ -z "$CB_SSH_PORT" ] && _error_not_set "$ME" "CB_SSH_PORT"
    [ -z "$CB_USER" ] && _error_not_set "$ME" "CB_USER"

    # Try access remote
    test_config_ssh
    "$CB_SSH" -p "$CB_SSH_PORT" -l "$CB_USER" "$CB_REMOTE" "uname" >/dev/null 2>&1 \
        || { echo "$ME: $CB_USER@$CB_REMOTE:$CB_SSH_PORT not accessible" >&2; exit 2; }

    _PASS_REMOTE=true
    if $VERBOSE; then echo "test_config_remote passed"; fi
}

test_config_group() {
    if $_PASS_GROUP; then return 0; fi

    [ -z "$CB_GROUP" ] && _error_not_set "$ME" "CB_GROUP"

    # Grep group using ssh
    test_config_ssh
    test_config_remote
    "$CB_SSH" -p "$CB_SSH_PORT" -l "$CB_USER" "$CB_REMOTE" "grep $CB_GROUP /etc/group >/dev/null" \
        || _error_not_found "$ME" "Group $CB_GROUP"

    _PASS_GROUP=true
    if $VERBOSE; then echo "test_config_group passed"; fi
}

test_config_root() {
    if $_PASS_ROOT; then return 0; fi

    [ -z "$CB_ROOT" ] && _error_not_set "$ME" "CB_ROOT"

    # Test folder existence using ssh
    test_config_ssh
    test_config_remote
    "$CB_SSH" -p "$CB_SSH_PORT" -l "$CB_USER" "$CB_REMOTE" "[ ! -d $CB_ROOT ]" \
        && _error_not_found "$ME" "$CB_ROOT" "on server"

    _PASS_ROOT=true
    if $VERBOSE; then echo "test_config_root passed"; fi
}

#
# Admin config tests
#

test_config_admin_user() {
    if $_PASS_ADMIN_USER; then return 0; fi

    # Test CB_REMOTE, CB_SSH_PORT and CB_ADMIN_USER
    [ -z "$CB_REMOTE" ] && _error_not_set "$ME" "CB_REMOTE"
    [ -z "$CB_SSH_PORT" ] && _error_not_set "$ME" "CB_SSH_PORT"
    [ -z "$CB_ADMIN_USER" ] && _error_not_set "$ME" "CB_ADMIN_USER"

    # Try access remote
    test_config_ssh
    "$CB_SSH" -p "$CB_SSH_PORT" -l "$CB_ADMIN_USER" "$CB_REMOTE" "uname" >/dev/null 2>&1 \
        || { echo "$ME: $CB_ADMIN_USER@$CB_REMOTE:$CB_SSH_PORT not accessible" >&2; exit 2; }

    _PASS_ADMIN_USER=true
    if $VERBOSE; then echo "test_config_admin_user passed"; fi
}

test_config_init_script() {
    if $_PASS_INIT_SCRIPT; then return 0; fi

    # Since using init script must has admin privilege,
    # test admin user accessible
    test_config_admin_user
    "$CB_SSH" -p "$CB_SSH_PORT" -l "$CB_ADMIN_USER" "$CB_REMOTE" "[ ! -f $CB_INIT_SCRIPT ]" \
        && _error_not_found "$ME" "$CB_INIT_SCRIPT" "on server"

    _PASS_INIT_SCRIPT=true
    if $VERBOSE; then echo "test_config_init_script passed"; fi
}

#
# Config test collections
#

test_config_non_admin() {
    test_config_ssh
    test_config_scp
    test_config_remote
    test_config_group
    test_config_root
}

test_config_admin() {
    test_config_admin_user
    test_config_init_script
}

test_config_all() {
    test_config_non_admin
    test_config_admin
}
