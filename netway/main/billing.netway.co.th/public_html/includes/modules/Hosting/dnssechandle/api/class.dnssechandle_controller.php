<?php
// Depending on HostBill application.
if ( ! defined('HBF_APPNAME')) {
    exit;
}

require_once dirname(__DIR__) . '/class.dnssechandle.php';
require_once dirname(__DIR__) . '/model/class.dnssechandle_model.php';

class dnssechandle_controller extends HBController {
    
    public function sendRequest ($request)
    {
        $aReturn    = array();
        
        $accountId  = isset($request['accountId']) ? $request['accountId'] : 0;
        
        $aAccount   = dnssechandle_model::singleton()->getAccountById($accountId);
        $domain     = isset($aAccount['domain']) ? $aAccount['domain'] : '';

        if (! $domain) {
            $message    = 'Domain is require field.';
            $this->addError($message);
            $aReturn['message'] = $message;
            return array(true, $aReturn);
        }


        $aDetail    = isset($aAccount['extra_details']) ? unserialize($aAccount['extra_details']) : array();
        $status     = isset($aDetail['dnssec_status']) ? $aDetail['dnssec_status'] : '';
        $keytag     = isset($aDetail['dnssec_keytag']) ? $aDetail['dnssec_keytag'] : '';
        $algorithm  = isset($aDetail['dnssec_algorithm']) ? $aDetail['dnssec_algorithm'] : '';
        $digestType = isset($aDetail['dnssec_digest_type']) ? $aDetail['dnssec_digest_type'] : '';
        $digest     = isset($aDetail['dnssec_digest']) ? $aDetail['dnssec_digest'] : '';

        if ($status != 'request') {
            $message    = 'DNSSEC Request status not in request.';
            $this->addError($message);
            $aReturn['message'] = $message;
            return array(true, $aReturn);
        }

        $mailfrom   = 'siripen@siaminterhost.com';
        $mailBCC    = 'thanitpong@netway.co.th';
        $mailto     = 'partners@srsplus.com,DNSSEC@srsplus.com';
        //$mailto     = 'prasit@netway.co.th';
        $subject    = 'Please set dnssec : '. $domain;
        $message    = '
        Domain: '. $domain .'
        DS Records KeyTag: '. $keytag .'
        DS Records Algorithm: '. $algorithm .'
        DS Records Digest Type: '. $digestType .'
        DS Records Digest: '. $digest .'
        ';
        
        $header     = 'MIME-Version: 1.0' . "\r\n" .
                'Content-type: text/plain; charset=utf-8' . "\r\n" .
                'From: '. $mailfrom . "\r\n" .
                'Bcc: '. $mailBCC . "\r\n" .
                'Reply-To: '. $mailfrom . "\r\n" .
                'X-Mailer: PHP/' . phpversion();
        @mail($mailto, $subject, $message, $header);

        $aDetail['dnssec_status']   = 'processing';
        dnssechandle_model::singleton()->updateAccountExtraDetail($accountId, $aDetail);

        $message    = 'DNSSEC Request to partners@srsplus.com,DNSSEC@srsplus.com.';
        $aReturn['message'] = $message;
        return array(true, $aReturn);
    }
}