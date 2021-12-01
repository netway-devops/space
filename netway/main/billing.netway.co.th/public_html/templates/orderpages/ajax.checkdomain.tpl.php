<?php
// Depending on HostBill application.
if ( ! defined('HBF_APPNAME')) {
    exit;
}

// --- hostbill helper ---
$api        = new ApiWrapper();
$db         = hbm_db();
$aClient    = hbm_logged_client();
$aAdmin     = hbm_logged_admin();
// --- hostbill helper ---

// --- Get template variable ---
$aCheck     = $this->get_template_vars('check');
// --- Get template variable ---

$aChecks    = $aCheck;

if (isset($aAdmin['id'])) {
    //echo '<pre>'.print_r($aCheck, true).'</pre>';
}

if (count($aCheck)) {
    foreach ($aCheck as $k => $aData) {
        $sld        = isset($aData['sld']) ? $aData['sld'] : '';
        $tld        = isset($aData['tld']) ? $aData['tld'] : '';
        $categoryId = 1;
        if (preg_match('/^xn\-\-/i', $sld)) {
            $categoryId     = 121;
        }

        $result     = $db->query("
            SELECT id
            FROM hb_products
            WHERE name = :tld
                AND category_id = :category_id
            ", array(
                ':tld'          => $tld,
                ':category_id'  => $categoryId,
            ))->fetch();
        
        $productId  = isset($result['id']) ? $result['id'] : 0;
        
        if ($productId) {
            $aChecks[$k]['prices']  = array();

            $result     = $db->query("
                SELECT *
                FROM hb_domain_periods
                WHERE product_id = :product_id
                ORDER BY period ASC
                ", array(
                    ':product_id'   => $productId,
                ))->fetchAll();
            
            if (count($result)) {
                foreach ($result as $arr) {
                    $arr['id']      = $productId;
                    $arr['tld']     = $tld;
                    array_push($aChecks[$k]['prices'], $arr);
                }
            }

        }
        
    }
}

$this->assign('check', $aChecks);

