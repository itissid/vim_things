#!/bin/bash

# Define your SMB share details
SERVER="smb://<server-ip>/<share-name>"
MOUNT_POINT="/Volumes/<share-name>"

# Check if the share is mounted
if ! mount | grep -q "$MOUNT_POINT"; then
    echo "$(date): Share is not mounted, attempting to reconnect..."
    # Attempt to remount the SMB share
    osascript <<EOF
    tell application "Finder"
        try
            mount volume "$SERVER" as user name "<username>" with password "<password>"
        end try
    end tell
