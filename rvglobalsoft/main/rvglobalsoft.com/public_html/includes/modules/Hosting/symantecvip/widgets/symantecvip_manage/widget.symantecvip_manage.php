<?php

/**
 * 
 * Widget Symantec VIP Manage
 * 
 * http://schlitt.info/opensource/blog/0581_reflecting_private_properties.html
 * 
 */


/* SESSION
stdClass Object
(
    [rold] => store
    [uid] => reseller
    [username] => reseller
    [HBInit] => 1
    [AppSettings] => stdClass Object
        (
            [remote] => 
            [language] => english
            [ctime] => 13705260112147483646
            [default_salt] => c0dfd92f03727ba77c3be87470989ac2
            [user_language] => english
            [UserTemplate] => netwaybysidepad
            [login] => stdClass Object
                (
                    [id] => 3
                    [server_time] => 1370525249
                    [companyname] => RV Globalsoft Co.,Ltd.
                    [lastname] => Wongnonglaeng
                    [firstname] => Isara (Dev)
                    [email] => isara@rvglobalsoft.com
                    [country] => TH
                    [state] => Bangkok
                    [city] => Bangsue
                    [address1] => 111
                    [address2] => 444
                    [postcode] => 10800
                    [phonenumber] => 66859359366
                    [datecreated] => 2013-05-29
                    [currency_id] => 0
                    [credit] => 0.00
                    [lasthost] => puttipong.local
                    [last] => 2013-05-31 15:17:06
                    [language] => english
                    [status] => 1
                    [s_id] => fgqp681d25jt819h318dlf4281
                    [salt] => a954e3c67ca85b05ceff62a5f3929313
                    [HTTP_USER_AGENT] => a5cd038ef63b6b7f4ecf0708fa2ebe8b
                )

            [userCurrency] => 0
            [cartCurrency] => 0
        )

    [oauth_token] => stdClass Object
        (
            [reseller] => 44d282aa105dc9edd73f69d20c1c3a1f237f1341
        )

)
*/
require_once HBFDIR_LIBS . 'RvLibs/RvGlobalSoftApi.php';
include_once(APPDIR_MODULES . "Hosting/symantecvip/include/api/class.symantecvip.dao.php");

class widget_symantecvip_manage extends HostingWidget {

    protected $description = 'This is description of widget that will be displayed in adminarea';
    protected $widgetfullname = "Account & Server Management";

    /**
     * HostBill will call this function when widget is visited from clientarea
     * @param HostingModule $module Your provisioning module object
     * @return array
     */
    public function clientFunction(&$module) {
    	
    	$reflectionObject = new ReflectionObject($module);
        $property = $reflectionObject->getProperty('account_details');
        $property->setAccessible(true);
        $aAccountDetails = $property->getValue($module); 
    	
        $accountId = (isset($aAccountDetails["id"])) ? $aAccountDetails["id"] : null;
        $serverId = (isset($aAccountDetails["server_id"])) ? $aAccountDetails["server_id"] : null;
        $clientId = (isset($aAccountDetails["client_id"])) ? $aAccountDetails["client_id"] : null;
        
        $db = hbm_db();
        $usrId = $_SESSION['AppSettings']['login']['id'];
        
        $query = "
			        SELECT
			        	ac.status AS status
			        FROM
			        	hb_vip_info AS vi
			        	, hb_accounts AS ac
			        	, hb_products AS p
			        WHERE
			        	vi.usr_id = {$usrId}
			        	AND vi.account_id = ac.id
			        	AND ac.product_id = p.id
		        ";
        $result = $db->query($query)->fetchAll();
        
      
        $oAuth =& RvLibs_RvGlobalSoftApi::singleton();
        
        // Validate Update Account Upgrade/Downgrade
        
       
        $vipQty = SymantecvipDao::singleton()->getSymantecVipAccount($accountId);
             
        if(isset($vipQty) && $vipQty != '') {

        	$rvapi1 = $oAuth->request('get', '/vipuserinfo', array( 'action_do' => 'listacct' ));
        	 
        	$userinfo1 = (array)$rvapi1;


        	if ($vipQty!=$userinfo1["quantity"]) {
        		// update quantity_at_symantec = '$vipQty'
        			
        		$rvapi1 = $oAuth->request('post', '/vipuserinfo', array( 'action_do' => 'sync_quantity' ,
																			'update_qty' => $vipQty ,
																			'account_id' => $accountId
        		));
        		 
        	}

        }
        
	
		
		/*
		if(!isset($userinfo['can_view'])) { $userinfo['can_view'] = ""; }
	
		if ($userinfo['can_view'] == 1) {
			
			$output->quantity = $userinfo['quantity'];
			$output->quantity_used = $userinfo['quantity_used'];
			
			$output->can_add_acct = 'no';
			
			if ($output->quantity > $output->quantity_used) {
				$output->can_add_acct = 'yes';
			}
			
			$output->acctlist = $userinfo['acctlist'];
			
			
			
			if ($input->action_do == 'validate_cred') {
				$vip_acct_api = $this->oAuth->request('get', '/vipuserinfo', 
															array( 'action_do' => 'get_vip_acct_name' ,
																   'vip_acct_id' => $input->vip_acct_id ,
																 )
													 );
				$acct_info = (array)$vip_acct_api;
				$output->vip_acct_name = $acct_info['vip_acct_name'];
				
				// vip_cred_id
				$vip_cred_api = $this->oAuth->request('get', '/vipuserinfo', 
															array( 'action_do' => 'get_vip_cred_id' ,
																   'vip_acct_id' => $input->vip_acct_id ,
															       'vip_cred' => $input->vip_cred ,
																 )
													 );
				$cred_info = (array)$vip_cred_api;
				$output->vip_cred_id = $cred_info['vip_cred_id'];
			} elseif ($input->action_do == 'addcred_after_addacct') {
				//$output->vip_acct_id = $input->vip_acct_id;
			}
        
		} else {
			$output->template = "vip_manager_no_data.html";
		}
		*/
		
		
		
		
		$rvapi = $oAuth->request('get', '/vipuserinfo', array( 'action_do' => 'listacct' ));
    	//print_r($rvapi);
		$userinfo = (array)$rvapi;
		
		$acctlist = $userinfo['acctlist'];
	
                
    	return array(
    	                       "symantecvip_manage.tpl", 
    	                       array(
    	                           'accountId' => $accountId, 
    	                           'serverId' => $serverId,
								   'quantity_used' =>  $userinfo["quantity_used"] ,
								   'quantity' => $userinfo["quantity"] ,
    	                       	   'u_email' => $userinfo['u_email'] ,
    	                           'vip_user_prefix' => $userinfo['vip_user_prefix'] ,
    	                       	   'userinfo' => $userinfo['acctlist'],
    	                       		'2factorStatus' => (isset($result[0]['status'])) ? $result[0]['status'] : '' 			
    	                       )
    	              );
    }
    
    
    


}