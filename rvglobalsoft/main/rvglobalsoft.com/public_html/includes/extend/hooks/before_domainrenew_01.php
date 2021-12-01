<?php
/**
 * HostBill is about to take an attempt to renew domain
 * Throw exception here to stop domain renewal
 * @param array $details array containing two elements
 * $details['id'] = domain id
 * $details['name'] = domain name
 */

// --- hostbill helper ---
$db         = hbm_db();
$db->query("SELECT '". __FILE__ ."' ");
// --- hostbill helper ---

/**
 * ถ้า order นั้นทำ provision renew complete ไปแล้ว ไม่ต้องทำซ้ำให้หยุด
 */
$domainId   = $details['id'];

require_once(APPDIR . 'class.general.custom.php');
$result     = GeneralCustom::singleton()->isDomainAllowRenewable($domainId);
if (! $result) {
    throw new Exception('Domain #' . $domainId  . ' ไม่อยู่ในเงื่อนไขที่จะทำการ autorenew ได้ ');
}


