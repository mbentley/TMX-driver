#!/bin/bash
# TMX Wheel Initialization Script
# Run this script after plugging in your TMX wheel

echo "Initializing Thrustmaster TMX wheel..."
echo "This script will temporarily unload xpad, initialize the TMX, then reload xpad."
echo ""

# Check if running as root
if [ "$EUID" -ne 0 ]; then
    echo "Please run as root (use sudo)"
    exit 1
fi

# Unload xpad
echo "Unloading xpad driver..."
rmmod xpad 2>/dev/null || echo "xpad already unloaded"

# Wait a moment
sleep 1

echo ""
echo "Please unplug your TMX wheel now and wait 2 seconds..."
read -p "Press Enter when you've unplugged the wheel..."

echo ""
echo "Now plug in your TMX wheel..."
read -p "Press Enter after plugging in the wheel..."

# Wait for initialization
echo "Waiting for tmx_driver to initialize the wheel..."
sleep 3

# Reload xpad for other controllers
echo "Reloading xpad for other controllers..."
modprobe xpad

echo ""
echo "Done! Check 'dmesg | tail -30' to verify the wheel was initialized correctly."
echo "You should see 'hid-t150' claiming the Thrustmaster TMX Racing Wheel."
