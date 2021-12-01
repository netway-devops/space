<?php

class widgeter_controller extends HBController {
    public $aWidgets    = array(
        'widgetActiveNoExpire'      => array(
            'title'     => 'List domain and services ที่ active แต่ไม่มีวันหมดอายุ ',
        ),
        'widgetActiveDueExpire'     => array(
            'title'     => 'List domain and services ที่ active แต่ due-date น้อยกว่า วันหมดอายุ ยกเว้น domain and services ที่ active แต่ไม่มีวันหมดอายุ ',
        ),
        'widgetManualCCInvoiceUnpaid'       => array(
            'title'     => 'List รายการ manual CC ยังไม่ process (invoice Unpaid)',
        ),
        'widgetManualCreditBalanceNotRenew' => array(
            'title'     => 'List รายการ accounts ยังไม่ renew (invoice credit balance)',
        ),
        'widgetAutomationFullPaidClientGroup' => array(
            'title'     => 'List รายชื่อ clients ที่ค้างอยู่ในกลุ่ม automation full paid client',
        ),
    	'widgetRVTwoFactorTerminatedAccount' => array(
    		'title'		=> 'List RV2Factor accounts ที่มีสถานะเป็น terminate และยังไม่ถูก revoke certificate',
    	),
    	'widgetSSLRenewingToLong' => array(
            'title'     => 'List accounts ที่มีสถานะเป็น Renewing',
        ),
        /*
        'widgetPaypalSub'     => array(
            'title'     => 'List รายการจ่ายเงิน Paypal Subscrition ที่มีปัญหา',
            'description'   => 'มี transaction id แต่ไม่ได้เอาไปผูกกับ invoice หรือ credit จพทำให้นำไปอ้างอิงไม่ได้',
        ),
        'widgetPaypalSubSB'     => array(
            'title'     => 'List รายการจ่ายเงิน Paypal Subscrition ของ Sitebuilder',
        ),
        'widgetPaypalSubLog' => array(
            'title'     => 'List Paypal Subscrition Log',
        ),
        'widgetPaypalMissingTransaction' => array(
            'title'     => 'Paypal Transaction ที่ไม่มีบนระบบ',
        ),
        */
        'widgetPaypalTransaction' => array(
            'title'     => 'Paypal Transaction',
            'description'   => 'มี transaction id ที่ไม่ได้เอาไปผูกกับ invoice หรือ credit ทำให้นำไปอ้างอิงไม่ได้ ต้องทำการแก้ไข',
        ),
        'widgetSuspendPaypalSubscription' => array(
            'title'     => 'Suspend Paypal Subscription',
            'description'   => 'รายการ Paypal subscription ที่ต้อง suspend หรือ cancel เมื่อ accout terminated.',
        ),
        
    );
    public function beforeCall ($request)
    {
        $this->_beforeRender();
        $this->template->assign('allWidgets', $this->aWidgets);
    }

    public function _default ($request)
    {
        $db     = hbm_db();

        $this->template->render(dirname(dirname(__FILE__)) .'/templates/admin/default.tpl',array(), true);
    }

    public function getadvanced ($request)
    {
        $currentfilter      = $this->_filter($request);
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
            header('location:index.php?cmd=module&module=50');
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

        if($widgetName =='widgetSuspendPaypalSubscription') {
            $aDatas_    = array();
            foreach ($aDatas as $arr) {
                $aChange    = unserialize($arr['change']);
                $aData      = isset($aChange['data']) ? $aChange['data'] : array();
                foreach ($aData as $arr_) {
                    $arr[$arr_['name']]     = $arr_['to'];
                }
                array_push($aDatas_, $arr);
            }
            $aDatas     = $aDatas_;
        }

        $this->template->assign('aDatas', $aDatas);
        $this->template->assign('currentfilter', $currentfilter);

        if (isset($request['page'])) {
        	if ($widgetName =='widgetPaypalSub'||$widgetName =='widgetPaypalSubSB'||$widgetName=='widgetPaypalSubLog') {
            	$this->template->render(dirname(dirname(__FILE__)) .'/templates/admin/ajax.lists_payment.tpl',array(), true);
			} elseif($widgetName =='widgetPaypalTransaction') {
				$this->template->render(dirname(dirname(__FILE__)) .'/templates/admin/ajax.lists_paypal.tpl',array(), true);
			} elseif($widgetName =='widgetPaypalSubSB') {
				$this->template->render(dirname(dirname(__FILE__)) .'/templates/admin/ajax.lists_payment_sb.tpl',array(), true);
			}elseif($widgetName =='widgetManualCreditBalanceNotRenew') {
                $this->template->render(dirname(dirname(__FILE__)) .'/templates/admin/ajax.list_creditbalance.tpl',array(), true);
            }elseif($widgetName =='widgetAutomationFullPaidClientGroup') {
                $this->template->render(dirname(dirname(__FILE__)) .'/templates/admin/ajax.lists_groupautomationfullpaid.tpl',array(), true);
            }elseif($widgetName =='widgetRVTwoFactorTerminatedAccount') {
                $this->template->render(dirname(dirname(__FILE__)) .'/templates/admin/ajax.lists_rvtwofactorterminatedaccount.tpl',array(), true);
            }elseif($widgetName =='widgetPaypalMissingTransaction') {
                $this->template->render(dirname(dirname(__FILE__)) .'/templates/admin/ajax.lists_paypal_transaction.tpl',array(), true);
            }elseif($widgetName =='widgetSuspendPaypalSubscription') {
                $this->template->render(dirname(dirname(__FILE__)) .'/templates/admin/ajax.lists_suspend_paypal_subscription.tpl',array(), true);
            }else {
				$this->template->render(dirname(dirname(__FILE__)) .'/templates/admin/ajax.lists.tpl',array(), true);
			}
        } else {
        	if ($widgetName =='widgetPaypalSub'||$widgetName =='widgetPaypalSubSB'||$widgetName=='widgetPaypalSubLog') {
            	$this->template->render(dirname(dirname(__FILE__)) .'/templates/admin/lists_payment.tpl',array(), true);
			} elseif($widgetName =='widgetPaypalTransaction') {
				$this->template->render(dirname(dirname(__FILE__)) .'/templates/admin/lists_paypal.tpl',array(), true);
			} elseif($widgetName =='widgetPaypalSubSB') {
				$this->template->render(dirname(dirname(__FILE__)) .'/templates/admin/lists_payment_sb.tpl',array(), true);
			} elseif($widgetName =='widgetManualCreditBalanceNotRenew') {
                $this->template->render(dirname(dirname(__FILE__)) .'/templates/admin/lists_creditbalance.tpl',array(), true);
            }elseif($widgetName =='widgetAutomationFullPaidClientGroup') {
                $this->template->render(dirname(dirname(__FILE__)) .'/templates/admin/lists_groupautomationfullpaid.tpl',array(), true);
            }elseif($widgetName =='widgetRVTwoFactorTerminatedAccount') {
                $this->template->render(dirname(dirname(__FILE__)) .'/templates/admin/lists_rvtwofactorterminatedaccount.tpl',array(), true);
            }elseif($widgetName =='widgetPaypalMissingTransaction') {
                $this->template->render(dirname(dirname(__FILE__)) .'/templates/admin/lists_paypal_transaction.tpl',array(), true);
            }elseif($widgetName =='widgetSuspendPaypalSubscription') {
                $this->template->render(dirname(dirname(__FILE__)) .'/templates/admin/lists_suspend_paypal_subscription.tpl',array(), true);
            }else {
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

        $widget = isset($request['widget']) ? $request['widget'] : '';

        if (! $widget) {
            $this->json->assign('title', 'Error');
            $this->json->assign('count', -1);
            $this->json->show();
        }

        $this->json->assign('title', $this->aWidgets[$widget]['title']);

        $method     = '_' . $widget;
        $sqlCount   = 'COUNT(*) AS numRow,';
		if ($method == '_widgetPaypalSub' || $method == '_widgetPaypalSubSB' || $method == '_widgetPaypalTransaction') {
			$sql        = "SELECT SUM(x.numRow) AS numRows FROM ( " . $this->{$method}($sqlCount) . " ) x ";
		} else {
        	$sql        = "SELECT SUM(x.numRow) - 1 AS numRows FROM ( " . $this->{$method}($sqlCount) . " ) x ";
		}
        $result     = $db->query($sql)->fetch();

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

    private function _widgetPaypalTransaction ($count = '', $limit = '')
	{
		$sql = "
            SELECT 
                {$count} 
                pt.transaction_id, 
                pt.transaction_initiation_date,
                pt.transaction_amount,
                pt.transaction_subject,
                pt.paypal_account
            FROM 
                hb_paypal_transaction pt
            WHERE 
                pt.transaction_initiation_date >= CURDATE() - INTERVAL 1 MONTH
                AND pt.is_skip_verify = 0
                AND pt.client_credit_log_id = 0
                AND pt.transaction_log_id = 0
            ORDER BY  pt.transaction_initiation_date DESC
            {$limit}
            ";

        return $sql;
	}

    private function _widgetPaypalSub($count = '', $limit = '')
	{
		$sql = "
        
                SELECT {$count} 'gtwlog' as serviceType,'paypal_subscr' as paymentModule ,
                ppl.transaction_id as transaction_id,
                ppl.email as email,
                ppl.amount as amount,
                ppl.invoice_id as invoice,
				l.date,l.id,l.result
                FROM
                    `hb_gateway_log` l 
                    LEFT JOIN `hb_paypal_subscription_log` ppl 
                        ON l.id = ppl.gateway_log_id
                WHERE
                    l.module = 11
                    AND l.date >= CURDATE() - INTERVAL 1 MONTH
					AND  ( ppl.client_credit_log_id = 0 AND  ppl.transaction_log_id = 0 )
				ORDER BY l.id DESC

            {$limit}

            ";

        return $sql;
	}
    
    private function _widgetPaypalSubLog($count = '', $limit = '')
    {
        $last3Month     = date('Y-m-d', strtotime('-3 months'));
        $sql = "

                SELECT {$count} 'gtwlog' as serviceType,'paypal_subscr' as paymentModule ,
                ppl.transaction_id as transaction_id,
                ppl.email as email,
                ppl.amount as amount,
                ppl.invoice_id as invoice,
                l.date,l.id,l.result
                FROM
                    `hb_gateway_log` l 
                    LEFT JOIN `hb_paypal_subscription_log` ppl 
                        ON l.id = ppl.gateway_log_id
                        AND ppl.is_manual_verify = 0
                WHERE
                    l.module = 11
                    AND l.date >= CURDATE() - INTERVAL 1 MONTH
                    AND ppl.id IS NOT NULL
                    AND l.result = 'Successfull'
                ORDER BY l.id DESC

            {$limit}

            ";

        return $sql;
    }
    
    private function _widgetPaypalMissingTransaction($count = '', $limit = '')
    {
        $sql = "
            SELECT {$count} 'transaction_id', 'transaction_subject', 'paypal_reference_id', 
                'transaction_initiation_date', 'transaction_amount'
            UNION (
                SELECT {$count} pt.transaction_id,
                    pt.transaction_subject,
                    pt.paypal_reference_id,
                    pt.transaction_initiation_date,
                    pt.transaction_amount
                FROM
                    hb_paypal_transaction pt
                    LEFT JOIN hb_transactions t
                    ON t.trans_id = pt.transaction_id
                WHERE
                    pt.paypal_reference_id_type = 'SUB'
                    AND pt.is_skip_verify != 1
                    AND t.id IS NULL
            )
            {$limit}

            ";

        return $sql;
    }
    
	private function _widgetPaypalSubSB($count = '', $limit = '')
	{
		$sql = "

                SELECT {$count} 'gtwlog' as serviceType,'paypal_subscr_sitebuilder' as paymentModule ,
                ppl.transaction_id as transaction_id,
                ppl.email as email,
                ppl.cpid as cpid,
                ppl.amount as amount,
                ppl.invoice_id as invoice,
                ppl.invoice_hb as invoice_hb,
                ppl.mail_hb as mail_hb,
				l.date,l.id,l.result
                FROM
                    `hb_gateway_log` l JOIN `hb_paypal_subscription_log` ppl ON l.id = ppl.gateway_log_id,
                    hb_gateway_log_ext gle
                WHERE
                    l.module =11
                    AND l.id = gle.id
                    AND gle.is_subscr_sb_payment = 1
                    AND l.date >= CURDATE() - INTERVAL 1 MONTH
                    AND  ( ppl.client_credit_log_id = 0 AND  ppl.transaction_log_id = 0 )
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
                ORDER BY
                    i.duedate ASC
            )
            {$limit}
            ";

        return $sql;

    }


    public function _widgetManualCreditBalanceNotRenew ($count = '', $limit = '')
    {

        $sql = "
            SELECT {$count} 'aId', 'invoiceId', 'status', 'invoicedate'
            UNION (
            SELECT  {$count} a.id as id , i.id as invoice_id , i.status as status , i.`date` as invoice_date
                FROM
                    `hb_accounts` a
                    INNER JOIN hb_invoice_items ii
                    ON ( a.id = ii.item_id AND ii.type = 'Hosting')
                    INNER JOIN hb_invoices i
                    ON ( ii.invoice_id = i.id)
                    INNER JOIN hb_products p
                    ON ( p.id = a.product_id AND p.category_id != 1 )
                WHERE
                    i.status = 'Paid'
                    AND i.credit > 0
                    AND i.duedate > CURDATE()
                    AND a.id NOT IN
                    (
                        SELECT a.id
                        FROM
                            `hb_accounts` a
                            INNER JOIN hb_invoice_items ii
                            ON ( a.id = ii.item_id AND ii.type = 'Hosting')
                            INNER JOIN hb_invoices i
                            ON ( ii.invoice_id = i.id)
                            INNER JOIN hb_account_logs al
                            ON ( a.id = al.`account_id`)
                        WHERE
                            i.status = 'Paid'
                            AND i.credit > 0
                            AND i.duedate > CURDATE()
                            AND al.event = 'AccountRenew'
                            AND DATE(al.`date`) >= DATE(i.`date`)
                            AND DATE(al.`date`) <= DATE(i.duedate)
                    )
            )
            {$limit}
            ";

        return $sql;

    }



    private function _widgetAutomationFullPaidClientGroup ($count = '', $limit = '')
    {

        $sql = "
            SELECT {$count} 'cId', 'Firstname', 'Lastname', 'Email'
            UNION (
            SELECT  {$count} ca.id , cd.firstname , cd.lastname , ca.email
            FROM    hb_client_access ca
                    INNER JOIN hb_client_details cd
                    ON(ca.id = cd.id)
            WHERE
                    ca.group_id = 2
            )
            {$limit}
            ";

        return $sql;

    }

    private function _widgetRVTwoFactorTerminatedAccount ($count = '', $limit = '')
    {
//     	$sql = "
//             SELECT  {$count}
//             	a.id AS Account_ID
//             	, a.order_id AS Order_ID
//             	, a.client_id AS Client_ID
//             	, a.product_id AS Product_ID
//             	, a.next_due AS Next_Due
//             	, a.status AS Status
//             	, cd.firstname AS Firstname
//             	, cd.lastname AS Lastname
//                 FROM
//                     `hb_accounts` as a
//                     , hb_client_details as cd
//                 WHERE
//                     a.status = 'Terminated'
//                     AND a.notes = ''
// 	    			AND a.product_id IN (58,59,60,61)
// 	    			AND a.client_id = cd.id
// 	    		ORDER BY a.order_id DESC
//            {$limits}
//     	";

        $sql = "
        	SELECT {$count}
				a.id AS Account_ID
				, a.order_id AS Order_ID
				, a.product_id AS Product_ID
				, a.status AS Status
				, a.next_due AS Next_Due
				, i.certificate_file_name AS CERT_NAME
				, a.notes AS Note
			FROM
				hb_accounts AS a
				, hb_vip_info AS i
			WHERE
				a.product_id IN (58, 59)
				AND a.status = 'Terminated'
				AND a.id = i.account_id
			       	AND a.notes = ''
			UNION ALL
			SELECT {$count}
				a.id AS Account_ID
				, a.order_id AS Order_ID
				, a.product_id AS Product_ID
				, a.status AS Status
				, a.next_due AS Next_Due
				, icpa.certificate_file_name AS CERT_NAME
				, a.notes AS Note
			FROM
				hb_accounts AS a
				, hb_vip_info_cp_apps AS icpa
			WHERE
				a.product_id IN (60, 61)
				AND a.status = 'Terminated'
				AND a.id = icpa.account_id
			       	AND a.notes = ''
			ORDER BY order_id DESC, product_id ASC
        ";
    	return $sql;

    }
    private function _widgetSSLRenewingToLong ($count = '', $limit = '')
    {

       $sql = "
            SELECT {$count} 'serviceType', 'id', 'name', 'nextDue', 'status'
            UNION (
            SELECT  {$count} 'accounts', a.id , a.domain , a.next_due , a.status
            FROM hb_accounts a
            LEFT JOIN hb_invoice_items ii ON ii.type =  'Hosting'
                AND ii.item_id = a.id
            LEFT JOIN hb_invoices i ON i.id = ii.invoice_id
                AND i.status =  'Paid'
                AND ABS( DATEDIFF( i.duedate, NOW( ) ) ) 
            BETWEEN 15 AND 30 
            WHERE a.status =  'Renewing'
                AND i.duedate IS NOT NULL 
           ) ORDER BY nextDue DESC 
           {$limit}
           ";

       return $sql;

    }

    private function _widgetSuspendPaypalSubscription ($count = '', $limit = '')
    {

       $sql = "
            SELECT {$count} 'nextDue', 'date', 'id', 'account_id', 'change'
            UNION (
            SELECT  {$count} a.next_due, al.date, al.id , al.account_id, al.change
            FROM hb_account_logs al,
                hb_accounts a
            WHERE al.account_id = a.id
                AND al.result = 0
                AND al.event = 'SuspendPaypalSubscription'
           ) ORDER BY nextDue DESC 
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

    private function _beforeRender ()
    {
        $this->template->assign('tplPath', dirname(dirname(__FILE__)) . '/templates/');
        $this->template->assign('tplClientPath', MAINDIR . 'templates/');
    }

    public function afterCall ($request)
    {

    }
}