#!/bin/ash

# Function to print colored text
print_color() {
    local color_code=$1
    local text=$2
    echo -e "\033[${color_code}m${text}\033[0m"
}

# Check the board model
BOARD_NAME=$(cat /etc/board.json | jsonfilter -e '@["model"]["name"]')

if [ "$BOARD_NAME" != "Zbtlink ZBT-Z800AX" ]; then
    print_color "31" "This firmware is only suitable for Zbtlink ZBT-Z800AX."
    exit 1
fi

# Define variables
ROOTFS_URL="https://firmware.download.solomonricky.eu.org/firmware/custom/17-July-24-QSDK-qualcommax-ipq807x-zbtlink_zbt-z800ax-rootfs.dump"
ROOTFS_1_URL="https://firmware.download.solomonricky.eu.org/firmware/custom/17-July-24-QSDK-qualcommax-ipq807x-zbtlink_zbt-z800ax-rootfs_1.dump"
ROOTFS="/tmp/17-July-24-QSDK-qualcommax-ipq807x-zbtlink_zbt-z800ax-rootfs.dump"
ROOTFS_1="/tmp/17-July-24-QSDK-qualcommax-ipq807x-zbtlink_zbt-z800ax-rootfs_1.dump"
ROOTFS_EXPECTED_SHA256="c4cb5b528ce35ac4b63c1af8c73aff7f29eb78b8b0cb1bbd83e092ff414f2237"
ROOTFS_1_EXPECTED_SHA256="d16e25f5266be02fd5627814f84f210ce43161ba982985b751fff0743bca05d1"
ROOTFS_PARTITION=$(grep '"rootfs"' /proc/mtd | awk -F: '{print $1}')
ROOTFS_1_PARTITION=$(grep '"rootfs_1"' /proc/mtd | awk -F: '{print $1}')

# Install packages
print_color "34" "Installing packages... Please wait..."
opkg update
opkg install nand-utils

# Download the file
print_color "34" "Downloading firmware... Please wait..."
wget -O $ROOTFS $ROOTFS_URL
wget -O $ROOTFS_1 $ROOTFS_1_URL

# Calculate the SHA-256 checksum
ROOTFS_ACTUAL_SHA256=$(sha256sum $ROOTFS | awk '{ print $1 }')
ROOTFS_1_ACTUAL_SHA256=$(sha256sum $ROOTFS_1 | awk '{ print $1 }')

# Compare the checksum
if [ "$ROOTFS_ACTUAL_SHA256" == "$ROOTFS_EXPECTED_SHA256" ] && [ "$ROOTFS_1_ACTUAL_SHA256" == "$ROOTFS_1_EXPECTED_SHA256" ]; then
    print_color "32" "This firmware is suitable for Zbtlink ZBT-Z800AX."
    # Prompt user for confirmation
    read -p "$(print_color "33" "Do you confirm you want to revert to stock firmware (Y/N)? ")" CONFIRM
    if [ "$CONFIRM" == "Y" ] || [ "$CONFIRM" == "y" ]; then
        mtd erase rootfs_1 && nandwrite /dev/$ROOTFS_1_PARTITION $ROOTFS_1
        mtd erase rootfs && nandwrite /dev/$ROOTFS_PARTITION $ROOTFS
        print_color "32" "Firmware reverted successfully."
        reboot
    else
        print_color "31" "Operation cancelled by user."
    fi
else
    print_color "31" "SHA-256 checksum does not match. File may be corrupted."
fi
