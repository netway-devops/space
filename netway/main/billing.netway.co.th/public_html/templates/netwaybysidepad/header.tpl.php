<?php
// Depending on HostBill application.
if ( ! defined('HBF_APPNAME')) {
    exit;
}

require_once(APPDIR . '/modules/Other/zendeskintegratehandle/admin/class.zendeskintegratehandle_controller.php');

// --- hostbill helper ---
$api        = new ApiWrapper();
$db         = hbm_db();
$aClient    = hbm_logged_client();
$aAdmin     = hbm_logged_admin();
// --- hostbill helper ---

$this->assign('aClient', $aClient);

if (isset($aAdmin['email'])) {
    $aExt       = array();
    $request    = array(
        'url'       => '/users/search.json?query='. $aAdmin['email'],
        'method'    => 'get',
        'data'      => array()
    );
    $result     = zendeskintegratehandle_controller::singleton()->send($request);
    $result     = isset($result['users'][0]) ? $result['users'][0] : array();
    if (isset($result['id'])) {
        $request    = array(
            'url'       => '/users/'. $result['id'] .'/identities.json',
            'method'    => 'get',
            'data'      => array()
        );
        $result     = zendeskintegratehandle_controller::singleton()->send($request);
        $result     = isset($result['identities']) ? $result['identities'] : array();
        if (count($result)) {
            foreach ($result as $arr) {
                if ($arr['type'] == 'phone_number' && strlen($arr['value']) == 4) {
                    array_push($aExt, $arr['value']);
                }
            }
        }
    }
    $aAdmin['aExt'] = $aExt;
    
/*

เอาไว้ set tag ให้เจ้าหน้าที่
##################################################
curl --include \
     --request PUT \
     --header "Content-Type: application/json" \
     --data-binary "{\"app_id\" : \"bd4a64d2-6c89-44b5-901b-00157d6b66ed\",
\"tags\":{\"xxxx\": \"ext\", \"email\": \"xxxxxxx@netway.co.th\"}}" \
     https://onesignal.com/api/v1/players/xxxxxxxxxxxxxxxxxxxxxxxxxx
##################################################
 
*/
}

$this->assign('aAdmin', $aAdmin);

// --- Get template variable ---
$aTplPath           = $this->get_template_vars('tpl_path');
// --- Get template variable ---

/* --- สนับสนุน SEO --- */
$currentPage        = (is_array($aTplPath) && count($aTplPath)) ? array_pop($aTplPath) : '';

$aSeoMetaTag        = array('title' => '', 'keywords' => '', 'description' => '');

if ($currentPage == '') {
    $aSeoMetaTag    = array(
        'title'         => 'Netway Communication, Managed Cloud Service Provider',
        'keywords'      => 'Netway Communication, Managed Cloud Service Provider',
        'description'   => 'Netway Communication, Managed Cloud Service Provider'
    );
}
if ($currentPage == 'hosting') {
    $aSeoMetaTag    = array(
        'title'         => 'Hosting',
        'keywords'      => 'Hosting',
        'description'   => 'Hosting'
    );
}

if ($currentPage == 'domain') {
    $aSeoMetaTag    = array(
        'title'         => 'Domain',
        'keywords'      => 'Domain',
        'description'   => 'Domain'
    );
}

if ($currentPage == 'googleapps') {
    $aSeoMetaTag    = array(
        'title'         => 'บริการอบรม Google Apps สำหรับบุคคลและองค์กรในประเทศไทยพร้อมระบบ Hybrid',
        'keywords'      => 'Google Apps for Business, Thailand, ประเทศไทย, การทำ Hybrid, การใช้งาน Google Apps ร่วมกับ, การเชื่อมระบบ, Integration, Apps Advisor, Maintenance, Implementation, Service, Deployment, อบรม, ติดตั้ง, การอบรม, การติดตั้ง, Train, Training, Google Apps Certified Sales Specialists, อบรมพนักงาน, การฝึกอบรม, อบรมงานบุคคล, แนะนำบริการ ',
        'description'   => 'Netway ให้บริการการอบรม Google Apps for Business พร้อมบริการเสริมที่เกี่ยวข้องเช่น Hybrid ที่เกี่ยวข้องกับการ Implementation ร่วมกับระบบเดิมหรืออื่นๆ ของคุณ โดยมี Google Apps Certified Sales Specialists ที่มากที่สุดในประเทศไทย'
    );
}

if ($currentPage == 'learngoogleapps') {
    $aSeoMetaTag    = array(
        'title'         => 'บริการอบรม Google Apps สำหรับบุคคลและองค์กรในประเทศไทยพร้อมระบบ Hybrid',
        'keywords'      => 'Google Apps for Business, Thailand, ประเทศไทย, การทำ Hybrid, การใช้งาน Google Apps ร่วมกับ, การเชื่อมระบบ, Integration, Apps Advisor, Maintenance, Implementation, Service, Deployment, อบรม, ติดตั้ง, การอบรม, การติดตั้ง, Train, Training, Google Apps Certified Sales Specialists, อบรมพนักงาน, การฝึกอบรม, อบรมงานบุคคล, แนะนำบริการ ',
        'description'   => 'Netway ให้บริการการอบรม Google Apps for Business พร้อมบริการเสริมที่เกี่ยวข้องเช่น Hybrid ที่เกี่ยวข้องกับการ Implementation ร่วมกับระบบเดิมหรืออื่นๆ ของคุณ โดยมี Google Apps Certified Sales Specialists ที่มากที่สุดในประเทศไทย'
    );
}

if ($currentPage == 'gmail') {
    $aSeoMetaTag    = array(
        'title'         => 'บริการอบรม Google Apps สำหรับบุคคลและองค์กรในประเทศไทยพร้อมระบบ Hybrid',
        'keywords'      => 'Google Apps for Business, Thailand, ประเทศไทย, การทำ Hybrid, การใช้งาน Google Apps ร่วมกับ, การเชื่อมระบบ, Integration, Apps Advisor, Maintenance, Implementation, Service, Deployment, อบรม, ติดตั้ง, การอบรม, การติดตั้ง, Train, Training, Google Apps Certified Sales Specialists, อบรมพนักงาน, การฝึกอบรม, อบรมงานบุคคล, แนะนำบริการ ',
        'description'   => 'Netway ให้บริการการอบรม Google Apps for Business พร้อมบริการเสริมที่เกี่ยวข้องเช่น Hybrid ที่เกี่ยวข้องกับการ Implementation ร่วมกับระบบเดิมหรืออื่นๆ ของคุณ โดยมี Google Apps Certified Sales Specialists ที่มากที่สุดในประเทศไทย'
    );
}

if ($currentPage == 'drive') {
    $aSeoMetaTag    = array(
        'title'         => 'บริการอบรม Google Apps สำหรับบุคคลและองค์กรในประเทศไทยพร้อมระบบ Hybrid',
        'keywords'      => 'Google Apps for Business, Thailand, ประเทศไทย, การทำ Hybrid, การใช้งาน Google Apps ร่วมกับ, การเชื่อมระบบ, Integration, Apps Advisor, Maintenance, Implementation, Service, Deployment, อบรม, ติดตั้ง, การอบรม, การติดตั้ง, Train, Training, Google Apps Certified Sales Specialists, อบรมพนักงาน, การฝึกอบรม, อบรมงานบุคคล, แนะนำบริการ ',
        'description'   => 'Netway ให้บริการการอบรม Google Apps for Business พร้อมบริการเสริมที่เกี่ยวข้องเช่น Hybrid ที่เกี่ยวข้องกับการ Implementation ร่วมกับระบบเดิมหรืออื่นๆ ของคุณ โดยมี Google Apps Certified Sales Specialists ที่มากที่สุดในประเทศไทย'
    );
}

if ($currentPage == 'calendar') {
    $aSeoMetaTag    = array(
        'title'         => 'บริการอบรม Google Apps สำหรับบุคคลและองค์กรในประเทศไทยพร้อมระบบ Hybrid',
        'keywords'      => 'Google Apps for Business, Thailand, ประเทศไทย, การทำ Hybrid, การใช้งาน Google Apps ร่วมกับ, การเชื่อมระบบ, Integration, Apps Advisor, Maintenance, Implementation, Service, Deployment, อบรม, ติดตั้ง, การอบรม, การติดตั้ง, Train, Training, Google Apps Certified Sales Specialists, อบรมพนักงาน, การฝึกอบรม, อบรมงานบุคคล, แนะนำบริการ ',
        'description'   => 'Netway ให้บริการการอบรม Google Apps for Business พร้อมบริการเสริมที่เกี่ยวข้องเช่น Hybrid ที่เกี่ยวข้องกับการ Implementation ร่วมกับระบบเดิมหรืออื่นๆ ของคุณ โดยมี Google Apps Certified Sales Specialists ที่มากที่สุดในประเทศไทย'
    );
}

if ($currentPage == 'site') {
    $aSeoMetaTag    = array(
        'title'         => 'บริการอบรม Google Apps สำหรับบุคคลและองค์กรในประเทศไทยพร้อมระบบ Hybrid',
        'keywords'      => 'Google Apps for Business, Thailand, ประเทศไทย, การทำ Hybrid, การใช้งาน Google Apps ร่วมกับ, การเชื่อมระบบ, Integration, Apps Advisor, Maintenance, Implementation, Service, Deployment, อบรม, ติดตั้ง, การอบรม, การติดตั้ง, Train, Training, Google Apps Certified Sales Specialists, อบรมพนักงาน, การฝึกอบรม, อบรมงานบุคคล, แนะนำบริการ ',
        'description'   => 'Netway ให้บริการการอบรม Google Apps for Business พร้อมบริการเสริมที่เกี่ยวข้องเช่น Hybrid ที่เกี่ยวข้องกับการ Implementation ร่วมกับระบบเดิมหรืออื่นๆ ของคุณ โดยมี Google Apps Certified Sales Specialists ที่มากที่สุดในประเทศไทย'
    );
}

if ($currentPage == 'benefitsgoogleapps') {
    $aSeoMetaTag    = array(
        'title'         => 'บริการอบรม Google Apps สำหรับบุคคลและองค์กรในประเทศไทยพร้อมระบบ Hybrid',
        'keywords'      => 'Google Apps for Business, Thailand, ประเทศไทย, การทำ Hybrid, การใช้งาน Google Apps ร่วมกับ, การเชื่อมระบบ, Integration, Apps Advisor, Maintenance, Implementation, Service, Deployment, อบรม, ติดตั้ง, การอบรม, การติดตั้ง, Train, Training, Google Apps Certified Sales Specialists, อบรมพนักงาน, การฝึกอบรม, อบรมงานบุคคล, แนะนำบริการ ',
        'description'   => 'Netway ให้บริการการอบรม Google Apps for Business พร้อมบริการเสริมที่เกี่ยวข้องเช่น Hybrid ที่เกี่ยวข้องกับการ Implementation ร่วมกับระบบเดิมหรืออื่นๆ ของคุณ โดยมี Google Apps Certified Sales Specialists ที่มากที่สุดในประเทศไทย'
    );
}

if ($currentPage == 'hybridgoogleapps') {
    $aSeoMetaTag    = array(
        'title'         => 'บริการอบรม Google Apps สำหรับบุคคลและองค์กรในประเทศไทยพร้อมระบบ Hybrid',
        'keywords'      => 'Google Apps for Business, Thailand, ประเทศไทย, การทำ Hybrid, การใช้งาน Google Apps ร่วมกับ, การเชื่อมระบบ, Integration, Apps Advisor, Maintenance, Implementation, Service, Deployment, อบรม, ติดตั้ง, การอบรม, การติดตั้ง, Train, Training, Google Apps Certified Sales Specialists, อบรมพนักงาน, การฝึกอบรม, อบรมงานบุคคล, แนะนำบริการ ',
        'description'   => 'Netway ให้บริการการอบรม Google Apps for Business พร้อมบริการเสริมที่เกี่ยวข้องเช่น Hybrid ที่เกี่ยวข้องกับการ Implementation ร่วมกับระบบเดิมหรืออื่นๆ ของคุณ โดยมี Google Apps Certified Sales Specialists ที่มากที่สุดในประเทศไทย'
    );
}

if ($currentPage == 'migrationservice') {
    $aSeoMetaTag    = array(
        'title'         => 'บริการอบรม Google Apps สำหรับบุคคลและองค์กรในประเทศไทยพร้อมระบบ Hybrid',
        'keywords'      => 'Google Apps for Business, Thailand, ประเทศไทย, การทำ Hybrid, การใช้งาน Google Apps ร่วมกับ, การเชื่อมระบบ, Integration, Apps Advisor, Maintenance, Implementation, Service, Deployment, อบรม, ติดตั้ง, การอบรม, การติดตั้ง, Train, Training, Google Apps Certified Sales Specialists, อบรมพนักงาน, การฝึกอบรม, อบรมงานบุคคล, แนะนำบริการ ',
        'description'   => 'Netway ให้บริการการอบรม Google Apps for Business พร้อมบริการเสริมที่เกี่ยวข้องเช่น Hybrid ที่เกี่ยวข้องกับการ Implementation ร่วมกับระบบเดิมหรืออื่นๆ ของคุณ โดยมี Google Apps Certified Sales Specialists ที่มากที่สุดในประเทศไทย'
    );
}

if ($currentPage == 'maintenanceservice') {
    $aSeoMetaTag    = array(
        'title'         => 'บริการอบรม Google Apps สำหรับบุคคลและองค์กรในประเทศไทยพร้อมระบบ Hybrid',
        'keywords'      => 'Google Apps for Business, Thailand, ประเทศไทย, การทำ Hybrid, การใช้งาน Google Apps ร่วมกับ, การเชื่อมระบบ, Integration, Apps Advisor, Maintenance, Implementation, Service, Deployment, อบรม, ติดตั้ง, การอบรม, การติดตั้ง, Train, Training, Google Apps Certified Sales Specialists, อบรมพนักงาน, การฝึกอบรม, อบรมงานบุคคล, แนะนำบริการ ',
        'description'   => 'Netway ให้บริการการอบรม Google Apps for Business พร้อมบริการเสริมที่เกี่ยวข้องเช่น Hybrid ที่เกี่ยวข้องกับการ Implementation ร่วมกับระบบเดิมหรืออื่นๆ ของคุณ โดยมี Google Apps Certified Sales Specialists ที่มากที่สุดในประเทศไทย'
    );
}

if ($currentPage == 'appsadvisor') {
    $aSeoMetaTag    = array(
        'title'         => 'บริการอบรม Google Apps สำหรับบุคคลและองค์กรในประเทศไทยพร้อมระบบ Hybrid',
        'keywords'      => 'Google Apps for Business, Thailand, ประเทศไทย, การทำ Hybrid, การใช้งาน Google Apps ร่วมกับ, การเชื่อมระบบ, Integration, Apps Advisor, Maintenance, Implementation, Service, Deployment, อบรม, ติดตั้ง, การอบรม, การติดตั้ง, Train, Training, Google Apps Certified Sales Specialists, อบรมพนักงาน, การฝึกอบรม, อบรมงานบุคคล, แนะนำบริการ ',
        'description'   => 'Netway ให้บริการการอบรม Google Apps for Business พร้อมบริการเสริมที่เกี่ยวข้องเช่น Hybrid ที่เกี่ยวข้องกับการ Implementation ร่วมกับระบบเดิมหรืออื่นๆ ของคุณ โดยมี Google Apps Certified Sales Specialists ที่มากที่สุดในประเทศไทย'
    );
}

if ($currentPage == 'onlinetraining') {
    $aSeoMetaTag    = array(
        'title'         => 'บริการอบรม Google Apps สำหรับบุคคลและองค์กรในประเทศไทยพร้อมระบบ Hybrid',
        'keywords'      => 'Google Apps for Business, Thailand, ประเทศไทย, การทำ Hybrid, การใช้งาน Google Apps ร่วมกับ, การเชื่อมระบบ, Integration, Apps Advisor, Maintenance, Implementation, Service, Deployment, อบรม, ติดตั้ง, การอบรม, การติดตั้ง, Train, Training, Google Apps Certified Sales Specialists, อบรมพนักงาน, การฝึกอบรม, อบรมงานบุคคล, แนะนำบริการ ',
        'description'   => 'Netway ให้บริการการอบรม Google Apps for Business พร้อมบริการเสริมที่เกี่ยวข้องเช่น Hybrid ที่เกี่ยวข้องกับการ Implementation ร่วมกับระบบเดิมหรืออื่นๆ ของคุณ โดยมี Google Apps Certified Sales Specialists ที่มากที่สุดในประเทศไทย'
    );
}

if ($currentPage == 'traininguser') {
    $aSeoMetaTag    = array(
        'title'         => 'บริการอบรม Google Apps สำหรับบุคคลและองค์กรในประเทศไทยพร้อมระบบ Hybrid',
        'keywords'      => 'Google Apps for Business, Thailand, ประเทศไทย, การทำ Hybrid, การใช้งาน Google Apps ร่วมกับ, การเชื่อมระบบ, Integration, Apps Advisor, Maintenance, Implementation, Service, Deployment, อบรม, ติดตั้ง, การอบรม, การติดตั้ง, Train, Training, Google Apps Certified Sales Specialists, อบรมพนักงาน, การฝึกอบรม, อบรมงานบุคคล, แนะนำบริการ ',
        'description'   => 'Netway ให้บริการการอบรม Google Apps for Business พร้อมบริการเสริมที่เกี่ยวข้องเช่น Hybrid ที่เกี่ยวข้องกับการ Implementation ร่วมกับระบบเดิมหรืออื่นๆ ของคุณ โดยมี Google Apps Certified Sales Specialists ที่มากที่สุดในประเทศไทย'
    );
}

if ($currentPage == 'trainingadmin') {
    $aSeoMetaTag    = array(
        'title'         => 'บริการอบรม Google Apps สำหรับบุคคลและองค์กรในประเทศไทยพร้อมระบบ Hybrid',
        'keywords'      => 'Google Apps for Business, Thailand, ประเทศไทย, การทำ Hybrid, การใช้งาน Google Apps ร่วมกับ, การเชื่อมระบบ, Integration, Apps Advisor, Maintenance, Implementation, Service, Deployment, อบรม, ติดตั้ง, การอบรม, การติดตั้ง, Train, Training, Google Apps Certified Sales Specialists, อบรมพนักงาน, การฝึกอบรม, อบรมงานบุคคล, แนะนำบริการ ',
        'description'   => 'Netway ให้บริการการอบรม Google Apps for Business พร้อมบริการเสริมที่เกี่ยวข้องเช่น Hybrid ที่เกี่ยวข้องกับการ Implementation ร่วมกับระบบเดิมหรืออื่นๆ ของคุณ โดยมี Google Apps Certified Sales Specialists ที่มากที่สุดในประเทศไทย'
    );
}


if ($currentPage == 'security') {
    $aSeoMetaTag    = array(
        'title'         => 'Security',
        'keywords'      => 'Security',
        'description'   => 'Security'
    );
}

if ($currentPage == 'software') {
    $aSeoMetaTag    = array(
        'title'         => 'Software',
        'keywords'      => 'Software',
        'description'   => 'Software'
    );
}

if ($currentPage == 'reseller') {
    $aSeoMetaTag    = array(
        'title'         => 'Reseller ตัวแทนจำหน่าย',
        'keywords'      => 'Reseller',
        'description'   => 'Reseller'
    );
}

if ($currentPage == 'payment') {
    $aSeoMetaTag    = array(
        'title'         => 'Payment',
        'keywords'      => 'Payment',
        'description'   => 'Payment'
    );
}

if ($currentPage == 'netway_support') {
    $aSeoMetaTag    = array(
        'title'         => 'Support',
        'keywords'      => 'Support',
        'description'   => 'Support'
    );
}
if ($currentPage == 'website_services') {
    $aSeoMetaTag    = array(
        'title'         => 'รับทำเว็บไซต์ website  ทำเว็บไซต์ eCommerce ออกแบบเว็บไซต์ รับทำเว็บไซต์ร้านค้าออนไลน์ รับทำเว็บขายสินค้า รับทำเว็บขายของ',
        'keywords'      => 'รับทำเว็บไซต์ website  ทำเว็บไซต์ eCommerce ออกแบบเว็บไซต์ รับทำเว็บไซต์ร้านค้าออนไลน์ รับทำเว็บขายสินค้า รับทำเว็บขายของ',
        'description'   => 'รับทำเว็บไซต์ website  ทำเว็บไซต์ eCommerce ออกแบบเว็บไซต์ รับทำเว็บไซต์ร้านค้าออนไลน์ รับทำเว็บขายสินค้า รับทำเว็บขายของ'
    );
}

if ($currentPage == 'website') {
    $aSeoMetaTag    = array(
        'title'         => 'รับทำเว็บไซต์ website  ทำเว็บไซต์ eCommerce ออกแบบเว็บไซต์ รับทำเว็บไซต์ร้านค้าออนไลน์ รับทำเว็บขายสินค้า รับทำเว็บขายของ',
        'keywords'      => 'รับทำเว็บไซต์ website  ทำเว็บไซต์ eCommerce ออกแบบเว็บไซต์ รับทำเว็บไซต์ร้านค้าออนไลน์ รับทำเว็บขายสินค้า รับทำเว็บขายของ',
        'description'   => 'รับทำเว็บไซต์ website  ทำเว็บไซต์ eCommerce ออกแบบเว็บไซต์ รับทำเว็บไซต์ร้านค้าออนไลน์ รับทำเว็บขายสินค้า รับทำเว็บขายของ'
    );
}

if ($currentPage == 'website_ecommerce') {
    $aSeoMetaTag    = array(
        'title'         => 'รับทำเว็บไซต์ website  ทำเว็บไซต์ eCommerce ออกแบบเว็บไซต์ รับทำเว็บไซต์ร้านค้าออนไลน์ รับทำเว็บขายสินค้า รับทำเว็บขายของ',
        'keywords'      => 'รับทำเว็บไซต์ website  ทำเว็บไซต์ eCommerce ออกแบบเว็บไซต์ รับทำเว็บไซต์ร้านค้าออนไลน์ รับทำเว็บขายสินค้า รับทำเว็บขายของ',
        'description'   => 'รับทำเว็บไซต์ website  ทำเว็บไซต์ eCommerce ออกแบบเว็บไซต์ รับทำเว็บไซต์ร้านค้าออนไลน์ รับทำเว็บขายสินค้า รับทำเว็บขายของ'
    );
}
if ($currentPage == 'email_marketing') {
    $aSeoMetaTag    = array(
        'title'         => 'MailChimp โปรแกรมส่ง Email Marketing',
        'keywords'      => 'ต้องการส่งเมล์จำนวนมากม  โปรแกรมส่ง Email Marketing ส่งเมล์เยอะ',
        'description'   => 'ต้องการส่งเมล์จำนวนมาก โปรแกรมส่ง Email Marketing '
    );
}

if ($currentPage == 'email_marketing_plan') {
    $aSeoMetaTag    = array(
        'title'         => 'MailChimp โปรแกรมส่ง Email Marketing',
        'keywords'      => 'ต้องการส่งเมล์จำนวนมากม  โปรแกรมส่ง Email Marketing ส่งเมล์เยอะ',
        'description'   => 'ต้องการส่งเมล์จำนวนมาก โปรแกรมส่ง Email Marketing '
    );
}

if ($currentPage == 'datacenter') {
    $aSeoMetaTag    = array(
        'title'         => 'Data Center | Colocation Server | Dedicated Server | ฝากวางเซิร์ฟเวอร์ โคโล | เช่าเซิร์ฟเวอร์ส่วนตัว ดาต้าเซ็นเตอร์ บริการตลอด 24 ชั่วโมง  ',
        'keywords'      => 'Data Center | Colocation Server | Dedicated Server | ฝากวางเซิร์ฟเวอร์ โคโล | เช่าเซิร์ฟเวอร์ส่วนตัว ดาต้าเซ็นเตอร์ บริการตลอด 24 ชั่วโมง ',
        'description'   => 'Netway Communication Co., Ltd. เราพร้อมตอบสนองความต้องการฝากวางเครื่องเซิร์ฟเวอร์ และเช่าเครื่องเซิร์ฟเวอร์ส่วนตัวสำหรับองค์กร ด้วยบริการ Colocation Server และ Dedicated Server บนโครงข่ายอินเตอร์เน็ตความเร็วสูง'
    );
}
if ($currentPage == 'colocation') {
    $aSeoMetaTag    = array(
        'title'         => 'Data Center | Colocation Server | Dedicated Server | ฝากวางเซิร์ฟเวอร์ โคโล | เช่าเซิร์ฟเวอร์ส่วนตัว ดาต้าเซ็นเตอร์ บริการตลอด 24 ชั่วโมง  ',
        'keywords'      => 'Data Center | Colocation Server | Dedicated Server | ฝากวางเซิร์ฟเวอร์ โคโล | เช่าเซิร์ฟเวอร์ส่วนตัว ดาต้าเซ็นเตอร์ บริการตลอด 24 ชั่วโมง ',
        'description'   => 'Netway Communication Co., Ltd. เราพร้อมตอบสนองความต้องการฝากวางเครื่องเซิร์ฟเวอร์ และเช่าเครื่องเซิร์ฟเวอร์ส่วนตัวสำหรับองค์กร ด้วยบริการ Colocation Server และ Dedicated Server บนโครงข่ายอินเตอร์เน็ตความเร็วสูง'
    );
}
if ($currentPage == 'dedicatedserver') {
    $aSeoMetaTag    = array(
        'title'         => 'Data Center | Colocation Server | Dedicated Server | ฝากวางเซิร์ฟเวอร์ โคโล | เช่าเซิร์ฟเวอร์ส่วนตัว ดาต้าเซ็นเตอร์ บริการตลอด 24 ชั่วโมง  ',
        'keywords'      => 'Data Center | Colocation Server | Dedicated Server | ฝากวางเซิร์ฟเวอร์ โคโล | เช่าเซิร์ฟเวอร์ส่วนตัว ดาต้าเซ็นเตอร์ บริการตลอด 24 ชั่วโมง ',
        'description'   => 'Netway Communication Co., Ltd. เราพร้อมตอบสนองความต้องการฝากวางเครื่องเซิร์ฟเวอร์ และเช่าเครื่องเซิร์ฟเวอร์ส่วนตัวสำหรับองค์กร ด้วยบริการ Colocation Server และ Dedicated Server บนโครงข่ายอินเตอร์เน็ตความเร็วสูง'
    );
}
if ($currentPage == 'managed_server_services') {
    $aSeoMetaTag    = array(
        'title'         => 'Managed Server Services by Netway | บริการดูแล จัดการ เพิ่มความปลอดภัย server',
        'keywords'      => 'Managed Server Services, บริการ Managed Server Services, บริการดูแลเครื่อง Server, ดูแลเซิรฟ์เวอร์ เช่าเครื่อง server',
        'description'   => 'บริการดูแลเครื่อง Server ที่คุณเลือกได้ตามความต้องการ เพิ่มความปลอดภัย และสะดวกรวดเร็วยิ่งขี้น, บริการดีตลอด 24 ชม. โทร 02-912-2558'
    );
}

if ($currentPage == 'privatecloud') {
    $aSeoMetaTag    = array(
        'title'         => 'Private Cloud',
        'keywords'      => 'cloud, cloud computing, private cloud, private cloud คือ, private cloud คืออะไร, private cloud ความหมาย, Cloud Hosting คือ, Cloud Hosting ความหมาย, private cloud ข้อดี, cloud ข้อดี, private cloud ดีอย่างไร, Hosting, Server Hosting, เช่า cloud hosting, เช่า cloud server, บริการให้เช่า cloud hosting, ระบบ Private Cloud, การใช้งาน private cloud, ทำ cloud server, cloud ส่วนตัว, คลาวด์ส่วนตัว, cloud ประหยัด, ป้องกันความเสียหายด้วยการสำรองข้อมูล, cloud ปลอดภัย, บริการคลาวด์24ชั่วโมง, Hosting ราคาถูก, โฮสติ้งราคาถูก, โฮสติ้งถูกๆ',
        'description'   => 'NETWAY Communication พร้อมให้บริการ Web Hosting, Server hosting, Cloud Hosting, ให้เช่าเครื่องเซิร์ฟเวอร์ (Dedicated server) , หรือบริการติดตั้ง Server ที่ศูนย์ Data Center (Co-location Server) ซึ่งศูนย์ Data Center ของเราตั้งอยู่ที่ CAT Telecom ซึ่งบริการทั้งหมดครอบคลุมความปลอดภัยด้วยระบบ Security ที่เหนือขั้นกว่า'
    );
}

if ($currentPage == 'office365') {
    $aSeoMetaTag    = array(
        'title'         => 'Office 365, Exchange E-mail, อีเมล ความปลอดภัยสูงสุดระดับ Enterprise Security',
        'keywords'      => 'Office 365, Exchange E-mail, Sharepoint , Lync, OneDrive, Office Online, ชุด Microsoft Office เวอร์ชันออนไลน ์',
        'description'   => 'Office 365, Exchange E-mail, Sharepoint , Lync, OneDrive, Office Online, ชุด Microsoft Office เวอร์ชันออนไลน ์'
    );
}

$this->assign('aSeoMetaTag', $aSeoMetaTag);
$this->assign('currentPage', $currentPage);
require_once(APPDIR . 'class.config.custom.php');
$webpackVersion    = ConfigCustom::singleton()->getValue('webpackVersion');
$this->assign('webpackVersion', $webpackVersion);
