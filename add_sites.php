<?php
// Include the bt_api class
require_once 'bt_api.php';

// Create an instance of bt_api
$api = new bt_api();

// Function to add sites using onion addresses
function add_sites_from_onion_addresses($onion_addresses) {
    global $api;
    $added_sites = array();
    foreach ($onion_addresses as $index => $onion_address) {
        // Define the root path, PHP version, and remarks for the site
        $root_path = "/www/wwwroot/${index}";
        $php_version = 74;
        $remarks = "Onion Service " . ($index + 1);
        
        // Add the onion address as a site using bt_api
        $result = $api->AddSite($onion_address, $root_path, $php_version, $remarks);
        
        // Check if the site was added successfully
        if ($result) {
            $added_sites[] = $onion_address;
        }
    }
    return $added_sites;
}

// Check if the form is submitted and onion addresses are provided
if ($_SERVER["REQUEST_METHOD"] == "POST" && isset($_POST['onion_addresses'])) {
    // Split the textarea content into individual onion addresses
    $onion_addresses = explode("\n", $_POST['onion_addresses']);
    // Remove any whitespace and empty elements
    $onion_addresses = array_map('trim', $onion_addresses);
    $onion_addresses = array_filter($onion_addresses);
    
    // Add sites using the provided onion addresses
    $added_sites = add_sites_from_onion_addresses($onion_addresses);
    
    // Output success message
    if (!empty($added_sites)) {
        echo "<h3>Added Sites:</h3>";
        foreach ($added_sites as $index => $onion_address) {
            echo "Site " . ($index + 1) . ": $onion_address<br>";
        }
    } else {
        echo "<h3>No sites were added.</h3>";
    }
} else {
    // Redirect to the form if accessed directly without submitting
    header("Location: index.html");
    exit;
}
?>
