# Helper script for validating configuration file
#
# Author: Kaiwen Xu <kevin@kevxu.net>
#

_PASS_SSH=false
_PASS_SCP=false
_PASS_REMOTE=false
_PASS_GROUP=false
_PASS_ROOT=false

_error_not_set() {
    echo "$1: variable $2 not set"
    exit 1
}

_error_not_found() {
    echo "$1: $2 not found"
    exit 2
}

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

    # Test both CB_REMOTE, CB_SSH_PORT and CB_USER
    [ -z "$CB_REMOTE" ] && _error_not_set "$ME" "CB_REMOTE"
    [ -z "$CB_SSH_PORT" ] && _error_not_set "$ME" "CB_SSH_PORT"
    [ -z "$CB_USER" ] && _error_not_set "$ME" "CB_USER"

    # Try access remote
    test_config_ssh
    "$CB_SSH" -p "$CB_SSH_PORT" -l "$CB_USER" "$CB_REMOTE" "uname" >/dev/null 2>&1
    [ ! $? -eq 0 ] && { echo "$ME: $CB_USER@$CB_REMOTE:$CB_SSH_PORT not accessible via ssh"; exit 2; }

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

    if [ ! $? -eq 0 ]; then
        _error_not_found "$ME" "Group $CB_GROUP"
    fi

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
        && _error_not_found "$ME" "$CB_ROOT"

    _PASS_ROOT=true
    if $VERBOSE; then echo "test_config_root passed"; fi
}

test_config_all() {
    test_config_ssh
    test_config_scp
    test_config_remote
    test_config_group
    test_config_root
}
