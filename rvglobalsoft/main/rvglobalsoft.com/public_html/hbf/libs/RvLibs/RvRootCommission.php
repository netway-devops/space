<?php

class RvRootCommission
{
	function getCommissionBalance()
	{
		$db         = hbm_db();
		$userId = isset($_SESSION['AppSettings']['login']['id'])
			? $_SESSION['AppSettings']['login']['id']
			: null;
		if (is_null($userId)) {
			return '0.00';
		}
		$aCommission = $db->query('
			SELECT
				commission
			FROM
				hb_commission
			WHERE
				owner_id = :owner_id
		', array(
			':owner_id' => $userId,
		))->fetchAll();
		
		if (count($aCommission)) {
			return isset($aCommission[0]['commission']) ? $aCommission[0]['commission'] : '0.00';
		} else {
			return '0.00';	
		}
	}
	
	function getTotalWithdrawn()
	{
		$db         = hbm_db();
		$userId = isset($_SESSION['AppSettings']['login']['id'])
		? $_SESSION['AppSettings']['login']['id']
		: null;
		if (is_null($userId)) {
			return '0.00';
		}
		$aCommission = $db->query('
			SELECT
				withdrawn
			FROM
				hb_commission
			WHERE
				owner_id = :owner_id
		', array(
			':owner_id' => $userId,
		))->fetchAll();
		
		if (count($aCommission)) {
			return isset($aCommission[0]['commission']) ? $aCommission[0]['commission'] : '0.00';
		} else {
			return '0.00';
		}
	}
	
	function getReportDate()
	{
		$db         = hbm_db();
		$userId = isset($_SESSION['AppSettings']['login']['id'])
		? $_SESSION['AppSettings']['login']['id']
		: null;
		if (is_null($userId)) {
			return array();
		}
		
		$aReportDate = $db->query('
			SELECT
				date
			FROM
				hb_commission_summery
			WHERE
				owner_id = :owner_id
			GROUP BY
				date
		', array(':owner_id' => $userId))->fetchAll();
		
		$aResuft = array();
		if (count($aReportDate)) {
			foreach ($aReportDate as $k => $v) {
				array_push($aResuft, $v['date']);
			}
		}
		
		return $aResuft;
	}
	
	function getReports($date)
	{
		$db         = hbm_db();
		$userId = isset($_SESSION['AppSettings']['login']['id'])
			? $_SESSION['AppSettings']['login']['id']
			: null;
		if (is_null($userId)) {
			return array();
		}
		$aResults = array();
		
		$aSummery = $db->query('
			SELECT
				cs.invoice_id AS invoice_id, cs.totel AS totel, cs.commission AS commission
				, cs.payment_status AS payment_status, cs.product_cat AS product_cat
			FROM
				hb_commission_summery AS cs
			WHERE
				cs.owner_id = :owner_id
				AND cs.date = :date
				
		', array(
			':owner_id' => $userId, ':date' => $date
		))->fetchAll();

		
		if (count($aSummery)) {
			foreach ($aSummery as $k => $v) {
				$aHistory = $db->query('
					SELECT 
						ch.active_customers AS active_customers, ch.resold_acct AS resold_acct, ch.totel AS total_history
						, rc.hostname AS servername, ca.email AS resellername
					FROM
						hb_commission_history AS ch
						, hb_res_cpservers AS rc
						, hb_client_access AS ca
					WHERE
						ch.invoice_id = :invoice_id
						AND ch.owner_id = :owner_id
						AND ch.cpserver_id = rc.cpserver_id
						AND ch.usr_id = ca.id
						AND ch.product_cat = :product_cat
				', array(
					':invoice_id' => $v['invoice_id']
					, ':owner_id' => $userId
					, ':product_cat' => $v['product_cat']
				))->fetchAll();
				//return $aHistory;
				if (empty($aResults[$v['product_cat']])) {
					$aResults[$v['product_cat']] = array();
				}

				foreach ($aHistory as $kh => $vh) {
					if (empty($aResults[$v['product_cat']][$vh['resellername']])) {
						$oldCommission = isset($aResults[$v['product_cat']][$vh['resellername']]['commission']) 
							? $aResults[$v['product_cat']][$vh['resellername']]['commission']
							: 0;
						$aResults[$v['product_cat']][$vh['resellername']] = array(
							'commission' => 0,
							'history' => array()
						);
					}
					
					if (isset($v['commission'])) {
						$oldCommission = isset($aResults[$v['product_cat']][$vh['resellername']]['commission'])
							? $aResults[$v['product_cat']][$vh['resellername']]['commission']
							: 0;
						$aResults[$v['product_cat']][$vh['resellername']]['commission'] = $oldCommission + $v['commission'];
					}
					if ($v['product_cat'] == 2) {
						$aResults[$v['product_cat']][$vh['resellername']]['history'][] = array(
							'servername' =>  $vh['servername'],
							'active_customers' => $vh['active_customers'],
							'resold_acct' => $vh['resold_acct'],
							'total_history' => $vh['total_history'],
							'payment_status' => $v['payment_status']
						);
					} else if ($v['product_cat'] == 1) {
						if (empty($aResults[$v['product_cat']][$vh['resellername']]['history'][$vh['servername']])) {
							$aResults[$v['product_cat']][$vh['resellername']]['history'][$vh['servername']] = array(
								'servername' =>  $vh['servername'],
								'active_customers' => 0,
								'resold_acct' => 0,
								'total_history' => 0,
								'payment_status' => 'Paid',
							);
						}
						
						$aResults[$v['product_cat']][$vh['resellername']]['history'][$vh['servername']]['resold_acct'] = $aResults[$v['product_cat']][$vh['resellername']]['history'][$vh['servername']]['resold_acct'] + 1;
						$aResults[$v['product_cat']][$vh['resellername']]['history'][$vh['servername']]['total_history'] = $aResults[$v['product_cat']][$vh['resellername']]['history'][$vh['servername']]['total_history'] + $vh['total_history'];
						
					}
				}
			}
		}
		return $aResults;
	}
}