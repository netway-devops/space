#!/usr/local/bin/php
<?php
/**
 * ทำการแก้ไข mail message ที่ส่งเข้ามา
 * |/usr/local/bin/php -q --php-ini /etc/phpconf/managene/php.ini /home/managene/public_html/admin/pipe-post.php
 */

require_once( dirname(dirname(__FILE__)) . '/includes/class.pipemail.custom.php');

/* --- อ่านข้อมูลเข้า --- */
// base64 /tmp/MSGZbw8jO
// attachment /tmp/MSGCddVsT
// base64 attach /tmp/MSG5vAoTq
// normal /tmp/MSGQUK2TF
// test from to /tmp/MSGZbw8j1
// test normal attachment /tmp/MSGZJO5To
// test change department /tmp/MSG2FnSlI
// no department /tmp/MSGKRKsNf , /tmp/MSG3Kst6w, /tmp/MSGVeU6uR


//$email      = file_get_contents('/tmp/MSGZbw8j2');


$email      = '';
$stdin      = fopen('php://stdin', 'r');
while (!feof($stdin)) {
    $email .= fread($stdin, 8192);
}
fclose($stdin);


/* --- ถ้าเป็น base64 encode อาจจะมีปัญหาได้ --- */
$email  = PipemailCustom::singleton()->base64toAttachment($email);

/* --- ถ้ามี From: To: Subject: ใน message hostbill จะชี้ผิดตัว --- */
$email  = PipemailCustom::singleton()->rewriteFromToInMessage($email);

/* --- ถ้ามี To: "billing" <test@tickets.netway.co.th> คือ name และ email คนละแผนก --- */
$email  = PipemailCustom::singleton()->rewriteClearToHeader($email);

/* --- เขียน mail ลงไฟล์ --- */
$tmpfname   = tempnam('/tmp', 'MSG');
$handle     = fopen($tmpfname, 'w');
fwrite($handle, $email);
fclose($handle);

/* --- ส่งข้อมูลไปให้ hostbill pipe --- */
system('cat '. $tmpfname .' |/usr/local/bin/php -q '. dirname(__FILE__) .'/pipe.php');
@unlink($tmpfname);