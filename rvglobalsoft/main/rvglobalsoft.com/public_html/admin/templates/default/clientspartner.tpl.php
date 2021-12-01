<?php
if ( ! defined('HBF_APPNAME')) {
    exit;
}

$db         = hbm_db();
$aClient            = $this->get_template_vars('client');
$aResult     = $db->query('
	SELECT 
		ac.id AS acct_id, ac.product_id AS product_id, p.category_id AS category_id
	FROM  
		hb_accounts AS ac, hb_products AS p
	WHERE
		ac.client_id = :client_id
		AND ac.product_id = p.id
', array(
	':client_id' => $aClient['id'],
))->fetchAll();

$isPatrnet = false;

foreach ($aResult as $aAcct) {
	// Product category_id 8 is NOC Licenses, that is patrnet
	if ($aAcct['category_id'] == 8) {
		$isPatrnet = true;
	}
}

$this->assign('isRVPatrnet', $isPatrnet);



