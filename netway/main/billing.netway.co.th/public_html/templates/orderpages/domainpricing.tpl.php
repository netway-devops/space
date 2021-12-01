<?php
// Depending on HostBill application.
if ( ! defined('HBF_APPNAME')) {
    exit;
}

// --- hostbill helper ---
$db         = hbm_db();
// --- hostbill helper ---


// --- Get template variable ---
$aProduct           = $this->get_template_vars('prices');
// --- Get template variable ---

$aProductA	=	array_splice($aProduct, 0 ,13 );
$aProductB	=	array_splice($aProduct, 0 - count($aProduct));

function compare_tld($a, $b){
	return strnatcmp($a['tld'], $b['tld']);
}

uasort($aProductB, 'compare_tld');

$aProductC	=	array_merge($aProductA,$aProductB);

$this->assign('prices', $aProductC);