# Onion Link Generator and Auto Site Creation for aapanel

This script automates the generation of onion links for Tor and facilitates the creation of auto sites in aapanel using PHP scripts.

## Description

This script generates onion service configurations for Tor, retrieves the corresponding onion links, and uploads them along with PHP scripts to create auto sites in aapanel. It allows you to specify the number of onion services to create and the last directory name part of the onion service paths.

## Usage

1. **Generate Onion Links**:

- `<number_of_services>`: Number of onion services to create.
- `<last_directory_name>`: Name for the last directory part of the onion service paths.
- `[clear]` (Optional): Use "clear" to clear existing Tor configuration before generating new configurations.

2. **Upload Onion Links to aapanel**:
- Once the onion links are generated, copy them and use a PHP script to upload them to aapanel. The PHP script will create auto sites for each onion link.

## Prerequisites

- Tor installed on your system.
- Bash shell.
- Access to aapanel for auto site creation.

## Installation

1. Clone this repository:



2. Change directory to the script directory:


3. Make the script executable:

## Uploading Onion Links to aapanel

1. Use the generated onion links along with a PHP script to upload them to aapanel.
2. Ensure the PHP script is configured to create auto sites in aapanel using the provided onion links.

## Example PHP Script for Auto Site Creation
index.html there is text area  upload there and it will add all links as site in aapanel 



## Prerequisites

- Tor installed on your system.
- Bash shell.

## Installation

1. Clone this repository:




2. Change directory to the script directory:




3. Make the script executable:


## Examples

Generate 5 onion services with the last directory name "hidden_dir":




Generate 10 onion services with the last directory name "my_onion" and clear existing configuration:




## Author

- [Tarun](https://github.com/Tarun-developer)

## License

This project is licensed under the [MIT License](LICENSE).



