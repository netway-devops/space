<?php

/**
 * ตั้งค่า Order Status 
 * จากหน้าสั่งซื้อ license ที่มีการเพิ่มเรื่องของ order status transfer ทำให้ต้องมา update Account status : Transfer Request
 */

$db             = hbm_db();
$orderId        = $details;

$result         = $db->query("
        SELECT
            a.id
        FROM
            hb_accounts a
        WHERE
            a.order_id = :orderId
        ", array(
            ':orderId'      => $orderId
        ))->fetchAll();

if (count($result)) {
    foreach ($result as $aAccount) {
        $accountId      = $aAccount['id'];
        
        $result         = $db->query("
                SELECT
                    c2a.*
                FROM
                    hb_config2accounts c2a,
                    hb_config_items_cat cic
                WHERE
                    c2a.account_id = :accountId
                    AND c2a.rel_type = 'Hosting'
                    AND c2a.config_cat = cic.id
                    AND cic.variable = 'order_type'
                ", array(
                    ':accountId'    => $accountId,
                ))->fetch();
        
        if (! isset($result['data'])) {
            continue;
        }
        if ($result['data'] != 'Transfer') {
            continue;
        }
        
        $db->query("UPDATE hb_accounts SET status = 'Transfer Request' WHERE id =:id ", array(':id' => $accountId));
        
    }
}

