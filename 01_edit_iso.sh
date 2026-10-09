#!/bin/bash

set -eu -o pipefail

if [ "$FLAVOUR" = "ubuntustudio" ]; then
    SQUASHFILE = "casper/standard.squashfs"
else
    SQUASHFILE = "casper/filesystem.squashfs"
fi

# Prepare the ISO Directories
mkdir -p "$ISO_MOUNT_DIR" "$ISO_WORK_DIR" "$CHROOT_DIR"
# Mount the Original ISO and Copy Files
echo "mounting $ISO_IMAGE"
if [ ! -f "$ISO_IMAGE" ]; then
    echo "Error: ISO file $ISO_IMAGE not found."
    exit 1
fi
mount -o loop "$(pwd)/$ISO_IMAGE" "$ISO_MOUNT_DIR"
rsync -a "$ISO_MOUNT_DIR/" "$ISO_WORK_DIR"
umount "$ISO_MOUNT_DIR"
unsquashfs -d "$CHROOT_DIR" "$ISO_WORK_DIR/$SQUASHFILE"
rm "$(pwd)/$ISO_IMAGE"


