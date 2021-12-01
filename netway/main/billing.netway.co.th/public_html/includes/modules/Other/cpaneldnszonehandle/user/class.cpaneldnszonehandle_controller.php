<?php

use GuzzleHttp\json_decode;

class cpaneldnszonehandle_controller extends HBController {
    
    public function beforeCall ($request)
    {
        
    }
    
    public function _default ($request)
    {
        $db     = hbm_db();
        /*$this->loader->component('template/apiresponse', 'json');
        $this->json->assign("aResponse", array(
        		'data' 	=> '',
        		'msg'	=> ''
        ));
        $this->json->show();*/
    }
    
    public function addzonerecord($request)
    {
    	$error		=	0;
    	$msg		=	'';
    	$allowType	=	array('CAA');
    	$recordType	=	isset($request['type']) ? $request['type'] : ''; 
    	$domain		=	isset($request['dom']) ? $request['dom'] : '';
    	$name		=	isset($request['name']) ? $request['name'] : '';
    	$class		=	'IN';
    	$ttl		=	isset($request['ttl']) ? $request['ttl'] : 14400;
    	$myDomain	=	$this->mydomain(array(
    						'domain'		=>	$domain
    					));
    	
    	if(!$myDomain){
    		$error	=	1;
    		$msg	=	'Something Wrong Please contact staff.';
    	}else{
    		if(!in_array($recordType, $allowType)){
    			$error	=	1;
    			$msg	=	'Record Type Incorrect.';
    		}else{
    			switch ($recordType){
    				case 'CAA':
    					$recordField	=	array('flag','tag','value');
    					$addQuery		=	$this->customQuery($request, $recordField);
    					break;
    			}
    			$query		=	'/addzonerecord?api.version=1&domain=' . $domain;
    			$query		.=	'&name=' . $name;
    			$query		.=	'&class=' . $class;
    			$query		.=	'&ttl=' . $ttl;
    			$query		.=	'&type=' . $recordType;
    			$query		.=	$addQuery;
    			
    			$aResponse	=	$this->_whmapi($query);
    			
    			if($aResponse->metadata->result == 1){
    				$msg		=	'Add DNS Record success.';	
    			}else{
    				$error		=	1;
    				$msg		=	utf8_decode($aResponse->metadata->reason);
    			}    			   			
    		}
    	}
    	
    	$this->loader->component('template/apiresponse', 'json');
    	$this->json->assign("aResponse", array(
    			'error'	=> $error,
    			'data' 	=> $aResponse,
    			'msg'	=> $msg
    	));
    	$this->json->show();
    }
    
    public function editzonerecord($request)
    {
    	$error		=	0;
    	$msg		=	'';
    	$allowType	=	array('CAA');
    	$recordType	=	isset($request['type']) ? $request['type'] : '';
    	$domain		=	isset($request['dom']) ? $request['dom'] : '';
    	$name		=	isset($request['name']) ? $request['name'] : '';
    	$line		=	isset($request['line']) ? $request['line'] : '';
    	$class		=	'IN';
    	$ttl		=	isset($request['ttl']) ? $request['ttl'] : 14400;
    	$myDomain	=	$this->mydomain(array(
    			'domain'		=>	$domain
    	));
    	 
    	if(!$myDomain){
    		$error	=	1;
    		$msg	=	'Something Wrong Please contact staff.';
    	}else{
    		if(!in_array($recordType, $allowType)){
    			$error	=	1;
    			$msg	=	'Record Type Incorrect.';
    		}else{
    			switch ($recordType){
    				case 'CAA':
    					$recordField	=	array('flag','tag','value');
    					$addQuery		=	$this->customQuery($request, $recordField);
    					break;
    			}
    			$query		=	'/editzonerecord?api.version=1&domain=' . $domain;
    			$query		.=	'&name=' . $name;
    			$query		.=	'&class=' . $class;
    			$query		.=	'&ttl=' . $ttl;
    			$query		.=	'&type=' . $recordType;
    			$query		.=  '&line='	. $line;
    			$query		.=	$addQuery;
    			 
    			$aResponse	=	$this->_whmapi($query);
    			 
    			if($aResponse->metadata->result == 1){
    				$msg		=	'Edit DNS Record success.';
    			}else{
    				$error		=	1;
    				$msg		=	utf8_decode($aResponse->metadata->reason);
    			}
    		}
    	}
    	 
    	$this->loader->component('template/apiresponse', 'json');
    	$this->json->assign("aResponse", array(
    			'error'	=> $error,
    			'data' 	=> $aResponse,
    			'msg'	=> $msg
    	));
    	$this->json->show();
    }
    
    public function dumpzone($request){
    	
    	$domain		=	$request['domain'];
    	$error		=	0;
    	$msg		=	'';
    	$query		=	'/dumpzone?api.version=1&domain=' . $domain;
    	$aResponse	=	$this->_whmapi($query);
    	 
    	if($aResponse->metadata->result == 1){
    		$msg		=	'Success';
    	}else{
    		$error		=	1;
    		$msg		=	utf8_decode($aResponse->metadata->reason);
    	}
    	 
    	$this->loader->component('template/apiresponse', 'json');
    	$this->json->assign("aResponse", array(
    			'error'	=> $error,
    			'data' 	=> $aResponse,
    			'msg'	=> $msg
    	));
    	$this->json->show();
    	
    }
    
    public function deletezonerecord($request){
    	
    	$zone		=	$request['zone'];
    	$line		=	$request['line'];
    	$error		=	0;
    	$msg		=	'';
    	$query		=	'/removezonerecord?api.version=1&zone=' . $zone . '&line=' . $line;
    	$aResponse	=	$this->_whmapi($query);
    	
    	if($aResponse->metadata->result == 1){
    		$msg		=	'Success';
    	}else{
    		$error		=	1;
    		$msg		=	utf8_decode($aResponse->metadata->reason);
    	}
    	
    	$this->loader->component('template/apiresponse', 'json');
    	$this->json->assign("aResponse", array(
    			'error'	=> $error,
    			'data' 	=> $aResponse,
    			'msg'	=> $msg
    	));
    	$this->json->show();
    	
    }
    
    private function customQuery(array $request , array $recordField){
    	$customQuery	=	'';
    	foreach($recordField as $field){
    		$customQuery	.=	'&' . $field . '=' . $request[$field];
    	}
    	return	$customQuery;
    }
    
    private function mydomain($request)
    {
    	$db     	=	hbm_db();
    	$client     = 	hbm_logged_client();
    	$aClient    = 	isset($client['id']) ? $client : array();
    	$result		=	$db->query("
    							SELECT
    								id , name
    							FROM
    								hb_domains
    							WHERE
    								client_id	=	:clientId
    								AND name	=	:domain
    						",array(
    							':clientId'		=>	$aClient['id'] ,
    							':domain'		=>	$request['domain']
    						))->fetchAll();
    	return count($result);
    }
    
    private function _whmapi ($query)
    {
        $db         = hbm_db();
        
        $result     = $db->query("
            SELECT
                mc.config
            FROM
                hb_modules_configuration mc
            WHERE
                mc.module = 'cpaneldnszonehandle'
            ")->fetch();
        
        $aConfig    = isset($result['config']) ? unserialize($result['config']) : array();
        
        $ipPark     = isset($aConfig['IP Park']['value']) ? $aConfig['IP Park']['value'] : '';
        $dnsServer  = isset($aConfig['DNS Server3 IP']['value']) ? $aConfig['DNS Server3 IP']['value'] : '';
        $dnsUser    = isset($aConfig['DNS Server3 WHM Username']['value']) 
                        ? $aConfig['DNS Server3 WHM Username']['value'] : '';
        $dnsHash    = isset($aConfig['DNS Server3 WHM Hash']['value']) 
                        ? $aConfig['DNS Server3 WHM Hash']['value'] : '';
        
        $query      = 'https://'. $dnsServer .':2087/json-api'. $query;
        
        $curl       = curl_init();
        curl_setopt($curl, CURLOPT_SSL_VERIFYHOST, 0);
        curl_setopt($curl, CURLOPT_SSL_VERIFYPEER, 0);
        curl_setopt($curl, CURLOPT_RETURNTRANSFER, 1);
        $header[0]  = 'Authorization: WHM '. $dnsUser .':' . preg_replace('/(\r|\n)/', '', $dnsHash);
        curl_setopt($curl, CURLOPT_HTTPHEADER, $header);
        curl_setopt($curl, CURLOPT_URL, $query);
        $result     = curl_exec($curl);
        curl_close($curl);
        
        $oResult    = json_decode($result);
        
        return $oResult;
    }

    public function afterCall ($request)
    {
        
    }
}