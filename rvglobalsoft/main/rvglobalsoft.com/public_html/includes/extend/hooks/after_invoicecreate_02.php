<?php

/**
 * New invoice has just been created with ID=$details
 *  This event is called after every items saved for the invoice.
 *  So if you will get this event you will be sure that invoice has been successfully created.
 * Following variable is available to use in this file:  $details This variable keeps invoice id
 */

// --- hostbill helper ---
$db         = hbm_db();
// --- hostbill helper ---

/**
 * ไม่แสดงระยะสัญญา สำหรับ service ที่พึ่งสั่งซื้อ
 * SMEs  Hosting - LH-1- Linux Economy plan demo-no-term.com (02/05/2013 - 02/06/2013)
 */

$invoiceId  = $details;
$listip     = '';

$result     = $db->query("
    SELECT 
        ii.id, ii.type, ii.item_id, ii.description
    FROM 
        hb_invoices i,
        hb_invoice_items ii
    WHERE 
        i.id = :invoiceId
        AND i.id = ii.invoice_id
        AND ii.type IN ('Hosting','Addon')
", array(
    ':invoiceId' => $invoiceId
))->fetchAll();

if (count($result)) 
{
    $aDatas = $result;
    foreach ($aDatas as $data) 
    {
        $invoiceItemId  = $data['id'];
        $itemId         = $data['item_id'];
        /* --- ต้องเป็น new order --- */
        if ($data['type'] == 'Hosting') 
        {
            $result = $db->query("
                SELECT 
                    a.id
                FROM 
                    hb_accounts a
                WHERE 
                    a.id = :itemId
                    AND a.status = 'Pending'
            ", array(
                ':itemId' => $itemId
            ))->fetch();
            
            //=== 1. สำหรับ product partner ===
            $aProductPartnerSK = array(73, 74, 75, 76);
            $aProductPartnerSB = array(77, 78, 79, 80);
            
            $aProductid = $db->query("
                SELECT 
                    product_id 
                FROM 
                    hb_accounts 
                WHERE 
                    id=:itemId
            ", array(
                ':itemId' => $itemId
            ))->fetch();
            
            if (in_array($aProductid['product_id'], $aProductPartnerSK)) 
            {

                $listSK = '';
                $aData  = $db->query("
                    SELECT 
                        u.main_ip 
                    FROM 
                        rvskin_license u
                    WHERE 
                        u.hb_acc =:itemid
                    ORDER BY
                        u.license_id DESC      
                ", array(
                    ':itemid' => $itemId
                ))->fetchall();
                
                if (count($aData) > 0) 
                {
                    foreach ($aData as $k => $v) 
                    {
                        $listSK .= $v['main_ip']."\n";
                    }
                }
                
                //$listSK = getListLicensePartnerSK333($itemId);
                if ($listSK != '') 
                {
                    //=== loop update invoice note
                    $qty = $db->query("
                        SELECT 
                            hca.data 
                        FROM 
                            hb_accounts acc
                            , hb_config_items_cat hc
                            , hb_config2accounts hca
                        WHERE
                            acc.product_id = hc.product_id
                            AND hc.id = hca.config_cat
                            AND acc.id  = hca.account_id
                            AND hc.variable = 'quantity'
                            AND acc.id =:accid
                    ", array(
                        ':accid' => $itemId
                    ))->fetch();
                    
                    if (isset($qty['data']) && $qty['data'] != '') 
                    {
                        $qty = $qty['data'];
                    } 
                    else 
                    {
                        $qty = 0;
                    }
                    
                    $desc   = $data['description'];
                    $desc   = preg_replace('/(\(\d{2}\/\d{2}\/\d{4}\s\-\s\d{2}\/\d{2}\/\d{4}\))/', ' $1 - '. $qty.' licenses', $desc);
                    
                    $resup  = $db->query("
                        UPDATE 
                            hb_invoice_items
                        SET 
                            description = :itemDesc
                        WHERE 
                            id = :invoiceItemId
                    ", array(
                        ':itemDesc'         => $desc, 
                        ':invoiceItemId'    => $invoiceItemId
                    ));
                    
                    $descSK = $data['description'];
                    $descSK = preg_replace('/(\(\d{2}\/\d{2}\/\d{4}\s\-\s\d{2}\/\d{2}\/\d{4}\))/', '', $descSK);
                    $listip .= "====== PRODUCT NAME : " . $descSK . "======\n";
                }

                $listip .= $listSK;
                continue;
                
            } 
            elseif (in_array($aProductid['product_id'], $aProductPartnerSB)) 
            {
                $listSB = '';
                $aData  = $db->query("
                    SELECT 
                        u.primary_ip
                    FROM 
                        rvsitebuilder_license u
                    WHERE 
                        u.hb_acc = :itemid
                    ORDER BY
                        u.license_id DESC 
                ", array(
                    ':itemid' => $itemId
                ))->fetchall();
                
                if (count($aData) > 0) 
                {
                    foreach ($aData as $k => $v) 
                    {
                        $listSB .= $v['primary_ip']."\n";
                    }
                }
                
                if ($listSB != '') 
                {
                    $qty = $db->query("
                        SELECT 
                            hca.data 
                        FROM 
                            hb_accounts acc
                            , hb_config_items_cat hc
                            , hb_config2accounts hca
                        WHERE
                            acc.product_id = hc.product_id
                            AND hc.id = hca.config_cat
                            AND acc.id  = hca.account_id
                            AND hc.variable = 'quantity'
                            AND acc.id =:accid
                    ", array(
                        ':accid' => $itemId
                    ))->fetch();
                    
                    if (isset($qty['data']) && $qty['data'] != '') 
                    {
                        $qty = $qty['data'];
                    } 
                    else 
                    {
                        $qty = 0;
                    }
                    
                    $desc   = $data['description'];
                    /*
                     * https://rvglobalsoft.com/7944web/?cmd=accounts&action=edit&id=16667&list=all 
                     * $desc   = preg_replace('/(\(\d{2}\/\d{2}\/\d{4}\s\-\s\d{2}\/\d{2}\/\d{4}\))/', ' $1 - '.$qty.' licenses', $desc);
                    */
                    $desc   = preg_replace('/(\((\d{2}\/\d{2}\/\d{4})\s\-\s\d{2}\/\d{2}\/\d{4}\))/', ' Licenses amount counted on $2 - '.$qty.' licenses', $desc);
                    $resup  = $db->query("
                        UPDATE 
                            hb_invoice_items
                        SET 
                            description = :itemDesc
                        WHERE 
                            id = :invoiceItemId
                    ", array(
                        ':itemDesc'         => $desc, 
                        ':invoiceItemId'    => $invoiceItemId
                    ));
                    
                    $descSB = $data['description'];
                    $descSB = preg_replace('/(\(\d{2}\/\d{2}\/\d{4}\s\-\s\d{2}\/\d{2}\/\d{4}\))/', '', $descSB);
                    $listip .= "====== PRODUCT NAME : " . $descSB . "======\n";
                }

                $listip .= $listSB;
                continue;
                
            }

            //=== 2. สำหรับ product ที่มี ip ===
            $resultIP = $db->query("
                SELECT 
                    ac.data 
                FROM 
                    hb_accounts acc
                    INNER JOIN 
                        hb_config2accounts ac 
                    ON 
                        ( acc.id = ac.account_id )
                    INNER JOIN 
                        hb_config_items_cat f 
                    ON 
                        ( ac.config_cat = f.id )
                WHERE  
                    acc.id = :itemId
                    AND f.variable = 'ip'
            ", array(
                ':itemId' => $itemId
            ))->fetch();
            
            if (isset($resultIP['data']) OR $resultIP['data'] != '') 
            {
                $desc = $data['description'];
                
                if ( ! isset($result['id']) OR ! $result['id']) 
                {
                    $desc = preg_replace('/(\(\d{2}\/\d{2}\/\d{4}\s\-\s\d{2}\/\d{2}\/\d{4}\))/', $resultIP['data'].' $1', $desc);
                } 
                else 
                {
                    $desc = preg_replace('/(\(\d{2}\/\d{2}\/\d{4}\s\-\s\d{2}\/\d{2}\/\d{4}\))/', $resultIP['data'].' <!--$1-->', $desc);
                }
                
                $resup = $db -> query("
                    UPDATE 
                        hb_invoice_items
                    SET 
                        description = :itemDesc
                    WHERE 
                        id = :invoiceItemId
                ", array(
                    ':itemDesc'         => $desc, 
                    ':invoiceItemId'    => $invoiceItemId
                ));
                
                continue;
                
            }

            if ( ! isset($result['id']) OR ! $result['id']) 
            {
                continue;
            }
            
        } 
        elseif ($data['type'] == 'Addon') 
        {
            $result = $db -> query("
                SELECT 
                	aa.id
                FROM 
                	hb_accounts_addons aa
                WHERE 
                    aa.id = :itemId
                    AND aa.status = 'Pending'
            ", array(
                ':itemId' => $itemId
            ))->fetch();
                
            if ( ! isset($result['id']) || ! $result['id']) 
            {
                continue;
            }
        }

        $desc = $data['description'];
        $desc = preg_replace('/(\(\d{2}\/\d{2}\/\d{4}\s\-\s\d{2}\/\d{2}\/\d{4}\))/', '<!--$1-->', $desc);

        $db->query("
            UPDATE 
            	hb_invoice_items
            SET 
            	description = :itemDesc
            WHERE 
            	id = :invoiceItemId
        ", array(
            ':itemDesc'         => $desc, 
            ':invoiceItemId'    => $invoiceItemId
        ));

    }
}

if ($listip != '') 
{
    $db->query("
        UPDATE 
            hb_invoices
        SET 
            notes = :noteip
        WHERE 
            id = :invoiceId
    ", array(
        ':noteip'       => $listip, 
        ':invoiceId'    => $invoiceId
    ));
}
