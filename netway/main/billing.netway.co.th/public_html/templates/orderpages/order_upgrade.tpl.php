<?php
// Depending on HostBill application.
if ( ! defined('HBF_APPNAME')) {
    exit;
}

// --- hostbill helper ---
$db         = hbm_db();
// --- hostbill helper ---
$aTemplate           = $this->get_template_vars();
//echo '<pre> $aTemplate '. print_r($aTemplate, true) .'</pre>';
$aGateways           = $this->get_template_vars('gateways');
$aContents           = $this->get_template_vars('contents');

$aGateway            = array();

if (is_array($aGateways) && count($aGateways)) {
    foreach ($aGateways as $k => $v) {
       if ( strtolower($v) == 'cash' ) {
           continue;
       }
       if ( preg_match('/^banktransfer/i', $v) && strtolower($v) != 'banktransfer' ) {
           continue;
       }
       $aGateway[$k]   = $v;
    }
}

$this->assign('gateways2', $aGateway);

/* --- order upgrade product ยังไม่ต้องเอา customfield มารวมด้วย เพราะเป็น bug --- */
//echo '<pre>'.print_r($_SESSION['Upgrade'],true).'</pre>';
//echo '<pre>'.print_r($aContents,true).'</pre>';
if (isset($aContents['product']['product_id'])
    && ($aContents['product']['product_id'] != $aContents['product']['new_product_id'])) {
    $aContents['config']       = array();
    
    $this->assign('contents', $aContents);
}
// echo '<pre> $aContents '. print_r($aContents, true) .'</pre>';
$accountId	=	$aContents['product']['account_id'];
$result     = $db->query("
    SELECT a.*
    FROM hb_accounts a
    WHERE a.id = '{$accountId}'
    ")->fetch();
    
if (isset($result['id']) && $result['id']) {
    $expireDate = strtotime($result['expiry_date']) > 0 ? $result['expiry_date'] : $result['next_due'];
    $startTerm  = date('d/m/Y', time());
    $endTerm    = date('d/m/Y', strtotime($expireDate));
    $desc       = $result['domain']  .' ('. $startTerm .' - '. $endTerm .')';
	$aDesc	=	array(
					'domain'		=>		$result['domain'] ,
					'desc'			=>		$desc
				);
				
	$this->assign('aDesc', $aDesc);

}