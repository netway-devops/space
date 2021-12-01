<?php
// Depending on HostBill application.
if ( ! defined('HBF_APPNAME')) {
    exit;
}


// --- hostbill helper ---
$api        = new ApiWrapper();
$db         = hbm_db();
$admin      = hbm_logged_admin();
$oAdmin     = isset($admin['id']) ? (object) $admin : null;
// --- hostbill helper ---


// --- Get template variable ---
$aDetails       = $this->get_template_vars('details');
$aNameserv      = $this->get_template_vars('nameserv');
$aWidgets       = $this->get_template_vars('widgets');
// --- Get template variable ---

//echo '<pre>'.print_r($aDetails, true).'</pre>';

$this->assign('oAdmin', $oAdmin);

/* sort nameservers for display assing var to "details" */
if (count($aDetails['nameservers'])>0) {
	
	// sort value not key 'nameservers'
	$aNameServerClone = $aDetails['nameservers'];
	asort($aNameServerClone);
	
	$aNameServerSort = array();
	$aNsipsSortnsips = array();
	
	foreach ($aNameServerClone as $key => $val) {
		if ($val != "") {
			array_push($aNameServerSort, $val);
			if (isset($aDetails['nsips'][$key]) && $aDetails['nsips'][$key] != "") {
	            // sort value and key 'nsips' from 'nameservers'
	            array_push($aNsipsSortnsips, $aDetails['nsips'][$key]);
	        }
		}
		
	}
	
	// sort value and key 'nameservers'
	$aDetails['nameservers_sort'] = $aNameServerSort;
	$aDetails['nsips_sort'] = $aNsipsSortnsips;
	
	$this->assign('details', $aDetails);
}

preg_match('/([^\.]+)(\..*)/', $aDetails['name'], $match);
$sld        = isset($match[1]) ? $match[1] : '';
$tld        = isset($match[2]) ? $match[2] : '';

$result     = $db->query("
    SELECT *
    FROM tb_domain_forwarding
    WHERE domain = :domain
        AND tld = :tld
    ", array(
        ':domain'   => $sld,
        ':tld'      => $tld,
    ))->fetch();

$aForwardDomain     = isset($result['domain']) ? $result : array();
if (isset($aForwardDomain['urlforwarding'])) {
    if (preg_match('/^https/i', $aForwardDomain['urlforwarding'])) {
        $aForwardDomain['urlforwarding_http']   = 'https';
    } else {
        $aForwardDomain['urlforwarding_http']   = 'http';
    }
    $aForwardDomain['urlforwarding']    = preg_replace('/^'. $aForwardDomain['urlforwarding_http'] .'\:\/\//i', '', $aForwardDomain['urlforwarding']);
    
}
$this->assign('aForwardDomain', $aForwardDomain);


/* -- verify include for rv custom template */
$this->assign('rvcustomtemplate', '');
if (isset($_SERVER['QUERY_STRING'])) {
	if (@preg_match('/rvdomainforwarding/', $_SERVER['QUERY_STRING'])) {
		$this->assign('rvcustomtemplate', APPDIR_MODULES . 'Other/netway_common/templates/domain/user/domainforwarding.tpl');
	} else if (@preg_match('/rvgooglecode/', $_SERVER['QUERY_STRING'])) {
        $this->assign('rvcustomtemplate', APPDIR_MODULES . 'Other/netway_common/templates/domain/user/googlecode.tpl');
	}
}


/* -- validate our name server -- */
if (count($aDetails['nameservers'])>0) {
	foreach ($aDetails['nameservers'] as $key => $nameServer) {
		if ($nameServer == "") {
		} else {
			if (preg_match('/ns1.siaminterhost.com/i', $nameServer)
	           || preg_match('/ns2.siaminterhost.com/i', $nameServer)
	           || preg_match('/ns3.siaminterhost.com/i', $nameServer)
	           || preg_match('/ns4.siaminterhost.com/i', $nameServer)
	           || preg_match('/ns1.thaidomainname.com/i', $nameServer)
	           || preg_match('/ns2.thaidomainname.com/i', $nameServer)
	           || preg_match('/ns.thaidns.net/i', $nameServer)
	           || preg_match('/ns1.thaidns.net/i', $nameServer)
	           || preg_match('/ns1.netway.co.th/i', $nameServer)
	           || preg_match('/ns2.netway.co.th/i', $nameServer)
	           || preg_match('/ns1.netwaygroup.com/i', $nameServer)
	           || preg_match('/ns2.netwaygroup.com/i', $nameServer)
	           || preg_match('/ns3.netwaygroup.com/i', $nameServer)
	           || preg_match('/ns4.netwaygroup.com/i', $nameServer)
	           || preg_match('/ns9.siaminterhost.com/i', $nameServer)
	           || preg_match('/ns10.siaminterhost.com/i', $nameServer)
	           || preg_match('/ns1.hostingfree.in.th/i', $nameServer)
	           || preg_match('/ns2.hostingfree.in.th/i', $nameServer)
	           || preg_match('/ns3.thaihostunlimited.com/i', $nameServer)
	           || preg_match('/ns4.thaihostunlimited.com/i', $nameServer)
	       ) {
	           // My Zone
	       } else {
	       	   $this->assign('requireUpdateNS', 1);
	       	   break;
	       }
		}
	}
}


/* --- เพิ่ม dns domain ให้ automatic --- */
if (isset($aDetails['name']) && $aDetails['name']) {
    
    /* --- ถ้ามี dnsservice --- */
    $result     = $db->query("
            SELECT
                a.id
            FROM
                hb_accounts a,
                hb_products p,
                hb_product_types pt
            WHERE
                a.client_id = :clientId
                AND a.status = 'Active'
                AND a.product_id = p.id
                AND p.type = pt.id
                AND pt.type = 'dnsservice'
                
            ", array(
                ':clientId'         => $aDetails['client_id']
            ))->fetch();
            
    $accountId                  = (isset($result['id']) && $result['id']) ? $result['id'] : 0;
    
    if ($accountId) {
        
        $result     = $db->query("
                SELECT
                    dd.*
                FROM
                    hb_dns_domains dd
                WHERE
                    dd.domain = :domainName
                    AND dd.account_id = :accountId
                ", array(
                    ':domainName'       => $aDetails['name'],
                    ':accountId'        => $accountId
                ))->fetch();
                
        $dnsDomainId    = (isset($result['domain_id']) && $result['domain_id']) ? $result['domain_id'] : 0;
        
        /* --- ถ้ายังไม่มี record --- */
        if (! $dnsDomainId) {
            $result     = $db->query("
                    SELECT
                        MAX(dd.domain_id) AS domainNumber
                    FROM
                        hb_dns_domains dd
                    WHERE
                        dd.account_id = :accountId
                    ", array(
                        ':accountId'        => $accountId
                    ))->fetch();
                    
            $dnsDomainId   = (isset($result['domainNumber']) && $result['domainNumber']) 
                                ? ($result['domainNumber'] + 1) : 1;
                                
            $db->query("
                INSERT INTO hb_dns_domains (
                    account_id, domain_id, domain, created
                ) VALUES (
                    :accountId, :domainId, :domainName, :created
                )
                ", array(
                    ':accountId'        => $accountId,
                    ':domainId'         => $dnsDomainId,
                    ':domainName'       => $aDetails['name'],
                    ':created'          => date('Y-m-d H:i:s')
                ));
                
        }

        $this->assign('dnsDomainId', $dnsDomainId);
        
    }
    

    
}


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


/* แสดงข้อมูล DNS Service error กรณียังไม่มีบริการ */
/* ไม่สามารถเชื่อมต่อระบบได้ */
if (preg_match('/dnsservices/', $_SERVER['QUERY_STRING']) || preg_match('/dnsservices/', $_SERVER['REQUEST_URI'])) {
    $this->assign('NsError', 1);
    if (! count($aNameserv)) {
        $result     = $db->query("
                    SELECT
                        mc.id,
                        s.ns1, s.ns2, s.ip1, s.ip2
                    FROM
                        hb_modules_configuration mc,
                        hb_servers s
                    WHERE
                        mc.filename = 'class.cpaneldns.php'
                        AND mc.id = s.default_module
                        AND s.default = 1
                        AND s.enable = 1
                    ")->fetch();
        if (isset($result) && $result['id']) {
            $aNameserv  = array(
                array('name' => $result['ns1'], 'ip' => $result['ip1']),
                array('name' => $result['ns2'], 'ip' => $result['ip2'])
            );
        }
        $this->assign('nameserv', $aNameserv);
    }
}


/* --- แสดงรายการ file upload ให้สามารถจัดการได้ --- */
if (isset($aDetails['id'])) {
    
    $aCustomUpload  = array();
    
    $result         = $db->query("
            SELECT
                c2a.*,
                cic.name
            FROM
                hb_config2accounts c2a,
                hb_config_items_cat cic,
                hb_config_items_types cit
            WHERE
                c2a.account_id = :accountId
                AND c2a.rel_type = 'Domain'
                AND c2a.config_cat = cic.id
                AND cic.type =cit.id
                AND cit.type = 'fileupload'
            ", array(
                ':accountId'            => $aDetails['id']
            ))->fetchAll();
    
    if (is_array($result) && count($result)) {
        foreach ($result as $v) {
            $aCustomUpload[$v['config_cat']]    = $v;
        }
    }
    
    $this->assign('aCustomUpload', $aCustomUpload);
    
}

//echo '<pre>'.print_r($aDetails, true).'</pre>';