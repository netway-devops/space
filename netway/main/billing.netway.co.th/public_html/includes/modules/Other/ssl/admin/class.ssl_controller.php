<?php

class ssl_controller extends HBController {

    private static  $instance;

    private $c_errorMsg = '<!-- {"ERROR":["ไม่สามารถสร้างข้อมูลของ product นี้ได้"],"INFO":[],"STACK":0} -->';
    private $c_successMsg = '<!-- {"ERROR":[],"INFO":["สร้างข้อมูลของ product เรียบร้อย"],"STACK":0} -->';
    private $r_errorMsg = '<!-- {"ERROR":["ไม่สามารถลบข้อมูลของ product ได้"],"INFO":[],"STACK":0} -->';
    private $r_successMsg = '<!-- {"ERROR":[],"INFO":["ลบข้อมูลเรียบร้อยแล้ว"],"STACK":0} -->';

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

    public function createSSLInfo($request)
    {
    	$db = hbm_db();

    	echo ($db->query("
    		INSERT INTO
    			hb_ssl
    				( pid, validation_id, authority_id )
    			VALUES
    				( {$request["pid"]}, 1, 1 );
    		INSERT INTO
    			hb_ssl_description
    				( ssl_id )
    		SELECT
    			id AS ssl_id
    		FROM
    			hb_ssl
    		WHERE
    			pid = {$request["pid"]};
    	"))
    	? $this->c_successMsg
    	: $this->c_errorMsg;

    	exit;
    }

    public function removeSSLInfO($request)
    {
    	$db = hbm_db();

    	echo ($db->query("
    			DELETE FROM `hb_ssl` WHERE id = {$request["ssl_id"]};
    			DELETE FROM `hb_ssl_description` WHERE ssl_id = {$request["ssl_id"]};
    	"))
    	? $this->r_successMsg
    	: $this->r_errorMsg;

    	exit;
    }

    public function updateSSLInfo($request)
    {
    	$db = hbm_db();
    	$ssl_id = $request["sslId"];
    	$data = array();
    	parse_str($request["data"], $data);

    	$data = $data["pssl"];

    	if(!$data["support_for_san"]){
    		$data["san_startup_domains"] = 0;
    		$data["san_max_domains"] = 0;
    		$data["san_max_servers"] = 0;
    	}

    	$db->query("
    		UPDATE
    			`hb_ssl`
    		SET
    			`validation_id` = {$data["validation_id"]}
    			, `authority_id` = {$data["authority_id"]}
    		WHERE
    			`id` = {$ssl_id}
    	");


    	$db->query("
    		UPDATE
    			hb_ssl_description
    		SET
    			warranty = :warranty
    			, issuance_time = :issuance_time
    			, reissue = {$data["reissue"]}
    			, green_addressbar = {$data["green_addressbar"]}
    			, secure_subdomain = {$data["secure_subdomain"]}
    			, licensing_multi_server = {$data["licensing_multi_server"]}
    			, malware_scan = {$data["malware_scan"]}
    			, secureswww = {$data["secureswww"]}
    			, support_for_san = {$data["support_for_san"]}
    			, san_startup_domains = {$data["san_startup_domains"]}
    			, san_max_domains = {$data["san_max_domains"]}
    			, san_max_servers = {$data["san_max_servers"]}
    		WHERE
    			ssl_id = {$ssl_id}
    	", array(
    		":warranty" => $data["warranty"]
    		, ":issuance_time" => $data["issuance_time"]
    	));
    }
}