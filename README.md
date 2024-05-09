# Onion Service Config Generator for Tor

This script automates the generation of onion service configurations for Tor.

## Description

This script generates onion service configurations for Tor. It allows you to specify the number of onion services to create and the name for the last directory part of the onion service paths. Optionally, you can clear the existing Tor configuration before generating new configurations.

## Usage




- `<number_of_services>`: Number of onion services to create.
- `<last_directory_name>`: Name for the last directory part of the onion service paths.
- `[clear]` (Optional): Use "clear" to clear existing Tor configuration before generating new configurations.

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



