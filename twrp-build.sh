#!bin/bash

# Go to the working directory
mkdir ~/TWRP-10 && cd ~/TWRP-10

# Configure git
git config --global user.email "100Daisy@protonmail.com"
git config --global user.name "GitDaisy"
git config --global color.ui false

# Sync the source
repo init --depth=1 -u git://github.com/minimal-manifest-twrp/platform_manifest_twrp_omni.git -b twrp-10.0
repo sync  -f --force-sync --no-clone-bundle --no-tags -j$(nproc --all)

# Clone device tree and common tree
git clone --depth=1 https://github.com/100Daisy/android_device_motorola_guamp -b android-10-caprip-prebuilt device/motorola/guamp

# Build recovery image
export ALLOW_MISSING_DEPENDENCIES=true; . build/envsetup.sh; lunch omni_guamp-eng; make -j$(nproc --all) recoveryimage
