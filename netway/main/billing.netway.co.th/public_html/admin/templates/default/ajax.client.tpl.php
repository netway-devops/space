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
$aStats             = $this->get_template_vars('stats');
$clientId           = $this->get_template_vars('client_id');
$action             = $this->get_template_vars('action');

$perpage            = $this->get_template_vars('perpage');
$contacts           = $this->get_template_vars('contacts');

// --- Get template variable ---

$aClientBilling     = $db->query("
                    SELECT cb.credit, cb.credit_swap
                    FROM hb_client_billing cb
                    WHERE cb.client_id = :clientId
                    ", array(
                        ':clientId' => $clientId
                    ))->fetch();
if (isset($aClientBilling['credit_swap']) && $aClientBilling['credit_swap'] > 0) {
    $aStats['credit_swap']      = $aClientBilling['credit_swap'];
    $aStats['credit_total']     = $aStats['credit'] + $aStats['credit_swap'];
}


$this->assign('aStats', $aStats);


/* --- สามารถ filter contact address ของ client ได้ --- */
if ($action == 'clientcontacts' && $clientId) {
    
    $result         = $db->query("
                SELECT
                    COUNT(cd.id) AS total
                FROM
                    hb_client_details cd,
                    hb_client_access ca
                WHERE
                    cd.parent_id = :clientId
                    AND cd.id = ca.id
                    AND ca.status = 'Active'
                ", array(
                    ':clientId'     => $clientId
                ))->fetch();
    
    $allTotal       = isset($result['total']) ? $result['total'] : 0;
    $this->assign('allTotal', $allTotal);
    
    $result         = $db->query("
                SELECT
                    cf.id, cf.default_value
                FROM
                    hb_client_fields cf
                WHERE
                    cf.code = 'addresstype'
                ")->fetch();
    if (isset($result['id'])) {
        $cfId           = $result['id'];
        $aAddressType   = explode(';', $result['default_value']);
        
        if (count($aAddressType)) {
            
            $result     = $db->query("
                    SELECT
                        cfv.value AS address_type, COUNT(cfv.value) AS total
                    FROM
                        hb_client_details cd,
                        hb_client_access ca,
                        hb_client_fields_values cfv
                    WHERE
                        cd.parent_id = :clientId
                        AND cd.id = ca.id
                        AND ca.status = 'Active'
                        AND cd.id = cfv.client_id
                        AND cfv.field_id = :fieldId
                    GROUP BY cfv.value
                    ", array(
                        ':clientId'     => $clientId,
                        ':fieldId'      => $cfId
                    ))->fetchAll();
            
            if (count($result)) {
                $aTotal         = $result;
                $this->assign('aTotal', $aTotal);
            }
            
        }
        
    }
    
    $addressType        = isset($_GET['addressType']) ? $_GET['addressType'] : $_POST['addressType'];
    $this->assign('addressType', $addressType);
    
    if ($addressType && isset($aTotal) && isset($cfId)) {
        
        $page           = isset($_GET['page']) ? $_GET['page'] : $_POST['page'];
        $total          = 0;
        if (count($aTotal)) {
            foreach ($aTotal as $v) {
                if ($v['address_type'] == $addressType) {
                    $total  = $v['total'];
                }
            }
        }
        
        /* --- list contact address with filter --- */
        $totalpages     = ceil($total / $perpage);
        $limit          = $perpage;
        $offset         = ($page * $perpage);
        
        $this->assign('totalpages', $totalpages);
        
        $result         = $db->query("
                    SELECT
                        ca.id, cd.firstname, cd.lastname, cd.datecreated, ca.email
                    FROM
                        hb_client_details cd,
                        hb_client_access ca,
                        hb_client_fields_values cfv
                    WHERE
                        cd.parent_id = :clientId
                        AND cd.id = ca.id
                        AND ca.status = 'Active'
                        AND cd.id = cfv.client_id
                        AND cfv.field_id = :fieldId
                        AND cfv.value = :addressType
                    ORDER BY cd.id DESC LIMIT {$offset}, {$limit}
                    ", array(
                        ':clientId'     => $clientId,
                        ':fieldId'      => $cfId,
                        ':addressType'  => $addressType
                    ))->fetchAll();
        if (count($result)) {
            $this->assign('contacts', $result);
        }
        
        
    }
    
}
