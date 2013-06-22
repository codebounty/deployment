# Helper script for validating configuration file

test_config_ssh() {
    [ -z "$CB_SSH" ] && { echo "$0: variable CB_SSH not set"; exit 1; }
    [ ! -f "$CB_SSH" ] && { echo "$0: $CB_SSH not found"; exit 2; }
}

test_config_scp() {
    [ -z "$CB_SCP" ] && { echo "$0: variable CB_SCP not set"; exit 1; }
    [ ! -f "$CB_SCP" ] && { echo "$0: $CB_SCP not found"; exit 2; }
}

test_config_remote() {
    [ -z "$CB_REMOTE" ] && { echo "$0: varibale CB_REMOTE not set"; exit 1; }
}

test_config_ssh_port() {
    [ -z "$CB_SSH_PORT" ] && { echo "$0: varibale CB_SSH_PORT not set"; exit 1; }
}

test_config_all() {
    test_config_ssh
    test_config_scp
    test_config_remote
    test_config_ssh_port
}
