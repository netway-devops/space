<?php

require_once(APPDIR .'class.cache.extend.php');

class widgeter_controller extends HBController {
    public $aWidgets    = array(
        'widgetActiveNoExpire'      => array(
            'title'     => 'List domain and services ที่ active แต่ไม่มีวันหมดอายุ ',
        ),
        'widgetActiveDueExpire'     => array(
            'title'     => 'List domain and services ที่ active แต่ due-date น้อยกว่า วันหมดอายุ ยกเว้น domain and services ที่ active แต่ไม่มีวันหมดอายุ ',
        ),
        'widgetPaypalSub'     => array(
            'title'     => 'List รายการจ่ายเงิน Paypal Subscrition ที่มีปัญหา',
        ),
        'widgetManualCCInvoiceUnpaid'       => array(
            'title'     => 'List รายการ manual CC ยังไม่ process (invoice Unpaid)',
        ),
        'widgetManualDuedateError'       => array(
            'title'     => 'List รายการ account ที่วันหมดอายุและวัน duedate มีข้อผิดพลาด',
        ),
        'widgetListDomainOverNextInvoice'       => array(
            'title'     => 'รายการ domain ที่ถึงวัน geninvoice แต่ไม่มี invoice ออกมา',
        ),
        'widgetInvoicePaidServiceNotActive'     => array(
            'title'     => 'List invoice ที่จ่ายเงินมาแล้ว 1 สัปดาห์ แต่ยังไม่ได้เปิดให้บริการ',
        ),
        'widgetInvoiceUnpaidServiceActive'      => array(
            'title'     => 'List invoice ที่ยังไม่จายเงิน แต่เปิดให้บริการไปแล้วเกิน 6 สัปดาห์',
        ),
        'widgetNewCreditLog'       => array(
            'title'     => 'จำนวนรายการ credit log ที่เกิดขึ้นใหม่',
        ),
        'widgetListRecurringError'  => array(
            'title'     => 'List รายการเปลี่ยน billing cycle แล้วไม่ update recurring price'
        ),
        'widgetListDueIn30Days'  => array(
            'title'     => 'Invoice ที่จะครบกำหนดชำระเงินภายใน 30 วัน'
        ),
        'widgetListSSLShouldTerminate'  => array(
            'title'     => 'SSL ที่เลย due มา 30 วันควร terminate'
        ),
        'widgetListInvoiceContractDateYesterday'  => array(
            'title'     => 'Invoice ที่เริ่มต้นสัญญาเมื่อวาน'
        ),
        'widgetListInvoiceUnpaidContractToday'  => array(
            'title'     => 'Invoice ที่ยัง Unpaid แต่เริ่มสัญญาวันนี้'
        )
        
    );
    public function beforeCall ($request)
    {
        $this->_beforeRender();
        $this->template->assign('allWidgets', $this->aWidgets);
    }
    
    public function _default ($request)
    {
        $db     = hbm_db();
        
        /**
         * Demo Cache Extend
         * 
        require_once(APPDIR .'class.cache.extend.php');
        $result = CacheExtend::singleton()->get('xxx');
        if($result == null) {
            $result = $db->query("SELECT * FROM hb_client_access LIMIT 10")->fetchAll();
            CacheExtend::singleton()->set('xxx', $result, 120);
        }
        */
        
        $this->template->render(dirname(dirname(__FILE__)) .'/templates/admin/default.tpl',array(), true);
    }
    
    public function getadvanced ($request)
    {
        $currentfilter      = $this->_filter($request);
        $widget     = isset($request['widget']) ? $request['widget'] : '';
        $this->template->assign('widget', $widget);
        $this->template->assign('currentfilter', $currentfilter);
        $this->template->render(dirname(dirname(__FILE__)) .'/templates/admin/ajax.filter.tpl',array(), true);
    }
    
    public function lists ($request)
    {
        $db     = hbm_db();
       
        $widgetName = isset($request['widget']) ? $request['widget'] : '';
        if (! $widgetName) {
            return false;
        }
        
        if ($widgetName == 'widgetManualCCInvoiceUnpaid') {
            header('location:index.php?cmd=module&module=92');
            exit;
        }
        
        $this->template->assign('widgetName', $widgetName);
             
        if (isset($request['filter'])) {
            $request['page']    = 0;
        }
        
        $currentfilter      = $this->_filter($request);
        /*
        $aParam     = array();
        $condition  = ' t.invoice_id != 0 AND t.module IN ('. implode(',', array_keys($aBankTransfer)).') ';
        if ($currentfilter && isset($currentfilter['payment']) && $currentfilter['payment'] ) {
            $condition              .= 'AND t.module = :tModule ';
            $aParam[':tModule']     = $currentfilter['payment'];
        }
        */
        $method     = '_' . $widgetName;
        $sqlCount   = 'COUNT(*) AS numRow,';
        $sql        = "SELECT SUM(x.numRow) - 1 AS numRows FROM ( " . $this->{$method}($sqlCount) . " ) x ";
        $result     = $db->query($sql)->fetch();
        
        $total      = isset($result['numRows']) ? $result['numRows'] : 0;
        
        $limit      = 30;
        $offset     = (isset($request['page']) && $request['page'] ) ? ($request['page'] * $limit) : 0;
        
        $sql        = $this->{$method}('', " LIMIT {$offset}, {$limit} ");
        $aDatas     = $db->query($sql)->fetchAll();
        
        /*--- Pagination ---*/
        $sorterpage     = (isset($request['page']) && $request['page'] ) ? $request['page']+1 : 1;
        $totalpages     = ceil($total / $limit);
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

        if (isset($request['page'])) {
            if ($widgetName =='widgetInvoicePaidServiceNotActive' || $widgetName =='widgetInvoiceUnpaidServiceActive' 
                || $widgetName =='widgetListInvoiceContractDateYesterday'
                || $widgetName =='widgetListInvoiceUnpaidContractToday') { 
                $this->template->render(dirname(dirname(__FILE__)) .'/templates/admin/ajax.lists_invoice.tpl',array(), true);
            } else if ($widgetName =='widgetPaypalSub') { 
            	$this->template->render(dirname(dirname(__FILE__)) .'/templates/admin/ajax.lists_payment.tpl',array(), true);
			} else {
				$this->template->render(dirname(dirname(__FILE__)) .'/templates/admin/ajax.lists.tpl',array(), true);
			}
        } else {
            if ($widgetName =='widgetInvoicePaidServiceNotActive' || $widgetName =='widgetInvoiceUnpaidServiceActive' 
                || $widgetName =='widgetListInvoiceContractDateYesterday'
                || $widgetName =='widgetListInvoiceUnpaidContractToday') { 
                $this->template->render(dirname(dirname(__FILE__)) .'/templates/admin/lists_invoice.tpl',array(), true);
        	}else if ($widgetName =='widgetPaypalSub') { 
            	$this->template->render(dirname(dirname(__FILE__)) .'/templates/admin/lists_payment.tpl',array(), true);
			} else {
				$this->template->render(dirname(dirname(__FILE__)) .'/templates/admin/lists.tpl',array(), true);
			}
        }
    }
    
    
    
    /**
     * นับจำนวนเหตุการณ์ตามเงื่อนไขของ widget
     */
    public function counter ($request)
    {
        $db     = hbm_db();
        
        $this->loader->component('template/apiresponse', 'json');
        
        $widget     = isset($request['widget']) ? $request['widget'] : '';
        $refresh    = isset($request['refresh']) ? $request['refresh'] : '';
        
        if (! $widget) {
            $this->json->assign('title', 'Error');
            $this->json->assign('count', -1);
            $this->json->show();
        }
        
        $this->json->assign('title', $this->aWidgets[$widget]['title']);
        
        $method     = '_' . $widget;
        $sqlCount   = 'COUNT(*) AS numRow,';
		if ($method == '_widgetPaypalSub' || $method == '_widgetPaypalSubSB' || $method == '_widgetNewCreditLog') {
			$sql        = "SELECT SUM(x.numRow) AS numRows FROM ( " . $this->{$method}($sqlCount) . " ) x ";
		} else {
        	$sql        = "SELECT SUM(x.numRow) - 1 AS numRows FROM ( " . $this->{$method}($sqlCount) . " ) x ";
		}
        
       /* if($method == '_widgetManualDuedateError'){
            $sql = "select count(*) as numRows from hb_accounts where next_due <> expiry_date";
        }
        */
        
        $cacheKey   = md5(serialize($request));
        $result     = CacheExtend::singleton()->get($cacheKey);
        if ($refresh == 'widget') {
            $result     = null;
        }
        if ($result == null) {
            $result     = $db->query($sql)->fetch();
            CacheExtend::singleton()->set($cacheKey, $result, 1800);
        }
        
        $rows       = isset($result['numRows']) ? $result['numRows'] : -1;
        
        $this->json->assign('count', $rows);
        $this->json->show();
    }
    /**
	 * l.output = 
	 * [a] => 'b' 
	 * [b] => 'c'
	 * [c] => 'z'
	 * 
	 * SUBSTRING_INDEX( l.output,  '\n', 2 )  ผลที่ได้  
	 * 	[b] => 'c'
	 *  [c] => 'z'
	 * 
	 * SUBSTRING_INDEX( SUBSTRING_INDEX( l.output,  '\n', 2 ) ,  '\n' , -1 ) ผลที่ได้  
	 *  [c] => 'z'
	 * 
	 * SUBSTRING_INDEX( SUBSTRING_INDEX( SUBSTRING_INDEX( l.output,  '\n', 16 ) ,  '\n' , -1 ) ,  '=>' , -1 ) ผลที่ได้
	 *  ' z '
	 * 
	 * REPLACE(SUBSTRING_INDEX( SUBSTRING_INDEX( SUBSTRING_INDEX( l.output,  '\n', 16 ) ,  '\n' , -1 ) ,  '=>' , -1 ),' ','') ผลที่ได้
	 *  'z'
	 * 
	 * REPLACE(SUBSTRING_INDEX( SUBSTRING_INDEX( SUBSTRING_INDEX( l.output,  '\n', 16 ) ,  '\n' , -1 ) ,  '=>' , -1 ),' ',''),
	 * 
	 */
	private function _widgetListRecurringError($count = '', $limit = '')
	{
	    $percentage = 0.3;
        $sql = "SELECT {$count} 'id' , 'name' , 'cname'
                    UNION( 
                         SELECT {$count} recur.id , recur.name , recur.cname
                         FROM (SELECT a.id, a.product_id, a.billingcycle, 
                            IF( a.billingcycle =  'Monthly'AND ((a.total-a.component_price) > ( c.m + ( c.m * {$percentage} ) ) OR (a.total-a.component_price) < ( c.m - ( c.m * {$percentage} ) ) ) ,  'TRUE', 
                            IF( a.billingcycle =  'Quarterly' AND ((a.total-a.component_price) > ( c.q + ( c.q * {$percentage} ) ) OR (a.total-a.component_price) < ( c.q - ( c.q * {$percentage} ) ) ) ,  'TRUE', 
                            IF( a.billingcycle =  'Semi-Annually' AND ((a.total-a.component_price) > ( c.s + ( c.s * {$percentage} ) ) OR (a.total-a.component_price) < ( c.s - ( c.s * {$percentage} ) ) ) ,  'TRUE', 
                            IF( a.billingcycle =  'Annually' AND ((a.total-a.component_price) > ( c.a + ( c.a * {$percentage} ) ) OR (a.total-a.component_price) < ( c.a - ( c.a * {$percentage} ) ) ) ,  'TRUE', 
                            IF( a.billingcycle =  'Biennially' AND ((a.total-a.component_price) > ( c.b + ( c.b * {$percentage} ) ) OR (a.total-a.component_price) < ( c.b - ( c.b * {$percentage} ) ) ) ,  'TRUE', 
                            IF( a.billingcycle =  'Triennially'AND ((a.total-a.component_price) > ( c.t + ( c.t * {$percentage} ) ) OR (a.total-a.component_price) < ( c.t - ( c.t * {$percentage} ) ) ) ,  'TRUE', 'FALSE'))))))error,
                            a.total, c.m, c.q, c.s, c.a, c.b, c.t , CONCAT(cd.firstname ,'&nbsp&nbsp', cd.lastname) as name, ca.name as cname
                            FROM hb_accounts a
                                INNER JOIN hb_common c ON ( a.product_id = c.id)
                                INNER JOIN hb_client_details cd ON (a.client_id = cd.id)
                                INNER JOIN hb_products p ON (a.product_id = p.id)
                                INNER JOIN hb_categories ca ON (p.category_id = ca.id)
                            WHERE c.rel =  'Product'
                            AND a.is_valid_recurring_amount != 1
                            AND a.billingcycle NOT IN ('Free','One Time')
                            AND p.category_id IN (2, 4, 10, 11, 16, 23, 29, 37, 47)
                            AND a.status = 'Active' ORDER BY a.id
                            ) recur
                         WHERE recur.error = 'TRUE'
                       )
                   {$limit}
                  ";
        return $sql;
	}
	
	private function _widgetNewCreditLog($count = '', $limit = '')
    {
            $count = substr($count, 0 , -1 );
            $sql    = "SELECT {$count}
                       FROM
                            hb_client_credit_log
                       WHERE
                            is_read = 0
                       {$limit} ";
        return $sql;
    }
	 
	//รายการวันที่หมดอายุ และวันที่ต้อง gen invoid ห่างกันผิดปกติ
    private function _widgetManualDuedateError($count = '', $limit = '')
    {
        
        $sql    = "
            SELECT {$count} 'id', 'domain', 'next_due', 'expiry_date', 'next_invoice_date'
            UNION (
                SELECT {$count} id , domain , next_due , expiry_date , next_invoice
                FROM
                    hb_accounts
                WHERE
                    DATE_FORMAT(next_due,'%Y-%m') <> DATE_FORMAT(next_expiry_date,'%Y-%m')
                    AND DATE_FORMAT(next_due,'%Y-%m') > DATE_FORMAT(next_expiry_date,'%Y-%m')
                    AND next_expiry_date <> '0000-00-00'
                    AND status = 'Active' 
                    AND billingcycle NOT IN ( 'Free',  'One Time' )
                    AND DATEDIFF(next_due,next_expiry_date) > 3
                    AND is_payment_inprogress != 1
                ORDER BY next_due ASC
            ) UNION (
                SELECT {$count} id , CONCAT(name,'_isdomain')  , next_due  , expires , next_invoice
                FROM
                    hb_domains
                WHERE
                    DATE_FORMAT(expires,'%Y-%m') <> DATE_FORMAT(next_invoice,'%Y-%m')
                    AND DATE_FORMAT(expires,'%Y-%m') > DATE_FORMAT(next_invoice,'%Y-%m')
                    AND next_invoice <> '0000-00-00'
                    AND status = 'Active'
                    AND DATEDIFF(expires,next_invoice) > 60
                    AND is_payment_inprogress != 1
                ORDER BY expires ASC
            )
            {$limit}
            ";
            
        return $sql;
    }
    
    private function _widgetPaypalSub($count = '', $limit = '')
	{

		$sql = "
            
                SELECT {$count} 'gtwlog' as serviceType,'paypal_subscr' as paymentModule , 
                REPLACE(SUBSTRING_INDEX( SUBSTRING_INDEX( SUBSTRING_INDEX( l.output,  '\n', 16 ) ,  '\n' , -1 ) ,  '=>' , -1 ),' ','')as transaction_id,
                REPLACE(SUBSTRING_INDEX( SUBSTRING_INDEX( SUBSTRING_INDEX( l.output,  '\n', 15 ) ,  '\n' , -1 ) ,  '=>' , -1 ),' ','') as email,
                REPLACE(SUBSTRING_INDEX( SUBSTRING_INDEX( SUBSTRING_INDEX( l.output,  '\n', 8 ) ,  '\n' , -1 ) ,  '=>' , -1 ),' ','') as amount,
                REPLACE(SUBSTRING_INDEX( SUBSTRING_INDEX( SUBSTRING_INDEX( l.output,  '\n', 21 ) ,  '\n' , -1 ) ,  '=>' , -1 ),' ','')as invoice,
				l.date,l.id,l.result
                FROM
                    `hb_gateway_log` l
                WHERE
                    l.module =11
					AND  REPLACE(SUBSTRING_INDEX( SUBSTRING_INDEX( SUBSTRING_INDEX( l.output,  '\n', 16 ) ,  '\n' , -1 ) ,  '=>' , -1 ),' ','') 
					NOT IN (
						SELECT 'trans_id'
						UNION (select trans_id FROM hb_transactions WHERE module = 11)
						UNION (select transaction_id FROM hb_client_credit_log)
					)
					AND l.output LIKE  '%subscr_payment%'
				ORDER BY l.id DESC
            
            {$limit} 
			
            ";

        return $sql;
	}
    private function _widgetActiveNoExpire ($count = '', $limit = '')
    {
        
        $sql = "
            SELECT {$count} 'serviceType', 'id', 'name', 'status', 'nextDue', 'expiryDate'
            UNION (
                SELECT {$count} 'domains', id, name, status, next_due, expires
                FROM
                    hb_domains
                WHERE
                    status = 'Active'
                    AND (expires = '0000-00-00' OR expires IS NULL)
            )
            UNION (
                SELECT {$count} 'accounts', id, domain, status, next_due, '-'
                FROM
                    hb_accounts
                WHERE
                    status = 'Active'
                    AND (next_due = '0000-00-00' OR next_due IS NULL)
                    AND billingcycle NOT IN ('Free', 'One Time')
            )
            {$limit}
            ";
        
        return $sql;
    }
    
    private function _widgetActiveDueExpire ($count = '', $limit = '')
    {
        
        $sql = "
            SELECT {$count} 'serviceType', 'id', 'name', 'status', 'nextDue', 'expiryDate'
            UNION (
                SELECT {$count} 'domains', id, name, status, next_due, expires
                FROM
                    hb_domains
                WHERE
                    status = 'Active'
                    AND expires > '0000-00-00'
                    AND next_due < expires
            )
            UNION (
                SELECT {$count} 'accounts', a.id, a.domain, a.status, a.next_due, x.expiryDate
                FROM
                    hb_accounts a,
                    (
                        SELECT 
                            MAX(STR_TO_DATE(SUBSTRING(TRIM(SUBSTRING_INDEX(ii.description, '-', -1)),1,10)
                                ,'%d/%m/%Y')) AS expiryDate,
                            ii.item_id
                        FROM 
                            hb_invoices i,
                            hb_invoice_items ii
                        WHERE 
                            i.id = ii.invoice_id
                            AND i.status = 'Paid'
                            AND ii.type = 'Hosting'
                        GROUP BY ii.item_id
                    ) x
                WHERE
                    a.id = x.item_id
                    AND a.status = 'Active'
                    AND a.next_due > '0000-00-00'
                    AND a.next_due < x.expiryDate
            )
            {$limit}
            ";
        
        return $sql;
    }
    
    /* --- List รายการ manual CC ยังไม่ process (invoice Unpaid) --- */
    private function _widgetManualCCInvoiceUnpaid ($count = '', $limit = '')
    {
        
        $sql = "
            SELECT {$count} 'mId', 'invoiceId', 'clientId', 'firstname', 'lastname', 'state'
            UNION (
                SELECT {$count} m.id, i.id AS invoice_id, d.id as client_id, d.firstname, d.lastname, m.status AS state
                FROM 
                    hb_client_details d 
                    RIGHT JOIN hb_invoices i 
                        ON d.id = i.client_id
                    RIGHT JOIN hb_manual_payment m 
                        ON i.id = m.invoice_id 
                WHERE
                    i.status = 'Unpaid'
                    AND i.duedate < NOW()
            )
            {$limit}
            ";
        
        return $sql;
        
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
    
    /* --- รายการ domain ที่ถึงวัน geninvoice แต่ไม่มี invoice ออกมา --- */
    private function _widgetListDomainOverNextInvoice ($count = '', $limit = '')
    {

        $sql = "
            SELECT {$count} 'serviceType', 'id', 'name', 'status', 'nextDue', 'expiryDate'
            UNION (
                SELECT
                    {$count} 'domains', d.id, d.name, d.status, d.next_due, d.expires
                FROM
                    hb_orders o
                    LEFT JOIN
                        hb_invoices i
                        ON i.id = o.invoice_id,
                    hb_domains d
                    LEFT JOIN 
                        (
                        SELECT dx.id AS idx
                        FROM
                            hb_domains dx,
                            hb_orders ox,
                            hb_invoice_items iix,
                            hb_invoices ix
                        WHERE dx.id = iix.item_id
                            AND iix.type LIKE 'Domain%'
                            AND iix.invoice_id = ix.id
                            AND ix.status = 'Unpaid'
                            AND DATE_ADD(ix.date, INTERVAL 15 DAY) >= dx.next_invoice
                            AND dx.order_id = ox.id
                            AND ox.invoice_id != ix.id
                        ) x
                        ON x.idx = d.id
                WHERE
                    d.order_id = o.id
                    AND o.status = 'Pending'
                    AND d.status = 'Active'
                    AND d.type='Renew'
                    AND d.next_invoice < NOW() 
                    AND (
                        DATEDIFF(d.next_invoice, o.date_created) > 1
                        OR
                        DATEDIFF(d.next_invoice, o.date_created) < -1
                        )
                    AND (i.id IS NULL OR i.status != 'Unpaid')
                    AND x.idx IS NULL
            )
            {$limit}
            ";
        
        return $sql;
        
    }
    
    private function _widgetInvoicePaidServiceNotActive ($count = '', $limit = '')
    {
        $last7Day       = date('Y-m-d', strtotime('-1 week'));
        $before3Month   = date('Y-m-d', strtotime('-3 month'));
        
        $sql = "
            SELECT {$count} 'id', 'date', 'description', 'datepaid'
            UNION (
                SELECT
                    {$count} i.id, i.date, ii.description, i.datepaid
                FROM
                    hb_invoices i,
                    hb_invoice_items ii,
                    hb_accounts a
                WHERE
                    i.status = 'Paid'
                    AND i.datepaid < '{$last7Day}'
                    AND i.datepaid > '{$before3Month}'
                    AND i.id = ii.invoice_id
                    AND ii.type LIKE 'Hosting'
                    AND ii.item_id = a.id
                    AND a.status LIKE 'Pending%'
                    AND a.billingcycle NOT IN ('Free', 'One Time')
            )
            UNION (
                SELECT
                    {$count} i.id, i.date, ii.description, i.datepaid
                FROM
                    hb_invoices i,
                    hb_invoice_items ii,
                    hb_domains d
                WHERE
                    i.status = 'Paid'
                    AND i.datepaid < '{$last7Day}'
                    AND i.datepaid > '{$before3Month}'
                    AND i.id = ii.invoice_id
                    AND ii.type LIKE 'Domain%'
                    AND ii.item_id = d.id
                    AND d.status LIKE 'Pending%'
            )
            {$limit}
            ";
        
        return $sql;
    }
    
    private function _widgetInvoiceUnpaidServiceActive ($count = '', $limit = '')
    {
        $last6Weak      = date('Y-m-d', strtotime('-6 weeks'));
        
        $sql = "
            SELECT {$count} 'id', 'date', 'description', 'datepaid'
            UNION (
                SELECT
                    {$count} i.id, i.date, ii.description, i.datepaid
                FROM
                    hb_invoices i,
                    hb_invoice_items ii,
                    hb_accounts a,
                    hb_orders o
                WHERE
                    i.status = 'Unpaid'
                    AND i.id = ii.invoice_id
                    AND ii.type = 'Hosting'
                    AND ii.item_id = a.id
                    AND a.status = 'Active'
                    AND a.order_id = o.id
                    AND a.date_changed < '{$last6Weak}'
                    AND a.next_due != a.next_invoice
                    AND o.invoice_id = i.id
            )
            UNION (
                SELECT
                    {$count} i.id, i.date, ii.description, i.datepaid
                FROM
                    hb_invoices i,
                    hb_invoice_items ii,
                    hb_domains d,
                    hb_orders o
                WHERE
                    i.status = 'Unpaid'
                    AND i.id = ii.invoice_id
                    AND ii.type LIKE 'Domain%'
                    AND ii.item_id = d.id
                    AND d.status = 'Active'
                    AND d.type IN ('Register', 'Transfer')
                    AND d.order_id = o.id
                    AND d.date_created < '{$last6Weak}'
                    AND d.next_due != d.next_invoice
                    AND o.invoice_id = i.id
            )
            {$limit}
            ";
        
        return $sql;
    }
    
    private function _widgetListDueIn30Days ($count = '', $limit = '')
    {
        $sql = "
            SELECT {$count} 'id', 'item_id', 'description', 'duedate'
            UNION (
                SELECT
                    {$count} i.id, ii.item_id, ii.description, i.duedate
                FROM
                    hb_invoices i,
                    hb_invoice_items ii,
                    hb_accounts a,
                    hb_products p
                WHERE
                    i.status = 'Unpaid'
                    AND i.duedate < CURDATE() + INTERVAL 30 DAY
                    AND i.id = ii.invoice_id
                    AND ii.type = 'Hosting'
                    AND ii.item_id = a.id
                    AND a.product_id = p.id
                    AND p.category_id IN (8,54,107,97,75,57,74,78,82,76,77,81,102,71,103,109)
                    AND a.status = 'Active'
            )
            ". ($limit ? " ORDER BY duedate DESC " : "  ") ."
            {$limit}
            ";
        
        return $sql;
    }
    
    private function _widgetListSSLShouldTerminate ($count = '', $limit = '')
    {
        $sql = "
            SELECT {$count} 'serviceType', 'id', 'name', 'status', 'nextDue', 'expiryDate'
            UNION (
                SELECT {$count} 'accounts', a.id, a.domain, a.status, a.next_due, a.expiry_date
                FROM hb_accounts a,
                    hb_products p
                WHERE  DATE_ADD(a.expiry_date, INTERVAL 30 DAY) < NOW()
                    AND a.status IN ('Active', 'Suspended')
                    AND a.product_id = p.id
                    AND p.category_id = 23
            )
            ". ($limit ? " ORDER BY expiryDate DESC " : "  ") ."
            {$limit}
            ";
        
        return $sql;
    }
    
    private function _widgetListInvoiceContractDateYesterday ($count = '', $limit = '')
    {
        $time   = strtotime('-1 day');
        $date   = date('d', $time) .'/'. date('m', $time) .'/'. date('Y', $time);
        
        $aFilter    = $this->_filter(array());
        $keword     = isset($aFilter['keyword']) ? $aFilter['keyword'] : '';
        if ($keword) {
            $date   = $keword;
        }
        
        $sql    = "
            SELECT {$count} 'id', 'date', 'invoice_number', 'description'
            UNION (
                SELECT {$count} i.id, i.date, i.invoice_number, ii.description
                FROM hb_invoice_items ii,
                    hb_invoices i
                WHERE i.id = ii.invoice_id
                    AND ii.description LIKE '%({$date}%'
            )
            ". ($limit ? " ORDER BY id ASC " : "  ") ."
            {$limit}
            ";
        
        return $sql;
    }
    
    private function _widgetListInvoiceUnpaidContractToday ($count = '', $limit = '')
    {
        $aDate  = array();
        for ($i = 1; $i <= 3; $i++) {
            $date   = strtotime('-'. $i .' day');
            $aDate[]    = date('d M Y', $date);
        }
        $date       = date('d M Y');
        
        $sql    = "
            SELECT {$count} 'id', 'date', 'invoice_number', 'description'
            UNION (
                SELECT {$count} i.id, i.date, i.invoice_number, ii.description
                FROM hb_invoice_items ii,
                    hb_invoices i,
                    hb_accounts a
                WHERE i.id = ii.invoice_id
                    AND ii.type = 'Hosting'
                    AND ii.item_id = a.id
                    AND a.status = 'Active'
                    AND ii.description NOT LIKE '%SSL Certificates%'
                    AND i.status = 'Unpaid'

                    AND ( ii.description LIKE '%({$date}%'
                    ";
                    foreach ($aDate as $v) {
                    $sql .= "
                        OR ii.description LIKE '%({$v}%'
                        ";
                    }
                    $sql .= "
                    )

            )
            UNION (
                SELECT {$count} i.id, i.date, i.invoice_number, ii.description
                FROM hb_invoice_items ii,
                    hb_invoices i,
                    hb_domains d
                WHERE i.id = ii.invoice_id
                    AND ii.type LIKE 'Domain%'
                    AND ii.item_id = d.id
                    AND d.status = 'Active'
                    AND ii.description NOT LIKE '%SSL Certificates%'
                    AND i.status IN ('Unpaid', 'Collections')

                    AND ( ii.description LIKE '%({$date}%'
                    ";
                    foreach ($aDate as $v) {
                    $sql .= "
                        OR ii.description LIKE '%({$v}%'
                        ";
                    }
                    $sql .= "
                    )

            )
            ". ($limit ? " ORDER BY id ASC " : "  ") ."
            {$limit}
            ";
        
        return $sql;
    }
    
    public function checkinvoice ($request)
    {
        $db     = hbm_db();
        
        $type   = isset($request['type']) ? $request['type'] : '';
        $id     = isset($request['id']) ? $request['id'] : 0;
        
        if ($type == 'domains') {
            $result     = $db->query("
                SELECT i.status
                FROM hb_domains d,
                    hb_orders o,
                    hb_invoices i
                WHERE d.id = :id
                    AND d.order_id = o.id
                    AND o.invoice_id = i.id
                ", array(
                    ':id'   => $id
                ))->fetch();
                
        }
        if ($type == 'accounts') {
            $result     = $db->query("
                SELECT i.status
                FROM hb_invoice_items ii,
                    hb_invoices i
                WHERE ii.item_id = :id
                    AND ii.type = 'Hosting'
                    AND ii.invoice_id = i.id
                ORDER BY ii.id DESC
                LIMIT 1
                ", array(
                    ':id'   => $id
                ))->fetch();
        }
        
        $status     = isset($result['status']) ? $result['status'] : '';
        
        $this->loader->component('template/apiresponse', 'json');
        $this->json->assign('status', $status);
        $this->json->show();
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