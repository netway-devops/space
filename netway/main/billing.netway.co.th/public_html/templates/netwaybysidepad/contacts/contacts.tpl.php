<?php
// Depending on HostBill application.
if ( ! defined('HBF_APPNAME')) {
    exit;
}


// --- hostbill helper ---
$api        = new ApiWrapper();
$db         = hbm_db();
$client     = hbm_logged_client();
$oClient    = isset($client['id']) ? (object) $client : null;
// --- hostbill helper ---


// --- Get template variable ---
$aProfiles          = $this->get_template_vars('profiles');
// --- Get template variable ---

$this->assign('oClient', $oClient);
$this->assign('act', (isset($_GET['act']) ? $_GET['act'] : ''));

if (count($aProfiles)) {
    $aContactId     = array();
    foreach ($aProfiles as $arr) {
        array_push($aContactId, $arr['id']);
    }
    
    $aIsUnableToDelete      = array();
    
    $result         = $db->query("
            SELECT
                i.billing_contact_id, i.mailing_contact_id
            FROM
                hb_invoices i
            WHERE
                ( i.billing_contact_id IN (". implode(',', $aContactId) .")
                OR i.mailing_contact_id IN (". implode(',', $aContactId) .") )
            UNION (
                SELECT
                    a.billing_contact_id, a.mailing_contact_id
                FROM
                    hb_accounts a
                WHERE
                    ( a.billing_contact_id IN (". implode(',', $aContactId) .")
                    OR a.mailing_contact_id IN (". implode(',', $aContactId) .") )
            )
            UNION (
                SELECT
                    d.billing_contact_id, d.mailing_contact_id
                FROM
                    hb_domains d
                WHERE
                    ( d.billing_contact_id IN (". implode(',', $aContactId) .")
                    OR d.mailing_contact_id IN (". implode(',', $aContactId) .") )
            )
            ")->fetchAll();
    
    if (count($result)) {
        foreach ($result as $arr) {
            if (! in_array($arr['billing_contact_id'], $aIsUnableToDelete)) {
                array_push($aIsUnableToDelete, $arr['billing_contact_id']);
            }
            if (! in_array($arr['mailing_contact_id'], $aIsUnableToDelete)) {
                array_push($aIsUnableToDelete, $arr['mailing_contact_id']);
            }
        }
    }
    
    $this->assign('aIsUnableToDelete', $aIsUnableToDelete);
    
    /* --- ดึงข้อมูล customfield addresstype  --- */
    $result         = $db->query("
                SELECT
                    cf.id, cf.default_value
                FROM
                    hb_client_fields cf
                WHERE
                    cf.code = 'addresstype'
                ")->fetch();
    $cfId           = isset($result['id']) ? $result['id'] : 0;
    
    $aContacts      = array();
    
    $result         = $db->query("
                SELECT
                    cd.*,
                    cfv.value AS addressType
                FROM
                    hb_client_details cd
                    LEFT JOIN hb_client_fields_values cfv
                        ON cfv.client_id = cd.id
                        AND cfv.field_id = :cfId
                WHERE
                    cd.id IN (". implode(',', $aContactId) .")
                ", array(
                    ':cfId'         => $cfId
                ))->fetchAll();
    if (count($result)) {
        foreach ($result as $arr) {
            $aContacts[$arr['id']]  = (object) $arr;
            
        }
    }
    
    $this->assign('aContacts', $aContacts);
    
}


/* --- แสดง notification summary --- */

if (count($aProfiles)) {
    foreach ($aProfiles as $aProfile) {
        $profileId          = $aProfile['id'];
        $notifyInfo         = '';
        
        if ( $aContacts[$profileId]->addressType != 'Notify') {
            continue;
        }
        
        $result         = $db->query("
                    SELECT
                        cp.*
                    FROM
                        hb_client_privileges cp
                    WHERE
                        cp.client_id = :profileId
                    ", array(
                        ':profileId'    => $profileId
                    ))->fetch();
        
        if (! isset($result['client_id'])) {
            continue;
        }
        
        $aPrivilege     = unserialize($result['privileges']);
        
        if (isset($aPrivilege['domains']) && count($aPrivilege['domains'])) {
            
            $allDomain  = array();
            foreach ($aPrivilege['domains'] as $k => $v) {
                if ($v['notify']) {
                    array_push($allDomain, $k);
                }
            }
            
            if (count($allDomain)) {
                $result     = $db->query("
                        SELECT
                            d.id
                        FROM
                            hb_domains d
                        WHERE
                            d.id NOT IN (". implode(',', $allDomain) .")
                            AND d.client_id = :clientId
                        ", array(
                            ':clientId'     => $oClient->id
                        ))->fetch();
            
                $notifyInfo .= isset($result['id']) ? 'By Domain' : 'All domain';
            }
        }
        
        if (isset($aPrivilege['services']) && count($aPrivilege['services'])) {
            
            $allService  = array();
            foreach ($aPrivilege['services'] as $k => $v) {
                if ($v['notify']) {
                    array_push($allService, $k);
                }
            }
            
            if (count($allService)) {
                $result     = $db->query("
                        SELECT
                            a.id
                        FROM
                            hb_accounts a
                        WHERE
                            a.id NOT IN (". implode(',', $allService) .")
                            AND a.client_id = :clientId
                        ", array(
                            ':clientId'     => $oClient->id
                        ))->fetch();
                
                $notifyInfo .= isset($result['id']) ? ', By Service' : ', All service';
            }
            
        }
        
        $aContacts[$profileId]->notifyInfo  = $notifyInfo;
        
    }
    
    $this->assign('aContacts', $aContacts);
}


//echo '<pre>'.print_r($oClient, true).'</pre>';