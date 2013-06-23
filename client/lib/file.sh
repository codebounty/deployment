# File related operations
#
# Author: Kaiwen Xu <kevin@kevxu.net>
#
# Depends:
#   ssh
#

CHECKSUM="md5"

cb_verify_file() {
    LOCAL_FILE=$1
    REMOTE_FILE=$2

    LOCAL_FILE_CHECKSUM=$(openssl $CHECKSUM $LOCAL_FILE)
    REMOTE_FILE_CHECKSUM=$(cb_ssh_verbose openssl $CHECKSUM $REMOTE_FILE)

    LOCAL_FILE_CHECKSUM=$(echo $LOCAL_FILE_CHECKSUM | sed -e 's/^[^ ]* //')
    REMOTE_FILE_CHECKSUM=$(echo $REMOTE_FILE_CHECKSUM | sed -e 's/^[^ ]* //')

    if [ "$LOCAL_FILE_CHECKSUM" == "$REMOTE_FILE_CHECKSUM" ]; then
        return 0
    else
        echo >&2 "Local file $LOCAL_FILE doesn't match with remote file $REMOTE_FILE"
        return 1
    fi
}
