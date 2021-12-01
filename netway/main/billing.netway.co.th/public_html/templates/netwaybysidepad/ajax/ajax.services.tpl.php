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
                        dd.*, a.server_id
                    FROM
                        hb_accounts a,
                        hb_dns_domains dd,
                        hb_domains d
                    WHERE
                        a.id IN (" . implode(',', $aServiceIds) . ")
                        AND dd.account_id = a.id
                        AND dd.domain = d.name
                        AND d.status = 'Active'
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

$this->assign('isFreeDnsService', $isFreeDnsService);
$this->assign('aFreeDnsServices', $aFreeDnsServices);