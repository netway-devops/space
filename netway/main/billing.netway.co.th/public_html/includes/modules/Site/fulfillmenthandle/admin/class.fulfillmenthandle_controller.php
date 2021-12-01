<?php

class fulfillmenthandle_controller extends HBController {
    
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
        
        $this->template->render(dirname(dirname(__FILE__)) .'/templates/admin/default.tpl', array(), true);
    }
    
    public function upload ($request)
    {
        $db     = hbm_db();
        
        require_once(APPDIR . 'class.config.custom.php');
        
        $allowedAttachmentExt   = ConfigCustom::singleton()->getValue('AllowedAttachmentExt');
        $maxAttachmentSize      = ConfigCustom::singleton()->getValue('MaxAttachmentSize');
        
        require_once( dirname(dirname(__FILE__)) .'/libs/php.php');
        
        $uploadPath         = MAINDIR . 'attachments/';
        $allowedExtensions  = explode(';.', 'xxx;' . $allowedAttachmentExt);
        $sizeLimit          = $maxAttachmentSize * 1024 * 1024;
        
        $uploader           = new qqFileUploader($allowedExtensions, $sizeLimit);
        $result             = $uploader->handleUpload($uploadPath);
        $result['filename'] = (isset($result['success']) && $result['success']) ? $uploader->getUploadName() : '';
        
        $this->loader->component('template/apiresponse', 'json');
        $this->json->assign('success', $result['success']);
        $this->json->assign('filename', $result['filename']);
        $this->json->show();
    }
    
    public function invoiceTotal ($request)
    {
        $db         = hbm_db();
        
        $invoiceId  = isset($request['invoiceId']) ? $request['invoiceId'] : 0;
        
        $result     = $db->query("
            SELECT *
            FROM hb_invoices
            WHERE id = :id
            ", array(
                ':id'   => $invoiceId
            ))->fetch();
        
        $aTotal     = array(
            'total'     => ($result['total'] ? $result['total'] : 0),
            'total_wh_3'=> ($result['total_wh_3'] ? $result['total_wh_3'] : 0),
            'total_wh_1'=> ($result['total_wh_1'] ? $result['total_wh_1'] : 0)
            );
        return $aTotal;
    }
    
    public function addAuthorize ($request)
    {
        $db         = hbm_db();
        $aAdmin     = hbm_logged_admin();
        
        $orderId    = isset($request['orderId']) ? $request['orderId'] : 0;
        $payment    = isset($request['authBanktransfer']) ? $request['authBanktransfer'] : '';
        $payment    = isset($request['authPaypal']) ? $request['authPaypal'] : $payment;
        $payment    = isset($request['authCreditCard']) ? $request['authCreditCard'] : $payment;
        $amount     = isset($request['authAmount']) ? $request['authAmount'] : 0;
        $paidDate   = isset($request['authDate']) ? $request['authDate'] : '';
        if (preg_match('/\//', $paidDate)) {
            $arr        = explode('/', $paidDate);
            $paidDate   = $arr[2] .'-'. $arr[1] .'-'. $arr[0];
        }
        $paidDate   = isset($request['authTime']) ? $paidDate .' '. $request['authTime'] : $paidDate;
        $paidDate   = date('Y-m-d H:i', strtotime($paidDate));
        $type       = isset($request['authType']) ? $request['authType'] : '';
        $url        = isset($request['authTicketUrl']) ? $request['authTicketUrl'] : '';
        $file       = isset($request['authFile']) ? $request['authFile'] : '';
        $note       = isset($request['authNote']) ? $request['authNote'] : '';
        $authWithHolding    = isset($request['authWithHolding']) ? $request['authWithHolding'] : '';
        
        
        $db->query("
            INSERT INTO `hb_fulfillment_authorize` (
            `date`, `order_id`, `payment`, `paid_date`, `amount`, 
            `type`, `reference_url`, `reference_file`, `reference_note`, `staff_id`, `total_wh`
            ) VALUES (
            NOW(), :orderId, :payment, :paidDate, :amount, 
            :type, :url, :file, :note, :staffId, :totalWH
            );
            ", array(
                ':orderId'  => $orderId,
                ':payment'  => $payment,
                ':paidDate' => $paidDate,
                ':amount'   => $amount,
                ':type'     => $type,
                ':url'      => $url,
                ':file'     => $file,
                ':note'     => $note,
                ':staffId'  => $aAdmin['id'],
                ':totalWH'  => $authWithHolding
            ));
        
        $result     = $db->query("SELECT MAX(id) AS id FROM hb_fulfillment_authorize ")->fetch();
        $id         = isset($result['id']) ? $result['id'] : 0;
        
        $isComplete = false;
        
        $result     = $db->query("
            SELECT i.total
            FROM hb_orders o,
                hb_invoices i
            WHERE o.id = :orderId
                AND o.invoice_id = i.id
            ", array(
                ':orderId'      => $orderId
            ))->fetch();
        
        $total      = isset($result[$authWithHolding]) ? $result[$authWithHolding] : 0;
        
        if ($amount >= ($total-1) && (($type && $amount <= 1000000) || ($amount <= 1000000))) {
            $isComplete = true;
        }
        
        if ($isComplete) {
            $output = 'Completed by authorize payment <a href="#'. $id .'">#'. $id .'</a>';
            $db->query("
                UPDATE `hb_order_steps`
                SET status = 'Completed',
                    date_changed = NOW(),
                    output = :output
                WHERE order_id = :orderId
                    AND step_id = 3
                ", array(
                    ':orderId'  => $orderId,
                    ':output'   => $output
                ));
        }
        
        $aData      = array(
            'id'    => $id,
            'is_complete'   => $isComplete
            );
        
        $this->loader->component('template/apiresponse', 'json');
        $this->json->assign('data', $aData);
        $this->json->show();
    }
    
    public function authorizeLists ($request)
    {
        $db         = hbm_db();
        
        $orderId    = isset($request['orderId']) ? $request['orderId'] : 0;
        
        $result     = $db->query("
            SELECT fa.*, aa.username
            FROM hb_fulfillment_authorize fa
                LEFT JOIN hb_admin_access aa
                    ON aa.id = fa.staff_id
            WHERE fa.order_id = :orderId
            ORDER BY fa.id DESC
            ", array(
                ':orderId'  => $orderId
            ))->fetchAll();
        
        $aList      = array();
        if (count($result)) {
            foreach ($result as $arr) {
                array_push($aList, $arr);
            }
        }
        
        return $aList;
    }
    
    public function pendingAuthorize ($request)
    {
        $db         = hbm_db();
        $aAdmin     = hbm_logged_admin();
        
        $orderId    = isset($request['orderId']) ? $request['orderId'] : 0;
        
        $db->query("
            UPDATE `hb_order_steps`
            SET status = 'Pending',
                date_changed = '0000-00-00',
                output = ''
            WHERE order_id = :orderId
                AND step_id = 3
            ", array(
                ':orderId'  => $orderId
            ));
        
        $db->query("
            DELETE FROM hb_fulfillment_authorize WHERE order_id = :orderId
            ", array(
                ':orderId'  => $orderId
            ));
        
        $db->query("
            INSERT INTO `hb_order_log` (
            `order_id` , `date` , `type` , `entry` , `who`
            ) VALUES (
            :orderId, NOW(), '', :entry, :staff
            )
            ", array(
                ':orderId'  => $orderId,
                ':entry'    => 'Reset authorize payment step to Pending',
                ':staff'    => $aAdmin['username']
            ));
        
        header('location:?cmd=orders&action=edit&id='. $orderId);
        exit;
    }
    
    public function orderFulfillmentProcess ($request)
    {
        $db         = hbm_db();
        $aAdmin     = hbm_logged_admin();
        
        $orderId    = isset($request['id']) ? $request['id'] : 0;
        
        $result     = $db->query("
            SELECT *
            FROM hb_accounts 
            WHERE order_id = :orderId
            ", array(
                ':orderId'  => $orderId
            ))->fetchAll();
        
        if (count($result)) {
            foreach ($result as $arr) {
                $this->accountFulfillmentProcess($arr);
            }
        }
        
        $result     = $db->query("
            SELECT *
            FROM hb_domains 
            WHERE order_id = :orderId
            ", array(
                ':orderId'  => $orderId
            ))->fetchAll();
        
        if (count($result)) {
            foreach ($result as $arr) {
                $this->domainFulfillmentProcess($arr);
            }
        }
        
    }
    
    public function orderFulfillmentTicket ($request)
    {
        $db         = hbm_db();
        
        require_once(APPDIR .'modules/Other/zendeskintegratehandle/admin/class.zendeskintegratehandle_controller.php');
        
        $orderId    = isset($request['id']) ? $request['id'] : 0;
        
        $result     = $db->query("
            SELECT ft.*, t.subject, t.status, t.ticket_number
            FROM hb_fulfillment_ticket ft,
                hb_tickets t
            WHERE ft.order_id = :orderId
                AND ft.ticket_id = t.id
                AND ft.event != 'Manual'
            ", array(
                ':orderId'  => $orderId
            ))->fetchAll();
        
        $aList      = array();
        if (count($result)) {
            foreach ($result as $arr) {
                $arr['ticketId']    = $arr['ticket_id'];
                $aZendeskTicket     = zendeskintegratehandle_controller::singleton()->updateTicket($arr);
                $status     = isset($aZendeskTicket['status']) ? $aZendeskTicket['status'] : $arr['status'];
                $arr['status']      = $status;
                $aList[$arr['rel_type']][$arr['rel_id']]    = $arr;
            }
        }
        
        return $aList;
    }
    
    public function accountFulfillmentProcess ($request)
    {
        $db         = hbm_db();
        $aAdmin     = hbm_logged_admin();
        
        $accountId  = isset($request['id']) ? $request['id'] : 0;
        
        $result     = $db->query("
            SELECT a.*, a.domain AS domainName, p.name AS productName, cd.firstname, cd.lastname, cd.companyname
            FROM hb_accounts a
                LEFT JOIN hb_products p ON p.id = a.product_id
                LEFT JOIN hb_client_details cd ON cd.id = a.client_id
            WHERE a.id = :accountId
            ", array(
                ':accountId'  => $accountId
            ))->fetch();
        
        $aAccount   = $result;
        $clientId   = isset($result['client_id']) ? $result['client_id'] : 0;
        
        $result     = $db->query("
            SELECT *
            FROM hb_account_logs 
            WHERE account_id = :accountId
                AND ( event = 'AccountCreate' OR event = 'AccountSuspend' 
                    OR event = 'AccountUnsuspend' OR event = 'AccountTerminate' 
                    OR event = 'AddonActivation' 
                    )
                AND result = 0
                AND `date` > (NOW() - INTERVAL 30 MINUTE) #เพราะพึ่งทำ provision 
            ORDER BY id DESC
            ", array(
                ':accountId'  => $accountId,
            ))->fetch();
        
        $aLog       = $result;
        $event      = isset($aLog['event']) ? $aLog['event'] : '';
        
        if (! isset($aAccount['id']) || ! isset($aLog['id'])) {
            return false;
        }
        
        if ($event == 'AccountCreate' && ! preg_match('/pending/i', $aAccount['status'])) {
            return false;
        }
        
        if ($event == 'AddonActivation') {
            $result     = $db->query("
                SELECT *
                FROM hb_accounts_addons
                WHERE account_id = :accountId
                ", array(
                    ':accountId'  => $accountId,
                ))->fetch();
            $aAddon     = $result;
            if (! isset($aAddon['addon_id']) || ! $aAddon['addon_id']) {
                return false;
            }
            if (! preg_match('/pending/i', $aAddon['status']) ) {
                return false;
            }
            if (preg_match('/pending/i', $aAccount['status'])) {
                return false;
            }
        }
        
        $result     = $db->query("
            SELECT *
            FROM hb_fulfillment_ticket
            WHERE order_id = :orderId
                AND rel_type = 'Hosting'
                AND rel_id = :accountId
                AND event = :event
            ", array(
                ':orderId'      => $aAccount['order_id'],
                ':accountId'    => $aAccount['id'],
                ':event'        => $event
            ))->fetch();
        
        if (isset($result['id'])) {
            return false;
        }
        
        // --- Custom helper ---
        require_once(APPDIR . 'class.api.custom.php');
        require_once(APPDIR . 'class.general.custom.php');
        $adminUrl       = GeneralCustom::singleton()->getAdminUrl();
        $apiCustom      = ApiCustom::singleton($adminUrl.'/api.php');
        // --- Custom helper ---
        
        // #2025 Prasit test3 DNS Service
        $aParam         = array(
            'call'      => 'addTicket',
            'name'      => 'Staff',
            'subject'   => 'Provision require process for #'. $aAccount['id'] .' '. $aAccount['domainName'] .' - '. $aAccount['productName'],
            'body'      => self::_fulfillmentMessage('Hosting', $aAccount),
            'dept_id'   => 3,
            'email'     => 'noreply@netway.co.th'
            );
        
        if ($event == 'AddonActivation') {
            $aParam['subject']  .= ' (Addon)';
        }
        
        $result         = $apiCustom->request($aParam);
        
        if (isset($result['error']) && count($result['error'])) {
            return false;
        }
        
        $ticketNumber   = isset($result['ticket_id']) ? $result['ticket_id'] : '';
        
        $result         = $db->query("
            SELECT id
            FROM hb_tickets
            WHERE ticket_number = :ticketNumber
            ", array(
                ':ticketNumber' => $ticketNumber
            ))->fetch();
        
        $ticketId       = isset($result['id']) ? $result['id'] : 0;
        
        $aParam['groupId']  = 33275407; // 33275407 TS Group ID
        $aParam['tag']      = 'fulfillment_account_process';
        $aParam['clientId'] = $clientId;
        
        require_once(APPDIR .'modules/Other/zendeskintegratehandle/admin/class.zendeskintegratehandle_controller.php');
        $zendeskTicketId    = zendeskintegratehandle_controller::singleton()->createTicket($aParam);
        if ($zendeskTicketId) {
            $db->query("
                REPLACE INTO hb_zendesk_ticket (
                    ticket_id, zendesk_ticket_id, sync_date
                ) VALUES (
                    :ticketId, :zendeskTicketId, NOW()
                )
                ", array(
                    ':ticketId'     => $ticketId,
                    ':zendeskTicketId'  => $zendeskTicketId,
                ));
        }
        
        $db->query("
            UPDATE hb_tickets
            SET body = '". $aParam['body'] ."'
            WHERE id = :id
            ", array(
                ':id'   => $ticketId
            ));
        
        $db->query("
            INSERT INTO `hb_fulfillment_ticket` (
            `order_id`, `rel_type`, `rel_id`, `ticket_id`, `event`
            ) VALUES (
            :orderId, 'Hosting', :relId, :ticketId, :event
            )
            ", array(
                ':orderId'      => $aAccount['order_id'],
                ':relId'        => $aAccount['id'],
                ':ticketId'     => $ticketId,
                ':event'        => $event
            ));
        
        switch ($event) {
            case 'AddonActivation'  : $eventFulfillment = 'addon_fulfillment_create_id'; break;
            case 'AccountCreate'    : $eventFulfillment = 'fulfillment_create_id'; break;
            case 'AccountSuspend'   : $eventFulfillment = 'fulfillment_suspend_id'; break;
            case 'AccountUnsuspend' : $eventFulfillment = 'fulfillment_unsuspend_id'; break;
            case 'AccountTerminate' : $eventFulfillment = 'fulfillment_terminate_id'; break;
            default     : $eventFulfillment = '';
        }
        
        $result     = self::_addServiceRequest ($aAccount['product_id'] .'_'. $aAccount['id'], $ticketId, $eventFulfillment);
        
        if (isset($result['processGroupTemplate']) && $result['processGroupTemplate']) {
            self::_updateTicketBodyByProcessTemplate($ticketId, $result['processGroupTemplate'], 'Hosting', $aAccount);
        }
    }
    
    public function accountFulfillmentProcessSuccess ($request)
    {
        $db         = hbm_db();
        $aAdmin     = hbm_logged_admin();
        
        $accountId  = isset($request['id']) ? $request['id'] : 0;
        
        $result     = $db->query("
            SELECT a.*, a.domain AS domainName, p.name AS productName, cd.firstname, cd.lastname, cd.companyname
            FROM hb_accounts a
                LEFT JOIN hb_products p ON p.id = a.product_id
                LEFT JOIN hb_client_details cd ON cd.id = a.client_id
            WHERE a.id = :accountId
            ", array(
                ':accountId'  => $accountId
            ))->fetch();
        
        $aAccount   = $result;
        $clientId   = isset($result['client_id']) ? $result['client_id'] : 0;
        
        $result     = $db->query("
            SELECT *
            FROM hb_account_logs 
            WHERE account_id = :accountId
                AND admin_login = :adminLogin
                AND ( event = 'AccountCreate')
                AND result = 1
                AND `date` > (NOW() - INTERVAL 30 MINUTE) #เพราะพึ่งทำ provision 
            ORDER BY id DESC
            ", array(
                ':accountId'  => $accountId,
                ':adminLogin' => $aAdmin['username']
            ))->fetch();
        
        $aLog       = $result;
        $event      = isset($aLog['event']) ? $aLog['event'] : '';
        
        if (! isset($aAccount['id']) || ! isset($aLog['id'])) {
            return false;
        }
        
        $event      = $event .'Success';
        
        $result     = $db->query("
            SELECT *
            FROM hb_fulfillment_ticket
            WHERE order_id = :orderId
                AND rel_type = 'Hosting'
                AND rel_id = :accountId
                AND event = :event
            ", array(
                ':orderId'      => $aAccount['order_id'],
                ':accountId'    => $aAccount['id'],
                ':event'        => $event
            ))->fetch();
        
        if (isset($result['id'])) {
            return false;
        }
        
        // --- Custom helper ---
        require_once(APPDIR . 'class.api.custom.php');
        require_once(APPDIR . 'class.general.custom.php');
        $adminUrl       = GeneralCustom::singleton()->getAdminUrl();
        $apiCustom      = ApiCustom::singleton($adminUrl.'/api.php');
        // --- Custom helper ---
        
        // #2025 Prasit test3 DNS Service
        $aParam         = array(
            'call'      => 'addTicket',
            'name'      => 'Staff',
            'subject'   => 'Provision require process for #'. $aAccount['id'] .' '. $aAccount['domainName'] .' - '. $aAccount['productName'],
            'body'      => self::_fulfillmentMessage('Hosting', $aAccount),
            'dept_id'   => 3,
            'email'     => 'noreply@netway.co.th'
            );
        
        $result         = $apiCustom->request($aParam);
        
        if (isset($result['error']) && count($result['error'])) {
            return false;
        }
        
        $ticketNumber   = isset($result['ticket_id']) ? $result['ticket_id'] : '';
        
        $result         = $db->query("
            SELECT id
            FROM hb_tickets
            WHERE ticket_number = :ticketNumber
            ", array(
                ':ticketNumber' => $ticketNumber
            ))->fetch();
        
        $ticketId       = isset($result['id']) ? $result['id'] : 0;
        
        $aParam['groupId']  = 33275407; // 33275407 TS Group ID
        $aParam['tag']      = 'fulfillment_account_success';
        $aParam['clientId'] = $clientId;
        
        require_once(APPDIR .'modules/Other/zendeskintegratehandle/admin/class.zendeskintegratehandle_controller.php');
        $zendeskTicketId    = zendeskintegratehandle_controller::singleton()->createTicket($aParam);
        if ($zendeskTicketId) {
            $db->query("
                REPLACE INTO hb_zendesk_ticket (
                    ticket_id, zendesk_ticket_id, sync_date
                ) VALUES (
                    :ticketId, :zendeskTicketId, NOW()
                )
                ", array(
                    ':ticketId'     => $ticketId,
                    ':zendeskTicketId'  => $zendeskTicketId,
                ));
        }
        
        $db->query("
            UPDATE hb_tickets
            SET body = '". $aParam['body'] ."'
            WHERE id = :id
            ", array(
                ':id'   => $ticketId
            ));
        
        $db->query("
            INSERT INTO `hb_fulfillment_ticket` (
            `order_id`, `rel_type`, `rel_id`, `ticket_id`, `event`
            ) VALUES (
            :orderId, 'Hosting', :relId, :ticketId, :event
            )
            ", array(
                ':orderId'      => $aAccount['order_id'],
                ':relId'        => $aAccount['id'],
                ':ticketId'     => $ticketId,
                ':event'        => $event
            ));
        
        switch ($event) {
            case 'AccountCreateSuccess'     : $eventFulfillment = 'fulfillment_create_id'; break;
            default     : $eventFulfillment = '';
        }
        
        $result     = self::_addServiceRequest ($aAccount['product_id'], $ticketId, $eventFulfillment, 0, 0, 1);
        
        if (isset($result['processGroupTemplate']) && $result['processGroupTemplate']) {
            self::_updateTicketBodyByProcessTemplate($ticketId, $result['processGroupTemplate'], 'Hosting', $aAccount);
        }
    }
    
    private function _updateTicketBodyByProcessTemplate($ticketId, $template, $type, $aData)
    {
        $db         = hbm_db();
        
        /*
        {$orderUrl} = link ไปยังหน้า Order Detail
        {$productName} = ชื่อบริการ
        {$domainName} = ชื่อ Domin หรือ Hosting account
        {$accountUrl} = link ไปยังหน้า Account Detail
        {$clientUrl} = link ไปยังหน้า Client Detail         
        */
        
        $orderUrl       = '<a href="?cmd=orders&action=edit&id='. $aData['order_id'] .'" target="_blank">#'. $aData['order_id'] .'</a>';
        $productName    = $aData['productName'];
        $domainName     = $aData['domainName'];
        $accountUrl     = '<a href="?cmd='. ($type == 'Domain' ? 'domains':'accounts') .'&action=edit&id='. $aData['id'] .'" target="_blank">#'. $aData['id'] .' '. $aData['domainName'] .'</a>';
        $clientUrl      = '<a href="?cmd=clients&action=show&id='. $aData['client_id'] .'" target="_blank">'. $aData['firstname'] .' '. $aData['lastname'] .' ('. $aData['companyname'] .')</a>';
        
        $template_      = addslashes($template);
        eval('$body     = "'. $template_ .'";');
        $body           = stripslashes($body);
        
        $db->query("
            UPDATE hb_tickets
            SET body = '". $body ."'
            WHERE id = :id
            ", array(
                ':id'   => $ticketId
            ));
    }
    
    private function _fulfillmentMessage ($type, $aData)
    {
        $message    = '
-----------------------------------
Owner ของ ticket เป็น noreply จะไม่มี email ไปหาลูกค้า

ถ้าต้องการสื่อสารกับ ลูกค้า ทำได้ 2 แบบ คือ
1. แก้ไข owner ticket นี้ ให้เป็นของลูกค้า
2. สร้าง ticket ใหม่ เพื่อคุยกับลูกค้าโดยเฉพาะ

Order ID: <a href="https://netway.co.th/7944web/?cmd=orders&action=edit&id='. $aData['order_id'] .'" target="_blank">#'. $aData['order_id'] .'</a>
Account ID: <a href="https://netway.co.th/7944web/?cmd='. ($type == 'Domain' ? 'domains':'accounts') .'&action=edit&id='. $aData['id'] .'" target="_blank">#'. $aData['id'] .' '. $aData['domainName'] .'</a>
Product/services name: '. $aData['productName'] .'
โดเมน/hostname (ถ้ามี): '. $aData['domainName'] .'
Client ID: <a href="https://netway.co.th/7944web/?cmd=clients&action=show&id='. $aData['client_id'] .'" target="_blank">'. $aData['firstname'] .' '. $aData['lastname'] .' ('. $aData['companyname'] .')</a>  
-----------------------------------
            ';
        
        return $message;
    }
    
    public function accountFulfillmentTicket ($request)
    {
        $db         = hbm_db();

        require_once(APPDIR .'modules/Other/zendeskintegratehandle/admin/class.zendeskintegratehandle_controller.php');
        
        $accountId  = isset($request['id']) ? $request['id'] : 0;
        
        $result     = $db->query("
            SELECT ft.*, t.subject, t.status, t.ticket_number
            FROM hb_fulfillment_ticket ft,
                hb_tickets t
            WHERE ft.rel_id = :accountId
                AND ft.rel_type = 'Hosting'
                AND ft.ticket_id = t.id
                AND t.status != 'Closed'
            ", array(
                ':accountId'    => $accountId
            ))->fetchAll();
        
        $aList      = array();
        if (count($result)) {
            foreach ($result as $arr) {
                $arr['ticketId']    = $arr['ticket_id'];
                $aZendeskTicket     = zendeskintegratehandle_controller::singleton()->updateTicket($arr);
                $status     = isset($aZendeskTicket['status']) ? $aZendeskTicket['status'] : $arr['status'];
                $arr['status']      = $status;
                $aList[$arr['ticket_id']]   = $arr;
            }
        }
        
        return $aList;
    }
    
    private function _addServiceRequest ($productId, $ticketId, $event = 'fulfillment_create_id', $scId = 0, $pgId = 0, $success = 0)
    {
        $db         = hbm_db();
        
        // ไม่ใช้งานแล้ว
        return true;

        require_once(APPDIR . 'modules/Site/producthandle/admin/class.producthandle_controller.php');
        require_once(APPDIR . 'modules/Other/supportcataloghandle/admin/class.supportcataloghandle_controller.php');
        require_once(APPDIR .'modules/Other/zendeskintegratehandle/admin/class.zendeskintegratehandle_controller.php');
        
        $accountId  = 0;
        if (preg_match('/\_/', $productId)) {
            $arr    = explode('_', $productId);
            $productId  = $arr[0];
            $accountId  = $arr[1];
        }
        
        $request    = array(
            'id'        => $productId,
            'accountId' => $accountId,
            'isReturn'  => 1
            );
        if (preg_match('/addon/i', $event)) {
            $event      = preg_replace('/addon\_/i', '', $event);
            $aConfig    = producthandle_controller::singleton()->getConfigAddonByProduct($request);
        } else {
            $aConfig    = producthandle_controller::singleton()->getConfig($request);
        }
        $serviceCatalogId   = isset($aConfig[$event]) ? $aConfig[$event] : 1370;
        $serviceCatalogId   = $scId ? $scId : $serviceCatalogId;
        
        $db->query("
            INSERT INTO `sc_ticket_2_request` (
            `ticket_id` , `request_type` , `sc_id` , `start_date` , `is_fulfillment`
            ) VALUES (
            :ticketId, 'Service Request', :scId, NOW(), '1'
            )
            ", array(
                ':ticketId'     => $ticketId,
                ':scId'         => $serviceCatalogId,
            ));
        
        // start fulfillment process แรกทันที
        
        if ($pgId) {
            $result     = $db->query("
                SELECT pg.*
                FROM sc_process_group pg
                WHERE pg.id = :id
                ", array(
                    ':id'       => $pgId
                ))->fetch();
            
        } else {
            $result     = $db->query("
                SELECT pg.*
                FROM sc_process_group pg
                WHERE pg.sc_id = :scId
                ORDER BY pg.orders ASC, pg.id ASC
                ", array(
                    ':scId'     => $serviceCatalogId
                ))->fetch();
            
        }
        
        if (preg_match('/_id$/i', $event)) {
            if ($success) {
                $event_     = preg_replace('/_id$/i', '_success', $event);
            } else {
                $event_     = preg_replace('/_id$/i', '_fail', $event);
            }
            $processId  = isset($aConfig[$event_]) ? $aConfig[$event_] : 0;
            $result     = $db->query("
                SELECT pg.*
                FROM sc_process_group pg
                WHERE pg.id = :id
                ", array(
                    ':id'   => $processId
                ))->fetch();
        }
        
        if (! isset($result['id'])) {
            return true;
        }
        
        $aReturn    = array(
            'processGroupId'    => $result['id'],
            'processGroupTemplate'      => $result['data_template'],
        );
        
        $aParams    = array(
            'isReturn'      => 1,
            'notAutoStart'  => 1,
            'ticketId'      => $ticketId,
            'serviceCatalogId'  => $serviceCatalogId,
            'processGroupId'    => $result['id'],
            'processGroupName'  => $result['name'],
        );
        
        $result     = supportcataloghandle_controller::singleton()->startFulfillment($aParams);
        
        zendeskintegratehandle_controller::singleton()->updateFulfillmentTicket($aParam);
        
        return $aReturn;
    }
    
    public function domainFulfillmentProcess ($request)
    {
        $db         = hbm_db();
        $aAdmin     = hbm_logged_admin();
        
        $domainId   = isset($request['id']) ? $request['id'] : 0;
        
        $result     = $db->query("
            SELECT d.*, d.name AS domainName, p.name AS productName, cd.firstname, cd.lastname, cd.companyname
            FROM hb_domains d
                LEFT JOIN hb_products p ON p.id = d.tld_id
                LEFT JOIN hb_client_details cd ON cd.id = d.client_id
            WHERE d.id = :domainId
            ", array(
                ':domainId'     => $domainId
            ))->fetch();
        
        $aDomain    = $result;
        $clientId   = isset($result['client_id']) ? $result['client_id'] : 0;
        
        $result     = $db->query("
            SELECT *
            FROM hb_domain_logs 
            WHERE domain_id = :domainId
                AND admin_login = :adminLogin
                AND (event = 'DomainRegister' OR event = 'DomainRenew')
                AND result = 0
                AND `date` > (NOW() - INTERVAL 30 MINUTE) #เพราะพึ่งทำ provision 
            ORDER BY id DESC
            ", array(
                ':domainId'  => $domainId,
                ':adminLogin' => $aAdmin['username']
            ))->fetch();
        
        $aLog       = $result;
        $event      = isset($aLog['event']) ? $aLog['event'] : '';
        
        if (! isset($aDomain['id']) || ! isset($aLog['id'])) {
            return false;
        }
        if ($event == 'DomainRegister' && ! preg_match('/pending/i', $aDomain['status'])) {
            return false;
        }
        
        $result     = $db->query("
            SELECT *
            FROM hb_fulfillment_ticket
            WHERE order_id = :orderId
                AND rel_type = 'Domain'
                AND rel_id = :domainId
                AND event = :event
            ", array(
                ':orderId'      => $aDomain['order_id'],
                ':domainId'     => $aDomain['id'],
                ':event'        => $event
            ))->fetch();
        
        if (isset($result['id'])) {
            return false;
        }
        
        // --- Custom helper ---
        require_once(APPDIR . 'class.api.custom.php');
        require_once(APPDIR . 'class.general.custom.php');
        $adminUrl       = GeneralCustom::singleton()->getAdminUrl();
        $apiCustom      = ApiCustom::singleton($adminUrl.'/api.php');
        // --- Custom helper ---
        
        // #2025 Prasit test3 DNS Service
        $aParam         = array(
            'call'      => 'addTicket',
            'name'      => 'Staff',
            'subject'   => 'Provision require process for #'. $aDomain['id'] .' '. $aDomain['domainName'] .' - '. $aDomain['productName'],
            'body'      => self::_fulfillmentMessage('Domain', $aDomain),
            'dept_id'   => 3,
            'email'     => 'noreply@netway.co.th'
            );
        
        $result         = $apiCustom->request($aParam);
        
        if (isset($result['error']) && count($result['error'])) {
            return false;
        }
        
        $ticketNumber   = isset($result['ticket_id']) ? $result['ticket_id'] : '';
        
        $result         = $db->query("
            SELECT id
            FROM hb_tickets
            WHERE ticket_number = :ticketNumber
            ", array(
                ':ticketNumber' => $ticketNumber
            ))->fetch();
        
        $ticketId       = isset($result['id']) ? $result['id'] : 0;
        
        $aParam['groupId']  = 33275407; // 33275407 TS Group ID
        $aParam['tag']      = 'fulfillment_domain_process';
        $aParam['clientId'] = $clientId;
        
        require_once(APPDIR .'modules/Other/zendeskintegratehandle/admin/class.zendeskintegratehandle_controller.php');
        $zendeskTicketId    = zendeskintegratehandle_controller::singleton()->createTicket($aParam);
        if ($zendeskTicketId) {
            $db->query("
                REPLACE INTO hb_zendesk_ticket (
                    ticket_id, zendesk_ticket_id, sync_date
                ) VALUES (
                    :ticketId, :zendeskTicketId, NOW()
                )
                ", array(
                    ':ticketId'     => $ticketId,
                    ':zendeskTicketId'  => $zendeskTicketId,
                ));
        }
        
        $db->query("
            UPDATE hb_tickets
            SET body = '". $aParam['body'] ."'
            WHERE id = :id
            ", array(
                ':id'   => $ticketId
            ));
        
        $db->query("
            INSERT INTO `hb_fulfillment_ticket` (
            `order_id`, `rel_type`, `rel_id`, `ticket_id`, `event`
            ) VALUES (
            :orderId, 'Domain', :relId, :ticketId, :event
            )
            ", array(
                ':orderId'      => $aDomain['order_id'],
                ':relId'        => $aDomain['id'],
                ':ticketId'     => $ticketId,
                ':event'        => $event
            ));
        
        switch ($event) {
            case 'DomainRegister'   : $eventFulfillment = 'fulfillment_create_id'; break;
            case 'DomainRenew'      : $eventFulfillment = 'fulfillment_renew_id'; break;
            case 'DomainTransfer'   : $eventFulfillment = 'fulfillment_transfer_id'; break;
            default     : $eventFulfillment = '';
        }
        
        $result     = self::_addServiceRequest($aDomain['tld_id'], $ticketId, $eventFulfillment);
        
        if (isset($result['processGroupTemplate']) && $result['processGroupTemplate']) {
            self::_updateTicketBodyByProcessTemplate($ticketId, $result['processGroupTemplate'], 'Domain', $aDomain);
        }
    }
    
    public function domainFulfillmentProcessSuccess ($request)
    {
        $db         = hbm_db();
        $aAdmin     = hbm_logged_admin();
        
        $domainId   = isset($request['id']) ? $request['id'] : 0;
        
        $result     = $db->query("
            SELECT d.*, d.name AS domainName, p.name AS productName, cd.firstname, cd.lastname, cd.companyname
            FROM hb_domains d
                LEFT JOIN hb_products p ON p.id = d.tld_id
                LEFT JOIN hb_client_details cd ON cd.id = d.client_id
            WHERE d.id = :domainId
            ", array(
                ':domainId'     => $domainId
            ))->fetch();
        
        $aDomain    = $result;
        $clientId   = isset($result['client_id']) ? $result['client_id'] : 0;
        
        $result     = $db->query("
            SELECT *
            FROM hb_domain_logs 
            WHERE domain_id = :domainId
                AND admin_login = :adminLogin
                AND (event = 'DomainRegister')
                AND result = 1
                AND `date` > (NOW() - INTERVAL 30 MINUTE) #เพราะพึ่งทำ provision 
            ORDER BY id DESC
            ", array(
                ':domainId'  => $domainId,
                ':adminLogin' => $aAdmin['username']
            ))->fetch();
        
        $aLog       = $result;
        $event      = isset($aLog['event']) ? $aLog['event'] : '';
        
        if (! isset($aDomain['id']) || ! isset($aLog['id'])) {
            return false;
        }
        
        $event      = $event .'Success';
        
        $result     = $db->query("
            SELECT *
            FROM hb_fulfillment_ticket
            WHERE order_id = :orderId
                AND rel_type = 'Domain'
                AND rel_id = :domainId
                AND event = :event
            ", array(
                ':orderId'      => $aDomain['order_id'],
                ':domainId'     => $aDomain['id'],
                ':event'        => $event
            ))->fetch();
        
        if (isset($result['id'])) {
            return false;
        }
        
        // --- Custom helper ---
        require_once(APPDIR . 'class.api.custom.php');
        require_once(APPDIR . 'class.general.custom.php');
        $adminUrl       = GeneralCustom::singleton()->getAdminUrl();
        $apiCustom      = ApiCustom::singleton($adminUrl.'/api.php');
        // --- Custom helper ---
        
        // #2025 Prasit test3 DNS Service
        $aParam         = array(
            'call'      => 'addTicket',
            'name'      => 'Staff',
            'subject'   => 'Provision require process for #'. $aDomain['id'] .' '. $aDomain['domainName'] .' - '. $aDomain['productName'],
            'body'      => self::_fulfillmentMessage('Domain', $aDomain),
            'dept_id'   => 3,
            'email'     => 'noreply@netway.co.th'
            );
        
        $result         = $apiCustom->request($aParam);
        
        if (isset($result['error']) && count($result['error'])) {
            return false;
        }
        
        $ticketNumber   = isset($result['ticket_id']) ? $result['ticket_id'] : '';
        
        $result         = $db->query("
            SELECT id
            FROM hb_tickets
            WHERE ticket_number = :ticketNumber
            ", array(
                ':ticketNumber' => $ticketNumber
            ))->fetch();
        
        $ticketId       = isset($result['id']) ? $result['id'] : 0;
        
        $aParam['groupId']  = 33275407; // 33275407 TS Group ID
        $aParam['tag']      = 'fulfillment_domain_success';
        $aParam['clientId'] = $clientId;
        require_once(APPDIR .'modules/Other/zendeskintegratehandle/admin/class.zendeskintegratehandle_controller.php');
        $zendeskTicketId    = zendeskintegratehandle_controller::singleton()->createTicket($aParam);
        if ($zendeskTicketId) {
            $db->query("
                REPLACE INTO hb_zendesk_ticket (
                    ticket_id, zendesk_ticket_id, sync_date
                ) VALUES (
                    :ticketId, :zendeskTicketId, NOW()
                )
                ", array(
                    ':ticketId'     => $ticketId,
                    ':zendeskTicketId'  => $zendeskTicketId,
                ));
        }
        
        $db->query("
            UPDATE hb_tickets
            SET body = '". $aParam['body'] ."'
            WHERE id = :id
            ", array(
                ':id'   => $ticketId
            ));
        
        $db->query("
            INSERT INTO `hb_fulfillment_ticket` (
            `order_id`, `rel_type`, `rel_id`, `ticket_id`, `event`
            ) VALUES (
            :orderId, 'Domain', :relId, :ticketId, :event
            )
            ", array(
                ':orderId'      => $aDomain['order_id'],
                ':relId'        => $aDomain['id'],
                ':ticketId'     => $ticketId,
                ':event'        => $event
            ));
        
        switch ($event) {
            case 'DomainRegisterSuccess'   : $eventFulfillment = 'fulfillment_create_id'; break;
            default     : $eventFulfillment = '';
        }
        
        $result     = self::_addServiceRequest($aDomain['tld_id'], $ticketId, $eventFulfillment, 0, 0, 1);
        
        if (isset($result['processGroupTemplate']) && $result['processGroupTemplate']) {
            self::_updateTicketBodyByProcessTemplate($ticketId, $result['processGroupTemplate'], 'Domain', $aDomain);
        }
    }
    
    public function domainFulfillmentTicket ($request)
    {
        $db         = hbm_db();
        
        require_once(APPDIR .'modules/Other/zendeskintegratehandle/admin/class.zendeskintegratehandle_controller.php');
        
        $domainId   = isset($request['id']) ? $request['id'] : 0;
        
        $result     = $db->query("
            SELECT ft.*, t.subject, t.status, t.ticket_number
            FROM hb_fulfillment_ticket ft,
                hb_tickets t
            WHERE ft.rel_id = :domainId
                AND ft.rel_type = 'Domain'
                AND ft.ticket_id = t.id
                AND t.status != 'Closed'
            ", array(
                ':domainId'     => $domainId
            ))->fetchAll();
        
        $aList      = array();
        if (count($result)) {
            foreach ($result as $arr) {
                $arr['ticketId']    = $arr['ticket_id'];
                $aZendeskTicket     = zendeskintegratehandle_controller::singleton()->updateTicket($arr);
                $status     = isset($aZendeskTicket['status']) ? $aZendeskTicket['status'] : $arr['status'];
                $arr['status']      = $status;
                $aList[$arr['ticket_id']]   = $arr;
            }
        }
        
        return $aList;
    }
    
    public function isAcceptableOrder ($request)
    {
        $db         = hbm_db();
        
        if (! isset($request['status']) || ! preg_match('/pending/i', $request['status']) ) {
            return false;
        }
        
        if (isset($request['hosting']) && count($request['hosting'])) {
            foreach ($request['hosting'] as $arr) {
                if (preg_match('/pending/i', $arr['status'])) {
                    return false;
                }
            }
        }
        if (isset($request['domains']) && count($request['domains'])) {
            foreach ($request['domains'] as $arr) {
                if (preg_match('/pending/i', $arr['status'])) {
                    return false;
                }
            }
        }
        
        $result     = $db->query("
            SELECT *
            FROM hb_invoices
            WHERE id = :id
                AND status = 'Paid'
            ", array(
                ':id'   => $request['invoice_id']
            ))->fetch();
        
        if (isset($result['id']) && $result['id']) {
            return true;
        }
        
        $isPending      = 0;
        if (isset($request['hosting']) && count($request['hosting'])) {
            foreach ($request['hosting'] as $arr) {
                if (preg_match('/pending/i', $arr['status'])) {
                    $isPending  = 1;
                    break;
                }
            }
        }
        if (isset($request['domains']) && count($request['domains'])) {
            foreach ($request['domains'] as $arr) {
                if (preg_match('/pending/i', $arr['status'])) {
                    $isPending  = 1;
                    break;
                }
            }
        }
        
        if (! $isPending) {
            return true;
        }
        
        return false;
    }
    
    public function authorizePaymentList ($request)
    {
        $db         = hbm_db();
        
        $oInfo          = (object) array(
            'title'     => 'Authorize Payment List',
            'desc'      => 'รายการ order ที่มีการยืนยันการ Authorize Payment แล้ว แต่ยังไม่ได้ทำการ Capture Payment'
            );
        
        $this->template->assign('oInfo', $oInfo);
        
        $result     = $db->query("
            SELECT o.id, os.date_changed, fa.payment, aa.username, fa.amount
            FROM hb_orders o,
                hb_invoices i,
                hb_order_steps os,
                hb_fulfillment_authorize fa,
                hb_admin_access aa
            WHERE o.invoice_id = i.id
                AND o.id = os.order_id
                AND os.step_id = 3
                AND os.status = 'Completed'
                AND i.status = 'Unpaid'
                AND o.id = fa.order_id
                AND fa.staff_id = aa.id
            GROUP BY o.id
            ORDER BY os.date_changed ASC
            LIMIT 0, 50
            ")->fetchAll();
        
        $this->template->assign('aDatas', $result);
        
        $this->template->render(dirname(dirname(__FILE__)) .'/templates/admin/authorize_payment_list.tpl', array(), true);
    }
    
    public function provisionActivate ($request)
    {
        $db         = hbm_db();
        
        $aHosting   = isset($request['hosting']) ? $request['hosting'] : array();
        $aDomains   = isset($request['domains']) ? $request['domains'] : array();
        $orderDate  = isset($request['date_created']) ? $request['date_created'] : '';
        
        foreach ($aHosting as $k => $arr) {
            $request['hosting'][$k]['isActivate']       = ($arr['status'] != 'Pending') ? 1 : 0;
        }
        
        foreach ($aDomains as $k => $arr) {
            $isActivate     = 0;
            $domainId       = $arr['id'];
            
            if ($arr['type'] == 'Renew') {
                $result     = $db->query("
                    SELECT *
                    FROM hb_domain_logs
                    WHERE domain_id = :domainId
                        AND event = 'DomainRenew'
                        AND `date` > :orderDate
                        AND result = 1
                    ", array(
                        ':domainId' => $domainId,
                        ':orderDate'=> $orderDate
                    ))->fetch();
                
                $isActivate = isset($result['id']) ? 1 : 0;
                
            } else if ($arr['status'] != 'Pending') {
                $isActivate = 1;
            }
            
            $request['domains'][$k]['isActivate']       = $isActivate;
        }
        
        
        return $request;
    }
    
    public function accountActiveFulfillmentTicketClose ($request)
    {
        $db         = hbm_db();
        
        $accountId  = isset($request['id']) ? $request['id'] : 0;
        $status     = isset($request['status']) ? $request['status'] : '';
        
        if ($status != 'Active') {
            return false;
        }
        
        $result     = $db->query("
            SELECT ft.*, t.status
            FROM hb_fulfillment_ticket ft,
                hb_tickets t
            WHERE ft.rel_id = :relId
                AND ft.rel_type = 'Hosting'
                AND ft.event = 'AccountCreate'
                AND ft.ticket_id = t.id
            ", array(
                ':relId'    => $accountId
            ))->fetch();
        
        if (! isset($result['id']) || $result['status'] == 'Closed') {
            return false;
        }
        
        return self::_serviceActiveFulfillmentTicketClose($result);
    }
    
    public function domainActiveFulfillmentTicketClose ($request)
    {
        $db         = hbm_db();
        
        $domainId   = isset($request['id']) ? $request['id'] : 0;
        $status     = isset($request['status']) ? $request['status'] : '';
        
        if ($status != 'Active') {
            return false;
        }
        
        $result     = $db->query("
            SELECT ft.*, t.status
            FROM hb_fulfillment_ticket ft,
                hb_tickets t
            WHERE ft.rel_id = :relId
                AND ft.rel_type = 'Domain'
                AND ( ft.event = 'DomainRegister' OR ft.event = 'DomainTransfer' )
                AND ft.ticket_id = t.id
            ", array(
                ':relId'    => $domainId
            ))->fetch();
        
        if (! isset($result['id']) || $result['status'] == 'Closed') {
            return false;
        }
        
        return self::_serviceActiveFulfillmentTicketClose($result);
    }
    
    private function _serviceActiveFulfillmentTicketClose ($request)
    {
        $db         = hbm_db();
        
        $ticketId   = isset($request['ticket_id']) ? $request['ticket_id'] : 0;
        
        // --- เตรียมข้อมูล close ticket ---
        
        $result     = $db->query("
            SELECT t2r.*
            FROM sc_ticket_2_request t2r
            WHERE t2r.ticket_id = :ticketId
            ", array(
                ':ticketId'     => $ticketId
            ))->fetch();
        
        if (! isset($result['ticket_id'])) {
            return false;
        }
        
        $startDate      = $result['start_date'];
        $timeInminute   = (time() - strtotime($startDate)) / 60;
        
        $db->query("
            UPDATE hb_tickets
            SET status = 'Closed'
            WHERE id = :id
            ", array(
                ':id'   => $ticketId
            ));
        
        $db->query("
            INSERT INTO hb_tickets_log (
            id, ticket_id, date, action
            ) VALUES (
            '', :ticketId, NOW(), 'Ticket status changed to Closed by Service active'
            )
            ", array(
                ':ticketId' => $ticketId
            ));
        
        $db->query("
            UPDATE sc_ticket_2_request
            SET end_date = NOW(),
                time_in_minute = :timeInMinute
            WHERE ticket_id = :ticketId
            ", array(
                ':timeInMinute' => $timeInminute,
                ':ticketId'     => $ticketId
            ));
        
        $result         = $db->query("
            SELECT tf.*
            FROM sc_ticket_fulfillment tf
            WHERE tf.ticket_id = :ticketId
                AND tf.opt_in_minute = 0
            ", array(
                ':ticketId'     => $ticketId
            ))->fetch();
        
        if (! isset($result['id'])) {
            return true;
        }
        
        $fulfillmentId  = $result['id'];
        $startDate      = ($result['start_date'] == '0000-00-00 00:00:00') ? date('Y-m-d H:i:s') : $result['start_date'];
        $timeInminute   = (time() - strtotime($startDate)) / 60;
        
        $db->query("
            UPDATE sc_ticket_fulfillment
            SET end_date = NOW(),
                opt_in_minute = :timeInMinute
            WHERE id = :id
            ", array(
                ':timeInMinute' => $timeInminute,
                ':id'           => $fulfillmentId
            ));
        
        $result         = $db->query("
            SELECT tt.*
            FROM sc_ticket_team tt
            WHERE tt.ticket_fulfillment_id = :fulfillmentId
                AND tt.opt_in_minute = 0
            ", array(
                ':fulfillmentId'    => $fulfillmentId
            ))->fetchAll();
        
        if (! count($result)) {
            return true;
        }
        
        $result_        = $result;
        
        foreach ($result_ as $arr_) {
            
            $ticketTeamId   = $arr_['id'];
            $startDate      = ($arr_['start_date'] == '0000-00-00 00:00:00') ? date('Y-m-d H:i:s') : $arr_['start_date'];
            $timeInminute   = (time() - strtotime($startDate)) / 60;
            
            $db->query("
                UPDATE sc_ticket_team
                SET end_date = NOW(),
                    opt_in_minute = :timeInMinute
                WHERE id = :id
                ", array(
                    ':timeInMinute' => $timeInminute,
                    ':id'           => $ticketTeamId
                ));
            
            $result         = $db->query("
                SELECT ta.*
                FROM sc_ticket_activity ta
                WHERE ta.ticket_team_id = :ticketTeamId
                    AND ta.is_complete = 0
                ", array(
                    ':ticketTeamId' => $ticketTeamId
                ))->fetchAll();
            
            if (! count($result)) {
                continue;
            }
            
            foreach ($result as $arr) {
                $activityId     = $arr['id'];
                $startDate      = ($arr['start_date'] == '0000-00-00 00:00:00') ? date('Y-m-d H:i:s') : $arr['start_date'];
                $timeInminute   = (time() - strtotime($startDate)) / 60;
                
                $db->query("
                    UPDATE sc_ticket_activity
                    SET end_date = NOW(),
                        opt_in_minute = :timeInMinute,
                        is_complete = 1
                    WHERE id = :id
                    ", array(
                        ':timeInMinute' => $timeInminute,
                        ':id'           => $activityId
                    ));
                
            }
            
        }
        
    }
    
    public function listFulfillmentProcess ($request)
    {
        $db         = hbm_db();
        
        $aDetail    = isset($request['aDetail']) ? $request['aDetail'] : 0;
        
        $aHosting   = (isset($aDetail['hosting']) && count($aDetail['hosting'])) ? $aDetail['hosting'] : array();
        $aDomain    = (isset($aDetail['domains']) && count($aDetail['domains'])) ? $aDetail['domains'] : array();
        
        for ($i = 0; $i < count($aHosting); $i++) {
            $productId  = $aHosting[$i]['product_id'];
            
            $result     = $db->query("
                SELECT pg.*, sc.title,
                    IF(pc.fulfillment_create_id = sc.id, 1, 0) AS isCreate,
                    IF(pc.fulfillment_upgrade_id = sc.id, 1, 0) AS isUpgrade
                FROM hb_products_config pc,
                    sc_service_catalog sc,
                    sc_process_group pg
                WHERE 
                    pc.id = :productId
                    AND ( pc.fulfillment_create_id = sc.id
                        OR pc.fulfillment_upgrade_id = sc.id
                        )
                    AND pg.sc_id = sc.id
                ORDER BY sc.id ASC, pg.orders ASC
                ", array(
                    ':productId'    => $productId
                ))->fetchAll();
            
            $aHosting[$i]['aProcessGroup']  = $result;
        }
        
        for ($i = 0; $i < count($aDomain); $i++) {
            $domainId   = $aDomain[$i]['id'];
            
            $result     = $db->query("
                SELECT d.*
                FROM hb_domains d
                WHERE d.id = :id
                ", array(
                    ':id'   => $domainId
                ))->fetch();
            
            $productId  = isset($result['tld_id']) ? $result['tld_id'] : 0;
            
            $result     = $db->query("
                SELECT pg.*, sc.title,
                    IF(pc.fulfillment_create_id = sc.id, 1, 0) AS isCreate,
                    IF(pc.fulfillment_renew_id = sc.id, 1, 0) AS isRenew,
                    IF(pc.fulfillment_transfer_id = sc.id, 1, 0) AS isTransfer
                FROM hb_products_config pc,
                    sc_service_catalog sc,
                    sc_process_group pg
                WHERE 
                    pc.id = :productId
                    AND ( pc.fulfillment_create_id = sc.id
                        OR pc.fulfillment_renew_id = sc.id
                        OR pc.fulfillment_transfer_id = sc.id
                        )
                    AND pg.sc_id = sc.id
                ORDER BY sc.id ASC, pg.orders ASC
                ", array(
                    ':productId'    => $productId
                ))->fetchAll();
            
            $aDomain[$i]['aProcessGroup']  = $result;
        }
        
        
        return array(
            'aHosting'  => $aHosting,
            'aDomain'   => $aDomain,
        );
    }
    
    public function createManualFulfillment ($request)
    {
        $db         = hbm_db();
        
        $processId  = isset($request['processId']) ? $request['processId'] : 0;
        $zendeskTicketId    = isset($request['ticketId']) ? $request['ticketId'] : 0;
        
        $result     = $db->query("
            SELECT pg.*
            FROM sc_process_group pg
            WHERE pg.id = :id
            ", array(
                ':id'   => $processId
            ))->fetch();
        
        $processName    = isset($result['name']) ? $result['name'] : '';
        $catalogId      = isset($result['sc_id']) ? $result['sc_id'] : 0;
        $detail         = isset($result['data_template']) ? $result['data_template'] : '';
        if (! $detail) {
            $detail     = '--- No data template ---';
        }
        
        // --- Custom helper ---
        require_once(APPDIR . 'class.api.custom.php');
        require_once(APPDIR . 'class.general.custom.php');
        $adminUrl       = GeneralCustom::singleton()->getAdminUrl();
        $apiCustom      = ApiCustom::singleton($adminUrl.'/api.php');
        // --- Custom helper ---
        
        // #2025 Prasit test3 DNS Service
        $aParam         = array(
            'call'      => 'addTicket',
            'name'      => 'Staff',
            'subject'   => 'Fulfillment process '. $processName,
            'body'      => $detail,
            'dept_id'   => 3,
            'email'     => 'noreply@netway.co.th'
            );
        
        $result         = $apiCustom->request($aParam);
        
        if (isset($result['error']) && count($result['error'])) {
            return false;
        }
        
        $ticketNumber   = isset($result['ticket_id']) ? $result['ticket_id'] : '';
        
        $result         = $db->query("
            SELECT id
            FROM hb_tickets
            WHERE ticket_number = :ticketNumber
            ", array(
                ':ticketNumber' => $ticketNumber
            ))->fetch();
        
        $ticketId       = isset($result['id']) ? $result['id'] : 0;
        
        $result         = $db->query("
            UPDATE hb_zendesk_ticket
            SET zendesk_ticket_id = :zendeskTicketIdOld
            WHERE zendesk_ticket_id = :zendeskTicketId
            ", array(
                ':zendeskTicketIdOld'   => -$zendeskTicketId,
                ':zendeskTicketId'      => $zendeskTicketId
            ));
        
        $db->query("
            REPLACE INTO hb_zendesk_ticket (
                ticket_id, zendesk_ticket_id, sync_date
            ) VALUES (
                :ticketId, :zendeskTicketId, NOW()
            )
            ", array(
                ':ticketId'     => $ticketId,
                ':zendeskTicketId'  => $zendeskTicketId,
            ));
        
        $event      = 'Manual';
        
        $db->query("
            INSERT INTO `hb_fulfillment_ticket` (
            `order_id`, `rel_type`, `rel_id`, `ticket_id`, `event`
            ) VALUES (
            :orderId, :relType, :relId, :ticketId, :event
            )
            ", array(
                ':orderId'      => 0,
                ':relType'      => '',
                ':relId'        => 0,
                ':ticketId'     => $ticketId,
                ':event'        => $event
            ));
        
        $result     = self::_addServiceRequest(0, $ticketId, $event, $catalogId, $processId);
        
        $aData      = array();
        
        $this->loader->component('template/apiresponse', 'json');
        $this->json->assign('data', $aData);
        $this->json->show();
    }
    
    public function createFulfillmentTicketByProcess ($request)
    {
        $db         = hbm_db();
        
        $fulfillmentProcessGroup    = isset($request['fulfillmentProcessGroup']) ? $request['fulfillmentProcessGroup'] : '';
        $orderId    = isset($request['orderId']) ? $request['orderId'] : 0;
        
        $aData      = array();
        
        $aProcess   = explode(',', $fulfillmentProcessGroup);
        
        $type       = $aProcess[0];
        $serviceId  = $aProcess[1];
        $catalogId  = $aProcess[2];
        $processId  = $aProcess[3];
        
        $result     = $db->query("
            SELECT pg.*
            FROM sc_process_group pg
            WHERE pg.id = :id
            ", array(
                ':id'   => $processId
            ))->fetch();
        
        $processName    = isset($result['name']) ? $result['name'] : '';
        
        if ($type == 'Hosting') {
            $result     = $db->query("
                SELECT a.*, a.domain AS domainName, p.name AS productName, cd.firstname, cd.lastname, cd.companyname
                FROM hb_accounts a
                    LEFT JOIN hb_products p ON p.id = a.product_id
                    LEFT JOIN hb_client_details cd ON cd.id = a.client_id
                WHERE a.id = :accountId
                ", array(
                    ':accountId'  => $serviceId
                ))->fetch();
            
        } else if ($type == 'Domain') {
            $result     = $db->query("
                SELECT d.*, d.name AS domainName, p.name AS productName, cd.firstname, cd.lastname, cd.companyname
                FROM hb_domains d
                    LEFT JOIN hb_products p ON p.id = d.tld_id
                    LEFT JOIN hb_client_details cd ON cd.id = d.client_id
                WHERE d.id = :domainId
                ", array(
                    ':domainId'     => $serviceId
                ))->fetch();
            
        }
        
        if (! isset($result['id'])) {
            $this->loader->component('template/apiresponse', 'json');
            $this->json->assign('data', $aData);
            $this->json->show();
        }
        
        $aData      = $result;
        $clientId   = $aData['client_id'];
        
        // --- Custom helper ---
        require_once(APPDIR . 'class.api.custom.php');
        require_once(APPDIR . 'class.general.custom.php');
        $adminUrl       = GeneralCustom::singleton()->getAdminUrl();
        $apiCustom      = ApiCustom::singleton($adminUrl.'/api.php');
        // --- Custom helper ---
        
        // #2025 Prasit test3 DNS Service
        $aParam         = array(
            'call'      => 'addTicket',
            'name'      => 'Staff',
            'subject'   => 'Fulfillment process '. $processName .' for #'. $aData['id'] .' '. $aData['domainName'],
            'body'      => self::_fulfillmentMessage($type, $aData),
            'dept_id'   => 3,
            'email'     => 'noreply@netway.co.th'
            );
        
        $result         = $apiCustom->request($aParam);
        
        if (isset($result['error']) && count($result['error'])) {
            return false;
        }
        
        $ticketNumber   = isset($result['ticket_id']) ? $result['ticket_id'] : '';
        
        $result         = $db->query("
            SELECT id
            FROM hb_tickets
            WHERE ticket_number = :ticketNumber
            ", array(
                ':ticketNumber' => $ticketNumber
            ))->fetch();
        
        $ticketId       = isset($result['id']) ? $result['id'] : 0;
        
        $aParam['groupId']  = 33275407; // 33275407 TS Group ID
        $aParam['clientId'] = $clientId;
        require_once(APPDIR .'modules/Other/zendeskintegratehandle/admin/class.zendeskintegratehandle_controller.php');
        $zendeskTicketId    = zendeskintegratehandle_controller::singleton()->createTicket($aParam);
        if ($zendeskTicketId) {
            $db->query("
                REPLACE INTO hb_zendesk_ticket (
                    ticket_id, zendesk_ticket_id, sync_date
                ) VALUES (
                    :ticketId, :zendeskTicketId, NOW()
                )
                ", array(
                    ':ticketId'     => $ticketId,
                    ':zendeskTicketId'  => $zendeskTicketId,
                ));
        }
        
        $db->query("
            UPDATE hb_tickets
            SET body = '". $aParam['body'] ."'
            WHERE id = :id
            ", array(
                ':id'   => $ticketId
            ));
        
        $event      = 'Manual';
        
        $db->query("
            INSERT INTO `hb_fulfillment_ticket` (
            `order_id`, `rel_type`, `rel_id`, `ticket_id`, `event`
            ) VALUES (
            :orderId, :relType, :relId, :ticketId, :event
            )
            ", array(
                ':orderId'      => $orderId,
                ':relType'      => $type,
                ':relId'        => $aData['id'],
                ':ticketId'     => $ticketId,
                ':event'        => $event
            ));
        
        $result     = self::_addServiceRequest($aData['productId'], $ticketId, $event, $catalogId, $processId);
        
        if (isset($result['processGroupTemplate']) && $result['processGroupTemplate']) {
            self::_updateTicketBodyByProcessTemplate($ticketId, $result['processGroupTemplate'], $type, $aData);
        }
        
        $this->loader->component('template/apiresponse', 'json');
        $this->json->assign('data', $aData);
        $this->json->show();
    }
    
    public function listManualFulfillmentTicket ($request)
    {
        $db         = hbm_db();
        
        require_once(APPDIR .'modules/Other/zendeskintegratehandle/admin/class.zendeskintegratehandle_controller.php');
        
        $orderId    = isset($request['orderId']) ? $request['orderId'] : 0;
        
        $result     = $db->query("
            SELECT ft.*, t.subject, t.status, t.ticket_number
            FROM hb_fulfillment_ticket ft,
                hb_tickets t
            WHERE ft.order_id = :orderId
                AND ft.ticket_id = t.id
                AND ft.event = 'Manual'
            ", array(
                ':orderId'  => $orderId
            ))->fetchAll();
        
        $result_    = count($result) ? $result : array();
        $result     = array();
        foreach ($result_ as $arr) {
                $arr['ticketId']    = $arr['ticket_id'];
                $aZendeskTicket     = zendeskintegratehandle_controller::singleton()->updateTicket($arr);
                $status     = isset($aZendeskTicket['status']) ? $aZendeskTicket['status'] : $arr['status'];
                $arr['status']      = $status;
                array_push($result, $arr);
        }
        return $result;
    }
    
    public function getFraud ($request)
    {
        $db         = hbm_db();
        
        $orderId    = isset($request['id']) ? $request['id'] : 0;
        
        $result     = $db->query("
            SELECT fo.*, mc.module AS moduleName
            FROM hb_fraud_output fo,
                hb_modules_configuration mc
            WHERE fo.rel_id = :orderId
                AND fo.type = 'Order'
                AND fo.module = mc.id
            ", array(
                ':orderId'  => $orderId
            ))->fetch();
        
        $aData      = $result;
        
        if (isset($aData['moduleName']) && $aData['moduleName'] == 'hostingfree_fraudprotection') {
            
            $result     = $db->query("
                SELECT cfv.*
                FROM hb_client_fields cf,
                    hb_client_fields_values cfv,
                    hb_orders o
                WHERE cf.code = 'idcard'
                    AND cf.id = cfv.field_id
                    AND cfv.client_id = o.client_id
                    AND o.id = :orderId
                ", array(
                    ':orderId'  => $orderId
                ))->fetch();
            
            $value      = isset($result['value']) ? $result['value'] : '';
            
            $aData['cfvidcard'] = $value;
            
        }
        
        return $aData;
    }
    
    public function afterCall ($request)
    {
        $aAdmin         = hbm_logged_admin();
        $this->template->assign('oAdmin', (object)$aAdmin);
        
        $_SESSION['notification']   = array();
    }
}