<?php
/*
 * Smarty plugin
 * -------------------------------------------------------------
 * File:     function.item_desc.php
 * Type:     function
 * Name:     item_desc
 * Purpose:  ip
 * -------------------------------------------------------------
 */
function smarty_function_invoice_item_desc ($params, $template) {
    $db         = hbm_db();
    $output     = '';

    $aItem      = isset($params['item']) ? $params['item'] : array();

    $itemId     = isset($aItem['item_id']) ? $aItem['item_id'] : 0;
    $itemType   = isset($aItem['type']) ? $aItem['type'] : '';

    $itemDesc   = isset($aItem['description']) ? $aItem['description'] : '-';
    $output     = $itemDesc;
    if (preg_match('/trial/i', $itemDesc)) {
        return $output;
    }
    
    return $output;

    $accountId  = 0;

    if ($itemType == 'Hosting') {
        $result     = $db->query("
            SELECT *
            FROM hb_accounts
            WHERE id = :id
                AND product_id = 162
                AND status = 'Pending'
            ", array(
                ':id'   => $itemId
            ))->fetch();
        $accountId  = isset($result['id']) ? $result['id'] : 0;
    }
    
    if (! $accountId) {
        return $output;
    }

    preg_match('/\((\d{2}\/\d{2}\/\d{4})\s+\-\s+(\d{2}\/\d{2}\/\d{4})\)/i', $itemDesc, $match);
    if (isset($match[1]) && isset($match[2])) {
        $startDate  = $match[1];
        $date   = $startDate;
        $date   = substr($date,-4) .'-'. substr($date,3,2) .'-'. substr($date,0,2);
        $startDateNew   = date('d/m/Y', strtotime('+30 day', strtotime($date)));
        $endDate    = $match[2];
        $date   = $endDate;
        $date   = substr($date,-4) .'-'. substr($date,3,2) .'-'. substr($date,0,2);
        $endDateNew     = date('d/m/Y', strtotime('+30 day', strtotime($date)));
        $itemDesc   = str_replace($startDate, $startDateNew, $itemDesc);
        $itemDesc   = str_replace($endDate, $endDateNew, $itemDesc);
        $itemDesc   .= "\n".'+ Free trial 30 Days.';
    }
    
    $output     = $itemDesc;
    
    return $output;
}
