<?php
class rv_ssl_controller extends HBController
{
    protected $aSubmenuList = array(
        'find_order' => array(
            'name' => 'Find Account(s) by Authority Order ID',
            'action' => 'find_order',
            'desc' => 'ค้นหา Account(s) จากค่า Authority Order ID',
        ),
        'ssl_details' => array(
            'name' => 'Edit SSL Details',
            'action' => 'edit_ssl_details',
            'desc' => 'แก้ไขข้อมูลรายละเอียด SSL',
        ),
        'def_res_price' => array(
            'name' => 'Edit Recommend Price',
            'action' => 'edit_recommend_price',
            'desc' => 'กำหนดค่าราคาแนะนำในการขาย SSL ให้กับ Reseller',
        ),
        'rate_exchange' => array(
            'name' => 'Edit Rate Exchange',
            'action' => 'edit_rate_exchange',
            'desc' => 'กำหนดอัตราแลกเปลี่ยนของสกุลเงินต่างๆ โดยเที่ยบกับสกุลเงิน USD',
        ),
    	'email_template' => array(
    		'name' => 'Manage Email Template',
    		'action' => 'manage_email_template',
    		'desc' => 'ตั้งค่า email template ให้กับ action ต่างๆ',
    	),
    	'cron_update_status' => array(
    		'name' => 'Cron update status log',
    		'action' => 'cron_update_log',
    		'desc' => 'ตรวจสอบการทำงานของ cron update status',
    	),
    	'get_order_by_date_range' => array(
    		'name' => 'Get Orders By Date Range',
    		'action' => 'get_order_by_date_range',
    		'desc' => 'list order โดยเลือกช่วง วัน-เวลา'
    	),
    	'integrate_old_ssl' => array(
    		'name' => 'Integrate Old SSL order',
    		'action' => 'integrate_old_ssl',
    		'desc' => 'ดึงข้อมูล order เก่าด้วย partner order id'
    	),
    	'get_hb_ssl_order' => array(
    		'name' => 'Get HostBill RVSSL orders',
    		'action' => 'get_hb_ssl_order',
    		'desc' => 'แสดง JSON ของข้อมูล rvssl order บน Hostbill'
    	),
    	'annoucements_management' => array(
    		'name' => 'Annoucements Management',
    		'action' => 'annoucements_management',
    		'desc' => 'จัดการ ประกาศ บน RVssl WHMCS Addon'
    	)
    );

    private function _assignDefaultVars()
    {
    	if($_SESSION['AppSettings']['admin_login']['username'] != 'natdanai@rvglobalsoft.com'){
    		unset($this->aSubmenuList['check_cert_expire']);
    		unset($this->aSubmenuList['get_hb_ssl_order']);
    	}
        $this->template->assign('submenuList', $this->aSubmenuList);
    }

    public function _default($request)
    {
        $this->_assignDefaultVars();
        $this->template->render(APPDIR_MODULES.'Other'.'/rv_ssl/template/admin/default.tpl',$request,true);
    }

    public function find_order($request)
    {
        $aResults = array();
        $db = hbm_db();
        if (isset($request['partner_id']) && $request['partner_id'] != '') {
            $aResults = $db->query("
                SELECT
                    ac.id AS accounts_id,
                    ac.product_id AS product_id,
                    ac.billingcycle AS billingcycle,
                    ac.status AS status,
                    so.symantec_status AS symantec_status,
                    so.authority_orderid AS symantec_order_id,
                    so.partner_order_id AS partner_order_id,
                    so.commonname AS commonname,
                    so.ssl_id AS ssl_id,
                    sl.ssl_name AS ssl_name,
                    ac.client_id AS client_id,
                    cd.firstname AS firstname,
                    cd.lastname AS lastname
                FROM
                    hb_ssl_order AS so,
                    hb_ssl AS sl,
                    hb_accounts AS ac,
                    hb_client_details AS cd
                WHERE
                    so.order_id = ac.order_id
                    AND so.ssl_id = sl.ssl_id
                    AND ac.client_id = cd.id
                    AND so.authority_orderid LIKE :symantec_order_id
                ", array(
                    ':symantec_order_id' => '%'.$request['partner_id'].'%'
                ))->fetchAll();
        }

        $this->_assignDefaultVars();
        $this->template->assign('results', $aResults);
        $this->template->assign('cResults', count($aResults));
        $this->template->render(APPDIR_MODULES.'Other'.'/rv_ssl/template/admin/find_order.tpl',$request,true);
    }

    public function edit_ssl_details($request)
    {
        $aResults = array();
        $db = hbm_db();
        if ($request['do_edit'] == 'do_edit') {
            foreach ($request['detail'] as $ssl_id => $aValue) {
                $query = $db->query("
                    UPDATE
                        hb_ssl
                    SET
                        ssl_authority_id =:ssl_authority_id
                        , ssl_validation_id =:ssl_validation_id
                        , ssl_productcode =:ssl_productcode
                		, ssl_contract_id =:ssl_contract_id
                        , ssl_assurance =:ssl_assurance
                        , green_addressbar =:green_addressbar
                        , secure_subdomain =:secure_subdomain
                        , secureswww =:secureswww
                        , licensing_multi_server =:licensing_multi_server
                        , malware_scan =:malware_scan
                		, strongest_security = :strongest_security
                		, free_reissue = :free_reissue
                		, support_for_san =:support_for_san
                		, san_startup_domains =:san_startup_domains
                		, san_max_domains =:san_max_domains
                		, san_max_servers =:san_max_servers
                    WHERE ssl_id = :ssl_id", array(
                        ':ssl_id'                   => $ssl_id
                        , ':ssl_authority_id'       => $aValue['ssl_authority_id']
                        , ':ssl_validation_id'      => $aValue['ssl_validation_id']
                        , ':ssl_productcode'        => $aValue['ssl_productcode']
                    	, ':ssl_contract_id'		=> $aValue['ssl_contract_id']
                        , ':ssl_assurance'          => $aValue['ssl_assurance']
                        , ':green_addressbar'       => $aValue['green_addressbar']
                        , ':secure_subdomain'       => $aValue['secure_subdomain']
                        , ':secureswww'             => $aValue['secureswww']
                        , ':licensing_multi_server' => $aValue['licensing_multi_server']
                        , ':malware_scan'           => $aValue['malware_scan']
                    	, ':strongest_security'		=> $aValue['strongest_security']
                    	, ':free_reissue'			=> $aValue['free_reissue']
                    	, ':support_for_san'		=> $aValue['support_for_san']
                    	, ':san_startup_domains'	=> $aValue['san_startup_domains']
                    	, ':san_max_domains'		=> $aValue['san_max_domains']
                    	, ':san_max_servers'		=> $aValue['san_max_servers']
                    ));
            }
            $this->template->assign('onUpdate', true);
        } else if($request["do_action"] == "edit_option"){
        	$aSSLOptionsNew = $request["editopt"];
        	$aSSLOptions = $db->query("SELECT value FROM hb_ssl_other_settings WHERE name = 'edit_detail_options'", array())->fetchAll();
        	$aSSLOptions = unserialize($aSSLOptions[0]["value"]);
        	$keyList = array();
        	foreach($aSSLOptions as $kchk => $vchk){
        		$keyList[] = $kchk;
        	}
        	foreach($aSSLOptionsNew as $k => $v){
        		if(isset($v["this_is_key"]) && isset($v["this_is_val"])){
        			$newArray = array_combine($v["this_is_key"], $v["this_is_val"]);
        			unset($aSSLOptionsNew[$k]["this_is_key"], $aSSLOptionsNew[$k]["this_is_val"], $v["this_is_key"], $v["this_is_val"]);
        			foreach($v as $vk => $vv){
        				$newArray[$vk] = $vv;
        			}
        			$aSSLOptionsNew[$k] = $newArray;
        		}
        	}
        	foreach($keyList as $ek){
        		if(empty($aSSLOptionsNew[$ek])){
        			$aSSLOptionsNew[$ek] = array();
        		}
        	}
        	$db->query("UPDATE hb_ssl_other_settings SET value = :val WHERE name = 'edit_detail_options'", array(":val" => serialize($aSSLOptionsNew)));
        }
        $aSSLOptions = $db->query("SELECT value FROM hb_ssl_other_settings WHERE name = 'edit_detail_options'", array())->fetchAll();
        $aSSLDetail = $db->query("SELECT * FROM hb_ssl ORDER BY ssl_authority_id", array())->fetchAll();
        $aAuthority = $db->query("SELECT ssl_authority_id, authority_name FROM hb_ssl_authority", array())->fetchAll();
        $aValidation = $db->query("SELECT ssl_validation_id, validation_name FROM hb_ssl_validation", array())->fetchAll();
        $aAssurance = array('Low', 'Medium', 'High', 'Very High', 'Highest');
        $aKeyLength = array('2048-bit');
        $aEncryption  = array('128/256bit', 'Up to 256-bit');
        $this->_assignDefaultVars();
        $aSSLOptions = unserialize($aSSLOptions[0]["value"]);
        $this->template->assign('aSSLOptions', $aSSLOptions);
        $this->template->assign('aSSLDetail', $aSSLDetail);
        $this->template->assign('aAuthority', $aAuthority);
        $this->template->assign('aValidation', $aValidation);
        $this->template->assign('aAssurance', $aAssurance);
        $this->template->assign('aKeyLength', $aKeyLength);
        $this->template->assign('aEncryption', $aEncryption);
        $this->template->render(APPDIR_MODULES.'Other'.'/rv_ssl/template/admin/ssl_details.tpl',$request,true);
    }

    public function update_recommend_price($id, $contract, $type, $initial, $renewal)
    {
    	$db = hbm_db();
    	$chk = $db->query("SELECT * FROM hb_ssl_recommend_price WHERE ssl_id = :ssl_id AND contract = :contract AND type = :type", array(":ssl_id" => $id, ":contract" => $contract, ":type" => $type))->fetch();
    	if($chk){
    		$query = $db->query("
    				UPDATE
    					hb_ssl_recommend_price
    				SET
    					initial_price = :initial_price
    					, renewal_price = :renewal_price
    				WHERE
    					ssl_id = :ssl_id
    					AND contract = :contract
    					AND type = :type
    				", array(
    					':ssl_id' => $id,
    					':contract' => $contract,
    					':initial_price' => $initial,
    					':renewal_price' => $renewal,
    					':type' => $type
    				));
    	} else {
    		$query = $db->query("
    				INSERT INTO
    					hb_ssl_recommend_price (`ssl_id`, `type`, `contract`, `initial_price`, `renewal_price`)
    				VALUES
    					(:ssl_id, :type, :contract, :initial_price, :renewal_price)
    				", array(
    					":ssl_id" => $id
    					, ":type" => $type
    					, ":contract" => $contract
    					, ":initial_price" => $initial
    					, ":renewal_price" => $renewal
    		));
    	}
    }

    public function edit_recommend_price($request)
    {

        $aSSLDetails = array();
        $db = hbm_db();

        if ($request['do_edit'] == 'do_edit') {
            foreach ($request['price'] as $id => $aContract) {
                foreach ($aContract as $contract => $aPrice) {
                	$this->update_recommend_price($id, $contract, "product", $aPrice["initial_price"], $aPrice["renewal_price"]);

                    if(isset($aPrice['addon'])){
                    	$this->update_recommend_price($id, $contract, "addon", $aPrice["addon"]["initial_price"], $aPrice["addon"]["renewal_price"]);
                    }
                }
            }
        }

        $aSSL = $db->query("
            SELECT
                sl.ssl_id AS ssl_id
                , sl.ssl_name AS ssl_name
                , rp.contract AS contract
                , rp.initial_price AS initial_price
                , rp.renewal_price AS renewal_price
                , pr.id AS id
            FROM
                hb_ssl AS sl
                , hb_ssl_recommend_price AS rp
                , hb_products AS pr
            WHERE
                rp.ssl_id = sl.ssl_id
                AND sl.ssl_name = pr.name
        		AND rp.type = 'product'
            ORDER BY
                sl.ssl_authority_id, sl.ssl_name", array())->fetchAll();

        $aContract = array('12', '24', '36');

        $aSSLRecPriceDB = $db->query("SELECT * FROM hb_ssl_recommend_price WHERE type = 'product'", array())->fetchAll();

        $aSSLRecPrice = $aSSLPriceDetails = array();
        foreach ($aSSLRecPriceDB as $aVal) {
            if ( ! isset($aSSLRecPrice[$aVal['ssl_id']]) ) {
                $aSSLRecPrice[$aVal['ssl_id']] = array();
            }
            if ( ! isset($aSSLRecPrice[$aVal['ssl_id']][$aVal['contract']]) ) {
                $aSSLRecPrice[$aVal['ssl_id']][$aVal['contract']] = array('initial_price' => $aVal['initial_price'], 'renewal_price' => $aVal['renewal_price']);
            }
        }

        foreach ($aSSL as $aVal) {
            if ($aVal['contract'] > 36) continue;

            if ( ! isset($aSSLPriceDetails[$aVal['ssl_id']])) {
            	$inner = array('initial_price' => '', 'renewal_price' => '', 'costs' => '0.00');
            	$sample = array('12' => $inner, '24' => $inner, '36' => $inner);
                $aSSLPriceDetails[$aVal['ssl_id']] = array('ssl_id' => $aVal['ssl_id'], 'ssl_name' =>  $aVal['ssl_name'], 'contract' => $sample, 'addon' => $sample);
            }

            if(in_array($aVal['contract'], $aContract)){
                $aSSLPriceDetails[$aVal['ssl_id']]['contract'][$aVal['contract']] = array(
                    'initial_price' => $aSSLRecPrice[$aVal['ssl_id']][$aVal['contract']]['initial_price'],
                    'renewal_price' => $aSSLRecPrice[$aVal['ssl_id']][$aVal['contract']]['renewal_price'],
                    'costs' => $this->_get_ssl_costs($aVal['id'], $aVal['contract']),
                );

                $aSSLPriceDetails[$aVal['ssl_id']]['addon'][$aVal['contract']] = array(
                	'initial_price' => '',
                	'renewal_price' => '',
                	'costs' => $this->_get_san_costs($aVal['id'], $aVal['contract'])
                );

                if($aSSLPriceDetails[$aVal['ssl_id']]['addon'][$aVal['contract']]['costs'] != '0.00'){
                	$getRecommendAddon = $db->query("
                			SELECT
                				initial_price
                				, renewal_price
                			FROM
                				hb_ssl_recommend_price
                			WHERE
                				ssl_id = :ssl_id
                				AND type = 'Addon'
                				AND contract = :contract
                	", array(':ssl_id' => $aVal['ssl_id'], ':contract' => $aVal['contract']))->fetch();

                	$aSSLPriceDetails[$aVal['ssl_id']]['addon'][$aVal['contract']]['initial_price'] = isset($getRecommendAddon['initial_price']) ? $getRecommendAddon['initial_price'] : '';
                	$aSSLPriceDetails[$aVal['ssl_id']]['addon'][$aVal['contract']]['renewal_price'] = isset($getRecommendAddon['renewal_price']) ? $getRecommendAddon['renewal_price'] : '';
                }
            }
        }

        $this->_assignDefaultVars();
        $this->template->assign('aSSLPriceDetails', $aSSLPriceDetails);
        $this->template->render(APPDIR_MODULES.'Other'.'/rv_ssl/template/admin/recommend_price.tpl',$request,true);
    }

    private function _get_reccommend($ssl_id, $contract, $type='initial_price')
    {
        $db = hbm_db();
        $aSSLPrice = $db->query("SELECT initial_price, renewal_price FROM hb_ssl_recommend_price WHERE ssl_id=:ssl_id AND contract=:contract", array(':ssl_id' => $ssl_id, ':contract' =>  $contract))->fetch();
        return (isset($aSSLPrice[$type])) ? $aSSLPrice[$type] : '0.00';
    }

    private function _get_san_costs($id, $contract)
    {
    	$db = hbm_db();
    	switch($contract){
    		case '12':
    		case 12:
    			$addonPrice = $db->query("SELECT c.a AS cost FROM hb_addons AS a , hb_common AS c WHERE c.id = a.id AND c.rel = 'Addon' AND (a.products LIKE '%,{$id},%' OR a.products LIKE '%,{$id}')")->fetch();
    			break;
    		case '24':
    		case 24:
    			$addonPrice = $db->query("SELECT c.b AS cost FROM hb_addons AS a , hb_common AS c WHERE c.id = a.id AND c.rel = 'Addon' AND (a.products LIKE '%,{$id},%' OR a.products LIKE '%,{$id}')")->fetch();
    			break;
    		case '36':
    		case 36:
    			$addonPrice = $db->query("SELECT c.t AS cost FROM hb_addons AS a , hb_common AS c WHERE c.id = a.id AND c.rel = 'Addon' AND (a.products LIKE '%,{$id},%' OR a.products LIKE '%,{$id}')")->fetch();
    			break;
    	}
    	if(!$addonPrice){
    		$addonPrice['cost'] = '0.00';
    	}

    	return $addonPrice['cost'];
    }

    private function _get_ssl_costs($id, $contract)
    {
        $db = hbm_db();
        switch ($contract)
        {
            case '12':
            case 12:
                $aSSLPrice = $db->query("SELECT a AS cost FROM hb_common WHERE id=:id AND rel = 'Product'", array(':id' => $id))->fetch();
                break;
            case '24':
            case 24:
                $aSSLPrice = $db->query("SELECT b AS cost FROM hb_common WHERE id=:id AND rel = 'Product'", array(':id' => $id))->fetch();
                    break;
            case '36':
            case 36:
                $aSSLPrice = $db->query("SELECT t AS cost FROM hb_common WHERE id=:id AND rel = 'Product'", array(':id' => $id))->fetch();
            break;
        }
        return $aSSLPrice['cost'];
    }

    public function edit_rate_exchange($request)
    {
        $db = hbm_db();
        if ($request['do_edit'] == 'do_edit') {
            foreach ($request['rate'] as $code => $rate) {
                $query = $db->query("
                    UPDATE
                        hb_rvg_currencies
                    SET
                        rate = :rate
                    WHERE
                        code = :code
                ", array(
                    ':rate' => $rate,
                    ':code' => $code
                ));
            }
        }
        $aCurrency = $db->query("SELECT * FROM hb_rvg_currencies ORDER BY code", array())->fetchAll();
        $this->_assignDefaultVars();
        $this->template->assign('aCurrency', $aCurrency);
        $this->template->render(APPDIR_MODULES.'Other'.'/rv_ssl/template/admin/rate_exchange.tpl',$request,true);
    }

    public function manage_email_template($request)
    {
    	$db = hbm_db();
    	require_once HBFDIR_LIBS . 'RvLibs/SSL/PHPLibs.php';
    	$oAuth =& RvLibs_SSL_PHPLibs::singleton();

    	$libEmail = $oAuth->get_email_template();
    	$aEmailSetting = $db->query("SELECT * FROM hb_ssl_email_templates")->fetchAll();
    	$aEmailAll = $db->query("SELECT id, subject FROM hb_email_templates")->fetchAll();
//     	$aCurrency = $db->query("SELECT * FROM hb_rvg_currencies ORDER BY code", array())->fetchAll();
    	$this->_assignDefaultVars();
//     	$this->template->assign('aCurrency', $aCurrency);
    	$this->template->assign('aEmailAll', $aEmailAll);
    	$this->template->assign('aEmailAllJSON', str_replace('\'', '\\\'', json_encode($aEmailAll)));
    	$this->template->assign('aEmailAllRow', sizeof($aEmailAll));
    	$this->template->assign('aEmailSetting', $aEmailSetting);
    	$this->template->assign('aEmailSettingJSON', str_replace('\'', '\\\'', json_encode($aEmailSetting)));
    	$this->template->assign('aEmailSettingRow', sizeof($aEmailSetting));
    	$this->template->assign('libEmail', $libEmail);
//     	echo '<pre>'; print_r($libEmail); echo '</pre>';
    	$this->template->render(APPDIR_MODULES.'Other'.'/rv_ssl/template/admin/manage_email_template.tpl',$request,true);
    }

    public function chk_next_due($request)
    {
    	$db = hbm_db();
    	$aAccounts = $db->query("SELECT a.id, a.next_due FROM hb_accounts AS a, hb_products_modules AS pm, hb_modules_configuration AS mc WHERE a.status = 'Active' AND a.product_id = pm.product_id AND pm.module = mc.id AND mc.module = 'ssl'")->fetchAll();
    	$this->_assignDefaultVars();
    	//     	$this->template->assign('aCurrency', $aCurrency);
    	$this->template->assign('aAccounts', $aAccounts);
    	$this->template->assign('aAccountsJSON', str_replace('\'', '\\\'', json_encode($aAccounts)));
    	$this->template->assign('aAccountsRow', sizeof($aAccounts));
    	$this->template->render(APPDIR_MODULES.'Other'.'/rv_ssl/template/admin/chk_next_due.tpl',$request,true);
    }

    public function cron_update_log($request)
    {
    	$db = hbm_db();
    	$chk = array();
    	$output = array();

    	if(isset($_POST['limit-edit']) && $_POST['limit-edit'] > 0){
   			$db->query("UPDATE `hb_ssl_other_settings` SET value = '{$_POST['limit-edit']}' WHERE `name`='cron_update_status'");
    	}

    	$condition = "name = 'Module - SSL : Status Updater, every run' OR name = 'Module - RV SSL Management, every run'";
    	$limit = $db->query("SELECT value FROM hb_ssl_other_settings WHERE name = 'cron_update_status'")->fetch();
//     	$cronTask = $db->query("SELECT metadata FROM hb_cron_tasks WHERE {$condition}")->fetch();
//     	$metadata = json_decode($cronTask['metadata'], 1);

//     	foreach($metadata as $k => $v){
//     		$chk[$k] = $v['lastrun'];
//     	}

//     	arsort($chk);

//     	foreach($chk as $kk => $vv){
//     		$output[$kk] = $metadata[$kk];
//     	}
    	$cronTask = $db->query("
    			SELECT
        			hso.order_id
        			, ha.id AS account_id
    				, hso.last_updated
    				, hso.commonname
    				, hso.symantec_status
    				, hso.cert_status
    				, ha.status
    				, hc.firstname
    				, hc.lastname
        		FROM
        			hb_ssl_order AS hso
        			, hb_accounts AS ha
        			, hb_invoices AS hi
        			, hb_orders AS ho
    				, hb_client_details AS hc
        		WHERE
        			ha.order_id = hso.order_id
        			AND ha.status != 'Terminated'
        			AND ha.status != 'Cancelled'
        			AND ho.id = ha.order_id
        			AND ho.invoice_id = hi.id
        			AND hi.status = 'Paid'
        			AND hso.partner_order_id != ''
    				AND ha.client_id = hc.id
        			AND (
        					(
        						hso.cron_update = 1
        					) OR (
        						hso.csr != ''
        						AND ho.id = ha.order_id
        						AND ho.invoice_id = hi.id
        						AND hso.authority_orderid = ''
        					)
        			)
        		ORDER BY hso.last_updated")->fetchAll();

    	$cronQuery = $db->query("
	        SELECT
	        	id
	        FROM
	        	hb_modules_configuration
	        WHERE
	        	module LIKE '%ssl%'
	        	AND type = 'Other'
        ")->fetchAll();

    	$cronTaskList = array();

    	foreach($cronQuery as $v){
    		$query = false;
    		$query = $db->query("SELECT name, lastrun FROM hb_cron_tasks WHERE task LIKE '%{$v['id']}%'")->fetch();
    		if($query){
    			$cronTaskList[] = array('name' => $query['name'], 'lastrun' => date('d M Y H:i:s', strtotime($query['lastrun'])-3600));
    		}
    	}

    	$this->_assignDefaultVars();
    	$this->template->assign('limit', $limit['value']);
    	$this->template->assign('aData', $cronTask);
    	$this->template->assign('cronTask', $cronTaskList);
    	$this->template->render(APPDIR_MODULES.'Other'.'/rv_ssl/template/admin/cron_update_log.tpl',$request,true);
    }

    public function integrate_old_ssl($request)
    {
    	$client         = hbm_logged_client();
    	require_once(HBFDIR_LIBS . 'RvLibs/SSL/PHPLibs.php');
    	$oAuth =& RvLibs_SSL_PHPLibs::singleton();
    	$db = hbm_db();

    	$partnerOrderId = $request['partnerOrderId'];
    	if($request['partnerOrderId'] && empty($request['integrateId'])){
    		$options = $this->getOrderByPartnerOrderIdFullOptions();
    		$response = $oAuth->getOrderByPartnerOrderID($partnerOrderId, $options);
    		$this->template->assign('getorderResponse', $response);
    		if($response['status']['symantec']){
    			$domain = $response['details']['orderInfo']['DomainName'];
    			$getAccount = $this->getAccountByDomain($domain);
    		}
    	} else if($request['integrateId']){
    		$accountId = $request['integrateId'];
    		$orderId = $request['orderId'];
    		$clientId = $request['clientId'];
    		$options = $this->getOrderByPartnerOrderIdFullOptions();
    		$response = $oAuth->getOrderByPartnerOrderID($partnerOrderId, $options);

    		$orderDetail = $response['details'];
    		$domainName = $orderDetail['orderInfo']['DomainName'];
    		$this->template->assign('getorderResponse', $response);


    		if(isset($orderDetail['orderContacts'])){

    			$contactData[0] = $this->generateContact($orderDetail['quickOrderDetail']['OrganizationInfo'], 0);
    			$contactData[1] = $this->generateContact($orderDetail['orderContacts']['AdminContact'], 1);
    			$contactData[2] = $this->generateContact($orderDetail['orderContacts']['TechContact'], 2);

    			$this->updateContact($contactData, $orderId, $clientId, $domainName);
    		}
    		$update = $this->updateOrder($orderId, $clientId, $orderDetail, $partnerOrderId);

//     		echo '<pre>';
//     		print_r($contactData);
//     		print_r($orderDetail);
//     		echo '</pre>';
    		$this->template->assign('update', $update);

    		$getAccount = $this->getAccountByDomain($domain);
    	}

    	$this->_assignDefaultVars();
    	$this->template->assign('partnerOrderId', $partnerOrderId);
    	$this->template->render(APPDIR_MODULES . 'Other' . '/rv_ssl/template/admin/integrate_old_ssl.tpl', $request, true);
    }

    public function getAccountByDomain($domain)
    {
    	$db = hbm_db();
    	$getAccount = $db->query("
    			SELECT
    				*
    			FROM
	    			hb_accounts AS a
	    			, hb_ssl_order AS so
    			WHERE
	    			a.domain = '{$domain}'
	    			AND a.order_id = so.order_id
    	")->fetchAll();
    	$this->template->assign('aData', $getAccount);
    	return $getAccount;
    }

    public function getOrderByPartnerOrderIdFullOptions()
    {
    	return array(
    			'ReturnProductDetail' => True,
    			'ReturnCertificateInfo' => True,
    			'ReturnCertificateAlgorithmInfo' => True,
    			'ReturnFulfillment' => True,
    			'ReturnCACerts' => True,
    			'ReturnPKCS7Cert' => True,
    			'ReturnOrderAttributes' => True,
    			'ReturnAuthenticationComments' => True,
    			'ReturnAuthenticationStatuses' => True,
    			'ReturnTrustServicesSummary' => True,
    			'ReturnTrustServicesDetails' => True,
    			'ReturnVulnerabilityScanSummary' => True,
    			'ReturnVulnerabilityScanDetails' => True,
    			'ReturnFileAuthDVSummary' => True,
    			'ReturnDNSAuthDVSummary' => True,
    			'ReturnContacts' => True
    	);
    }

    public function generateContact($data, $type)
    {
    	return array(
    			'firstname' => ($type == 0) ? $data['OrganizationAddress']['FirstName'] : $data['FirstName']
    			, 'lastname' => ($type == 0) ? $data['OrganizationAddress']['LastName'] : $data['LastName']
    			, 'organization_name' => $data['OrganizationName']
    			, 'address' => ($type == 0) ? $data['OrganizationAddress']['AddressLine1'] : trim($data['AddressLine1'] . ' ' . $data['AddressLine2'])
    			, 'city' => ($type == 0) ? $data['OrganizationAddress']['City'] : $data['City']
    			, 'state' => ($type == 0) ? $data['OrganizationAddress']['Region'] : $data['Region']
    			, 'country' => ($type == 0) ? $data['OrganizationAddress']['Country'] : $data['Country']
    			, 'postal_code' => ($type == 0) ? $data['OrganizationAddress']['PostalCode'] : $data['PostalCode']
    			, 'job' => ($type == 0) ? $data['Division'] : $data['Title']
    			, 'telephone' => ($type == 0) ? $data['OrganizationAddress']['Phone'] : $data['Phone']
    			, 'phone' => ($type == 0) ? $data['OrganizationAddress']['Phone'] : $data['Phone']
    			, 'email_approval' => ($type == 0) ? $data['OrganizationAddress']['Email'] : $data['Email']
    			, 'address_type' => $type
    	);
    }

    public function updateContact($contact, $orderId, $clientId, $domainName)
    {
    	$db = hbm_db();
    	foreach($contact as $eachContact){
    		$chkExists = $db->query("SELECT * FROM hb_ssl_order_contact WHERE order_id = '{$orderId}' AND address_type = '{$eachContact['address_type']}'")->fetch();
    		if(!$chkExists){
    			$db->query("
    					INSERT INTO
    						`hb_ssl_order_contact` (
    							`client_id`
    							, `order_id`
    							, `domain_name`
    							, `address_type`
    						) VALUES (
    							:clientId
    							, :orderId
    							, :domainName
    							, :address_type
    						)
    			", array(
    					':clientId' => $clientId
    					, ':orderId' => $orderId
    					, ':domainName' => $domainName
    					, ':address_type' => $eachContact['address_type']
    			));
    		}
    		foreach($eachContact as $key => $value){
    			$db->query("
    					UPDATE
    						hb_ssl_order_contact
    					SET
    						{$key} = :value
    					WHERE
    						order_id = :orderId
    						AND address_type = :address_type
    			", array(':value' => $value, ':orderId' => $orderId, ':address_type' => $eachContact['address_type']));
    		}
    	}
    }

    public function updateOrder($orderId, $clientId, $orderDetail, $partnerOrderId)
    {
    	$db = hbm_db();
    	$chkOrder = $db->query("SELECT * FROM hb_ssl_order WHERE order_id = {$orderId}")->fetch();
    	if(!$chkOrder){
    		$dateCreate = strtotime($orderDetail['orderInfo']['OrderDate']);
    		$now = strtotime('now');
    		$dateExpire = (isset($orderDetail['certificateInfo']['EndDate'])) ? strtotime($orderDetail['certificateInfo']['EndDate']) : 0;
    		$productInfo = $this->getProductInfo($orderId);
    		$cronUpdate = ($orderDetail['orderInfo']['OrderState'] == 'COMPLETED') ? 1 : 0;
    		$domainName = $orderDetail['orderInfo']['DomainName'];
    		$dnsName = explode(',', $orderDetail['certificateInfo']['DNSNames']);
    		if(in_array('www.' . $domainName, $dnsName)){
    			unset($dnsName[array_search('www.' . $domainName, $dnsName)]);
    		}
    		$dnsText = '';
    		foreach($dnsName as $eachDNS){
    			$dnsText .= ($dnsText == '') ? $eachDNS : ',' . $eachDNS;
    		}
    		$dnsCount = sizeof($dnsName);
    		$db->query("
    				INSERT INTO
    					`hb_ssl_order` (
    						`order_id`
    						, `usr_id`
    						, `date_created`
    						, `last_updated`
    						, `date_expire`
    						, `ssl_id`
    						, `pid`
    						, `contract`
    						, `status_accept`
    						, `status_detail`
    						, `custom_techaddress`
    						, `cron_update`
    						, `is_renewal`
    						, `is_revoke`
    						, `san_amount`
    						, `server_amount`
    						, `hashing_algorithm`
    						, `commonname`
    						, `dns_name`
    					) VALUES (
    						:orderId
    						, :clientId
    						, :dateCreate
    						, :now
    						, :dateExpire
    						, :ssl_id
    						, :product_id
    						, :billingcycle
    						, 0
    						, 0
    						, 1
    						, :cronUpdate
    						, 0
    						, 0
    						, :dnsCount
    						, :serverCount
    						, ''
    						, :domainName
    						, :dnsText
    					)
    		", array(
    				':orderId' => $orderId
    				, ':clientId' => $clientId
    				, ':dateCreate' => $dateCreate
    				, ':now' => $now
    				, ':dateExpire' => $dateExpire
    				, ':ssl_id' => $productInfo['ssl_id']
    				, ':product_id' => $productInfo['product_id']
    				, ':billingcycle' => $productInfo['billingcycle']
    				, ':cronUpdate' => $cronUpdate
    				, ':dnsCount' => $dnsCount
    				, ':serverCount' => $orderDetail['OrderInfo']['ServerCount']
    				, ':domainName' => $domainName
    				, ':dnsText' => $dnsText
    		));
    	}
    	$code_certificate = isset($orderDetail['fulfillment']['ServerCertificate']) ? $orderDetail['fulfillment']['ServerCertificate'] : '';
    	$code_ca = isset($orderDetail['fulfillment']['CACertificates']['CACertificate'][0]['CACert']) ? $orderDetail['fulfillment']['CACertificates']['CACertificate'][0]['CACert'] : '';
    	$type_ca = isset($orderDetail['fulfillment']['CACertificates']['CACertificate'][0]['Type']) ? $orderDetail['fulfillment']['CACertificates']['CACertificate'][0]['Type'] : '';
    	$code_pkcs7 = isset($orderDetail['fulfillment']['PKCS7']) ? $orderDetail['fulfillment']['PKCS7'] : '';
    	$date_expire = isset($orderDetail['certificateInfo']['EndDate']) ? strtotime($orderDetail['certificateInfo']['EndDate']) : '';
    	$authority_orderid = isset($orderDetail['orderInfo']['GeoTrustOrderID']) ? $orderDetail['orderInfo']['GeoTrustOrderID'] : '';
    	$email_approval = isset($orderDetail['quickOrderDetail']['ApproverEmailAddress']) ? $orderDetail['quickOrderDetail']['ApproverEmailAddress'] : '';
    	$server_type = isset($orderDetail['certificateInfo']['WebServerType']) ? $orderDetail['certificateInfo']['WebServerType'] : '';
    	$commonname = isset($orderDetail['orderInfo']['DomainName']) ? $orderDetail['orderInfo']['DomainName'] : '';
    	$symantec_status = isset($orderDetail['orderInfo']['OrderState']) ? $orderDetail['orderInfo']['OrderState'] : '';
    	$partner_order_id = isset($orderDetail['orderInfo']['PartnerOrderID']) ? $orderDetail['orderInfo']['PartnerOrderID'] : '';
    	$cert_status = isset($orderDetail['certificateInfo']['CertificateStatus']) ? ucfirst(strtolower($orderDetail['certificateInfo']['CertificateStatus'])) : '';
    	$domainName = $orderDetail['orderInfo']['DomainName'];
    	$dnsName = explode(',', $orderDetail['certificateInfo']['DNSNames']);
    	if(in_array('www.' . $domainName, $dnsName)){
    		unset($dnsName[array_search('www.' . $domainName, $dnsName)]);
    	}
    	$dns_name = '';
    	foreach($dnsName as $eachDNS){
    		$dns_name .= ($dns_name == '') ? $eachDNS : ',' . $eachDNS;
    	}
    	$san_amount = sizeof($dnsName);
    	$server_amount = isset($orderDetail['orderInfo']['ServerCount']) ? $orderDetail['orderInfo']['ServerCount'] : '';
    	$hashing_algorithm = isset($orderDetail['certificateInfo']['AlgorithmInfo']['SignatureHashAlgorithm']) ? $orderDetail['certificateInfo']['AlgorithmInfo']['SignatureHashAlgorithm'] : '';

    	$update = $db->query("
    			UPDATE
    				`hb_ssl_order`
    			SET
    				`code_certificate` = :code_certificate
    				, `code_ca` = :code_ca
    				, `type_ca` = :type_ca
    				, `code_pkcs7` = :code_pkcs7
    				, `date_expire` = :date_expire
    				, `authority_orderid` = :authority_orderid
    				, `email_approval` = :email_approval
    				, `server_type` = :server_type
    				, `commonname` = :commonname
    				, `symantec_status` = :symantec_status
    				, `partner_order_id` = :partner_order_id
    				, `cert_status` = :cert_status
    				, `dns_name` = :dns_name
    				, `san_amount` = :san_amount
    				, `server_amount` = :server_amount
    				, `hashing_algorithm` = :hashing_algorithm
    			WHERE  `order_id` = :order_id
    	", array(
    			':code_certificate' => $code_certificate
    			, ':code_ca' => $code_ca
    			, ':type_ca' => $type_ca
    			, ':code_pkcs7' => $code_pkcs7
    			, ':date_expire' => $date_expire
    			, ':authority_orderid' => $authority_orderid
    			, ':email_approval' => $email_approval
    			, ':server_type' => $server_type
    			, ':commonname' => $commonname
    			, ':symantec_status' => $symantec_status
    			, ':partner_order_id' => $partner_order_id
    			, ':cert_status' => $cert_status
    			, ':dns_name' => $dns_name
    			, ':san_amount' => $san_amount
    			, ':server_amount' => $server_amount
    			, ':hashing_algorithm' => $hashing_algorithm
    			, ':order_id' => $orderId
    	));

    	if($date_expire != ''){
    		$next_due = date('Y-m-d', $date_expire);
	    	$db->query("
	    			UPDATE
	    				hb_accounts
	    			SET
	    				next_due = :next_due
	    			WHERE
	    				order_id = :orderId
	    	", array(':next_due' => $next_due, ':orderId' => $orderId));
    	}

    	return ($update) ? true : false;
    }

    public function getProductInfo($orderId)
    {
    	$db = hbm_db();
    	$data = $db->query("
    			SELECT
    				p.id AS product_id
    				, s.ssl_id
    				, a.billingcycle
    			FROM
    				hb_accounts AS a
    				, hb_products AS p
    				, hb_ssl AS s
    			WHERE
    				a.order_id = {$orderId}
    				, a.product_id = p.id
    				, p.name = s.ssl_name
    	")->fetch();
    	switch($data['billingcycle']){
    		case 'Annually' : $data['billingcycle'] = 12; break;
    		case 'Biennially' : $data['billingcycle'] = 24; break;
    		case 'Triennially' : $data['billingcycle'] = 36; break;
    	}
    	return $data;
    }

    public function get_order_by_date_range($request)
    {
    	require_once(HBFDIR_LIBS . 'RvLibs/SSL/PHPLibs.php');
    	$oAuth =& RvLibs_SSL_PHPLibs::singleton();
    	if($request['fDate'] && $request['tDate'] && $request['maction']){
    		$from = $request['fDate'];
    		$to = $request['tDate'];

    		$response = $oAuth->GetOrdersByDateRange($from, $to);

    		$this->template->assign('orderFound', $response['GetOrdersByDateRangeResult']['QueryResponseHeader']['ReturnCount']);
    		$this->template->assign('aData', $response);
    		$this->template->assign('fDate', $request['fDate']);
    		$this->template->assign('tDate', $request['tDate']);
    	} else if($request['partnerOrderID']){
    		$options = $this->getOrderByPartnerOrderIdFullOptions();
    		$orderData = $oAuth->getOrderByPartnerOrderID($request['partnerOrderID'], $options);
    		$this->template->assign('oData', $orderData);
    	}

    	$this->template->assign('fDate', $request['fDates']);
    	$this->template->assign('tDate', $request['tDates']);

    	$this->_assignDefaultVars();
    	$this->template->render(APPDIR_MODULES . 'Other' . '/rv_ssl/template/admin/get_order_by_date_range.tpl', $request, true);
    }

    public function get_hb_ssl_order($request)
    {
    	if(isset($request['date_f']) && isset($request['date_t'])){
    		$from = date('Y-m-d', strtotime($request['date_f']));
    		$to = date('Y-m-d', strtotime($request['date_t']));

    		$db = hbm_db();

    		$shownetway = (empty($request["shownetway"])) ? 'AND a.client_id != "8485"' : '';

    		$getSSL = $db->query("
    				SELECT
						p.name
						, a.date_created
						, a.firstpayment
						, a.client_id
						, a.billingcycle
					FROM
						hb_accounts AS a
						, hb_products AS p
					WHERE
						p.category_id = 1
						AND p.visible = 1
						AND a.product_id = p.id
						AND a.date_created >= :from
						AND a.date_created <= :to
    					{$shownetway}
						ORDER BY p.name ASC, a.date_created ASC
    		", array(":from" => $from, ":to" => $to))->fetchAll();

    		$getLicense = $db->query("
    				SELECT
						p.name
						, a.date_created
						, a.firstpayment
						, a.client_id
						, a.billingcycle
					FROM
						hb_accounts AS a
						, hb_products AS p
					WHERE
						p.category_id = 6
						AND p.visible = 1
						AND a.product_id = p.id
						AND a.date_created >= :from
						AND a.date_created <= :to
						AND p.name NOT LIKE '%RVSiteBuilder%'
						AND p.name NOT LIKE '%RVSkin%'
						ORDER BY p.name ASC, a.date_created ASC
    		", array(":from" => $from, ":to" => $to))->fetchAll();

    		$this->template->assign("ssl_data", $this->get_hb_ssl_order_gendata($getSSL));
    		$this->template->assign("ssl_out_b64", base64_encode(json_encode($getSSL)));
    		$this->template->assign("license_data", $this->get_hb_ssl_order_gendata($getLicense));
    		$this->template->assign("license_out_b64", base64_encode(json_encode($getLicense)));
    		$this->template->assign("from", $from);
    		$this->template->assign("to", $to);
    	} else if(isset($request['s_action'])){
    		if($request['s_action'] == "download"){
    			$today = date("Y-m-d");
		    	header("Content-type: text/plain");
		    	header("Content-Disposition: attachment; filename={$today}-{$request['type']}.php");
		    	echo "<?php\n\n\$hb_accounts = '" . base64_decode($request['data']) . "';\n\n?>";
		    	exit;
    		}
    	}


    	$this->_assignDefaultVars();
    	$this->template->render(APPDIR_MODULES . 'Other' . '/rv_ssl/template/admin/get_hb_ssl_order.tpl', $request, true);
    }

    public function get_hb_ssl_order_gendata($data)
    {
    	$output = array();
    	$output['count'] = count($data);
    	$output['cycle'] =  array();

    	foreach($data as $eData){
    		$eData['billingcycle'] = str_replace("-", "", $eData['billingcycle']);
    		if(!in_array($eData['billingcycle'], $output['cycle'])){
    			$output['cycle'][] = $eData['billingcycle'];
    		}
    		if(empty($output['product'][$eData['name']][$eData['billingcycle']])){
    			$output['product'][$eData['name']][$eData['billingcycle']] = 1;
    		} else {
    			$output['product'][$eData['name']][$eData['billingcycle']]++;
    		}
    		if(empty($output['product'][$eData['name']]['income'])){
    			$output['product'][$eData['name']]['income'] = $eData['firstpayment'];
    			$output['product'][$eData['name']]['incomes'] = $eData['firstpayment'];
    		} else {
    			$output['product'][$eData['name']]['income'] .= '+' . $eData['firstpayment'];
    			$output['product'][$eData['name']]['incomes'] += $eData['firstpayment'];
    		}
    	}

    	return $output;
    }

    public function annoucements_management($request)
    {
    	$db = hbm_db();
    	$annoucementDb = $db->query("SELECT * FROM hb_annoucements ORDER BY date DESC")->fetchAll();

    	if(isset($request["system_ann"]) && count($request["system_ann"]) > 0){
    		$annoucementSys = $db->query("SELECT value FROM hb_ssl_other_settings WHERE name = 'system_annoucement'")->fetch();
    		if(empty($annoucementSys["value"])){
    			$annoucementSys = array();
    		} else {
    			$annoucementSys = unserialize($annoucementSys["value"]);
    		}

    		if(count($annoucementSys) > 0){
    			$annoucementSys = serialize($request["system_ann"]);
    			$db->query("UPDATE hb_ssl_other_settings SET value=:val WHERE name = 'system_annoucement'", array(":val" => $annoucementSys));
    		} else {
    			$annoucementSys = serialize($request["system_ann"]);
    			$db->query("INSERT INTO hb_ssl_other_settings (name, value) VALUES ('system_annoucement', :val)", array(":val" => $annoucementSys));
    		}
    	} else if(isset($request["submit"])){
    		$db->query("DELETE FROM `hb_ssl_other_settings` WHERE `name` = 'system_annoucement'");
    	}

    	if(isset($request["add_whmcs"]) && count($request["add_whmcs"]) > 0){
	    	$annoucementWhmcs = $db->query("SELECT value FROM hb_ssl_other_settings WHERE name = 'whmcs_annoucement'")->fetch();
	    	if(empty($annoucementWhmcs["value"])){
	    		$annoucementWhmcs = array();
	    	} else {
	    		$annoucementWhmcs = unserialize($annoucementWhmcs["value"]);
	    	}
    		if(count($annoucementWhmcs) > 0){
	    		$annoucementWhmcs = serialize($request["add_whmcs"]);
	    		$db->query("UPDATE hb_ssl_other_settings SET value=:val WHERE name = 'whmcs_annoucement'", array(":val" => $annoucementWhmcs));
    		} else {
    			$annoucementWhmcs = serialize($request["add_whmcs"]);
    			$db->query("INSERT INTO hb_ssl_other_settings (name, value) VALUES ('whmcs_annoucement', :val)", array(":val" => $annoucementWhmcs));
    		}
    	} else if(isset($request["submit"])){
    		$db->query("DELETE FROM `hb_ssl_other_settings` WHERE `name` = 'whmcs_annoucement'");
    	}

    	$annoucementWhmcs = $db->query("SELECT value FROM hb_ssl_other_settings WHERE name = 'whmcs_annoucement'")->fetch();
    	if(empty($annoucementWhmcs["value"])){
    		$annoucementWhmcs = array();
    	} else {
    		$annoucementWhmcs = unserialize($annoucementWhmcs["value"]);
    	}

    	$annoucementSys = $db->query("SELECT value FROM hb_ssl_other_settings WHERE name = 'system_annoucement'")->fetch();
    	if(empty($annoucementSys["value"])){
    		$annoucementSys = array();
    	} else {
    		$annoucementSys = unserialize($annoucementSys["value"]);
    	}

    	$this->template->assign('system_annoucements', $annoucementDb);
    	$this->template->assign('whmcs_annoucements', $annoucementWhmcs);
    	$this->template->assign('system_select', $annoucementSys);

    	$this->_assignDefaultVars();
    	$this->template->render(APPDIR_MODULES . 'Other' . '/rv_ssl/template/admin/annoucements_management.tpl', $request, true);
    }

}