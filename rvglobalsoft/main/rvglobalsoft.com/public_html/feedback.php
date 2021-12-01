<?php

/* --- config --- */
$mailto     = 'pairote@netway.co.th';
/* --- config --- */

$aError     = array();
$oData      = isset($_POST) ? (object) $_POST : new stdClass();

// --- after form submit ---
if (isset($_POST) && isset($oData->feedback_name) && isset($oData->feedback_email) && isset($oData->subject)) {
    
    if (! isset($oData->feedback_name) || $oData->feedback_name == '') {
        $aError['fullname']     = 'ชื่อของคุณ';
    }
    if (! isset($oData->feedback_email) || $oData->feedback_email == '') {
        $aError['phone']     = 'อีเมล์';
    }
    if (! isset($oData->subject) || $oData->subject == '') {
        $aError['payday']    = 'ข้อความแนะนำหรือติชม';
    }
    
    if ( ! count($aError)) {
        
        $_SESSION['hb_captcha'] = '';
        
        $subject    = 'แนะนำ ติชม เสนอความคิดเห็นจาก ' . $oData->feedback_name;
        $message    = "\n". 'รายละเอียด'
                . "\n" . '============================================================'
                . "\n" . 'ชื่อคุณ:              ' . $oData->feedback_name
                . "\n" . 'อีเมล์:              ' . $oData->feedback_email
                . "\n" . 'ข้อความแนะนำหรือติชม: '
                . "\n" . $oData->subject
                . "\n"
                . "\n" . '============================================================'
                . "\n" . 'Reference: http://www.netway.co.th/feedback.php' 
                ;

        $header     = 'MIME-Version: 1.0' . "\r\n" .
                'Content-type: text/plain; charset=utf-8' . "\r\n" .
                'From: ' . $oData->feedback_email . "\r\n" .
                'Reply-To: ' . $oData->feedback_email . "\r\n" .
                'X-Mailer: PHP/' . phpversion();
        
        if (@mail($mailto, $subject, $message, $header)) {
            $_SESSION['notification']   = array('type' => 'success', 'message' => 'ส่งข้อมูล feedback ถึง SEO เรียบร้อยแล้ว');
        } else {
            $_SESSION['notification']   = array('type' => 'error', 'message' => 'เกิดข้อผิดพลาดระหว่างส่งข้อมูล');
        }
        
    }
    
    /* AJAX check  */
    if(!empty($_SERVER['HTTP_X_REQUESTED_WITH']) && strtolower($_SERVER['HTTP_X_REQUESTED_WITH']) == 'xmlhttprequest') {
        
        /* special ajax here */
        if (isset($_SESSION['notification']['type']) && $_SESSION['notification']['type'] == 'success') {
            header ('Content-type: text/html; charset=utf-8'); 
            echo json_encode($_SESSION['notification']);
        }
        
        exit;
    }

    header('location:feedback.php');exit;
    
}
// --- after form submit ---


require('includes/hostbill.php');

// --- hostbill helper ---
$client     = hbm_logged_client();
$db         = hbm_db();
$api        = new ApiWrapper();
// --- hostbill helper ---

$oClient    = (object) $client;

//echo '<pre>'.print_r($_SESSION,true).'</pre>';

hbm_render_page(
    'feedback.tpl',
    array(
        'oClient'       => $oClient
    ),
    _t('sendFeedBackToSEO')
);