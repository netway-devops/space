<?php
require('includes/hostbill.php');

// --- hostbill helper ---
$db         = hbm_db();
// --- hostbill helper ---

$invoiceId  = isset($_GET['id']) ? $_GET['id'] : 0;

$resultInvoice        =   $db->query("
                        SELECT
                            i.id , i.total 
                        FROM
                            hb_invoices i
                        WHERE
                            i.id = :id
                    ", array(
                        ':id'       =>      $invoiceId
                    ))->fetch();

if (! isset($resultInvoice['id'])) {
    exit;
}

require APPDIR_LIBS . 'php-promptpay-qr-master/vendor/autoload.php';
require_once APPDIR_LIBS . 'php-promptpay-qr-master/src/PromptPay.php';

$PromptPay = new KS\PromptPay();

$savePath = MAINDIR . '/promptpayQr/' . 'iv_' . $invoiceId . '.png';
$target = '0135539003143';
$amount = $resultInvoice['total'];
$PromptPay->generateQrCode($savePath, $target, $amount);
echo '<img src="https://'. $_SERVER['HTTP_HOST'] .'/promptpayQr/iv_'. $invoiceId .'.png">';
