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
$aConfiguration   = $this->get_template_vars('configuration');
// --- Get template variable ---

$aDepartments   = array();
$return = $api->getTicketDepts();

if ($return['success']) {
    $aDepartments   = $return['depts'];
}

$this->assign('aDepartments', $aDepartments);

/* --- ตั้งค่า config เพื่อใช้ใน form setting --- */
if (isset($aConfiguration['nwTechnicalContact'])) {
    $contactId      = $aConfiguration['nwTechnicalContact'];
    $aConfiguration['nwTechnicalContact']      = array();
    if ($contactId) {
        $result     = $db->query("
                    SELECT 
                        ca.id, ca.email,
                        cd.firstname, cd.lastname, cd.companyname, cd.address1, cd.address2,
                        cd.city, cd.state, cd.postcode, cd.country, cd.phonenumber
                    FROM  
                        hb_client_access ca,
                        hb_client_details cd
                    WHERE ca.id = :contactId
                        AND ca.id = cd.id
                    ", array(
                        ':contactId'    => $contactId
                    ))->fetch();
        if (isset($result['id'])) {
            foreach ($result as $k => $v) {
                $aConfiguration['nwTechnicalContact'][$k]   = $v;
            }
        } else {
            $aConfiguration['nwTechnicalContact']['id']  = 'ไม่พบข้อมูล contact id';
        }
    } else {
        $aConfiguration['nwTechnicalContact']['id']  = 'กรุณาระบุ contact id';
    }
}
$this->assign('aConfiguration', $aConfiguration);
