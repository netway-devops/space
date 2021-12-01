<?php

require_once(APPDIR . 'modules/Other/zendeskintegratehandle/admin/class.zendeskintegratehandle_controller.php');


class zendeskhandle_controller extends HBController {
    
    private static  $instance;
    
    public static function singleton ()
    {
        if (!isset(self::$instance)) {
            $c = __CLASS__;
            self::$instance = new $c();
        }

        return self::$instance;
    }
    
    public function beforeCall ($request)
    {
        $aNotification  = isset($_SESSION['notification']) ? $_SESSION['notification'] : array();
        $this->template->assign('aNotification', $aNotification);
        
        $this->template->assign('tplPath', dirname(dirname(__FILE__)) . '/templates/');
        $this->template->assign('tplClientPath', MAINDIR . 'templates/');
    }
    
    public function _default ($request)
    {
        $db     = hbm_db();
        
        $this->template->render(dirname(dirname(__FILE__)) .'/templates/user/default.tpl', array(), true);
    }
    
    public function test ($request)
    {
        $db     = hbm_db();
        /*
        require_once(APPDIR . 'modules/Other/zendeskintegratehandle/admin/class.zendeskintegratehandle_controller.php');
        
        $aParam     = array(
            'id'        => '24584',
            'email'     => 'henrique@mw9.com.br',
            'name'      => 'Wiliam'
        );
        $result     = zendeskintegratehandle_controller::singleton()->createNewTicket($aParam);
        */
        echo '<pre>'.print_r($result,true).'</pre>'; exit;
    }
    
    public function getClientInfo ($request)
    {
        $db     = hbm_db();
        
        $arr        = isset($request['ctr']) ? explode('-', $request['ctr']) : array();
        $id         = isset($arr[0]) ? $arr[0] : 0;
        $ctr        = isset($arr[1]) ? date('Y-m-d H:i:s', $arr[1]) : '';
        
        $result     = $db->query("
            SELECT ca.id, ca.email,
                cd.firstname
            FROM hb_client_access ca,
                hb_client_details cd
            WHERE ca.lastlogin = :lastlogin
                AND ca.id = :id
                AND ca.lastlogin != '0000-00-00 00:00:00'
                AND ca.id = cd.id
            ", array(
                ':id'           => $id,
                ':lastlogin'    => $ctr
            ))->fetch();
        
        $this->loader->component('template/apiresponse', 'json');
        $this->json->assign('name', $result['firstname']);
        $this->json->assign('email', $result['email']);
        $this->json->show();
    }
    
    public function searchTicket ($request)
    {
        $db     = hbm_db();
        
        $aClient    = hbm_logged_client();
        $aAdmin     = hbm_logged_admin();
        
        // --- Custom helper ---
        require_once(APPDIR . 'class.api.custom.php');
        require_once(APPDIR . 'class.general.custom.php');
        $adminUrl   = GeneralCustom::singleton()->getAdminUrl();
        $apiCustom  = ApiCustom::singleton($adminUrl.'/api.php');
        // --- Custom helper ---
        
        $request['email']   = $aClient['email'];
        $request['clientId']= $aClient['id'];
        
        $result     = zendeskintegratehandle_controller::singleton()->getUser($request);
        $userId     = isset($result['id']) ? $result['id'] : 0;
        $orgId      = isset($result['organization_id']) ? $result['organization_id'] : 0;

       if ($orgId) {
               $request    = array(
                    'url'       => '/organizations/'. $orgId .'/tickets.json?sort_by=updated_at&sort_order=desc',
                    'method'    => 'get',
                    'data'      => array()
                );
                $result = zendeskintegratehandle_controller::singleton()->_send($request);   
         }
         else {             
             $request    = array(
                    'url'       => '/users/'. $userId .'/tickets/requested.json?sort_by=updated_at&sort_order=desc',
                    'method'    => 'get',
                    'data'      => array()
                );
              $result = zendeskintegratehandle_controller::singleton()->_send($request);   
        }
              
        $result = isset($result['tickets']) ? $result['tickets'] : array();

        $aTicket    = array();
        if (count($result)) {
            $result_    = $result;
            foreach ($result_ as $arr) {
                $zendeskTicketId    = $arr['id'];
                switch ($arr['status']) {
                    case 'new':
                    case 'open': $status = 'Open'; break;
                    case 'pending':
                    case 'hold': $status = 'In-Progress'; break;
                    case 'solved': $status = 'Answered'; break;
                    case 'closed': $status = 'Closed'; break;
                }
                $result     = $db->query("
                    SELECT *
                    FROM hb_zendesk_ticket
                    WHERE zendesk_ticket_id = :ticketId 
                    ", array(
                        ':ticketId' => $zendeskTicketId
                    ))->fetch();
                $ticketId   = isset($result['ticket_id']) ? $result['ticket_id'] : 0;
                
                if (! $ticketId) {
                    $aParam     = array(
                        'call'          => 'addTicket',
                        'name'          => $aClient['firstname'] .' '. $aClient['lastname'],
                        'subject'       => $arr['subject'],
                        'body'          => $arr['description'],
                        'email'         => 'noreply@rvglobalsoft.com'
                    );
                    $result     = $apiCustom->request($aParam);
                    $ticketId   = isset($result['ticket_id']) ? $result['ticket_id'] : 0;
                    
                    if ($ticketId) {
                        $db->query("
                            UPDATE hb_tickets
                            SET email = :email,
                                client_id = :clientId
                            WHERE id = :id
                            ", array(
                                ':id'   => $ticketId,
                                ':email'    => $aClient['email'],
                                ':clientId' => $aClient['id']
                            ));
                        
                        $db->query("
                            INSERT INTO hb_zendesk_ticket (
                                zendesk_ticket_id, ticket_id, sync_date
                            ) VALUES (
                                :zendeskTicketId, :ticketId, NOW()
                            )
                            ", array(
                                ':zendeskTicketId'  => $zendeskTicketId,
                                ':ticketId'         => $ticketId
                            ));
                    }
                }
                
                $aTicket[$ticketId] = $arr;

                if ($ticketId && $status) {
                    $db->query("
                        UPDATE hb_tickets
                        SET status = :status
                        WHERE id = :id
                        ", array(
                            ':id'   => $ticketId,
                            ':status'   => $status
                        ));
                }
            }
        }
        
        return $aTicket;
    }
    
    public function afterCall ($request)
    {
        $aClient        = hbm_logged_client();
        $this->template->assign('aClient', $aClient);
        
        $_SESSION['notification']   = array();
    }
}