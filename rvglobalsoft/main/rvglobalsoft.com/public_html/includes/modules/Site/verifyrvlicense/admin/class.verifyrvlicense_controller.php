<?php
class verifyrvlicense_controller extends HBController {

    private static  $instance;

    public function _default ($request)
    {
    }

    public static function singleton ()
    {
        if (!isset(self::$instance)) {
            $c = __CLASS__;
            self::$instance = new $c();
        }

        return self::$instance;
    }

    public function addRVSkinLicense($value){

        require_once(APPDIR . 'class.general.custom.php');
        $db = hbm_db();
        $accountId     = $value['id'];  
        
        $result         = $db->query("
            SELECT a.*, p.name
            FROM hb_accounts a
                LEFT JOIN hb_products p
                ON p.id = a.product_id
            WHERE a.id = '{$accountId}'
            ")->fetch();
        
        
        if (! isset($result['id'])) {
            header('location:?cmd=accounts&action=edit&id='. $accountId);
         
        }
        
        $main_ip     = GeneralCustom::singleton()->getIPFromConfig2Account($accountId);
        $second_ip   = GeneralCustom::singleton()->getPublicIPFromConfig2Account($accountId);
        if($second_ip == ''){
         $second_ip = GeneralCustom::singleton()->getIPFromConfig2Account($accountId);
        }

        $productName    = isset($result['name']) ? $result['name'] : '';
        $license_type   = '';
        if (preg_match('/vps/i', $productName)) {
            $license_type   = 'VPS';
        }
        
        $strExpiredate  = isset($result['next_due']) ? $result['next_due'] : '';
        $strExpiredate  = strtotime($strExpiredate);
        $effectivedate  = strtotime('+5 day', $strExpiredate);
        
        $dateServer     = time();
      
       $searchAccount = $db->query("
                    SELECT  *
                    FROM rvskin_license 
                    WHERE hb_acc = :hb_acc
                    ", array(
                      ':hb_acc' => $accountId
                    ))->fetch();   
        if(empty($searchAccount)){             
            $result = $db->query("    
                  INSERT INTO `rvskin_license`(`license_id`, `license_type`, `hb_acc`, `cpanel_id`, `user_id`, `sub_user_id`, `activate_id`, `main_ip`, `second_ip`, `active`, `expire`, `effective_expiry`, `pre_na_main_ip`, `pre_na_second_ip`, `auto_renew`, `log`, `edit_hit`, `edit_log`, `url`, `url_name`, `url_desc`, `transfer_log`, `date_nameserver`, `sta_import`)
                    VALUES (NULL, :license_type, :hb_acc, :cpanel_id, 
                            :user_id, :sub_user_id, :activate_id,:main_ip,
                            :second_ip,:active, :expire,:effective_expiry, 
                            :pre_na_main_ip, :pre_na_second_ip, :auto_renew,:log, 
                            :edit_hit, :edit_log, :url, :url_name,
                            :url_desc, :transfer_log, :date_nameserver, :sta_import
                     )
                    ",array(
                        ':license_type' => $license_type,
                        ':hb_acc'       => $accountId,
                        ':cpanel_id'    => '0',
                        ':user_id'      => '0',
                        ':sub_user_id'  => '',
                        ':activate_id'  => '0',
                        ':main_ip'      => $main_ip,
                        ':second_ip'    => $second_ip,
                        ':active'       => 'yes',
                        ':expire'       => $strExpiredate,
                        ':effective_expiry'   => $effectivedate,
                        ':pre_na_main_ip'     => NULL,
                        ':pre_na_second_ip'   => NULL,
                        ':auto_renew'   => 'no',
                        ':log'          => '',
                        ':edit_hit'     => 0,
                        ':edit_log'     => '',
                        ':url'          => '',
                        ':url_name'     => '',
                        ':url_desc'     => '',
                        ':transfer_log'        => '',
                        ':date_nameserver'     => $dateServer,
                        ':sta_import'          => '0',
                     ));
        }

        
        header('location:?cmd=accounts&action=edit&id='. $accountId);
        exit;
    }
   

    public function addRVSitebuilderLicense($value)
    {
        
        require_once(APPDIR . 'class.general.custom.php');
        
        $db = hbm_db();
        $client_id      = '1';  
        $accountId     = $_GET['id']; 
        
        $result         = $db->query("
            SELECT a.*, p.name
            FROM hb_accounts a
                LEFT JOIN hb_products p
                ON p.id = a.product_id
            WHERE a.id = '{$accountId}'
            ")->fetch();
        
        if (! isset($result['id'])) {
            header('location:?cmd=accounts&action=edit&id='. $accountId);
            
            exit;
        }
        
        $primary_ip     = GeneralCustom::singleton()->getIPFromConfig2Account($accountId);
        $secondary_ip   = GeneralCustom::singleton()->getPublicIPFromConfig2Account($accountId);
        
        $productName    = isset($result['name']) ? $result['name'] : '';
        $license_type   = 9;
        if (preg_match('/vps/i', $productName)) {
            $license_type   = 11;
        }
        
        $strExpiredate  = isset($result['next_due']) ? $result['next_due'] : '';
        $strExpiredate  = strtotime($strExpiredate);
        $effectivedate  = strtotime('+5 day', $strExpiredate);
        
        $dateServer     = time();
        
        
       $searchAccount = $db->query("
                    SELECT  *
                    FROM rvsitebuilder_license 
                    WHERE hb_acc = :hb_acc
                    ", array(
                      ':hb_acc' => $accountId
                    ))->fetch();   
        if(empty($searchAccount)){             
            $result = $db->query("    
                  INSERT INTO `rvsitebuilder_license`(
                            `license_id`, `client_id`, `cpv_id`, `license_type`, 
                            `primary_ip`, `secondary_ip`, `expire`, `effective_expiry`, 
                            `active`, `email_installation`, `rvskin_user_snd`, `hb_acc`, 
                            `comment`, `edit_hit`, `edit_log`, `transfer_log`, `date_nameserver`
                    )
                    VALUES (NULL, :client_id, :cpv_id, :license_type, 
                            :primary_ip, :secondary_ip, :expire, :effective_expiry,
                            :active, :email_installation, :rvskin_user_snd, :hb_acc, 
                            :comment, :edit_hit, :edit_log , :transfer_log , :date_nameserver
                     )
                    ",array(
                        ':client_id'    => $client_id,
                        ':cpv_id'       => '',
                        ':license_type' => $license_type,
                        ':primary_ip'   => $primary_ip,
                        ':secondary_ip' => $secondary_ip ,
                        ':expire'       => $strExpiredate,
                        ':effective_expiry'   => $effectivedate,
                        ':active'       => '1',
                        ':email_installation' => '1',
                        ':rvskin_user_snd'    => '0',
                        ':hb_acc'       => $accountId,
                        ':comment'      => NULL,
                        ':edit_hit'     => '0',
                        ':edit_log'     => NULL,
                        ':transfer_log' => NULL,
                        ':date_nameserver'    => $dateServer
                        
                     ));
        }
        
        header('location:?cmd=accounts&action=edit&id='. $accountId);
        exit;
    }

    public function updateSite_Licence($value){
        $db = hbm_db();
        $aAdmin         = hbm_logged_admin();
        
        $accountId      = isset($value['account_id'])?$value['account_id']:0;  
        $primary_ip     = isset($value['primary_ip'])?$value['primary_ip']:'';
        $secondary_ip   = isset($value['secondary_ip'])?$value['secondary_ip']:'';
        $active         = isset($value['active'])?$value['active']:0; 
        $product        = isset($value['product'])?$value['product']:'';  
        $license        = isset($value['license'])?$value['license']:0;  
        $nexDue         = isset($value['nexDue'])?$value['nexDue']:0;  
        $expiredate     = str_replace("/","-",$value['expiredate']); 
        $strExpiredate  = strtotime($expiredate);
        $effectivedate  = strtotime("+5 day", strtotime($expiredate));
        $dateServer     = time();
       
        if($accountId !=0){
            
           $checkIsAccount= $db->query("
                            SELECT *
                            FROM
                               hb_accounts
                            WHERE id = {$accountId}
                        ")->fetch();
            if(isset($checkIsAccount)){
                if($checkIsAccount["billingcycle"] == 'Monthly' || $checkIsAccount["billingcycle"] == 'Free' || $checkIsAccount["billingcycle"] == 'Quarterly' )
                {
                    $db->query("    
                       UPDATE hb_accounts 
                       SET next_due = '{$nexDue}',
                           next_invoice = DATE_SUB(next_due, INTERVAL 7 DAY),
                           due_day = DATEDIFF(next_due, next_invoice),
                           date_changed = NOW()
                       WHERE id = {$accountId}
                    ");    
                    
                }
                else{
                    $db->query("    
                       UPDATE hb_accounts 
                       SET next_due = '{$nexDue}',
                           next_invoice = DATE_SUB(next_due, INTERVAL 30 DAY),
                           due_day = DATEDIFF(next_due, next_invoice),
                           date_changed = NOW()
                       WHERE id = {$accountId}
                    ");    
                }
            }
            $searchAccount = $db->query("
                    SELECT  *
                    FROM rvsitebuilder_license 
                    WHERE hb_acc = :hb_acc
                    ", array(
                      ':hb_acc' => $accountId
                    ))->fetch();   
        $oldPublicIp  = isset($searchAccount['secondary_ip'])?$searchAccount['secondary_ip']:0;
        $oldServerIP  = isset($searchAccount['primary_ip'])?$searchAccount['primary_ip']:0; 
                   
        
        if(isset($searchAccount)){  
                $result = $db->query("    
                     UPDATE rvsitebuilder_license 
                     SET  primary_ip = '{$primary_ip}' ,
                          secondary_ip = '{$secondary_ip}',
                          expire  = '{$strExpiredate}',
                          effective_expiry = '{$effectivedate}',
                          active = '{$active}',
                          date_nameserver = {$dateServer}
                     WHERE hb_acc = {$accountId}
                     AND license_id = {$license} 
                    ");   
        }
        $configServerIP  = $db->query("
                    SELECT c2a.*
                    FROM
                        hb_config2accounts c2a,
                        hb_config_items_cat cic
                    WHERE
                        c2a.account_id = {$accountId}
                        AND c2a.rel_type = 'Hosting'
                        AND c2a.config_cat = cic.id
                        AND cic.variable = 'ip'
                    ")->fetch();  
                    
            if(isset($configServerIP)) {
                $serverIPUpdate = $db->query("    
                           UPDATE hb_config2accounts 
                           SET data = '{$primary_ip}'
                           WHERE account_id = {$accountId}
                           AND rel_type ='Hosting'
                           AND config_cat = {$configServerIP['config_cat']}
                           AND config_id  = {$configServerIP['config_id']} 
                        "); 
                $aServerLog  = array('serialized' => '1', 'data' => 
                            array(
                                '0' => array('name' => 'ServerIP', 'from' => $oldServerIP, 'to' => $primary_ip)
                         ));    
                                        
                $db->query("
                        INSERT INTO hb_account_logs (id, date, account_id, admin_login, module, manual, action,
                        `change`, result, error, event, ip) 
                        VALUES (
                            NULL, NOW(), :accountId, :admin, 'verifyrvlicense', '0', 'Change IP',
                            :logs, '1','', 'ChangeIP',''
                        )
                    ", array(
                        ':accountId'        => $accountId,
                        ':admin'            => isset($aAdmin['username']) ? $aAdmin['username'] : '',
                        ':logs'             => serialize($aServerLog)
                      
                      ));             
            }                        
            $configPublicIp  = $db->query("
                    SELECT c2a.*
                    FROM
                        hb_config2accounts c2a,
                        hb_config_items_cat cic
                    WHERE
                        c2a.account_id = {$accountId}
                        AND c2a.rel_type = 'Hosting'
                        AND c2a.config_cat = cic.id
                        AND cic.variable = 'public_ip'
                    ")->fetch();
            if(isset($configPublicIp)) {
                $publicIpUpdate = $db->query("    
                   UPDATE hb_config2accounts 
                   SET data = '{$secondary_ip}'
                   WHERE account_id = {$accountId}
                   AND config_cat = {$configPublicIp['config_cat']}
                   AND config_id  = {$configPublicIp['config_id']} 
                    "); 
                    
                $aPublicLog  = array('serialized' => '1', 'data' => 
                        array(
                            '0' => array('name' => 'PublicIp', 'from' => $oldPublicIp, 'to' => $secondary_ip)
                     ));                   
                $db->query("
                        INSERT INTO hb_account_logs (id, date, account_id, admin_login, module, manual, action,
                        `change`, result, error, event, ip) 
                        VALUES (
                            NULL, NOW(), :accountId, :admin, 'verifyrvlicense', '0', 'Change IP',
                            :logs, '1','', 'ChangeIP',''
                        )
                        ",array(
                            ':accountId'        => $accountId,
                            ':admin'            => isset($aAdmin['username']) ? $aAdmin['username'] : '',
                            ':logs'             => serialize($aPublicLog)
                        ));             
            } 
        
            
        }
        header('location:?cmd=accounts&action=edit&id='. $accountId);
        exit;

    }
    public function updateSkin_Licence($value){
        
        $db = hbm_db();
        $account_id     = isset($value['account_id'])?$value['account_id']:0;  
        $main_ip        = isset($value['main_ip'])?$value['main_ip']:'';
        $second_ip      = isset($value['second_ip'])?$value['second_ip']:'';
        $active         = isset($value['active'])?$value['active']:''; 
        $product        = isset($value['product'])?$value['product']:'';  
        $license        = isset($value['license'])?$value['license']:0;  
        $renew          = isset($value['renew'])?$value['renew']:''; 
        $nexDue         = isset($value['nexDue'])?$value['nexDue']:0;   
        $expiredate     = str_replace("/","-",$value['expiredate']); 
        $strExpiredate  = strtotime($expiredate);
        $effectivedate  = strtotime('+5 day', $strExpiredate);
        $dateServer     = time();
     

         if($account_id != 0){
             $checkIsAccount= $db->query("
                            SELECT *
                            FROM
                               hb_accounts
                            WHERE id = {$account_id}
                        ")->fetch();
            if(isset($checkIsAccount)){
                if($checkIsAccount["billingcycle"] == 'Monthly' || $checkIsAccount["billingcycle"] == 'Free' || $checkIsAccount["billingcycle"] == 'Quarterly' )
                {
                    $db->query("    
                       UPDATE hb_accounts 
                       SET next_due = '{$nexDue}',
                           next_invoice = DATE_SUB(next_due, INTERVAL 7 DAY),
                           due_day = DATEDIFF(next_due, next_invoice),
                           date_changed = NOW()
                       WHERE id = {$account_id}
                    ");    
                    
                }
                else{
                    $db->query("    
                       UPDATE hb_accounts 
                       SET next_due = '{$nexDue}',
                           next_invoice = DATE_SUB(next_due, INTERVAL 30 DAY),
                           due_day = DATEDIFF(next_due, next_invoice),
                           date_changed = NOW()
                       WHERE id = {$account_id}
                    ");    
                }
            }
            $searchAccount = $db->query("
                    SELECT * 
                    FROM `rvskin_license` 
                    WHERE `hb_acc` = :hb_acc
                    AND license_id = :license
                    ", array(
                        ':hb_acc' => $account_id,
                        ':license' =>$license
                    ))->fetch();   
            if(isset($searchAccount)){  
             $result = $db->query("   
             
                     UPDATE rvskin_license 
                     SET  
                          main_ip    ='{$main_ip}',
                          second_ip  ='{$second_ip}',
                          active     ='{$active}',
                          expire     ='{$strExpiredate}',
                          effective_expiry = '{$effectivedate}',
                          auto_renew = '{$renew}',
                          date_nameserver = '{$dateServer}'
                     WHERE hb_acc = {$account_id}
                     AND license_id = {$license}
                ");
            }
            
          $configServerIP  = $db->query("
                    SELECT c2a.*
                    FROM
                        hb_config2accounts c2a,
                        hb_config_items_cat cic
                    WHERE
                        c2a.account_id = {$account_id}
                        AND c2a.rel_type = 'Hosting'
                        AND c2a.config_cat = cic.id
                        AND cic.variable = 'ip'
                    ")->fetch();  
                    
            if(isset($configServerIP)) {
                $serverIPUpdate = $db->query("    
                           UPDATE hb_config2accounts 
                           SET data = '{$primary_ip}'
                           WHERE account_id = {$account_id}
                           AND rel_type ='Hosting'
                           AND config_cat = {$configServerIP['config_cat']}
                           AND config_id  = {$configServerIP['config_id']} 
                        "); 
                $aServerLog  = array('serialized' => '1', 'data' => 
                            array(
                                '0' => array('name' => 'ServerIP', 'from' => $oldServerIP, 'to' => $primary_ip)
                         ));    
                                        
                $db->query("
                        INSERT INTO hb_account_logs (id, date, account_id, admin_login, module, manual, action,
                        `change`, result, error, event, ip) 
                        VALUES (
                            NULL, NOW(), :accountId, :admin, 'verifyrvlicense', '0', 'Change IP',
                            :logs, '1','', 'ChangeIP',''
                        )
                    ", array(
                        ':accountId'        => $account_id,
                        ':admin'            => isset($aAdmin['username']) ? $aAdmin['username'] : '',
                        ':logs'             => serialize($aServerLog)
                      
                      ));             
            }                        
            $configPublicIp  = $db->query("
                    SELECT c2a.*
                    FROM
                        hb_config2accounts c2a,
                        hb_config_items_cat cic
                    WHERE
                        c2a.account_id = {$account_id}
                        AND c2a.rel_type = 'Hosting'
                        AND c2a.config_cat = cic.id
                        AND cic.variable = 'public_ip'
                    ")->fetch();
            if(isset($configPublicIp)) {
                $publicIpUpdate = $db->query("    
                   UPDATE hb_config2accounts 
                   SET data = '{$secondary_ip}'
                   WHERE account_id = {$account_id}
                   AND config_cat = {$configPublicIp['config_cat']}
                   AND config_id  = {$configPublicIp['config_id']} 
                    "); 
                    
                $aPublicLog  = array('serialized' => '1', 'data' => 
                        array(
                            '0' => array('name' => 'PublicIp', 'from' => $oldPublicIp, 'to' => $secondary_ip)
                     ));                   
                $db->query("
                        INSERT INTO hb_account_logs (id, date, account_id, admin_login, module, manual, action,
                        `change`, result, error, event, ip) 
                        VALUES (
                            NULL, NOW(), :accountId, :admin, 'verifyrvlicense', '0', 'Change IP',
                            :logs, '1','', 'ChangeIP',''
                        )
                        ",array(
                            ':accountId'        => $account_id,
                            ':admin'            => isset($aAdmin['username']) ? $aAdmin['username'] : '',
                            ':logs'             => serialize($aPublicLog)
                        ));             
            } 

        }  
          header('location:?cmd=accounts&action=edit&id='. $account_id);
        exit;

    }

}