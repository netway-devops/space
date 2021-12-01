<?php

class domain_autorenew_controller extends HBController {
    /* 
     * Under $this->module HostBill will load your module
     * in this case it will be Example 
    */
    public $module;
    
    
    
    /**
     * 
     * @return string
     */
    public function call_Hourly() 
    {
        $db         = hbm_db();
        
        require_once(APPDIR . 'class.general.custom.php');
        require_once(APPDIR . 'class.api.custom.php');
        
        $adminUrl   = GeneralCustom::singleton()->getAdminUrl();
        $apiCustom  = ApiCustom::singleton($adminUrl . '/api.php');
        
        //require_once(APPDIR . 'simplemodules/Domain/srsplus/srsplus.php');
        
        $current    = time();
        $syncDate   = date('Y-m-d 00:00:00', strtotime('-7 days', $current));
        $message    = '';

        $result     = $db->query("
                SELECT
                    d.id, d.name,
                    mc.module
                FROM
                    hb_domains d
                    LEFT JOIN
                        hb_domain_renew dr
                        ON dr.id = d.id,
                    hb_modules_configuration mc
                WHERE
                    d.reg_module = mc.id
                    AND ( dr.id IS NULL
                        OR dr.sync_date < :syncDate
                    )
                ORDER BY d.expires DESC
                LIMIT 0,10
                ", array(
                    ':syncDate'     => $syncDate
                ))->fetchAll();
        
        if (! count($result)) {
            return $message;
        }
        
        $aDomains       = $result;
        foreach ($aDomains as $aDomain) {
            
            $isAutoRenew        = 0;
            
            switch ($aDomain['module']) {
                
                case 'srsplus': {
                        $domainName     = $aDomain['name'];
                        $tld            = substr(strstr($domainName, '.'), 1);
                        $sld            = substr($domainName, 0, - (strlen($tld)+1));
                        
                        $QSTRING    = 'DOMAIN=' . $sld;
                        $QSTRING   .= '&TLD='   . $tld;
                        
                        putenv('REQUEST_METHOD=GET');
                        putenv('QUERY_STRING='. $QSTRING);   
                        
                        unset($aResult);
                        exec(APPDIR . 'simplemodules/Domain/srsplus/registrarAPI/srsplus/whois.cgi', $aResult);
                        
                        if (count($aResult)) {
                            $result         = preg_grep('/AUTOCHARGE\s?\:\s?1/i', $aResult);
                            if (count($result)) {
                                $isAutoRenew    = 1;
                            }
                        }
                    
                    }
                    break;
                    
                case 'opensrsnetway': {
                        require_once( APPDIR . 'simplemodules/Domain/opensrsnetway/opensrs/openSRS_loader.php');
                        $domainName     = $aDomain['name'];
                        $callArray      = array (
                            'func'  => 'lookupGetDomain',
                            'data'  => array(
                                'domain'    => $domainName,
                                'type'      => 'all_info',
                                'bypass'    => true
                                )
                            );
                        
                        $callstring     = json_encode($callArray);
                        
                        $osrsHandler    = processOpenSRS ('json', $callstring);
                        $oRespond       = json_decode($osrsHandler->resultFormated);
                        
                        if (isset($oRespond->attributes->auto_renew) && $oRespond->attributes->auto_renew) {
                            $isAutoRenew    = 1;
                        }
                        
                    }
                    break;
                    
                default:
                    
            }
            
            $db->query("
                REPLACE INTO hb_domain_renew (
                    id, sync_date, is_auto_renew
                ) VALUES (
                    :domainId, NOW(), :isAutoRenew
                )
                ", array(
                    ':domainId'     => $aDomain['id'],
                    ':isAutoRenew'  => $isAutoRenew
                ));
            
        }
        
        return $message;
    }
    
}


