<?php
class bt_api {
    private $BT_KEY = "54nV0ZPzbDpwtriRLQwzLwifSYoh6WX8";
    private $BT_PANEL = "https://54.37.91.7:7800/";

    public function __construct($bt_panel = null,$bt_key = null){
        if($bt_panel) $this->BT_PANEL = $bt_panel;
        if($bt_key) $this->BT_KEY = $bt_key;
    }

  

    public function AddSite($domain, $root_path, $php_version, $remarks) {
        $url = $this->BT_PANEL . '/site?action=AddSite';
        $post_data = $this->GetKeyData();
        $post_data['webname'] = json_encode(array(
            'domain' => $domain,
            'domainlist' => [],
            'count' => 0
        ));
        $post_data['path'] = $root_path;
        $post_data['type_id'] = 0;
        $post_data['type'] = 'PHP';
        $post_data['version'] = $php_version;
        $post_data['port'] = 80;
        $post_data['ps'] = $remarks;
        $post_data['ftp'] = true;
        $post_data['ftp_username'] = 'username';
        $post_data['ftp_password'] = 'password';
        $post_data['sql'] = true;
        $post_data['coding'] = 'utf8';
        $post_data['datauser'] = 'database_username';
        $post_data['datapassword'] = 'database_password';
        $result = $this->HttpPostCookie($url, $post_data);
        $data = json_decode($result, true);
        return $data;
    }

    private function GetKeyData(){
        $now_time = time();
        $p_data = array(
            'request_token' => md5($now_time . '' . md5($this->BT_KEY)),
            'request_time' => $now_time
        );
        return $p_data;    
    }

    private function HttpPostCookie($url, $data, $timeout = 60)
    {
        $cookie_file = './' . md5($this->BT_PANEL) . '.cookie';
        if (!file_exists($cookie_file)) {
            $fp = fopen($cookie_file, 'w+');
            fclose($fp);
        }

        $ch = curl_init();
        curl_setopt($ch, CURLOPT_URL, $url);
        curl_setopt($ch, CURLOPT_TIMEOUT, $timeout);
        curl_setopt($ch, CURLOPT_POST, 1);
        curl_setopt($ch, CURLOPT_POSTFIELDS, $data);
        curl_setopt($ch, CURLOPT_COOKIEJAR, $cookie_file);
        curl_setopt($ch, CURLOPT_COOKIEFILE, $cookie_file);
        curl_setopt($ch, CURLOPT_RETURNTRANSFER, 1);
        curl_setopt($ch, CURLOPT_HEADER, 0);
        curl_setopt($ch, CURLOPT_SSL_VERIFYHOST, false);
        curl_setopt($ch, CURLOPT_SSL_VERIFYPEER, false);
        $output = curl_exec($ch);
        if ($output === false) {
            $error = curl_error($ch);
            curl_close($ch);
            return "cURL Error: " . $error;
        }
        if (empty($output) || !json_decode($output)) {
            curl_close($ch);
            return "Server Response Error: Empty response or not in JSON format";
        }
        curl_close($ch);
        return $output;
    }
}


