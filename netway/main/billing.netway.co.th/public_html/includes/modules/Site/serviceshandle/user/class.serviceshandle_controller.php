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
        
        if($hostname == null){
            
        echo '{"ERROR":["Domain name can\'t blank."], "INFO":[], "STACK":0}';
        exit;
        
        }
        
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

	    } else if( ! preg_match("/^(?!\-)(?:[a-zA-Z\d\-]{0,62}[a-zA-Z\d]\.){2,126}(?!\d+)[a-zA-Z\d]{1,63}$/", $hostname ) || $hostname == null){
	    	
	    	$response .= <<<EOF
        {"ERROR":["Domain name has an invalid format: Please specify a valid Domain Name"], "INFO":[], "STACK":0}
EOF;

	    }else{
            
            $response .= <<<EOF
        {"ERROR":[], "INFO":[], "STACK":0}
EOF;

        }

        echo $response;
        exit;
        
	}
	
	public function getCloudOsTemplateApiId ($request)
	{
		$db 			=	hbm_db();
		
		
		$virtualizorApiId		= isset($request['virtualizorApiId']) ? $request['virtualizorApiId'] : 0;
		$baseOS			=	$request['baseos'];
		$controlPanel	=	$request['controlPanel'];
		$database		=	$request['database'];
		$productId		=	$request['productId'];
		$productName	=	$request['productName'];

		$result			=	$db->query("
			SELECT
				*
			FROM
				hb_cloud_os_template
			WHERE
				( 
					os_name	=	:baseOS
					OR virtualizor_api_id = :virtualizor_api_id
				)
				AND control_panel	=	:controlPanel
				AND	`database`	=	:database
			ORDER BY id DESC
			", array(
				':baseOS'		=>	$baseOS ,
				':virtualizor_api_id'	=>	$virtualizorApiId ,
				':controlPanel'	=>	$controlPanel ,
				':database'		=>	$database
			))->fetchAll();
		
		if (count($result)) {
			if ($virtualizorApiId) {
				$result_ 	= $result;
				$result		= array();
				foreach ($result_ as $arr) {
					if ($arr['virtualizor_api_id'] == $virtualizorApiId) {
						$result	= $arr;
						break;
					}
				}
			} else {
				$result	= $result[0];
			}
		}

		$templateApiId = $result['virtualizor_api_id'];
		if($productName == 'vmware'){
			$templateApiId = $result['vmware_api_id'];
		}					
							
		$result			=	$db->query("
			SELECT
				ci.id , ci.variable_id
			FROM
				hb_config_items ci , hb_config_items_cat cic
			WHERE
				cic.product_id = :productId
				AND cic.variable = 'os'
				AND cic.name = 'OS Template'
				AND cic.id = ci.category_id
				AND ci.variable_id = :templateApiId
			", array(
				':productId'		=>	$productId ,
				':templateApiId'	=>	$templateApiId
			))->fetch();
							
		$this->loader->component('template/apiresponse', 'json');
        $this->json->assign('data', json_encode($result));
        $this->json->show();	
		
	}
        
}