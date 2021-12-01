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
// --- Get template variable ---

if (isset($_GET['email'])) {
    $aSubmit    = array();
}

$aSubmit       = filter_input_array($aSubmit, [
    'firstname' => FILTER_SANITIZE_STRING,
    'lastname' => FILTER_SANITIZE_STRING,
    'companyname' => FILTER_SANITIZE_STRING,
    'field_taxid' => FILTER_SANITIZE_STRING,
    'field_departmentposition' => FILTER_SANITIZE_STRING,
    'field_address1' => FILTER_SANITIZE_STRING,
    'field_address2' => FILTER_SANITIZE_STRING,
    'field_city' => FILTER_SANITIZE_STRING,
    'field_state' => FILTER_SANITIZE_STRING,
    'postcode' => FILTER_SANITIZE_STRING,
    'field_phonenumber' => FILTER_SANITIZE_STRING,
    'field_fax' => FILTER_SANITIZE_STRING,
    'field_mobile' => FILTER_SANITIZE_STRING,
    'email' => FILTER_SANITIZE_EMAIL,
]);

$this->assign('useCustomSignupFrom', true);


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
                    
foreach ($aFields as $k => $v) {
    if (in_array($k, $aNotDomainField)) {
        continue;
    }
    if (in_array($k, $aIsDomainField)) {
        $aDomainFields[$k]  = $v;
    }
}

$this->assign('aDomainFields', $aDomainFields);

//echo '<pre>'.print_r($aFields, true).'</pre>';