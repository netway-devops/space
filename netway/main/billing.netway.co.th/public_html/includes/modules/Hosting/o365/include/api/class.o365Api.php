<?php

    class o365Api {
           
           /***************************** Sandbox *********************************/
           /*public $APP_ID	     			=	'9927a1be-da59-4df4-9476-2bdf1da70d1e';
		   public $ACCOUNT_ID	 			=	'88d53361-c344-442f-a891-a6c1568a04b1';
		   public $SECRET_KEY	 			=	'Tti06WALCXvwpQDk5YoBwOOpO1ggdtQG0LqcSVe8jKA=';
		   public $RESELLER_DOMAIN			=	'testnetwaymarketing.onmicrosoft.com';*/
           /***********************************************************************/
           
           /****************************** Real ***********************************/
           public $APP_ID	     			=	'adf2d551-aa39-4302-b2dd-786dc0c3fbb3';
		   public $ACCOUNT_ID	 			=	'ecf92b64-6863-4193-8daa-64d0e8d02998';
		   public $SECRET_KEY	 			=	'LqHYHjpOe5mhRge9qkGmoeHfjiqbnW5PGpdzMCXYb7w=';
		   public $RESELLER_DOMAIN			=	'netwaymarketing.in.th';
           /***********************************************************************/
           
           public function getAzureADsecuritytoken(){
           		
           		$VARS	=	"grant_type=client_credentials&resource=https://graph.windows.net&client_id=" . $this->APP_ID ."&client_secret=" . $this->SECRET_KEY;
	
				$ch = curl_init();
				curl_setopt($ch, CURLOPT_URL,'https://login.windows.net/' . $this->RESELLER_DOMAIN . '/oauth2/token?api-version=1.0');
				curl_setopt($ch, CURLOPT_POST, 1);
				curl_setopt($ch, CURLOPT_POSTFIELDS,$VARS);
				curl_setopt($ch, CURLOPT_RETURNTRANSFER, TRUE);
				
				$headers = array();
				$headers[] = 'HTTP/1.1';
				
				curl_setopt($ch, CURLOPT_HTTPHEADER, $headers);
				
				$server_output = curl_exec ($ch);
				
				curl_close ($ch);
				
				$server_output	=	json_decode($server_output);
				
				$ACCESS_TOKEN			=	$server_output->access_token;
				
				return	$ACCESS_TOKEN;
				
           }
           
		   public function getSAToken(){
		   	
				$ACCESS_TOKEN	=	self::getAzureADsecuritytoken();
				
				$VARS			=	"grant_type=client_credentials";
				
				$ch = curl_init();
				curl_setopt($ch, CURLOPT_URL,'https://api.cp.microsoft.com/my-org/tokens');
				curl_setopt($ch, CURLOPT_POST, 1);
				curl_setopt($ch, CURLOPT_POSTFIELDS,$VARS);
				curl_setopt($ch, CURLOPT_RETURNTRANSFER, TRUE);
				
				$headers = array();
				$headers[] = 'HTTP/1.1';
				$headers[] = 'Authorization: bearer ' . $ACCESS_TOKEN;
				$headers[] = 'Accept:application/x-www-form-urlencoded';
				
				curl_setopt($ch, CURLOPT_HTTPHEADER, $headers);
				
				$server_output = curl_exec ($ch);
				
				curl_close ($ch);
				
				$server_output	=	json_decode($server_output);
				
				$SA_TOKEN			=	$server_output->access_token;
				
				return	$SA_TOKEN;   	
		   }
		   
		   public function createCustomer($data){
		   
		        $SA_TOKEN	=	self::getSAToken();
			   	
			    $VARS		=	$data;
				
				$ch = curl_init();
				curl_setopt($ch, CURLOPT_URL,'https://api.cp.microsoft.com/' . $this->ACCOUNT_ID . '/customers/create-reseller-customer');
				curl_setopt($ch, CURLOPT_POST, 1);
				curl_setopt($ch, CURLOPT_POSTFIELDS,$VARS);
				curl_setopt($ch, CURLOPT_RETURNTRANSFER, TRUE);
				
				$headers = array();
				$headers[] = 'HTTP/1.1';
				$headers[] = 'Authorization: bearer ' . $SA_TOKEN;
				$headers[] = 'Content-Type:application/json';
				$headers[] = 'Accept:application/json';
				$headers[] = 'api-version:2015-03-31';
				$headers[] = 'x-ms-tracking-id:257002e4-8481-4f15-a8b1-649b927220a9';
				
				curl_setopt($ch, CURLOPT_HTTPHEADER, $headers);
				
				$server_output = curl_exec ($ch);
				
				curl_close ($ch);
				
				$server_output	=	json_decode($server_output);	
				
				return $server_output;
		       		
		   }
		   
		   public function addSubscription($data){
		   	
		   		$SA_TOKEN	=	self::getSAToken();
			   	
			    $VARS		=	$data;
				
				$ch = curl_init();
				curl_setopt($ch, CURLOPT_URL,'https://api.cp.microsoft.com/' . $this->ACCOUNT_ID . '/orders');
				curl_setopt($ch, CURLOPT_POST, 1);
				curl_setopt($ch, CURLOPT_POSTFIELDS,$VARS);
				curl_setopt($ch, CURLOPT_RETURNTRANSFER, TRUE);
				
				$headers = array();
				$headers[] = 'HTTP/1.1';
				$headers[] = 'Authorization: bearer ' . $SA_TOKEN;
				$headers[] = 'Content-Type:application/json';
				$headers[] = 'Accept:application/json';
				$headers[] = 'api-version:2015-03-31';
				
				curl_setopt($ch, CURLOPT_HTTPHEADER, $headers);
				
				$server_output = curl_exec ($ch);
				
				curl_close ($ch);
				
				$server_output	=	json_decode($server_output);	
				
				return $server_output;	
			
		   } 
		   
		   public function getSubscription($data){
		   
		   		$SA_TOKEN	=	self::getSAToken();
			   	
			    $VARS		=	$data;
				
				$ch = curl_init();
				curl_setopt($ch, CURLOPT_URL,'https://api.cp.microsoft.com' . $VARS);
				curl_setopt($ch, CURLOPT_RETURNTRANSFER, TRUE);
				
				$headers = array();
				$headers[] = 'HTTP/1.1';
				$headers[] = 'Authorization: bearer ' . $SA_TOKEN;
				$headers[] = 'Accept:application/json';
				$headers[] = 'api-version:2015-03-31';
				
				curl_setopt($ch, CURLOPT_HTTPHEADER, $headers);
				
				$server_output = curl_exec ($ch);
				
				curl_close ($ch);
				
				$server_output	=	json_decode($server_output);	
				
				return $server_output;	
		   	
		   }

		   public function setQuantity($data){
		   	
		   		$SA_TOKEN	=	self::getSAToken();
			   	
			    $VARS		=	$data;
				$aJson		=	array(
										'line_items'	=>	array(
																	array(
																			'line_item_number'			=>	0,
																			'offer_uri'					=>	$VARS['offerUri'],
																			'quantity'					=>	$VARS['quantity'],
																			'reference_entitlement_uris'=>	array($VARS['entitlement'])
																		)
																)
									);
				$json		=	json_encode($aJson);
				
				$ch = curl_init();
				curl_setopt($ch, CURLOPT_URL,'https://api.cp.microsoft.com' . $VARS['orderUri']);
				curl_setopt($ch, CURLOPT_RETURNTRANSFER, TRUE);
				curl_setopt($ch, CURLOPT_CUSTOMREQUEST, 'PATCH');
				curl_setopt($ch, CURLOPT_POST, true);
				curl_setopt($ch, CURLOPT_POSTFIELDS,$json);
				
				
				$headers = array();
				$headers[] = 'HTTP/1.1';
				$headers[] = 'Authorization: bearer ' . $SA_TOKEN;
				$headers[] = 'Content-Type:application/json';
				$headers[] = 'Accept:application/json';
				$headers[] = 'api-version:2015-03-31';
				//$headers[] = 'If-Match:' . $VARS['etag'];
				
				curl_setopt($ch, CURLOPT_HTTPHEADER, $headers);
				
				$server_output = curl_exec ($ch);
				
				$info = curl_getinfo($ch);
								
				curl_close ($ch);
				
				$server_output	=	json_decode($server_output);	
				
				return $server_output;		
			
		   }
    
    }  

?>