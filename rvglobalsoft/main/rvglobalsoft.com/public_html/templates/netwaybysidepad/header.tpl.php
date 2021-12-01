<?php
// Depending on HostBill application.
if ( ! defined('HBF_APPNAME')) {
    exit;
}

// --- Get template variable ---
$aTplPath           = $this->get_template_vars('tpl_path');
// --- Get template variable ---

/* --- สนับสนุน SEO --- */
$currentPage        = (is_array($aTplPath) && count($aTplPath)) ? array_pop($aTplPath) : '';

$aSeoMetaTag        = array('title' => '', 'keywords' => '', 'description' => '');
if ($currentPage == 'root') {
    $aSeoMetaTag    = array(
        'title'         => 'Leading one stop shop for hosting provider | buy everything at the best price',
        'keywords'      => 'cpanel, rvsitebuilder, rvskin, ssl, isp manager, litespeed, softaculous, cloudlinux, virtualizor',
        'description'   => 'Find variation of addons for hosting - including plugins, cPanel addons, control panels, SSL - at our one stop shop with great discount'
    );
}
if ($currentPage == 'rvsitebuilder') {
    $aSeoMetaTag    = array(
        'title'         => 'Get RVsitebuilder license | High-performance site builder for web hosts | RVglobalsoft, Inc.',
        'keywords'      => 'Site Builder, Site Building Service, Building Website, Shared Hosting Provider, Shared Hosting, Hosting',
        'description'   => 'values to your selling points by providing site-building service on top of your dedicated servers. With confidence with latest web publishing technology.'
    );
}
if ($currentPage == 'rvskin') {
    $aSeoMetaTag    = array(
        'title'         => 'Buy RVskin - the best cPanel theme and admin tool | RVglobalsoft, Inc.',
        'keywords'      => 'build website, web hosts, hosting provider, add on, RVsitebuilder, create site, build sites, cpanel, direct admin',
        'description'   => 'Offer your customers to create their sites without any coding skill required. Fast integration & unlimited clients websites | Leading online store for webhosts'
    );
}
if ($currentPage == 'ssl') {
    $aSeoMetaTag    = array(
        'title'         => 'RVGlobalSoft - SSL Certificates',
        'keywords'      => 'SSL, SSL Certificates, SSL reseller, Website Security, Site Security',
        'description'   => 'Be the right partner to your customers by selling SSL Certificate from industry leaders with retail price.'
    );
}

if ($currentPage == 'cpanel_licenses') {
    $aSeoMetaTag    = array(
        'title'         => 'Get cPanel license with 23% discount | RVglobalsoft, Inc.',
        'keywords'      => 'control panel. cpanel, discount, cheap, pricing, webhosts, hosting provider, platform, vps, dedicated, server',
        'description'   => 'Best price for cPanel - the most popular control panel. Buy now and get RVskin for free | Leading online store for webhosts '
    );
}
if ($currentPage == 'cpanel_license') {
    $aSeoMetaTag    = array(
        'title'         => 'Get cPanel license with 23% discount | RVglobalsoft, Inc. ',
        'keywords'      => 'control panel. cpanel, discount, cheap, pricing, webhosts, hosting provider, platform, vps, dedicated, server',
        'description'   => 'Best price for cPanel - the most popular control panel. Buy now and get RVskin for free | Leading online store for webhosts'
    );
}
if ($currentPage == 'reseller') {
    $aSeoMetaTag    = array(
        'title'         => 'RVGlobalSoft - Reseller',
        'keywords'      => 'Reseller',
        'description'   => 'Become and RVGlobalSoft reseller and optimize your business. No minimum commitment, Transparency and Integrated.'
    );
}
if ($currentPage == 'knowledgebase') {
    $aSeoMetaTag    = array(
        'title'         => 'RVGlobalSoft - Software Solution Provider',
        'keywords'      => 'Site Builder, Managed System Service, SSL Certificates, 2-Factor Authentication, cPanel, WHM, WHMCS, Software Licences, Web Design, Web Hosting Management, Site Security, Software Solutions, Security Solutions',
        'description'   => 'Software solution provider for hosting companies around the world, Applications on control panel, Security solutions and web hosting management application.'
    );
}
if ($currentPage == 'contact') {
    $aSeoMetaTag    = array(
        'title'         => 'RVGlobalSoft - Software Solution Provider',
        'keywords'      => 'Site Builder, Managed System Service, SSL Certificates, 2-Factor Authentication, cPanel, WHM, WHMCS, Software Licences, Web Design, Web Hosting Management,, Site Security, Software Solutions, Security Solutions',
        'description'   => 'Software solution provider for hosting companies around the world, Applications on control panel, Security solutions and web hosting management application.'
    );
}
if ($currentPage == 'rvlogin') {
    $aSeoMetaTag    = array(
        'title'         => 'Download RVLogin - A Single Sign-on for WHM and SSH (compatible with RV2Factor)',
        'keywords'      => 'Download, RVLogin, RV2Factor, RVGlobalSoft, WHM Single Sign-on, SSH Single Sign-on, 2-Factor Authentication, Symantec Validation and ID Protection (VIP) Service.',
        'description'   => 'Software solution provider for hosting companies around the world, Applications on control panel, Security solutions and web hosting management application.'
    );
}

if ($currentPage == 'products') {
	$aSeoMetaTag    = array(
			'title'         => 'Products - One Stop Shop for Hosting Provider',
			'keywords'      => 'Web-hosting software licenses, software, services, cPanel, ISPmanager, LiteSpeed, CloudLinux, Softaculous, RVskin, RVsitebuilder, RVssl, Virtualizor',
			'description'   => 'a one-stop service for all software licenses designed for web-hosting business'
	);
}
if ($currentPage == 'ispmanager') {
	$aSeoMetaTag    = array(
			'title'         => 'Get ISPmanager control panel license | RVglobalsoft, Inc.',
			'keywords'      => 'ispmanager, isp manager, control panel, lite, business, webhost, webhosts, hosting, provider, platform, pricing',
			'description'   => 'ISPmanager for VPS and dedicated server. We offer both ISPmanager Business and ISPmanager Lite | Leading online store for webhosts'
	);
}
if ($currentPage == 'litespeed') {
	$aSeoMetaTag    = array(
			'title'         => 'Buy LiteSpeed web server license | RVglobalsoft, Inc.',
			'keywords'      => 'litespeed, apache, drop-in, replacement, web server, hosting provider, webhosts, addon',
			'description'   => 'Improve your performance and lower operating costs with LiteSpeed drop-in replacement - Apache compatible | Leading online store for webhosts'
	);
}
if ($currentPage == 'cloudlinux') {
	$aSeoMetaTag    = array(
			'title'         => 'Get CloudLinux with 22% discount | RVglobalsoft, Inc.',
			'keywords'      => 'CloudLinux, discount, operating system, shared hosting, webhosts, hosting providers',
			'description'   => 'Best price of CloudLinux - The linux based operating system for shared hosting providers | Leading online store for webhosts'
	);
}
if ($currentPage == 'softaculous') {
	$aSeoMetaTag    = array(
			'title'         => 'Buy Softaculous for dedicated server and VPS server license | RVglobalsoft, Inc.',
			'keywords'      => 'softaculous, vps, dedicated, server, installer, scripts, application, hosting providers, webhosts, addon',
			'description'   => 'Get softaculous license - the best web application auto installer works on many control panels | Leading online store for webhosts'
	);
}
if ($currentPage == 'virtualizor') {
	$aSeoMetaTag    = array(
			'title'         => 'Buy Virtualizor - the powerful web based VPS control panel | RVglobalsoft, Inc.',
			'keywords'      => 'virtualizor, VPS, control panel, web host, hosting provider',
			'description'   => 'Supports OpenVZ, Xen PV, Xen HVM, XenServer, Linux KVM, LXC, OpenVZ | Leading online store for webhosts'
	);
}
if ($currentPage == 'installation') {
	$aSeoMetaTag    = array(
			'title'         => 'Installation instructions for all softwares | RVglobalsoft, Inc.',
			'keywords'      => 'Installation, instruction, download, how to, web host, hosting provider',
			'description'   => 'Find how to download and install any software | Leading online store for webhosts'
	);
}
if ($currentPage == 'why_us') {
	$aSeoMetaTag    = array(
			'title'         => 'Why Us | Learn more about RVglobalsoft, Inc.',
			'keywords'      => 'Why us, learn, hosting provider, webhost, management, addon, add-on, license, about',
			'description'   => 'We offer all in one shopping experience with easy license management and much more! | Leading online store for webhosts'
	);
}

$this->assign('aSeoMetaTag', $aSeoMetaTag);

/***********************SSL***********************/
$count_ssl = array(
		'all' => 0
		, 'active' => 0
		, 'expire' => 0
		, 'incomplete' => 0
		, 'unpaid' => 0
		, 'terminate' => 0
);

$account_ssl = array(
		'active' => array()
		, 'expire' => array()
		, 'incomplete' => array()
		, 'unpaid' => array()
		, 'terminate' => array()
);

$aServices           = $this->get_template_vars('services');

$db = hbm_db();

$opdetails = $this->get_template_vars('opdetails');
$slug = $opdetails['slug'];
if(strtolower($slug) == 'ssl'){
	$clientdata = $this->get_template_vars('clientdata');
	$client_id = $clientdata['id'];
	$all_account = $db->query("
			SELECT
				a.id
				, a.product_id
				, a.domain
				, a.total
				, a.status
				, a.billingcycle
				, a.next_due
				, so.symantec_status
				, i.status AS invoice_status
			FROM
				hb_accounts AS a
				, hb_ssl_order AS so
				, hb_products AS p
				, hb_categories AS c
				, hb_orders AS o
				, hb_invoices AS i
			WHERE
				a.client_id = {$client_id}
				AND a.product_id = p.id
				AND p.category_id = c.id
				AND c.name = 'SSL'
				AND a.order_id = so.order_id
				AND o.id = a.order_id
				AND o.invoice_id = i.id
			ORDER BY a.id DESC
	")->fetchAll();
	foreach($all_account as $aService){
		$getLatestInvoice = $db->query("
				SELECT
					i.status
				FROM
					hb_invoices AS i
					, hb_invoice_items AS ii
					, hb_accounts AS a
				WHERE
					a.id = {$aService['id']}
					AND ii.item_id = a.id
					AND ii.invoice_id = i.id
					ORDER BY ii.id DESC
					LIMIT 0,1")->fetch();
		$aService['invoice_status'] = $getLatestInvoice['status'];
		$count_ssl['all']++;
	    if($aService['status'] == 'Active'){
	        $count_ssl['active']++;
	        $account_ssl['active'][] = $aService['id'];
	        if((strtotime($aService['next_due'])-(60*60*24*90)) <= strtotime('now')){
	        	$count_ssl['expire']++;
	        	$account_ssl['expire'][] = $aService['id'];
	        }
	        continue;
	    } else if($aService['status'] == 'Renewing'){
	    	$count_ssl['expire']++;
	    	$count_ssl['incomplete']++;
	    	$account_ssl['expire'][] = $aService['id'];
	    	$account_ssl['incomplete'][] = $aService['id'];
	    } else if($aService['status'] == 'Pending'){
	    	$count_ssl['incomplete']++;
	    	$account_ssl['incomplete'][] = $aService['id'];
	    } else if($aService['status'] == 'Terminated'){
	    	$count_ssl['terminate']++;
	    	$account_ssl['terminate'][] = $aService['id'];
	    	continue;
	    }

	    if($aService['invoice_status'] == 'Unpaid'){
	         $count_ssl['unpaid']++;
	         $account_ssl['unpaid'][] = $aService['id'];
	        continue;
	    }
	}

	switch($_GET['sort']){
		case 'active':
			$this->_tpl_vars['ssl_side_sort'] = $account_ssl['active'];
			break;
		case 'expire':
			$this->_tpl_vars['ssl_side_sort'] = $account_ssl['expire'];
			break;
		case 'incomplete':
			$this->_tpl_vars['ssl_side_sort'] = $account_ssl['incomplete'];
			break;
		case 'unpaid':
			$this->_tpl_vars['ssl_side_sort'] = $account_ssl['unpaid'];
			break;
		case 'terminate':
			$this->_tpl_vars['ssl_side_sort'] = $account_ssl['terminate'];
			break;
	}


}
$this->_tpl_vars['count_ssl'] = $count_ssl;

$noPermissionUser = array('internal@netway.co.th');
if(isset($_SESSION['AppSettings']['login']) && !in_array($_SESSION['AppSettings']['login']['email'], $noPermissionUser) && empty($_SESSION['AppSettings']['admin_login'])){
	require_once(HBFDIR_LIBS . 'RvLibs/GA/RVGATracking.php');
	RVGATracking::init('UA-65722035-5', '9819');
	$oRVGATracking = RVGATracking::singleton();
	$os = $oRVGATracking->getUserOS();

	$aDevice = $oRVGATracking->getDevice();
	$device = array('Device', $aDevice['type'], $aDevice['platform']);
	if (strtolower($aDevice['type']) == 'tablet') {
		$device = array('Device Tablet', $aDevice['platform'], $aDevice['version']);
	} elseif (strtolower($aDevice['type']) == 'mobile') {
		$device = array('Device Mobile', $aDevice['platform'], $aDevice['version']);
	}

	$this->_tpl_vars['ga_mode'] = (file_exists(HBFDIR_LIBS . 'RvLibs/SSL/developer.php')) ? 'demo' : 'real';
	$this->_tpl_vars['ga_request'] = ($_SERVER['REQUEST_URI'][0] == '/') ? substr($_SERVER['REQUEST_URI'], 1) : $_SERVER['REQUEST_URI'];
	$this->_tpl_vars['ga_os'] = $device;
	$this->_tpl_vars['ga_device'] = $aDevice['type'];
}
