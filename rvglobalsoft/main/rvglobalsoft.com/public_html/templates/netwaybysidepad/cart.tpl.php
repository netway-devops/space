<?php
// Depending on HostBill application.
if ( ! defined('HBF_APPNAME')) {
    exit;
}

require_once(APPDIR . 'class.general.custom.php');
require_once(APPDIR . 'class.config.custom.php');
require_once(APPDIR . 'modules/Site/productlicensehandle/user/class.productlicensehandle_controller.php');
require_once(HBFDIR_LIBS . 'RvLibs/SSL/PHPLibs.php');

// --- hostbill helper ---
$api        = new ApiWrapper();
$db         = hbm_db();
$client     = hbm_logged_client();
$oClient    = (object) $client;
$oAuth 		=& RvLibs_SSL_PHPLibs::singleton();
$apiCustom 	= $oAuth->generateAPICustom();
// --- hostbill helper ---


// --- Get template variable ---
$aGateways          = $this->get_template_vars('gateways');
$aContents          = $this->get_template_vars('contents');
// --- Get template variable ---


/* --- เอา payment ที่ไม่ต้องการแสดงออก --- */
$aGateway            = array();

if (is_array($aGateways) && count($aGateways)) {
    foreach ($aGateways as $k => $v) {
       if ( strtolower($v) == 'cash' || strtolower($v) == 'credit' ) {
           continue;
       }
       if ( preg_match('/^banktransfer/i', $v) && strtolower($v) != 'banktransfer' ) {
           continue;
       }
       $aGateway[$k]   = $v;
    }
}

$this->assign('gateways', $aGateway);

/* --- XXX --- */

$cartItems      = isset($_SESSION['AppSettings']['Cart']) ? count($_SESSION['AppSettings']['Cart']) : 0;
$this->assign('cartItems', $cartItems);
$catid;
$isLicence = TRUE;
foreach ($_SESSION['AppSettings']['Cart'] as $key) {
	$catid = $key['product']['category_id'];
    if($catid!=6)
        $isLicence =FALSE;
}
$this->assign('catid', $catid);
$this->assign('islicence', $isLicence);
//echo '<pre>'.print_r($_SESSION['AppSettings']['Cart'], true).'</pre>';

$contents = $this->get_template_vars('contents');
if($contents[0]['product']['id'] == 59){
	$chk = $db->query("
				SELECT
					quantity
				FROM
					hb_vip_info
				WHERE
					usr_id = :usr_id
			", array(
				':usr_id' => $client['id']
			)
	)->fetch();
 	$qty = $contents[0]['product_configuration'][13][13]['val'];
 	if($chk['quantity'] != '' && $qty != $chk['quantity']){
 		$system_url = $this->get_template_vars('system_url');
 		?>
 			<script type='text/javascript'>
 			var url = '<?php echo $system_url; ?>' + 'clientarea/services/rv2factor/';
 	 		window.location.assign(url);
 			</script>
 		<?php
 	}
 	$cyc = $contents[0]['product_configuration'][13][13]['recurring'];
 	$price_per_unit = ($cyc == 'm') ? 3.00 : 30.00;
	$contents[0]['product_configuration'][13][13]['prorata_amount'] = $price_per_unit * $qty;

	$now = date('Y-m-d');
	if($cyc == 'm'){
		$n1 = strtotime(date('Y-m-d', strtotime($now . '+1 months')));
		$n17 = strtotime(date('Y-m-07', strtotime($now . '+1 months')));
	} else {
		$n1 = strtotime(date('Y-m-d', strtotime($now . '+1 years')));
		$n17 = strtotime(date('Y-m-07', strtotime($now . '+1 years')));
	}
	if($n1 > $n17){
		if($cyc == 'm'){
			$n17 = strtotime(date('Y-m-07', strtotime($now . '+2 months')));
		} else {
			$n17 = strtotime(date('Y-m-07', strtotime($now . '+1 years')));
		}
	}
	// Date gap
	$start = strtotime($now);
	$end = $n17;
	$timeDiff = abs($end - $start);
	$numberDays = intval($timeDiff/86400);
	// Date gap

	// total date gap
	$start = strtotime(date('Y-m-01', $n17));
	$end = strtotime(date('Y-m-t', $n17));
	$timeDiff = abs($end - $start);
	$numberDaysPeriod = intval($timeDiff/86400);
	// total date gap

	$now = date('d/m/Y', strtotime($now));
	$nextDue = date('d/m/Y', $n17);
	$prorata_amount = $price_per_unit*(($numberDays*100)/(($cyc == 'm') ? $numberDaysPeriod*100 : 36500));
	$prorata_amount = number_format(floatval($prorata_amount), 2, '.', '');
	$contents[0]['product']['prorata_date'] = $nextDue;
	$contents[0]['product']['prorata_amount'] = $prorata_amount;

	$this->assign('contents', $contents);
 	$this->assign('2faProrata', $prorata_amount * $qty);
 	$_SESSION['2faProrata'] = $prorata_amount * $qty;

	$lastAccountInfo = $db->query("
                                        SELECT
                                                id
                                                , client_id
                                                , order_id
                                                , product_id

                                                , next_due
                                                , status
                                        FROM
                                                hb_accounts
                                        WHERE
                                                client_id = :client_id
                                                AND product_id IN (59, 60, 61)
        								ORDER BY product_id ASC
                                        ", array(
                                                ':client_id' => $client['id']
	))->fetchAll();
	if(sizeof($lastAccountInfo) > 0 && $lastAccountInfo[0]['status'] == 'Active'){
		$nextdue = strtotime($lastAccountInfo[0]['next_due']);
		if(strtotime('now') > $nextdue){
			$lastAccountInfo[0]['status'] = 'Expired';
		}
	}
	if(sizeof($lastAccountInfo) > 0 && ($lastAccountInfo[0]['status'] == 'Terminated' || $lastAccountInfo[0]['status'] == 'Suspended' || $lastAccountInfo[0]['status'] == 'Expired') && $lastAccountInfo[0]['product_id'] == 59){
		$this->assign('2faRenew', 1);
	} else {
		$this->assign('2faRenew', 0);
	}
}

// --- Clear item ออกจาก cart ถ้าไม่ตรงเงื่อนไขในการสั่งซื้อ product license ---
$idx            = productlicensehandle_controller::singleton()->validateCartItem();
$this->assign('cartIndex', $idx);

// --- Partner กำลังสั่งซื้อ RVSkin RVSitebuilder เราไม่อนุญาติให้ทำ เพราะมีหน้า issue license อยู่แล้ว ---
$isPartnerOrderOurLicense   = productlicensehandle_controller::singleton()->isPartnerOrderOurLicense();
$this->assign('cartIndex', $isPartnerOrderOurLicense);
$this->assign('isPartnerOrderOurLicense', (($isPartnerOrderOurLicense >= 0) ? 1 : 0));


//######################SSL#########################################
$sslContent = $contents;

$productConfig = $contents[0]['product_configuration'];

$qSSL = $db->query("SELECT id from hb_products as p, hb_ssl as s WHERE p.name = s.ssl_name AND p.id = {$sslContent[0]['product']['id']}")->fetch();
// echo '<pre>'; print_r($sslContent); echo '</pre>';
if($qSSL){
	$sanText = '';
	$sanAmount = 0;
	$servAmount = 0;
	foreach($productConfig as $eK => $eC){
		foreach($eC as $eV){
			if($eV['name'] == 'Additional Domain Text'){
				$sanText = $eV['val'];
				unset($sslContent[0]['product_configuration'][$eK]);
			} else if($eV['name'] == 'Additional Domain Name'){
				$sanAmount = $eV['qty'];
				unset($sslContent[0]['product_configuration'][$eK]);
			} else if($eV['name'] == 'Additional Server'){
				$servAmount = $eV['qty'];
				unset($sslContent[0]['product_configuration'][$eK]);
			}
		}
	}
	$adminOrder = false;
	foreach($sslContent as $v){
		$pid = $v['product']['id'];
		$scyc = $v['product']['recurring'];
		$priceSum = $v['product']['price'];
		$cParams = array('call' => 'getProductApplicableAddons', 'id' => $pid);
		$productAddonsList = $apiCustom->request($cParams);
// 		$productAddonsList = $api->getProductApplicableAddons($cParams);
		$subtotal = $this->get_template_vars('subtotal');
		$have_coupon = false;

		if(isset($_SESSION['SSLPROMO'])){
			$have_coupon = true;
			$code = $_SESSION['SSLPROMO']['code'];
			$type = $_SESSION['SSLPROMO']['type'];
			$value = $_SESSION['SSLPROMO']['value'];
			$promo_cycle = $_SESSION['SSLPROMO']['cycle'];
// 			$adminOrder = $oAuth->getExtraPromo($client['id'], $code);
			$subtotal['coupon'] = $code;
			$discount = 0.00;

			switch($type){
				case 'percent' :
					$discount = $priceSum;
					$priceSumDiscount = $priceSum*((100-$value)/100);
					$discount -= $priceSumDiscount;
					if($value == '100' || $value == '100.00'){
						$adminOrder = true;
					}
					break;
				case 'fixed' :
					$priceSumDiscount = $priceSum - $value;
					$discount += $value;
					break;
			}
		}

		foreach($productAddonsList['addons']['addons'] as $vv){
			$productId = explode(',', $vv['products']);
			if(in_array($pid, $productId)){
				$addonId = $vv['id'];
				$aParams = array('id' => $vv['id']);
				$addonDetail = $api->getAddonDetails($aParams);
				$price = $addonDetail['addon'][$scyc];

				if(isset($_SESSION['SSLSAN']['additional_domain']) && $_SESSION['SSLSAN']['additional_domain'] > 0){
					$sanNum = $_SESSION['SSLSAN']['additional_domain'];
					if($have_coupon) $priceSumDiscount += ($price*$sanNum);
					$addonSANName = "Additional Domain Name";
					$addonSANName .= ($sanNum > 1) ? 's' : '';
					$addonSANName .= " x {$sanNum}";
					$sslContent[0]['addons']['san']['id'] = 'san';
					$sslContent[0]['addons']['san']['name'] = $addonSANName;
					$sslContent[0]['addons']['san']['description'] = '';
					$sslContent[0]['addons']['san']['price'] = $price*$sanNum;
					$sslContent[0]['addons']['san']['recurring'] = 'a';
					$sslContent[0]['addons']['san']['prorata_amount'] = '';
					$sslContent[0]['addons']['san']['prorata_date'] = '';
					$sslContent[0]['addons']['san']['setup'] = 0.00;
					$sslContent[0]['addons']['san']['tax'] = 0;
					$sslContent[0]['addons']['san']['account_id'] = '';
					$priceSum += $price*$sanNum;
				}
			}
		}

		if($_SESSION['SSLSAN']['additional_server'] > 1){
			$servNum = $_SESSION['SSLSAN']['additional_server'];
			$priceServ = $priceSum*($servNum-1);
			if($have_coupon){
				$discount += $priceServ - ($priceSumDiscount * ($servNum-1));
				$priceSumDiscount *= ($servNum);
			}
			$priceSum*=$servNum;
			$servNum--;
			$addonServName = "Additional Server";
			$addonServName .= ($servNum > 1) ? 's' : '';
			$addonServName .= " x {$servNum}";
			$sslContent[0]['addons']['serv']['id'] = 'serv';
			$sslContent[0]['addons']['serv']['name'] = $addonServName;
			$sslContent[0]['addons']['serv']['description'] = '';
			$sslContent[0]['addons']['serv']['price'] = $priceServ;
			$sslContent[0]['addons']['serv']['recurring'] = 'a';
			$sslContent[0]['addons']['serv']['prorata_amount'] = '';
			$sslContent[0]['addons']['serv']['prorata_date'] = '';
			$sslContent[0]['addons']['serv']['setup'] = 0.00;
			$sslContent[0]['addons']['serv']['tax'] = 0;
			$sslContent[0]['addons']['serv']['account_id'] = '';
		}
	}

	$tax = $this->get_template_vars('tax');
	$tax['subtotal'] = strval($priceSum);
	$tax['total'] = ($have_coupon) ? strval($priceSumDiscount) : strval($priceSum);
	$tax['cost'] = ($have_coupon) ? $priceSumDiscount : $priceSum;

	foreach($tax['recurring'] as $tk => $tv){
		$tax['recurring'][$tk] = ($have_coupon && $promo_cycle == 'recurring') ? $priceSumDiscount : $priceSum;
		if($adminOrder){
			$tax['recurring'][$tk] = ($have_coupon && $promo_cycle == 'recurring') ? 0.01 : $tax['recurring'][$tk];
		}
	}

	if($have_coupon && isset($discount) && $discount > 0){
		$subtotal['discount'] = $discount;
	}

	if($adminOrder){
		$subtotal['discount'] = $tax['subtotal'] - 0.01;
		$tax['total'] = 0.01;
	}

	$clientCredit = $db->query("SELECT credit FROM hb_client_billing WHERE client_id = '{$client['id']}'")->fetch();
	$clientCredit =	$clientCredit['credit'];

	if($clientCredit){
		$clientCredit = floatval($clientCredit);
		if($clientCredit >= $tax['total']){
			$tax['credit'] = $tax['total'];
			$tax['total'] = '0.00';
		} else {
			$tax['total']-=$clientCredit;
			$tax['credit'] = $clientCredit;
		}
	}

	$this->assign('tax', $tax);
	$this->assign('contents', $sslContent);
	$this->assign('subtotal', $subtotal);
}
//######################SSL#########################################


$isOrderRVSiteBuilder   = preg_match('/rvsitebuilder/i', serialize($aContents)) ? 1 : 0;
$this->assign('isOrderRVSiteBuilder', $isOrderRVSiteBuilder);
