<?php
$db         = hbm_db();
$services   = $this->get_template_vars('services');
$array;

if($services[0]['catname'] == 'RV2Factor'){
	require_once( APPDIR_MODULES . "Other/billingcycle/api/class.billingcycle_controller.php");
	foreach($services as $service){
		if($service['catname'] == 'RV2Factor'){
			$aParam = array('accountId'=>$service['id'],'nextDue'=>$service['next_due']);
			$aExpire  = billingcycle_controller::getAccountExpiryDate($aParam);

			$result    = $db->query("
					SELECT ac.qty
					FROM hb_config2accounts ac
					JOIN hb_config_items_cat f ON (ac.account_id=:aid AND ac.config_cat=f.id)
					JOIN hb_config_items_types t ON (t.id=f.type)
					WHERE !(f.options & 4) AND ac.`rel_type`='Hosting'
					",array(':aid' => $service['id']))->fetch();
			if($result){
				$service['qty'] = $result['qty'];
			}
			else{
				$service['qty'] = 1;
			}

			if($aExpire[1]['expire']!= '')
				$service['next_due'] = $aExpire[1]['expire'];
			$array[] = $service;

		}

	}



	$statChk = 0;
	foreach($array as $key => $value){
		$getAccountDetail = $db->query("
				SELECT
				*
				FROM
				hb_accounts
				WHERE
				id = :acctId
				", array(
						':acctId' => $value['id']
				)
		)->fetch();
		$array[$key]['next_due'] = $getAccountDetail['next_due'];
		if($getAccountDetail['status'] == 'Active' && date('Y-m-d') > $getAccountDetail['next_due'] && $value['product_id'] != 58){
			$array[$key]['status'] = 'Expired';
			$statChk = 1;
		}
		if($statChk == 1 && $value['product_id'] == 58){
			$array[$key]['status'] = 'Expired';
		}
	}

	$this->assign('services', $array);
}

//FIND IS MODULE SSL?
$opdetails = $this->get_template_vars('opdetails');
if($opdetails['slug'] == 'ssl'){
	$clientData		= $this->get_template_vars('clientdata');
	$clientId 		= $clientData['id'];
	$sortWhere = '';

	if(isset($_GET['sort'])){
		switch($_GET['sort']){
			case 'active':
			case 'expire':
			case 'incomplete':
			case 'unpaid':
			case 'terminate':
				$sortAccount = $this->get_template_vars('ssl_side_sort');
				foreach($sortAccount as $acctId){
					if($sortWhere == ''){
						$sortWhere = "AND ( a.id = {$acctId} ";
					} else {
						$sortWhere .= "OR a.id = {$acctId} ";
					}
				}
				if($sortWhere != ''){
					$sortWhere .= ' )';
				}
		}
	}

	$order_by = 'a.id DESC';
	if(isset($_GET['orderby'])){
		$orderby = $_GET['orderby'];
		$sort_type = $_GET['sort_type'];

		switch($orderby){
			case 'name': $order_by = 'p.name ' . $sort_type; break;
			case 'account_status': $order_by = 'a.status ' . $sort_type; break;
			case 'symantec_status': $order_by = 'sslo.symantec_status ' . $sort_type; break;
			case 'total': $order_by = 'a.total ' . $sort_type; break;
			case 'next_due': $order_by = 'a.next_due ' . $sort_type; break;
			case 'account_id': $order_by = 'a.id ' . $sort_type; break;
			default : $order_by = 'a.id DESC';
		}
	}

	$allservices = $db->query("
			SELECT
				a.id
				, a.product_id
				, a.domain
				, i.subtotal AS total
				, a.status
				, a.billingcycle
				, a.next_due
				, c.name
				, c.slug
				, sslo.symantec_status
				, p.name
			FROM
				hb_accounts AS a
				, hb_orders AS o
				, hb_invoices AS i
				, hb_products_modules AS pm
				, hb_modules_configuration AS mc
				, hb_categories AS c
				, hb_products AS p
				, hb_ssl_order AS sslo
			WHERE
				a.order_id = o.id
				AND a.client_id  = {$clientId}
				AND o.invoice_id = i.id
				AND a.product_id = p.id
				AND a.product_id = pm.product_id
				AND pm.module = mc.id
				AND mc.module = 'ssl'
				AND c.id = p.category_id
				AND sslo.order_id = o.id
				{$sortWhere}
			ORDER BY {$order_by}
	")->fetchAll();

	if($sortWhere != ''){
		$services = $allservices;
	}

	$serviceCount = count($allservices);

	$this->assign('request_url', $_SERVER['REQUEST_URI']);

	$paginate = (isset($_POST['service_page'])) ? $_POST['service_page'] : 1;
	$this->assign('paginateSSL', $paginate);

	if(isset($_POST['search']) && $_POST['search'] != ''){
		$searchText = trim(strtolower($_POST['search']));
		if($searchText == 'processing'){
			$searchText = 'pending';
		}
		$searchText = str_replace("*", '\*', str_replace(".", '\.', addslashes(stripslashes($searchText))));
		$chkKey = array('id', 'product_id', 'domain', 'total', 'status', 'billingcycle', 'next_due', 'name', 'slug', 'symantec_status');
		foreach($allservices as $eachKey => $eachVal){
			$none = true;
			foreach($chkKey as $chk){
				if($chk == 'next_due' && $eachVal[$chk] != 0){
					$eachVal[$chk] = date('d M Y', strtotime($eachVal[$chk]));
				}
				if(preg_match("/{$searchText}/", strtolower($eachVal[$chk]))){
					$none = false;
				}
			}
			if($none && isset($allservices[$eachKey])){
				unset($allservices[$eachKey]);
			}
		}
		$services = array_values($allservices);
		$this->assign('services', $services);
	}

	$startLimit = (25*$paginate)-25;
	$endLimit = 25;
	if(empty($_POST['search'])){
		$services = $db->query("
				SELECT
					a.id
					, a.product_id
					, a.domain
					, i.subtotal AS total
					, a.status
					, a.billingcycle
					, a.next_due
					, c.name
					, c.slug
					, sslo.symantec_status
					, p.name
				FROM
					hb_accounts AS a
					, hb_orders AS o
					, hb_invoices AS i
					, hb_products_modules AS pm
					, hb_modules_configuration AS mc
					, hb_categories AS c
					, hb_products AS p
					, hb_ssl_order AS sslo
				WHERE
					a.order_id = o.id
					AND a.client_id  = {$clientId}
					AND o.invoice_id = i.id
					AND a.product_id = p.id
					AND a.product_id = pm.product_id
					AND pm.module = mc.id
					AND mc.module = 'ssl'
					AND c.id = p.category_id
					AND sslo.order_id = o.id
					{$sortWhere}
				ORDER BY {$order_by}
				LIMIT {$startLimit}, {$endLimit}
		")->fetchAll();
	} else if(isset($_POST['search'])){
		$serviceCount = count($services);
		$count = 0;
		$newServices = array();
		for($i = $startLimit; ($count < count($services) && $count < 25); $i++){
			$newServices[] = $services[$i];
			$count++;
		}
		$services = $newServices;
	}

	$this->assign('service_count', $serviceCount);
	$this->assign('service_page', ceil($serviceCount/25));
	$this->assign('services', $services);

	$clientData		= $this->get_template_vars('clientdata');
	$clientEmail = $clientData['email'];
	$statMailList = array( 'internal@netway.co.th');
	if(!in_array($clientEmail, $statMailList) && empty($_SESSION['AppSettings']['admin_login'])){
		$mode = (file_exists(HBFDIR_LIBS . 'RvLibs/SSL/developer.php')) ? 'demo' : 'real';
		$this->assign('ga_mode', $mode);
	}
}

?>