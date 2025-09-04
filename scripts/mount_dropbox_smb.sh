#!/bin/bash
# File: ~/mount_dropbox.sh

# Configuration
USERNAME="itissid"
SERVICE="DropboxSMB"   # Keychain service name
HOST="192.168.1.50"   # or the static IP, e.g. 192.168.1.101
SHARE="DropboxShare"
MOUNT_POINT="/Users/sid/DropboxTruenas"

# Retrieve Password from Keychain
PASSWORD=$(security find-generic-password -a "$USERNAME" -s "$SERVICE" -w)

# Create mount point if it doesn't exist
mkdir -p "$MOUNT_POINT"
urlencode() {
    local raw="$1"
    local encoded=""
    local i
    local char
    local hex

    for (( i=0; i<${#raw}; i++ )); do
        char="${raw:$i:1}"
        case "$char" in
            [a-zA-Z0-9.~_-]) encoded+="$char" ;;
            *)
                hex=$(printf '%02X' "'$char")
                encoded+="%$hex"
                ;;
        esac
    done
    echo "$encoded"
}
ENCODED_PASSWORD=$(urlencode "$PASSWORD")

# Attempt to mount
mount_smbfs "//${USERNAME}:${ENCODED_PASSWORD}@${HOST}/${SHARE}" "${MOUNT_POINT}"
