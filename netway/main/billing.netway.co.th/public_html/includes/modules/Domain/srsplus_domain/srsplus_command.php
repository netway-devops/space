<?php
class SRSPlusCommand {
    private static  $instance;
    
    public static function singleton ()
    {
        if (!isset(self::$instance)) {
            $c = __CLASS__;
            self::$instance = new $c();
        }

        return self::$instance;
    }
    
    public function __construct(){
        
    }
    
    public function RegisterNameserver($params) {
        
        $QSTRING = "DNS_SERVER_NAME=" . $params['DNS_SERVER_NAME'];
        $QSTRING .= "&DNS_SERVER_IP=" . $params['DNS_SERVER_IP'];
        putenv('REQUEST_METHOD=GET');
        putenv('QUERY_STRING='.$QSTRING);
        
        unset($return_array);
        exec(SRSPLUS_REGISTRAR_WEBROOT . '/register_nameserver.cgi', $return_array);
        //echo "<pre>";print_r($return_array);
        $data = array();
        if(!count($return_array)){
            return $data;
        }
        
        $status = "";
        $error = "";
        foreach($return_array as $v){
            if(preg_match('/^STATUS\:/i', $v) and preg_match('/ERROR/i', $v)){
                $status = "error";
            }
            if(preg_match('/^ERROR\:/i', $v) ){
                $error .= substr($v, strpos($v, ':')+1 ) . "\n";
            }
        }
        
        
        if($status == "error"){
            $data['error'] = $error;
        }
        
        return $data;
    }
    
    public function GetNameservers($params) {
        
        $QSTRING = "DOMAIN=" . $params['DOMAIN'];
        $QSTRING .= "&TLD=" . $params['TLD'];
        putenv('REQUEST_METHOD=GET');
        putenv('QUERY_STRING='.$QSTRING);
        
        unset($return_array);
        exec(SRSPLUS_REGISTRAR_WEBROOT . '/domain_info.cgi', $return_array);
        //echo "<pre>";print_r($return_array);
        
        return $data;
    }
    
    /**
     * (non-PHPdoc)
     * @see public_html/a/modules/registrarAPI/CallRegistrarInterface#GetDNS($params)
     */
    public function GetDNS($params) {
        $QSTRING = "DOMAIN=" . $params['DOMAIN'];
        $QSTRING .= "&TLD=" . $params['TLD'];
        putenv('REQUEST_METHOD=GET');
        putenv('QUERY_STRING='.$QSTRING);
        
        unset($return_array);
        exec(SRSPLUS_REGISTRAR_WEBROOT . '/whois.cgi', $return_array);
        //echo "<pre>";print_r($return_array);
        
        $data = array();
        $data['error'] = 'No data.';
        if(!count($return_array)){
            return $data;
        }
        $i = 0;
        foreach($return_array as $v){
            if(preg_match('/^STATUS\:/i', $v) and preg_match('/SUCCESS/i', $v)){
                $data['error'] = "";
            }
            if(preg_match('/^DNS\ SERVER\ NAME/i', $v) ){
                $i++;
                $data['nameserver'.$i.''] = trim(substr($v, strpos($v, ':')+1 ));
            }
        }
        //echo "<pre>";print_r($data);
        return $data;
    }
    
    
    public function SaveDNS($params) 
    {
        
        unset($result);
        
        $result     = $this->_whois($params);
        
        $aData      = $this->_get_responible_id($result);

        if(! $aData['contact_id']){
            return $aData;
        }else{
            $params['RESPONSIBLE_PERSON']   = $aData['contact_id'];
        }
        
        $aData = $this->_get_technical_id($result);
        if(! $aData['contact_id']){
            return $aData;
        }else{
            $params['TECHNICAL_CONTACT']    = $aData['contact_id'];
        }
        
        $QSTRING    = 'DOMAIN=' . $params['DOMAIN'];
        $QSTRING   .= '&TLD='   . $params['TLD'];
        $QSTRING   .= '&RESPONSIBLE_PERSON='  . $params['RESPONSIBLE_PERSON'];
        $QSTRING   .= '&TECHNICAL_CONTACT='   . $params['TECHNICAL_CONTACT'];
        for( $i = 1; $i <= 4; $i++ ){
            $QSTRING    .= '&DNS_SERVER_NAME_'. $i .'='. $params['DNS_SERVER_NAME_'. $i];
        }
        putenv('REQUEST_METHOD=GET');
        putenv('QUERY_STRING='. $QSTRING);
        
        unset($aResult);
        exec(SRSPLUS_REGISTRAR_WEBROOT . '/change_domain.cgi', $aResult);
        
        $aData              = array();
        $aData['error']     = 'No data.';
        $aData['log']       = print_r($aResult, true);
        
        if(! count($aResult)){
            return $aData;
        }
        
        foreach($aResult as $v){
            if(preg_match('/^STATUS\:\ SUCCESS/i', $v)){
                $aData['error']     = '';
                break;
            }
            if(preg_match('/^STATUS\:\ ERROR(.*)/i', $v, $matches, PREG_OFFSET_CAPTURE)){
                if (isset($matches[1][0])) {
                    $aData['error']   = 'Error: '.$matches[1][0];
                }
                break;
            }
        }
        
        $client     = hbm_logged_client();
        if (isset($client['id']) && $client['id']) {
            $aData  = array();
        }
        
        return $aData;
    }
    
    public function RegisterDomain($params) {
        
        /* ---  หาค่า contact_id ก่อน นำไป register --- */
        $aData      = $this->SaveContactDetails($params['REGISTRANT_CONTACT']);
        
        if($aData['contact_id']){
            $params['RESPONSIBLE_PERSON'] = $aData['contact_id'];
        }else{
            $aData['log']       = print_r($aData, true);
            $aData['error']     = 'No data.';
            return $aData;
        }
        
        $aData      = $this->SaveContactDetails($params['ADMIN_CONTACT']);
        
        if($aData['contact_id']){
            $params['TECHNICAL_CONTACT'] = $aData['contact_id'];
        }else{
            $params['TECHNICAL_CONTACT'] = 0;
        }
        
        $QSTRING    = 'DOMAIN=' .               $params['DOMAIN'];
        $QSTRING   .= '&TLD=' .                 $params['TLD'];
        $QSTRING   .= '&TERM_YEARS=' .          $params['TERM_YEARS'];
        $QSTRING   .= '&RESPONSIBLE_PERSON=' .  $params['RESPONSIBLE_PERSON'];
        $QSTRING   .= '&TECHNICAL_CONTACT=' .   $params['TECHNICAL_CONTACT'];
        $QSTRING   .= '&PRICE=' .               number_format($params['PRICE'], 2, '.', '');
        
        $QSTRING   .= '&DNS_SERVER_NAME_1=' .   $params['DNS_SERVER_NAME_1'];
        $QSTRING   .= '&DNS_SERVER_NAME_2=' .   $params['DNS_SERVER_NAME_2'];
        $QSTRING   .= '&DNS_SERVER_NAME_3=' .   $params['DNS_SERVER_NAME_3'];
        $QSTRING   .= '&DNS_SERVER_NAME_4=' .   $params['DNS_SERVER_NAME_4'];
        
        putenv('REQUEST_METHOD=GET');
        putenv('QUERY_STRING='.$QSTRING);

        unset($aResult);
        exec(SRSPLUS_REGISTRAR_WEBROOT . '/register_domain.cgi', $aResult);
        //echo '<hr /><pre>'. print_r($params, true).print_r($aResult, true) .'<hr /></pre>';
        
        $aData              = array();
        $aData['error']     = 'No data.';
        $aData['log']       = print_r($aResult, true);
        
        if(! count($aResult)){
            return $aData;
        }
        
        foreach($aResult as $v){
            if(preg_match('/^STATUS\:\ SUCCESS/i', $v)){
                $aData['error']         = '';
                break;
            }
            if(preg_match('/^STATUS\:\ ERROR(.*)/i', $v, $matches, PREG_OFFSET_CAPTURE)){
                $aData['error']        .= ' '. (isset($matches[1][0]) ? $matches[1][0] : '');
                break;
            }
        }
        
        return $aData;
    }

    public function SaveContactDetails($params) {
        
        $QSTRING    = 'TLD=' .              $params['TLD'];
        $QSTRING   .= '&FNAME=' .           $params['FNAME'];
        $QSTRING   .= '&LNAME=' .           $params['LNAME'];
        $QSTRING   .= '&ORGANIZATION=' .    $params['ORGANIZATION'];
        $QSTRING   .= '&EMAIL=' .           $params['EMAIL'];
        $QSTRING   .= '&ADDRESS1=' .        addslashes($params['ADDRESS1']);
        $QSTRING   .= '&ADDRESS2=' .        addslashes($params['ADDRESS2']);
        $QSTRING   .= '&CITY=' .            $params['CITY'];
        $QSTRING   .= '&PROVINCE=' .        $params['PROVINCE'];
        $QSTRING   .= '&POSTAL_CODE=' .     $params['POSTAL_CODE'];
        $QSTRING   .= '&COUNTRY=' .         $params['COUNTRY'];
        $QSTRING   .= '&PHONE=' .           $params['PHONE'];
        putenv('REQUEST_METHOD=GET');
        putenv('QUERY_STRING='. $QSTRING);
        
        unset($aResult);
        exec(SRSPLUS_REGISTRAR_WEBROOT . '/create_contact.cgi', $aResult);
        //echo '<pre>'.print_r($aResult, true).'</pre>';
        
        $aData      = array();
        
        if(! count($aResult)){
            return $aData;
        }
        
        foreach($aResult as $v){
            if(preg_match('/^STATUS\:\ ERROR/i', $v, $matches, PREG_OFFSET_CAPTURE)){
                $aData['error']         = 'Error';
            }
            if(isset($aData['error']) && preg_match('/^ERROR\:\ (.*)/i', $v, $matches, PREG_OFFSET_CAPTURE)){
                $aData['error']         .= ' '. (isset($matches[1][0]) ? $matches[1][0] : '');
            }
            if(preg_match('/^CONTACTID\:\ (\d+)/i', $v, $matches, PREG_OFFSET_CAPTURE)){
                $aData['contact_id']    = isset($matches[1][0]) ? $matches[1][0] : '';
            }
        }
        
        return $aData;
    }

    public function EditContactDetails($params) {
        
        if ($params['CONTACTID'] == '25347902' || $params['CONTACTID'] == '26729143') {
            // 25347902 Default technical contact id ของ siaminterhost ไม่ให้แก้ไข
            // 26729143 Default technical contact id ของ netway ไม่ให้แก้ไข
            
            return array(
                    'contact_id'    => $params['CONTACTID']
                );
            
        }
        
        $QSTRING    = 'TLD=' .              $params['TLD'];
        $QSTRING   .= '&CONTACTID=' .       $params['CONTACTID'];
        $QSTRING   .= '&FNAME=' .           $params['FNAME'];
        $QSTRING   .= '&LNAME=' .           $params['LNAME'];
        $QSTRING   .= '&ORGANIZATION=' .    $params['ORGANIZATION'];
        $QSTRING   .= '&EMAIL=' .           $params['EMAIL'];
        $QSTRING   .= '&ADDRESS1=' .        $params['ADDRESS1'];
        $QSTRING   .= '&ADDRESS2=' .        $params['ADDRESS2'];
        $QSTRING   .= '&CITY=' .            $params['CITY'];
        $QSTRING   .= '&PROVINCE=' .        $params['PROVINCE'];
        $QSTRING   .= '&POSTAL_CODE=' .     $params['POSTAL_CODE'];
        $QSTRING   .= '&COUNTRY=' .         $params['COUNTRY'];
        $QSTRING   .= '&PHONE=' .           $params['PHONE'];
        putenv('REQUEST_METHOD=GET');
        putenv('QUERY_STRING='. $QSTRING);
        
        unset($aResult);
        exec(SRSPLUS_REGISTRAR_WEBROOT . '/edit_contact.cgi', $aResult);
        // echo '<pre>'.print_r($params, true).print_r($aResult, true).'</pre>';
        
        $aData      = array();
        if(! count($aResult)){
            return $aData;
        }
        
        foreach($aResult as $v){
            if(preg_match('/^STATUS\:\ ERROR(.*)/i', $v, $matches, PREG_OFFSET_CAPTURE)){
                $aData['error']         = isset($matches[1][0]) ? $matches[1][0] : '';
                break;
            }
            if(preg_match('/^CONTACTID\:\ (\d+)/i', $v, $matches, PREG_OFFSET_CAPTURE)){
                $aData['contact_id']    = isset($matches[1][0]) ? $matches[1][0] : '';
            }
        }
        
        return $aData;
    }    
    
    public function TransferDomain($params) {
        
        // หาค่า contact_id ก่อน นำไป transfer
        $data = $this->SaveContactDetails($params['REGISTRANT_CONTACT']);
        if($data['contact_id']){
            $params['RESPONSIBLE_PERSON'] = $data['contact_id'];
        }else{
            $params['RESPONSIBLE_PERSON'] = 0;
        }
        
        $data = $this->SaveContactDetails($params['ADMIN_CONTACT']);
        if($data['contact_id']){
            $params['TECHNICAL_CONTACT'] = $data['contact_id'];
        }else{
            $params['TECHNICAL_CONTACT'] = 0;
        }
        
        $QSTRING    = 'DOMAIN=' .               $params['DOMAIN'];
        $QSTRING   .= '&TLD=' .                 $params['TLD'];
        $QSTRING   .= '&AUTH_CODE=' .           $params['AUTH_CODE'];
        $QSTRING   .= '&RESPONSIBLE_PERSON=' .  $params['RESPONSIBLE_PERSON'];
        $QSTRING   .= '&TECHNICAL_CONTACT=' .   $params['TECHNICAL_CONTACT'];
        $QSTRING   .= '&CURRENT_ADMIN_EMAIL=' . $params['CURRENT_ADMIN_EMAIL'];
        putenv('REQUEST_METHOD=GET');
        putenv('QUERY_STRING='.$QSTRING);
        
        unset($aResult);
        exec(SRSPLUS_REGISTRAR_WEBROOT . '/request_transfer.cgi', $aResult);
        // echo "<pre>";print_r($aResult);exit;
        
        $aData              = array();
        $aData['error']     = 'No data.';
        $aData['log']       = print_r($aResult, true);
        
        if(! count($aResult)){
            return $aData;
        }
        
        foreach($aResult as $v){
            if(preg_match('/^STATUS\:\ SUCCESS/i', $v)){
                $aData['error']         = '';
                break;
            }
            if(preg_match('/^STATUS\:\ ERROR(.*)/i', $v, $matches, PREG_OFFSET_CAPTURE)){
                $aData['error']        .= ' '. (isset($matches[1][0]) ? $matches[1][0] : '');
                break;
            }
        }
        
        return $aData;
    }    
    
    public function RenewDomain($params) 
    {
        
        $QSTRING    = 'DOMAIN=' .           $params['DOMAIN'];
        $QSTRING   .= '&TLD=' .             $params['TLD'];
        $QSTRING   .= '&TERM_YEARS=' .      $params['TERM_YEARS'];
        $QSTRING   .= '&PRICE=' .           $params['PRICE'];
        putenv('REQUEST_METHOD=GET');
        putenv('QUERY_STRING='.$QSTRING);   
        
        unset($aResult);
        exec(SRSPLUS_REGISTRAR_WEBROOT . '/renew_domain.cgi', $aResult);
        // echo '<hr /><pre>'. print_r($params, true).print_r($aResult, true) .'<hr /></pre>';exit;
        
        $aData              = array();
        $aData['error']     = 'No data.';
        $aData['log']       = print_r($aResult, true);
        
        if(! count($aResult)){
            return $aData;
        }
        
        foreach($aResult as $v){
            if(preg_match('/^STATUS\:\ SUCCESS/i', $v)){
                $aData['error']         = '';
                break;
            }
            if(preg_match('/^STATUS\:\ ERROR(.*)/i', $v, $matches, PREG_OFFSET_CAPTURE)){
                $aData['error']        .= ' '. (isset($matches[1][0]) ? $matches[1][0] : '');
                break;
            }
        }
        
        return $aData;
    }    
    
    public function GetContactDetails ($params)
    {
        
        $result         = $this->_whois($params);
        
        $aContact       = array();
        
        $data = $this->_get_responible_id($result);
        if($data['contact_id']){
            $aContact["Registrant"]     = $this->_get_contact_info($data['contact_id']);
        }
        
        $data = $this->_get_technical_id($result);
        if($data['contact_id']){
            $aContact["Tech"]           = $this->_get_contact_info($data['contact_id']);
        }

        $data = $this->_get_admin_id($result);
        if($data['contact_id']){
            $aContact["Admin"]          = $this->_get_contact_info($data['contact_id']);
        }
        
        $data = $this->_get_billing_id($result);
        if($data['contact_id']){
            $aContact["Billing"]        = $this->_get_contact_info($data['contact_id']);
        }
        
        return $aContact;
    }
    
    public function UpdateDomainContact ($params)
    {

        $QSTRING    = 'TLD=' .                      $params['TLD'];
        $QSTRING   .= '&DOMAIN=' .                  $params['DOMAIN'];
        $QSTRING   .= '&REGISTRANT_CONTACT_ID=' .   $params['REGISTRANT_CONTACT_ID'];
        $QSTRING   .= '&TECHNICAL_CONTACT_ID=' .    $params['TECHNICAL_CONTACT_ID'];
        $QSTRING   .= '&BILLING_CONTACT_ID=' .      $params['BILLING_CONTACT_ID'];
        $QSTRING   .= '&ADMIN_CONTACT_ID=' .        $params['ADMIN_CONTACT_ID'];
        putenv('REQUEST_METHOD=GET');
        putenv('QUERY_STRING='. $QSTRING);
        
        unset($aResult);
        exec(SRSPLUS_REGISTRAR_WEBROOT . '/change_domain_address.cgi', $aResult);
        //echo '<pre>'.print_r($params, true).print_r($aResult, true).'</pre>';
        
        $aData          = array();
        $aData['error'] = 'No data.';
        
        if(! count($aResult)){
            return $aData;
        }
        
        foreach($aResult as $v){
            if(preg_match('/^STATUS\:\ SUCCESS/i', $v)){
                $aData['error']         = '';
                break;
            }
        }
        
        return $aData;
    }
    
    public function SynchronizeDomain ($params)
    {
        $result         = $this->_whois($params);
        
        $aData              = array();
        $aData['error']     = 'No data.';
        $aData['log']       = print_r($result, true);
        
        if(! count($result)){
            return $aData;
        }

        foreach($result as $v){
            if(preg_match('/^STATUS\:\ SUCCESS/i', $v)){
                $aData['error']     = '';
            }
            
            if(preg_match('/^DNS\ SERVER\ NAME\ (\d)\:\ (.*)/i', $v, $matches, PREG_OFFSET_CAPTURE) ){
                if (isset($matches[1][0]) && isset($matches[2][0])) {
                    $aData['nameserver'. $matches[1][0]]    = trim($matches[2][0]);
                }
            } else if(preg_match('/^NAME\ SERVER\:\ (.*)/i', $v, $matches, PREG_OFFSET_CAPTURE) ){
                if (isset($matches[1][0]) && $matches[1][0]) {
                    if (isset($aData['nameserver1'])) {
                        $aData['nameserver2']   = $matches[1][0];
                    } else {
                        $aData['nameserver1']   = $matches[1][0];
                    }
                }
            }

            if(preg_match('/^DNS\ SERVER\ IP\ (\d)\:\ (.*)/i', $v, $matches, PREG_OFFSET_CAPTURE) ){
                if (isset($matches[1][0]) && isset($matches[2][0])) {
                    $aData['nameserverip'. $matches[1][0]]    = trim($matches[2][0]);
                }
            }
            
            if(preg_match('/^EXPIRATION\ DATE\:\ (\d+)/i', $v, $matches, PREG_OFFSET_CAPTURE) ){
                if (isset($matches[1][0]) && $matches[1][0]) {
                    $aData['expire']   = $matches[1][0];
                }
            }
            
            if(preg_match('/^DOMAIN\ PROTECT\:\ (\d)/i' , $v , $matches, PREG_OFFSET_CAPTURE)){
                $aData['privateDomain']     = $matches[1][0];
            }
            
            if(preg_match('/^Domain\sStatus.*clientTransferProhibited/i' , $v)){
                $aData['lockdomain']   = 1;
            }
            
        }
        
        return $aData;
    }
    
    private function _get_contact_info($contact_id){
        
        $QSTRING = "CONTACT_ID=" . $contact_id;
        putenv('REQUEST_METHOD=GET');
        putenv('QUERY_STRING='.$QSTRING);   
        
        unset($return_array);
        exec(SRSPLUS_REGISTRAR_WEBROOT . '/get_contact_info.cgi', $return_array);
        //echo "<hr>";print_r($return_array);
        
        $data = array();
        if(!count($return_array)){
            return $data;
        }
        foreach($return_array as $v){

            if(preg_match('/^COUNTRY/i', $v) ){
                $data['COUNTRY'] = trim(substr($v, strpos($v, ':')+1 )) ;
            }
            if(preg_match('/^ORGANIZATION/i', $v) ){
                $data['ORGANIZATION'] = trim(substr($v, strpos($v, ':')+1 )) ;
            }
            if(preg_match('/^CITY/i', $v) ){
                $data['CITY'] = trim(substr($v, strpos($v, ':')+1 )) ;
            }
            if(preg_match('/^EMAIL/i', $v) ){
                $data['EMAIL'] = trim(substr($v, strpos($v, ':')+1 )) ;
            }
            if(preg_match('/^PROVINCE/i', $v) ){
                $data['PROVINCE'] = trim(substr($v, strpos($v, ':')+1 )) ;
            }
            if(preg_match('/^FNAME/i', $v) ){
                $data['FNAME'] = trim(substr($v, strpos($v, ':')+1 )) ;
            }
            if(preg_match('/^ADDRESS2/i', $v) ){
                $data['ADDRESS2'] = trim(substr($v, strpos($v, ':')+1 )) ;
            }
            if(preg_match('/^ADDRESS1/i', $v) ){
                $data['ADDRESS1'] = trim(substr($v, strpos($v, ':')+1 )) ;
            }
            if(preg_match('/^PHONE/i', $v) ){
                $data['PHONE'] = trim(substr($v, strpos($v, ':')+1 )) ;
            }
            if(preg_match('/^POSTAL\ CODE/i', $v) ){
                $data['POSTAL_CODE'] = trim(substr($v, strpos($v, ':')+1 )) ;
            }
            if(preg_match('/^LNAME/i', $v) ){
                $data['LNAME'] = trim(substr($v, strpos($v, ':')+1 )) ;
            }

        }
        
        $data['CONTACTID'] = $contact_id;
        
        return $data;
    }
    
    private function _get_contact_person($return_array){
        $data = array();
        if(!count($return_array)){
            return $data;
        }
        foreach($return_array as $v){
            if(preg_match('/^FNAME\ RESPONSIBLE\ PERSON/i', $v) ){
                $data['firstname'] = trim(substr($v, strpos($v, ':')+1 )) ;
            }
            if(preg_match('/^LNAME\ RESPONSIBLE\ PERSON/i', $v) ){
                $data['lastname'] = trim(substr($v, strpos($v, ':')+1 )) ;
            }
            if(preg_match('/^FNAME\ ADMIN\ CONTACT/i', $v) ){
                $data['adminfirstname'] = trim(substr($v, strpos($v, ':')+1 )) ;
            }
            if(preg_match('/^LNAME\ ADMIN\ CONTACT/i', $v) ){
                $data['adminlastname'] = trim(substr($v, strpos($v, ':')+1 )) ;
            }
            if(preg_match('/^FNAME\ TECHNICAL\ CONTACT/i', $v) ){
                $data['techfirstname'] = trim(substr($v, strpos($v, ':')+1 )) ;
            }
            if(preg_match('/^LNAME\ TECHNICAL\ CONTACT/i', $v) ){
                $data['techlastname'] = trim(substr($v, strpos($v, ':')+1 )) ;
            }

        }
        
        return $data;
    } 

    private function _domain_info($params){
        
        $QSTRING = "DOMAIN=" . $params['DOMAIN'];
        $QSTRING .= "&TLD=" . $params['TLD'];

        putenv('REQUEST_METHOD=GET');
        putenv('QUERY_STRING='.$QSTRING);   
        
        unset($return_array);
        exec(SRSPLUS_REGISTRAR_WEBROOT . '/domain_info.cgi', $return_array);
        
        $data = array();
        if(!count($return_array)){
            return $data;
        }
        
        $status = "";
        $error = "";
        foreach($return_array as $v){
            if(preg_match('/^STATUS\:/i', $v) and preg_match('/ERROR/i', $v)){
                $status = "error";
            }
            if(preg_match('/^ERROR/i', $v) ){
                $error .= substr($v, strpos($v, ':')+1 ). "\n";
            }
            
        }
        
        if($status == "error"){
            $data['error'] = $error;
        }
        
        return $data;
        
    }
    
    public function _whois($params)
    {
        
        $QSTRING    = 'DOMAIN=' . $params['DOMAIN'];
        $QSTRING   .= '&TLD='   . $params['TLD'];

        putenv('REQUEST_METHOD=GET');
        putenv('QUERY_STRING='. $QSTRING);   
        
        unset($aResult);
        exec(SRSPLUS_REGISTRAR_WEBROOT . '/whois.cgi', $aResult);

        return $aResult;
        
    }

    //[TODO]
    private function _get_responible_id($return_array){
        $data = array();
        if(!count($return_array)){
            return $data;
        }
        
        $status = "error";
        $error = "";
        $contact_id = 0;
        foreach($return_array as $v){
            if(preg_match('/^STATUS\:/i', $v) and preg_match('/SUCCESS/i', $v)){
                $status = "";
            }
            if(preg_match('/^ERROR/i', $v) ){
                $error .= substr($v, strpos($v, ':')+1 ). "\n";
            }
            if(preg_match('/^RESPONSIBLE\ PERSON/i', $v) ){
                $contact_id = (int)trim(substr($v, strpos($v, ':')+1 ));
            }
            
        }
        
        if($status == "error"){
            $data['error'] = $error;
        }else{
            $data['contact_id'] = $contact_id;
        }
        
        return $data;
    }
    
    private function _get_technical_id($return_array){
        $data = array();
        if(!count($return_array)){
            return $data;
        }
        
        $status = "error";
        $error = "";
        $contact_id = 0;
        foreach($return_array as $v){
            if(preg_match('/^STATUS\:/i', $v) and preg_match('/SUCCESS/i', $v)){
                $status = "";
            }
            if(preg_match('/^ERROR/i', $v) ){
                $error .= substr($v, strpos($v, ':')+1 ). "\n";
            } 
            if(preg_match('/^TECHNICAL\ CONTACT/i', $v) ){
                $contact_id = (int)trim(substr($v, strpos($v, ':')+1 ));
            }
            
        }
        
        if($status == "error"){
            $data['error'] = $error;
        }else{
            $data['contact_id'] = $contact_id;
        }
        
        return $data;
    }
    
    private function _get_billing_id($return_array){
        $data = array();
        if(!count($return_array)){
            return $data;
        }
        
        $status = "error";
        $error = "";
        $contact_id = 0;
        foreach($return_array as $v){
            if(preg_match('/^STATUS\:/i', $v) and preg_match('/SUCCESS/i', $v)){
                $status = "";
            }
            if(preg_match('/^ERROR/i', $v) ){
                $error .= substr($v, strpos($v, ':')+1 ). "\n";
            } 
            if(preg_match('/^BILLING\ CONTACT/i', $v) ){
                $contact_id = (int)trim(substr($v, strpos($v, ':')+1 ));
            }
            
        }
        
        if($status == "error"){
            $data['error'] = $error;
        }else{
            $data['contact_id'] = $contact_id;
        }
        
        return $data;
    }
    
    private function _get_admin_id($return_array){
        $data = array();
        if(!count($return_array)){
            return $data;
        }
        
        $status = "error";
        $error = "";
        $contact_id = 0;
        foreach($return_array as $v){
            if(preg_match('/^STATUS\:/i', $v) and preg_match('/SUCCESS/i', $v)){
                $status = "";
            }
            if(preg_match('/^ERROR/i', $v) ){
                $error .= substr($v, strpos($v, ':')+1 ). "\n";
            } 
            if(preg_match('/^ADMIN\ CONTACT/i', $v) ){
                $contact_id = (int)trim(substr($v, strpos($v, ':')+1 ));
            }
            
        }
        
        if($status == "error"){
            $data['error'] = $error;
        }else{
            $data['contact_id'] = $contact_id;
        }
        
        return $data;
    }
    
    
    public function _whois_server($params){
        
        unset($return_array);
        exec('whois '. $params['DOMAIN'].'.'.$params['TLD'], $return_array);

        return $return_array;
        
    }
    
    private function _get_name_server($return_array){
        $data = array();
        if(!count($return_array)){
            return $data;
        }
        $i=1;
        foreach($return_array as $v){
            if(preg_match('/^Name\ Server\:/i', trim($v))){
                $data['nameserver'.$i] = trim(substr($v, strpos($v, ':')+1 ));
                $i++;
            }
        }
        
        return $data;
    }
    
}
