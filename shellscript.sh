#!/bin/bash

# Script: shellscript.sh
# Description: This script generates onion service configurations for Tor.
# Author: Botdigit

# Define the path to the Tor configuration file
TOR_CONFIG="/etc/tor/torrc"

# Check if number of services and directory name are provided as arguments
if [ "$#" -eq 2 ]; then
    num_services="$1"
    last_directory_name="$2"
    clear_config=""
elif [ "$#" -eq 3 ]; then
    num_services="$1"
    last_directory_name="$2"
    clear_config="$3"
else
    echo "Usage: $0 <number_of_services> <last_directory_name> [clear]"
    exit 1
fi

# Define the static part of the directory path
static_directory="/var/lib/tor/"

# Function to check if a directory exists
directory_exists() {
    if [ -d "$1" ]; then
        return 0  # Directory exists
    else
        return 1  # Directory does not exist
    fi
}


# Function to generate onion service configurations
generate_onion_service_configurations() {
    # Create an array to store configured directories
    configured_directories=()

    # Read existing directory configurations from torrc
    while IFS= read -r line; do
        if [[ $line == HiddenServiceDir* ]]; then
            configured_directories+=("${line#HiddenServiceDir }")
        fi
    done < "$TOR_CONFIG"

    for ((i = 1; i <= num_services; i++)); do
        directory="${static_directory}${last_directory_name}_${i}/"
        if directory_exists "$directory"; then
            echo "Directory $directory exists."
            # Check if directory is configured
            if [[ " ${configured_directories[@]} " =~ " ${directory} " ]]; then
                echo "Directory $directory is already configured in $TOR_CONFIG. Skipping configuration."
            else
                # Generate a new onion service configuration in torrc
                cat << EOF >> "$TOR_CONFIG"
HiddenServiceDir $directory
HiddenServicePort 80 127.0.0.1:$((i * 1000 + 80))
EOF
            fi
        else
            echo "Directory $directory does not exist. Creating configuration."
            # Generate configuration for non-existing directory
            cat << EOF >> "$TOR_CONFIG"
HiddenServiceDir $directory
HiddenServicePort 80 127.0.0.1:$((i * 1000 + 80))
EOF
        fi
    done
}



# Function to clear Tor configuration file
clear_tor_config() {
    if [ "$clear_config" = "clear" ]; then
        echo "Clearing Tor configuration file..."
        echo "" > "$TOR_CONFIG"
        cat << EOF >> "$TOR_CONFIG"
RunAsDaemon 1
EOF
    fi
}

# Function to restart Tor
restart_tor() {
    # Check if Tor is already running
    if pgrep -x "tor" >/dev/null; then
        # Stop Tor
        sudo pkill -x tor
    fi
    # Start Tor as debian-tor user
    sudo -u debian-tor tor
    # Restart Tor to apply the new configurations
    systemctl restart tor
}

# Function to retrieve and display onion addresses for generated services
retrieve_onion_addresses() {
    for ((i = 1; i <= num_services; i++)); do
        onion_address_file="${static_directory}${last_directory_name}_${i}/hostname"
        if [ -f "$onion_address_file" ]; then
            onion_address=$(cat "$onion_address_file")
            echo "Onion Address for service $i: $onion_address"

            # Add the onion address to aapanel website configuration (You need to implement this part)
            # Example: aapanel add_onion_address $onion_address
        else
            echo "Error: Onion Address file not found for service $i"
        fi
    done
}

# Clear Tor configuration if specified
clear_tor_config

# Generate onion service configurations
generate_onion_service_configurations

# Restart Tor to apply the new configurations
restart_tor

# Retrieve and display onion addresses for generated services
retrieve_onion_addresses
