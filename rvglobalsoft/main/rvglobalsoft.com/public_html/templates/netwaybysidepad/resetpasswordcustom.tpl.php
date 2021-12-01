<?php
    if(isset($_GET['activate'])){
        $url  = $this->get_template_vars('system_url');
        $url .= "?cmd=root&action=passreset&activate=";
        $url .= $_GET['activate'];
   
        
        $ch  = curl_init();
            
        curl_setopt($ch, CURLOPT_URL,$url);  
        curl_setopt($ch, CURLOPT_RETURNTRANSFER, 1);
        
        curl_exec ($ch);
        curl_close ($ch);
    }
    
    
