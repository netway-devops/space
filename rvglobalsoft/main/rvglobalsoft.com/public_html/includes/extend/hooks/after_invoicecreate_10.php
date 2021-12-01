<?php
$api            = new ApiWrapper();

 // --- hostbill helper ---
 $db         = hbm_db();
 // --- hostbill helper ---

$invoiceId      = $details;
$params         = array(
    'id' => $invoiceId 
);

$invoiceDetail  = $api->getInvoiceDetails($params);

if ($invoiceDetail['success'] == 'true' && isset($invoiceDetail['invoice']['client']['partner']))
{
    if ($invoiceDetail['invoice']['client']['partner'] == 'minimum invoice')
    {
        $min        = 0;
        $haveNocLic = FALSE;
        
        foreach ($invoiceDetail['invoice']['items'] as $item) 
        {
            if ($item['type'] == 'Hosting' && preg_match('/^NOC\s+Licenses(\s+)?\-/i', $item['description'])) 
            {
                $haveNocLic     = TRUE;
                $result         = $db->query("
                    SELECT
                        p.category_id as cid
                    FROM
                        hb_accounts a
                    INNER JOIN 
                        hb_products p
                        ON 
                            (a.product_id = p.id)
                    WHERE
                        a.id = :itemId
                ", array(
                    ':itemId'   => $item['item_id']
                ))->fetch();

                if($result['cid'] == 8)
                {
                    $min += $item['amount'];
                }
            }
        } /// endforeach
            
        if($haveNocLic == TRUE && $min < $invoiceDetail['invoice']['client']['minimuminvoice'] )
        {
            $difference     = $invoiceDetail['invoice']['client']['minimuminvoice']-$min;
            $newInvoiceItem = array(
                'id'    => $invoiceId,
                'line'  => 'add-back item based committed minimum value',
                'price' => $difference,
                'qty'   => 1,
                'tax'   => 0
            );
            
            $api->addInvoiceItem($newInvoiceItem);
            /// ตรวจดูว่าลูกค้ามีเคดิตอยู่หรือไม่ ถ้ามีให้หักเคดิตด้วย
            $a_client_details = $api->getClientDetails(array('id' => $invoiceDetail['invoice']['client_id']));
            
            if ($a_client_details['client']['credit'] > 0) 
            {
                $item_credit        = $min;
                $back_item_credit   = 0;
                $total_credit       = 0;
                $invoice_status     = '';

                if ($a_client_details['client']['credit'] >= $invoiceDetail['invoice']['client']['minimuminvoice'])
                {
                    $total_credit       = $invoiceDetail['invoice']['client']['minimuminvoice'];
                    $back_item_credit   = $difference;
                    $invoice_status     = 'Paid';
                }
                else 
                {
                    if ($a_client_details['client']['credit'] > $min) 
                    {
                        $back_item_credit   = $a_client_details['client']['credit'] - $min;
                    }
                    
                    $total_credit    = $a_client_details['client']['credit'];
                    $invoice_status  = 'Unpaid';
                }
            }
            
            $api->editInvoiceDetails(array(
                'id'        => $invoiceId,
                'credit'    => $total_credit
            ));
            
            $api->setInvoiceStatus(array(
                'id'        => $invoiceId,
                'status'    => $invoice_status
            ));


            /// Update credit log
            if ($back_item_credit > 0) 
            {
                $credit_balance = $a_client_details['client']['credit'] - $back_item_credit;
                $result         = $db->query("
                    INSERT INTO hb_client_credit_log
                        (date, client_id, `in`, `out`, balance, description, invoice_id, admin_id, admin_name)
                    VALUES
                        (:date, :client_id, :in, :out, :balance, :description, :invoice_id, :admin_id, :admin_name)
                ", array(
                    ':date'         => date('Y-m-d H:i:s'),
                    ':client_id'    => $invoiceDetail['invoice']['client_id'],
                    ':in'           => '0',
                    ':out'          => $back_item_credit,
                    ':balance'      => $credit_balance,
                    ':description'  => 'Credit applied to invoice',
                    ':invoice_id'   => $invoiceId,
                    ':admin_id'     => isset($_SESSION['AppSettings']['admin_login']['id'])
                                            ? $_SESSION['AppSettings']['admin_login']['id']
                                            : '',
                    ':admin_name'   => isset($_SESSION['AppSettings']['admin_login']['username'])
                                       ? $_SESSION['AppSettings']['admin_login']['username']
                                       : '',
                ));
                
                /// Update Create 
                $result         = $db->query("
                    UPDATE
                        hb_client_billing
                    SET
                        credit = :credit
                    WHERE
                        client_id = :client_id
                    ", array(
                        ':credit' => $credit_balance,
                        ':client_id' => $invoiceDetail['invoice']['client_id'],
                ));
            }
        }
    }
}
