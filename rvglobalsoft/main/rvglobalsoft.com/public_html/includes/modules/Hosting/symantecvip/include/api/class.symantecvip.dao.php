<?php

/**
 * 
 * SymantecvipDao
 * 
 */

require_once HBFDIR_LIBS . 'RvLibs/RvGlobalSoftApi.php';

class SymantecvipDao {
	
	protected $db;
	
	public $aVIPStatus = array(
        'P' => 'Processing',
        'X' => 'Suspended',
        'C' => 'Active',
    );
	
    /**
     * 
     * Enter description here ...
     */
    public function __construct() {
        $this->db = hbm_db();
    }
    
    /**
     * Returns a singleton HostbillApi instance.
     *
     * @author Puttipong Pengprakhon <puttipong@rvglobalsoft.com>
     *         Isara Wongnonglaeng <isara@rvglobalsoft.com>
     * @param bool $autoload
     * @return obj
     * 
     */
     public static function &singleton($autoload=false) {
        static $instance;
        // If the instance is not there, create one
        if (!isset($instance) || $autoload) {
            $class = __CLASS__;
            $instance = new $class();
        }
        return $instance;
    }
    
	/**
     * 
     * Enter description here ...
     * @param $accountID
     * @example SymantecvipDao::singleton()->findAccountByAccountId($accountID);
     */
    public function findOrderIdByAccountId($accountID="") {
    	
    	$query = sprintf("   
                        SELECT 
                            i.order_id
                        FROM 
                            %s i
                        WHERE
                            i.id='%s'                  
                        "
                        , "hb_accounts"
                        , $accountID
                    );
                    
        $aRes = $this->db->query($query)->fetchAll();
        
        return (isset($aRes["0"]["order_id"])) ? $aRes["0"]["order_id"] : null;              
    }
    
    
	public function getVIPInfoByID($vip_info_id)
	{
        $query = sprintf("
            SELECT 
               *              
            FROM 
                %s       
            WHERE
                vip_info_id != ''
            %s
            ORDER BY
                vip_info_id DESC 
            "
            , 'hb_vip_info'
            , ((isset($vip_info_id) && $vip_info_id != '') 
                    ? " AND  vip_info_id = '{$vip_info_id}' " : "")
            );
            
        $aRes = $this->db->query($query)->fetchAll();
        $sub_status = $aRes['0']['status'];
        $manage_status = $aRes['0']['can_manage_status'];
        $aRes['0']['vip_subscription_status'] = $this->aVIPStatus[$sub_status];
        $aRes['0']['vip_manage_status'] = $this->aVIPStatus[$manage_status];
        return (isset($aRes["0"]["vip_info_id"])) ? $aRes["0"] : null;              
	}
	
	public function getVIPInfoByUsrID($usrId)
	{
        $query = sprintf("
            SELECT 
               *              
            FROM 
                %s       
            WHERE
                vip_info_id != ''
            %s
            ORDER BY
                vip_info_id DESC 
            "
            , 'hb_vip_info'
            , ((isset($usrId) && $usrId != '') 
                    ? " AND  usr_id = '{$usrId}' " : "")
            );
            
        $aRes = $this->db->query($query)->fetchAll();
        $sub_status = $aRes['0']['status'];
        $manage_status = $aRes['0']['can_manage_status'];
        $aRes['0']['vip_subscription_status'] = $this->aVIPStatus[$sub_status];
        $aRes['0']['vip_manage_status'] = $this->aVIPStatus[$manage_status];
        return $aRes['0'];       
	}
	
	public function getVIPInfoByUsrIDcPanelAppsType($usrId,$cPanelAppType)
	{
        $query = sprintf("
            SELECT 
               *              
            FROM 
                %s       
            WHERE
                vip_info_cp_apps_id != ''
            	%s
            	%s
            LIMIT 0,1 
            "
            , 'hb_vip_info_cp_apps'
            , ((isset($usrId) && $usrId != '') 
                    ? " AND  usr_id = '{$usrId}' " : "")
            , ((isset($cPanelAppType) && $cPanelAppType != '') 
                    ? " AND  cp_apps_type = '{$cPanelAppType}' " : "")
            );
            
            //echo "query=".$query; exit;
            
        $aRes = $this->db->query($query)->fetchAll();
        /*
        $sub_status = $aRes['0']['status'];
        $manage_status = $aRes['0']['can_manage_status'];
        $aRes['0']['vip_subscription_status'] = $this->aVIPStatus[$sub_status];
        $aRes['0']['vip_manage_status'] = $this->aVIPStatus[$manage_status];
        */
        return $aRes['0'];       
	}
	
	public function addVIP ($aData=null)
    {
        $query = sprintf("
            INSERT INTO 
            	%s              
            (	usr_id,	account_id , vip_user_prefix,	date_created
            ,	last_updated,		ou_number,	billing_cycle_unit
            ,	quantity,	quantity_at_symantec,	can_manage_status,	status,		product_id 
            ,	vip_info_type ) 
            VALUES
            (	%s , %s , %s , %s 
            ,   %s , %s , %s 
            ,	%s , %s , %s 
            ,   %s , %s , %s )
            "
            , 'hb_vip_info'
            , "'".$aData["usr_id"]."'"
            , "'".$aData["account_id"]."'"
            , "'".$aData["vip_user_prefix"]."'"
            , time()
            , time()
            , "'".$aData["ou_number"]."'"
            , "'".$aData["billing_cycle_unit"]."'"
            , $aData["quantity"]
            , $aData["quantity_at_symantec"]
            , "'P'"
            , "'P'"
            , $aData["product_id"]
            , "'".$aData["vip_info_type"]."'"
            );
            
    	if ($this->db->query($query))
        { 
        	return true;
        } else {
        	return false;
        } 
    }
    
 	public function updateVIP ($aData=null , $vipInfoId = 0)
    {
         $query = sprintf("
            UPDATE
            	%s     
            SET last_updated = %s ,
            	    %s 
            		billing_cycle_unit = %s ,
            		quantity = %s ,
            		quantity_at_symantec = %s ,
            		%s
            		%s
            		product_id = %s ,
            		vip_info_type = %s 
            WHERE 
            		vip_info_id = %s
            "
            , 'hb_vip_info'
            , time()
            , (isset($aData["ou_number"]))?" ou_number = '".$aData["ou_number"]."' , ":" "
            , "'".$aData["billing_cycle_unit"]."'"
            , $aData["quantity"]
            , $aData["quantity_at_symantec"]
            , (isset($aData["can_manage_status"]))?" can_manage_status = '".$aData["can_manage_status"]."' , ":" "
            , (isset($aData["status"]))?" status = '".$aData["status"]."' , ":" "
            , $aData["product_id"]
            , "'".$aData["vip_info_type"]."'"
            , $vipInfoId
            );
            
            //echo "in dao query=".$query;
            
        if ($this->db->query($query))
        { 
        	return true;
        } else {
        	return false;
        }
    }
    
    
	public function updateSymantecVipAccount ($vipInfoId , $account_id , $new_qty)
    {
         $query = sprintf("
            UPDATE
            	%s     
            SET last_updated = %s ,
            	quantity_at_symantec = %s
            WHERE 
                vip_info_id = %s
            AND 
            	account_id = %s
            "
            , 'hb_vip_info'
            , time()
            , $new_qty
            , $vipInfoId
            , $account_id
            );
            
            //echo "in dao query=".$query;
            
        if ($this->db->query($query))
        { 
        	return true;
        } else {
        	return false;
        }
    }
    
    public function updateVIPCertificateFile ($aData=null , $vipInfoId = 0)
    {
         $query = sprintf("
            UPDATE
            	%s     
            SET 
            		%s
            		%s
            		%s
            		%s
            		%s
            		%s 
            		%s 
            		%s
            		%s
            		
            		%s 
            		%s 
            	    %s 
            		%s
            		%s
            		%s
            		%s 
            		%s
            		%s 
            		
            		%s 
            	    %s
            	    vip_info_id = %s
            WHERE 
            		vip_info_id = %s
            "
            , 'hb_vip_info'
            , (isset($aData["certificate_file_name"]))?" certificate_file_name = '".$aData["certificate_file_name"]."' , ":" "
            , (isset($aData["certificate_file_type"]))?" certificate_file_type = '".$aData["certificate_file_type"]."' , ":" "
            , (isset($aData["certificate_file_size"]))?" certificate_file_size = '".$aData["certificate_file_size"]."' , ":" "
            , (isset($aData["certificate_file_path"]))?" certificate_file_path = '".$aData["certificate_file_path"]."' , ":" "
            , (isset($aData["certificate_file_content"]))?" certificate_file_content = '".$aData["certificate_file_content"]."' , ":" "
            , (isset($aData["md5sum"]))?" md5sum = '".$aData["md5sum"]."' , ":" "
            , ($aData["date_file_upload"]!="")?" date_file_upload = '".$aData["date_file_upload"]."' , ":" "
            , (isset($aData["date_file_last_upload"]))?" date_file_last_upload = '".$aData["date_file_last_upload"]."' , ":" "
            , (isset($aData["certificate_expire_date"]))?" certificate_expire_date = '".$aData["certificate_expire_date"]."' , ":" "
            
            , (isset($aData["certificate_file_name_p12"]))?" certificate_file_name_p12 = '".$aData["certificate_file_name_p12"]."' , ":" "
            , (isset($aData["certificate_file_type_p12"]))?" certificate_file_type_p12 = '".$aData["certificate_file_type_p12"]."' , ":" "
            , (isset($aData["certificate_file_size_p12"]))?" certificate_file_size_p12 = '".$aData["certificate_file_size_p12"]."' , ":" "
            , (isset($aData["certificate_file_path_p12"]))?" certificate_file_path_p12 = '".$aData["certificate_file_path_p12"]."' , ":" "
            , (isset($aData["certificate_file_content_p12"]))?" certificate_file_content_p12 = '".$aData["certificate_file_content_p12"]."' , ":" "
            , (isset($aData["md5sum_p12"]))?" md5sum_p12 = '".$aData["md5sum_p12"]."' , ":" "
            , ($aData["date_file_upload_p12"]!="")?" date_file_upload_p12 = '".$aData["date_file_upload_p12"]."' , ":" "
            , (isset($aData["date_file_last_upload_p12"]))?" date_file_last_upload_p12 = '".$aData["date_file_last_upload_p12"]."' , ":" "
            , (isset($aData["certificate_expire_date_p12"]))?" certificate_expire_date_p12 = '".$aData["certificate_expire_date_p12"]."' , ":" "

            //, (isset($aData["status"]))?" status = '".$aData["status"]."' , ":" "
            , " status = 'P' , "
            // , (isset($aData["symantec_connection"]))?" symantec_connection = '".$aData["symantec_connection"]."' , ":" "
            , " symantec_connection = 'Waiting for check password' , "
            , $vipInfoId
            , $vipInfoId
            );
            
      // return  "in dao query=".$query;
            
        if ($this->db->query($query))
        { 
        	return true;
        } else {
        	return false;
        }
    }
    
    
    public function updateVIPCertificateFilePassword($aData=null , $vipInfoId = 0) 
    {
     $query = sprintf("
            UPDATE
            	%s     
            SET 
            		certificate_file_password = %s ,
            		certificate_file_password_p12 = %s 
    
            WHERE 
            		vip_info_id = %s
            "
            , 'hb_vip_info'
            , "'".$aData["certificate_file_password"]."'"
            , "'".$aData["certificate_file_password_p12"]."'"
            , $vipInfoId
            );
            
           // echo "dao_query=".$query; exit;
            
        if ($this->db->query($query))
        { 
        	$conn = $this->checkSymantecConnection($vipInfoId);
        	return true;
        } else {
        	return false;
        }
    }
    
    
    
	public function updateVIPCertificateFilecPanelApps ($aData=null , $vipInfoId = 0)
    {
         $query = sprintf("
            UPDATE
            	%s     
            SET 
            		%s
            		%s
            		%s
            		%s
            		%s
            		%s
            		%s
            		%s 
            		%s 
            		%s
            		%s
            		%s
            		
            		%s 
            		%s 
            	    %s 
            		%s
            		%s
            		%s
            		%s 
            		%s
            		%s 
            		%s
            		
            		%s 
            	    %s
            	    vip_info_id = %s
            WHERE 
            		vip_info_id = %s
           	AND 
           			usr_id = %s
            AND 	
            		cp_apps_type = %s
            "
            , 'hb_vip_info_cp_apps'
            , (isset($aData["account_id"]))?" account_id = '".$aData["account_id"]."' , ":" "
            , (isset($aData["cp_apps_type"]))?" cp_apps_type = '".$aData["cp_apps_type"]."' , ":" "
            , (isset($aData["certificate_file_name"]))?" certificate_file_name = '".$aData["certificate_file_name"]."' , ":" "
            , (isset($aData["certificate_file_type"]))?" certificate_file_type = '".$aData["certificate_file_type"]."' , ":" "
            , (isset($aData["certificate_file_size"]))?" certificate_file_size = '".$aData["certificate_file_size"]."' , ":" "
            , (isset($aData["certificate_file_path"]))?" certificate_file_path = '".$aData["certificate_file_path"]."' , ":" "
            , (isset($aData["certificate_file_content"]))?" certificate_file_content = '".$aData["certificate_file_content"]."' , ":" "
            , (isset($aData["certificate_file_password"]))?" certificate_file_password = '".$aData["certificate_file_password"]."' , ":" "
            , (isset($aData["md5sum"]))?" md5sum = '".$aData["md5sum"]."' , ":" "
            , ($aData["date_file_upload"]!="")?" date_file_upload = '".$aData["date_file_upload"]."' , ":" "
            , (isset($aData["date_file_last_upload"]))?" date_file_last_upload = '".$aData["date_file_last_upload"]."' , ":" "
            , (isset($aData["certificate_expire_date"]))?" certificate_expire_date = '".$aData["certificate_expire_date"]."' , ":" "
            
            , (isset($aData["certificate_file_name"]))?" certificate_file_name_p12 = '".$aData["certificate_file_name"]."' , ":" "
            , (isset($aData["certificate_file_type_p12"]))?" certificate_file_type_p12 = '".$aData["certificate_file_type_p12"]."' , ":" "
            , (isset($aData["certificate_file_size_p12"]))?" certificate_file_size_p12 = '".$aData["certificate_file_size_p12"]."' , ":" "
            , (isset($aData["certificate_file_path_p12"]))?" certificate_file_path_p12 = '".$aData["certificate_file_path_p12"]."' , ":" "
            , (isset($aData["certificate_file_content_p12"]))?" certificate_file_content_p12 = '".$aData["certificate_file_content_p12"]."' , ":" "
            , (isset($aData["certificate_file_password"]))?" certificate_file_password_p12 = '".$aData["certificate_file_password"]."' , ":" "
            
            , (isset($aData["md5sum_p12"]))?" md5sum_p12 = '".$aData["md5sum_p12"]."' , ":" "
            , ($aData["date_file_upload_p12"]!="")?" date_file_upload_p12 = '".$aData["date_file_upload_p12"]."' , ":" "
            , (isset($aData["date_file_last_upload_p12"]))?" date_file_last_upload_p12 = '".$aData["date_file_last_upload_p12"]."' , ":" "
            , (isset($aData["certificate_expire_date"]))?" certificate_expire_date_p12 = '".$aData["certificate_expire_date"]."' , ":" "

            //, (isset($aData["status"]))?" status = '".$aData["status"]."' , ":" "
            , " status = 'P' , "
            // , (isset($aData["symantec_connection"]))?" symantec_connection = '".$aData["symantec_connection"]."' , ":" "
            , " symantec_connection = 'Waiting for check password' , "
            , $vipInfoId
            , $vipInfoId
            , $aData['usr_id']
            , (isset($aData["cp_apps_type"]))?"  '{$aData["cp_apps_type"]}' ":"''"
            );
            
       //return  "in dao query=".$query; exit;
            
        if ($this->db->query($query))
        { 
        	$this->checkSymantecConnectioncPanelApps($aData["usr_id"],$aData["cp_apps_type"]);
        	return true;
        	
        } else {
        	return false;
        }
    }
    
    
	public function updateVIPManageStatus ($aData=null , $vipInfoId = 0)
    {
         $query = sprintf("
            UPDATE
            	%s     
            SET last_updated = %s ,
            		can_manage_status = %s ,
            		status = %s 
            WHERE 
            		vip_info_id = %s
            "
            , 'hb_vip_info'
            , time()
            , "'".$aData['can_manage_status']."'"
            , "'".$aData['status']."'"
            , $vipInfoId
            );
            
        if ($this->db->query($query))
        { 
        	return true;
        } else {
        	return false;
        }
    }
    
    
	public function updateVIPManageStatuscPanelApps ($aData=null , $vipInfocPanelAppsId = 0)
    {
         $query = sprintf("
            UPDATE
            	%s     
            SET last_updated = %s ,
            		can_manage_status = %s ,
            		status = %s 
            WHERE 
            		vip_info_cp_apps_id = %s
            "
            , 'hb_vip_info_cp_apps'
            , time()
            , "'".$aData['can_manage_status']."'"
            , "'".$aData['status']."'"
            , $vipInfocPanelAppsId
            );
            
            //echo "qq=".$query; exit;
            
        if ($this->db->query($query))
        { 
        	return true;
        } else {
        	return false;
        }
    }
    
    public function checkSymantecConnection($vipInfoId = 0) 
    {
    	
    	$aVIP = $this->getVIPInfoByID($vipInfoId);
    	
    	if (($aVIP["certificate_file_path"] != '') && ($aVIP["certificate_file_password"] != '')) {
    		
    		$oAuth =& RvLibs_RvGlobalSoftApi::singleton();
		    //$oRes = $oAuth->request('get', 'SessionTest');
	  			
  			$rvAddApi = $oAuth->request('post', '/vipconnect', 
    									array('file_path' => $aVIP["certificate_file_path"] ,
    		  								  'file_password' => $aVIP["certificate_file_password"] ,
    										  'usr_id' => $aVIP["usr_id"]
    									     )
    								  );
    		
    								  
    		$test_connect_symantec = (array)$rvAddApi;
    		
    		// update connection status
    		$aData = array ( "symantec_connection" => $test_connect_symantec["statusMessage"]);
    		$upRes = $this->updateVIPConnection($aData,$vipInfoId);
    		
    		
    		$aVIP2 = $this->getVIPInfoByID($vipInfoId);
    		
    		if ( ($test_connect_symantec["statusMessage"] == 'Success') 
    				&& ($aVIP["certificate_file_path"] != '') 
    				&& ($aVIP["certificate_file_password"] != '') 
    				&& ($aVIP["certificate_file_path_p12"] != '' )
    				&& ($aVIP["certificate_file_password_p12"] != '')	
    				&& ($aVIP2["symantec_connection"] == 'Success') 
    				 ) {
    			$aData = array (	'can_manage_status' => 'C' ,
									'status' => 'C'
    							);
    		} else {
				$aData = array (	'can_manage_status' => 'P' ,
									'status' => $aVIP["status"]
    							);
    		}
    		$res = $this->updateVIPManageStatus($aData,$vipInfoId);
	    } 
    	return $res;
    	
    }
    
    
	public function updateVIPConnection ($aData=null , $vipInfoId = 0)
    {
         $query = sprintf("
            UPDATE
            	%s     
            SET 
            	symantec_connection = %s
            WHERE 
            	vip_info_id = %s
            "
            , 'hb_vip_info'
            , "'".$aData["symantec_connection"]."'"
            , $vipInfoId
            );
            
            //echo "in dao query=".$query;
            
        if ($this->db->query($query))
        { 
        	return true;
        } else {
        	return false;
        }
    }
    
    
    
    /*
     * checkSymantecConnection for cPanel Apps
     * 
     */
    
	public function checkSymantecConnectioncPanelApps($usrId,$cPanelAppType) 
    {
    	
    	$aVIP = $this->getVIPInfoByUsrIDcPanelAppsType($usrId,$cPanelAppType);
    	
    	//echo "<pre>"; print_r($aVIP); exit;
    	
    	$vipInfoCpAppsId = $aVIP['vip_info_cp_apps_id'];
    	
    	if (($aVIP["certificate_file_path"] != '') && ($aVIP["certificate_file_password"] != '')) {
    		
    		$oAuth =& RvLibs_RvGlobalSoftApi::singleton();
		    //$oRes = $oAuth->request('get', 'SessionTest');
	  			
  			$rvAddApi = $oAuth->request('post', '/vipconnect', 
    									array('file_path' => $aVIP["certificate_file_path"] ,
    		  								  'file_password' => $aVIP["certificate_file_password"] ,
    										  'usr_id' => $aVIP["usr_id"] , 
    										  'cp_apps_type' => $cPanelAppType ,
    									     )
    								  );
    								  
    		//print_r($rvAddApi);
    		
    								  
    		$test_connect_symantec = (array)$rvAddApi;
    		
    		// update connection status
    		$aData = array ( "symantec_connection" => $test_connect_symantec["statusMessage"]);
    		$upRes = $this->updateVIPConnectioncPanelApps($aData,$vipInfoCpAppsId);
    		
    		
    		$aVIP2 = $this->getVIPInfoByUsrIDcPanelAppsType($usrId,$cPanelAppType);
    		
    		if ( ($test_connect_symantec["statusMessage"] == 'Success') 
    				&& ($aVIP["certificate_file_path"] != '') 
    				&& ($aVIP["certificate_file_password"] != '') 
    				&& ($aVIP["certificate_file_path_p12"] != '' )
    				&& ($aVIP["certificate_file_password_p12"] != '')	
    				&& ($aVIP2["symantec_connection"] == 'Success') 
    				 ) {
    			$aData = array (	'can_manage_status' => 'C' ,
									'status' => 'C'
    							);
    		} else {
				$aData = array (	'can_manage_status' => 'P' ,
									'status' => $aVIP["status"]
    							);
    		}
    		$res = $this->updateVIPManageStatuscPanelApps($aData,$vipInfoCpAppsId);
	    } 
    	return $res;
    	
    }
    
	public function updateVIPConnectioncPanelApps ($aData=null , $vipInfocPAppsId = 0)
    {
         $query = sprintf("
            UPDATE
            	%s     
            SET 
            	symantec_connection = %s
            WHERE 
            	vip_info_cp_apps_id = %s
            "
            , 'hb_vip_info_cp_apps'
            , "'".$aData["symantec_connection"]."'"
            , $vipInfocPAppsId
            );
            
          //  echo "in dao query=".$query; exit;
            
        if ($this->db->query($query))
        { 
        	return true;
        } else {
        	return false;
        }
    }
    
    
    
    
    
    /**
     * Get Symantec VIP Account
     * 
     * @author Puttipong Pengprakhon <puttipong@rvglobalsoft.com>
     * @param $accountID
     * @example SymantecvipDao::singleton()->getSymantecVipAccount($params['account']['id']);
     */
    public function getSymantecVipAccount($accountID="") {
    	
    	$query = sprintf("   
                        SELECT 
                            hbup.new_qty
                        FROM 
                            %s hbup,
                            %s hbit
                        WHERE
                            hbup.account_id='%s'
                        AND
                            hbup.status='%s'
                        AND
                            hbup.config_cat=hbit.id
                        AND
                            hbit.name='%s'
                        ORDER BY
                            hbup.id DESC                                             
                        "
                        , "hb_config_upgrades"
                        , "hb_config_items_cat"
                        , $accountID
                        , "Upgraded"
                        , "quantity"
                    ); // Symantec VIP Account // change when label in rv2factor change
                    
         $aRes = $this->db->query($query)->fetchAll();
         return (isset($aRes["0"]["new_qty"])) ? $aRes["0"]["new_qty"] : 1;
    }
    
    
    public function addVIPcPanelApps($aData) 
    {
    	$query = sprintf("
            INSERT INTO 
            	%s              
            (	vip_info_id 
            , 	usr_id 
            ,	date_created
            ,	last_updated 
            , 	can_manage_status
            ,	status 
            ,	cp_apps_type ) 
            VALUES
            (	%s 
            , %s 
            , %s 
            , %s 
            ,   %s 
            , %s 
            , %s 
            )
            "
            , 'hb_vip_info_cp_apps'
            , "'".$aData["vip_info_id"]."'"
            , "'".$aData["usr_id"]."'"
            , "'".$aData["date_created"]."'"
            , "'".$aData["last_updated"]."'"
            , "'".$aData["can_manage_status"]."'"
            , "'".$aData["status"]."'"
            , "'".$aData["cp_apps_type"]."'"
            );
            
    	if ($this->db->query($query))
        { 
        	return true;
        } else {
        	return false;
        } 
    }
      
}


 