<?php

class configurationhandle_controller extends HBController {

    public function beforeCall ($request)
    {
        
    }
    
    public function _default ($request)
    {
        $db     = hbm_db();
    }
    
    /**
     * Update custom configuration
     * @param unknown_type $request
     * @return unknown_type
     */
    public function update ($request)
    {
        $db     = hbm_db();
        
        $aConfig        = isset($request['nwConfig']) ? $request['nwConfig'] : array();
        if (! count($aConfig)) {
            exit;
        }
        
        foreach ($aConfig as $settingKey => $settingValue) {
            
            switch ($settingKey) {
                case 'nwTechnicalContact' :
                    self::_updatenwTechnicalContact($settingValue);
                    $settingValue   = $settingValue['id'];
                    break;
                default:
                    $settingValue   = $settingValue;
            }
            
            $db->query("
                UPDATE hb_configuration 
                SET value = :settingValue
                WHERE setting = :settingKey
            ", array(
                ':settingValue' => $settingValue,
                ':settingKey'   => $settingKey
            ));
            
        }
        
        echo 'success';
        exit;
    }
    
    /**
     * 
     * @param unknown_type $setting
     * @return string|string
     */
    private function _updatenwTechnicalContact ($aSetting)
    {
        $db     = hbm_db();
        
        if ( ! isset($aSetting['id']) || ! $aSetting['id']) {
            return false;
        }
        
        $id     = $aSetting['id'];
        
        $db->query("
            UPDATE 
                hb_client_access
            SET 
                email = :email
            WHERE
                id = :id
            ", array(
                ':email'    => $aSetting['email'],
                ':id'       => $id
            ));

        $db->query("
            UPDATE 
                hb_client_details
            SET 
                firstname = :firstname,
                lastname = :lastname,
                companyname = :companyname,
                address1 = :address1,
                address2 = :address2,
                city = :city,
                state = :state,
                postcode = :postcode,
                country = :country,
                phonenumber = :phonenumber
            WHERE
                id = :id
            ", array(
                ':firstname'    => $aSetting['firstname'],
                ':lastname'     => $aSetting['lastname'],
                ':companyname'  => $aSetting['companyname'],
                ':address1'     => $aSetting['address1'],
                ':address2'     => $aSetting['address2'],
                ':city'         => $aSetting['city'],
                ':state'        => $aSetting['state'],
                ':postcode'     => $aSetting['postcode'],
                ':country'      => $aSetting['country'],
                ':phonenumber'  => $aSetting['phonenumber'],
                ':id'           => $id
            ));
        
        return true;
    }
    
    public function updateDomainNextInvoice ($request)
    {
        $db     = hbm_db();
        
        $genBefore  = 45;
        
        $result = $db->query("
                UPDATE hb_domains 
                SET next_invoice = DATE_SUB(expires, INTERVAL " . $genBefore . " DAY),
                    autorenew = '1'
                WHERE status = 'Active'
                    AND DATE_SUB(expires, INTERVAL " . $genBefore . " DAY) > CURDATE()
                ");
        
        echo '<pre>'.print_r($result,true).'</pre>';
        echo 'success';
        exit;
    }
    
    public function updateServiceNextInvoice ($request)
    {
        $db         = hbm_db();
        
        $productId  = isset($request['productId']) ? $request['productId'] : 0;
        $day        = (isset($request['day']) && (int) $request['day']) ? (int)$request['day'] : 30;
        
        $result = $db->query("
                UPDATE hb_accounts 
                SET next_invoice = DATE_SUB(next_due, INTERVAL {$day} DAY)
                WHERE status = 'Active'
                    AND DATE_SUB(next_due, INTERVAL {$day} DAY) > CURDATE()
                    AND product_id = '{$productId}'
                    AND billingcycle IN ('Quarterly','Semi-Annually','Annually','Biennially','Triennially')
                ");
        
        $day    = 15;
        $result = $db->query("
                UPDATE hb_accounts 
                SET next_invoice = DATE_SUB(next_due, INTERVAL {$day} DAY)
                WHERE status = 'Active'
                    AND DATE_SUB(next_due, INTERVAL {$day} DAY) > CURDATE()
                    AND product_id = '{$productId}'
                    AND billingcycle IN ('Monthly')
                ");
        
        echo '<pre>'.print_r($result,true).'</pre>';
        echo 'success';
        exit;
    }
    
    public function afterCall ($request)
    {
        
    }
}