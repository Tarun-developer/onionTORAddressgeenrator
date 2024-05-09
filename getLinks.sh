#!/bin/bash

# Define the path to the Tor configuration file
TOR_CONFIG="/etc/tor/torrc"

# Function to read torrc file and extract onion directories
read_torrc_and_extract_directories() {
    # Array to store onion directories
    onion_directories=()

    # Read torrc file and extract onion directories
    while IFS= read -r line; do
        if [[ $line == HiddenServiceDir* ]]; then
            onion_directories+=("${line#HiddenServiceDir }")
        fi
    done < "$TOR_CONFIG"

    # Output the onion directories
    echo "Onion Directories:"
    for dir in "${onion_directories[@]}"; do
        echo "$dir"
    done
}

# Function to retrieve onion links from hostname files
retrieve_onion_links() {
    echo "Onion Links:"
    for dir in "${onion_directories[@]}"; do
        hostname_file="${dir}/hostname"
        if [ -f "$hostname_file" ]; then
            onion_link=$(cat "$hostname_file")
            echo "$onion_link"
        else
            echo "Error: Hostname file not found for directory $dir"
        fi
    done
}

# Main function
main() {
    # Read torrc file and extract onion directories
    read_torrc_and_extract_directories

    # Retrieve onion links from hostname files
    retrieve_onion_links
}

# Execute main function
main
