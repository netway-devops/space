<?php

class domainexpirehandle_controller extends HBController {
    
    public function beforeCall ($request)
    {
        
    }
    
    public function _default ($request)
    {
        $db     = hbm_db();
        $api    = new ApiWrapper();
        
        $this->_beforeRender();
        //$this->template->render(dirname(dirname(__FILE__)) .'/templates/admin/default.tpl',array(), true);
    }
    
    public function getadvanced ($request)
    {
        $db     = hbm_db();
        
        $result     = $db->query("
            SELECT mc.*
            FROM hb_domains d,
                hb_modules_configuration mc
            WHERE d.reg_module = mc.id
            GROUP BY d.reg_module
            ORDER BY mc.module ASC
            ")->fetchAll();
        $this->template->assign('aModules', $result);
        
        $currentfilter      = $this->_filter($request);
        $widget     = isset($request['widget']) ? $request['widget'] : '';
        $this->template->assign('widget', $widget);
        $this->template->assign('currentfilter', $currentfilter);
        $this->template->render(dirname(dirname(__FILE__)) .'/templates/admin/ajax.filter.tpl',array(), true);
    }
    
    private function _filter ($request)
    {
        if (isset($request['resetfilter']) && $request['resetfilter']) {
            $_SESSION['Sorterwidgeter'] = array();
        }
        
        if (isset($request['filter'])) {
            
            $aSorter    = array(
                'filter'        => true,
                'filterFields'  => array_keys($request['filter']),
                'filterInput'   => $request['filter'],
                'smart'         => ''
            );
            $_SESSION['Sorterwidgeter'] = $aSorter;
        
        }
        
        if ( ! isset($_SESSION['Sorterwidgeter']['filter']) || ! $_SESSION['Sorterwidgeter']['filter']) {
            return false;
        }
        
        return $_SESSION['Sorterwidgeter']['filterInput'];
    }
    
    public function renewal ($request)
    {
        $db     = hbm_db();
        
       
        $widgetName = 'domainRenewalLog';
        $this->template->assign('widgetName', $widgetName);
        
        if (isset($request['filter'])) {
            $request['page']    = 0;
        }
        
        $export     = isset($request['export']) ? $request['export'] : 0;
        
        $currentfilter      = $this->_filter($request);
        $keyword    = isset($currentfilter['keyword']) ? $currentfilter['keyword'] : '';
        $startDate  = isset($currentfilter['start_date']) ? $currentfilter['start_date'] : '';
        $endDate    = isset($currentfilter['end_date']) ? $currentfilter['end_date'] : '';
        $module     = isset($currentfilter['module']) ? $currentfilter['module'] : '';
                
        $sql        = "
            FROM hb_domain_renewal_logs drl,
                hb_domains d,
                hb_modules_configuration mc
            WHERE drl.domain_id = d.id
                AND d.reg_module = mc.id
            ";
        if ($keyword) {
            $sql    .= " AND d.name = '". trim($keyword) ."' ";
        }
        if ($startDate) {
            $arr    = explode('/', $startDate);
            $date   = $arr[2] .'-'. $arr[1] .'-'. $arr[0];
            $sql    .= " AND drl.log_date >= '{$date}' ";
        }
        if ($endDate) {
            $arr    = explode('/', $endDate);
            $date   = $arr[2] .'-'. $arr[1] .'-'. $arr[0];
            $sql    .= " AND drl.log_date <= '{$date}' ";
        }
        if ($module) {
            $sql    .= " AND d.reg_module = '{$module}' ";
        }
        
        $result     = $db->query("
            SELECT COUNT(*) AS total
            ". $sql)->fetch();
        
        $total      = $result['total'];
        
        $limit      = 100;
        $offset     = (isset($request['page']) && $request['page'] ) ? ($request['page'] * $limit) : 0;
        
        $aDatas     = $db->query("
            SELECT drl.*, d.name, mc.module, YEAR(drl.end_date_domain_log) - YEAR(drl.start_date_invoice_item) AS `year`
            ". $sql ."
            ORDER BY drl.log_date DESC
            LIMIT {$offset}, {$limit} 
            ")->fetchAll();
        
        if ($export) {
            
            $sql    =  "
                SELECT 
                    drl.domain_log_id AS logID, 
                    drl.log_date AS logDate, 
                    d.name AS DomainName, 
                    mc.module AS Registrar, 
                    drl.start_date_invoice_item AS StartDate, 
                    drl.end_date_domain_log AS EndDate, 
                    YEAR(drl.end_date_domain_log) - YEAR(drl.start_date_invoice_item) AS `Year`,
                    drl.invoice_id AS InvoiceID
                ". $sql ."
                ORDER BY drl.log_date DESC
                ";
            $this->_export($sql);
            
        }
        
        /*--- Pagination ---*/
        $sorterpage     = (isset($request['page']) && $request['page'] ) ? $request['page']+1 : 1;
        $totalpages     = ceil($total / $limit);
        $this->template->assign('total', $total);
        $this->template->assign('perpage', $limit);
        $this->template->assign('totalpages', $totalpages);
        $this->template->assign('sorterrecords', $total);
        $this->template->assign('sorterpage', $sorterpage);
        $this->template->assign('sorterlow', ($offset+1));
        $this->template->assign('sorterhigh', (($offset+$limit) > $total) ? $total : ($offset+$limit));
        /*--- Pagination ---*/
        
        $this->template->assign('aDatas', $aDatas);
        $this->template->assign('currentfilter', $currentfilter);
        $this->template->assign('widgetNow', $widgetName);
        $this->template->assign('export', $export);
        
        $this->_beforeRender();
        $this->template->render(dirname(dirname(__FILE__)) .'/templates/admin/renewal.tpl',array(), true);
    }

    private function _export($sql)
    {
        $db             = hbm_db();
        
        $db->query("
            UPDATE hb_reports
            SET query = :query
            WHERE id = '75007'
            ", array(
                ':query'    => $sql
            ));
        
    }
    
    public function validateOrderDomainCancel ($request)
    {
        $db             = hbm_db();
        
        $invoiceId      = isset($request['invoiceId']) ? $request['invoiceId'] : 0;
        
        $result         = $db->query("
                    SELECT
                        i.id
                    FROM
                        hb_invoices i
                    WHERE
                        i.id = :invoiceId
                        AND i.status = 'Cancelled'
                    ", array(
                        ':invoiceId'      => $invoiceId
                    ))->fetch();
        
        if (isset($result['id']) && $result['id']) {
            return '<a href="?cmd=invoices&action=edit&id='. $result['id'] .'" target="_blank">Invoice# '. 
                $result['id'] .' is cancelled</a>';
        }
        
        /*
         * เจ้าหน้าที่แจ้งว่า ไม่ต้อง ยกเลิกการ cancel order ก็ได้ เมื่อ invoice paid order จะถูก active เอง
         * 
        $result         = $db->query("
                    SELECT
                        o.id
                    FROM
                        hb_invoice_items ii,
                        hb_domains d,
                        hb_orders o
                    WHERE
                        ii.invoice_id = :invoiceId
                        AND ii.type IN ('Domain Register','Domain Renew','Domain Transfer')
                        AND ii.item_id = d.id
                        AND d.order_id = o.id
                        AND o.status = 'Cancelled'
                    ", array(
                        ':invoiceId'      => $invoiceId
                    ))->fetchAll();
        
        if (count($result)) {
            foreach ($result as $arr) {
                if (isset($arr['id']) && $arr['id']) {
                    return '<a href="?cmd=orders&action=edit&id='. $arr['id'] .'" target="_blank">Order# '. 
                        $arr['id']  .' is cancelled</a>';
                }
            }
        }
        */
        
        return false;
    }
    
    private function _beforeRender ()
    {
        $this->template->assign('tplPath', dirname(dirname(__FILE__)) . '/templates/');
        $this->template->assign('tplClientPath', dirname(dirname(dirname(dirname(dirname(dirname(__FILE__)))))) 
            . '/templates/');
    }

    public function afterCall ($request)
    {
        
    }
    
}
