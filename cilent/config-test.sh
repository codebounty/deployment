# Helper script for validating configuration file

test_ssh() {
    [ -z "$SSH" ] && { echo "$0: variable SSH not set" ; exit 1; }
    [ ! -f "$SSH" ] && { echo "$0: $SSH not found" ; exit 2; }
}


