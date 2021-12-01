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

    public function get_ssl_data($request)
    {
    	$db = hbm_db();

    	$authList = $this->get_auth_sort();
    	$auth = array('Symantec', 'Entrust', 'Thawte', 'GeoTrust', 'RapidSSL', 'DigiCert', 'Comodo', 'GoDaddy');
    	/*foreach($authList as $foo){
    		$auth[] = $foo["name"];
    	}*/

    	$valSort = $this->get_validation_sort();
    	$validation = array();
    	foreach($valSort as $foo){
    		$validation[] = $foo["name"];
    	}

    	$sql = "
    		SELECT
    			p.id
    			, p.name
    			, p.description
    			, a.name AS authority_name
    			, co.a
    			, co.b
    			, co.t
    			, v.name AS validation_name
    			, v.abbreviation AS validation_abbreviation
    			, d.*
    		FROM
    			hb_ssl AS s
    			, hb_products AS p
    			, hb_common AS co
    			, hb_ssl_validation AS v
    			, hb_ssl_authority AS a
				, hb_ssl_description AS d
				, hb_categories AS c
    		WHERE
    			s.pid = p.id
    			AND co.id = p.id
    			AND co.rel = 'Product'
    			AND p.visible = 1
    			AND v.id = s.validation_id
    			AND s.validation_id = v.id
    			AND s.authority_id = a.id
				AND d.ssl_id = s.id
				AND p.category_id =c.id
                AND c.id = 23  
    	";

    	if(isset($request["pid"])){
    		$sql .= " " . 'AND s.pid = ' . $request["pid"];
    	}

    	$sql .= "
    		ORDER BY
    			FIELD (a.name, '" . implode("', '", $auth) . "')
    			, FIELD (v.name, '" . implode("', '", $validation) . "')
    			, p.sort_order ASC
    	";

    	$productList = $db->query($sql)->fetchAll();

    	foreach($productList as $index => $foo){
            if(strstr($foo["name"],'(')){
        		  $pname = trim(substr($foo["name"], 0, strpos($foo["name"], "(")));
        		  
        		  $chkSAN = $db->query("
                    SELECT
                        co.a
                        , co.b
                        , co.t
                    FROM
                        hb_products AS p
                        , hb_common AS co
                    WHERE
                        p.name = '{$pname} (Additional Certificate)'
                        AND co.id = p.id
                ")->fetch();
            
            }else{
                $pname  = $foo["name"];
                $chkSAN = $db->query("
                    SELECT
                        co.a
                        , co.b
                        , co.t
                    FROM
                        hb_products AS p
                        , hb_common AS co
                    WHERE
                        p.name = '{$pname} (Additional Certificate)'
                        AND co.id = p.id
                ")->fetch();
            }
    		

    		$productList[$index]["name"] = preg_replace("/\s*\((DV|EV|OV)\)$/", "", $foo["name"]);

    		if($chkSAN){
    			$productList[$index]["san_a"] = $chkSAN["a"];
    			$productList[$index]["san_b"] = $chkSAN["b"];
    			$productList[$index]["san_t"] = $chkSAN["t"];
    		}
    	}

    	$this->loader->component('template/apiresponse', 'json');
        $this->json->assign('productList', $productList);
        $this->json->show();
    }

    private function get_auth_sort()
    {
    	$db = hbm_db();
    	return $db->query("SELECT * FROM hb_ssl_authority ORDER BY sort")->fetchAll();
    }

    private function get_validation_sort()
    {
    	$db = hbm_db();
    	return $db->query("SELECT * FROM hb_ssl_validation ORDER BY sort")->fetchAll();
    }


    public function logMessage($content)
    {
    	$logPath = '/home/apirvglo/rvglobalsoft/whmcs.log';
    	if(file_exists($logPath)){
    		$bt = debug_backtrace();
    		file_put_contents($logPath, "{$bt[1]["class"]}->{$bt[1]["function"]}:{$bt[0]["line"]}", FILE_APPEND);
    		if(is_array($content) || is_object($content)){
    			file_put_contents($logPath, "\n\n=========Array========\n\n", FILE_APPEND);
    			file_put_contents($logPath, print_r($content, 1), FILE_APPEND);
    			file_put_contents($logPath, "\n\n=======END-Array======\n\n", FILE_APPEND);
    		} else {
    			file_put_contents($logPath, "\n" . $content . "\n", FILE_APPEND);
    		}
    	}
    }
}
?>