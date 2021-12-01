<?php

class orderreviewhandle_controller extends HBController {

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
        
        $ostatus    = isset($request['ostatus']) ? $request['ostatus'] : 'Pending';
        $istatus    = isset($request['istatus']) ? $request['istatus'] : 'Unpaid';
        $astatus    = isset($request['astatus']) ? $request['astatus'] : 'Pending';
        
        $oInfo          = (object) array(
            'title'     => 'Order Review',
            'desc'      => 'ตรวจสอบสถามนะ Order Invoice Domain Account Add-on ให้มีข้อมูลที่สัมพันธ์กัน 
                            <a href="https://docs.google.com/a/netway.co.th/spreadsheets/d/1Ew-36E3RSqgt-qoOcQspnNnfJyi5tg2lcgnzzEKEMQU/edit?usp=sharing" target="_blank">เอกสารอ้างอิง</a>
                            <br /><b>
                            '. $ostatus .'
                            '. $istatus .'
                            '. $astatus .'
                            </b>
                            '
            );
        
        $this->template->assign('oInfo', $oInfo);
        
        $result     = $db->query("
            SELECT o.status AS ostatus, i.status AS istatus, a.status AS astatus, count(o.id) AS total,
                CONCAT(o.status,' ',i.status,' ',a.status) AS status
            FROM hb_orders o,
                hb_invoices i,
                hb_invoice_items ii,
                hb_accounts a
            WHERE o.invoice_id = i.id
                AND i.id = ii.invoice_id
                AND ii.type = 'Hosting'
                AND ii.item_id = a.id
            GROUP BY o.status, i.status, a.status
            ")->fetchAll();
        
        $this->template->assign('aStatus', $result);
        
        $aError     = array(
            'Pending Paid Active',
            'Pending Paid Suspended',
            'Pending Paid Terminated',
            'Pending Paid Cancelled',
            
            'Pending Unpaid Cancelled',
            'Pending Cancelled Pending',
            'Pending Cancelled Active',
            'Pending Cancelled Suspended',
            'Pending Cancelled Terminated',
            'Pending Cancelled Cancelled',
            'Pending Refunded Pending',
            'Pending Refunded Active',
            'Pending Refunded Terminated',
            
            'Active Paid Terminated',
            'Active Paid Cancelled',
            'Active Unpaid Pending',
            
            'Active Unpaid Terminated',
            'Active Unpaid Cancelled',
            
            'Active Cancelled Pending',
            
            'Active Cancelled Terminated',
            'Active Cancelled Cancelled',
            
            'Active Refunded Terminated',
            'Active Refunded Cancelled',
            
        );
        $this->template->assign('aError', $aError);
        
        $offset     = 0;
        $limit      = 100;
        
        $result     = $db->query("
            SELECT o.id, o.status, i.id AS invoiceId, i.status AS invoiceStatus
            FROM hb_orders o,
                hb_invoices i,
                hb_invoice_items ii,
                hb_accounts a
            WHERE o.invoice_id = i.id
                AND i.id = ii.invoice_id
                AND ii.type = 'Hosting'
                AND ii.item_id = a.id
                AND o.status = :ostatus
                AND i.status = :istatus
                AND a.status = :astatus
            ORDER BY o.id ASC
            LIMIT {$offset}, {$limit}
            ", array(
                ':ostatus'      => $ostatus,
                ':istatus'      => $istatus,
                ':astatus'      => $astatus
            ))->fetchAll();
        
        $result_    = count($result) ? $result : array();
        $aDatas     = array();
        
        foreach ($result_ as $arr) {
            $orderId        = $arr['id'];
            $invoiceId      = $arr['invoiceId'];
            $status         = $arr['status'];
            $invoiceStatus  = $arr['invoiceStatus'];
            $aDatas[$orderId]['id']         = $orderId;
            $aDatas[$orderId]['status']     = $status;
            $aDatas[$orderId]['invoiceId']  = $invoiceId;
            $aDatas[$orderId]['invoiceStatus']      = $invoiceStatus;
            
            $result     = $db->query("
                SELECT ii.type, ii.item_id, ii.description
                FROM hb_invoice_items ii
                WHERE ii.invoice_id = :invoiceId
                ORDER BY ii.type ASC, ii.item_id ASC
                ", array(
                    ':invoiceId'    => $invoiceId
                ))->fetchAll();
            
            $arr        = count($result) ? $result : array();
            
            foreach ($arr as $arr_) {
                $result     = self::getItemDetail($arr_['type'], $arr_['item_id']);
                if (! isset($result['id']) ) {
                    continue;
                }
                $result['type'] = $arr_['type'];
                $result['desc'] = $arr_['description'];
                $aItem          = $result;
                if ($aItem['orderId'] != $orderId) {
                    $result     = $db->query("
                        SELECT o.id, o.invoice_id, o.status AS ostatus, i.status AS istatus
                        FROM hb_orders o,
                            hb_invoices i
                        WHERE o.invoice_id = i.id
                            AND o.id = :id
                        ", array(
                            ':id'   => $aItem['orderId']
                        ))->fetch();
                    
                    if (isset($result['id'])) {
                        $aItem['xOrderStatus']      = $result['ostatus'];
                        $aItem['xInvocieStatus']    = $result['istatus'];
                        $aItem['xInvocieId']        = $result['invoice_id'];
                        $aItem['xInvocieDesc']      = '';
                        
                        
                        $result     = $db->query("
                            SELECT ii.type, ii.item_id, ii.description
                            FROM hb_invoice_items ii
                            WHERE ii.invoice_id = :invoiceId
                            ORDER BY ii.type ASC, ii.item_id ASC
                            ", array(
                                ':invoiceId'    => $aItem['xInvocieId']
                            ))->fetchAll();
                        
                        if (count($result)) {
                            foreach ($result as $arr) {
                                $aItem['xInvocieDesc']  .= '###'. $arr['type'] .'###<br /> '. $arr['description'] .'<br />';
                            }
                        }
                        
                    }
                    
                }
                
                $aDatas[$orderId]['item'][]  = $aItem;
                
            }
            
            
        }
        
        $this->template->assign('aDatas', $aDatas);
        
        $this->template->render(dirname(dirname(__FILE__)) .'/templates/admin/default.tpl',array(), true);
    }
    
    public function getItemDetail ($type, $itemId)
    {
        $db     = hbm_db();
        $aData  = array();
        
        if (preg_match('/Domain/i', $type)) {
            $result     = $db->query("
                SELECT d.*
                FROM hb_domains d
                WHERE d.id = :id
                ", array(
                    ':id'   => $itemId
                ))->fetch();
            
            if (isset($result['id'])) {
                $aData['id']    = $result['id'];
                $aData['name']  = $result['name'];
                $aData['orderType'] = $result['type'];
                $aData['status']    = $result['status'];
                $aData['orderId']   = $result['order_id'];
                $aData['url']       = '?cmd=domains&action=edit&id='. $result['id'];
                
            }
            
        } else if (preg_match('/Hosting/i', $type)) {
            $result     = $db->query("
                SELECT a.*
                FROM hb_accounts a
                WHERE a.id = :id
                ", array(
                    ':id'   => $itemId
                ))->fetch();
            
            if (isset($result['id'])) {
                $aData['id']    = $result['id'];
                $aData['name']  = $result['domain'];
                $aData['status']    = $result['status'];
                $aData['orderId']   = $result['order_id'];
                $aData['url']       = '?cmd=accounts&action=edit&id='. $result['id'];
                
            }
            
        }
        
        
        return $aData;
    }
    
    public function afterCall ($request)
    {
        $aAdmin     = hbm_logged_admin();
        $this->template->assign('oAdmin', (object)$aAdmin);
        
        $_SESSION['notification']   = array();
    }
    
}