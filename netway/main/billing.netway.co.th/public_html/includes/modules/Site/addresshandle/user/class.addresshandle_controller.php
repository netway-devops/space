<?php

class addresshandle_controller extends HBController {

    public function beforeCall ($request)
    {
        $this->_beforeRender();
    }
    
    public function _default ($request)
    {
        $db     = hbm_db();
    }
    
    public function updateNotificationContact ($request)
    {
        $db             = hbm_db();
        
        $client         = hbm_logged_client();
        $oClient        = (object) $client;
        
        $contactId      = isset($request['contactId']) ? $request['contactId'] : 0;
        $email          = isset($request['email']) ? $request['email'] : '';
        $firstname      = isset($request['firstname']) ? $request['firstname'] : '';
        $lastname       = isset($request['lastname']) ? $request['lastname'] : '';
        $phonenumber    = isset($request['phonenumber']) ? $request['phonenumber'] : '';
        $privileges     = isset($request['privileges']) ? $request['privileges'] : array();
        
        if (! $email || ! $contactId) {
            echo json_encode(array('result' => array('success' => '0')));
            exit;
        }
        
        /* --- security ต้องเป็นเจ้าของ --- */
        $result         = $db->query("
                SELECT
                    cd.id
                FROM
                    hb_client_details cd
                WHERE
                    cd.id = :contactId
                    AND cd.parent_id = :clientId
                ", array(
                    ':contactId'        => $contactId,
                    ':clientId'         => $oClient->id
                ))->fetch();
        
        if (! isset($result['id']) || ! $result['id']) {
            echo json_encode(array('result' => array('success' => '0')));
            exit;
        }
        
        /* --- เปลี่ยน email --- */
        $db->query("
            UPDATE
                hb_client_access
            SET
                email = :email
            WHERE
                id = :contactId 
            ", array(
                ':email'        => $email,
                ':contactId'    => $contactId
            ));
        
        /* --- เปลี่ยน firstname --- */
        $db->query("
            UPDATE
                hb_client_details
            SET
                firstname = :email,
                firstname = :firstname,
                lastname = :lastname,
                phonenumber = :phonenumber
            WHERE
                id = :contactId 
            ", array(
                ':email'        => $email,
                ':contactId'    => $contactId,
                ':firstname'    => $firstname,
                ':lastname'     => $lastname,
                ':phonenumber'  => $phonenumber
            ));
        
        /* --- update privilege --- */
        $result         = $db->query("
                SELECT
                    cp.*
                FROM
                    hb_client_privileges cp
                WHERE
                    cp.client_id = :contactId
                ", array(
                    ':contactId'        => $contactId
                ))->fetch();
        
        if (! isset($result['client_id'])) {
            echo json_encode(array('result' => array('success' => '0')));
            exit;
        }
        
        $aPrivilege     = unserialize($result['privileges']);
        
        if (isset($privileges['services'])) {
            $aPrivilege['services']   = $privileges['services'];
        }
        if (isset($privileges['domains'])) {
            $aPrivilege['domains']    = $privileges['domains'];
        }
        
        $db->query("
            UPDATE
                hb_client_privileges
            SET
                privileges = '". serialize($aPrivilege) ."'
            WHERE
                client_id = :contactId
            ", array(
                ':contactId'        => $contactId
            ));
        
        
        echo json_encode(array('result' => array('success' => '1')));
        exit;
    }
    
    public function addEmailContact ($request)
    {
        
        require_once(APPDIR . 'class.config.custom.php');
        require_once(APPDIR . 'class.general.custom.php');
        require_once(APPDIR . 'class.api.custom.php');
        
        $db         = hbm_db();
        
        $client     = hbm_logged_client();
        $oClient    = (object) $client;
        
        
        $emailaddress       = isset($request['emailaddress']) ? $request['emailaddress'] : '';
        
        if (! $emailaddress) {
            echo json_encode(array('result' => array('success' => '0')));
            exit;
        }
        
        /* --- ดึงข้อมูล customfield addresstype  --- */
        $result         = $db->query("
                SELECT
                    cf.id, cf.default_value
                FROM
                    hb_client_fields cf
                WHERE
                    cf.code = 'addresstype'
                ")->fetch();
        $cfId           = isset($result['id']) ? $result['id'] : 0;
        
        $result         = $db->query("
                SELECT
                    ca.id
                FROM
                   hb_client_details cd,
                   hb_client_access ca,
                   hb_client_fields_values cfv
                WHERE
                    cd.parent_id = :loginClientId
                    AND cd.id = ca.id
                    AND ca.email = :emailAddress
                    AND ca.id = cfv.client_id
                    AND cfv.field_id = :cfId
                    AND cfv.value = 'Notify'
                ", array(
                    ':loginClientId'    => $oClient->id,
                    ':emailAddress'     => $emailaddress,
                    ':cfId'             => $cfId
                ))->fetch();
        
        if (isset($result['id']) && $result['id']) {
            echo json_encode(array('result' => array('success' => '0', 'message' => 'มีข้อมูล email นี้อยู่แล้ว')));
            exit;
        }
        
        $adminUrl       = GeneralCustom::singleton()->getAdminUrl();
        $apiCustom      = ApiCustom::singleton($adminUrl.'/api.php');
        
        $password       = GeneralCustom::singleton()->randomPassword();
        
        $aParam         = array(
                'call'      => 'addClientContact',
                
                'id'            => $oClient->id,
                'firstname'     => $emailaddress,
                'lastname'      => '-',
                'email'         => $oClient->email,
                'password'      => $password,
                'password2'     => $password,
                'country'       => 'TH'
                
            );
        
        $result         = $apiCustom->request($aParam);
        
        if (! isset($result['success']) || ! $result['success'] || ! $result['contact_id']) {
            echo json_encode(array('result' => array('success' => '0', 'message' => 'เกิดข้อผิดพลาดระหว่างเพิ่มข้อมูล')));
            exit;
        }
        
        $contactId      = $result['contact_id'];
        
        $db->query("
            UPDATE
                hb_client_access
            SET
                email = :email
            WHERE
                id = :clientId
            ", array(
                ':clientId'     => $contactId,
                ':email'        => $emailaddress
            ));
        
        $db->query("
            REPLACE INTO hb_client_fields_values (
                client_id, field_id, value
            ) VALUES (
                :clientId, :fieldId, 'Notify'
            )
            ", array(
                ':clientId'     => $contactId,
                ':fieldId'      => $cfId
            ));
            
        echo json_encode(array('result' => array('success' => '1', 'contactId' => $contactId)));
        exit;
    }
    
    public function updateContactType ($request)
    {
        $db         = hbm_db();
        
        $client     = hbm_logged_client();
        $oClient    = (object) $client;
        
        $clientId           = isset($request['clientId']) ? $request['clientId'] : 0;
        $contactType        = (isset($request['contactType']) && $request['contactType'] == 'Company') ? 1 : 0;
        $companyName        = isset($request['companyName']) ? $request['companyName'] : '';
        
        
        $result         = $db->query("
                SELECT
                    cd.id
                FROM
                   hb_client_details cd
                WHERE
                    cd.id = :clientId
                    AND ( cd.id = :loginClientId OR cd.parent_id = :loginClientId )
                ", array(
                    ':clientId'         => $clientId,
                    ':loginClientId'    => $oClient->id
                ))->fetch();
        
        if (isset($result['id']) && $result['id']) {
            $db->query("
                UPDATE
                    hb_client_details
                SET
                    company = :contactType,
                    companyName = :companyName
                WHERE
                    id = :clientId
                ", array(
                    ':clientId'         => $clientId,
                    ':contactType'      => $contactType,
                    ':companyName'      => ($contactType ? $companyName : '')
                ));
                
        }
        
        echo json_encode(array('result' => array('success' => '1')));
        exit;
    }
    
    public function saveDomainContact ($request, $domainId = 0)
    {
        $db         = hbm_db();
        
        $client     = hbm_logged_client();
        $oClient    = (object) $client;
        
        if (! $domainId) {
            return false;
        }
        
        if (! isset($request['registrant']) || ! count($request['registrant'])) {
            return false;
        }
        
        $result     = $db->query("
                SELECT
                    d.id, d.extended
                FROM
                    hb_domains d
                WHERE
                    d.id = :domainId
                    AND d.client_id = :clientId
                ", array(
                    ':domainId'     => $domainId,
                    ':clientId'     => $oClient->id
                ))->fetch();
                
        if (! isset($result['id'])) {
            return false;
        }
        
        $aExtended      = unserialize($result['extended']);
        $aExtended['registrant']    = $request['registrant'];
        $aExtended['admin']         = $request['admin'];
        $aExtended['tech']          = $request['tech'];
        $aExtended['billing']       = $request['billing'];
        
        $extended       = serialize($aExtended);
        
        $db->query("
            UPDATE
                hb_domains
            SET
                extended = :extended
            WHERE
                id = :domainId
            ", array(
                ':extended'     => $extended,
                ':domainId'     => $domainId
            ));
        
        return true;
    }
    
    public function updateDomainContact ($request)
    {
        require_once(APPDIR . 'class.config.custom.php');
        require_once(APPDIR . 'class.general.custom.php');
        require_once(APPDIR . 'class.api.custom.php');
        
        $adminUrl   = GeneralCustom::singleton()->getAdminUrl();
        $apiCustom  = ApiCustom::singleton($adminUrl.'/api.php');
        
        $db         = hbm_db();
        $admin      = hbm_logged_admin();
        $oAdmin     = isset($admin['id']) ? $admin : null;
        $client     = hbm_logged_client();
        $oClient    = (object) $client;
        
        $domainId   = isset($request['domainId']) ? $request['domainId'] : 0;
        
        $result     = $db->query("
                SELECT
                    d.id, d.name, d.extended
                FROM
                    hb_domains d
                WHERE
                    d.id = :domainId
                    AND d.client_id = :clientId
                ", array(
                    ':domainId'     => $domainId,
                    ':clientId'     => $oClient->id
                ))->fetch();
        if (! isset($result['id'])) {
            echo json_encode(array('result' => array('success' => '')));
            exit;
        }
        
        $domainName     = $result['name'];
        $aExtended      = unserialize($result['extended']);
        
        if (! isset($request['updateContactInfo']) || ! count($request['updateContactInfo'])) {
            echo json_encode(array('result' => array('success' => '')));
            exit;
        }
        
        $aContact       = $request['updateContactInfo'];
        $aContact_temp  = $aContact;
        
        foreach ($aContact_temp as $type => $arr) {
            
            if (! in_array($type, array('registrant', 'admin', 'tech', 'billing'))) {
                continue;
            }
            
            if (isset($aContact[$type]) && count($aContact[$type])) {
                if ($aContact[$type]['action'] == 'premade' && $aContact[$type]['contactid']) {
                    $result         = $this->_getContactAddress($aContact[$type]['contactid']);
                    
                    if (count($result)) {
                        foreach ($result as $k => $v) {
                            $aContact[$type][$k]     = $v;
                        }
                    }
                    
                }

                /* --- ถ้ามีการแก้ไข admin contact ให้ทำการส่ง ticket แจ้งให้เจ้าฟน้าที่ทราบด้วย --- */
                if ($type == 'admin') {
                        
                    $isEdit         = $this->_isEditContactAddress($aExtended[$type], $aContact[$type]);
                    
                    if ($isEdit) {
                        
                        $message    = '<br />';
                        foreach ($aExtended[$type] as $kInfo => $vInfo) {
                            $message    .= '<br />['. $kInfo .'] '. $vInfo .' === ';
                            if ($vInfo != $aContact[$type][$kInfo]) {
                                $message    .= '***** '. $aContact[$type][$kInfo] .' *****';
                            } else {
                                $message    .= $aContact[$type][$kInfo];
                            }
                        }

                        require_once(APPDIR . 'class.config.custom.php');
                        $nwDomainDepartmentId = ConfigCustom::singleton()->getValue('nwDomainDepartmentId');
                        
                        $subject    = 'Client change domain '. $domainName .' admin contact.';
                        $message    = 'ให้โทรไปตรวจสอบว่า ลูกค้าได้ดำเนินการจริงหรือไม่ ด้วยจ๊ะ '. $message;
                        $aParam     = array(
                            'call'      => 'addTicket',
                            
                            'name'      => $oClient->firstname .' '. $oClient->lastname,
                            'subject'   => $subject,
                            'body'      => $message,
                            'email'     => $oClient->email,
                            
                            'dept_id'   => $nwDomainDepartmentId,
                            'client_id' => $oClient->id
                        
                        );
                        if (! isset($oAdmin->id) || ! $oAdmin->id) {
                            //$result     = $apiCustom->request($aParam);
                            $header     = 'MIME-Version: 1.0' . "\r\n" .
                                    'Content-type: text/plain; charset=utf-8' . "\r\n" .
                                    'From: ' . $oClient->email . "\r\n" .
                                    'Reply-To: ' . $oClient->email . "\r\n" .
                                    'X-Mailer: PHP/' . phpversion();
                            $mailto     = 'sales@netway.co.th';
                            @mail($mailto, $subject, $message, $header);
                        }
                    
                    }
                }
                
                /* --- 'registrant' ไม่ให้ update ให้ส่งเอกสารมาแทน --- */
                if ($type != 'registrant') {
                    $aExtended[$type]   = $aContact[$type];
                }
                
            }
            
            
        }

        foreach ($aContact_temp as $type => $arr) {
            if (! in_array($type, array('admin', 'tech', 'billing'))) {
                continue;
            }
            
            if ($aContact[$type]['action'] == 'registrant') {
                $aContact[$type]    = $aContact['registrant'];
                $aExtended[$type]   = $aContact[$type];
            }
            
        }
        
        /* --- กรณีใช้ technical contact ของ netway --- */
        $nwTechnicalContact     = ConfigCustom::singleton()->getValue('nwTechnicalContact');
        if ($aContact['tech']['action'] == 'netway') {
            $result         = $this->_getContactAddress($nwTechnicalContact);
            if (count($result)) {
                foreach ($result as $k => $v) {
                    $aContact['tech'][$k]     = $v;
                }
                $aExtended['tech']   = $aContact['tech'];
            }
        }
        
        $extended       = serialize($aExtended);
        
        $db->query("
            UPDATE
                hb_domains
            SET
                extended = :extended
            WHERE
                id = :domainId
            ", array(
                ':extended'     => $extended,
                ':domainId'     => $domainId
            ));
        
        echo json_encode(array('result' => array('success' => '1')));
        exit;
    }

    private function _isEditContactAddress ($aCurrent, $aNew)
    {
        $currentAddress     = $aCurrent['firstname'] . $aCurrent['lastname'] . $aCurrent['companyname'] .
                              $aCurrent['email'] . $aCurrent['address1'] . $aCurrent['address2'] .
                              $aCurrent['city'] . $aCurrent['state'] . $aCurrent['postcode'] .
                              $aCurrent['country'] . $aCurrent['phonenumber'];
        $newAddress         = $aNew['firstname'] . $aNew['lastname'] . $aNew['companyname'] .
                              $aNew['email'] . $aNew['address1'] . $aNew['address2'] .
                              $aNew['city'] . $aNew['state'] . $aNew['postcode'] .
                              $aNew['country'] . $aNew['phonenumber'];

        if (md5($currentAddress) != md5($newAddress)) {
            return true;
        } else {
            return false;
        }
    }
    
    private function _getContactAddress ($contactId)
    {
        $db         = hbm_db();
        $result     = $db->query("
                SELECT
                    ca.email,
                    cd.firstname,
                    cd.lastname,
                    cd.companyname,
                    cd.address1,
                    cd.address2,
                    cd.city,
                    cd.state,
                    cd.postcode,
                    cd.country,
                    cd.phonenumber
                FROM
                    hb_client_access ca,
                    hb_client_details cd
                WHERE
                    cd.id = :contactId
                    AND cd.id = ca.id
                ", array(
                    ':contactId'        => $contactId
                ))->fetch();
        
        return $result;
    }

    private function _beforeRender ()
    {
        $this->template->assign('tplPath', dirname(dirname(__FILE__)) . '/templates/');
        $this->template->assign('tplClientPath', MAINDIR . 'templates/');
    }
    
    public function afterCall ($request)
    {
        
    }
}