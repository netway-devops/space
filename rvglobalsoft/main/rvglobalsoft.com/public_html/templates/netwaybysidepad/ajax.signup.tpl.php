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
$aSubmit    = $this->get_template_vars('submit');
$aFields    = $this->get_template_vars('fields');
$aCountry   = $this->get_template_vars('countries');
unset($aCountry['TH']);
$this->assign('countries', $aCountry);
// --- Get template variable ---


$address            = isset($aSubmit['mailingaddress']) ?  $aSubmit['mailingaddress'] : '';
$mailingAddress     = preg_match('/ชื่อผู้รับ\:(.*)ที่อยู่\:(.*)จังหวัด\:(.*)รหัสไปรษณีย์\:(.*)/ism', $address, $matches);

$this->assign('isMailingAddress',  (isset($matches[0]) && trim($matches[0])) ? true : false);
$this->assign('mAddrPerson',       isset($matches[1]) ? trim($matches[1]) : '');
$this->assign('mAddrAddress',      isset($matches[2]) ? trim($matches[2]) : '');
$this->assign('mAddrProvince',     isset($matches[3]) ? trim($matches[3]) : '');
$this->assign('mAddrZipcode',      isset($matches[4]) ? trim($matches[4]) : '');


/* --- มันใช้หน้า register สำหรับ domain contact ดังนั้นต้อง skip บาง field ที่ไม่เกี่ยวกับ domain --- */
if (isset($_GET['domaincontact']) && $_GET['domaincontact']) {
    $isDomainContactForm    = true;
    $this->assign('isDomainContactForm', $isDomainContactForm);
    
    /* --- domain contact data --- */
    if (isset($_GET['cid']) && $_GET['cid']  && intval($_GET['cid'])) {
        $cid        = intval($_GET['cid']);
        $result     = $db->query("
                    SELECT 
                        ca.id, ca.email,
                        cd.firstname, cd.lastname, cd.companyname, cd.address1, cd.address2,
                        cd.city, cd.state, cd.postcode, cd.country, cd.phonenumber
                    FROM  
                        hb_client_access ca,
                        hb_client_details cd
                    WHERE ca.id = :cid
                        AND ca.id = cd.id
                    ", array(
                        ':cid'    => $cid
                    ))->fetch();
        if (isset($result['id'])) {
            unset($result['id']);
            foreach ($result as $k => $v) {
                $aSubmit[$k]   = $v;
            }
            $this->assign('submit', $aSubmit);
        }
    }
        
}


/* --- domain contact form --- */
$aNotDomainField    = array();
$aDomainFields      = array();
$aDomainFields['type']          = $aFields['type'];
array_push($aNotDomainField, 'type');
$aDomainFields['companyname']   = $aFields['companyname'];
array_push($aNotDomainField, 'companyname');

$aIsDomainField     = array(
                        'email', 'firstname', 'lastname', 
                        'address1', 'address2', 
                        'city', 'state', 'postcode', 
                        'country', 'phonenumber'
                    );
$acountry = $aFields['country'];
unset($aFields['country']);
$aNewFields =  array();         

foreach ($aFields as $k => $v) {
    if ($k == 'companyname'){
        $aNewFields['companyname'] = $v;
        $aNewFields['country'] = $acountry;
		//=== case add contact ฝั่ง client มันไม่มีตัวแปร companyname
    } elseif (!isset($aFields['companyname']) && $k == 'address2') {
    	 $aNewFields['address2'] = $v;
		 $aNewFields['country'] = $acountry;
    } else {
         $aNewFields[$k] = $v;
    }
     
    if (in_array($k, $aNotDomainField)) {
        continue;
    }
    if (in_array($k, $aIsDomainField)) {
        $aDomainFields[$k]  = $v;
    }
}
$aFields = $aNewFields;

$this->assign('fields', $aFields);
$this->assign('aDomainFields', $aDomainFields);
