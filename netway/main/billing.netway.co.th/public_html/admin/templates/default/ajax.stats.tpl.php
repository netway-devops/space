<?php
// Depending on HostBill application.
if ( ! defined('HBF_APPNAME')) {
    exit;
}

// --- hostbill helper ---
$db         = hbm_db();
// --- hostbill helper ---

// --- Get template variable ---
$action         = $this->get_template_vars('action');
$dateFrom       = $this->get_template_vars('dateFrom');
$dateTo         = $this->get_template_vars('dateTo');
// --- Get template variable ---


if ($action == 'ticketsgen' &&  $dateFrom && $dateTo) {
    
    $aAverages          = array();
    
    while ($dateFrom != $dateTo) {
        $i++;
        if ($i > 31) {
            break;
        }
        
        $startDate      = date('Y-m-d H:i:s', strtotime($dateFrom));
        $endDate        = date('Y-m-d H:i:s', strtotime('+1 day', strtotime($dateFrom)) -1 );
        
        $result         = $db->query("
                SELECT AVG(sub.timediff) avg_response,
                    AVG(TIMESTAMPDIFF(SECOND, tc.date, tc.lastupdate )) avg_resolve  FROM (
                        SELECT t.id, TIMESTAMPDIFF(SECOND, t.date, MIN(r.date) ) `timediff` 
                        FROM hb_tickets t 
                        JOIN hb_ticket_replies r ON t.id=r.ticket_id AND r.`type`='Admin'
                        WHERE t.date >= :startDate AND t.date <= :endDate
                        GROUP BY r.ticket_id ORDER BY t.date ASC, r.date ASC
                    ) sub
                    LEFT JOIN hb_tickets tc ON tc.id=sub.id AND tc.`status`='Closed'
                ", array(
                    ':startDate'    => $startDate,
                    ':endDate'      => $endDate
                ))->fetch();
        
        if (isset($result['avg_response'])) {
            $aAverages[$dateFrom]   = array(
                    'avg_response'      => floor($result['avg_response'] / (60*60)).':'.ceil($result['avg_response']%60),
                    'avg_resolve'       => floor($result['avg_resolve'] / (60*60)).':'.ceil($result['avg_resolve']%60)
                );
        }
        
        $dateFrom       = date('Y-m-d', strtotime('+1 day', strtotime($dateFrom)));
        
    }
    
    $this->assign('aAverages', $aAverages);
    
}


if ($action == 'incomebyservice' &&  $dateFrom && $dateTo) {
    $result     = $db->query("
        SELECT
        cat.name AS cname, p.name AS `name`, SUM(it.`amount`) AS `total`, i.currency_id
        FROM hb_invoices i
        JOIN hb_invoice_items it ON (it.invoice_id=i.id)
        LEFT JOIN hb_currencies c ON c.id=i.currency_id
        JOIN hb_accounts a ON (a.id=it.item_id AND it.type='Hosting')
        JOIN hb_products p ON (p.id=a.product_id)
        JOIN hb_categories cat ON (cat.id=p.category_id)
        WHERE i.status='Paid'
        AND
        i.`datepaid`>= '{$dateFrom} 00:00:00'
        AND i.`datepaid`<= '{$dateTo} 23:59:59'
        GROUP BY p.id, i.currency_id
        ORDER BY `total` DESC
        ")->fetchAll();
    
    $aTick      = $this->get_template_vars('tick');

    if (count($aTick)) {
        $aTick_     = $aTick;
        foreach ($aTick_ as $k => $arr) {
            $aTick[$k][0]  = (isset($result[$k]['cname']) ? $result[$k]['cname'] : '') . ' : ' . $arr[0];

        }
    }
    $this->assign('tick', $aTick);

}

//echo '<pre>'.print_r($aAverages, true).'</pre>';