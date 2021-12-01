<?php

class zendeskintegratehandle_controller extends HBController {
    
    private static  $instance;
    
    public static function singleton ()
    {
        if (!isset(self::$instance)) {
            $c = __CLASS__;
            self::$instance = new $c();
        }
        
        return self::$instance;
    }
    
    public function __clone ()
    {
        trigger_error('Clone is not allowed.', E_USER_ERROR);
    }
    
    public $aUsers     = array(
            'pairote'  => '15876698527',
            'prasit'   => '18799857608',
            'natdanai' => '18799917548',
            'chinnapat'=> '19801910628',
            'paisarn'  => '19826147787',
            'jatturaput'  => '19832194668',
            'siripen'  => '19868660888',
            'passaraporn'  => '19948588148',
            'thirawat'  => '20964006288',
            'chanin'  => '19732369047',
            'sarawut'  => '19824305487',
            'prapatsorn'  => '19828783668',
            'thananun'  => '19829135887',
            'sudarat'  => '19838943868',
            'burin'  => '19840754988',
            'vanvipa'  => '19875537787',
            'jutiphorn'  => '19882798667',
            'nutthawat'  => '19896527068',
            'anan'  => '20769285287',
            'thanitpong'  => '20914976647',
            'yuranun'  => '20916524207',
            'anont'  => '20990207268',
            'narest'  => '20990222468',
            'monthira'  => '20992477528',
            'arisara'  => '21405530568',
        );
    
    public $aPublicOrganization    = array(
        '15972683328',   // gmail.com
        );
    
    public function beforeCall ($request)
    {
        $aNotification  = isset($_SESSION['notification']) ? $_SESSION['notification'] : array();
        $this->template->assign('aNotification', $aNotification);
        
        $this->template->assign('tplPath', dirname(dirname(__FILE__)) . '/templates/');
        $this->template->assign('tplClientPath', MAINDIR . 'templates/');
    }
    
    public function _default ($request)
    {
        $db         = hbm_db();
        
        $oInfo          = (object) array(
            'title'     => 'Information',
            'desc'      => 'เลือกจัดการข้อมูลตามเมนูด้านซ้าย'
            );
        $this->template->assign('oInfo', $oInfo);
        
        // https://github.com/giggsey/libphonenumber-for-php

        /*
        require_once( APPDIR . 'lib/libphonenumber/PhoneNumberUtil.php' );
        require_once( APPDIR . 'lib/libphonenumber/PhoneNumberFormat.php' );
        $phoneUtil  = PhoneNumberUtil::getInstance();
        
        $number         = '264203-51';
        $numberProto    = $phoneUtil->parse($number, 'TH');
        $result         = $phoneUtil->format($numberProto, PhoneNumberFormat::INTERNATIONAL);
        */
        
        //echo '<p><pre>'. print_r($result, true) .'</pre></p>';
        
        $this->template->render(dirname(dirname(__FILE__)) .'/templates/admin/default.tpl',array(), true);
    }
    
    public function user ($request)
    {
        $db         = hbm_db();
        
        $oInfo          = (object) array(
            'title'     => 'User integration',
            'desc'      => 'จัดการข้อมูลผู้ใช้งาน'
            );
        
        
        $isReturn   = isset($request['isReturn']) ? $request['isReturn'] : 0;
        $clientId   = isset($request['clientId']) ? $request['clientId'] : 0;
        
        $aDatas     = array();
        
        $result     = $db->query("
            SELECT ca.id, ca.email, zu.client_id, zu.user_id, zu.org_id,
                cd.firstname, cd.lastname
            FROM hb_client_access ca
                LEFT JOIN hb_zendesk_user zu
                    ON zu.client_id = ca.id
                ,
                hb_client_details cd
            WHERE ca.id = cd.id
                AND (zu.user_id IS NULL OR zu.user_sync_date < SUBDATE(CURDATE(), 7))
                
                ". ($clientId ? " AND ca.id = '{$clientId}' " : " AND zu.is_error_email = 0 ") ."
                
            ORDER BY ca.id DESC
            LIMIT 10
            ")->fetchAll();
        
        if (count($result)) {
            $result_    = $result;
            foreach ($result_ as $arr) {
                $clientId   = $arr['id'];
                $userId     = $arr['user_id'];
                $orgId      = $arr['org_id'];
                $email      = trim(strtolower($arr['email']));
                if ($arr['firstname'] || $arr['lastname']) {
                $name       = $arr['firstname'] .' '. $arr['lastname'];
                } else {
                $name       = $email;
                }
                if (! isset($arr['client_id']) || ! $arr['client_id']) {
                    $db->query("
                        INSERT INTO hb_zendesk_user (
                        client_id
                        ) VALUES (
                        :clientId
                        )
                        ", array(
                            ':clientId'     => $clientId
                        ));
                }
                
                $aParam         = array(
                    'url'       => '/users/search.json?query='. $email,
                    'method'    => 'get',
                    'data'      => array()
                );
                $result = self::_send($aParam);
                $result = isset($result['users'][0]) ? $result['users'][0] : array();
                
                if (isset($result['id']) && $userId && $result['id'] != $userId) {
                    $db->query("
                        UPDATE hb_zendesk_user
                        SET is_error_email = 1,
                            user_sync_date = NOW()
                        WHERE client_id = :clientId
                        ", array(
                            ':clientId' => $clientId
                        ));
                    continue;
                }
                
                if (! isset($result['email']) || $result['email'] != $email) {
                    
                    $aParam         = array(
                        'url'       => '/users.json',
                        'method'    => 'post',
                        'data'      => array(
                            'user'      => array(
                                'email'     => $email,
                                'name'      => $name,
                                'role'      => 'end-user',
                                'locale'    => 'th',
                                'time_zone' => 'Bangkok',
                                'verified'  => true
                            )
                        )
                    );
                    $result = self::_send($aParam);
                    $result = isset($result['user']) ? $result['user'] : array();
                    
                }
                
                if (isset($result['id'])) {
                    $userId     = $result['id'];
                    
                    $db->query("
                        UPDATE hb_zendesk_user
                        SET user_id = :userId,
                            user_sync_date = NOW()
                        WHERE client_id = :clientId
                        ", array(
                            ':userId'   => $userId,
                            ':clientId' => $clientId
                        ));
                    
                }
                
                $aDatas[$clientId]      = $result;
                
                $orgName    = '';
                if ($orgId) {
                    $aParam         = array(
                        'url'       => '/organizations/'. $orgId .'.json',
                        'method'    => 'get',
                        'data'      => array()
                    );
                    $result = self::_send($aParam);
                    $result = isset($result['organization']) ? $result['organization'] : array();
                    $orgName    = isset($result['name']) ? $result['name'] : '';
                    
                }
                
                $db->query("
                    UPDATE hb_zendesk_user
                    SET user_sync_date = NOW(),
                        org_name = :orgName
                    WHERE client_id = :clientId
                    ", array(
                        ':orgName'  => $orgName,
                        ':clientId' => $clientId
                    ));
                
            }
        }
        
        if ($isReturn) {
            return $aDatas;
        }
        
        $this->template->assign('oInfo', $oInfo);
        $this->template->assign('aDatas', $aDatas);
        
        $this->template->render(dirname(dirname(__FILE__)) .'/templates/admin/user.tpl',array(), true);
    }
    
    public function organization ($request)
    {
        $db         = hbm_db();
        
        $oInfo          = (object) array(
            'title'     => 'User organization integration',
            'desc'      => 'จัดการข้อมูล Organization ของผู้ใช้งาน'
            );
        $this->template->assign('oInfo', $oInfo);
        
        $isReturn   = isset($request['isReturn']) ? $request['isReturn'] : 0;
        
        $aDatas     = array();
        
        $aIgnoreOrg = array(
            '-1',
            '15972683328', #gmail
            '15886541487', #outlook
        );
        
        $db->query("
            UPDATE hb_zendesk_user
            SET org_id = ''
            WHERE org_id IN ('". implode("','", $aIgnoreOrg) ."')
            ");
        
        $result     = $db->query("
            SELECT ca.id, ca.email, zu.user_id, zu.org_id,
                cd.companyname
            FROM hb_client_access ca,
                hb_client_details cd,
                hb_zendesk_user zu
            WHERE ca.id = cd.id
                # AND cd.company = 1
                AND cd.parent_id = 0
                AND ca.id = zu.client_id
                AND zu.user_id != ''
                AND (zu.org_id = '' OR zu.org_id = '0') 
                AND zu.org_sync_date < zu.user_sync_date
            ORDER BY ca.id DESC
            LIMIT 10
            ")->fetchAll();
        
        if (count($result)) {
            $result_    = $result;
            foreach ($result_ as $arr) {
                $clientId   = $arr['id'];
                $userId     = $arr['user_id'];
                $orgId      = $arr['org_id'];
                $companyname    = $arr['companyname'] ? $arr['companyname'] : 'Organization #'. $clientId;
                
                if (! $orgId) {
                    
                    $aParam         = array(
                        'url'       => '/users/'. $userId .'.json',
                        'method'    => 'get',
                        'data'      => array()
                    );
                    $result = self::_send($aParam);
                    $result = isset($result['user']) ? $result['user'] : array();
                    
                    $orgId      = isset($result['organization_id']) ? $result['organization_id'] : 0;
                    if (in_array($orgId, $aIgnoreOrg)) {
                        $orgId  = 0;
                    }
                    
                    if (! $orgId) {
                        
                        $aParam         = array(
                            'url'       => '/organizations.json',
                            'method'    => 'post',
                            'data'      => array(
                                'organization'  => array(
                                    'name'      => $companyname
                                )
                            )
                        );
                        $result = self::_send($aParam);
                        $result = isset($result['organization']) ? $result['organization'] : array();
                        
                        if (! isset($result['id'])) {
                            $aParam         = array(
                                'url'       => '/organizations.json',
                                'method'    => 'post',
                                'data'      => array(
                                    'organization'  => array(
                                        'name'      => 'Org #'. $clientId
                                    )
                                )
                            );
                            $result = self::_send($aParam);
                            $result = isset($result['organization']) ? $result['organization'] : array();
                        }
                        
                        $orgId      = isset($result['id']) ? $result['id'] : 0;
                        
                        $result['json']         = 'organizations';
                        $aDatas[$clientId]      = $result;
                        
                        if ($orgId) {
                            
                            $aParam         = array(
                                'url'       => '/organization_memberships.json',
                                'method'    => 'post',
                                'data'      => array(
                                    'organization_membership'   => array(
                                        'user_id'           => $userId,
                                        'organization_id'   => $orgId,
                                        'default'   => true
                                    )
                                )
                            );
                            $result = self::_send($aParam);
                            $result = isset($result['organization_membership']) ? $result['organization_membership'] : array();
                            
                            if (isset($result['id'])) {
                                $db->query("
                                    UPDATE hb_zendesk_user
                                    SET org_id = :orgId,
                                        org_sync_date = NOW()
                                    WHERE client_id = :clientId
                                    ", array(
                                        ':orgId'    => $orgId,
                                        ':clientId' => $clientId
                                    ));
                                
                                $result['json']         = 'organization_memberships';
                                $aDatas[$clientId]      = $result;
                            }
                            
                        }
                        
                    } else {
                        $orgId      = $result['organization_id'];
                        $db->query("
                            UPDATE hb_zendesk_user
                            SET org_id = :orgId,
                                org_sync_date = NOW()
                            WHERE client_id = :clientId
                            ", array(
                                ':orgId'    => $orgId,
                                ':clientId' => $clientId
                            ));
                    }
                
                }
                
                if (! $orgId) {
                    $db->query("
                        UPDATE hb_zendesk_user
                        SET org_sync_date = NOW()
                        WHERE client_id = :clientId
                        ", array(
                            ':clientId' => $clientId
                        ));
                }
                
                $result     = $db->query("
                    SELECT ca.id, ca.email, zu.user_id, zu.org_id,
                        cd.companyname
                    FROM hb_client_access ca,
                        hb_client_details cd,
                        hb_zendesk_user zu
                    WHERE ca.id = cd.id
                        AND cd.parent_id = '{$clientId}'
                        AND ca.id = zu.client_id
                        AND zu.user_id != ''
                        AND zu.org_id = ''
                    ")->fetchAll();
                
                if (! count($result)) {
                    continue;
                }
                
                $result2    = $result;
                $aCompanyname   = array();
                
                foreach ($result2 as $arr) {
                    $clientId   = $arr['id'];
                    $userId     = $arr['user_id'];
                    $userId     = $arr['user_id'];
                    
                    if (! $orgId) {
                        $db->query("
                            UPDATE hb_zendesk_user
                            SET org_sync_date = NOW()
                            WHERE client_id = :clientId
                            ", array(
                                ':clientId' => $clientId
                            ));
                        continue;
                    }
                    
                    $isCreateSubOrg = 0;
                    if ($arr['companyname'] && $arr['companyname'] != $companyname) {
                        if (! $arr['org_id'] || $arr['org_id'] == $orgId) {
                            $isCreateSubOrg = 1;
                        }
                    }
                    
                    $subOrgId   = $orgId;
                    
                    if ($isCreateSubOrg) {
                        $companyname    = $arr['companyname'];
                        
                        if (isset($aCompanyname[$companyname])) {
                            $subOrgId   = $aCompanyname[$companyname];
                        } else {
                            
                            $aParam         = array(
                                'url'       => '/organizations.json',
                                'method'    => 'post',
                                'data'      => array(
                                    'organization'  => array(
                                        'name'      => $companyname
                                    )
                                )
                            );
                            $result = self::_send($aParam);
                            $result = isset($result['organization']) ? $result['organization'] : array();
                            $subOrgId   = isset($result['id']) ? $result['id'] : 0;
                            
                            if ($subOrgId) {
                                $aCompanyname[$companyname] = $subOrgId;
                            }
                        
                        }
                        
                    }
                    
                    
                    $aParam         = array(
                        'url'       => '/organization_memberships.json',
                        'method'    => 'post',
                        'data'      => array(
                            'organization_membership'   => array(
                                'user_id'           => $userId,
                                'organization_id'   => $subOrgId,
                                'default'   => true
                            )
                        )
                    );
                    $result = self::_send($aParam);
                    $result = isset($result['organization_membership']) ? $result['organization_membership'] : array();
                    
                    if (isset($result['id'])) {
                        $db->query("
                            UPDATE hb_zendesk_user
                            SET org_id = :orgId,
                                org_sync_date = NOW()
                            WHERE client_id = :clientId
                            ", array(
                                ':orgId'    => $orgId,
                                ':clientId' => $clientId
                            ));
                        
                        $result['json']         = 'organization_memberships';
                        $aDatas[$clientId]      = $result;
                    }

                    $db->query("
                        UPDATE hb_zendesk_user
                        SET org_sync_date = NOW()
                        WHERE client_id = :clientId
                        ", array(
                            ':clientId' => $clientId
                        ));
                    
                }
                
            }
        }
        
        $this->template->assign('aDatas', $aDatas);
        
        if ($isReturn) {
            return $aDatas;
        }
        
        $this->template->render(dirname(dirname(__FILE__)) .'/templates/admin/organization.tpl',array(), true);
    }
    
    public function setorgclientid ($request)
    {
        $db         = hbm_db();
        
        $oInfo          = (object) array(
            'title'     => 'Main client id',
            'desc'      => 'จัดการเชื่อมข้อมูล client id ของ Netway กับ Organization ขแง Zendesk'
            );
        $this->template->assign('oInfo', $oInfo);
        
        $isReturn   = isset($request['isReturn']) ? $request['isReturn'] : 0;
        
        $aDatas     = array();
        
        $result     = $db->query("
            SELECT *
            FROM hb_zendesk_user
            WHERE is_set_org_client_id = 0
                AND user_id != ''
                AND org_id != ''
                AND org_id != '0'
                AND sync_date < user_sync_date
            LIMIT 10
            ")->fetchAll();
        
        if (count($result)) {
            $result_    = $result;
            foreach ($result_ as $arr) {
                $clientId   = $arr['client_id'];
                $orgId      = $arr['org_id'];
                $userId     = $arr['user_id'];
                
                $aParam         = array(
                    'url'       => '/organizations/'. $orgId .'.json',
                    'method'    => 'get',
                    'data'      => array(
                    )
                );
                $result = self::_send($aParam);
                $result = isset($result['organization']) ? $result['organization'] : array();
                $orgName    = isset($result['name']) ? $result['name'] : array();
                $aField = isset($result['organization_fields']) ? $result['organization_fields'] : array();
                $mainClientId   = isset($aField['main_client_id']) ? $aField['main_client_id'] : 0;
                
                if (! $mainClientId) {
                    $aParam         = array(
                        'url'       => '/organizations/'. $orgId .'.json',
                        'method'    => 'put',
                        'data'      => array(
                            'organization'  => array(
                                'organization_fields'   => array(
                                    'main_client_id'    => $clientId
                                )
                            )
                        )
                    );
                    $result = self::_send($aParam);
                    $result = isset($result['organization']) ? $result['organization'] : array();
                }
                
                $aDatas[$clientId]  = $result;
                
                $db->query("
                    UPDATE hb_zendesk_user
                    SET is_set_org_client_id = 1,
                        org_name = :orgName,
                        sync_date = NOW()
                    WHERE client_id = :clientId
                    ", array(
                        ':orgName'  => $orgName,
                        ':clientId' => $clientId
                    ));
                
            }
        }
        
        if ($isReturn) {
            return $aDatas;
        }
        
        $this->template->assign('aDatas', $aDatas);
        
        $this->template->render(dirname(dirname(__FILE__)) .'/templates/admin/setorgclientid.tpl',array(), true);
    }
    
    public function importticket ($request)
    {
        $db         = hbm_db();
        
        $oInfo          = (object) array(
            'title'     => 'Import ticket',
            'desc'      => 'นำเข้า ticket ไปยัง zendesk'
            );
        $this->template->assign('oInfo', $oInfo);
        
        $isReturn   = isset($request['isReturn']) ? $request['isReturn'] : 0;
        
        $aDatas     = array();
        
        $aUsers     = $this->aUsers;
        
        $result     = $db->query("
            SELECT t.id, t.subject, t.client_id, t.body, t.ticket_number, t.date, t.lastupdate,
                zt.ticket_id, zt.zendesk_ticket_id, zt.replies,
                t2r.request_type
            FROM hb_tickets t
                LEFT JOIN hb_zendesk_ticket zt
                    ON zt.ticket_id = t.id
                LEFT JOIN sc_ticket_2_request t2r
                    ON t2r.ticket_id = t.id
            WHERE (zt.zendesk_ticket_id IS NULL AND (zt.sync_date IS NULL OR zt.sync_date < SUBDATE(CURDATE(), 3) ) )
            ORDER BY t.id ASC
            LIMIT 20
            ")->fetchAll();
        
        $result_    = count($result) ? $result : array();
        
        foreach ($result_ as $arr) {
            $ticketId       = $arr['id'];
            $ticketNum      = $arr['ticket_number'];
            $clientId       = $arr['client_id'];
            $subject        = $arr['subject'];
            $description    = $arr['body'];
            $zendeskId      = $arr['zendesk_ticket_id'];
            switch ($arr['request_type']) {
                case 'Service Request' : $type = 'question'; break;
                case 'Change' : $type = 'task'; break;
                case 'Problem' : $type = 'problem'; break;
                default : $type = 'incident';
            }
            $create         = date('Y-m-d', strtotime($arr['date']));
            $update         = date('Y-m-d', strtotime($arr['lastupdate']));
            
            if (! $arr['ticket_id']) {
                $db->query("
                    INSERT INTO hb_zendesk_ticket (
                    ticket_id
                    ) VALUES (
                    :ticketId
                    )
                    ", array(
                        ':ticketId' => $ticketId
                    ));
            }
            
            $result     = $db->query("
                SELECT zu.user_id
                FROM hb_zendesk_user zu
                WHERE zu.client_id = :clientId
                ", array(
                    ':clientId'     => $clientId
                ))->fetch();
            
            $userId     = (isset($result['user_id']) && $result['user_id']) ? $result['user_id'] : 0;
            
            if (! $userId) {
                $db->query("
                    UPDATE hb_zendesk_ticket
                    SET zendesk_ticket_id = -1
                    WHERE ticket_id = :ticketId
                    ", array(
                        ':ticketId' => $ticketId
                    ));
                
                continue;
            }

            $db->query("
                UPDATE hb_zendesk_ticket
                SET sync_date = NOW()
                WHERE ticket_id = :ticketId
                ", array(
                    ':ticketId'     => $ticketId
                ));
            
            $aComments  = array();
            $aComments[]    = array(
                'author_id' => 18799857608, #prasit@netway.co.th
                'value'     => 'Import from https://netway.co.th/7944web/index.php?cmd=tickets&action=view&list=all&num='. $ticketNum,
                'created_at'    => date('Y-m-d'),
                'public'    => false
            );
            
            $result     = $db->query("
                SELECT tr.*,
                    zu.user_id
                FROM hb_ticket_replies tr
                    LEFT JOIN hb_zendesk_user zu
                        ON zu.client_id = tr.replier_id
                WHERE tr.ticket_id = :ticketId
                ", array(
                    ':ticketId' => $ticketId
                ))->fetchAll();
            
            if (count($result)) {
                foreach ($result as $arr2) {
                    if (! $arr2['user_id']) {
                    $aEmail = explode('@', strtolower($arr2['email']));
                    $uid    = (isset($aEmail[0]) && isset($aUsers[$aEmail[0]])) ? $aUsers[$aEmail[0]] : 18799857608;
                    $arr2['user_id']    = $uid;
                    }
                    $aComments[]  = array(
                        'author_id' => $arr2['user_id'],
                        'value'     => $arr2['body'] ."\nReply by: ". $arr2['name'] .' '. $arr2['email'],
                        'created_at'    => date('Y-m-d', strtotime($arr2['date'])),
                        'public'    => (($arr2['user_id'] == 'Client') ? true : false)
                    );
                }
            }
            
            $result     = $db->query("
                SELECT tn.*
                FROM hb_tickets_notes tn
                WHERE tn.ticket_id = :ticketId
                ", array(
                    ':ticketId' => $ticketId
                ))->fetchAll();
            
            if (count($result)) {
                foreach ($result as $arr2) {
                    $aEmail = explode('@', strtolower($arr2['email']));
                    $uid    = (isset($aEmail[0]) && isset($aUsers[$aEmail[0]])) ? $aUsers[$aEmail[0]] : 18799857608;
                    $aComments[]  = array(
                        'author_id' => $uid,
                        'value'     => $arr2['note'] ."\nNote by: ". $arr2['name'] .' '. $arr2['email'],
                        'created_at'    => date('Y-m-d', strtotime($arr2['date'])),
                        'public'    => false
                    );
                }
            }
            
            
            if (! $zendeskTicketId) {
                $aParam     = array(
                    'ticket'    => array(
                        'created_at'    => $create,
                        'updated_at'    => $update,
                        'subject'       => $subject,
                        'description'   => $description,
                        'type'          => $type,
                        'requester_id'  => $userId,
                        'status'        => 'closed',
                        'tags'          => array('import_from_hostbill'),
                        'comments'      => $aComments
                    )
                );
                $data       = json_encode($aParam);
                
                $ch = curl_init();
                curl_setopt($ch, CURLOPT_URL, 'https://pdi-netway.zendesk.com/api/v2/imports/tickets.json');
                curl_setopt($ch, CURLOPT_POST, 1);
                curl_setopt($ch, CURLOPT_TIMEOUT, 30);
                curl_setopt($ch, CURLOPT_RETURNTRANSFER, 1);
                curl_setopt($ch, CURLOPT_POSTFIELDS, $data);
                curl_setopt($ch, CURLOPT_SSL_VERIFYPEER, false);
                curl_setopt($ch, CURLOPT_SSL_VERIFYHOST, false);
                curl_setopt($ch, CURLOPT_USERPWD, 'prasit@netway.co.th/token:mbPrx5uPCbCjez9QZ0oBSy4WBmYrm4wly382yJw1');
                curl_setopt($ch, CURLOPT_HTTPAUTH, CURLAUTH_BASIC);
                curl_setopt($ch, CURLOPT_HTTPHEADER, array('Content-Type:application/json'));
                $data   = curl_exec($ch);
                curl_close($ch);
                $result = json_decode($data, true);
                //echo '<p><pre>'. print_r($result, true) .'</pre></p>';
                $result = isset($result['ticket']) ? $result['ticket'] : array();
                
                $zendeskId      = isset($result['id']) ? $result['id'] : '';
            
            }
            
            if ($zendeskId) {
                $db->query("
                    UPDATE hb_zendesk_ticket
                    SET zendesk_ticket_id = :zendeskId,
                        sync_date = NOW()
                    WHERE ticket_id = :ticketId
                    ", array(
                        ':zendeskId'    => $zendeskId,
                        ':ticketId'     => $ticketId
                    ));
            }
            
            $aDatas[$ticketNum]     = $result;
            
        }
        
        $this->template->assign('aDatas', $aDatas);
        
        if ($isReturn) {
            return $aDatas;
        }
        
        $this->template->render(dirname(dirname(__FILE__)) .'/templates/admin/importticket.tpl',array(), true);
    }
    
    public function getUser ($request)
    {
        $db         = hbm_db();
        
        $email      = isset($request['email']) ? $request['email'] : '';
        $clientId   = isset($request['clientId']) ? $request['clientId'] : 0;
        
        $aData      = array();
        
        if (! $email) {
            return $aData;
        }
        
        $request    = array(
            'url'       => '/users/search.json?query='. $email,
            'method'    => 'get',
            'data'      => array()
        );
        $result     = self::_send($request);
        
        $result     = isset($result['users'][0]) ? $result['users'][0] : array();
        
        if (isset($result['id'])) {
            $userId     = $result['id'];
            $orgId      = isset($result['organization_id']) ? $result['organization_id'] : 0;
            $aData      = $result;
            
            // Check organization share ticket
            
            if (in_array($orgId, $this->aPublicOrganization)) {
                $orgId  = 0;
                $aData['organization_id']   = $orgId;
                
            } else {
                $request    = array(
                    'url'       => '/users/'. $userId .'/organizations.json',
                    'method'    => 'get',
                    'data'      => array()
                );
                $result     = self::_send($request);
                $result     = isset($result['organizations']) ? $result['organizations'] : array();
                
                if (count($result)) {
                    foreach ($result as $arr) {
                        if ($arr['shared_tickets']) {
                            $orgId  = $arr['id'];
                        } else {
                            $orgId  = 0;
                        }
                    }
                }
                
                $aData['organization_id']   = $orgId;
            }
            
            $result     = $db->query("
                SELECT zu.*
                FROM hb_zendesk_user zu
                WHERE zu.client_id = :clientId
                ", array(
                    ':clientId'     => $clientId
                ))->fetch();
            
            if (isset($result['client_id'])) {
                $db->query("
                    UPDATE hb_zendesk_user
                    SET user_id = :userId,
                        org_id = :orgId,
                        sync_date = NOW()
                    WHERE client_id = :clientId
                    ", array(
                        ':userId'   => $userId,
                        ':orgId'    => $orgId,
                        ':clientId' => $clientId
                    ));
            } else {
                $db->query("
                    INSERT INTO hb_zendesk_user (
                        client_id, user_id, org_id, sync_date
                    ) VALUES (
                        :clientId, :userId, :orgId, NOW()
                    )
                    ", array(
                        ':userId'   => $userId,
                        ':orgId'    => $orgId,
                        ':clientId' => $clientId
                    ));
            }
            
        }
        
        
        return $aData;
    }
    
    public function createTicket ($request)
    {
        $db         = hbm_db();
        
        $aAdmin     = hbm_logged_admin();
        $aUsers     = $this->aUsers;
        
        $email      = isset($aAdmin['email']) ? $aAdmin['email'] : '';
        $staff      = explode('@', $email);
        $staff      = (isset($staff[0]) && $staff[0]) ? strtolower($staff[0]) : '';
        $agentId    = isset($aUsers[$staff]) ? $aUsers[$staff] : 0;
        
        $subject    = isset($request['subject']) ? $request['subject'] : '';
        $comment    = isset($request['body']) ? $request['body'] : '';
        $type       = isset($request['type']) ? $request['type'] : 'task';
        $groupId    = isset($request['groupId']) ? $request['groupId'] : 33275407; // 33275407 TS Group ID
        $tag        = isset($request['tag']) ? $request['tag'] : '';
        $clientId   = isset($request['clientId']) ? $request['clientId'] : 0;
        
        $aTag       = array('fulfillment_ticket');
        if ($tag) {
            array_push($aTag, $tag);
        }
        
        $result     = $db->query("
            SELECT *
            FROM hb_zendesk_user
            WHERE client_id = :clientId
            ", array(
                ':clientId' => $clientId
            ))->fetch();
        
        $userId     = isset($result['user_id']) ? $result['user_id'] : 0;
        
        $aParam     = array(
            'ticket'    => array(
                'group_id'      => $groupId,
                'requester_id'  => $userId,
                'submitter_id'  => $userId,
                'subject'       => $subject,
                'type'          => $type,
                'tags'          => $aTag,
                #'description'   => $comment,
                'comment'       => array(
                    #'body'      => $comment,
                    'public'    => 'false',
                    'html_body' => nl2br($comment)
                )
            )
        );
        if ($agentId) {
            $aParam['ticket']['assignee_id']   = $agentId;
        }
        
        $request    = array(
            'url'       => '/tickets.json',
            'method'    => 'post',
            'data'      => $aParam
        );
        $result     = self::_send($request);
        $result_    = $result;
        
        $result     = isset($result['ticket']) ? $result['ticket'] : array();
        $ticketId   = isset($result['id']) ? $result['id'] : 0;
        
        if (! $ticketId) {
            $db->query("
                INSERT INTO `hb_error_log` (
                    `id`, `date`, `entry`, `type`
                ) VALUES (
                    '', NOW(), '". serialize($result_) ."', 'Other'
                )
                ");
        }
        
        return $ticketId;
    }
    
    public function updateTicket ($request)
    {
        $db         = hbm_db();
        
        $ticketId   = isset($request['ticketId']) ? $request['ticketId'] : 0;
        $aData      = array();
        
        $result     = $db->query("
            SELECT zt.*
            FROM hb_zendesk_ticket zt,
                hb_tickets t
            WHERE zt.ticket_id = :ticketId
                AND zt.ticket_id = t.id
                AND t.status != 'Closed'
            ", array(
                ':ticketId'     => $ticketId
            ))->fetch();
        
        if (! isset($result['ticket_id'])) {
            return $aData;
        }
        
        $zendeskTicketId    = $result['zendesk_ticket_id'];
        
        $request    = array(
            'url'       => '/tickets/'. $zendeskTicketId .'.json',
            'method'    => 'get',
            'data'      => array()
        );
        $result     = self::_send($request);
        
        $result     = isset($result['ticket']) ? $result['ticket'] : array();
        
        if (isset($result['status']) && in_array($result['status'],array('solved','closed'))) {
            $db->query("
                UPDATE hb_tickets
                SET status = 'Closed'
                WHERE id = :id
                ", array(
                    ':id'   => $ticketId
                ));
            $db->query("
                UPDATE hb_zendesk_ticket
                SET sync_date = NOW()
                WHERE ticket_id = :id
                ", array(
                    ':id'   => $ticketId
                ));
            $result['status']   = 'Closed';
        }
        
        return $result;
    }
    
    public function assignAgent ($request)
    {
        $db         = hbm_db();
        
        $ticketId   = isset($request['ticketId']) ? $request['ticketId'] : 0;
        $emailStaff = isset($request['staffEmail']) ? $request['staffEmail'] : '';
        $aData      = array();
        
        $result     = $db->query("
            SELECT zt.*
            FROM hb_zendesk_ticket zt
            WHERE zt.ticket_id = :ticketId
            ", array(
                ':ticketId'     => $ticketId
            ))->fetch();
        
        if (! isset($result['zendesk_ticket_id']) || $result['zendesk_ticket_id'] < 1) {
            return $aData;
        }
        
        $zendeskTicketId    = $result['zendesk_ticket_id'];
        
        $aUsers = $this->aUsers;
        $aEmail = explode('@', strtolower($emailStaff));
        $uid    = (isset($aEmail[0]) && isset($aUsers[$aEmail[0]])) ? $aUsers[$aEmail[0]] : '';
        
        $aData      = array(
            'ticket'    => array(
                'assignee_id'   => $uid
            )
        );
        
        $request    = array(
            'url'       => '/tickets/'. $zendeskTicketId .'.json',
            'method'    => 'put',
            'data'      => $aData
        );
        $result     = self::_send($request);
        
        return $aData;
    }
    
    public function addTicketTag ($request)
    {
        $db         = hbm_db();
        
        $ticketId   = isset($request['ticketId']) ? $request['ticketId'] : 0;
        $tag        = isset($request['tag']) ? $request['tag'] : '';
        $aData      = array();
        
        $result     = $db->query("
            SELECT zt.*
            FROM hb_zendesk_ticket zt
            WHERE zt.ticket_id = :ticketId
            ", array(
                ':ticketId'     => $ticketId
            ))->fetch();
        
        if (! isset($result['zendesk_ticket_id']) || $result['zendesk_ticket_id'] < 1) {
            return $aData;
        }
        
        $zendeskTicketId    = $result['zendesk_ticket_id'];
        
        $aData      = array(
            'ticket'    => array(
                'additional_tags'   => array($tag)
            )
        );
        
        $request    = array(
            'url'       => '/tickets/update_many.json?ids='. $zendeskTicketId,
            'method'    => 'put',
            'data'      => $aData
        );
        $result     = self::_send($request);
        
        return $aData;
    }

    public function wriketozendeskCreateUser($request){
        $result     = self::_send($request);
        return $result;
    }

    public function findZendeskUser($request){
        $result     = self::_send($request);
        return $result;
    }
    
    public function wriketozendeskUpdateStatus($request){
        $result     = self::_send($request);
        return $result;
    }
    
    public function wriketozendeskUpdateTitle($request){
        $result     = self::_send($request);
        return $result;
    }
    
    public function wriketozendeskAdditionalTags($request){
        $result     = self::_send($request);
        return $result;
    }

    public function wriketozendeskCreateTicket($request){
        $result     = self::_send($request);
        return $result;
    }
    
    public function getGuideIdBy ($guideId)
    {
        $request    = array(
            'url'       => '/help_center/th/articles/'. $guideId .'.json',
            'method'    => 'get',
            'data'      => array()
        );
        $result     = self::_send($request);
        $result     = isset($result['article']) ? $result['article'] : array();
        
        return $result;
    }
    
    public function updateFulfillmentTicket ($request)
    {
        $db         = hbm_db();
        
        $ticketId   = isset($request['ticketId']) ? $request['ticketId'] : 0;
        $title       = isset($request['processGroupName']) ? $request['processGroupName'] : '';
        $aData      = array();
        
        $result     = $db->query("
            SELECT zt.*, t.subject
            FROM hb_zendesk_ticket zt
                LEFT JOIN hb_tickets t
                ON t.id = zt.ticket_id
            WHERE zt.ticket_id = :ticketId
            ", array(
                ':ticketId'     => $ticketId
            ))->fetch();
        
        if (! isset($result['zendesk_ticket_id']) || $result['zendesk_ticket_id'] < 1) {
            return $aData;
        }
        
        $zendeskTicketId    = $result['zendesk_ticket_id'];
        $title      = $title . ' ( '. $result['subject'] .' )';
        
        $aData      = array(
            'ticket'    => array(
                'subject'   => $title
            )
        );
        
        $request    = array(
            'url'       => '/tickets/'. $zendeskTicketId .'.json',
            'method'    => 'put',
            'data'      => $aData
        );
        $result     = self::_send($request);
        
        return $aData;
    }

    public function listAllGuideCategoryAndSection ()
    {
        $aCategory  = array();
        
        $request    = array(
            'url'       => '/help_center/th/categories.json',
            'method'    => 'get',
            'data'      => array()
        );
        $result     = self::_send($request);
        $page       = isset($result['page']) ? $result['page'] : 1;
        $pageCount  = isset($result['page_count']) ? $result['page_count'] : 1;
        $result     = isset($result['categories']) ? $result['categories'] : array();
        
        foreach ($result as $arr) {
            $catId  = $arr['id'];
            $aCategory[$catId]  = $arr;
            $aCategory[$catId]['section']   = array();
        }
        
        $page--;
        
        for ($i = $page; $i <= $pageCount; $i++) {
            $request    = array(
                'url'       => '/help_center/th/categories.json?page='. $i,
                'method'    => 'get',
                'data'      => array()
            );
            $result     = self::_send($request);
            $result     = isset($result['categories']) ? $result['categories'] : array();
            
            foreach ($result as $arr) {
                $catId  = $arr['id'];
                $aCategory[$catId]  = $arr;
                $aCategory[$catId]['section']   = array();
            }
            
        }
        
        $request    = array(
            'url'       => '/help_center/th/sections.json',
            'method'    => 'get',
            'data'      => array()
        );
        $result     = self::_send($request);
        $page       = isset($result['page']) ? $result['page'] : 1;
        $pageCount  = isset($result['page_count']) ? $result['page_count'] : 1;
        $result     = isset($result['sections']) ? $result['sections'] : array();
        
        foreach ($result as $arr) {
            $sectionId  = $arr['id'];
            $catId      = $arr['category_id'];
            $aCategory[$catId]['section'][$sectionId]   = $arr;
        }
        
        $page--;
        
        for ($i = $page; $i <= $pageCount; $i++) {
            $request    = array(
                'url'       => '/help_center/th/sections.json?page='. $i,
                'method'    => 'get',
                'data'      => array()
            );
            $result     = self::_send($request);
            $result     = isset($result['sections']) ? $result['sections'] : array();
            
            foreach ($result as $arr) {
                $sectionId  = $arr['id'];
                $catId      = $arr['category_id'];
                $aCategory[$catId]['section'][$sectionId]   = $arr;
            }
            
        }
        
        $aCategory_     = $aCategory;
        foreach ($aCategory_ as $catId => $arr) {
            foreach ($arr['section'] as $sectionId => $arr2) {
                $name   = $arr2['name'];
                $isServiceRequest   = 0;
                if (preg_match('/service.*request/i', $name)) {
                    $isServiceRequest   = 1;
                }
                $aCategory[$catId]['section'][$sectionId]['isServiceRequest']   = $isServiceRequest;
            }
        }
        
        return $aCategory;
    }

    public function listArticleBySectionId ($request)
    {
        $sectionId  = isset($request['sectionId']) ? $request['sectionId'] : 0;
        
        $aArticle   = array();
        
        $request    = array(
            'url'       => '/help_center/th/sections/'. $sectionId .'/articles.json',
            'method'    => 'get',
            'data'      => array()
        );
        $result     = self::_send($request);
        $page       = isset($result['page']) ? $result['page'] : 1;
        $pageCount  = isset($result['page_count']) ? $result['page_count'] : 1;
        $result     = isset($result['articles']) ? $result['articles'] : array();
        
        foreach ($result as $arr) {
            $articleId      = $arr['id'];
            $aArticle[$articleId]  = $arr;
        }
        
        $page--;
        
        for ($i = $page; $i <= $pageCount; $i++) {
            $request    = array(
                'url'       => '/help_center/th/sections/'. $sectionId .'/articles.json?page='. $i,
                'method'    => 'get',
                'data'      => array()
            );
            $result     = self::_send($request);
            $result     = isset($result['articles']) ? $result['articles'] : array();
            
            foreach ($result as $arr) {
                $articleId      = $arr['id'];
                $aArticle[$articleId]  = $arr;
            }
            
        }
        
        return $aArticle;
    }

    public function listServiceCatalog ()
    {
        $db         = hbm_db();
        
        $result     = $db->query("
            SELECT c.*
            FROM sc_category c
            WHERE 1
            ")->fetchAll();
        
        $aCategory  = array();
        
        foreach ($result as $arr) {
            $catId  = $arr['id'];
            $aCategory[$catId]  = $arr;
        }
        
        $aCategory_     = $aCategory;
        foreach ($aCategory_ as $catId => $arr) {
            $parentId   = $arr['parent_id'];
            if (isset($aCategory[$parentId])) {
                $name   = $aCategory[$parentId]['name'];
                $aCategory[$catId]['pathway']   = $name .' &gt; '. $aCategory[$catId]['name'];
                
                $parentId   = $aCategory[$parentId]['parent_id'];
                if (isset($aCategory[$parentId])) {
                    $name   = $aCategory[$parentId]['name'];
                    $aCategory[$catId]['pathway']   = $name .' &gt; '. $aCategory[$catId]['pathway'];
                    
                    $parentId   = $aCategory[$parentId]['parent_id'];
                    if (isset($aCategory[$parentId])) {
                        $name   = $aCategory[$parentId]['name'];
                        $aCategory[$catId]['pathway']   = $name .' &gt; '. $aCategory[$catId]['pathway'];
                        
                    }
                    
                }
                
            }
        }
        
        $result     = $db->query("
            SELECT sc.*
            FROM sc_service_catalog sc
            WHERE sc.is_delete = 0
            ")->fetchAll();
        
        $aCatalog   = array();
        
        foreach ($result as $arr) {
            $articleId  = $arr['zendesk_guide_id'];
            $catId      = $arr['category_id'];
            if ($articleId) {
                $arr['pathway'] = isset($aCategory[$catId]['pathway']) ? $aCategory[$catId]['pathway'] : '';
                $aCatalog[$articleId]   = $arr;
            }
        }
        
        return $aCatalog;
    }
    
    public function serviceRequest ($request)
    {
        $db         = hbm_db();
        
        $isReturn   = isset($request['isReturn']) ? $request['isReturn'] : 0;
        
        $oInfo          = (object) array(
            'title'     => 'Service Request',
            'desc'      => 'ดูข้อมูล service request จาก zendesk'
            );
        $this->template->assign('oInfo', $oInfo);
        
        $aCategory  = $this->listAllGuideCategoryAndSection();
        $this->template->assign('aCategory', $aCategory);
        
        $aArticle   = array();
        
        $aCategory_     = $aCategory;
        foreach ($aCategory_ as $catId => $arr) {
            foreach ($arr['section'] as $sectionId => $arr2) {
                if ($arr2['isServiceRequest']) {
                    $aParam     = array(
                        'sectionId' => $sectionId
                    );
                    $aArticle[$sectionId]   = $this->listArticleBySectionId($aParam);
                }
            }
        }
        $this->template->assign('aArticle', $aArticle);
        
        $aCatalog   = $this->listServiceCatalog();
        $this->template->assign('aCatalog', $aCatalog);
        
        if ($isReturn) {
            $request['aCategory']   = $aCategory;
            $request['aArticle']    = $aArticle;
            $request['aCatalog']    = $aCatalog;
            return $request;
        }
        
        $this->template->render(dirname(dirname(__FILE__)) .'/templates/admin/service_request.tpl',array(), true);
    }
    
    public function syncServiceRequest ($request)
    {
        $db         = hbm_db();
        
        $isExit     = isset($request['exit']) ? $request['exit'] : 0;
        $request['isReturn']    = 1;
        $request    = $this->serviceRequest($request);
        $aCategory  = $request['aCategory'];
        $aArticle   = $request['aArticle'];
        $aCatalog   = $request['aCatalog'];
       
        $aArticleExisted    = array();
        
        $db->query("
            UPDATE sc_category
            SET parent_id = 1
            WHERE id != 1
                AND zendesk_category_id = ''
                AND zendesk_section_id = ''
            ");
        
        $aCategory_     = $aCategory;
        foreach ($aCategory_ as $catId => $aCat) {
            
            $result     = $db->query("
                SELECT *
                FROM sc_category
                WHERE zendesk_category_id = :catId
                ", array(
                    ':catId'    => $catId
                ))->fetch();
            
            if (! isset($result['id'])) {
                $db->query("
                    INSERT INTO sc_category (
                    id, zendesk_category_id
                    ) VALUES (
                    '', :catId
                    )
                    ", array(
                        ':catId'    => $catId
                    ));
            }
            
            $result     = $db->query("
                SELECT *
                FROM sc_category
                WHERE zendesk_category_id = :catId
                ", array(
                    ':catId'    => $catId
                ))->fetch();
            
            $categoryId = $result['id'];
            
            $db->query("
                UPDATE sc_category
                SET parent_id = 0,
                    name = :name,
                    orders = :orders
                WHERE zendesk_category_id = :catId
                ", array(
                    ':catId'    => $catId,
                    ':name'     => $aCat['name'],
                    ':orders'   => $aCat['position']
                ));
            
            foreach ($aCat['section'] as $sectionId => $aSection) {
                if (! $aSection['isServiceRequest']) {
                    continue;
                }
                
                $result     = $db->query("
                    SELECT *
                    FROM sc_category
                    WHERE zendesk_section_id = :sectionId
                    ", array(
                        ':sectionId'    => $sectionId
                    ))->fetch();
                
                if (! isset($result['id'])) {
                    $db->query("
                        INSERT INTO sc_category (
                        id, zendesk_section_id
                        ) VALUES (
                        '', :sectionId
                        )
                        ", array(
                            ':sectionId'    => $sectionId
                        ));
                }
                
                $db->query("
                    UPDATE sc_category
                    SET parent_id = :catId,
                        name = :name,
                        orders = :orders
                    WHERE zendesk_section_id = :sectionId
                    ", array(
                        ':sectionId'    => $sectionId,
                        ':catId'    => $categoryId,
                        ':name'     => $aSection['name'],
                        ':orders'   => $aSection['position']
                    ));
                
                $result     = $db->query("
                    SELECT *
                    FROM sc_category
                    WHERE zendesk_section_id = :sectionId
                    ", array(
                        ':sectionId'    => $sectionId
                    ))->fetch();
                
                $categoryId = $result['id'];
                
                foreach ($aArticle[$sectionId] as $articleId => $aData) {
                    array_push($aArticleExisted, $articleId);
                    
                    if (isset($aCatalog[$articleId])) {
                        $db->query("
                            UPDATE sc_service_catalog
                            SET category_id = :catId
                            WHERE zendesk_guide_id = :guideId
                            ", array(
                                ':catId'    => $categoryId,
                                ':guideId'  => $articleId
                            ));
                        
                    } else {
                        $db->query("
                            INSERT INTO sc_service_catalog (
                            id, category_id, zendesk_guide_id
                            ) VALUES (
                            '', :catId, :guideId
                            )
                            ", array(
                                ':catId'    => $categoryId,
                                ':guideId'  => $articleId,
                            ));
                    }
                    
                    $db->query("
                        UPDATE sc_service_catalog
                        SET title = :title,
                            modified = :modified,
                            is_publish = 1,
                            orders = :orders
                        WHERE zendesk_guide_id = :guideId
                        ", array(
                            ':title'    => $aData['title'],
                            ':modified' => $aData['updated_at'],
                            ':orders'   => $aData['position'],
                            ':guideId'  => $articleId
                        ));
                    
                    
                }
                
            }
            
        }
        
        // delete record if zendesk guide deleted
        foreach ($aCatalog as $articleId => $arr) {
            if (in_array($articleId, $aArticleExisted)) {
                continue;
            }
            $result     = $this->getGuideIdBy($articleId);
            if (! isset($result['id'])) {
                $db->query("
                    UPDATE sc_service_catalog 
                    SET is_delete = 1
                    WHERE zendesk_guide_id = :guideId
                    ", array(
                        ':guideId'  => $articleId
                    ));
            }
        }
        
        if ($isExit) {
            echo 'Done';
            exit;
        }
        
        header('location:?cmd=zendeskintegratehandle&action=serviceRequest');
        exit;
    }
    
    public function send ($request)
    {
        return self::_send($request);
    }
    
    private function _send ($request)
    {
        $url        = $request['url'];
        $method     = isset($request['method']) ? $request['method'] : 'get';
        $data       = isset($request['data']) ? json_encode($request['data']) : array();
        
        $ch = curl_init();
        curl_setopt($ch, CURLOPT_URL, 'https://pdi-netway.zendesk.com/api/v2/'. $url);
        if ($method == 'post') {
            curl_setopt($ch, CURLOPT_POST, 1);
        }
        if ($method == 'put') {
            curl_setopt($ch, CURLOPT_CUSTOMREQUEST, 'PUT');
        }
        if ($method != 'get') {
            curl_setopt($ch, CURLOPT_POSTFIELDS, $data);
        }
        curl_setopt($ch, CURLOPT_TIMEOUT, 30);
        curl_setopt($ch, CURLOPT_RETURNTRANSFER, 1);
        curl_setopt($ch, CURLOPT_SSL_VERIFYPEER, false);
        curl_setopt($ch, CURLOPT_SSL_VERIFYHOST, false);
        curl_setopt($ch, CURLOPT_USERPWD, 'prasit@netway.co.th/token:mbPrx5uPCbCjez9QZ0oBSy4WBmYrm4wly382yJw1');
        curl_setopt($ch, CURLOPT_HTTPAUTH, CURLAUTH_BASIC);
        curl_setopt($ch, CURLOPT_HTTPHEADER, array('Content-Type:application/json'));
        $data   = curl_exec($ch);
        curl_close($ch);
        $result = json_decode($data, true);
        
        return $result;
    }
    
    public function afterCall ($request)
    {
        $_SESSION['notification']   = array();
    }
}