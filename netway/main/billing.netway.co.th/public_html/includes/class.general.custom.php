<?php

// Depending on HostBill application.
if ( ! defined('HBF_APPNAME')) {
    exit;
}

class GeneralCustom {
    
    private static  $instance;
    
    public static function singleton ()
    {
        if (!isset(self::$instance)) {
            $c = __CLASS__;
            self::$instance = new $c();
        }

        return self::$instance;
    }

    public function __clone ()
    {
        trigger_error('Clone is not allowed.', E_USER_ERROR);
    }
    
    private function __construct () 
    {
        
    }
    
    /**
     * ตรวจสอบว่า domain อยู่ในเงื่อนไขที่สามารถ renew ได้หรือไม่
     * @param $domainId
     * @return unknown_type
     */
    public function isDomainAllowRenewable ($domainId, $autoSync = true)
    {
        if (! $domainId) {
            return false;
        }
        
        // --- hostbill helper ---
        $db         = hbm_db();
        $api        = new ApiWrapper();
        // --- hostbill helper ---
        
        require_once(APPDIR . 'class.config.custom.php');
        $nwShortTermRenewal = ConfigCustom::singleton()->getValue('nwShortTermRenewal');
        
        $nwShortTermRenewalTime = strtotime('-' . $nwShortTermRenewal . ' day', time());
        
        if ($nwShortTermRenewalTime > 0) {
            
            $result    = $db->query("
                        SELECT 
                            dl.date
                        FROM 
                            hb_domain_logs dl
                        WHERE 
                            dl.domain_id = :domainId
                            AND dl.date >  :termRenewalDate
                            AND dl.event = 'DomainRenew'
                            AND dl.result = 1
                        ", array(
                            ':domainId'         => $domainId,
                            ':termRenewalDate'  => date('Y-m-d', $nwShortTermRenewalTime)
                        ))->fetch();
            
            if (isset($result['date']) && $result['date']) {
                return false;
            }
        
        }
        
        
        /* --- เพิ่มการ sync domain + ตรวจสอบวันหมดอายุ --- */
        if (! $autoSync) {
            return true;
        }
        
        require_once(APPDIR . 'class.api.custom.php');
        // [FIXME] Fixcode
        $adminUrl   = (isset($_SERVER['HTTPS']) ? 'https' : 'http://') . $_SERVER['HTTP_HOST']
                    . (preg_match('/^192\.168\.1/', $_SERVER['HTTP_HOST']) 
                        ? '/manage.netway.co.th/public_html/admin/api.php'
                        : '/7944web/api.php');
        $apiCustom  = ApiCustom::singleton($adminUrl);
        
        $params     = array(
            'call'      => 'domainSynch',
            'id'        => $domainId
        );
        $result     = $apiCustom->request($params);
        
        $result    = $db->query("
                    SELECT 
                        d.expires
                    FROM 
                        hb_domains d
                    WHERE 
                        d.id = :domainId
                    ", array(
                        ':domainId'         => $domainId
                    ))->fetch();
        if ( isset($result['expires']) && strtotime($result['expires']) ) {
            $expire     = strtotime($result['expires']);
            $term       = $expire - time();
            if ($term > 0 && ($term/(60*60*24)) > $nwShortTermRenewal) {
                return false;
            }
        }
        
        return true;
    }
    
    public function newAccountTerm ($desc)
    {

        preg_match('/\<\!\-\-\s?\((\d{2})\/(\d{2})\/(\d{4})\s?\-\s?(\d{2})\/(\d{2})\/(\d{4})\)\s?\-\-\>/', $desc, $matches);
        
        $termStart      = 0;
        $termEnd        = 0;
        if ( isset($matches[1]) && isset($matches[2]) && isset($matches[3])
            && isset($matches[4]) && isset($matches[5]) && isset($matches[6]) ) {
            $d          = $matches[1];
            $m          = $matches[2];
            $y          = $matches[3];
            $termStart  = strtotime($y .'-'. $m .'-'. $d);
            $d          = $matches[4];
            $m          = $matches[5];
            $y          = $matches[6];
            $termEnd    = strtotime($y .'-'. $m .'-'. $d);
        }
        
        if ($termStart && $termEnd) {
            $dayDiff    = ($termEnd - $termStart) / (60*60*24);
            $termStart  = time();
            $termEnd    = strtotime('+' . $dayDiff . ' day', $termStart);
            $desc       = preg_replace('/<\!\-\-(.*)\-\->/',
                            '(' . date('d/m/Y', $termStart) . ' - ' . date('d/m/Y', $termEnd) . ')',
                            $desc);
        }
        
        return $desc;
    }

    public function hideAccountTerm ($desc)
    {
        $desc       = preg_replace('/(\(\d{2}\/\d{2}\/\d{4}\s?\-\s?\d{2}\/\d{2}\/\d{4}\))/', '<!--$1-->', $desc);
        return $desc;
    }
    
    public function convertStrtotime ($str = '00/00/0000')
    {
        $d  = substr($str,0,2);
        $m  = substr($str,3,2);
        $y  = substr($str,6);
        return strtotime($y .'-'. $m .'-'. $d);
    }
    
    public function urlFriendlyThai ($string)
    {
        // ref: http://www.thaiseoboard.com/index.php?topic=139137.0
        $string = preg_replace("`\[.*\]`U","",$string);
        $string = preg_replace('`&(amp;)?#?[a-z0-9]+;`i','-',$string);
        $string = str_replace('%', '-percent', $string);
        $string = htmlentities($string, ENT_COMPAT, 'utf-8');
        $string = preg_replace( "`&([a-z])(acute|uml|circ|grave|ring|cedil|slash|tilde|caron|lig|quot|rsquo);`i","\\1", $string );
        $string = preg_replace( array("`[^a-z0-9ก-๙เ-า]`i","`[-]+`") , "-", $string);
        return strtolower(trim($string, '-'));
    }
    
    public function buildSearchTerm ($sql = '', $field = '', $str = '', $term = 'OR'){
        $phase      = @explode(' ', $str);
        
        if(count($phase)){
            $i  = 0;
            foreach($phase as $v){
                $v  = trim($v);
                if (!$v) {
                    continue;
                }
                if (!$i){
                    $sql    .= " ( ";
                    $sql    .= $field . " LIKE  '%" . $v . "%' ";
                } else {
                    $sql    .= $term . "  " . $field . " LIKE  '%" . $v . "%' ";
                }
                $i++;
            }
            if ($i) {
                $sql    .= " ) ";
            }
        }
        
        return $sql;
    }
    
    // http://stackoverflow.com/questions/6101956/generating-a-random-password-in-php
    public function randomPassword() {
        $alphabet = "abcdefghijklmnopqrstuwxyzABCDEFGHIJKLMNOPQRSTUWXYZ0123456789";
        $pass = array(); //remember to declare $pass as an array
        $alphaLength = strlen($alphabet) - 1; //put the length -1 in cache
        for ($i = 0; $i < 8; $i++) {
            $n = rand(0, $alphaLength);
            $pass[] = $alphabet[$n];
        }
        return implode($pass); //turn the array into a string
    }
    
    public function getAdminUrl ()
    {
        global $hb_admin_folder;
        if (! $hb_admin_folder) {
            include(dirname(__FILE__).'/config.php');
        }
        $adminFolder    = $hb_admin_folder ? $hb_admin_folder : 'admin';
        $path           = substr(MAINDIR, (strpos(MAINDIR, '/public_html/')+13));
        $https          = isset($_SERVER['HTTPS']) ? 'https://' : 'http://';
        $httphost       = isset($_SERVER['HTTP_HOST']) ? $_SERVER['HTTP_HOST'] : '';
        $url            = '';
        if ($httphost) {
            $url        = $https . $httphost;
        } else {
            $url        = 'https://netway.co.th';
        }
        $adminUrl       =  $url . '/' . $path . $adminFolder;
        
        return $adminUrl;
    }
    
    public function getClientUrl ()
    {

        $path           = substr(MAINDIR, (strpos(MAINDIR, '/public_html/')+13));
        $adminUrl       = 'https://' . $_SERVER['HTTP_HOST'] 
                        . '/' . $path ;
        
        return $adminUrl;
    }
    
    public function listDomainContactId ($aContacts)
    {
        
        // --- hostbill helper ---
        $db         = hbm_db();
        // --- hostbill helper ---
        
        $aContactId         = array();
        $aIsDomainContact   = array();
        
        /* --- ดึงข้อมูล customfield addresstype  --- */
        $result         = $db->query("
                    SELECT
                        cf.id, cf.default_value
                    FROM
                        hb_client_fields cf
                    WHERE
                        cf.code = 'addresstype'
                    ")->fetch();
        $cfId           = isset($result['id']) ? $result['id'] : 0;
        if (! $cfId) {
            return $aIsDomainContact;
        }
        
        /* --- เอาเฉพาะ domian contact มาให้เลือก --- */
        foreach ($aContacts as $arr) {
            array_push($aContactId, $arr['id']);
        }
        
        $result         = $db->query("
                    SELECT
                        cfv.*
                    FROM
                        hb_client_fields_values cfv
                    WHERE
                        cfv.client_id IN (". implode(',', $aContactId) .")
                        AND cfv.field_id = :fieldId
                        AND cfv.value = 'Domain'
                    ", array(
                        ':fieldId'      => $cfId
                    ))->fetchAll();
        
        if (count($result)) {
            foreach ($result as $arr) {
                array_push($aIsDomainContact, $arr['client_id']);
            }
        }
        
        return $aIsDomainContact;
    }

    public function getNetwayTechContactAddress ($contactId)
    {
        $db         = hbm_db();
        
        $result     = $db->query("
                SELECT
                    ca.email,
                    cd.firstname,
                    cd.lastname,
                    cd.companyname,
                    cd.address1,
                    cd.address2,
                    cd.city,
                    cd.state,
                    cd.postcode,
                    cd.country,
                    cd.phonenumber
                FROM
                    hb_client_access ca,
                    hb_client_details cd
                WHERE
                    cd.id = :contactId
                    AND cd.id = ca.id
                ", array(
                    ':contactId'        => $contactId
                ))->fetch();
        
        return $result;
    }
    
    public function adminUIActionRequest ($cmd, $aPost = array(), $isReturn = 0)
    {
        require_once(APPDIR . 'class.config.custom.php');
        
        $cookiefile         = '/tmp/curl-session';
        $username           = ConfigCustom::singleton()->getValue('nwAdminUsername');
        $password           = ConfigCustom::singleton()->getValue('nwAdminPassword');
        
        $url                = self::getAdminUrl() .'/index.php';
        
        $aParam     = array(
            'action'    => 'login',
            'username'  => $username,
            'password'  => $password,
            'rememberme'=> '1'
        );
        
        $ch = curl_init();
        curl_setopt($ch, CURLOPT_URL, $url);
        curl_setopt($ch, CURLOPT_HEADER, false);
        curl_setopt($ch, CURLOPT_POST, 1);
        curl_setopt($ch, CURLOPT_TIMEOUT, 60);
        curl_setopt($ch, CURLOPT_RETURNTRANSFER, 1);
        curl_setopt($ch, CURLOPT_FOLLOWLOCATION, true);
        curl_setopt($ch, CURLOPT_POSTFIELDS, $aParam);
        curl_setopt($ch, CURLOPT_SSL_VERIFYPEER, false);
        curl_setopt($ch, CURLOPT_SSL_VERIFYHOST, false);
        curl_setopt($ch, CURLOPT_COOKIEFILE, $cookiefile);
        curl_setopt($ch, CURLOPT_COOKIEJAR, $cookiefile);
        $data = curl_exec($ch);
        
        /* --- ค่าที่ hostbill ใช้ verify เมื่อมีการ call XMLHttpRequest --- */
        preg_match('/<meta\sname="csrf\-token"\scontent="(.*)"\s?\/>/i', $data, $matches);
        
        $csrfToken  = isset($matches[1]) ? $matches[1] : '';
        
        if ($csrfToken == '') {
            throw new Exception('ไม่มีค่า csrf-toke ไม่สามารถ run action request ได้');
        }
        
        curl_setopt($ch, CURLOPT_POST, 0);
        curl_setopt($ch, CURLOPT_TIMEOUT, 60);
        curl_setopt($ch, CURLOPT_HTTPHEADER, array(
            'Accept: */*', 
            'X-Requested-With: XMLHttpRequest', 
            'X-CSRF-Token: ' . $csrfToken,
        ));
        curl_setopt($ch, CURLOPT_URL, $url . $cmd);
        curl_setopt($ch, CURLOPT_POSTFIELDS, $aPost);
                
        $data = curl_exec($ch);
        
        curl_close($ch);
        
        if (is_file($cookiefile)) {
            unlink($cookiefile);
        }
        
        if ($isReturn) {
            return $data;
        }
    }

    /**
     * [XXX] ไม่ยืนยันว่าเป็นข้อมูลที่ถูกต้อง
     * จำนวนวันตามประเภทรอบบิล
     * $nextDue = timestamp
     */
    public function billingCycleUpgradeToDays ($nextDue, $cycle)
    {

        switch ($cycle) {
            case 'Monthly': {
                $days       = 30; return $days;
                $lastDue    = mktime(0,0,0, date('n', $nextDue) - 1, date('j', $nextDue), date('Y', $nextDue));
                break;
                }
            case 'Quarterly': {
                $days       = 90; return $days;
                $lastDue    = mktime(0,0,0, date('n', $nextDue) - 3, date('j', $nextDue), date('Y', $nextDue));
                break;
                }
            case 'Semi-Annually': {
                $days       = 180; return $days;
                $lastDue    = mktime(0,0,0, date('n', $nextDue) - 6, date('j', $nextDue), date('Y', $nextDue));
                break;
                }
            case 'Annually': {
                $days       = 365; return $days;
                $lastDue    = mktime(0,0,0, date('n', $nextDue), date('j', $nextDue), date('Y', $nextDue) -1);
                break;
                }
            case 'Biennially': {
                $days       = 730; return $days;
                $lastDue    = mktime(0,0,0, date('n', $nextDue), date('j', $nextDue), date('Y', $nextDue) -2);
                break;
                }
            case 'Triennially': {
                $days       = 1095; return $days;
                $lastDue    = mktime(0,0,0, date('n', $nextDue), date('j', $nextDue), date('Y', $nextDue) -3);
                break;
                }
                
        }
        
        $days       = ($nextDue - $lastDue ) / (60*60*24);
        
        return $days;
    }
    
    public function removeCommonWords($input){

        // EEEEEEK Stop words

        $commonWords    = array('a','able','about','above','abroad','according','accordingly','across','actually',
            'adj','after','afterwards','again','against','ago','ahead','ain\'t','all','allow','allows','almost',
            'alone','along','alongside','already','also','although','always','am','amid','amidst','among','amongst',
            'an','and','another','any','anybody','anyhow','anyone','anything','anyway','anyways','anywhere','apart',
            'appear','appreciate','appropriate','are','aren\'t','around','as','a\'s','aside','ask','asking',
            'associated','at','available','away','awfully','b','back','backward','backwards','be','became',
            'because','become','becomes','becoming','been','before','beforehand','begin','behind','being','believe',
            'below','beside','besides','best','better','between','beyond','both','brief','but','by','c','came','can',
            'cannot','cant','can\'t','caption','cause','causes','certain','certainly','changes','clearly','c\'mon',
            'co','co.','com','come','comes','concerning','consequently','consider','considering','contain',
            'containing','contains','corresponding','could','couldn\'t','course','c\'s','currently','d','dare',
            'daren\'t','definitely','described','despite','did','didn\'t','different','directly','do','does',
            'doesn\'t','doing','done','don\'t','down','downwards','during','e','each','edu','eg','eight','eighty',
            'either','else','elsewhere','end','ending','enough','entirely','especially','et','etc','even','ever',
            'evermore','every','everybody','everyone','everything','everywhere','ex','exactly','example','except',
            'f','fairly','far','farther','few','fewer','fifth','first','five','followed','following','follows','for',
            'forever','former','formerly','forth','forward','found','four','from','further','furthermore','g','get',
            'gets','getting','given','gives','go','goes','going','gone','got','gotten','greetings','h','had','hadn\'t',
            'half','happens','hardly','has','hasn\'t','have','haven\'t','having','he','he\'d','he\'ll','hello','help',
            'hence','her','here','hereafter','hereby','herein','here\'s','hereupon','hers','herself','he\'s','hi',
            'him','himself','his','hither','hopefully','how','howbeit','however','hundred','i','i\'d','ie','if',
            'ignored','i\'ll','i\'m','immediate','in','inasmuch','inc','inc.','indeed','indicate','indicated',
            'indicates','inner','inside','insofar','instead','into','inward','is','isn\'t','it','it\'d','it\'ll',
            'its','it\'s','itself','i\'ve','j','just','k','keep','keeps','kept','know','known','knows','l','last',
            'lately','later','latter','latterly','least','less','lest','let','let\'s','like','liked','likely',
            'likewise','little','look','looking','looks','low','lower','ltd','m','made','mainly','make','makes',
            'many','may','maybe','mayn\'t','me','mean','meantime','meanwhile','merely','might','mightn\'t','mine',
            'minus','miss','more','moreover','most','mostly','mr','mrs','much','must','mustn\'t','my','myself','n',
            'name','namely','nd','near','nearly','necessary','need','needn\'t','needs','neither','never','neverf',
            'neverless','nevertheless','new','next','nine','ninety','no','nobody','non','none','nonetheless','noone',
            'no-one','nor','normally','not','nothing','notwithstanding','novel','now','nowhere','o','obviously','of',
            'off','often','oh','ok','okay','old','on','once','one','ones','one\'s','only','onto','opposite','or',
            'other','others','otherwise','ought','oughtn\'t','our','ours','ourselves','out','outside','over','overall',
            'own','p','particular','particularly','past','per','perhaps','placed','please','plus','possible',
            'presumably','probably','provided','provides','q','que','quite','qv','r','rather','rd','re','really',
            'reasonably','recent','recently','regarding','regardless','regards','relatively','respectively','right',
            'round','s','said','same','saw','say','saying','says','second','secondly','see','seeing','seem','seemed',
            'seeming','seems','seen','self','selves','sensible','sent','serious','seriously','seven','several','shall',
            'shan\'t','she','she\'d','she\'ll','she\'s','should','shouldn\'t','since','six','so','some','somebody',
            'someday','somehow','someone','something','sometime','sometimes','somewhat','somewhere','soon','sorry',
            'specified','specify','specifying','still','sub','such','sup','sure','t','take','taken','taking','tell',
            'tends','th','than','thank','thanks','thanx','that','that\'ll','thats','that\'s','that\'ve','the','their',
            'theirs','them','themselves','then','thence','there','thereafter','thereby','there\'d','therefore',
            'therein','there\'ll','there\'re','theres','there\'s','thereupon','there\'ve','these','they','they\'d',
            'they\'ll','they\'re','they\'ve','thing','things','think','third','thirty','this','thorough','thoroughly',
            'those','though','three','through','throughout','thru','thus','till','to','together','too','took','toward',
            'towards','tried','tries','truly','try','trying','t\'s','twice','two','u','un','under','underneath',
            'undoing','unfortunately','unless','unlike','unlikely','until','unto','up','upon','upwards','us','use',
            'used','useful','uses','using','usually','v','value','various','versus','very','via','viz','vs','w','want',
            'wants','was','wasn\'t','way','we','we\'d','welcome','well','we\'ll','went','were','we\'re','weren\'t',
            'we\'ve','what','whatever','what\'ll','what\'s','what\'ve','when','whence','whenever','where','whereafter',
            'whereas','whereby','wherein','where\'s','whereupon','wherever','whether','which','whichever','while',
            'whilst','whither','who','who\'d','whoever','whole','who\'ll','whom','whomever','who\'s','whose','why',
            'will','willing','wish','with','within','without','wonder','won\'t','would','wouldn\'t','x','y','yes',
            'yet','you','you\'d','you\'ll','your','you\'re','yours','yourself','yourselves','you\'ve','z','zero');

        return preg_replace('/\b('.implode('|',$commonWords).')\b/','',$input);
    }
    
    function getProductPrice ($productId)
    {
       $url     = 'https://netway.co.th/7944web/api.php';
       
       $post    = array(
          'api_id'      => '2c96d70f79f41a159134',
          'api_key'     => 'b0b6ab88832d3a5b9ba2',
          'call'        => 'module',
          'module'      => 'informationhandle',
          'fn'          => 'getProductPrice',
          'productId'   => $productId
       );
       
        $ch     = curl_init();
        curl_setopt($ch, CURLOPT_URL, $url);
        curl_setopt($ch, CURLOPT_TIMEOUT, 30);
        curl_setopt($ch, CURLOPT_POST, 1);
        curl_setopt($ch, CURLOPT_RETURNTRANSFER, 1);
        curl_setopt($ch, CURLOPT_POSTFIELDS, $post);
        curl_setopt($ch, CURLOPT_SSL_VERIFYPEER, false);
        curl_setopt($ch, CURLOPT_SSL_VERIFYHOST, false);
        $data   = curl_exec($ch);
        curl_close($ch);
       
        $return = json_decode($data, true);
        return $return;
    }
    
    public function sendOneSignalNotify ($request)
    {
        require_once(APPDIR . 'class.config.custom.php');
        $oneSignalAppID     = ConfigCustom::singleton()->getValue('oneSignalAppID');
        $oneSignalAppKey    = ConfigCustom::singleton()->getValue('oneSignalAppKey');
        
        $aField     = $request['aField'];
        $aField['app_id']   = $oneSignalAppID;
        $aField['data']     = array('foo' => 'bar');
        
        $fields     = json_encode($aField);
        
        $ch = curl_init();
        curl_setopt($ch, CURLOPT_URL, "https://onesignal.com/api/v1/notifications");
        curl_setopt($ch, CURLOPT_HTTPHEADER, array('Content-Type: application/json; charset=utf-8',
            'Authorization: Basic '. $oneSignalAppKey));
        curl_setopt($ch, CURLOPT_RETURNTRANSFER, TRUE);
        curl_setopt($ch, CURLOPT_HEADER, FALSE);
        curl_setopt($ch, CURLOPT_POST, TRUE);
        curl_setopt($ch, CURLOPT_POSTFIELDS, $fields);
        curl_setopt($ch, CURLOPT_SSL_VERIFYPEER, FALSE);
        $data = curl_exec($ch);
        curl_close($ch);
        
        $return = json_decode($data, true);
        return $return;
    }

}