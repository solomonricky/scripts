#!/bin/ash

# Define variables
URL="https://firmware.download.solomonricky.eu.org/firmware/custom/02-Jan-24-QSDK-qualcommax-ipq807x-zbtlink_zbt-z800ax-rootfs.bin"
FILE="/tmp/02-Jan-24-QSDK-qualcommax-ipq807x-zbtlink_zbt-z800ax-rootfs.bin"
EXPECTED_SHA256="d16e25f5266be02fd5627814f84f210ce43161ba982985b751fff0743bca05d1"

# Download the file
echo "Downloading firmware... Please wait..."
wget -O $FILE $URL

# Calculate the SHA-256 checksum
ACTUAL_SHA256=$(sha256sum $FILE | awk '{ print $1 }')

# Compare the checksum
if [ "$ACTUAL_SHA256" == "$EXPECTED_SHA256" ]; then
    echo "This firmware only suitable for ZBT Z800AX"
    # Prompt user for confirmation
    read -p "Do you confirm you want to revert to stock firmware (Y/N)? " CONFIRM
    if [ "$CONFIRM" == "Y" ] || [ "$CONFIRM" == "y" ]; then
        mtd write $FILE rootfs_1 && mtd -r write $FILE rootfs
    else
        echo "Operation cancelled by user."
    fi
else
    echo "SHA-256 checksum does not match. File may be corrupted."
fi
