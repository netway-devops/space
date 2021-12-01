<?php
foreach ($this->_tpl_vars['services'] as $k => $v) {
	require_once HBFDIR_LIBS . 'RvLibs/SSL/PHPLibs.php';
	$db = hbm_db();
	$oAuth =& RvLibs_SSL_PHPLibs::singleton();

	$orderItrmInfo = $db->query("
		SELECT
			so.csr AS csr,
			so.commonname AS cname,
			so.symantec_status,
			i.status AS invoice_status
		FROM
			hb_invoice_items AS it,
			hb_orders AS o,
			hb_ssl_order AS so,
			hb_invoices AS i
		WHERE
			it.item_id = :item_id
			AND it.invoice_id = o.invoice_id
			AND o.id = so.order_id
			AND i.id = it.invoice_id
		",
		array(
			':item_id' => $v['id']
		)
	)->fetch();

	if ($orderItrmInfo['cname'] != '') {
		//$this->_tpl_vars['services'][$k]['name'] .= ' for ' . $orderItrmInfo['cname'];
        $this->_tpl_vars['services'][$k]['dname'] = $orderItrmInfo['cname'] . '<br>';
	}

    if($orderItrmInfo['invoice_status'] == 'Unpaid'){
        $this->_tpl_vars['services'][$k]['status'] = 'Unpaid';
    }else{
        if($v['status'] == 'Active'){
            $this->_tpl_vars['services'][$k]['status'] = 'Active';
        }else{
            if($v['status'] == 'Pending' && $orderItrmInfo['csr'] != '' && $orderItrmInfo['invoice_status'] == 'Paid' && !strpos($orderItrmInfo['symantec_status'],'FAILED') && $orderItrmInfo['symantec_status'] != 'DOMAIN_NOT_PREVETTED'){
                $this->_tpl_vars['services'][$k]['status'] = 'Processing';

            }else if($v['status'] == 'Pending' || $orderItrmInfo['csr'] == '' || strpos($orderItrmInfo['symantec_status'],'FAILED') || $orderItrmInfo['symantec_status'] == 'DOMAIN_NOT_PREVETTED'){
                $this->_tpl_vars['services'][$k]['status'] = 'Incomplete';
            }else{
                $this->_tpl_vars['services'][$k]['status'] = $v['status'];
            }
        }
    }

    $this->_tpl_vars['services'][$k]['account_status'] = $v['status'];


    $this->_tpl_vars['services'][$k]['symantec_status'] = $orderItrmInfo['symantec_status'];

    if($orderItrmInfo['symantec_status'] != 'COMPLETED'){
        $this->_tpl_vars['services'][$k]['next_due'] = 0;
    }

    //UPDATE STATUS
    $accountInfo = array();
	foreach($this->_tpl_vars['services'] as $k => $v){
		$accountId = $v['id'];
		$eachOrder = $db->query("
				SELECT
					o.id AS order_id
					,so.last_updated
					,so.authority_orderid
					,so.partner_order_id
					,cert_status
					, a.id AS acct_id
				FROM
					hb_ssl_order AS so
					, hb_accounts AS a
					, hb_orders AS o
				WHERE
					a.id = {$accountId}
					AND a.order_id = o.id
					AND so.order_id = o.id
					AND a.status != 'Terminated'
		")->fetch();

		$lUpdate = $eachOrder['last_updated'];
		$now = strtotime('now');
		$gapTime = $now-$lUpdate;
		$orderId = $eachOrder['order_id'];

		if($gapTime >= 60*60 && $eachOrder['authority_orderid'] != '' && $eachOrder['cert_status'] != 'Active'){
			$updateInfo[$orderId] = $eachOrder['acct_id'];
		}
	}
}

$allAccounts = sizeof($this->_tpl_vars['services']);
$updateSize = sizeof($updateInfo);
if($updateSize){
// 	$this->_tpl_vars['ssl_update_size'] = $updateSize;
// 	$this->assign('ssl_update_info', json_encode($updateInfo));
// 	$this->assign('ssl_update_size', $updateSize);
// 	foreach($updateInfo as $orderId => $partnerId){
// 		$orderInfo = $oAuth->GetOrderByPartnerOrderIdClient($partnerId);
// 		echo '<pre>'; print_r($orderInfo); echo '</pre>';
// 	}
}