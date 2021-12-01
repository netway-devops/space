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
$aServices      = $this->get_template_vars('services');
$clientData		= $this->get_template_vars('clientdata');
$clientId 		= $clientData['id'];
// --- Get template variable ---

/* --- แสดงรายชื่อ zone เลย  --- */

$isFreeDnsService   = false;
$aFreeDnsServices   = array();
if (count($aServices)) {
    $aServiceIds    = array();
    foreach ($aServices as $aService) {
        array_push($aServiceIds, $aService['id']);
    }

    $aDsnDomains    = $db->query("
                    SELECT
                        dd.*
                    FROM
                        hb_accounts a,
                        hb_dns_domains dd
                    WHERE
                        a.id IN (" . implode(',', $aServiceIds) . ")
                        AND dd.account_id = a.id
                    ORDER BY dd.domain_id ASC
                    ")->fetchAll();

    if (count($aDsnDomains)) {
        $isFreeDnsService   = true;

        foreach ($aDsnDomains as $aDnsDomain) {
            $serviceId      = $aDnsDomain['account_id'];
            $domainId       = $aDnsDomain['domain_id'];

            if (! is_array($aFreeDnsServices[$serviceId])) {
                $aFreeDnsServices[$serviceId]   = array();
            }

            $aFreeDnsServices[$serviceId][$domainId]    = $aDnsDomain;

        }

    }

}

foreach($aServices as $index => $service){
	if($service['slug'] == 'ssl'){
		if($service['next_due'] != 0){
			$now = strtotime('now');
			$due = strtotime($service['next_due']);
			if($now > $due){
				$aServices[$index]['next_due'] = 'Expired';
			} else {
				$aServices[$index]['next_due_strtotime'] = strtotime($service['next_due'])-(60*60*24*90);
			}
		}
		$iQuery = $db->query("
				SELECT
					i.status
				FROM
					hb_invoices AS i
					, hb_invoice_items AS ii
					, hb_accounts AS a
				WHERE
					a.id = :accountId
					AND ii.item_id = a.id
					AND ii.invoice_id = i.id
					ORDER BY ii.id DESC
					LIMIT 0,1
				", array(
					':accountId' => $service['id']
				)
		)->fetch();
		if($iQuery){
			$aServices[$index]['status'] = $iQuery['status'];
		}
	}
}

$this->assign('services', $aServices);
$this->assign('strtotimeNow', strtotime('now'));
$this->assign('isFreeDnsService', $isFreeDnsService);
$this->assign('aFreeDnsServices', $aFreeDnsServices);