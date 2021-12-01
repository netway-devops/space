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
        require_once( dirname(dirname(__FILE__)) . '/lib/libphonenumber/PhoneNumberUtil.php' );
        require_once( dirname(dirname(__FILE__)) . '/lib/libphonenumber/PhoneNumberFormat.php' );
        $phoneUtil  = PhoneNumberUtil::getInstance();
        
        $number         = '264203-51';
        $numberProto    = $phoneUtil->parse($number, 'TH');
        $result         = $phoneUtil->format($numberProto, PhoneNumberFormat::INTERNATIONAL);
        
        //echo '<p><pre>'. print_r($result, true) .'</pre></p>';
        
        $this->template->render(dirname(dirname(__FILE__)) .'/templates/admin/default.tpl',array(), true);
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
            
            if (!$userId) {
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
                'value'     => 'Import from https://rvglobalsoft.com/7944web/index.php?cmd=tickets&action=view&list=all&num='. $ticketNum,
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
                curl_setopt($ch, CURLOPT_URL, 'https://jaruwan1234.zendesk.com/api/v2/imports/tickets.json');
                curl_setopt($ch, CURLOPT_POST, 1);
                curl_setopt($ch, CURLOPT_TIMEOUT, 30);
                curl_setopt($ch, CURLOPT_RETURNTRANSFER, 1);
                curl_setopt($ch, CURLOPT_POSTFIELDS, $data);
                curl_setopt($ch, CURLOPT_SSL_VERIFYPEER, false);
                curl_setopt($ch, CURLOPT_SSL_VERIFYHOST, false);
                curl_setopt($ch, CURLOPT_USERPWD, 'jaruwan@netway.co.th/token:7tFrJZ0xamiLcjeknfS5FXSmiHTEFKPi4tAhaKSy');
                curl_setopt($ch, CURLOPT_HTTPAUTH, CURLAUTH_BASIC);
                curl_setopt($ch, CURLOPT_HTTPHEADER, array('Content-Type:application/json'));
                $data   = curl_exec($ch);
                curl_close($ch);
                $result = json_decode($data, true);
                //echo '<p><pre>'. print_r($result, true) .'</pre></p>';
                $result = isset($result['ticket']) ? $result['ticket'] : array();
                echo '<pre>'. print_r($result, true) .'</pre>';
        exit;
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
    
    public function updateZendeskUser ($request)
    {
        $db         = hbm_db();
   
        $clientId   = isset($request['clientId']) ? $request['clientId'] : 0;
    
        /*
         * check table hb_zendesk_user
         * select where client_id = xxxxx
         * if (! clientId) {
         *      add client_id to hb_zendesk_user
         * }
         * query hb_client_detail where client_id = xxxxx
         * if (zendeskId) {
         *      เอา name + email ไป update zendesk user
         * } else {
         *      เอา name + email ไป create zendesk user
         *      ได้ zendeskId
         *      update hb_zendesk_user
         * }
         */
        
        $result     = $db->query(" 
            SELECT ca.id, ca.email, cd.firstname, cd.lastname
            FROM hb_client_access ca, 
                 hb_client_details cd
             WHERE ca.id = cd.id
             AND cd.id = :clientId
             ", array(
                ':clientId' => $clientId
            ))->fetch();
        $aClient    = $result;
        
        $clientId  =  $aClient['id'];
  
        $result     = $db->query("
           SELECT *
            FROM hb_zendesk_user
            WHERE client_id = :clientId
            ", array(
                ':clientId' => $clientId
            ))->fetch();
      
        if(! isset($result['client_id']))  {
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
        
        $userId = (isset($result['user_id']) && $result['user_id']) ? $result['user_id'] : 0;
        
        if ($userId) {
                 
            $email      = strtolower($aClient['email']);
            if ($aClient['firstname'] || $aClient['lastname']){
                $name   = $aClient['firstname'] .' '. $aClient['lastname'];
            } 
            $requestidentities   = array(
                'url'        => '/users/'.$userId.'/identities.json',       
                'method'     => 'get',
                'data'       => array()
            );
            $resultidentities     = self::_send($requestidentities); 
  
            $Ididentities = isset($resultidentities['identities'][0]['id'])? $resultidentities['identities'][0]['id']: array();
            
            $identiEmail    = array(
                'url'        => '/users/'.$userId.'/identities/'.$Ididentities.'.json',       
                'method'     => 'put',
                'data'       => array(
                    'identity' => array(
                        'id'       => $Ididentities,       
                        'user_id'  => $userId,      
                        'type'     => 'email',
                        'value'    => $email,
                        'verified' => true,
                        'primary'  => true
                    )
                 )
            );
            $resultEmail     = self::_send($identiEmail);
            
            $request    = array(
                'url'        => '/users/'.$userId.'.json',       
                'method'     => 'put',
                'data'       => array(
                    'user'       => array(
                        'name'     => $name
                    )
                 )
            );
            $result     = self::_send($request);
            //echo '<pre>'. print_r($result, true) .'</pre>';  

        } else {
            $email      = strtolower($aClient['email']);
            if ($aClient['firstname'] || $aClient['lastname']) {
                $name   = $aClient['firstname'] .' '. $aClient['lastname'];
            } 
 
            $request    = array(
                'url'       => '/users/search.json?query='. $email ,         
                'method'    => 'get',
                'data'      => array()
            );

            $result = self::_send($request);
                
            $result = isset($result['users']) ? $result['users'] : array();
                
            if (! isset($result['email']) || $result['email'] != $email) {

                $request    = array(
                 'url'        => '/users.json',         
                 'method'     => 'post',
                 'data'       => array(
                    'user'      => array(
                        'email'     => $email,
                        'name'      => $name,
                        'role'      => 'end-user',
                        'locale'    => 'en-us',
                        'time_zone' => 'Bangkok',
                        'verified'  => true
                    )  
                 )
                );
                $result     = self::_send($request);
                
                $result     = isset($result['user']) ? $result['user'] : array();
            }
   
            if (isset($result['id'])) {
                $userId  = $result['id'];
                $db->query("
                    UPDATE hb_zendesk_user
                    SET user_id = :userId,
                        sync_date = NOW()
                    WHERE client_id = :clientId
                    ", array(
                        ':userId'   => $userId,
                        ':clientId' => $clientId
                    ));
            }
                
            $aDatas[$clientId]      = $result;
   
        }
        
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
          //echo '<pre>'. print_r($result, true) .'</pre>';
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
          //echo '<pre>'. print_r($result, true) .'</pre>'; 
        $result     = isset($result['ticket']) ? $result['ticket'] : array();
        $ticketId   = isset($result['id']) ? $result['id'] : 0;
        
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
    
    public function _send ($request)
    {
        $url        = $request['url'];
        $method     = isset($request['method']) ? $request['method'] : 'get';
        $data       = isset($request['data']) ? json_encode($request['data']) : array();
        
        $ch = curl_init();
         curl_setopt($ch, CURLOPT_URL, 'https://rvglobalsoft.zendesk.com/api/v2'. $url);
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
        curl_setopt($ch, CURLOPT_USERPWD, 'prasit+rv@netway.co.th/token:rzkJaKdbWg2cptxaVZjsezCiIY8mxgrpG89kobAg');
        curl_setopt($ch, CURLOPT_HTTPAUTH, CURLAUTH_BASIC);
        curl_setopt($ch, CURLOPT_HTTPHEADER, array('Content-Type:application/json'));
        $data   = curl_exec($ch);
        curl_close($ch);
        $result = json_decode($data, true);
        
        return $result;
    }


    public function createNewTicket ($request)
    {
        $db         = hbm_db();
        
        require_once(APPDIR . 'modules/Site/supporthandle/admin/class.supporthandle_controller.php');
        
        $ticketId   = isset($request['id']) ? $request['id'] : 0;  
        $clientId   = isset($request['client_id']) ? $request['client_id'] : 0;  
        $name       = isset($request['name']) ? $request['name'] : '';  
        $email      = isset($request['email']) ? $request['email'] : '';  

        /* --- รองรับ customfield ที่ลูกค้ากรอกมา --- */
        supporthandle_controller::_extractCustomfield(array('ticketId' => $ticketId ));
        
        $result     = $db->query("
            SELECT t.*
            FROM hb_tickets t
            WHERE t.`id` = :ticketId
           ", array(
                ':ticketId'     => $ticketId
            ))->fetch();
         
        $aResult      = $result;
        $body         = $aResult['body'];
        
        $ticketId     =  $aResult['id'];
        $name         =  $aResult['name'];
        $email        =  $aResult['email'];
        $subject      =  $aResult['subject'];
        $comment      =  utf8_encode( html_entity_decode($body) );
        $aTag         = 'create_from_hostbill';
        $clientId     =  $aResult['client_id'];
        
        if (! isset($ticketId)) {
            return false;
        }
        
        if ($clientId) {
            $aParam     = array(
                'client_id'     => $clientId  
            );
            $requesterId    = $this->getZendeskUserIdByClientId($aParam);
        } else {
            $aParam     = array(
                'email'     => $email,
                'name'      => $name
            );
            $requesterId    = $this->getZendeskUserIdByEmail($aParam);
        }
        
        $request    = array(
            'url'       => '/tickets.json',
            'method'    => 'post',
            'data'      => array(
              'ticket'    => array(    
                'subject'       => $subject,
                'tags'          => $aTag,
                'comment'       => array(
                    'body'      => $comment
                )       
              )
            )
        );
        
        if ($requesterId) {
            $request['data']['ticket']['requester_id']  = $requesterId;
        } else {
            $request['data']['ticket']['requester']['name']     = $name;
            $request['data']['ticket']['requester']['email']    = $email;
        }
        
        $result     = self::_send($request);
        
        $zendeskTicketId    = isset($result['ticket']['id']) ? $result['ticket']['id'] : 0;  
        if (! $zendeskTicketId) {
            return false;
        }
   
        $result     = $db->query("
            SELECT zt.*
            FROM hb_zendesk_ticket zt
            WHERE zt.ticket_id = :ticketId
            ", array(
                ':ticketId'     => $ticketId
            ))->fetch();

        if (! isset($result['ticket_id'])) {
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

        $db->query("
            UPDATE hb_zendesk_ticket
            SET sync_date = NOW(),
                zendesk_ticket_id = :zendeskTicketId
            WHERE ticket_id = :ticketId
            ", array(
                ':ticketId'           => $ticketId,
                ':zendeskTicketId'    => $zendeskTicketId
            ));

        $db->query("
            UPDATE hb_tickets
            SET status = 'In-Progress'
            WHERE id = :ticketId
            ", array(
                ':ticketId' => $ticketId
            ));
            
        $aParam     = array(
            'ticketId'           => $ticketId,
            'zendeskTicketId'    => $zendeskTicketId
         );  
              
        $this->_updateCustomField($aParam);
        
        return $aParam;
    }
    
    public function addTicketAttachment ($request)
    {
        $db         = hbm_db();
        $aClient    = hbm_logged_client();
        
        $ticketId   = isset($request['ticketId'])? $request['ticketId'] : 0;
        
        $result     = $db->query("
            SELECT t.*
            FROM hb_tickets t
            WHERE t.`id` = :ticketId
           ", array(
                ':ticketId'     => $ticketId
            ))->fetch();
        
        $clientId     =  $result['client_id'];
        $name         =  $aClient['firstname'];
        $email        =  $aClient['email'];
        
        if ($clientId) {
            $aParam     = array(
                'client_id'     => $clientId  
            );
            $requesterId    = $this->getZendeskUserIdByClientId($aParam);
        } else {
            $aParam     = array(
                'email'     => $email,
                'name'      => $name
            );
            $requesterId    = $this->getZendeskUserIdByEmail($aParam);
        }
        
        $result     = $db->query("
            SELECT zt.*
            FROM hb_zendesk_ticket zt
            WHERE zt.ticket_id = :ticketId
            ", array(
                ':ticketId'     => $ticketId
            ))->fetch();
        
        $zendeskTicketId    = isset($result['zendesk_ticket_id']) ? $result['zendesk_ticket_id'] : 0;
        
        $result     = $db->query("
            SELECT *
            FROM hb_tickets_attachments
            WHERE ticket_id = :ticketId
            ", array(
                ':ticketId'     => $ticketId
            ))->fetchAll();
        if (count($result)) {
            foreach ($result as $arr) {
                
                $aData      = array(
                    'ticket'    => array(
                        'comment'   => array(
                            'author_id' => $requesterId,
                            'body'      => 'Attachment: https://rvglobalsoft.com/attachments/'. $arr['filename']
                        )
                    )
                );
                
                $request    = array(
                    'url'       => '/tickets/'. $zendeskTicketId .'.json',
                    'method'    => 'put',
                    'data'      => $aData
                );
                self::_send($request);
                
            }
        }
        
    }
    
    public  function _updateCustomField ($request)
    {
          $db         = hbm_db();
         
          $ticketId          = isset($request['ticketId'])? $request['ticketId'] : '';  
          $zendeskTicketId   = isset($request['zendeskTicketId'])? $request['zendeskTicketId'] : '';             
        
         $result     = $db->query("
            SELECT tc.* 
            FROM  hb_ticket_customfields tc
            WHERE  tc.ticket_id  = :ticketId
            ", array(
                ':ticketId' => $ticketId
            ))->fetch();
         
         $AticketContent    = isset($result['content']) ? $result['content'] : '';
         $AticketContent    = unserialize($result['content']);
         
         $AticketContent_   = $AticketContent;
         foreach ($AticketContent_ as $k => $v) {
             $AticketContent[$k]    = $v;
             if (! is_array($v)) {
                 continue;
             }
             foreach ($v as $k2 => $v2) {
                 unset($AticketContent[$k][$k2]);
                 $k2    = preg_replace('/\'/', '', $k2);
                 $AticketContent[$k][$k2]   = $v2;
             }
         }
              
        if ($AticketContent['problem'] == 'RVSiteBuilder') {
            if($AticketContent['problemOn'] == 'RVSiteBuilder end-user'){
                 $controlpanelUsername      = $AticketContent['cpuser']['RVSiteBuilder end-user'];
                 $projectName               = $AticketContent['rvproject']['RVSiteBuilder end-user'];
                 $step                      = $AticketContent['rvstep']['RVSiteBuilder end-user'];
            } else if ($AticketContent['problemOn'] == 'Published web site'){       
                 $controlpanelUsername      = $AticketContent['cpuser']['Published web site'];
                 $fullUrl                   = $AticketContent['rvurl']['Published web site'];
            } else {
                $controlpanelUsername       = $AticketContent['cpuser']; 
                 $step                      = $AticketContent['rvstep']['RVSiteBuilder'];
                 $projectName               = $AticketContent['rvproject']['RVSiteBuilder'];
                 $fullUrl                   = $AticketContentcf['rvurl_opt']['RVSiteBuilder'];
            }
                              
        }
        else if ($AticketContent['problem']  == 'RVSiteBuilderTryout'){
             if ($AticketContent['problemOn'] == 'RVSiteBuilder Tryout end-user') {
                $controlpanelUsername         = $AticketContent['cpuser_try']['RVSiteBuilder Tryout end-user'];  
                $step                         = $AticketContentcf['rvstep_try']['RVSiteBuilder Tryout end-user'];
            }else if($AticketContent['problemOn'] == 'Published tryout web site'){
                $controlpanelUsername         = $AticketContent['cpuser_try']['Published tryout web site'];
                $fullUrl                      = $AticketContent['rvurl_try']['Published tryout web site'];
            }else{
               $controlpanelUsername          = $AticketContent['cpuser'];
            }            
        }
        else if ($AticketContent['problem'] == 'PublishedWebsite'){
           $step                   = $AticketContent['rvstep_opt']['PublishedWebsite'];
           $projectName            = $AticketContent['rvproject_opt']['PublishedWebsite'];
           $fullUrl                = $AticketContent['rvurl']['PublishedWebsite'];
        }
        else {
           $controlpanelUsername   = $AticketContent['cpuser'];
        }
        
        $aData      = array(
            'ticket'    => array(
                'custom_fields'   => array(
                    array(
                        'id'          => '360000376513',
                        'value'       => 'relate_'. $AticketContent['cat_id']
                    ),array(
                        'id'          => '360000694193',
                        'value'       => $AticketContent['controlpanel_type'] 
                    ),array(
                        'id'          => '360000689333',
                        'value'       => $AticketContent['authMethod'] 
                    ),array(
                        'id'          => '360000689353',
                        'value'       => $AticketContent['hostname'] 
                    ),array(
                        'id'          => '360000730674',
                        'value'       => $AticketContent['rootpassword'] 
                    ),array(
                        'id'          => '360000730694',
                        'value'       => $AticketContent['user'] 
                    ),array(
                        'id'          => '360000730714',
                        'value'       => $AticketContent['password'] 
                    ),array(
                        'id'          => '360000730734',
                        'value'       => $AticketContent['sshport'] 
                    ),array(
                        'id'          => '360000733414',
                        'value'       => $AticketContent['problem'] 
                    ),
                    array(
                        'id'          => '360000694213',
                        'value'       => $AticketContent['rvsversion'] 
                    ),array(
                        'id'          => '360000694233',
                        'value'       => $AticketContent['browser_name'] 
                    ),array(
                        'id'          => '360000733454',
                        'value'       => $AticketContent['browser_version'] 
                    ),array(
                        'id'          => '360000694253',
                        'value'       => $AticketContent['problemOn'] 
                    ),
                    array(
                        'id'          => '360000784874',
                        'value'       => $AticketContent['cpurl'] 
                    ),array(
                        'id'          => '360000784114',
                        'value'       => $AticketContent['cppassword'] 
                    ),array(
                        'id'          => '360000733934',
                        'value'       => $controlpanelUsername
                    ),array(
                        'id'          => '360000733954',
                        'value'       => $AticketContent['rvproject_try']['RVSiteBuilder Tryout end-user']
                        
                    ),array(
                        'id'          => '360000734134',
                         'value'      => $projectName

                    ),array(
                        'id'          => '360000733974',
                        'value'       => $step  
                    ),array(
                        'id'          => '360000733754',
                        'value'       => $AticketContent['domain_try']['Tryout Installation']
                    ),array(
                        'id'          => '360000694273',
                        'value'       => $fullUrl
                    )  
                )
            )
        );       
        
        $request    = array(
            'url'       => '/tickets/'. $zendeskTicketId .'.json',
            'method'    => 'put',
            'data'      => $aData
        );
        $result     = self::_send($request);
      
    }
  
  
    public function getZendeskUserIdByEmail ($request)
    {
            
        $email      = isset($request['email'])? $request['email'] : '';  
        $name       = isset($request['name'])? $request['name'] : ''; 
        $Param     = array(
             'url'       => '/users/search.json?query='.$email ,        
             'method'    => 'get',
             'data'      => array()
        );
        $result     = $this->_send($Param);
        //echo '<pre>'. print_r($result, true) .'</pre>';   
       
        $zendeskUserId  = isset($result['users'][0]['id']) ? $result['users'][0]['id'] : array();
     
        if ($zendeskUserId) {
            return $zendeskUserId;
        }
        
        $aParam     = array(
                'email'     => $email,
                'name'      => $name
        );
        return $this->_addZendeskUserByEmail($aParam);
       
    }
    
    public function getZendeskUserIdByClientId ($request)
    {
        $clientId   = isset($request['client_id'])? $request['client_id'] : 0;  
        $db         = hbm_db();
        
        //หา zendesk userId จาก hb_zendesk_user จาก client_id
        $result     = $db->query("
            SELECT *
            FROM hb_zendesk_user
            WHERE client_id = :clientId
            ", array(
                ':clientId' => $clientId
            ))->fetch();

         $zendeskUserId  = isset($result['user_id']) ? $result['user_id'] : 0;
         if ($zendeskUserId) {
            return $zendeskUserId; 
        }

        return $this->_getZendeskUserIdByClientId($clientId);
    }
    
    private function _getZendeskUserIdByClientId ($clientId)
    {
        $clientId   = isset($request['client_id'])? $request['client_id'] : 0;  
        
        $db         = hbm_db();
        
        $result     = $db->query(" 
        SELECT ca.*
        FROM hb_client_access ca
        WHERE ca.id = :clientId
        
            ", array(
                ':clientId' => $clientId
            ))->fetch();
            
        $email = $result['email'];
        
        // ถ้าไม่เจอ หา userId บน zendesk email
         $request    = array(
                'url'       => '/users/search.json?query='. $email ,         
                'method'    => 'get',
                  'data'    => array()
               );

        $result     = $this->_send($request);
        //echo '<pre>'. print_r($result, true) .'</pre>';  
     
        $zendeskUserId  = isset($result['users'][0]['id']) ? $result['users'][0]['id'] : 0;
        
        if ($zendeskUserId) {
            $aParam     = array(
                'clientId'       => $clientId,
                'zendeskUserId'       => $zendeskUserId
            );
           
            $this->_updateZendeskUserIdByClientId($aParam);
            
            return $zendeskUserId;
        }
        
        return $this->_addZendeskUserByClientId($clientId);
    }
    
    
    private function _updateZendeskUserIdByClientId ($request)
    {
        $db         = hbm_db();
        
        $clientId       = isset($request['clientId']) ? $request['clientId'] : 0;
        $zendeskUserId  = isset($request['zendeskUserId']) ? $result['zendeskUserId'] : 0;
        
        $result     = $db->query("
            SELECT *
            FROM hb_zendesk_user
            WHERE client_id = :clientId
            ", array(
                ':clientId' => $clientId
            ))->fetch();
        
        if ( ! isset($result['client_id'])) {
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
        
        $db->query("
            UPDATE hb_zendesk_user
            SET user_id = :zendeskUserId,
                sync_date = NOW()
            WHERE client_id = :clientId
            ", array(
                ':zendeskUserId'   => $zendeskUserId,
                ':clientId' => $clientId
            ));
        
    }
    
    private function _addZendeskUserByClientId ($clientId)
    {
        $db         = hbm_db();
        
        $result     = $db->query("
         SELECT ca.*
         FROM hb_client_access ca
         WHERE ca.id = :clientId
         ", array(
            ':clientId' => $clientId
        ))->fetch();
        
        // ถ้าไม่เจอ หา userId บน zendesk email
        
        
        $aParam     = array(
            'url'        => '/users.json',         
            'method'     => 'post',
            'data'       => array(
              'user'     => array(
                'email'     => $email,
                'role'      => 'end-user',
                'locale'    => 'en-us',
                'time_zone' => 'Bangkok',
                'verified'  => true
                )  
            )
        );
        
        $result     = $this->_send($request);
        //echo '<pre>'. print_r($result, true) .'</pre>';  
        
        $zendeskUserId  = isset($result['user']['id']) ? $result['user']['id'] : 0;
        
        if ($zendeskUserId) {
            $aParam     = array(
                'client_id'      => $clientId,
                'zendeskUserId' => $zendeskUserId
            );
            $this->_updateZendeskUserIdByClientId($aParam);
        }
        
        return $zendeskUserId;
    }
    
    private function _addZendeskUserByEmail ($request)
    {
        $email      = isset($request['email']) ? $request['email'] : '';
        $name       = isset($request['name']) ? $request['name'] : '';
      
        $aParam     = array(
            'url'        => '/users.json',         
            'method'     => 'post',
            'data'       => array(
              'user'     => array(
                'email'     => $email,
                'name'      => $name,
                'role'      => 'end-user',
                'locale'    => 'en-us',
                'time_zone' => 'Bangkok',
                'verified'  => true
                )  
            )
        );
        $result     = $this->_send($aParam);
        //echo '<pre>'. print_r($result, true) .'</pre>';  
     
        $zendeskUserId  = isset($result['user']['id']) ? $result['user']['id'] : 0;

        return $zendeskUserId;
    }
    
    public function isZendeskTicket ($request)
    {
        $db         = hbm_db();
        $aAdmin     = hbm_logged_admin();
        $aClient    = hbm_logged_client();
        $clientId   = isset($aClient['id']) ? $aClient['id'] : 0;
        $email      = isset($aClient['email']) ? $aClient['email'] : '';
        
        require_once(APPDIR .'libs/php-jwt-1.0.0/Authentication/JWT.php');
        
        $ticketId   = isset($request['id']) ? $request['id'] : 0;
        
        $result     = $db->query("
            SELECT *
            FROM hb_zendesk_ticket
            WHERE ticket_id = :ticketId
            ", array(
                ':ticketId' => $ticketId
            ))->fetch();
        
        $aData      = $result;
        $zendeskTicketId    = (isset($aData['zendesk_ticket_id']) && $aData['zendesk_ticket_id']) 
                            ? $aData['zendesk_ticket_id'] : 0;
        if ($zendeskTicketId
            // && strtotime($aData['sync_date']) < (time() - 600)
            ) {
            
            $aParam     = array(
                'url'        => '/tickets/'. $aData['zendesk_ticket_id'] .'.json',         
                'method'     => 'get',
                'data'       => array()
            );
            $result     = $this->_send($aParam);
            $result     = isset($result['ticket']['id']) ? $result['ticket'] : array();
            //if ($aAdmin['id']) { echo '<pre>'. print_r($result, true) .'</pre>'; exit;}
            
            $status     = isset($result['status']) ? $result['status'] : '';
            $requesterId    = isset($result['requester_id']) ? $result['requester_id'] : 0;
            
            switch ($status) {
                case 'new':
                case 'open': $status = 'Open'; break;
                case 'pending':
                case 'hold': $status = 'In-Progress'; break;
                case 'solved': $status = 'Answered'; break;
                case 'closed': $status = 'Closed'; break;
            }
            if ($status) {
                $db->query("
                    UPDATE hb_tickets
                    SET status = :status
                    WHERE id = :ticketId
                    ", array(
                        ':ticketId' => $ticketId,
                        ':status'   => $status
                    ));
            }
            
            $aParam     = array(
                'url'        => '/users/'. $requesterId .'.json',         
                'method'     => 'get',
                'data'       => array()
            );
            $result     = $this->_send($aParam);
            $result     = isset($result['user']['id']) ? $result['user'] : array();
            $userEmail  = isset($result['email']) ? $result['email'] : '';
            
            
            if ($email == $userEmail) {
                $aData['firstname']     = $aClient['firstname'];
                $aData['lastname']      = $aClient['lastname'];
                $aData['companyname']   = $aClient['companyname'];
                $aData['email']         = $aClient['email'];
            } else {
            
                $result     = $db->query("
                    SELECT ca.email, cd.firstname, cd.lastname, cd.companyname
                    FROM hb_client_access ca,
                        hb_client_details cd
                    WHERE cd.parent_id = :id
                        AND ca.id = cd.id
                    ", array(
                        ':id'   => $clientId
                    ))->fetchAll();
                if (count($result)) {
                    foreach ($result as $arr) {
                        $email      = isset($arr['email']) ? $arr['email'] : '';
                        if ($email == $userEmail) {
                            $aData['firstname']     = $arr['firstname'];
                            $aData['lastname']      = $arr['lastname'];
                            $aData['companyname']   = $arr['companyname'];
                            $aData['email']         = $arr['email'];
                            break;
                        }
                    }
                }
                
            }
            
            if (isset($aData['email']) && $aData['email']) {
                // Log your user in.
                $key        = 'IvI4DEfUL6MYxb9ewOtuTKgcCBoaSZwDmHCivdzij35buyzT';
                $subdomain  = 'rvglobalsoft';
                $now        = time();
                $token      = array(
                    'jti'   => md5($now . rand()),
                    'iat'   => $now,
                    'name'  => $aData['firstname'] .' '. $aData['lastname'] .' '. $aData['companyname'],
                    'email' => $aData['email']
                );
                
                $jwt        = JWT::encode($token, $key);
                $location   = 'https://' . $subdomain . '.zendesk.com/access/jwt?jwt=' . $jwt
                            .= '&return_to='
                            . urlencode('https://rvglobalsoft.zendesk.com/hc/en-us/requests/'. $zendeskTicketId);
                $aData['location']  = $location;
            }
            
        }
        
        return $aData;
    }
    
    
    public function createTicketAddCompany ($request)
    {
        $db         = hbm_db();
 
        $clientId    = isset($request['clientId']) ? $request['clientId'] : 0;
        $email       = isset($request['email']) ? $request['email'] : '';
        $companyName = isset($request['companyName']) ? $request['companyName'] : '';
        $webUrl      = isset($request['webUrl']) ? $request['webUrl'] : '';
        $title       = isset($request['title']) ? $request['title'] : '';

        $resultUser     = $db->query("
            SELECT *
            FROM hb_zendesk_user
            WHERE client_id = :clientId
            ", array(
                ':clientId' => $clientId
            ))->fetch();
       
        $checkCompany  = $db->query("
                    SELECT * 
                    FROM hb_hosting_partner 
                    WHERE client_id = :clientId     
                    ", array(
                        ':clientId' => $clientId
                    ))->fetch();
            
            
        
        $userId     = isset($resultUser['user_id']) ? $resultUser['user_id'] : 0;
        
        $aParam     = array(
            'ticket'    => array(
                'requester_id'  => $userId ,
                'submitter_id'  => $userId ,
                'subject'       => 'Add Company',
                'assignee_id'   =>  '360175000633',
                'comment'       => array(
                    'public'    => false,
                    'html_body' => nl2br( '<br><b>Client ID : </b> ' .$clientId.
                        '<br><b>Email :</b> '.$email.
                        '<br><b>Company Name :</b> '.$companyName.
                        '<br><b>Web URL  : '.$webUrl.'</b>'.
                        '<br><b>Brief Info  : '.$title.'</b>'.
                        '<br><b>AddCompany:AddCompany'.'</b>'.
                        '<br><b>Detail :</b><a href = "https://rvglobalsoft.com/7944web/?cmd=hostpartnerhandle&action=dataCompany&id='.$clientId.'">Client Profile ID '.$clientId)
                        
                )
            )
        );
       if($userId != 0 && isset($checkCompany['client_id'])){
            $request    = array(
                'url'       => '/tickets.json',
                'method'    => 'post',
                'data'      => $aParam
            );
       
            $resultTicket     = self::_send($request);
        }
        $result     = isset($resultTicket) ? $resultTicket : array();
        $ticketId   = isset($resultTicket['id']) ? $resultTicket['id'] : 0;

        return $resultTicket;
    }
    
    
    
    public function createTicketEditCompany ($request)
    {
        $db         = hbm_db();
 
        $clientId    = isset($request['clientId']) ? $request['clientId'] : 0;
        $email       = isset($request['email']) ? $request['email'] : '';
        $companyName = isset($request['companyName']) ? $request['companyName'] : '';
        $webUrl      = isset($request['webUrl']) ? $request['webUrl'] : '';
        $title       = isset($request['title']) ? $request['title'] : '';

        $resultUserId    = $db->query("
            SELECT *
            FROM hb_zendesk_user
            WHERE client_id = :clientId
            ", array(
                ':clientId' => $clientId
            ))->fetch();
       
        $checkCompany  = $db->query("
                    SELECT * 
                    FROM hb_hosting_partner 
                    WHERE client_id = :clientId    
                    AND  status_edit_company = 0
                    ", array(
                        ':clientId' => $clientId
                    ))->fetch();
            
            
        
        $userId     = isset($resultUserId['user_id']) ? $resultUserId['user_id'] : 0;
        
        $aParam     = array(
            'ticket'    => array(
                'requester_id'  => $userId ,
                'submitter_id'  => $userId ,
                'subject'       => 'Edit Company',
                'assignee_id'   =>  '360175000633',
                'comment'       => array(
                    'public'    => false,
                    'html_body' => nl2br( '<br><b>Client ID : </b> ' .$clientId.
                        '<br><b>Email :</b> '.$email.
                        '<br><b>Company Name :</b> '.$companyName.
                        '<br><b>Web URL  : '.$webUrl.'</b>'.
                        '<br><b>Brief Info  : '.$title.'</b>'.
                        '<br><b>EditCompany:EditCompany'.'</b>'.
                        '<br><b>Detail :</b><a href = "https://rvglobalsoft.com/7944web/?cmd=hostpartnerhandle&action=dataEditCompany&id='.$clientId.'">Client Profile ID '.$clientId)
                )
            )
        );
       if($userId != 0 && isset($checkCompany['client_id'])){
            $request    = array(
                'url'       => '/tickets.json',
                'method'    => 'post',
                'data'      => $aParam
            );
       
            $resultTicket     = self::_send($request);
        }
        $result     = isset($resultTicket) ? $resultTicket : array();
        $ticketId   = isset($resultTicket['id']) ? $resultTicket['id'] : 0;

        return $checkCompany;
    }
    

    public function afterCall ($request)
    {
        $_SESSION['notification']   = array();
    }
}