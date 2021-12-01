<?php
// Depending on HostBill application.
if ( ! defined('HBF_APPNAME')) {
    exit;
}


// --- hostbill helper ---
$api        = new ApiWrapper();
$db         = hbm_db();
// --- hostbill helper ---


// --- Get template variable ---
$aDetails       = $this->get_template_vars('details');
// --- Get template variable ---


/* --- แสดงรายชื่อ zone เลย  --- */

$aDnsService        = $db->query("
                    SELECT 
                        a.id, c.slug
                    FROM
                        hb_dns_domains dd,
                        hb_accounts a,
                        hb_products p,
                        hb_categories c
                    WHERE
                        dd.domain = :domainName
                        AND dd.account_id = a.id
                        AND a.client_id = :clientId
                        AND a.product_id = p.id
                        AND p.category_id = c.id
                    ", array(
                        ':domainName'   =>  $aDetails['name'],
                        ':clientId'     =>  $aDetails['client_id']
                    ))->fetch();

$this->assign('aDnsService', $aDnsService);