<?php

require_once(APPDIR .'class.cache.extend.php');

class redirecthandle_controller extends HBController {
    
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
        $db         = hbm_db();
        
        require_once(APPDIR . 'modules/Other/zendeskintegratehandle/admin/class.zendeskintegratehandle_controller.php');
        
        $cmd        = isset($request['cmd_']) ? $request['cmd_'] : '';
        $action     = isset($request['action_']) ? $request['action_'] : '';
        $id         = isset($request['id']) ? $request['id'] : 0;
        $num        = isset($request['num']) ? $request['num'] : 0;
        
        if ($cmd == 'tickets' && $action == 'clienttickets' && $id) {
            $result     = $db->query("
                SELECT ca.email
                FROM hb_client_access ca
                WHERE ca.id = :clientId
                ", array(
                    ':clientId' => $id
                ))->fetch();
            
            $email      = isset($result['email']) ? $result['email'] : '';
            $request['email']   = $email;
            $request['clientId']= $id;
            
            $result     = zendeskintegratehandle_controller::singleton()->getUser($request);
            
            if (isset($result['id'])) {
                if (isset($_SERVER['HTTP_X_REQUESTED_WITH']) && $_SERVER['HTTP_X_REQUESTED_WITH'] == 'XMLHttpRequest') {
                    echo '<!-- {"ERROR":[],"INFO":[],"STACK":0} -->
                    <p align="center">
                    <a href="https://pdi-netway.zendesk.com/agent/users/'. $result['id'] .'/requested_tickets" class="btn btn-success" target="_blank">
                    ดูรายการ ticket บน Zendesk
                    </a>
                    </p>
                    ';
                    exit;
                }
                header('location:https://pdi-netway.zendesk.com/agent/users/'. $result['id'] .'/requested_tickets');
                exit;
            } else {
                header('location:?cmd=tickets&action=clienttickets&id='. $id);
                exit;
            }
            
        }
        if ($cmd == 'tickets' && $action == 'view' && $num) {
            $result     = $db->query("
                SELECT zt.*
                FROM hb_zendesk_ticket zt,
                    hb_tickets t
                WHERE t.ticket_number = :ticketNumber
                    AND zt.ticket_id = t.id
                ", array(
                    ':ticketNumber'     => $num
                ))->fetch();
            
            if (isset($result['zendesk_ticket_id']) && $result['zendesk_ticket_id']) {
                header('location:https://pdi-netway.zendesk.com/agent/tickets/'. $result['zendesk_ticket_id']);
                exit;
            } else {
                header('location:?cmd=tickets&action=view&num='. $num);
                exit;
            }
            
        }
        
        $this->template->render(dirname(dirname(__FILE__)) .'/templates/admin/default.tpl',array(), true);
    }
    
    public function afterCall ($request)
    {
        $aAdmin         = hbm_logged_admin();
        $this->template->assign('oAdmin', (object)$aAdmin);
        
        $_SESSION['notification']   = array();
    }
}