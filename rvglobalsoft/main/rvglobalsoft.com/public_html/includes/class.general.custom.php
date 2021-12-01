<?php

/**
 * [XXX]
 * @author prasit
 *
 */

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

	public function getConfig_cat($productID) {
    	$db         = hbm_db();
    	$getCateId  = $db->query("
	        SELECT
	        	id,variable
	        FROM
	        	hb_config_items_cat
	        WHERE
	        	product_id = :productId
        	",array(
            	':productId' => $productID
        	))->fetch();
        if ($getCateId['variable'] != 'ip') {
            return '';
        }
        return $getCateId['id'];
    }

	public function getConfig_Id($cateId)
	{
	    $db         	= hbm_db();
	    $getConfItem	= $db->query("
	        SELECT
	        	id
	        FROM
	        	hb_config_items
	        WHERE
	        	category_id = :cateconfigId
	        ", array(
	            ':cateconfigId' => $cateId
	        ))->fetch();
		if (count($getConfItem) > 0) return $getConfItem['id'];
		else return '';
	}

	public function getDataIp($accId,$config_cat,$config_id)
	{
	    $db         = hbm_db();
	    $getData 	= $db->query("
	        SELECT
	        	data
	        FROM
	        	hb_config2accounts
	        WHERE
	        	account_id = :accountId
	        	AND config_cat=:config_cat
	        	AND config_id=:config_id
	        ", array(
	            ':accountId' 	=> $accId,
	            ':config_cat' 	=> $config_cat,
	            ':config_id' 	=> $config_id
	        ))->fetch();
	        if (count($getData) > 0) return $getData['data'];
	        else return '';
	}

	private function findDataAccountInInvoiceForma($invoice_id){
		$db		= hbm_db();
		$q 		= $db->query("
				SELECT
					proii.id,proii.invoice_id,proii.description
				FROM
					hb_invoices proi,hb_invoice_items proii
				WHERE
		    		proi.id = proii.invoice_id
		    		AND proi.status = 'Unpaid'
		    		AND proii.type='Invoice'
		    		AND proii.item_id = :invoice_id
				",array(':invoice_id'=>$invoice_id))->fetch();
		if ($q) {
			return $q;
		} else {
			return false;
		}
	}

	/**
	 * $inv_many ใช้เพื่อว่า ถ้าเป็น แค่ item เดียว แล้วไม่ได้เป็น proforma ก็ได้ทำ api ไป cancel order เรียบร้อยแล้ว
	 * แต่ถ้าเป็นหลายๆ item ใน invoiced อันนี้ ก้ต้อง list ไว้ในเมลล์ด้วยให้ทำ แบบ manual เอา
	 */
	public function apiSendTicketManualCancelInvForAccTerminateCron ($aData)
	{
		require_once(APPDIR . 'class.config.custom.php');
		//1. เอาดาต้ามาวนหาจำนวนข้อมูล
		$subject        		= 'Account Terminate ให้ split Inv#' . $aData[0]['invoice_id'];
		$nwBillingDepartmentId  = ConfigCustom::singleton()->getValue('nwBillingDepartmentId');

		$message = 'ตามใบแจ้งหนี้ <br />
                มีการ Terminate Account แต่ยังไม่ได้ไป Split Account นี้ออกจากใบแจ้งหนี้<br />

                ให้เข้าไปที่ ลิงค์นี้<br />';
		$linkInv = '';
		$aInvProForma = $this->findDataAccountInInvoiceForma($aData[0]['invoice_id']);
		$linkInvProForma = '';
		if ($aInvProForma != false) {
			$invFroma = (isset($aInvProForma['invoice_id'])) ? $aInvProForma['invoice_id'] : '';
			$desFroma = (isset($aInvProForma['description'])) ? $aInvProForma['description'] : '';
			$linkInv .= '
		    <br />item Name  : ' . $desFroma . '<br />
			https://rvglobalsoft.com/7944web/?cmd=invoices#'. $invFroma .'&list=all<br />';
		}
		foreach ($aData as $k => $v) {
			$invoice_id = $v['invoice_id'];
			$linkInv 	.= '<br />item Name : ' . $v['description'] . '<br />
                https://rvglobalsoft.com/7944web/?cmd=invoices#'. $invoice_id .'&list=all<br />';
		}
		$message .= $linkInv;
		if (isset($_SERVER['HTTP_HOST'])) {
        	$adminUrl   = (isset($_SERVER['HTTPS']) ? 'https://' : 'http://') . $_SERVER['HTTP_HOST']
                    . (preg_match('/^192\.168\.1/', $_SERVER['HTTP_HOST'])
                        ? '/demo/rvglobalsoft.com/public_html/7944web/api.php'
                        : '/7944web/api.php');
		} else {
			$adminUrl = 'https://rvglobalsoft.com/7944web/api.php';
		}
		//echo "\n".$adminUrl;
		require_once(APPDIR . 'class.api.custom.php');
        $apiCustom  = ApiCustom::singleton($adminUrl);

        $params     = array(
            'call'      => 'addTicket',
            'name'      => 'SEND BY CRON' ,
            'subject'   => $subject,
            'body'      => $message,
            'email'     => 'noreply@rvglobalsoft.com',
            'dept_id'   => $nwBillingDepartmentId,
            'client_id' => 0,
        );
        return $apiCustom->request($params);
	}

    public function apiSetInvoiceStatus ($id, $status)
	{
		require_once(APPDIR . 'class.api.custom.php');
        // [FIXME] Fixcode
        if (isset($_SERVER['HTTP_HOST'])) {
        	$adminUrl   = (isset($_SERVER['HTTPS']) ? 'https://' : 'http://') . $_SERVER['HTTP_HOST']
                    . (preg_match('/^192\.168\.1/', $_SERVER['HTTP_HOST'])
                        ? '/demo/rvglobalsoft.com/public_html/7944web/api.php'
                        : '/7944web/api.php');
		} else {
			$adminUrl = 'https://rvglobalsoft.com/7944web/api.php';
		}
        $apiCustom  = ApiCustom::singleton($adminUrl);

        $params     = array(
            'call'      => 'setInvoiceStatus',
            'id'        => $id,
            'status'    => $status,
        );
       return $apiCustom->request($params);
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

        preg_match('/<\!\-\-\((\d{2}\/\d{2}\/\d{4})\s\-\s(\d{2}\/\d{2}\/\d{4})\)\-\->/', $desc, $matches);

        $termStart      = 0;
        $termEnd        = 0;
        if (isset($matches[1]) && isset($matches[2])) {
            $d          = substr($matches[1],0,2);
            $m          = substr($matches[1],3,2);
            $y          = substr($matches[1],6);
            $termStart  = strtotime($y .'-'. $m .'-'. $d);
            $d          = substr($matches[2],0,2);
            $m          = substr($matches[2],3,2);
            $y          = substr($matches[2],6);
            $termEnd    = strtotime($y .'-'. $m .'-'. $d);
        }

        if ($termStart && $termEnd) {
            $dayDiff    = floor(($termEnd - $termStart) / (60*60*24));
            $termStart  = time();
            $termEnd    = strtotime('+' . $dayDiff . ' day', $termStart);
            $desc       = preg_replace('/<\!\-\-(.*)\-\->/',
                            '(' . date('d/m/Y', $termStart) . ' - ' . date('d/m/Y', $termEnd) . ')',
                            $desc);
        }

        return $desc;
    }


//darawan
     public function provistion_manual ($aParam)
    {


        return $desc;
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
            $url        = 'https://rvglobalsoft.com';
        }
        $adminUrl       =  $url . '/' . $path . $adminFolder;
        
        return $adminUrl;
    }

    public function getClientUrl ()
    {
        $path           = substr(MAINDIR, (strpos(MAINDIR, '/public_html/')+13));
        $https          = isset($_SERVER['HTTPS']) ? 'https://' : 'http://';
        $httphost       = isset($_SERVER['HTTP_HOST']) ? $_SERVER['HTTP_HOST'] : '';
        $url            = '';
        if ($httphost) {
            $url        = $https . $httphost;
        } else {
            $url        = 'https://rvglobalsoft.com';
        }
        $adminUrl       = $url . '/' . $path ;

        return $adminUrl;
    }

    public function getIPFromConfig2Account ($accountId)
    {
        $db             = hbm_db();

        $result         = $db->query("
                SELECT
                    c2a.*
                FROM
                    hb_config2accounts c2a,
                    hb_config_items_cat cic
                WHERE
                    c2a.account_id = :accountId
                    AND c2a.rel_type = 'Hosting'
                    AND c2a.config_cat = cic.id
                    AND cic.variable = 'ip'
                ", array(
                    ':accountId'    => $accountId
                ))->fetch();

        return isset($result['data']) ? $result['data'] : '';
    }

    public function getPublicIPFromConfig2Account ($accountId)
    {
        $db             = hbm_db();

        $result         = $db->query("
                SELECT
                    c2a.*
                FROM
                    hb_config2accounts c2a,
                    hb_config_items_cat cic
                WHERE
                    c2a.account_id = :accountId
                    AND c2a.rel_type = 'Hosting'
                    AND c2a.config_cat = cic.id
                    AND cic.variable = 'public_ip'
                ", array(
                    ':accountId'    => $accountId
                ))->fetch();

        return isset($result['data']) ? $result['data'] : '';
    }

    public function updateCustomfieldData ($accountId, $relType, $variableName, $dataValue)
    {
        $db             = hbm_db();

        $result         = $db->query("
                SELECT
                    ci.id, ci.category_id
                FROM
                    hb_accounts a,
                    hb_products p,
                    hb_config_items_cat cic,
                    hb_config_items ci
                WHERE
                    a.id = :accountId
                    AND a.product_id = p.id
                    AND p.id = cic.product_id
                    AND cic.variable = :variableName
                    AND cic.id = ci.category_id
                ", array(
                    ':accountId'        => $accountId,
                    ':variableName'     => $variableName,
                ))->fetch();

        $configId       = (isset($result['id']) && $result['id']) ? $result['id'] : 0;
        $configCatId    = (isset($result['category_id']) && $result['category_id']) ? $result['category_id'] : 0;

        if (! $configId || ! $configCatId) {
            return;
        }

        $result         = $db->query("
                SELECT
                    c2a.account_id
                FROM
                    hb_config2accounts c2a
                WHERE
                    c2a.rel_type = :relType
                    AND c2a.account_id = :accountId
                    AND c2a.config_id = :configId
                ", array(
                    ':accountId'    => $accountId,
                    ':configId'     => $configId,
                    ':relType'      => $relType
                ))->fetch();

        if ( isset($result['account_id']) && $result['account_id']) {

            $db->query("
                UPDATE
                    hb_config2accounts
                SET
                    data = :dataValue
                WHERE
                    rel_type = :relType
                    AND account_id = :accountId
                    AND config_id = :configId
                ", array(
                    ':dataValue'    => $dataValue,
                    ':accountId'    => $accountId,
                    ':configId'     => $configId,
                    ':relType'      => $relType
                ));

        } else {

            $db->query("
                INSERT INTO `hb_config2accounts` (
                    `rel_type`, `account_id`, `config_cat`, `config_id`, `qty`, `data`
                ) VALUES (
                    :relType, :accountId, :configCat, :configId, 1, :dataValue
                )
                ", array(
                    ':accountId'    => $accountId,
                    ':configCat'    => $configCatId,
                    ':configId'     => $configId,
                    ':dataValue'    => $dataValue,
                    ':relType'      => $relType
                ));

        }

    }


    
    public function adminUIActionRequest ($cmd, $aPost = array())
    {
        require_once(APPDIR . 'class.config.custom.php');
        
        $cookiefile         = '/tmp/curl-session';
        $username           = ConfigCustom::singleton()->getValue('rvAdminUsername');
        $password           = ConfigCustom::singleton()->getValue('rvAdminPassword');
        
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
            throw new Exception('ไม่มีค่า csrf-token ไม่สามารถ run action request ได้');
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
        
    }
    
    public function addRvsitebuilderLicenseLog ($event, $request)
    {
        $db         = hbm_db();
        $aAdmin     = hbm_logged_admin();
        $aClient    = hbm_logged_client();
        $email      = isset($aAdmin['email']) ? $aAdmin['email'] : (isset($aClient['email']) ? 'Client '. $aClient['email'] : '');
        
        $expire = (isset($request['expire']) && (int) $request['expire']) ? date('Y-m-d H:i:s', (int) $request['expire']) : '0000-00-00 00:00:00';
        $log    = serialize($request);
        
        $db->query("
            INSERT INTO rvsitebuilder_license_log (
                id, `date`, client_id, account_id, `event`, primary_ip, secondary_ip, expire, `log`
            ) VALUES (
                '', NOW(), :client_id, :account_id, :event, :primary_ip, :secondary_ip, :expire, :log
            )
            ", array(
                ':client_id'    => $request['client_id'],
                ':account_id'   => $request['hb_acc'],
                ':event'        => $event,
                ':primary_ip'   => $request['primary_ip'],
                ':secondary_ip' => $request['secondary_ip'],
                ':expire'       => $expire,
                ':log'          => $log
            ));
        
        $aLog   = array(
            'serialized'    => 1,
            'data'          => array(
                array( 
                    'name'  => 'license',
                    'from'  => '',
                    'to'    => $request['license_id']
                ),
                array( 
                    'name'  => 'primary_ip',
                    'from'  => '',
                    'to'    => $request['primary_ip']
                ),
                array( 
                    'name'  => 'secondary_ip',
                    'from'  => '',
                    'to'    => $request['secondary_ip']
                ),
                array( 
                    'name'  => 'expire',
                    'from'  => '',
                    'to'    => $expire
                )
            )
        );
        
        $db->query("
            INSERT INTO hb_account_logs (
                id, date, account_id, admin_login, module, manual, action,
                `change`, result, error, event
            ) VALUES (
                '', NOW(), :account_id, :admin_login, 'none', '0', :action,
                :logs, '1', '', :event
            )
            ", array(
                ':account_id'       => $request['hb_acc'],
                ':admin_login'      => $email,
                ':logs'             => serialize($aLog),
                ':action'           => $event,
                ':event'            => $event
            ));
        
        
    }
    
}