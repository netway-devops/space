<?php

class productlicensehandle_controller extends HBController {

    private static  $instance;

    public $categoryId      = 6; // License product category id
    public $aStatus         = array(
        'All'       => array('Pending','Active','Suspended','Transfer','Transfer Request','Pending Transfer','Terminated'),
        'Pending'   => array('Pending','Transfer','Transfer Request','Pending Transfer'),
        'Active'    => array('Active'),
        'Suspended' => array('Suspended'),
        'Expired'   => array('Terminated'),
        );

    public static function singleton ()
    {
        if (!isset(self::$instance)) {
            $c = __CLASS__;
            self::$instance = new $c();
        }

        return self::$instance;
    }

    public function beforeCall ($request)
    {
        $this->_beforeRender();
    }

    public function _default ($request)
    {
        $db     = hbm_db();
    }

    public function productInfo ($request)
    {
        $db     = hbm_db();
        $product        = isset($request['product']) ? $request['product'] : '';
        if (! $product) {
            exit;
        }
        $this->template->render(dirname(dirname(__FILE__)) .'/templates/user/ajax.info.'. $product .'.tpl', array(), false);
    }

    public function listProduct ($request)
    {
        $db     = hbm_db();

        $aProduct       = array(
            /* --- Product --- */
            'Products'          => array(
                '64'            => array('slug' => 'cpanel', 'name' => 'cPanel', 'server' => 'VPS'),
                '63'            => array('slug' => 'cpanel', 'name' => 'cPanel', 'server' => 'Dedicated'),
                '109'           => array('slug' => 'cpanelrvskin', 'name' => 'cPanel+RVSkin', 'server' => 'Dedicated'),
                '111'           => array('slug' => 'cpanelrvskin', 'name' => 'cPanel+RVSkin', 'server' => 'VPS'),
                '155'           => array('slug' => 'cpanelrvskinrvsitebuilder', 'name' => 'cPanel+RVSkin+RVsitebuilder', 'server' => 'Dedicated'),
                '157'           => array('slug' => 'cpanelrvskinrvsitebuilder', 'name' => 'cPanel+RVSkin+RVsitebuilder', 'server' => 'VPS'),
                '135'           => array('slug' => 'ispmanager', 'name' => 'ISPmanager', 'server' => 'VPS'),
                '136'           => array('slug' => 'ispmanager', 'name' => 'ISPmanager', 'server' => 'Dedicated'),

                '71'            => array('slug' => 'rvskin', 'name' => 'RVSkin', 'server' => 'VPS'),
                '70'            => array('slug' => 'rvskin', 'name' => 'RVSkin', 'server' => 'Dedicated'),
                '67'            => array('slug' => 'rvsitebuilder', 'name' => 'RVSiteBuilder', 'server' => 'VPS'),
                '66'            => array('slug' => 'rvsitebuilder', 'name' => 'RVSiteBuilder', 'server' => 'Dedicated'),
                '158'           => array('slug' => 'rvsitebuilder7', 'name' => 'RVSiteBuilder License', 'server' => 'Dedicated'),
                '116'           => array('slug' => 'cloudlinux', 'name' => 'CloudLinux', 'server' => array('VPS', 'Dedicated'), 'dependon' => 'cpanel'),
                '137'           => array('slug' => 'cloudlinux', 'name' => 'CloudLinux', 'server' => array('VPS', 'Dedicated'), 'dependon' => 'other'),

                '138'           => array('slug' => 'litespeed', 'name' => 'LiteSpeed', 'server' => 'VPS', 'type' => 'Normal'),
                '139'           => array('slug' => 'litespeed', 'name' => 'LiteSpeed', 'server' => 'VPS', 'type' => 'Ultra'),
                '140'           => array('slug' => 'litespeed', 'name' => 'LiteSpeed', 'server' => 'Dedicated', 'cpu' => '1-CPU'),
                '141'           => array('slug' => 'litespeed', 'name' => 'LiteSpeed', 'server' => 'Dedicated', 'cpu' => '2-CPU'),
                '142'           => array('slug' => 'litespeed', 'name' => 'LiteSpeed', 'server' => 'Dedicated', 'cpu' => '4-CPU'),
                '143'           => array('slug' => 'litespeed', 'name' => 'LiteSpeed', 'server' => 'Dedicated', 'cpu' => '8-CPU'),

                '145'           => array('slug' => 'softaculous', 'name' => 'Softaculous', 'server' => 'VPS'),
                '144'           => array('slug' => 'softaculous', 'name' => 'Softaculous', 'server' => 'Dedicated'),

                '149'           => array('slug' => 'virtualizor', 'name' => 'Virtualizor', 'server' => 'Dedicated'),

                '108'           => array('slug' => 'rvlogin', 'name' => 'RVLogin'),
                ),
            'ServerType'        => array(
                'cpanel'        => array('Dedicated' => '63', 'VPS' => '64', 'name' => 'cPanel'),
                'cpanelrvskin'  => array('Dedicated' => '109', 'VPS' => '111', 'name' => 'cPanel+RVSkin'),
                'cpanelrvskinrvsitebuilder'     => array('Dedicated' => '155', 'VPS' => '157', 'name' => 'cPanel+RVSkin+RVsitebuilder'),
                'ispmanager'    => array('Dedicated' => '136', 'VPS' => '135', 'name' => 'ISPmanager'),
                'rvskin'        => array('Dedicated' => '70', 'VPS' => '71', 'name' => 'RVSkin'),
                'rvsitebuilder' => array('Dedicated' => '66', 'VPS' => '67', 'name' => 'RVSiteBuilder'),
                'rvsitebuilder7'=> array('Dedicated' => '158', 'VPS' => '158','name' => 'RVSiteBuilder License'),
                'cloudlinux'    => array('Dedicated' => '116', 'VPS' => '116', 'name' => 'CloudLinux'),
                'litespeed'     => array('Dedicated' => '140', 'VPS' => '138', 'name' => 'LiteSpeed'),
                'softaculous'   => array('Dedicated' => '144', 'VPS' => '145', 'name' => 'Softaculous'),
                'virtualizor'   => array('Dedicated' => '149', 'VPS' => '149', 'name' => 'Virtualizor'),
                ),
            );

        return $aProduct;
    }

    public function getProductNameById ($id)
    {
        $aProduct           = self::listProduct(array());
        return isset($aProduct['Products'][$id]['name']) ? $aProduct['Products'][$id]['name'] : '';
    }

    public function getProductById ($id)
    {
        $aProduct           = self::listProduct(array());
        return isset($aProduct['Products'][$id]) ? $aProduct['Products'][$id] : array();
    }

    public function verifyLicense ($request)
    {
        $db             = hbm_db();
        $client         = hbm_logged_client();
        $productId      = isset($_SESSION['Cart'][1]['id']) ? $_SESSION['Cart'][1]['id'] : 0;
        $aProduct       = self::listProduct(array());
        $isPartner      = $this->isPartner(array());
        $ip             = isset($request['ip']) ? $request['ip'] : '';
		$pb_ip          = isset($request['pb_ip']) ? $request['pb_ip'] : '';
		$ip_type        = isset($request['ip_type']) ? $request['ip_type'] : '';
        $product        = isset($request['product'])
                        ? strtolower($request['product'])
                        : $aProduct['Products'][$productId]['slug'];
        
        //if ($client['id'] == 9300) {
        
        $aCart      = isset($_SESSION['AppSettings']['Cart']) ? $_SESSION['AppSettings']['Cart'] : array();
        $cartIndex  = isset($_SESSION['AppSettings']['CartIndex']) ? $_SESSION['AppSettings']['CartIndex'] : -1;
        /*
        echo '<!-- {"ERROR":[]'
            . ',"RESULT":["NOTAVAILABLE"]'
            . ',"NOTAVAILABLE":['. json_encode($_SESSION) .']'
            . ',"STACK":0} -->';
        exit;
        */
        foreach ($aCart as $cartId => $arr) {
            if ($cartIndex == $cartId && isset($_SESSION['AppSettings']['Cart'][$cartIndex])) {
                continue;
            }
            $pid        = isset($arr['product']['id']) ? $arr['product']['id'] : 0;
            if ($pid != $productId) {
                continue;
            }
            $aConfig    = isset($arr['product_configuration']) ? $arr['product_configuration'] : array();
            foreach ($aConfig as $arr2) {
                foreach ($arr2 as $arr3) {
                    $k      = isset($arr3['variable']) ? $arr3['variable'] : '';
                    $v      = isset($arr3['val']) ? $arr3['val'] : '';
                    if ($k == 'ip' && $v == $ip) {
                        echo '<!-- {"ERROR":[]'
                            . ',"RESULT":["NOTAVAILABLE"]'
                            . ',"NOTAVAILABLE":["This​ IP​ is​ already​ in​ your​ <a href=/cart>shopping cart</a>."]'
                            . ',"STACK":0} -->';
                        exit;
                    }
                }
            }
        }

        //}
        
        if (! $productId) {
            echo '<!-- {"ERROR":[]'
                . ',"RESULT":["NOTAVAILABLE"]'
                . ',"NOTAVAILABLE":["Invalid product to order."]'
                . ',"STACK":0} -->';
            exit;
        }

        if (! $ip && (! $pb_ip || $pb_ip == '-')) {
            $bankip     = ($ip == '') ? 'IP Address cannot be blank. ' : '';
            echo '<!-- {"ERROR":[]'
                . ',"RESULT":["BLANKIP"]'
                . ',"BLANKIP":["' . $bankip . ' Please specify an IP Address to continue the order."]'
                . ',"STACK":0} -->';
            exit;
        }
        
        if (($product == 'rvskin' || $product == 'rvsitebuilder' || $product == 'rvsitebuilder7')) {
            // ไม่รับ IP ประเทศไทย
            $result     = @file_get_contents('http://freegeoip.net/json/'. $ip);
            $obj        = json_decode($result);
            if (isset($obj->country_code) && $obj->country_code == 'TH') {
                echo '<!-- {"ERROR":[]'
                        . ',"RESULT":["NOTAVAILABLE"]'
                        . ',"NOTAVAILABLE":["Sorry, this IP is not available to proceed the order."]'
                        . ',"STACK":0} -->';
                exit;
            }
        }

        if($db->query("SELECT id FROM fraud_server_ip WHERE ip = '{$ip}'")->fetchAll()){
        	echo '<!-- {"ERROR":[]'
        			. ',"RESULT":["NOTAVAILABLE"]'
        			. ',"NOTAVAILABLE":["Sorry, this IP is detected as Fruad IP. Please check your IP and submit again."]'
        			. ',"STACK":0} -->';
        	exit;
        }

        if ($isPartner && ($product == 'rvskin' || $product == 'rvsitebuilder' || $product == 'rvsitebuilder7')) {
            echo '<!-- {"ERROR":[]'
                . ',"RESULT":["NOTAVAILABLE"]'
                . ',"NOTAVAILABLE":["You can issue RVSkin , RVSitebuilder licenses in more easier way '
                . ' at your account under NOC Licenses page."]'
                . ',"STACK":0} -->';
            exit;
        }

        if (filter_var($ip, FILTER_VALIDATE_IP) === false) {
            echo '<!-- {"ERROR":[]'
                . ',"RESULT":["INVALIDIP"]'
                . ',"INVALIDIP":["The IP Address is invalid."]'
                . ',"STACK":0} -->';
            exit;
        }

		if($ip_type == 'Public'){
        	if (filter_var($pb_ip, FILTER_VALIDATE_IP) === false) {
	            echo '<!-- {"ERROR":[]'
	                . ',"RESULT":["INVALIDIP"]'
	                . ',"INVALIDIP":["The IP Address is invalid."]'
	                . ',"STACK":0} -->';
	            exit;
	        }
        }


        $_SESSION['aCart']   = array(
            'ip'        => $ip,
            'id'        => $productId
            );

        /* --- ตรวจสอบ module --- */
        $result         = self::validateModule($product);
        if (! isset($result['id'])) {
            echo '<!-- {"ERROR":[]'
                . ',"RESULT":["NOMODULE"]'
                . ',"NOMODULE":["Connection error please try again"]'  //[TODO] translator
                . ',"STACK":0} -->';
            exit;
        }

        /* --- ตรวจสอบ license ผ่าน module --- */
        $result         = self::validateLicense($product, $ip , $pb_ip);
        if (! $result->available) {
            $message    = (isset($result->message) && $result->message) ? $result->message : 'This IP already exists in our system.';
            echo '<!-- {"ERROR":[]'
                . ',"RESULT":["NOTAVAILABLE"]'
                . ',"NOTAVAILABLE":["'. $message .'"]'  //[TODO] translator
                . ',"STACK":0} -->';
            exit;
        /*} else if($result->available == "Transfer" && isset($result->risk_score) && $result->risk_score > 0) {
        	$message = 'We suspect that this IP may be a fraud. If you want to make an order, please submit a ticket by <a href=\"http://hostbill.rvglobalsoft.net/tickets/new&deptId=2\" target=\"_blank\">click here</a>.';
        	echo '<!-- {"ERROR":[]'
        			. ',"RESULT":["NOTAVAILABLE"]'
        			. ',"NOTAVAILABLE":["'. $message .'"]'  //[TODO] translator
        			. ',"STACK":0} -->';
        	exit;*/
        }

        $serverType     = $aProduct['Products'][$productId]['server'];
        $serverType     = is_array($serverType) ? $serverType[0] : $serverType;

		//เช็คว่าเป็น Private IP  หรือไม่
		$isPrivateIP	=	'FALSE';
		if($ip_type == 'Server'){
			if(self::ip_is_private($ip)){
				$isPrivateIP	=	'TRUE';
			}
		}

		if($ip_type == 'Public'){
			if($ip == $pb_ip){
				if(self::ip_is_private($ip)){
					$isPrivateIP	=	'TRUE';
				}
			}else{
				if( ! self::ip_is_private($ip) || self::ip_is_private($pb_ip)){
					$isPrivateIP	=	'TRUE';
				}
			}
		}


        echo '<!-- {"ERROR":[]'
            . ',"RESULT":["AVAILABLE"]'
            . ',"AVAILABLE":["'. $result->available .'"]'
            . ',"TYPE":["'. $serverType .'"]'
            . ',"NOTIFY":["\"serverType\":\"'. ((isset($result->type) && $serverType != $result->type) ? $result->type : '') .'\""]'
            . ',"DEDICATED":["'. $aProduct['ServerType'][$product]['Dedicated'] .'"]'
            . ',"VPS":["'. $aProduct['ServerType'][$product]['VPS'] .'"]'
            . ',"PRIVATEIP":["'. $isPrivateIP .'"]';
        if(($product == "cpanelrvskin" || $product == "cpanelrvskinrvsitebuilder") && isset($result->risk_score)){
        	echo ',"RISKSCORE":["'. $result->risk_score .'"]';
        }
        echo ',"STACK":0} -->';

        exit;
    }

    private function validateModule ($product)
    {
        $db         = hbm_db();

        $moduleFilename     = '';

        switch ($product) {
            case 'cpanelrvskin' :
            case 'cpanelrvskinrvsitebuilder' :
            case 'cpanel'       : {
                    $moduleFilename     = 'class.rvcpanel_manage2.php';
                    break;
                }
            case 'ispmanager'   : {
                    $moduleFilename     = 'class.ispmanagerlicensehandle.php';
                    break;
                }
            case 'cloudlinux'   : {
                    $moduleFilename     = 'class.cloudlinuxlicensehandle.php';
                    break;
                }
            case 'rvskin'   : {
                    $moduleFilename     = 'class.rvskin_license.php';
                    break;
                }
            case 'rvsitebuilder7'   : 
            case 'rvsitebuilder'   : {
                    $moduleFilename     = 'class.rvsitebuilder_license.php';
                    break;
                }
            case 'softaculous'   : {
                    $moduleFilename     = 'class.softaculouslicensehandle.php';
                    break;
                }
            case 'litespeed'    : {
                    $moduleFilename     = 'class.litespeedlicensehandle.php';
                    break;
                }
            case 'rvlogin'    : {
                    $moduleFilename     = 'class.rvlogin_license.php';
                    break;
                }
            case 'virtualizor'  : {
                    $moduleFilename     = 'class.virtualizorlicensehandle.php';
                    break;
                }
        }

        $result     = $db->query("
            SELECT
                *
            FROM
                hb_modules_configuration
            WHERE
                filename = '{$moduleFilename}'
                AND active = 1
            ")->fetch();

        return $result;
    }

    private function validateLicense ($product, $ip , $pb_ip = '')
    {
        
        switch ($product) {
            case 'cpanelrvskin' :
            case 'cpanelrvskinrvsitebuilder' :
            case 'cpanel'       : {
                    require_once (APPDIR .'modules/Hosting/rvcpanel_manage2/class.rvcpanel_manage2.php');
                    $result     = rvcpanel_manage2::singleton()->verifyLicense($ip);
                    break;
                }
            case 'ispmanager'   : {
                    require_once (APPDIR .'modules/Hosting/ispmanagerlicensehandle/class.ispmanagerlicensehandle.php');
                    $result     = ispmanagerlicensehandle::singleton()->verifyLicense($ip);
                    break;
                }
            case 'cloudlinux'   : {
                    require_once (APPDIR .'modules/Hosting/cloudlinuxlicensehandle/class.cloudlinuxlicensehandle.php');
                    $result     = cloudlinuxlicensehandle::singleton()->verifyLicense($ip);
                    break;
                }
            case 'rvskin'       : {
                    require_once (APPDIR .'modules/Hosting/rvskin_license/class.rvskin_license.php');
                    $result     = rvskin_license::singleton()->verifyLicense($ip , $pb_ip);
                    break;
                }
            case 'rvsitebuilder7'    :
            case 'rvsitebuilder'    : {
                    require_once (APPDIR .'modules/Hosting/rvsitebuilder_license/class.rvsitebuilder_license.php');
                    $result     = rvsitebuilder_license::singleton()->verifyLicense($ip , $pb_ip);
                    break;
                }
            case 'softaculous'    : {
                    require_once (APPDIR .'modules/Hosting/softaculouslicensehandle/class.softaculouslicensehandle.php');
                    $result     = softaculouslicensehandle::singleton()->verifyLicense($ip);
                    break;
                }
            case 'litespeed'    : {
                    require_once (APPDIR .'modules/Hosting/litespeedlicensehandle/class.litespeedlicensehandle.php');
                    $result     = litespeedlicensehandle::singleton()->verifyLicense($ip);
                    break;
                }
            case 'rvlogin'    : {
                    require_once (APPDIR .'modules/Hosting/rvlogin_license/class.rvlogin_license.php');
                    $result     = rvlogin_license::singleton()->verifyLicense($ip , $pb_ip);
                    break;
                }
            case 'virtualizor'  : {
                    require_once (APPDIR .'modules/Hosting/virtualizorlicensehandle/class.virtualizorlicensehandle.php');
                    $result     = virtualizorlicensehandle::singleton()->verifyLicense($ip , $pb_ip);
                    break;
                }
        }

        return $result;
    }

    public function getBillingCycle ($request)
    {
        $db         = hbm_db();

        $product        = isset($request['product']) ? $request['product'] : '';
        $type           = isset($request['type']) ? $request['type'] : '';

        $productId      = 0;

        $aProduct       = self::listProduct(array());
        foreach ($aProduct['Products'] as $id => $arr) {
            if ($arr['slug'] == $product && ( $arr['server'] == $type || in_array($type, $arr['server']) )) {
                $productId      = $id;
            }
        }

        $result         = $db->query("
            SELECT
                c.*
            FROM
                hb_common c
            WHERE
                c.id = :produuctId
                AND c.rel = 'Product'
                AND c.paytype = 'Regular'
            ", array(
                ':produuctId'   => $productId
            ))->fetch();


        $status         = isset($result['id']) ? 'success' : 'error';
        $aBillingCycle  = array();

        if (floatval($result['m']) > 0) {
            $aBillingCycle['m'] = $result['m']. ' USD / Monthly';
        }
        if (floatval($result['q']) > 0) {
            $aBillingCycle['q'] = $result['q']. ' USD / Quarterly';
        }
        if (floatval($result['s']) > 0) {
            $aBillingCycle['s'] = $result['s']. ' USD / Semi-Annually';
        }
        if (floatval($result['a']) > 0) {
            $aBillingCycle['a'] = $result['a']. ' USD / Annually';
        }
        if (floatval($result['b']) > 0) {
            $aBillingCycle['b'] = $result['b']. ' USD / Biennially';
        }
        if (floatval($result['t']) > 0) {
            $aBillingCycle['t'] = $result['t']. ' USD / Triennially';
        }

        $recurring      = '';
        $aCart          = isset($_SESSION['AppSettings']['Cart']) ? $_SESSION['AppSettings']['Cart'] : array();
        if (count($aCart)) {
            $idx        = self::getCurrentCartIndex(array('output' => 'index'));
            $recurring  = isset($aCart[$idx]['product']['recurring']) ? $aCart[$idx]['product']['recurring'] : '';
        }

        echo '<!-- {"ERROR":[]'
            . ',"RESULT":["'. $status .'"]'
            . ',"PRODUCTID":["'. $productId .'"]'
            . ',"RECURRING":["'. $recurring .'"]'
            . ',"BILLINGCYCLE":['. json_encode($aBillingCycle) .']'
            . ',"STACK":0} -->';

        exit;
    }

    public function isExistedInCart ($request)
    {
        $db         = hbm_db();

        $product        = isset($request['product']) ? $request['product'] : '';
        $productId      = isset($request['productId']) ? $request['productId'] : 0;
        $ipaddress      = isset($request['ipaddress']) ? $request['ipaddress'] : '';
        $serverType     = isset($request['serverType']) ? $request['serverType'] : '';

        $aItem          = array();

        /* --- อยู่ในขั้นตอนการเตรียมตระกร้า --- */
        $aCart          = isset($_SESSION['Cart']) ? $_SESSION['Cart'] : array();

        if (count($aCart)) {
            foreach ($aCart as $k => $arr) {
                $pid        = isset($arr['id']) ? $arr['id'] : 0;
                if ($pid == $productId) {
                    $aItem['idx']       = $k;

                    /* --- custom field --- */


                    echo '<!-- {"ERROR":[]'
                        . ',"RESULT":["TRUE"]'
                        . ',"TRUE":['. json_encode($aItem) .']'
                        . ',"STACK":0} -->';
                    exit;
                }
            }
        }

        /* --- อยู่ในตระกร้าแล้ว --- */
        $aCart          = isset($_SESSION['AppSettings']['Cart']) ? $_SESSION['AppSettings']['Cart'] : array();
        if (count($aCart)) {
            $idx        = self::getCurrentCartIndex(array('output' => 'index'));
            $pid        = isset($aCart[$idx]['product']['id']) ? $aCart[$idx]['product']['id'] : 0;
            $oldpid     = isset($_SESSION['aCart']['productId']) ? $_SESSION['aCart']['productId'] : 0;
            if ($pid && $pid == $oldpid) {
                $aItem['idx']       = $idx;
            }
        }

        $_SESSION['aCart']   = array(
            'product'       => $product,
            'productId'     => $productId,
            'ipaddress'     => $ipaddress,
            'serverType'    => $serverType
            );

        $_SESSION['Cart'][1]        = array();
        $_SESSION['Cart'][2]        = array();

        echo '<!-- {"ERROR":[]'
            . ',"RESULT":["FALSE"]'
            . ',"FALSE":['. json_encode($aItem) .']'
            . ',"STACK":0} -->';
        exit;
    }

    public function getCurrentCartIndex ($request)
    {
        $output         = isset($request['output']) ? $request['output'] : '';

        $aCart          = isset($_SESSION['AppSettings']['Cart']) ? $_SESSION['AppSettings']['Cart'] : array();
        $idx            = isset($_SESSION['AppSettings']['CartIndex']) ? $_SESSION['AppSettings']['CartIndex'] : '';

        if ( ! isset($aCart[$idx])) {
            $idx        = '';
        }

        if ($output == 'index') {
            return $idx;
        }

        echo '<!-- {"ERROR":[]'
            . ',"RESULT":['. $idx .']'
            . ',"STACK":0} -->';
        exit;
    }

    public function getLatestCartIndex ($request)
    {
        $aCart          = isset($_SESSION['AppSettings']['Cart']) ? $_SESSION['AppSettings']['Cart'] : array();

        $idx            = key( array_slice( $aCart, -1, 1, TRUE ) );
        //$idx            = $idx ? $idx : 0;
        echo '<!-- {"ERROR":[]'
            . ',"RESULT":['. $idx .']'
            . ',"STACK":0} -->';
        exit;
    }

    public function getCurrentOrderItem ($request)
    {
        $aCart      = isset($_SESSION['aCart']) ? $_SESSION['aCart'] : array();
        $idx        = self::getCurrentCartIndex(array('output' => 'index'));

        if (isset($_SESSION['AppSettings']['Cart'][$idx])) {
            $aCart['CartIndex']     = $idx;

            $aItem          = $_SESSION['AppSettings']['Cart'][$idx];
            $productId      = $aItem['product']['id'];
            $aCart['productId']     = $productId;

            $aProduct       = self::listProduct(array());
            $aCart['product']       = $aProduct['Products'][$productId]['slug'];
            $aCart['serverType']    = $aProduct['Products'][$productId]['server'];

            if (isset($aItem['product_configuration']) && count($aItem['product_configuration'])) {
                foreach ($aItem['product_configuration'] as $k => $arr) {
                    if (is_array($arr) && count($arr)) {

                        foreach ($arr as $k2 => $arr2) {
                            if (preg_match('/^IP/i', $arr2['name'])) {
                                $aCart['ipaddress']     = $arr2['val'];
                            }
                        }

                    }
                }
            }

        } elseif (isset($_SESSION['Cart'][1])) {
            $aCart['CartIndex']     = 0;
            $productId              = $_SESSION['Cart'][1]['id'];
            $aCart['productId']     = $productId;
            $aProduct               = self::listProduct(array());
            $aCart['product']       = $aProduct['Products'][$productId]['slug'];
            $aCart['serverType']    = $aProduct['Products'][$productId]['server'];
        }

        $_SESSION['aCart']      = $aCart;

        echo '<!-- {"ERROR":[]'
            . ',"RESULT":['. json_encode($aCart) .']'
            . ',"STACK":0} -->';
        exit;
    }

    public function currentProduct ($request)
    {
        $product        = isset($_SESSION['aCart']['product']) ? $_SESSION['aCart']['product'] : '';

        // --- ส่ง url มาแบบ ?cmd=cart&action=add&id=63  ---
        if (! $product) {
            $productId  = $_SESSION['Cart'][1]['id'];
            $aProduct   = self::listProduct(array());
            $product    = $aProduct['Products'][$productId]['slug'];

            require_once(APPDIR . 'class.general.custom.php');
            $clientUrl  = GeneralCustom::singleton()->getClientUrl();

            echo '
                <script type="text/javascript">
                window.location.href = "'. $clientUrl .'cart/licenses/&product='. $product .'&id='. $productId .'";
                </script>
                ';
            exit;

        }
        return $product;
    }

    public function customfieldData ($request)
    {
        $db             = hbm_db();

        $productId      = isset($request['productId']) ? $request['productId'] : 0;

        $result         = $db->query("
            SELECT
                cic.id AS cid, cic.variable,
                ci.id
            FROM
                hb_config_items_cat cic,
                 hb_config_items ci
            WHERE
                cic.id = ci.category_id
                AND cic.product_id = :productId
            ", array(
                ':productId'    => $productId
            ))->fetchAll();

        $aCustom        = array();
        $aCustom[-1]    = 'dummy';
        $customurl      = '&custom[-1]=dummy';
        if (count($result)) {
            foreach ($result as $arr) {
                $cid            = $arr['cid'];
                $id             = $arr['id'];
                $variable       = $arr['variable'];
                $value          = '';
                switch ($variable) {
                    case 'ip': {
                        $value  = isset($_SESSION['aCart']['ipaddress']) ? $_SESSION['aCart']['ipaddress'] : '';
                        break;
                    }
                }

                $aCustom[$cid][$id]     = $value;
                $customurl      .= '&custom['. $cid .']['. $id .']='. $value;

            }
        }

        echo '<!-- {"ERROR":[]'
            . ',"RESULT":['. json_encode($aCustom) .']'
            . ',"RESULT_STRING":["'. $customurl .'"]'
            . ',"STACK":0} -->';
        exit;
    }

    public function getSubProduct ()
    {
        $idx            = self::getCurrentCartIndex(array('output' => 'index'));
        $aCart          = isset($_SESSION['AppSettings']['Cart']) ? $_SESSION['AppSettings']['Cart'] : array();
        $aSubProduct    = isset($aCart[$idx]['subproducts']) ? $aCart[$idx]['subproducts'] : array();
        $aSub           = array();
        if (count($aSubProduct)) {
            foreach ($aSubProduct as $k => $v) {
                array_push($aSub, $k);
            }
        }
        echo '<!-- {"ERROR":[]'
            . ',"RESULT":['. json_encode($aSub) .']'
            . ',"STACK":0} -->';
        exit;
    }

    public function isPartner ($request)
    {
        $db             = hbm_db();
        $client         = hbm_logged_client();
        $clientId       = isset($client['id']) ? $client['id'] : 0;

        $result         = $db->query("
                SELECT
                    cfv.value
                FROM
                    hb_client_fields cf,
                    hb_client_fields_values cfv
                WHERE
                    cfv.client_id = :clientId
                    AND cf.code= 'partner'
                    AND cf.id = cfv.field_id
                ", array(
                    ':clientId'     => $clientId
                ))->fetch();

        return isset($result['value']) ? $result['value'] : '';
    }

    public function addOrderType ($request)
    {
        $db             = hbm_db();
        $index          = isset($request['index']) ? $request['index'] : 0;
        $type           = isset($request['type']) ? $request['type'] : 'Register';
        $sub            = isset($request['sub']) ? $request['sub'] : array();

        $aCart          = $_SESSION['AppSettings']['Cart'][$index];
        $aCart['product']['order_type']         = $type;

        if (count($sub)) {
            foreach ($sub as $k => $v) {
                if (isset($aCart['subproducts'][$k])) {
                    $aCart['subproducts'][$k]['order_type'] = $v;
                }
            }
        }

        $_SESSION['aCart']['items'][$index]     = $aCart;

        echo '<!-- {"ERROR":[]'
            . ',"RESULT":[TRUE]'
            . ',"STACK":0} -->';
        exit;
    }

    /**
     * ลบ shopping cart item ที่มีอยู่แล้วใน account ออก
     */
    public function validateCartItem ()
    {
        $db             = hbm_db();
        $aProduct       = self::listProduct(array());
        $idx            = -1;
        $client         = hbm_logged_client();
        $clientId       = isset($client['id']) ? $client['id'] : 0;

        if (! $clientId) {
            return $idx;
        }

        $aCart          = $_SESSION['AppSettings']['Cart'];
        if (! count($aCart)) {
            return $idx;
        }

        $aProductId     = array_keys($aProduct['Products']);

        foreach ($aCart as $cartIdx => $arr) {
            $productId      = $arr['product']['id'];

            if (! in_array($productId, $aProductId)) {
                continue;
            }

            $product        = $aProduct['Products'][$productId]['slug'];

            $pid        = array();
            foreach ($aProductId as $v) {
                if ($aProduct['Products'][$v]['slug'] == $product) {
                    array_push($pid, $v);
                }
            }

            $ip             = '';
            $aConfig        = $arr['product_configuration'];
            if (count($aConfig)) {
                foreach ($aConfig as $k => $v) {
                    foreach ($aConfig as $k2 => $v2) {
                        if (preg_match('/^IP/i', $v2['name'])) {
                            $ip     = $v2['val'];
                            break 2;
                        }
                    }
                }
            }

            switch ($product) {
                case 'rvskin': {

                    break;
                }
                
                case 'rvsitebuilder7': 
                case 'rvsitebuilder': {

                    break;
                }

                default : {
                    $result         = $db->query("
                            SELECT
                                c2a.*
                            FROM
                                hb_accounts a,
                                hb_config2accounts c2a,
                                hb_config_items_cat cic
                            WHERE
                                a.id = c2a.account_id
                                AND c2a.rel_type = 'Hosting'
                                AND a.status = 'Active'
                                AND cic.variable = 'ip'
                                AND cic.id = c2a.config_cat
                                AND a.client_id = :clientId
                                AND a.product_id IN (". implode(',', $pid) .")
                                AND c2a.data = :ip
                            ", array(
                                ':clientId'     => $clientId,
                                ':ip'           => $ip
                            ))->fetch();

                    if (isset($result['config_id'])) {
                        return $cartIdx;
                    }

                }

            }



        }

        return $idx;
    }

    public function isPartnerOrderOurLicense ()
    {
        $db             = hbm_db();
        $aProduct       = self::listProduct(array());
        $isPartner      = $this->isPartner(array());
        $idx            = -1;

        if (! $isPartner) {
            return $idx;
        }

        $aCart          = $_SESSION['AppSettings']['Cart'];
        if (! count($aCart)) {
            return $idx;
        }

        $aProductId     = array_keys($aProduct['Products']);

        foreach ($aCart as $cartIdx => $arr) {
            $productId      = $arr['product']['id'];
            $product        = $aProduct['Products'][$productId]['slug'];

            if ($product == 'rvskin' || $product == 'rvsitebuilder' || $product == 'rvsitebuilder7') {
                return $cartIdx;
            }

        }

        return $idx;
    }

    public function listLicense ($request)
    {
        $db             = hbm_db();
        $client         = hbm_logged_client();
        $clientId       = isset($client['id']) ? $client['id'] : 0;

        $status         = (isset($request['status']) && $request['status']) ? $request['status']: 'All';
        $page           = isset($request['page']) ? $request['page']: 1;
        $keyword        = isset($request['keyword']) ? $request['keyword']: '';
        $limit          = 10;
        $offset         = ($page - 1) * $limit;

        $result         = $db->query("
                SELECT COUNT( * ) AS totals
                FROM (
                    SELECT
                        COUNT(c2a.data) AS total
                    FROM
                        hb_accounts a,
                        hb_products p,
                        hb_config2accounts c2a,
                        hb_config_items_cat cic
                    WHERE
                        a.id = c2a.account_id
                        AND a.product_id = p.id
                        AND a.status NOT IN ('Cancelled','Fraud')
                        AND p.category_id = :catId
                        AND c2a.rel_type = 'Hosting'
                        AND a.status IN ('". implode("','", $this->aStatus[$status]) ."')
                        AND cic.variable = 'ip'
                        AND cic.id = c2a.config_cat
                        AND a.client_id = :clientId
                        ". ($keyword ? " AND c2a.data = '{$keyword}' " : " " )."
                    GROUP BY
                        c2a.data
                    ) X
                ", array(
                    ':catId'        => $this->categoryId,
                    ':clientId'     => $clientId
                ))->fetch();

        $total          = isset($result['totals']) ? $result['totals'] : 0;

        $aLicenses      = array(
            'total'     => $total,
            'pages'     => ceil($total/$limit),
            'lists'     => array()
        );

        $result         = $db->query("
                SELECT
                    a.id, a.product_id,
                    c2a.data,
                    sn.hostname
                FROM
                    hb_accounts a,
                    hb_products p,
                    hb_config_items_cat cic,
                    hb_config2accounts c2a
                    LEFT JOIN
                        hb_server_name sn
                        ON sn.ip_user = c2a.data
                WHERE
                    a.id = c2a.account_id
                    AND a.product_id = p.id
                    AND a.status NOT IN ('Cancelled','Fraud')
                    AND p.category_id = :catId
                    AND c2a.rel_type = 'Hosting'
                    AND a.status IN ('". implode("','", $this->aStatus[$status]) ."')
                    AND cic.variable = 'ip'
                    AND cic.id = c2a.config_cat
                    AND a.client_id = :clientId
                    ". ($keyword ? " AND c2a.data = '{$keyword}' " : " " )."
                GROUP BY
                    c2a.data
                ORDER BY
                    a.status ASC, a.next_due ASC
                LIMIT {$offset}, {$limit}
                ", array(
                    ':catId'        => $this->categoryId,
                    ':clientId'     => $clientId
                ))->fetchAll();

        if (count($result)) {
            foreach ($result as $k => $arr) {
                $ip             = $arr['data'];
                $productId      = $arr['product_id'];
                $aData          = array(
                    'ip'        => $ip,
                    'hostname'  => ($arr['hostname'] ? $arr['hostname'] : 'N/A.'),
                    'more'      => self::_moreAvailable($productId, $ip, $k),
                    'items'     => self::_currentLicenses($ip, $status),
                    );
                array_push($aLicenses['lists'], $aData);
            }
        }

        return $aLicenses;
    }

    private function _moreAvailable ($productId, $ip, $k)
    {
        $db             = hbm_db();
        $client         = hbm_logged_client();
        $clientId       = isset($client['id']) ? $client['id'] : 0;
        $aProduct       = self::listProduct(array());

        $result         = $db->query("
                SELECT
                    p.id
                FROM
                    hb_accounts a,
                    hb_products p,
                    hb_config2accounts c2a,
                    hb_config_items_cat cic
                WHERE
                    a.id = c2a.account_id
                    AND a.product_id = p.id
                    AND a.status IN ('Active','Suspended')
                    AND p.category_id = :catId
                    AND c2a.rel_type = 'Hosting'
                    AND cic.variable = 'ip'
                    AND cic.id = c2a.config_cat
                    AND a.client_id = :clientId
                    AND c2a.data = :ip
                ", array(
                    ':catId'        => $this->categoryId,
                    ':clientId'     => $clientId,
                    ':ip'           => $ip
                ))->fetchAll();

        $aExisted           = array();

        if (count($result)) {
            foreach ($result as $arr) {
                $slug       = isset($aProduct['Products'][$arr['id']]) ? $aProduct['Products'][$arr['id']]['slug'] : '';
                if ($slug) {
                    array_push($aExisted, $slug);
                }
            }
        }


        // [TODO]
        /*
        cPanel License (for vzzo server)
        https://rvglobalsoft.com/7944web/index.php?cmd=services&action=product&id=65

        Free Cpanel License (for dedicated server)
        https://rvglobalsoft.com/7944web/index.php?cmd=services&action=product&id=96
        Free Cpanel License (for vps server)
        https://rvglobalsoft.com/7944web/index.php?cmd=services&action=product&id=97

        Cpanel License + Free RVSkin (for dedicated)
        https://rvglobalsoft.com/7944web/index.php?cmd=services&action=product&id=109
        Cpanel License + Free RVSkin (for vps server)
        https://rvglobalsoft.com/7944web/index.php?cmd=services&action=product&id=111
        Cpanel License + Free RVSkin (for vzzo server)
        https://rvglobalsoft.com/7944web/index.php?cmd=services&action=product&id=113
        */

        if ( in_array($productId, array('65','96','97')) ) {
            array_push($aExisted, 'cpanel');
            array_push($aExisted, 'ispmanager');
        }
        if ( in_array($productId, array('109','111','113')) ) {
            array_push($aExisted, 'cpanel');
            array_push($aExisted, 'ispmanager');
            array_push($aExisted, 'rvskin');
        }


        $aVailable          = array();

        foreach ($aProduct['ServerType'] as $slug => $arr) {
            if (! in_array($slug, $aExisted)) {
                
                // เลิกขายแล้ว
                if ($slug == 'ispmanager' || $slug == 'litespeed' || $slug == 'cpanelrvskinrvsitebuilder') {
                    continue;
                }

                if ($slug == 'ispmanager' && in_array('cpanel', $aExisted)) {
                    continue;
                }
                if ($slug == 'cpanel' && in_array('ispmanager', $aExisted)) {
                    continue;
                }

                $aVailable[$slug]   = $aProduct['ServerType'][$slug];
                $productId          = $aProduct['ServerType'][$slug]['VPS'];

                // --- แสดงเฉพาะรายการแรก ---
                if ($k == 0) {
                    $result         = $db->query("
                        SELECT
                            c.m
                        FROM
                            hb_common c
                        WHERE
                            c.id = :productId
                            AND c.rel = 'Product'
                            AND c.paytype = 'Regular'
                        ", array(
                            ':productId'        => $productId
                        ))->fetch();

                    $aVailable[$slug]['price']  = isset($result['m']) ? $result['m'] : 0;

                    $oResult                    = self::validateLicense ($slug, $ip);
                    if (isset($oResult->available) && $oResult->available) {
                        $aVailable[$slug]['available']  = $oResult->available;
                    }

                }

            }
        }

        return $aVailable;
    }

    private function _currentLicenses ($ip, $status)
    {
        $db             = hbm_db();
        $client         = hbm_logged_client();
        $clientId       = isset($client['id']) ? $client['id'] : 0;

        $result         = $db->query("
                SELECT
                    a.id, a.status, a.next_due AS expire, a.product_id,
                    p.name AS product
                FROM
                    hb_accounts a,
                    hb_products p,
                    hb_config2accounts c2a,
                    hb_config_items_cat cic
                WHERE
                    a.id = c2a.account_id
                    AND a.product_id = p.id
                    AND a.status NOT IN ('Cancelled','Fraud')
                    AND p.category_id = :catId
                    AND c2a.rel_type = 'Hosting'
                    AND cic.variable = 'ip'
                    AND cic.id = c2a.config_cat
                    AND a.client_id = :clientId
                    AND c2a.data = :ip
                    AND a.status IN ('". implode("','", $this->aStatus[$status]) ."')
                ORDER BY
                    a.status ASC, a.next_due ASC
                ", array(
                    ':catId'        => $this->categoryId,
                    ':clientId'     => $clientId,
                    ':ip'           => $ip
                ))->fetchAll();

        if (count($result)) {
            $result_    = $result;
            foreach ($result_ as $k => $arr) {
                $aExpire                = self::getExpireDate (
                        $arr['id'], $arr['product_id'], $ip, $arr['expire'], $arr['status']
                        );
                $result[$k]['expire']     = $aExpire['expire'];
            }
        }

        return $result;
    }

    public function countLicense ($request)
    {
        $db             = hbm_db();
        $client         = hbm_logged_client();
        $clientId       = isset($client['id']) ? $client['id'] : 0;

        $status         = $request['status'];

        $result         = $db->query("
                SELECT
                    COUNT(a.id) AS total
                FROM
                    hb_accounts a,
                    hb_products p
                WHERE
                    a.product_id = p.id
                    AND a.status NOT IN ('Cancelled','Fraud')
                    AND p.category_id = :catId
                    AND a.status IN ('". implode("','", $this->aStatus[$status]) ."')
                    AND a.client_id = :clientId
                ", array(
                    ':catId'        => $this->categoryId,
                    ':clientId'     => $clientId,
                ))->fetch();

        return isset($result['total']) ? $result['total'] : 0;
    }

    /**
     * อ้างอิง
     * /rvglobalsoft.com/public_html/templates/netwaybysidepad/rvlicense/services_product_license.tpl.php
     */
    public function getExpireDate ($accountId, $productId, $ip, $nextDue, $status)
    {
        $db             = hbm_db();

        require_once(APPDIR . 'modules/Other/billingcycle/api/class.billingcycle_controller.php');

        $aExpired       = array(
            'expire'    => '',
            'color'     => ''
            );
        $aData          = array(
            'accountId'     => $accountId,
            'nextDue'       => $nextDue
            );

        if ($status == 'Terminated') {
            $aExpire    = billingcycle_controller::getAccountExpiryDate($aData);

            if (isset($aExpire[1]['expire']) && $aExpire[1]['expire'] != '') {
                $aExpire            = $aExpire[1];
                list($d,$m,$y)      = explode('/',$aExpire['expire']);
                $aExpired['expire'] = date('M j, Y',strtotime($y . '-' . $m . '-' . $d));

            } else {
                $aExpired['expire'] = '-';
            }

        } else {
            $product        = self::getProductNameById($productId);

            if (preg_match('/RVSiteBuilder/i', $product)) {
                $result     = $db->query("
                    SELECT
                        rl.expire
                    FROM
                        rvsitebuilder_license rl
                    WHERE
                        rl.hb_acc = :accountId
                        AND rl.primary_ip = :ip
                    ", array(
                        ':accountId'    => $accountId,
                        ':ip'           => $ip
                    ))->fetch();

                $aExpired['expire']     = date('M j, Y', $result['expire']);
                $aExpired['color']      = '';

            } elseif ($product == 'RVSkin') {
                $result     = $db->query("
                    SELECT
                        rl.expire
                    FROM
                        rvskin_license rl
                    WHERE
                        rl.hb_acc = :accountId
                        AND rl.main_ip = :ip
                    ", array(
                        ':accountId'    => $accountId,
                        ':ip'           => $ip
                    ))->fetch();

                $aExpired['expire']     = date('M j, Y', $result['expire']);
                $aExpired['color']      = '';

            } else {
                $aExpire        = billingcycle_controller::getAccountExpiryDate($aData);
                $aExpire        = $aExpire[1];
                list($d,$m,$y)  = explode('/', $aExpire['expire']);
                $aExpired['expire']     = date('M j, Y',strtotime($y . '-' . $m . '-' . $d));

            }
        }

        return $aExpired;
    }

    public function getIPAddress ($accountId, $raw = false)
    {
        $db             = hbm_db();

        $result         = $db->query("
                SELECT
                    c2a.*
                FROM
                    hb_accounts a,
                    hb_config2accounts c2a,
                    hb_config_items_cat cic
                WHERE
                    a.id = :accountId
                    AND a.id = c2a.account_id
                    AND c2a.rel_type = 'Hosting'
                    AND cic.variable = 'ip'
                    AND cic.id = c2a.config_cat
                ", array(
                    ':accountId'     => $accountId
                ))->fetch();

        if ($raw) {
            return $result;
        }

        return isset($result['data']) ? $result['data'] : '';
    }

    public function changeip ($request)
    {
        $db             = hbm_db();
        $client         = hbm_logged_client();
        $clientId       = isset($client['id']) ? $client['id'] : 0;
        $ip             = isset($request['ip']) ? $request['ip'] : '';
        $accountId      = isset($request['accountId']) ? $request['accountId'] : 0;

        if (! $ip) {
            echo '<!-- {"ERROR":["IP Address cannot be blank. Please specify an IP Address to continue."]'
                . ',"RESULT":["ERROR"]'
                . ',"STACK":0} -->';
            exit;
        }

        if (filter_var($ip, FILTER_VALIDATE_IP) === false) {
            echo '<!-- {"ERROR":["The IP Address is invalid."]'
                . ',"RESULT":["ERROR"]'
                . ',"STACK":0} -->';
            exit;
        }

        $result         = $db->query("
                SELECT
                    *
                FROM
                    fraud_server_ip
                WHERE
                    ip = :ip
                ", array(
                    ':ip'   => $ip,
                ))->fetch();

        if (isset($result['id'])) {
            echo '<!-- {"ERROR":["This IP : '. $ip .' is fraud, please contact staff."]'
                . ',"RESULT":["ERROR"]'
                . ',"STACK":0} -->';
            exit;
        }

        $result         = $db->query("
                SELECT
                    a.*
                FROM
                    hb_accounts a
                WHERE
                    a.id = :accountId
                    AND a.client_id = :clientId
                    AND a.status = 'Active'
                ", array(
                    ':accountId'        => $accountId,
                    ':clientId'         => $clientId,
                ))->fetch();

        if (! isset($result['id'])) {
            echo '<!-- {"ERROR":["Cannot find account detail as your request."]'
                . ',"RESULT":["ERROR"]'
                . ',"STACK":0} -->';
            exit;
        }

        $productId          = $result['product_id'];
        $aProduct           = self::listProduct(array());
        $product            = $aProduct['Products'][$productId]['slug'];
		
        $result             = (object) array(
            'success'       => false,
            'message'       => 'Connection fail, please contact staff.'
            );

        $aData              = self::getIPAddress($accountId, true);
        $oldIp              = isset($aData['data']) ? $aData['data'] : '';

        switch ($product) {
            case 'ispmanager'   : {
                    require_once (APPDIR .'modules/Hosting/ispmanagerlicensehandle/'
                        .'user/class.ispmanagerlicensehandle_controller.php');
                    $result     = ispmanagerlicensehandle_controller::singleton()->changeip(array(
                        'accountId'     => $accountId,
                        'oldIp'         => $oldIp,
                        'ip'            => $ip,
                        ));
                    break;
                }
            case 'cloudlinux'   : {
                    require_once (APPDIR .'modules/Hosting/cloudlinuxlicensehandle/'
                        .'user/class.cloudlinuxlicensehandle_controller.php');
                    $result     = cloudlinuxlicensehandle_controller::singleton()->changeip(array(
                        'accountId'     => $accountId,
                        'oldIp'         => $oldIp,
                        'ip'            => $ip,
                        ));
                    break;
                }
            case 'softaculous'    : {
                    require_once (APPDIR .'modules/Hosting/softaculouslicensehandle/'
                        .'user/class.softaculouslicensehandle_controller.php');
                    $result     = softaculouslicensehandle_controller::singleton()->changeip(array(
                        'accountId'     => $accountId,
                        'oldIp'         => $oldIp,
                        'ip'            => $ip,
                        ));
                    break;
                }
            case 'litespeed'    : {
                    require_once (APPDIR .'modules/Hosting/litespeedlicensehandle/'
                        .'user/class.litespeedlicensehandle_controller.php');
                    $result     = litespeedlicensehandle_controller::singleton()->changeip(array(
                        'accountId'     => $accountId,
                        'oldIp'         => $oldIp,
                        'ip'            => $ip,
                        ));
                    break;
                }
        }

        $result         = is_array($result) ? (object) $result : $result;

        if ($result->success) {

            $db->query("
                UPDATE
                    hb_config2accounts
                SET
                    data = :ip
                WHERE
                    rel_type = 'Hosting'
                    AND account_id = :accountId
                    AND config_id = :configId
                ", array(
                    ':ip'           => $ip,
                    ':accountId'    => $accountId,
                    ':configId'     => $aData['config_id']
                ));

            $aLog       = array('serialized' => '1', 'data' => array(
                '0'     => array('name' => 'IP', 'from' => $oldIp, 'to' => $ip)
                ));
            $db->query("
                INSERT INTO hb_account_logs (
                    id, date, account_id, admin_login, module, manual, action,
                    `change`, result, error, event
                ) VALUES (
                    '', NOW(), :accountId, :admin, 'softaculouslicensehandle', '0', 'Change IP',
                    :logs, '1', :result, 'ChangeIP'
                )
                ", array(
                    ':accountId'        => $accountId,
                    ':admin'            => '-',
                    ':logs'             => serialize($aLog),
                    ':result'           => (isset($result->rawdata) ? $result->rawdata : ' ')
                ));

            $db->query("
                INSERT INTO hb_license_logs (
                    id, account_id, date, event, detail, rel
                ) VALUES (
                    '', :accountId, :date, 'Change IP', :detail, :rel
                )
                ", array(
                    ':accountId'    => $accountId,
                    ':date'         => date('Y-m-d H:i:s'),
                    ':detail'       => $oldIp .' to '. $ip,
                    ':rel'          => __FILE__
                ));

        }

        if ($result->success) {
            $result->success    = 'TRUE';
        } else {
            $result->success    = 'FALSE';
        }

        echo '<!-- {"ERROR":[]'
            . ',"RESULT":["'. strtoupper($result->success) .'"]'
            . ',"TRUE":["'. ($result->success == 'TRUE' ? $result->message : '') .'"]'
            . ',"FALSE":["'. ($result->success == 'FALSE' ? $result->message : '') .'"]'
            . ',"STACK":0} -->';
        exit;
    }

    public function listHistory ($request)
    {
        $db             = hbm_db();

        $page           = isset($request['page']) ? $request['page']: 1;
        $accountId      = isset($request['accountId']) ? $request['accountId']: 0;
        $limit          = 10;
        $offset         = ($page - 1) * $limit;

        self::_appendLicenseHistory($accountId);

        $result         = $db->query("
                SELECT
                    COUNT(ll.id) AS total
                FROM
                    hb_license_logs ll
                WHERE
                    ll.account_id = :accountId
                GROUP BY 
                    ll.date, ll.event
                    ", array(
                        ':accountId'    => $accountId
                ))->fetch();

        $total          = isset($result['total']) ? $result['total'] : 0;

        $aLicenses      = array(
            'total'     => $total,
            'pages'     => ceil($total/$limit),
            'lists'     => array()
        );

        $result         = $db->query("
                SELECT
                    ll.*
                FROM
                    hb_license_logs ll
                WHERE
                    ll.account_id = :accountId
                GROUP BY 
                    ll.date, ll.event
                ORDER BY
                    ll.date DESC
                LIMIT {$offset}, {$limit}
                ", array(
                    ':accountId'    => $accountId
                ))->fetchAll();

        $aLicenses['lists'] = count($result) ? $result : array();

        return $aLicenses;
    }

    private function _appendLicenseHistory ($accountId)
    {
        $db             = hbm_db();

        $result         = $db->query("
                SELECT
                    ll.*
                FROM
                    hb_license_logs ll
                WHERE
                    ll.account_id = :accountId
                ORDER BY ll.date DESC
                ", array(
                    ':accountId'    => $accountId
                ))->fetch();

        $update         = isset($result['date']) ? $result['date'] : 0;

        $result         = $db->query("
                SELECT
                    al.*
                FROM
                    hb_account_logs al
                WHERE
                    al.account_id = :accountId
                    AND al.result = 1
                    ". ($update ? " AND al.date > '{$update}' " : "") ."
                ORDER BY
                    al.date ASC
                ", array(
                    ':accountId'    => $accountId
                ))->fetchAll();

        if (count($result)) {
            $aEvent     = array('AccountCreate', 'AccountRenew', 'AccountTerminate');

            foreach ($result as $arr) {
                if (! in_array($arr['event'], $aEvent)) {
                    continue;
                }

                $aChange            = unserialize($arr['change']);

                $db->query("
                    INSERT INTO hb_license_logs (
                        id, account_id, date, event, detail, rel
                    ) VALUES (
                        '', :accountId, :date, :event, :detail, :rel
                    )
                    ", array(
                        ':accountId'    => $accountId,
                        ':date'         => $arr['date'],
                        ':event'        => $arr['action'],
                        ':detail'       => $aChange['data'] .' ',
                        ':rel'          => 'hb_account_logs.id = '. $arr['id']
                    ));

            }
        }

        $currentTime    = $update ? strtotime($update) : 0;

        $result         = $db->query("
                SELECT
                    tl.*
                FROM
                    hb_transfer_log tl
                WHERE
                    tl.acc_id = :accountId
                    AND tl.create_date > :time
                ORDER BY
                    tl.create_date ASC
                ", array(
                    ':accountId'    => $accountId,
                    ':time'         => $currentTime,
                ))->fetchAll();

        if (count($result)) {

            foreach ($result as $arr) {

                $db->query("
                    INSERT INTO hb_license_logs (
                        id, account_id, date, event, detail, rel
                    ) VALUES (
                        '', :accountId, :date, 'Change IP', :detail, :rel
                    )
                    ", array(
                        ':accountId'    => $accountId,
                        ':date'         => date('Y-m-d H:i:s', $arr['create_date']),
                        ':detail'       => $arr['from_ip'] .' to '. $arr['to_ip'],
                        ':rel'          => 'hb_transfer_log.t_id = '. $arr['t_id']
                    ));

            }

        }

    }

    public function ip_is_private ($ip) {
	    $pri_addrs = array (
	                      '10.0.0.0|10.255.255.255', // single class A network
	                      '172.16.0.0|172.31.255.255', // 16 contiguous class B network
	                      '192.168.0.0|192.168.255.255', // 256 contiguous class C network
	                      '169.254.0.0|169.254.255.255', // Link-local address also refered to as Automatic Private IP Addressing
	                      '127.0.0.0|127.255.255.255' // localhost
	                     );

	    $long_ip = ip2long ($ip);
	    if ($long_ip != -1) {

	        foreach ($pri_addrs AS $pri_addr) {
	            list ($start, $end) = explode('|', $pri_addr);

	             // IF IS PRIVATE
	             if ($long_ip >= ip2long ($start) && $long_ip <= ip2long ($end)) {
	                 return true;
	             }
	        }
	    }

	    return false;
	}

    public function preorder ($request)
    {
        $_SESSION['Stack']['ip']        = isset($request['ip']) ? $request['ip'] : '';

        echo '<!-- {"ERROR":[]'
            . ',"STACK":0} -->';
        exit;
    }

    private function _beforeRender ()
    {
        $this->template->assign('tplPath', dirname(dirname(__FILE__)) . '/templates/');
        $this->template->assign('tplClientPath', MAINDIR . 'templates/');
    }

    public function afterCall ($request)
    {

    }
}