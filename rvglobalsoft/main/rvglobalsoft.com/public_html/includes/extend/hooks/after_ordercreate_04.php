<?php
#@LICENSE@#
/**
 * If this order is product "2-factor Authentication for WHM",
 * add "2-factor Authentication for cPanel/webmail" and "2-factor Authentication for apps" items to order too.
 */
$db         = hbm_db();
$orderId    = $details;

/// 58: VIP for WHM (free)
/// 59: VIP for WHM
$aVipProduct = array(58, 59);


$vip_cpanel_product_id = 60;
$vip_app_product_id = 61;



/** เครื่องบูม ใช้ test
$aVipProduct = array(62, 63);
$vip_cpanel_product_id = 64;
$vip_app_product_id = 66;
*/

$api = new ApiWrapper();
$params = array(
        'id'=> $orderId
);
$aOrderDetails = $api->getOrderDetails($params);

foreach ($aVipProduct as $vip_product_id) {
    $foundOrderVipWHM = false;
    $foundOrderVipCpanel = false;
    $foundOrderVipApp = false;
    $parentID = null;
    $accountVipWHM = array();
    $clientId = $aOrderDetails['details']['client_id'];

    if (isset($aOrderDetails['details']['hosting']) && count($aOrderDetails['details']['hosting']) > 0) {
        foreach ($aOrderDetails['details']['hosting'] as $k => $v) {
            if ($v['product_id'] == $vip_product_id) {
                $foundOrderVipWHM = true;
                $accountVipWHM = $v;
            }

            if ($v['product_id'] == $vip_cpanel_product_id) {
                $foundOrderVipCpanel = true;
            }

            if ($v['product_id'] == $vip_app_product_id) {
                $foundOrderVipApp = true;
            }
        }
    }

    if ($foundOrderVipWHM === true) {
        if ($foundOrderVipCpanel === false) {
            $aOrderVipWHMInTable     = $db->query("
                SELECT
                    date_created, payment_module, next_due, next_invoice, date_changed
                FROM
                    hb_accounts
                WHERE
                    id = :id
                "
                , array(
                    ':id' => $accountVipWHM['id']
            ))->fetch();

            /// Make Next Due
            list($year, $month, $date) = preg_split('/\-/', $aOrderVipWHMInTable['date_created'], 3);
            $aData = $db->query("
                SELECT
                    value
                FROM
                    hb_automation_settings
                WHERE
                    item_id = :item_id
                    AND type = :type
                    AND setting = :setting
            ", array(
                ':item_id' => $vip_cpanel_product_id,
                ':type' => 'Hosting',
                ':setting' => 'EnableProRata'
            ))->fetch();

            $prorateOn = $aData['value'] ? $aData['value'] : null;

            if ($prorateOn == 'on') {
                $aData = $db->query("
                    SELECT
                        value
                    FROM
                        hb_automation_settings
                    WHERE
                        item_id = :item_id
                        AND type = :type
                        AND setting = :setting
                ", array(
                    ':item_id' => $vip_cpanel_product_id,
                    ':type' => 'Hosting',
                    ':setting' => 'ProRataDay'
                ))->fetch();

                $proRataDay = $aData['value'] ? $aData['value'] : null;

                if ((int)$proRataDay > (int)$date) {
                    $next_due = date("Y-m-d", mktime(0, 0, 0, $month, $proRataDay, $year));
                } else {
                    $aData = $db->query("
                        SELECT
                            value
                        FROM
                            hb_automation_settings
                        WHERE
                            item_id = :item_id
                            AND type = :type
                            AND setting = :setting
                    ", array(
                        ':item_id' => $vip_cpanel_product_id,
                        ':type' => 'Hosting',
                        ':setting' => 'ProRataNextMonth'
                    ))->fetch();
                    $proRataNextMonth = $aData['value'] ? $aData['value'] : null;
                    if (  (int)$date < (int)$proRataNextMonth) {
                        $nextMouth = 1;
                    } else {
                        $nextMouth = 2;
                    }
                    $next_due = date("Y-m-d", mktime(0, 0, 0, $month + $nextMouth, $proRataDay, $year));
                }
            } else {
                $next_due = date("Y-m-d", mktime(0, 0, 0, $month+1, $date, $year));
            }

            /// Make Next Invoice
            list($year, $month, $date) = preg_split('/\-/', $next_due, 3);
            $aData = $db->query("
                SELECT
                    value
                FROM
                    hb_automation_settings
                WHERE
                    item_id = :item_id
                    AND type = :type
                    AND setting = :setting
            ", array(
                ':item_id' => $vip_cpanel_product_id,
                ':type' => 'Hosting',
                ':setting' => 'InvoiceGeneration'
            ))->fetch();
            $invoiceGen = $aData['value'] ? $aData['value'] : null;

            $invoiceGen = isset($invoiceGen) ? $invoiceGen : 7;
            $next_invoice = date("Y-m-d", mktime(0, 0, 0, $month, $date - $invoiceGen, $year));

            /// Make Order
            $db->query("
                INSERT INTO hb_accounts
                    (client_id, order_id, product_id, parent_id, date_created, server_id, payment_module, firstpayment,
                    total, billingcycle, next_due, next_invoice, status, date_changed, extra_details)
                VALUES
                    (:client_id, :order_id, :product_id, :parent_id, :date_created, :server_id, :payment_module, :firstpayment,
                    :total, :billingcycle, :next_due, :next_invoice, :status, :date_changed, :extra_details)
            ",
            array(
                ':client_id' => $clientId,
                ':order_id' => $orderId,
                ':product_id' => $vip_cpanel_product_id,
                ':parent_id' => $accountVipWHM['id'],
                ':date_created' => $aOrderVipWHMInTable['date_created'],
                ':server_id' => $accountVipWHM['server_id'],
                ':payment_module' => $aOrderVipWHMInTable['payment_module'],
                ':firstpayment' => '0.00',
                ':total' => '0.00',
                ':billingcycle' => "Monthly",
                ':next_due' => $next_due,
                ':next_invoice' => $next_invoice,
                ':status' => $accountVipWHM['status'],
                ':date_changed' => $aOrderVipWHMInTable['date_changed'],
                ':extra_details' => 's:0:"";',
            ));

            /// Get accountID
            $aAccountInfo     = $db->query("
                SELECT
                    id
                FROM
                    hb_accounts
                WHERE
                    client_id = :client_id
                    AND order_id = :order_id
                    AND product_id = :product_id
                ", array(
                    ':client_id' => $clientId,
                    ':order_id' => $orderId,
                    ':product_id' => $vip_cpanel_product_id
            ))->fetch();

            $account_id = isset($aAccountInfo['id']) ? $aAccountInfo['id'] : null;

            /// Get hb_config_items_cat
            $aConfigItemCatInfo     = $db->query("
                SELECT
                    id, name, variable
                FROM
                    hb_config_items_cat
                WHERE
                    product_id = :product_id
                    AND variable = :variable
            ", array(
                ':product_id' => $vip_cpanel_product_id,
                ':variable' => 'quantity'
            ))->fetch();
            $quantityId = $aConfigItemCatInfo['id'];


            if ($quantityId) {
                /// Update hb_config2accounts
                $db->query("
                    INSERT INTO hb_config2accounts
                        (rel_type, account_id, config_cat, config_id, qty, data)
                    VALUES
                        (:rel_type, :account_id, :config_cat, :config_id, :qty, :data)
                ", array(
                    ':rel_type' => 'Hosting',
                    ':account_id' => $account_id,
                    ':config_cat' => $quantityId,
                    ':config_id' => $quantityId,
                    ':qty' => '0',
                    ':data' => '0',
                ));
            }

            /// ตัวทด
            $aConfigItemCatInfo     = $db->query("
                SELECT
                    id, name, variable
                FROM
                    hb_config_items_cat
                WHERE
                    product_id = :product_id
                    AND variable = :variable
            ", array(
                ':product_id' => $vip_cpanel_product_id,
                ':variable' => 'commute'
            ))->fetch();
            $commuteId = $aConfigItemCatInfo['id'];

            if ($commuteId) {
                $db->query("
                    INSERT INTO hb_config2accounts
                        (rel_type, account_id, config_cat, config_id, qty, data)
                    VALUES
                        (:rel_type, :account_id, :config_cat, :config_id, :qty, :data)
                ", array(
                    ':rel_type' => 'Hosting',
                    ':account_id' => $account_id,
                    ':config_cat' => $commuteId,
                    ':config_id' => $commuteId,
                    ':qty' => '1',
                    ':data' => '1',
                ));
            }
        }

        if ($foundOrderVipApp === false) {
            $aOrderVipWHMInTable     = $db->query("
                SELECT
                    date_created, payment_module, next_due, next_invoice, date_changed
                FROM
                    hb_accounts
                WHERE
                    id = :id
            ", array(
                ':id' => $accountVipWHM['id']
            ))->fetch();

            /// Make Next Due
            list($year, $month, $date) = preg_split('/\-/', $aOrderVipWHMInTable['date_created'], 3);
            $aData = $db->query("
                SELECT
                    value
                FROM
                    hb_automation_settings
                WHERE
                    item_id = :item_id
                    AND type = :type
                    AND setting = :setting
            ", array(
                ':item_id' => $vip_app_product_id,
                ':type' => 'Hosting',
                ':setting' => 'EnableProRata'
            ))->fetch();

            $prorateOn = $aData['value'] ? $aData['value'] : null;

            if ($prorateOn == 'on') {
                $aData = $db->query("
                    SELECT
                        value
                    FROM
                        hb_automation_settings
                    WHERE
                        item_id = :item_id
                        AND type = :type
                        AND setting = :setting
                ", array(
                    ':item_id' => $vip_app_product_id,
                    ':type' => 'Hosting',
                    ':setting' => 'ProRataDay'
                ))->fetch();

                $proRataDay = $aData['value'] ? $aData['value'] : null;

                if ((int)$proRataDay > (int)$date) {
                    $next_due = date("Y-m-d", mktime(0, 0, 0, $month, $proRataDay, $year));
                } else {
                    $aData = $db->query("
                        SELECT
                            value
                        FROM
                            hb_automation_settings
                        WHERE
                            item_id = :item_id
                            AND type = :type
                            AND setting = :setting
                    ", array(
                        ':item_id' => $vip_app_product_id,
                        ':type' => 'Hosting',
                        ':setting' => 'ProRataNextMonth'
                    ))->fetch();
                    $proRataNextMonth = $aData['value'] ? $aData['value'] : null;
                    if (  (int)$date < (int)$proRataNextMonth) {
                        $nextMouth = 1;
                    } else {
                        $nextMouth = 2;
                    }
                    $next_due = date("Y-m-d", mktime(0, 0, 0, $month + $nextMouth, $proRataDay, $year));
                }
            } else {
                $next_due = date("Y-m-d", mktime(0, 0, 0, $month+1, $date, $year));
            }

            /// Make Next Invoice
            list($year, $month, $date) = preg_split('/\-/', $next_due, 3);
            $aData = $db->query("
                SELECT
                    value
                FROM
                    hb_automation_settings
                WHERE
                    item_id = :item_id
                    AND type = :type
                    AND setting = :setting
            ", array(
                ':item_id' => $vip_app_product_id,
                ':type' => 'Hosting',
                ':setting' => 'InvoiceGeneration'
            ))->fetch();
            $invoiceGen = $aData['value'] ? $aData['value'] : null;

            $invoiceGen = isset($invoiceGen) ? $invoiceGen : 7;
            $next_invoice = date("Y-m-d", mktime(0, 0, 0, $month, $date - $invoiceGen, $year));

            /// Make Order
            $db->query("
                INSERT INTO hb_accounts
                    (client_id, order_id, product_id, parent_id, date_created, server_id, payment_module, firstpayment,
                    total, billingcycle, next_due, next_invoice, status, date_changed, extra_details)
                VALUES
                    (:client_id, :order_id, :product_id, :parent_id, :date_created, :server_id, :payment_module, :firstpayment,
                    :total, :billingcycle, :next_due, :next_invoice, :status, :date_changed, :extra_details)
            ", array(
                ':client_id' => $clientId,
                ':order_id' => $orderId,
                ':product_id' => $vip_app_product_id,
                ':parent_id' => $accountVipWHM['id'],
                ':date_created' => $aOrderVipWHMInTable['date_created'],
                ':server_id' => $accountVipWHM['server_id'],
                ':payment_module' => $aOrderVipWHMInTable['payment_module'],
                ':firstpayment' => '0.00',
                ':total' => '0.00',
                ':billingcycle' => "Monthly",
                ':next_due' => $next_due,
                ':next_invoice' => $next_invoice,
                ':status' => $accountVipWHM['status'],
                ':date_changed' => $aOrderVipWHMInTable['date_changed'],
                ':extra_details' => 's:0:"";',
            ));

            /// Get accountID
            $aAccountInfo     = $db->query("
                SELECT
                    id
                FROM
                    hb_accounts
                WHERE
                    client_id = :client_id
                    AND order_id = :order_id
                    AND product_id = :product_id
            ", array(
                ':client_id' => $clientId,
                ':order_id' => $orderId,
                ':product_id' => $vip_app_product_id
            ))->fetch();

            $account_id = isset($aAccountInfo['id']) ? $aAccountInfo['id'] : null;

            /// Get hb_config_items_cat
            $aConfigItemCatInfo     = $db->query("
                SELECT
                    id, name, variable
                FROM
                    hb_config_items_cat
                WHERE
                    product_id = :product_id
                    AND variable = :variable
            ", array(
                ':product_id' => $vip_app_product_id,
                ':variable' => 'quantity'
            ))->fetch();

            $quantityId = $aConfigItemCatInfo['id'];


            if ($quantityId) {
                /// Update hb_config2accounts
                $db->query("
                    INSERT INTO hb_config2accounts
                        (rel_type, account_id, config_cat, config_id, qty, data)
                    VALUES
                        (:rel_type, :account_id, :config_cat, :config_id, :qty, :data)
                ", array(
                    ':rel_type' => 'Hosting',
                    ':account_id' => $account_id,
                    ':config_cat' => $quantityId,
                    ':config_id' => $quantityId,
                    ':qty' => '0',
                    ':data' => '0',
                ));
            }

            /// ตัวทด
            $aConfigItemCatInfo     = $db->query("
                SELECT
                    id, name, variable
                FROM
                    hb_config_items_cat
                WHERE
                    product_id = :product_id
                    AND variable = :variable
            ", array(
                ':product_id' => $vip_app_product_id,
                ':variable' => 'commute'
            ))->fetch();
            $commuteId = $aConfigItemCatInfo['id'];

            if ($commuteId) {
                $db->query("
                    INSERT INTO hb_config2accounts
                        (rel_type, account_id, config_cat, config_id, qty, data)
                    VALUES
                        (:rel_type, :account_id, :config_cat, :config_id, :qty, :data)
                ", array(
                    ':rel_type' => 'Hosting',
                    ':account_id' => $account_id,
                    ':config_cat' => $commuteId,
                    ':config_id' => $commuteId,
                    ':qty' => '1',
                    ':data' => '1',
                ));
            }
        }
    }
}
$checkOrder = $db->query(
                        "
                        SELECT
                            product_id
                        FROM
                            hb_accounts
                        WHERE
                            product_id = 59
                            AND order_id = :order_id
                        ORDER BY id DESC
                        LIMIT 0,1
                        ", array(
                            ':order_id' => $aOrderDetails['details']['id']
                        )
)->fetch();
if($checkOrder['product_id'] == 59){
    $clientID = $aOrderDetails['details']['client_id'];
    $canBuy = 0;
    $checkProduct = $db->query(
                "
                    SELECT
                        id,status,next_due
                    FROM
                        hb_accounts
                    WHERE
                        client_id = :client_id
                        AND product_id = 59
                    ORDER BY id ASC
                ", array(
                        'client_id' => $clientID
                    )
    )->fetchAll();
    if(sizeof($checkProduct) > 0){
        if($checkProduct[0]['status'] == 'Active'){
            $next_due = strtotime($checkProduct[0]['next_due']);
            if(strtotime('now') > $next_due){
                $canBuy = 1;
            }
        } else {
            $canBuy = 1;
        }
    }
    if($canBuy == 1){
        $api->deleteOrder(array('id' => $orderId));

        $paramsInv = array('client_id' => $clientID);

        $res = $api->addInvoice($paramsInv);
        $invoiceId = $res['invoice_id'];
        $cyc = $aOrderDetails['details']['hosting']['0']['billingcycle'];

        $now = date('Y-m-d');
        if($cyc == 'Monthly'){
            $billingCycle = 'Monthly';
            $n1 = strtotime(date('Y-m-d', strtotime($now . '+1 months')));
            $n17 = strtotime(date('Y-m-7', strtotime($now . '+1 months')));
        } else {
            $billingCycle = 'Annually';
            $n1 = strtotime(date('Y-m-d', strtotime($now . '+1 years')));
            $n17 = strtotime(date('Y-m-7', strtotime($now . '+1 years')));
        }
        if($n1 > $n17){
            if($billingCycle == 'Monthly'){
                $n17 = strtotime(date('Y-m-7', strtotime($now . '+2 months')));
            } else {
                $n17 = strtotime(date('Y-m-7', strtotime($now . '+1 years')));
            }
        }
        $now = date('d/m/Y', strtotime($now));
        $nextDue = date('d/m/Y', $n17);
        $mainProductName = '2-factor Authentication for WHM (Renew ' . $now . ' to ' . $nextDue . ') - ' . $cyc;
        $productName = array($mainProductName, '2-factor Authentication for cPanel/webmail (Renew)', '2-factor Authentication for apps (Renew)');
        $real_price = intval($aOrderDetails['details']['hosting'][0]['total']);
        $qty = ($cyc == 'Monthly') ? $real_price/3 : $real_price/30;
        $prorataPrice = $_SESSION['2faProrata']/$qty;
        unset($_SESSION['2faProrata']);
        //$payment_module = $aOrderDetails['details']['payment_module'];

        $loopRound = 0;
        $roundOneStatus = 0;
        foreach($productName as $k){
            $paramsInvItem = array(
                        'id' => $invoiceId
                                , 'line' => $k
                                , 'price' => ($loopRound == 0) ? $prorataPrice : 0
                                , 'qty' => ($loopRound == 0) ? $qty : 1
                                , 'tax' => 0
            );
            $resItem = $api->addInvoiceItem($paramsInvItem);
            if($loopRound == 0 && $resItem['success'] == 1){
                $roundOneStatus = 1;
                $loopRound = 1;
            } else if($resItem['success'] != 1){
                $api->deleteInvoice(array('id' => $invoiceId));
                break;
            }
        }
        if($roundOneStatus){
            $paramsInvPayModule = array('id' => $invoiceId, 'payment_module' => $payment_module);
            $resEditInvDetails = $api->editInvoiceDetails($paramsInvPayModule);
            $paramsInvStat = array('id' => $invoiceId, 'status' => 'Unpaid');
            $resStat = $api->setInvoiceStatus($paramsInvStat);
            $_SESSION['2FactorRenew'] = 1;
        }

    }

}

//add domain name to invoice description SSL
$resultcommonname = $db->query("
                                SELECT commonname
                                FROM hb_ssl_order
                                WHERE order_id = :orderId
                               ",array(
                                    ':orderId'    => $orderId
                    ))->fetch();

if($resultcommonname && $resultcommonname['commonname'] != ''){

    $resultitem_id  =    $db->query("
                                    SELECT id
                                    FROM hb_accounts
                                    WHERE order_id = :orderId
                                    ",array(
                                        ':orderId'      => $orderId
                         ))->fetch();

    $resultdesc     =    $db->query("
                                    SELECT id, description
                                    FROM hb_invoice_items
                                    WHERE item_id = :item_id
                                    AND description like 'SSL - %'
                                    ",array(
                                            ':item_id'   => $resultitem_id['id']
                          ))->fetchAll();
    foreach($resultdesc as $eachDesc){
	    if($eachDesc['description'] != ''){
	        $tmpdesc    =   $eachDesc['description'];
	        $tmpdesc    =   explode("<!--(",$tmpdesc);
	        $commonname =   $resultcommonname['commonname'];
	        $newdesc    =   $tmpdesc[0] . $commonname . ' <!--(' . $tmpdesc[1];

	        $db->query("
	                    UPDATE hb_invoice_items
	                    SET description = :newdesc
	                    WHERE id = :id
	                    ",array(
	                            ':newdesc'  =>  $newdesc ,
	                    		':id' => $eachDesc['id']
	                    )
	        );
	    }
    }
}

?>
