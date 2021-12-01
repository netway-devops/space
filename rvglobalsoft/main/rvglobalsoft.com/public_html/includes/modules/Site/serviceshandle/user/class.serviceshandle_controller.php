<?php

/**
 * 
 * Hostbill Common
 * 
 * Verify Order
 * 
 * @author Puttipong Pengprakhon<puttipong@rvglobalsoft.com>
 */

class serviceshandle_controller extends HBController {

	/**
	 * 
	 * Enter description here ...
	 * @param $request
	 * @author Puttipong Pengprakhon<puttipong@rvglobalsoft.com>
	 */
	public function verifyDomain($request) {
		
		$aRes = array();
	    $hostname  = isset($request['hostname']) ? $request['hostname'] : null;
        
	    if (isset($hostname)) {
	    	
	    	$db = hbm_db();
            $query = sprintf("   
                        SELECT 
                            i.domain
                        FROM 
                            %s i
                        WHERE
                            i.domain='%s'                  
                        "
                        , "hb_accounts"
                        , $hostname
            );  
            $aRes = $db->query($query)->fetchAll();
            
	    }
        
	    if (isset($aRes["0"]["domain"])) {
	    	
	    	$error = $aRes["0"]["domain"];
	    	$response .= <<<EOF
        {"ERROR":["$error already exists."], "INFO":[], "STACK":0}
EOF;

	    } else {
	    	
	    	$response .= <<<EOF
        {"ERROR":[], "INFO":[], "STACK":0}
EOF;

	    }

        echo $response;
        exit;
        
	}
        
}