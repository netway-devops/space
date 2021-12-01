<?php
require_once APPDIR . "class.general.custom.php";
class ssl_controller extends HBController {

    function _default($request) {

    }

    public static function &singleton($autoload=false) {
        static $instance;
        // If the instance is not there, create one
        if (!isset($instance) || $autoload) {
            $class = __CLASS__;
            $instance = new $class();
        }
        return $instance;
    }

    public function get_list_by_price(){
        require_once HBFDIR_LIBS . 'RvLibs/RvGlobalSoftApi.php';
        $oSSL =& RvLibs_RvGlobalSoftApi::singleton();
        $aSSLbyprice = $oSSL->request('get', 'ssl_productlistbyprice');
        $this->loader->component('template/apiresponse', 'json');
        $this->json->assign('productList', $aSSLbyprice);
        $this->json->show();
    }

    public function get_list_by_property(){
    	require_once HBFDIR_LIBS . 'RvLibs/RvGlobalSoftApi.php';
    	$oSSL =& RvLibs_RvGlobalSoftApi::singleton();
    	$aSSLbyproperty = $oSSL->request('get', 'ssl_productlistbyproperty');
    	$this->loader->component('template/apiresponse', 'json');
    	$this->json->assign('productList', $aSSLbyproperty);
    	$this->json->show();

    }

    public function uploadDocument(){
    	if($_SERVER['HTTP_USER_AGENT'] == 'RVGlobalsoft API 1.3.1' && $_SERVER['HTTP_REFERER'] == 'http://api.rvglobalsoft.com'){
    		$fileDir = '/home/rvglobal/public_html/uploads/ssl/documents/';
    		foreach($_FILES as $k => $v){
    			move_uploaded_file($v["tmp_name"], $fileDir . $k . '/' . $v['name']);
    		}
    	}
    }

    public function rvsslDecodeCsr($request){
        require_once(HBFDIR_LIBS . 'RvLibs/SSL/PHPLibs.php');
        $oAuth =& RvLibs_SSL_PHPLibs::singleton();
        $firstStep = $oAuth->ParseCSRforDecoder($request['csrData']);
        if($firstStep['status']['parseStatus']){
        	$commonName = $firstStep['CN'];
        	if(substr($commonName, 0, 2) == '*.'){
		        $csrDecodeData = $oAuth->ParseCSRByValidateOrderParametersforDecoder($request['csrData'], 20);
        	} else {
        		$csrDecodeData = $oAuth->ParseCSRByValidateOrderParametersforDecoder($request['csrData']);
        	}
        } else {
        	$csrDecodeData = $oAuth->ParseCSRByValidateOrderParametersforDecoder($request['csrData']);
        }

        $this->loader->component('template/apiresponse', 'json');
        $this->json->assign('csrData', $csrDecodeData);
        $this->json->show();
    }

    public function verify_login($request)
    {
    	$api = new ApiWrapper();
    	$login = $request["login"];

    	$params = array(
    		'email' => $login['user']
    		, 'password' => $login['pass']
    	);

    	$check_login = $api->verifyClientLogin($params);
    	if($check_login["success"]){
    		$client_detail = $this->get_client_detail($check_login["client_id"]);
    		$check_login["firstname"] = $client_detail["firstname"];
    		$check_login["lastname"] = $client_detail["lastname"];
    	}

    	$this->loader->component('template/apiresponse', 'json');
        $this->json->assign('login', $check_login);
        $this->json->show();
    }

    public function register_account($request)
    {
    	$api = new ApiWrapper();
    	$params = $request["reg"];

    	$clientCreate = $api->addClient($params);

    	if($clientCreate["success"]){
    		$client_detail = $this->get_client_detail($clientCreate["client_id"]);
    		$clientCreate["firstname"] = $client_detail["firstname"];
    		$clientCreate["lastname"] = $client_detail["lastname"];
    		$clientCreate["email"] = $client_detail["email"];
    		$clientCreate["companyname"] = $client_detail["companyname"];
    		$clientCreate["phonenumber"] = $client_detail["phonenumber"];
    	}

    	$this->loader->component('template/apiresponse', 'json');
    	$this->json->assign('reg', $clientCreate);
    	$this->json->show();
    }

    private function get_client_detail($client_id)
    {
    	$api = new ApiWrapper();
    	$client_detail = $api->getClientDetails(array("id" => $client_id));
    	$c = $client_detail["client"];
    	$client = array(
    		"firstname" => $c["firstname"]
    		, "lastname" => $c["lastname"]
    		, "email" => $c["email"]
    		, "companyname" => $c["companyname"]
    		, "phonenumber" => $c["phonenumber"]
    	);
    	return $client;
    }
    
    
    public function ChangeEmailApproval($request)
    {
        $db     = hbm_db();
        $aResponse = array();
        
        $orderId    = isset($request['order_id']) ? $request['order_id'] : 0;
        $email      = isset($request['email']) ? $request['email'] : '';
        
        $result     = $db->query("
            SELECT authority_orderid, partner_order_id
            FROM hb_ssl_order
            WHERE order_id = '{$orderId}'
            ")->fetch();
        if($result['authority_orderid'] != ''){
            
            require_once HBFDIR_LIBS . 'RvLibs/SSL/PHPLibs.php';
            $oAuth      =& RvLibs_SSL_PHPLibs::singleton();
            
            $c_result    = $oAuth->changeApproverEmail($email, $result['partner_order_id']);
            
                if(!empty($c_result)){
                    $db->query("
                            UPDATE hb_ssl_order
                            SET email_approval = :email
                            WHERE order_id = :order_id
                            ",array(
                                ':email'        => $email,
                                ':order_id'     => $orderId
                            ));
        
                        $aResponse  = array(
                            'status' => 'success',
                            'message' => "Email Approval has been updated already.",
                        );
                }else{
                 $aResponse = 'Cannot change approver email for this order!!';
                }   
        }
        
        $this->loader->component('template/apiresponse', 'json');
        $this->json->assign("aResponse", $aResponse);
        $this->json->show();
        }   
    }

