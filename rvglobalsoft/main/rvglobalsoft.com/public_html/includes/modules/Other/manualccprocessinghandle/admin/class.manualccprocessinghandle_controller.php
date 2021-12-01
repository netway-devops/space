<?php

require_once(APPDIR .'class.cache.extend.php');

class manualccprocessinghandle_controller extends HBController {
    
    
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
        $limit      = 50;
        $sort       = (isset($request['sort'])) ? $request['sort'] : 'i.id';
        $order      = (isset($request['order'])) ? $request['order'] : 'DESC';
        $page       = (isset($request['page'])) ? (int) $request['page'] : 1;
        $status     = isset($request['status']) ? $request['status'] : 'unpaid';
        $offset     = ($page > 0) ? ($page-1) * $limit : 0;
        
        $sql        = "
            FROM 
                hb_invoices i
                LEFT JOIN hb_manual_payment mp
                    ON mp.invoice_id = i.id
                LEFT JOIN hb_client_details cd
                    ON cd.id = i.client_id
            WHERE i.payment_module = 49
                ". ($status == 'unpaid' ? " AND i.status = 'Unpaid' " : "") ."
                ". ($status == 'paid' ? " AND i.status = 'Paid' " : "") ."
                ". ($status == 'error' ? " AND i.status = 'Unpaid' AND mp.id IS NULL " : "") ."
            ";
        
        $result     = $db->query("
            SELECT COUNT(*) AS total
            ". $sql ."
            ")->fetch();
        
        $total      = $result['total'];
        $totalPage  = ceil($total / $limit);
        $nextPage   = ($page < $totalPage) ? $page + 1 : $page;
        $prevPage   = ($page > 1) ? $page - 1 : $page;
        
        $result     = $db->query("
            SELECT mp.id, i.id AS invoice_id, i.status, 
                i.date, i.duedate, i.total AS totalcur, cd.id as client_id, cd.firstname, 
                cd.lastname, mp.status AS state
            ". $sql ."
            ORDER BY {$sort} {$order}
            LIMIT {$offset}, {$limit}
            ")->fetchAll();
        
        $aList      = $result;
        
        $this->template->assign('list', $aList);
        $this->template->assign('total', $total);
        $this->template->assign('page', $page);
        $this->template->assign('nextPage', $nextPage);
        $this->template->assign('prevPage', $prevPage);
        $this->template->assign('totalPage', $totalPage);
        $this->template->assign('status', $status);
        $this->template->assign('order', $order);
        $this->template->assign('sort', $sort);
        
        $this->template->render(dirname(dirname(__FILE__)) .'/templates/admin/default.tpl',array(), true);
    }
    
    public function afterCall ($request)
    {
        $aAdmin         = hbm_logged_admin();
        $this->template->assign('oAdmin', (object)$aAdmin);
        
        $_SESSION['notification']   = array();
    }
}