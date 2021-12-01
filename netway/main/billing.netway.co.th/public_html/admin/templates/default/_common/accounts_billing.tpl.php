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
$aDetails    = $this->get_template_vars('details');
// --- Get template variable ---

$productId  = $aDetails['product_id'];
$paytype    = $aDetails['paytype'];

$result    = $db->query("
            SELECT *
            FROM hb_common 
            WHERE id = :productId
            AND paytype = :paytype
            ", array(
                ':productId'   => $productId,
                ':paytype'     => $paytype
            ))->fetch();

$billingcycle = array(
    "billingcycle" => array(
         "m"     => isset($result['m']) ? $result['m'] : 0,
         "q"     => isset($result['q']) ? $result['q'] : 0,
         "s"     => isset($result['s']) ? $result['s'] : 0,
         "a"     => isset($result['a']) ? $result['a'] : 0,
         "b"     => isset($result['b']) ? $result['b'] : 0,
         "t"     => isset($result['t']) ? $result['t'] : 0,
         "p4"    => isset($result['p4']) ? $result['p4'] : 0,
         "p5"    => isset($result['p5']) ? $result['p5'] : 0,

    )
);
$regular_cycles = array();

  foreach($billingcycle as $cycle){
        if ($cycle['m'] > 0 && $paytype == 'Regular') {
            $regular_cycles[] = 'Monthly';
        }
        if ($cycle['m'] > 0 && $paytype == 'Once') {
            $regular_cycles[] = 'One Time';
        }
        if ($cycle['q'] > 0) {
           array_push ($regular_cycles,'Quarterly');
        }
        if ($cycle['s'] > 0) {
            array_push ($regular_cycles,'Semi-Annually');
        }

        if ($cycle['a'] > 0) {
        array_push ($regular_cycles,'Annually');
        }

        if ($cycle['b'] > 0) {
        array_push ($regular_cycles,'Biennially');
        }

        if ($cycle['t'] > 0) {
        array_push ($regular_cycles,'Triennially');
        }

        if ($cycle['p4'] > 0) {
        array_push ($regular_cycles,'Quadrennially');
        }

        if ($cycle['p5'] > 0) {
        array_push ($regular_cycles,'Quinquennially');
        }
    }
    //echo '<pre>'. print_r($regular_cycles, true) .'</pre>';
    $this->assign('regular_cycles', $regular_cycles);

            