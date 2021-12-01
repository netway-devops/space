<?php

require_once(APPDIR .'class.cache.extend.php');

class orderhandle_controller extends HBController {
    
    
    public function beforeCall ($request)
    {
        $aNotification  = isset($_SESSION['notification']) ? $_SESSION['notification'] : array();
        $this->template->assign('aNotification', $aNotification);
        
        $this->template->assign('tplPath', dirname(dirname(__FILE__)) . '/templates/');
        $this->template->assign('tplClientPath', MAINDIR . 'templates/');
    }
    
    public function _default ($request)
    {
        $db             = hbm_db();
        
        
        
        $this->template->render(dirname(dirname(__FILE__)) .'/templates/admin/default.tpl',array(), true);
    }
    
    public function updateInvoiceStaffOwner ($orderId)
    {
        $db             = hbm_db();
        
        $result         = $db->query("
                SELECT o.id, o.invoice_id, o.staff_member_id, i.status
                FROM hb_orders o,
                     hb_invoices i
                WHERE o.invoice_id = i.id
                    AND o.id = :orderId
                ", array(
                    ':orderId'  => $orderId
                ))->fetch();
        
        if (! isset($result['id'])) {
            return false;
        }
        
        $invoiceId      = $result['invoice_id'];
        $staffId        = $result['staff_member_id'];
        
        if ($result['status'] != 'Unpaid') {
            return false;
        }
        
        $db->query("
            UPDATE hb_invoices 
            SET staff_owner_id = :staffId
            WHERE id = :invoiceId
            ", array(
                ':staffId'      => $staffId,
                ':invoiceId'    => $invoiceId
            ));
        
        
        return true;
    }
    
    public function getOrderDetail ($aOrders)
    {
        $db             = hbm_db();
        
        $aOrder         = array();
        $aOrderDetail   = array();
        
        if (! count($aOrders)) {
            return $aOrderDetail;
        }
        
        foreach ($aOrders as $arr) {
            array_push($aOrder, $arr['id']);
        }
        
        $cacheKey   = md5(serialize($aOrder));
        $result     = CacheExtend::singleton()->get($cacheKey);
        if ($result == null) {
            
            $result         = $db->query("
                    SELECT ii.*, o.id AS orderId
                    FROM 
                        hb_invoice_items ii,
                        hb_invoices i,
                        hb_orders o
                    WHERE ii.invoice_id = i.id
                        AND i.id = o.invoice_id
                        AND o.id IN (". implode(',', $aOrder) .")
                    ")->fetchAll();
            
            CacheExtend::singleton()->set($cacheKey, $result, 3600);
        }
        
        if (! count($result)) {
            return $aOrderDetail;
        }
        
        foreach ($result as $arr) {
            $orderId    = $arr['orderId'];
            
            if (! is_array($aOrderDetail[$orderId])) {
                $aOrderDetail[$orderId] = array();
            }
            
            array_push($aOrderDetail[$orderId], $arr);
        }
        
        return $aOrderDetail;
    }

    public function createfiledotorderpage($request){
        
        $categoryname   =   isset($request['categoryname']) ? $request['categoryname'] : '';
        
        if($categoryname != ''){
            
            $orderpagename  =   str_replace(' ', '-', strtolower($categoryname));
            $filePath       =   '/home/managene/public_html/templates/netwaybysidepad/';
            $newFile        =   $filePath.$orderpagename.'.orderpage';
            
            if( ! file_exists($newFile)){
                $objCreate = fopen($newFile, 'w');
                if($objCreate){
                    echo "File Created.";
                }else{
                    echo "File Not Create.";
                }
                fclose($objCreate);
            }
            
        }
        
    }
    
    public function afterCall ($request)
    {
        $aAdmin         = hbm_logged_admin();
        $this->template->assign('oAdmin', (object)$aAdmin);
        
        $_SESSION['notification']   = array();
    }
}