<?php
require('includes/hostbill.php');

// --- hostbill helper ---
$db         = hbm_db();
// --- hostbill helper ---

$hostname   = $_SERVER['HTTP_HOST'] ? $_SERVER['HTTP_HOST'] : 'billing.netway.co.th';
$invoiceId  = isset($_GET['id']) ? $_GET['id'] : 0;
$isDownload = isset($_GET['download']) ? $_GET['download'] : 0;

$result     =   $db->query("
        SELECT *
        FROM hb_invoices
        WHERE id = :id
        ", array(
            ':id'       =>      $invoiceId
        ))->fetch();

if (! isset($result['id'])) {
    exit;
}

require_once(APPDIR .'libs/lib-crc16/lib-crc16.inc.php');
require_once(APPDIR .'libs/php-qr-code/vendor/autoload.php');

$invoiceId  = $invoiceId;
$clientId   = $result['client_id'];
$amount     = $result['total'];

$qrcode00   = '000201';
$qrcode01   = '010212';

$qrcode3000 = '0016A000000677010112';
$qrcode3001 = '0115013553900314343';
$qrcode3002 = '0213INV'. str_pad($invoiceId, 10, '0', STR_PAD_LEFT);
$qrcode3003 = '0313CID'. str_pad($clientId, 10, '0', STR_PAD_LEFT);
$qrcode30   = $qrcode3000 . $qrcode3001 . $qrcode3002 . $qrcode3003;
$qrcode30   = '30'. str_pad(strlen($qrcode30), 2, '0', STR_PAD_LEFT) . $qrcode30;

$qrcode53   = '5303764';
$qrcode54   = '54'. str_pad(strlen($amount), 2, '0', STR_PAD_LEFT) . $amount;
$qrcode58   = '5802TH';
$qrcode62   = '';//'62100706SCB001';
$qrcode63   = '6304';

$qrcode     = $qrcode00 . $qrcode01 . $qrcode30 . $qrcode53 . $qrcode54 . $qrcode58 . $qrcode62 . $qrcode63;

$checkSum   = CRC16HexDigest($qrcode);

$savePath   = MAINDIR . '/qrPaymentTag30/invoice_' . $invoiceId . '.png';

QRcode::png($qrcode . $checkSum, $savePath, QR_ECLEVEL_H, 10, 4);

if ($isDownload) {
    if(file_exists($savePath)) {
        
        header('Content-Description: File Transfer');
        header('Content-Transfer-Encoding: binary');
        header('Content-Type: image/png');
        header('Content-Disposition: attachment; filename="invoice_' . $invoiceId . '.png";');
        header('Expires: 0');
        header('Cache-Control: must-revalidate, post-check=0, pre-check=0');
        header('Pragma: public');
        header('Cache-Control: private',false);
        header('Content-Length: '. filesize($savePath));
        ob_clean(); #THIS!
        flush(); // Flush system output buffer
        readfile($savePath);
        exit;
    }
    
} else {

    echo '<img src="https://'. $hostname .'/qrPaymentTag30/invoice_'. $invoiceId .'.png">';

}
