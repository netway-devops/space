<?php

class clienthandle_controller extends HBController {

    public function beforeCall ($request)
    {
        
    }
    
    public function _default ($request)
    {
        $db         = hbm_db();
    }
    
    public function isClientAccessEmail ($request)
    {
        $db         = hbm_db();
        
        $email      = isset($request['email']) ? $request['email'] : '';
        
        $result     = $db->query("
                SELECT
                    ca.*
                FROM
                    hb_client_access ca,
                    hb_client_details cd
                WHERE
                    ca.email = :email
                    AND ca.id = cd.id
                    AND cd.parent_id = 0
                ", array(
                    ':email'    => $email
                ))->fetch();
        
        $clientId   = (isset($result['id']) && $result['id']) ? $result['id'] : 0;
        
        echo '<!-- {"ERROR":[],"INFO":[]'
            . ',"DATA":'. json_encode(array('clientId' => $clientId))
            . ',"STACK":0} -->';
        exit;
    }
    
    public function afterCall ($request)
    {
        
    }
}