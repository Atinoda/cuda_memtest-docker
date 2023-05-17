#!/bin/bash
set -e

# Function to handle keyboard interrupt
function ctrl_c {
    echo -e "\nAborting test!"
    # Add your cleanup actions here
    exit 0
}
# Register the keyboard interrupt handler
trap ctrl_c SIGTERM SIGINT SIGQUIT SIGHUP ERR

$@
