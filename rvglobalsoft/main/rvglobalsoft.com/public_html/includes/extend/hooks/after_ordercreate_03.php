<?php

/**
 * New order has been placed
 * Following variable is available to use in this file:  $details is ID property in hb_orders table
 * update product sub : เวลาที่สั่งซื้อแล้วมี sub product ด้วย เวลาใส่ค่า ip ก็เอา ip นี้ไปบันทึกลงที่แต่ละ product ด้วย
 */


// --- hostbill helper ---
$db         = hbm_db();
// --- hostbill helper ---

$orderId    = $details;


$aOrder     = $db->query("
        SELECT 
        	id, client_id, product_id, parent_id
        FROM 
        	hb_accounts
        WHERE 
        	order_id = :orderId
        ORDER BY 
            parent_id ASC
        ", array(
        	':orderId' => $orderId
        ))->fetchall();
if(count($aOrder)){
	
    $aConfigs   = array();
    
    foreach ($aOrder as $k => $v) {
        
        $productId  = $v['product_id'];
        $accountId  = $v['id'];
        
        if ($k == 0) {
            $result     = $db->query("
                SELECT c2a.data, cic.variable
                FROM hb_config2accounts c2a,
                    hb_config_items_cat cic
                WHERE c2a.account_id = '{$accountId}'
                    AND c2a.rel_type = 'Hosting'
                    AND c2a.config_cat = cic.id
                    AND ( cic.variable = 'ip' OR cic.variable = 'public_ip' OR cic.variable = 'order_type' )
                ")->fetchall();
            if (count($result)) {
                foreach ($result as $k => $v) {
                    $aConfigs[$v['variable']] = $v['data'];
                }
            }
            continue;
        }
        
        $aConfig    = array();
        
        $result     = $db->query("
            SELECT ci.id AS configId, cic.id AS configCatId, cic.variable
            FROM hb_config_items_cat cic,
                hb_config_items ci
            WHERE cic.product_id = '{$productId}'
                AND cic.id = ci.category_id
                AND ( cic.variable = 'ip' OR cic.variable = 'public_ip' OR cic.variable = 'order_type' )
            ")->fetchall();
        if (count($result)) {
            foreach ($result as $k => $v) {
                $aConfig[$v['variable']]  = $v;
            }
        }
        
        foreach ($aConfig as $var => $arr) {
            $configId       = $arr['configId'];
            $configCatId    = $arr['configCatId'];
            if (isset($aConfigs[$var]) && $aConfigs[$var]) {
                $result     = $db->query("
                      SELECT *
                      FROM hb_config2accounts
                      WHERE rel_type = 'Hosting'
                          AND account_id = :account_id
                          AND config_id = :config_id
                      ", array(
                            ':account_id'   => $accountId, 
                            ':config_id'    => $configId
                      ))->fetch();
                  if (! isset($result['account_id'])) {
                      $db->query("
                            INSERT INTO hb_config2accounts (
                            rel_type, account_id, config_cat, config_id, qty, data
                            ) VALUES (
                            :rel_type, :account_id, :config_cat, :config_id, :qty, :data
                            )
                            ", array(
                            ':rel_type'     => 'Hosting',
                            ':account_id'   => $accountId, 
                            ':config_cat'   => $configCatId, 
                            ':config_id'    => $configId,
                            ':qty'          => 1,
                            ':data'         => $aConfigs[$var],
                        ));
                  } else if ($result['data'] == '') {
                      $db->query("
                        UPDATE hb_config2accounts
                        SET data = :data
                        WHERE rel_type = 'Hosting'
                            AND account_id = :account_id
                            AND config_id = :config_id
                        ", array(
                            ':data'         => $aConfigs[$var],
                            ':account_id'   => $accountId,
                            ':config_id'    => $configId
                        ));
                  }
            }
        }
        
    }
}





