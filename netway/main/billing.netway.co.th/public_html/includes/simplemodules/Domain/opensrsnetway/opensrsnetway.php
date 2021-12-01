<?php

hbm_create('OpenSRS Domain Registrar by Netway', array(
    'description' => 'OpenSRS Domain Registrar module for HostBill, using procedural DevKit',
    'version' => '1.0'
));

hbm_add_app_config('Reseller username');
hbm_add_app_config('OpenSRS Private Key');
hbm_add_app_config('Use Test Mode', array('type' => 'checkbox'));

// TEST CONNECTION:
hbm_on_action('module.testconnection', function() {
    return true;
});

// SYNCHRONIZE:
hbm_on_action('domain.synchronize',function($details) {

    $return     = array(
        'status' => $details['status']  // ต้องมี return ป้องกัน error
    );
    
    $isTestMode = hbm_get_app_config('Use Test Mode');
    
    if ($isTestMode) {
        hbm_error('CMD:opensrsnetway.domain.action is testmode');
        return $return;
    }
    
    if (isset($_POST['synch']) && $_POST['synch'] == 'Updatenameservers') {
        $result     = openSRSDomainAPI::updatenameservers($details);
    }
    
    $aResult    = openSRSDomainAPI::synchronize($details['domain']);
    
    if (isset($aResult['status']) && $aResult['status'] != 'Active') {
        if(preg_match('/pending/i', $details['status'])) {
            return $return;
        }
    }

    if ($aResult) {
        $return['expires']  = $aResult['expires'];
        $return['status']   = $aResult['status'];
        $return['ns']       = $aResult['ns'];
    }
    
    return $return;
});

//REGISTER:
hbm_on_action('domain.register', function($details) {

    $isTestMode = hbm_get_app_config('Use Test Mode');
    
    if ($isTestMode) {
        hbm_error('CMD:opensrsnetway.domain.action is testmode');
        return false;
    }
    
    for($i = 1; $i<=2; $i++) {
        if (! isset($details['nameservers']['ns'. $i]) || ! $details['nameservers']['ns'. $i]) {
            $details['nameservers']['ns'. $i]  = 'ns'. $i .'.netway.co.th';
        }
    }
    
    $result    = openSRSDomainAPI::register($details);
    if ($result) {
        return true;
    } else {
        hbm_error('CMD:opensrsnetway.domain.register เกิดข้อผิดพลาด');
    }
    return false;
});

hbm_on_action('domain.renew', function($details) {
    
    // --- hostbill helper ---
    $db         = hbm_db();
    // --- hostbill helper ---
    
    $isTestMode = hbm_get_app_config('Use Test Mode');
    if ($isTestMode) {
        hbm_error('CMD:opensrsnetway.domain.action is testmode');
        return false;
    }
    
    /*--- ถ้า order ทำ provisioning ผ่านมาแล้วไม่เกิน 90 วันไม่ให้ renew ---*/
    $domainId       = $details['id'];
    $domainName     = $details['domain'];

    require_once(APPDIR . 'class.general.custom.php');
    $result     = GeneralCustom::singleton()->isDomainAllowRenewable($domainId);
    if (! $result) {
        hbm_error('Domain #' . $domainId  . ' ไม่อยู่ในเงื่อนไขที่จะทำการ autorenew ได้ ');
        return false;
    }
    
    $result    = openSRSDomainAPI::renew($details);
    
    if ($result) {
        return true;
    } else {
        hbm_error('CMD:opensrsnetway.domain.renew เกิดข้อผิดพลาด');
    }
    
    return false;
});

hbm_on_action('domain.transfer',function($details) {
    
    $isTestMode = hbm_get_app_config('Use Test Mode');
    
    if ($isTestMode) {
        hbm_error('CMD:opensrsnetway.domain.action is testmode');
        return false;
    }
    
    $result    = openSRSDomainAPI::transfer($details);
    if ($result) {
        return true;
    } else {
        hbm_error('CMD:opensrsnetway.domain.transfer เกิดข้อผิดพลาด');
    }
    return false;
});

hbm_on_action('domain.getcontacts', function($details) {
    $return = array();
    
    $isTestMode = hbm_get_app_config('Use Test Mode');
    
    if ($isTestMode) {
        hbm_error('CMD:opensrsnetway.domain.action is testmode');
        return false;
    }
    
    $aResult    = openSRSDomainAPI::getcontacts($details['domain']);
    
    if ($aResult) {
        $return = $aResult;
    } else {
        hbm_error('CMD:opensrsnetway.domain.getcontacts เกิดข้อผิดพลาด');
    }
    return $return;
});

hbm_on_action('domain.updatecontacts', function($details) {
    $return = array();
    
    $isTestMode = hbm_get_app_config('Use Test Mode');
    
    if ($isTestMode) {
        hbm_error('CMD:opensrsnetway.domain.action is testmode');
        return false;
    }
    
    $aResult    = openSRSDomainAPI::updatecontacts($details);
    
    if ($aResult) {
        return true;
    } else {
        hbm_error('CMD:opensrsnetway.domain.updatecontacts เกิดข้อผิดพลาด');
    }
    return $return;
});

hbm_on_action('domain.getnameservers', function($details) {
    
    $return     = array();
    
    $isTestMode = hbm_get_app_config('Use Test Mode');
    
    if ($isTestMode) {
        hbm_error('CMD:opensrsnetway.domain.action is testmode');
        return false;
    }
    
    $aResult    = openSRSDomainAPI::synchronize($details['domain']);
    
    if ($aResult) {
        $return     = $aResult['ns'];
    } else {
        hbm_error('CMD:opensrsnetway.domain.getnameservers ไม่พบข้อมูล');
    }
    
    return $return;
});

hbm_on_action('domain.updatenameservers', function($details) {
    
    $isTestMode = hbm_get_app_config('Use Test Mode');
    
    if ($isTestMode) {
        hbm_error('CMD:opensrsnetway.domain.action is testmode');
        return false;
    }
	
	require_once(APPDIR . 'class.general.custom.php');
    require_once(APPDIR . 'class.api.custom.php');
       
    $adminUrl = GeneralCustom::singleton()->getAdminUrl();
    $apiCustom = ApiCustom::singleton($adminUrl . '/api.php');
     
    $post = array(
           'call' 		=> 'module',
           'module' 	=> 'dnsservicehandle',
           'fn' 		=> 'addDNSZone',
           'domainName' => $details['domain'] ,
           'domainID'	=> $details['id'] ,
           'do'			=> 'Update name server opensrs'
    );
	
    $aRes = $apiCustom->request($post);
    
    
    
    $result     = openSRSDomainAPI::updatenameservers($details);
    
    if ($result) {
        
        require_once(APPDIR . 'class.config.custom.php');
        require_once(APPDIR . 'class.general.custom.php');
        require_once(APPDIR . 'class.api.custom.php');
        
        /* --- sync update domain info --- */
        $adminUrl   = GeneralCustom::singleton()->getAdminUrl();
        $apiCustom  = ApiCustom::singleton($adminUrl.'/api.php');
        
        $aParam     = array( 
            'call'  => 'domainSynch',
            'id'    => $details['id']
        );
        $result     = $apiCustom->request($aParam);
        
        return true;
        
    } else {
        return false;
    }
});

hbm_on_action('domain.attributes', function($details) {
    $attributes     = array();
    
    $attributes[]   = array('description' => 'Registrant\'s username',
                'name'      => 'reg_username',
                'type'      => 'input',
                'option'    => false
            );
    $attributes[]   = array('description' => 'Registrant\'s password',
                'name'      => 'reg_password',
                'type'      => 'input',
                'option'    => false
            );
    
    return $attributes;
});



/* --- OPENSRS API --- */
class openSRSDomainAPI {
    
    public static $aHBFieldToReg      = array(
                'firstname'         => 'first_name',
                'lastname'          => 'last_name',
                'companyname'       => 'org_name',
                'address1'          => 'address1',
                'city'              => 'city',
                'state'             => 'state',
                'country'           => 'country',
                'postcode'          => 'postal_code',
                'phonenumber'       => 'phone',
                'email'             => 'email',
                'fax'               => 'fax',
                'address2'          => 'address2'
                );
    public static $aContact = array('admin' => 'admin','tech' => 'tech','registrant' => 'owner','billing' => 'billing');
    
    private function send ($func, $aData)
    {
        
        require_once MAINDIR . 'includes/simplemodules/Domain/opensrsnetway/opensrs/openSRS_loader.php';
        
        $callArray = array (
                'func' => $func,
                'data' => $aData
        );
        
        if (isset($aData['personal'])) {
            $callArray['personal']  = $aData['personal'];
        }
    
        //JSON
        $callstring     = json_encode($callArray);
        
        $osrsHandler    = processOpenSRS ('json', $callstring);
        $oRespond       = json_decode($osrsHandler->resultFormated);
        
        return $oRespond;
    }
    
    public function synchronize ($domainName)
    {
        $return         = array();
        $return['ns']   = array();
        
        $result         = self::send('lookupGetDomain', array(
                        'domain'    => $domainName,
                        'type'      => 'all_info',
                        'bypass'    => true
                    ));
        
        $resultStatus         = self::send('lookupGetDomain', array(
                        'domain'    => $domainName,
                        'type'      => 'status',
                        'bypass'    => true
                    ));
        
        if ( ! $result->is_success) {
            return false;
        }
        
        if ( ! isset($result->attributes->expiredate)) {
            return false;
        }
        
        $expire         = strtotime($result->attributes->expiredate);
        
        if ($expire > time()) {
            $return['status']   = 'Active';
        } else {
            $return['status']   = 'Expired';
        }

        if ( ! isset($result->attributes->nameserver_list) || ! is_array($result->attributes->nameserver_list)) {
            return false;
        }
        
        $nameserver     = $result->attributes->nameserver_list;
        
        foreach ($nameserver as $oNameServer) {
            array_push($return['ns'], $oNameServer->name);
        }
        
        $return['expires']  = date('Y-m-d', $expire);
        
        $isLock = $resultStatus->attributes->lock_state;
        
        if(isset($_POST['lockstate'])){
            if($_POST['lockstate'] != $isLock){
                self::updatelockstate($domainName,$_POST['lockstate']);
            }
        }
        
        self::lockDomain($domainName,$isLock);
        
        return $return;
    }

    public function updatelockstate($domainName,$lockstate){
        $lock = 'unlock';    
        if($lockstate){
            $lock = 'lock';
        }
        
        $result         = self::send('bulkSubmit', array(
                         'change_type'    => 'domain_lock',
                         'change_items'      => $domainName,
                         'op_type'       => $lock
                     ));
        
        if ( ! $result->is_success) {
            return false;
        }
        
    }
    
    public function lockDomain($domainName,$isLock){
            
        $db             = hbm_db();
            
        //หาโปรดักไอดี
        $result         = $db->query("SELECT d.id,d.tld_id
                                      FROM hb_domains d
                                      WHERE d.name = :domainName
                                    ",array(
                                            ':domainName'   => $domainName
                                    ))->fetch();
        $accountId      = $result['id'];
        
        //หา customfield_id
        $result         = $db->query("SELECT cic.id
                                      FROM hb_config_items_cat cic
                                      WHERE cic.variable = 'lock_domain'
                                      AND cic.product_id = :productId
                                    ",array(
                                            ':productId'   => $result['tld_id']
                                    ))->fetch();
        $configCat      = $result['id'];
        
        //หา config_items_id
        $result         = $db->query("SELECT ci.id
                                      FROM hb_config_items ci
                                      WHERE ci.category_id = :category_id
                                    ",array(
                                            ':category_id'   => $result['id']
                                    ))->fetch();
        $configId       = $result['id'];
        
        if($isLock == 0){
            
            $db             = hbm_db();
            $db->query("DELETE FROM hb_config2accounts
                                          WHERE account_id = :accountId
                                          AND config_cat = :configCat
                                          AND config_id = :configId
                                        ",array(
                                                ':accountId'        => $accountId,
                                                ':configCat'        => $configCat,
                                                ':configId'         => $configId
                                        ));

        }else{

            $result         = $db->query("SELECT count(*) as num
                                          FROM hb_config2accounts
                                          WHERE account_id = :accountId
                                          AND config_cat = :configCat
                                          AND config_id = :configId
                                        ",array(
                                                ':accountId'        => $accountId,
                                                ':configCat'        => $configCat,
                                                ':configId'         => $configId
                                        ))->fetch();
            if($result['num'] != 0){
                 $db->query("UPDATE
                             hb_config2accounts
                             SET qty = 1 , data = 1
                             WHERE account_id = :accountId
                             AND config_cat = :configCat
                             AND config_id = :configId
                             ",array(
                                    ':accountId'        => $accountId,
                                    ':configCat'        => $configCat,
                                    ':configId'         => $configId
                                    ));
            }else{
                 $db->query("INSERT INTO 
                       hb_config2accounts 
                       (rel_type,account_id,config_cat,config_id,qty,data)
                       VALUE('Domain',:accountId,:configCat,:configId,1,1)
                       ",array(
                               ':accountId'        => $accountId,
                               ':configCat'        => $configCat,
                               ':configId'         => $configId
                       ));
            }
        }
    }
    public function _generateCode($characters = 10) {
        /* list all possible characters, similar looking characters and vowels have been removed */
        if ($characters == 6) {
            $possible = 'abcdefghijklmnopqrstuvwxyz';
        } else {
            $possible = '0123456789abcdefghijklmnopqrstuvwxyz';
        }
        $code = '';
        $i = 0;
        while ($i < $characters) { 
            $code .= substr($possible, mt_rand(0, strlen($possible)-1), 1);
            $i++;
        }
        return $code;
    }
    
    private function _updateForm ($field, $details)
    {
        // --- hostbill helper ---
        $db         = hbm_db();
        // --- hostbill helper ---
        
        if ($field == 'reg_username') {
            $code   = self::_generateCode(6);
        } elseif ($field == 'reg_password') {
            $code   = self::_generateCode();
        }
        
        if ($code) {
            
            /* --- --- */
            $domainId   = $details['id'];
            
            $result     = $db->query("
                        SELECT
                            ci.id, ci.category_id
                        FROM
                            hb_domains d,
                            hb_products p,
                            hb_config_items_cat cic,
                            hb_config_items ci
                        WHERE
                            d.id = :domainId
                            AND d.tld_id = p.id
                            AND p.id = cic.product_id
                            AND cic.variable = :variableName
                            AND cic.id = ci.category_id
                        ", array(
                            ':domainId'         => $domainId,
                            ':variableName'     => $field,
                        ))->fetch();
            
            $configId       = (isset($result['id']) && $result['id']) ? $result['id'] : 0;
            $configCatId    = (isset($result['category_id']) && $result['category_id']) ? $result['category_id'] : 0;
            
            $result     = $db->query("
                        SELECT
                            c2a.account_id
                        FROM
                            hb_config2accounts c2a
                        WHERE
                            c2a.rel_type = 'Domain'
                            AND c2a.account_id = :domainId
                            AND c2a.config_id = :configId
                        ", array(
                            ':domainId'     => $domainId,
                            ':configId'     => $configId
                        ))->fetch();
            
            if ( isset($result['account_id']) && $result['account_id']) {
            
                $db->query("
                UPDATE hb_config2accounts
                SET data = :dataValue
                WHERE rel_type = 'Domain'
                    AND account_id = :domainId
                    AND config_id = :configId
                ", array(
                    ':dataValue'    => $code,
                    ':domainId'     => $domainId,
                    ':configId'     => $configId
                ));
            
            } else {
                
                $db->query("
                INSERT INTO `hb_config2accounts` (
                    `rel_type`, `account_id`, `config_cat`, `config_id`, `qty`, `data`
                ) VALUES (
                    'Domain', :domainId, :configCat, :configId, 1, :dataValue
                )
                ", array(
                    ':domainId'     => $domainId,
                    ':configCat'    => $configCatId,
                    ':configId'     => $configId,
                    ':dataValue'    => $code
                ));
                
            }
            
        }
        
        return $code;
    }

    public function register($details, $regType = 'new')
    {

        $domainName     = $details['domain'];
        $oPerson        = (object) $details['registrant'];
        $aPerson        = array();
        foreach (self::$aHBFieldToReg as $key => $val) {
            $aPerson[$val]  = $oPerson->{$key};
        }
        $aPerson['lang_pref']   = 'en';
        
        $period             = $details['period'];
        $oAttribute         = isset($details['attributes']) ? (object) $details['attributes'] : null;
        
        /* --- ตั้งค่า default ให้ --- */
        if (! isset($oAttribute->reg_username) || $oAttribute->reg_username == '') {
            $oAttribute->reg_username   = self::_updateForm('reg_username', $details);
        }
        if (! isset($oAttribute->reg_password) || $oAttribute->reg_password == '') {
            $oAttribute->reg_password   = self::_updateForm('reg_password', $details);
        }
        /* --- ตั้งค่า default ให้ --- */
        
        $aNameservers       = array();
        $aNameServerLists   = array();
        if (is_array($details['nameservers']) && count($details['nameservers'])) {
            $i = 1;
            foreach ($details['nameservers'] as $nameserver) {
                if (empty($nameserver)) {
                    continue;
                }
                $aNameserver               = array();
                $aNameserver['name']       = $nameserver;
                $aNameserver['sortorder']  = $i;
                array_push($aNameservers, $aNameserver);
                
                $aNameServerLists['name' . $i]      = $nameserver;
                $aNameServerLists['sortorder' . $i] = $i;
                $i++;
            }
        }

        /* --- ถ้า domain เป็น IDN --- */
        $encodingType       = '';
        if (preg_match('/^xn\-/i', $domainName)) {
            $encodingType   = 'THA';
        }
        
        $result     = self::send('provSWregister', array_merge(array(
                        'domain'    => $domainName,
                        'period'    => $period,
                        'handle'    => 'process',
                        
                        'encoding_type' => $encodingType,
        
                        'reg_type'      => $regType,
                        'reg_username'  => $oAttribute->reg_username,
                        'reg_password'  => $oAttribute->reg_password,
        
                        'custom_nameservers'    => '1',
                        'custom_tech_contact'   => '0',
                        'nameserver_list'       => $aNameservers,
        
                        'personal'  => $aPerson
                    ),
                    $aNameServerLists
                    ));
        
        if ( ! isset($result->id) || ! $result->id ) {
            if (isset($result->response_text)) {
                hbm_error($result->response_text);
            }
            if (isset($result->error)) {
                hbm_error($result->error);
            }
            return false;
        }
        
        return true;
    }
    
    public function renew($details)
    {
        
        $domainName     = $details['domain'];
        $period         = $details['period'];
        $domainExpire   = (isset($details['expires']) && $details['expires']) ? strtotime($details['expires']) : 0;
        
        $result     = self::send('provRenew', array(
                        'domain'    => $domainName,
                        'period'    => $period,
                        'handle'    => 'process',
                        
                        'currentexpirationyear'    => ($domainExpire ? date('Y', $domainExpire) : ''),
                        'auto_renew'    => '0'
                    ));
        
        if ( ! isset($result->id) || ! $result->id ) {
            return false;
        }
        
        return true;
    }
    
    public function getcontacts($domainName)
    {
        $return         = array();
        
        $result         = self::send('lookupGetDomainsContacts', array(
                        'domain_list'    => $domainName
                    ));
        
        if ( ! isset($result->{$domainName}->contact_set)) {
            return false;
        }
        
        $oContactSet        = $result->{$domainName}->contact_set;
        
        foreach (self::$aContact as $k => $v) {
            if (!is_array($return[$k])) {
                $return[$k]     = array();
            }
            foreach (self::$aHBFieldToReg as $key => $val) {
                $return[$k][$key]   = isset($oContactSet->{$v}->{$val}) ? $oContactSet->{$v}->{$val} : '';
            }
            
        }
        
        return $return;
    }
    
    public function updatecontacts($details)
    {
        $return         = array();
        
        $domainName     = $details['domain'];
        
        foreach (self::$aContact as $k => $v) {
        
            if ( ! isset($details[$k])) {
                continue;
            }
            
            $type           = $v;
            $oPerson        = (object) $details[$k];
            $aPerson        = array();
            foreach (self::$aHBFieldToReg as $key => $val) {
                $aPerson[$val]  = $oPerson->{$key};
            }
            /* --- hostbill ไม่ส่ง companyname มาให้ --- */
            $aPerson['org_name']    = $aPerson['org_name'] ? $aPerson['org_name'] : '-';
            $aPerson['city']        = $aPerson['city'] ? $aPerson['city'] : '-';
            $aPerson['lang_pref']   = 'en';
            
            $result     = self::send('provUpdateContacts', array(
                            'domain'    => $domainName,
                            'types'     => $type,
            
                            'personal'  => $aPerson
                        ));
            
        }
        
        if ( ! $result->is_success) {
            return false;
        }

        $return['message']      = $result->response_text;

        return $return;
    }
    
    public function updatenameservers($details)
    {
        
        if ( ! isset($details['nameservers']) || ! is_array($details['nameservers'])) {
            return false;
        }
        
        $domainName     = $details['domain'];
        $aNameServers   = array();
        if (is_array($details['nameservers']) && count($details['nameservers'])) {
            foreach ($details['nameservers'] as $k => $v) {
                if (trim($v)) {
                    array_push($aNameServers, trim($v));
                }
            }
        }
        $nameServer     = implode(',', $aNameServers);

        $result     = self::send('nsAdvancedUpdt', array(
                        'bypass'    => $domainName,
                        'assign_ns' => $nameServer,
                        'op_type'   => 'assign'
                    ));
        
        if ( ! $result->is_success) {
            echo '
                <div id="error">
                    <h4>Error: ' . $result->response_code . '</h4>
                    <p>' . $result->response_text . '</p>
                </div>
                ';
            return false;
        }
        
        echo '
            <style>
            #infos {
                background:#d5ffce; border:solid 1px #9adf8f; padding:8px 8px 8px 30px;
                margin-bottom:8px; color:#556652; font-weight:bold; position:relative;
            }
            #infos span, #errors span { display:block; margin-bottom:3px; }
            </style>
            <div id="infos">
                <h4>Success: อาจจะต้องรอประมาณ 5-10 นาที เพื่อให้ข้อมูล nameserver ที่ registrar อัพเดท</h4>
                <p>' . $result->response_text . '</p>
            </div>
            ';
        return true;
    }
    
    public function transfer($details)
    {
        $result     = self::register($details, 'transfer');
        return $result;
    }
    

}