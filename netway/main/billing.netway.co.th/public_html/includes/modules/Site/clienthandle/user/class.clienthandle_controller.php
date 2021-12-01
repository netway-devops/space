<?php

class clienthandle_controller extends HBController {

    public function beforeCall ($request)
    {
        
    }
    
    public function _default ($request)
    {
        $db         = hbm_db();
    }
    
    public function islogin ($request)
    {
        $db         = hbm_db();
        $aClient    = hbm_logged_client();
        $clientId   = isset($aClient['id']) ? $aClient['id'] : 0;
        
        $result     = $db->query("
            SELECT cfv.*
            FROM hb_client_fields_values cfv,
                hb_client_fields cf
            WHERE cfv.client_id = :clientId
                AND cfv.field_id = cf.id
                AND cf.code = 'facebookmessengerid'
            ", array(
                ':clientId' => $clientId
            ))->fetch();
        
        $messengerId    = isset($result['value']) ? $result['value'] : '';
        
        $aClient['messengerId'] = $messengerId;
        
        $this->loader->component('template/apiresponse', 'json');
        $this->json->assign('data', $aClient);
        $this->json->show();
    }
    
    public function connectMessenger ($request)
    {
        $db         = hbm_db();
        
        $aClient    = hbm_logged_client();
        $messengerId    = isset($request['messengerId']) ? $request['messengerId'] : '';
        
        if (isset($aClient['id']) && $messengerId) {
            $clientId   = $aClient['id'];
            
            $result     = $db->query("
                SELECT *
                FROM hb_client_fields
                WHERE code = 'facebookmessengerid'
                ")->fetch();
            
            $fieldId    = isset($result['id']) ? $result['id'] : 0;
            
            $result     = $db->query("
                SELECT *
                FROM hb_client_fields_values
                WHERE client_id = :clientId
                    AND field_id = :fieldId
                ", array(
                    ':clientId' => $clientId,
                    ':fieldId'  => $fieldId
                ))->fetch();
            
            if (isset($result['client_id'])) {
                $db->query("
                    UPDATE hb_client_fields_values
                    SET value = :value
                    WHERE client_id = :clientId
                        AND field_id = :fieldId
                    ", array(
                        ':clientId' => $clientId,
                        ':fieldId'  => $fieldId,
                        ':value'    => $messengerId
                    ));
            } else {
                $db->query("
                    INSERT INTO hb_client_fields_values (
                        client_id, field_id, value
                    ) VALUES (
                        :clientId, :fieldId, :value
                    )
                    ", array(
                        ':clientId' => $clientId,
                        ':fieldId'  => $fieldId,
                        ':value'    => $messengerId
                    ));
            }
            
        }
        
        return $this->islogin($request);
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