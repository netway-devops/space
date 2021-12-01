<?php
/**
 * Order data is about to be build (inserted into database)
 * @param array $details Following details are passed:
 * $details['product'] - array with ordered pacakge details
 * $details['configuration'] - array with ordered Form elements
 * $details['addons'] - array with ordered addons
 * $details['domains'] - array with ordered domains
 * $details['notes'] - order notes
 * $details['discounts'] - discounts applied in cart during order
 * $details['subproducts'] - subpackages ordered with main package
 * $details['client_id'] - client id that place this order.
 */

// --- hostbill helper ---
$db         = hbm_db();
$db->query("SELECT '". __FILE__ ."' ");
// --- hostbill helper ---

$clientId = $details['client_id'];

// if($details['product']['category_name'] == 'SSL' && isset($_SESSION['SSLSAN']) && ((isset($_SESSION['SSLSAN']['additional_domain']) && $_SESSION['SSLSAN']['additional_domain'] > 0) || (isset($_SESSION['SSLSAN']['additional_server']) && $_SESSION['SSLSAN']['additional_server'] > 1))){
if($details['product']['category_name'] == 'SSL'){
	$nowCredit = $db->query("SELECT credit FROM hb_client_billing WHERE client_id = {$clientId}")->fetch();
	$db->query("UPDATE hb_client_billing SET credit = 0.00, credit_swap = {$nowCredit['credit']} WHERE client_id = {$clientId}");
}


$clientId       = $details['client_id'];
$aDomains       = isset($details['domains']) ? $details['domains'] : array();

$isRenewDomain  = false;

if (count($aDomains)) {
    foreach ($aDomains as $aDomain) {
        if (isset($aDomain['domain_id']) && $aDomain['domain_id']
            && isset($aDomain['action']) && $aDomain['action'] == 'renew' ) {
            $isRenewDomain  = true;
            break;
        }
    }
}

/**
 * ถ้ามี order ที่มี renew domain อยู่ด้วยยกเลิการใช้ credit
 */
if ($clientId && $isRenewDomain) {

    $credit     = 0;
    $creditSwap = 0;
    $aClientBilling     = $db->query("
                    SELECT cb.credit, cb.credit_swap
                    FROM hb_client_billing cb
                    WHERE cb.client_id = :clientId
                    ", array(
                        ':clientId' => $clientId
                    ))->fetch();

    $creditSwap     = $aClientBilling['credit'] + $aClientBilling['credit_swap'];

    $db->query("
        UPDATE hb_client_billing
        SET credit = :credit,
            credit_swap = :creditSwap
        WHERE client_id = :clientId
    ", array(
        ':credit'       => $credit,
        ':creditSwap'   => $creditSwap,
        ':clientId'     => $clientId
    ));

}

if (isset($_SESSION['SSLORDER'])) {
	unset($_SESSION['SSLORDER']);
}

if (isset($details['product']['category_id']) && $details['product']['category_id'] == 1) {
	$_SESSION['SSLORDER'] = $_SESSION['SSLITEM'];
	unset($_SESSION['SSLITEM']);
}




