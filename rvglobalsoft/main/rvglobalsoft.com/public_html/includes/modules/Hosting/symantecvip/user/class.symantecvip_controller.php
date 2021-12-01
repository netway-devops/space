<?php

/*************************************************************
 *
 * Hosting Module Class - Symantecvip
 * 
 * http://dev.hostbillapp.com/dev-kit/provisioning-modules/client-area/
 * 
 ************************************************************/

require_once HBFDIR_LIBS . 'RvLibs/RvGlobalSoftApi.php';

class symantecvip_controller extends HBController {
	
	protected $moduleName = "symantecvip";
	
	public function accountdetails($params) {
		
	}
		
    public function view($request) {
    }
    
    
	/*****************************************************************
     * doAddVIPAccount
     *****************************************************************/  
	public function _validate_doAddVIPAccount($params) {
        
        $input = array( 
     		"isValid" => true,
          	"resError" => ""
        );
        
        // Variable Defined.
        $input["acctPrefix"] = (isset($params["acctPrefix"]) && $params["acctPrefix"] != "") ? $params["acctPrefix"] : null;
        $input["vipAcctName"] = (isset($params["vipAcctName"]) && $params["vipAcctName"] != "") ? $params["vipAcctName"] : null;
        $input["vipAcctComment"] = (isset($params["vipAcctComment"]) && $params["vipAcctComment"] != "") ? $params["vipAcctComment"] : null;
        $input["vipAcctNameFull"] = (isset($params["vipAcctNameFull"]) && $params["vipAcctNameFull"] != "") ? $params["vipAcctNameFull"] : null;
        
        if (isset($input["acctPrefix"]) && ($input["acctPrefix"] != "")
         && isset($input["vipAcctName"]) && ($input["vipAcctName"] != "")
         && isset($input["vipAcctComment"]) && ($input["vipAcctComment"] != "")
         && isset($input["vipAcctNameFull"]) && ($input["vipAcctNameFull"] != "")) {
         	
        } else {
        	
        	$resError = "";
        	
        	if (!isset($input["vipAcctName"]) || ($input["vipAcctName"] == "")) {
            	$resError = 'Please type Symantec™ VIP Account';
        	} else if (!isset($input["vipAcctComment"]) || ($input["vipAcctComment"] == "")){
            	$resError = 'Please type Note'; 
        	}
        	
        	$input["isValid"] = false;
        	$input["resError"] = $resError;
        }

        return $input;
    
    }
    
    public function doAddVIPAccount($params) {
    	
    	$complete = "1";
        $message = "";
    
        try {
            
            // Validate
            $input = $this->_validate_doAddVIPAccount($params);
            
            
             //echo "--------input--------<pre>";
			    
			 //print_r($input);
			    
			    
            if ($input["isValid"] == false) {
                throw new Exception($input["resError"]);
            } else {
 
            	// connect to api for add vip account
            	$oAuth =& RvLibs_RvGlobalSoftApi::singleton();
		        //$oRes = $oAuth->request('get', 'SessionTest');
            	$rvAddApi = $oAuth->request('post', '/vipuserinfo', 
	    									array('vip_acct_name' => $input['vipAcctNameFull'] ,
	    		  								  'vip_acct_comment' => $input['vipAcctComment'] ,
	    										  'action_do' => 'addacct'
	    									     )
	    								  );
	    								  
			    $userAddRes = (array)$rvAddApi;
			    
			    if ($userAddRes['status'] == 'success') { 
			    	$complete = "1";
			    	$message = $userAddRes['comment'];
			    	$vip_acct_id = $userAddRes['vip_acct_id'];
			    } else {
			    	$complete = "0";
			    	$message = $userAddRes['comment'];
			    	$vip_acct_id = '';
			    }
			    
			    
			    /*
			    if ($userAddRes['status'] == 'success') {
			    	
			    	$aSuc['comment'] = $userAddRes['comment'];
					SGL::raiseMsg($aSuc['comment'], true, SGL_MESSAGE_INFO);
					SGL_HTTP::redirect(
						array (
						 'vip_acct_id' => $userAddRes['vip_acct_id'] ,
						 'vip_acct_name' => $userAddRes['vip_acct_name'] ,
						 'action_do' => 'addcred_after_addacct'
						)
					);
			    	
			    } else {
			    	
			    	$aErrors['comment'] = $userAddRes['comment'];
					SGL::raiseMsg($aErrors['comment'], true, SGL_MESSAGE_ERROR);
					$input->action = 'list';
					SGL_HTTP::redirect(
						array ('managerName' => 'vipmanager', )
					);
			    }	
			    */
            
           	}
        } catch (Exception $e) {
            $complete = "0";
            $message = $e->getMessage();
        }
        
        $aResponse = array(
          "complete" => $complete,
          "message" => $message,
          "vip_acct_id" => $vip_acct_id
        );
        
        
        $this->loader->component('template/apiresponse', 'json');
        $this->json->assign("aResponse", $aResponse);
        $this->json->show();
    }
    
    
    ///cmd"zabbix"action=doAddVIPAccount&acctPrefix=vip3_&vipAcctName=44444&vipAcctComment=999&vipAcctNameFull=vip3_44
    
    
    
    
	/*****************************************************************
     * doAddVIPAccount
     *****************************************************************/  
	public function _validate_doDeleteVIPAccount($params) {
        
        $input = array( 
     		"isValid" => true,
          	"resError" => ""
        );
        
        $resError = '';
        
        // Variable Defined.
        $input["vipAcctId"] = (isset($params["vipAcctId"]) && $params["vipAcctId"] != "") ? $params["vipAcctId"] : null;
 
        if (isset($input["vipAcctId"]) && ($input["vipAcctId"] != "")) {
         	
        } else {
            $resError = 'Please type Symantec™ VIP Account';
            $input["isValid"] = false;
        	$input["resError"] = $resError;
        }

        return $input;
    
    }
    
    
    public function doDeleteVIPAccount($params) {
    	
    	$complete = "1";
        $message = "";
        
    	try {
            
            // Validate
            $input = $this->_validate_doDeleteVIPAccount($params);
            
            if ($input["isValid"] == false) {
                throw new Exception($input["resError"]);
            } else {

            	// connect to api for add vip account
            	$oAuth =& RvLibs_RvGlobalSoftApi::singleton();
		        //$oRes = $oAuth->request('get', 'SessionTest');
            	$rvAddApi = $oAuth->request('get', '/vipuserinfo', 
	    									array('vip_acct_id' => $input['vipAcctId'] ,
	    		  								  'action_do' => 'deleteacct'
	    									     )
	    								  );
	    								  
			    $userAddRes = (array)$rvAddApi;
			    
			    if ($userAddRes['del_status'] == 'success') { 
			    	$complete = "1";
			    	$message = $userAddRes['comment'];
			    } else {
			    	$complete = "0";
			    	$message = $userAddRes['comment'];
			    }
            
           	}
        } catch (Exception $e) {
            $complete = "0";
            $message = $e->getMessage();
        }
        
    	$aResponse = array(
          "complete" => $complete,
          "message" => $message
        );
        
        
        $this->loader->component('template/apiresponse', 'json');
        $this->json->assign("aResponse", $aResponse);
        $this->json->show();
    	
    }
    
    public function doGetVIPCredList($params)
    {
    	try {
    		
    		$vipAcctId = (isset($params["vipAcctId"]) && $params["vipAcctId"] != "") ? $params["vipAcctId"] : null;
    		
    		$oAuth =& RvLibs_RvGlobalSoftApi::singleton();
            $rvAddApi = $oAuth->request('get', '/vipuserinfo', 
	    									array('vip_acct_id' => $vipAcctId ,
	    		  								  'action_do' => 'listcred'
	    									     )
	    								  );
	    								  
			$userAddRes = (array)$rvAddApi;
    		
			$vipCredLlist = $userAddRes['vip_cred_list'];
			
			$htmlCredList = '<strong>Symantec&trade; VIP Credential ID list for : '.$userAddRes['vip_acct_name'].'</strong>';
			$htmlCredList .= '<br />Find : '.$userAddRes['vip_cred_num'].'/5 credentials<br />';
			
			$htmlCredList .= '<table cellpadding="3" cellspacing="0" width="100%" style=" font-size:14px;">';
			$htmlCredList .= '<tr bgcolor="#91b0c1">';
			$htmlCredList .= '<th style="color:#fff; padding:4px; font-weight:bold;border-right:1px solid #ffffff; border-bottom:1px solid #ffffff; text-align:center;">Credential ID</th>';
			$htmlCredList .= '<th style="color:#fff; padding:4px; font-weight:bold;border-right:1px solid #ffffff; border-bottom:1px solid #ffffff; text-align:center;">Name</th>';
			$htmlCredList .= '<th style="color:#fff; padding:4px; font-weight:bold;border-right:1px solid #ffffff; border-bottom:1px solid #ffffff; text-align:center;">Delete</th>';
			$htmlCredList .= '</tr>';
			
			foreach ($vipCredLlist as $k => $dtl) {
				$htmlCredList .= '<tr>';
				$htmlCredList .= '<td style="text-align:center; background:#e2e2e2; border-bottom:1px solid #ffffff;">'.$dtl->vip_cred.'</td>';
				$htmlCredList .= '<td style="text-align:center; background:#e2e2e2; border-bottom:1px solid #ffffff;">'.$dtl->vip_cred_comment.'</td>';
				$htmlCredList .= '<td style="text-align:center; background:#e2e2e2; border-bottom:1px solid #ffffff;">';
				$htmlCredList .= '<span class="ui-button"><input onclick="jQuery.symantecvip.makeEventdoDeleteCredential(' . $dtl->vip_cred_id . ');" type="button" class="vip-delete-cred" id="'.$dtl->vip_cred_id.'" value="Delete"></span></td>';
				$htmlCredList .= '</tr>';
			}
				
			$htmlCredList .= '</table>';
  
    	} catch (Exception $e) {
            $complete = "0";
            $message = $e->getMessage();
        }
        
        
        $aResponse = array(
          "vip_cred_num" => $userAddRes['vip_cred_num'] ,
          "vip_cred_list" => $userAddRes['vip_cred_list'],
          "htmlCredList" => $htmlCredList
        );
    	
    	$this->loader->component('template/apiresponse', 'json');
        $this->json->assign("aResponse", $aResponse);
        $this->json->show();
    }
    
    
    public function doLoadVIPCredAddForm($params) 
    {
    	try {
    		
    		$vipAcctId = (isset($params["vipAcctId"]) && $params["vipAcctId"] != "") ? $params["vipAcctId"] : null;
    		
    		$oAuth =& RvLibs_RvGlobalSoftApi::singleton();
            $rvAddApi = $oAuth->request('get', '/vipuserinfo', 
	    									array('vip_acct_id' => $vipAcctId ,
	    		  								  'action_do' => 'get_vip_acct_name'
	    									     )
	    								  );			  
			$userAddRes = (array)$rvAddApi;
			
			$vipAcctNameRes = $userAddRes['vip_acct_name'];
			
			/*
			$htmlForm = '<form name="createvipcredential" method="post" action="">';
			$htmlForm .= '<div class="titlevip">';
			*/
			$htmlForm .= '<h1 style="color:#166dbd; font-size:16px; font-weight:bold;">Add Credential ID for Symantec&trade; VIP account : <strong>' . $vipAcctNameRes . '</strong></h1>';
			$htmlForm .= '<input type="hidden" id="vip-acct-id" value="' . $vipAcctId . '">';
			$htmlForm .= '<input type="hidden" id="vip-acct-name-input" value="' . $vipAcctNameRes . '">'; 
			$htmlForm .= '<input type="hidden" id="vip-cred-type" value="STANDARD_OTP">'; 
			$htmlForm .= '</div>';
				/*
			$htmlForm .= '<div>';
			$htmlForm .= '<table cellpadding="0" cellspacing="2" width="100%" style=" font-size:14px;">';
			$htmlForm .= '<tr>';
			$htmlForm .= '<td align="right" valign="top" width="30%" style="padding-right:5px;"><div align="right">Credential ID : </div></td>';
			$htmlForm .= '<td align="left" valign="top"><div class="left"><input type="text" name="vip_cred" class="vip-cred" /></div></td>';
			$htmlForm .= '<td align="left" valign="top" width="36%">';
			$htmlForm .= '<ul class="inlinehelp">';
			$htmlForm .= '<li><img src="iconHelp.png" alt="" border="0" hspace="5" />';
			$htmlForm .= '<ul>';
			$htmlForm .= '<li><strong>What is a credential ID?</strong>';
			$htmlForm .= '<br />The credential ID is typically a 12-character alphanumeric identifier used when registering the user\'s credential. This ID associates the credential with the Symantec&trade; VIP\'s account.</li>';
			$htmlForm .= '</ul>';
			$htmlForm .= '</li>';
			$htmlForm .= '</ul>';
			$htmlForm .= '</td>';
			$htmlForm .= '</tr>';
			$htmlForm .= '<tr>';
			$htmlForm .= '<td align="right" valign="top" style="padding-right:5px;"><div align="right">Name :</div> </td>';
			$htmlForm .= '<td align="left" valign="top"><div class="left"><input type="text" name="vip-cred-comment" class="vip_cred_comment" /></div></td>';
			$htmlForm .= '<td align="left" valign="top" width="36%">';
			$htmlForm .= '<ul class="inlinehelp">';
			$htmlForm .= '<li><img src="iconHelp.png" alt="" border="0" hspace="5" />';
			$htmlForm .= '<ul>';
			$htmlForm .= '<li><strong>What is the credential name?</strong>';
			$htmlForm .= '<br />This is an informal name to easily identify this credential.</li>';
			$htmlForm .= '</ul>';
			$htmlForm .= '</li>';
			$htmlForm .= '</ul>';
			$htmlForm .= '</td>';
			$htmlForm .= '</tr>';
			$htmlForm .= '<tr>';
			$htmlForm .= '<td align="right" valign="top">&nbsp;</td>';
			$htmlForm .= '<td align="left" valign="top"><input type="button" id="vip-save-credential" name="vip-save-credential" value="Add Credential ID" class="ui-button" /></td>';
			$htmlForm .= '</tr>';
			$htmlForm .= '</table>';
			$htmlForm .= '</div>';
			$htmlForm .= '</form>';
			
			*/
    	
    	} catch (Exception $e) {
            $complete = "0";
            $message = $e->getMessage();
        }
        
        
        $aResponse = array(
          "htmlForm" => $htmlForm
        );
    	
    	$this->loader->component('template/apiresponse', 'json');
        $this->json->assign("aResponse", $aResponse);
        $this->json->show();
    }
    
    
    
	/*****************************************************************
     * doSaveCredential
     *****************************************************************/  
	public function _validate_doSaveCredential($params) {
        
        $input = array( 
     		"isValid" => true,
          	"resError" => ""
        );
        
        $resError = '';
				 
        // Variable Defined.
        $input["vipCred"] = (isset($params["vipCred"]) && $params["vipCred"] != "") ? $params["vipCred"] : null;
        $input["vipCredComment"] = (isset($params["vipCredComment"]) && $params["vipCredComment"] != "") ? $params["vipCredComment"] : null;
        $input["vipAcctId"] = (isset($params["vipAcctId"]) && $params["vipAcctId"] != "") ? $params["vipAcctId"] : null;
        $input["vipAcctName"] = (isset($params["vipAcctNameInput"]) && $params["vipAcctNameInput"] != "") ? $params["vipAcctNameInput"] : null;
        $input["vipCredType"] = (isset($params["vipCredType"]) && $params["vipCredType"] != "") ? $params["vipCredType"] : null;
 
        if (isset($input["vipCred"]) && ($input["vipCred"] != "")
        	&& isset($input["vipCredComment"]) && ($input["vipCredComment"] != "")
        	&& isset($input["vipAcctId"]) && ($input["vipAcctId"] != "")
        	&& isset($input["vipAcctName"]) && ($input["vipAcctName"] != "")
        	&& isset($input["vipCredType"]) && ($input["vipCredType"] != "")
        ) {
         	// nothing to do
        } else {
        	if ( !isset($input["vipCred"]) || ($input["vipCred"] == "") ) {
            	$resError = 'Please type Credential ID';
        	} else if (!isset($input["vipCredComment"]) || ($input["vipCredComment"] == "")) {
        		$resError = 'Please type Name';
        	}
            $input["isValid"] = false;
        	$input["resError"] = $resError;
        }

        return $input;
    
    }
    
    public function doSaveCredential($params) 
    {
    	
    	$complete = "1";
        $message = "";
        
    	try {
            
            // Validate
            $inputD = $this->_validate_doSaveCredential($params);
    	
    		$oAuth =& RvLibs_RvGlobalSoftApi::singleton();
    		
            $rvAddApi = $oAuth->request('post', '/vipuserinfo', 
	    									array('vip_acct_id' => $inputD['vipAcctId'] ,
	    									      'vip_acct_name' => $inputD['vipAcctName']  ,
	    									      'vip_cred_type' => $inputD['vipCredType']  ,
	    		  								  'vip_cred' => $inputD['vipCred']  ,
	    										  'vip_cred_comment' => $inputD['vipCredComment']  ,
	    										  'action_do' => 'addcred'
	    									     )
	    								  );
	    								  
	    	$credAddRes = (array)$rvAddApi;
	    	
	    	$message = $credAddRes['comment'];
	    	
	    	if($credAddRes['status'] == 'success') {
	    		$complete = "1";
	    		//$vip_cred = $input['vipCred'];
	    		//$vip_acct_id = $input['vipAcctId'];
	    		//$vip_acct_name = $input['vipAcctName'];
	    	}  else {
	    		$complete = "0";
	    		//$vip_cred_id = "";
	    	}
			
			//$vipAcctName = $userAddRes['vip_acct_name'];
			
			
    	} catch (Exception $e) {
            $complete = "0";
            $message = $e->getMessage();
        }
        
        $aResponse = array(
          "complete" => $complete,
          "message" => $message,
          "vip_cred_id" => $credAddRes['vip_cred_id'],
          "vip_cred" => $inputD['vipCred'],
	      "vip_acct_id" => $inputD['vipAcctId'],
	      "vip_acct_name" => $inputD['vipAcctName']
        );

    	$this->loader->component('template/apiresponse', 'json');
        $this->json->assign("aResponse", $aResponse);
        $this->json->show();
    	
    }
    
	/*****************************************************************
     * doValidateCredential
     *****************************************************************/  
	public function _validate_doValidateCredentialForm($params) {
        
        $input = array( 
     		"isValid" => true,
          	"resError" => ""
        );
        		 
        $resError = '';
				 
        // Variable Defined.
        $input["vipCred"] = (isset($params["vipCredF"]) && $params["vipCredF"] != "") ? $params["vipCredF"] : null;
        $input["vipAcctId"] = (isset($params["vipAcctIdF"]) && $params["vipAcctIdF"] != "") ? $params["vipAcctIdF"] : null;
        $input["vipAcctName"] = (isset($params["vipAcctNameF"]) && $params["vipAcctNameF"] != "") ? $params["vipAcctNameF"] : null;
    
 
        if (isset($input["vipCred"]) && ($input["vipCred"] != "")
        	&& isset($input["vipAcctId"]) && ($input["vipAcctId"] != "")
        	&& isset($input["vipAcctName"]) && ($input["vipAcctName"] != "")
        ) {
         	// nothing to do
        } else {
        	
        	if ( !isset($input["vipCred"]) || ($input["vipCred"] == "") ) {
            	$resError = 'Please type Symantec&trade; VIP Credential';
        	}
        	
            $input["isValid"] = false;
        	$input["resError"] = $resError;
        }

        return $input;
    
    }
    
    public function doValidateCredentialForm($params)
    {
    	try {
    		
    		$input = $this->_validate_doValidateCredentialForm($params);
  
    		$htmlFormValidate = '<input type="hidden" id="vip-acct-id-c" value="' . $input['vipAcctId'] . '" >';
			$htmlFormValidate .= '<input type="hidden" id="vip-acct-name-c" value="' . $input['vipAcctName'] . '" >';
			$htmlFormValidate .= '<input type="hidden" id="vip-cred-c" value="' . $input['vipCred'] . '" >';
			
			$htmlFormValidate .= 'Add Symantec&trade; VIP Credential ID : <strong>' . $input['vipCred'] . '</strong>';
			
			$htmlFormValidate .= '<br /><br />';
			
			$htmlFormValidate .= 'for Symantec&trade; VIP Account : <strong>' . $input['vipAcctName'] . '</strong>';
    		
    		
    	} catch (Exception $e) {
            $complete = "0";
            $message = $e->getMessage();
        }
        
        
        $aResponse = array(
          "htmlFormValidate" => $htmlFormValidate
        );
    	
    	$this->loader->component('template/apiresponse', 'json');
        $this->json->assign("aResponse", $aResponse);
        $this->json->show();
    	
    }
    
    
    
	/*****************************************************************
     * doValidateCredential
     *****************************************************************/  
	public function _validate_doConfirmCodeOtp($params) {
        
        $input = array( 
     		"isValid" => true,
          	"resError" => ""
        );
        		 
        $resError = '';
				 
        // Variable Defined.
        $inputC["vipCred"] = (isset($params["vipCredC"]) && $params["vipCredC"] != "") ? $params["vipCredC"] : null;
        $inputC["vipAcctId"] = (isset($params["vipAcctIdC"]) && $params["vipAcctIdC"] != "") ? $params["vipAcctIdC"] : null;
        $inputC["vipAcctName"] = (isset($params["vipAcctNameC"]) && $params["vipAcctNameC"] != "") ? $params["vipAcctNameC"] : null;
        $inputC["otp"] = (isset($params["otp"]) && $params["otp"] != "") ? $params["otp"] : null;
    
 
        if (isset($inputC["vipCred"]) && ($inputC["vipCred"] != "")
        	&& isset($inputC["vipAcctId"]) && ($inputC["vipAcctId"] != "")
        	&& isset($inputC["vipAcctName"]) && ($inputC["vipAcctName"] != "")
        	&& isset($inputC["otp"]) && ($inputC["otp"] != "")
        ) {
         	// nothing to do
        } else {
        	
        	if ( !isset($inputC["otp"]) || ($inputC["otp"] == "") ) {
            	$resError = 'Please type security code';
        	}
        	
            $inputC["isValid"] = false;
        	$inputC["resError"] = $resError;
        }

        return $inputC;
    
    }
    
    public function doConfirmCodeOtp($params)
    {
    	$complete = "1";
        $message = "";
        
    	try {
            
            // Validate
            $inputD = $this->_validate_doConfirmCodeOtp($params);
    	
    		$oAuth =& RvLibs_RvGlobalSoftApi::singleton();
    		
            $rvAddApi = $oAuth->request('post', '/vipuserinfo', 
	    									array('vip_acct_id' => $inputD['vipAcctId'] ,
	    									      'vip_acct_name' => $inputD['vipAcctName'] ,
	    										  'vip_cred' => $inputD['vipCred'] ,
	    		  								  'otp' => $inputD['otp'] ,
	    										  'action_do' => 'validate_cred'
	    									     )
	    								  );
	    								  
	    	$credAddRes = (array)$rvAddApi;
	    	
	    	$message = $credAddRes['comment'];
	    	
	    	if($credAddRes['status'] == 'success') {
	    		$complete = "1";
	    		//$vip_cred = $input['vipCred'];
	    		//$vip_acct_id = $input['vipAcctId'];
	    		//$vip_acct_name = $input['vipAcctName'];
	    	}  else {
	    		$complete = "0";
	    		//$vip_cred_id = "";
	    	}
			
			//$vipAcctName = $userAddRes['vip_acct_name'];
			
			
    	} catch (Exception $e) {
            $complete = "0";
            $message = $e->getMessage();
        }
        
        $aResponse = array(
          "complete" => $complete,
          "message" => $message,
          "vip_cred_id" => $credAddRes['vip_cred_id'],
          "vip_cred" => $inputD['vipCred'],
	      "vip_acct_id" => $inputD['vipAcctId'],
	      "vip_acct_name" => $inputD['vipAcctName']
        );

    	$this->loader->component('template/apiresponse', 'json');
        $this->json->assign("aResponse", $aResponse);
        $this->json->show();
    	
    }
    
    
    
    
	/*****************************************************************
     * doDeleteCredential
     *****************************************************************/  
	public function _validate_doDeleteCredential($params) {
        
        $input = array( 
     		"isValid" => true,
          	"resError" => ""
        );
        		 
        $resError = '';
				 
        // Variable Defined.
        $inputX["vipCredIdDel"] = (isset($params["vipCredIdDel"]) && $params["vipCredIdDel"] != "") ? $params["vipCredIdDel"] : null;

        if (isset($inputX["vipCredIdDel"]) && ($inputX["vipCredIdDel"] != "") ) {
         	// nothing to do
        } else {
        	
        	if ( !isset($inputX["vipCredIdDel"]) || ($inputX["vipCredIdDel"] == "") ) {
            	$resError = 'Please click Delete button';
        	}
        	
            $inputX["isValid"] = false;
        	$inputX["resError"] = $resError;
        }
        
        //print_r($inputX); exit;

        return $inputX;
    
    }
    
    public function doDeleteCredential($params)
    {
    	$complete = "1";
        $message = "";
        
    	try {
            // Validate
            $inputZ = $this->_validate_doDeleteCredential($params);
    	
    		$oAuth =& RvLibs_RvGlobalSoftApi::singleton();
    		
    		$rvDelApi = $oAuth->request('get', '/vipuserinfo', 
	    									array('vip_cred_id' => $inputZ['vipCredIdDel'] ,
	    		  								  'action_do' => 'deletecredential' ,
	    									     )
	    								  );
	    								  
	    	$credDeleteRes = (array)$rvDelApi;
	    
	    	if ($credDeleteRes['del_status'] == 'success') {
	    	
	    		$complete = "1";
	    	
	    	}  else {
	    		$complete = "0";
	    	}
	    	
	    	$message = $credDeleteRes['comment'];

    	} catch (Exception $e) {
            $complete = "0";
            $message = $e->getMessage();
        }
        
        $aResponse = array(
          "complete" => $complete,
          "message" => $message,
        );

    	$this->loader->component('template/apiresponse', 'json');
        $this->json->assign("aResponse", $aResponse);
        $this->json->show();
    	
    }
    
    
    
    
    
	/*****************************************************************
     * doGetVIPHostList
     *****************************************************************/  
	public function _validate_doGetVIPHostList($params) {
        
        $input = array( 
     		"isValid" => true,
          	"resError" => ""
        );
        		 
        $resError = '';
				 
        // Variable Defined.
        $inputX["vipAcctId"] = (isset($params["vipAcctId"]) && $params["vipAcctId"] != "") ? $params["vipAcctId"] : null;

        if (isset($inputX["vipAcctId"]) && ($inputX["vipAcctId"] != "") ) {
         	// nothing to do
        } else {
        	
        	if ( !isset($inputX["vipAcctId"]) || ($inputX["vipAcctId"] == "") ) {
            	$resError = 'Please click Manage button';
        	}
        	
            $inputX["isValid"] = false;
        	$inputX["resError"] = $resError;
        }
        
        //print_r($inputX); exit;

        return $inputX;
    
    }
    
    public function doGetVIPHostList($params)
    {
    		
    	try {
    		
    		$vipAcctId = (isset($params["vipAcctId"]) && $params["vipAcctId"] != "") ? $params["vipAcctId"] : null;
    		
    		$oAuth =& RvLibs_RvGlobalSoftApi::singleton();
            $vip_acct_api = $oAuth->request('get', '/vipuserinfo', 
														array( 'action_do' => 'get_vip_acct_name' ,
															   'vip_acct_id' => $vipAcctId ,
															 )
												 );
			$acct_info = (array)$vip_acct_api;
			$vip_acct_name = $acct_info['vip_acct_name'];
			
			
			// get server list
			
			$vip_server_api = $oAuth->request('get', '/vipuserinfo', 
															array( 'action_do' => 'get_server_list' ,
																   'vip_acct_id' => $vipAcctId ,
																 )
													 );
			
			$server_info = (array)$vip_server_api;
			$server_list = $server_info;

			
			$htmlFormHost = '<strong>Manage Symantec™ VIP account : '.$vip_acct_name.' for server</strong><br /><br />';
			
			$htmlFormHost .= '<input type="hidden" name="vip-acct-id" value="'.$vipAcctId.'">'; 
			$htmlFormHost .= '<input type="hidden" name="vip-acct-name" value="'.$vip_acct_name.'">';
		
			$htmlFormHost .= '<table cellpadding="3" cellspacing="0" width="100%" style=" font-size:14px;">';
			$htmlFormHost .= '<tr bgcolor="#91b0c1">';
			$htmlFormHost .= '<th style="color:#fff; padding:4px; font-weight:bold;border-right:1px solid #ffffff; border-bottom:1px solid #ffffff; text-align:center;"><div align="center">Server Name</div></th>';
			$htmlFormHost .= '<th style="color:#fff; padding:4px; font-weight:bold;border-right:1px solid #ffffff; border-bottom:1px solid #ffffff; text-align:center;"><div align="center">Enable</div></th>';
			$htmlFormHost .= '</tr>';

			foreach ( $server_list as $bb => $xx ) 
			{
				if ($xx->is_enable != 1) {
					$chk1 = '<input type="checkbox" class="cpserver_id" id="'.$xx->cpserver_id.'" onclick="jQuery.symantecvip.makeEventdoEnableServer(' . $xx->cpserver_id .',' .$vipAcctId. ');" checked="false">';
				} else {
					$chk1 = '<input type="checkbox" class="cpserver_id" id="'.$xx->cpserver_id.'" onclick="jQuery.symantecvip.makeEventdoEnableServer(' . $xx->cpserver_id .',' .$vipAcctId. ');" checked="true">';
				}
				
				$htmlFormHost .= '<tr>';
				$htmlFormHost .= '<td style="text-align:left; background:#e2e2e2; border-bottom:1px solid #ffffff;">'.$xx->hostname.'</td>';
				$htmlFormHost .= '<td style="text-align:center; background:#e2e2e2; border-bottom:1px solid #ffffff;">';
				$htmlFormHost .= $chk1;
				$htmlFormHost .= '</td>';
				$htmlFormHost .= '</tr>';
			}	
			$htmlFormHost .= '</table>';
		
		} catch (Exception $e) {
            $complete = "0";
            $message = $e->getMessage();
        }
        
        
        $aResponse = array(
          "htmlFormHost" => $htmlFormHost
        );
    	
    	$this->loader->component('template/apiresponse', 'json');
        $this->json->assign("aResponse", $aResponse);
        $this->json->show();
		
    }
    
    
    
    public function _validate_doEnableDisableServer($params) {
        
        $input = array( 
     		"isValid" => true,
          	"resError" => ""
        );
        		 
        $resError = '';
				 
        // Variable Defined.
        $inputX["serverId"] = (isset($params["serverId"]) && $params["serverId"] != "") ? $params["serverId"] : null;
        $inputX["vipAcctId"] = (isset($params["vipAcctId"]) && $params["vipAcctId"] != "") ? $params["vipAcctId"] : null;

        if (isset($inputX["serverId"]) && ($inputX["serverId"] != "") ) {
         	// nothing to do
        } else {
        	
        	if ( !isset($inputX["serverId"]) || ($inputX["serverId"] == "") ) {
            	$resError = 'Please click checkbox';
        	}
        	
            $inputX["isValid"] = false;
        	$inputX["resError"] = $resError;
        }

        return $inputX;
    
    }
    
    
    
    public function doEnableDisableServer($params)
    {
    	$complete = "1";
        $message = "";
        
    	try {
            // Validate
            $inputZ = $this->_validate_doEnableDisableServer($params);
    	
    		$oAuth =& RvLibs_RvGlobalSoftApi::singleton();
    		
    		$dd = $inputZ['serverId'];
    		$vip_acct_id = $inputZ['vipAcctId'];
    		
   			//echo "====dd====".$dd;
   			//echo "=====vip-acct-id=====".$vip_acct_id;
    											 
			$vip_server_api3 = $oAuth->request('post', '/vipuserinfo', 
													array( 'action_do' => 'check_allow_server' ,
													       'vip_acct_id' => $vip_acct_id ,
														   'cpserver_id' => $dd , 
														 )
													 );									 
													 
			$server_info = (array)$vip_server_api3;
			//print_r($server_info);
			//exit;

			
			if($server_info['status'] == 'success') {	
				$complete = "1";	
				$msg = "Success to set server for Symantec™ VIP account : ".$server_info['vip_acct_name'];
			} else {
				$complete = "0";
				$msg = "Failed to set server for Symantec™ VIP account : ".$server_info['vip_acct_name'];
			}
			$message = $msg;
					
    	} catch (Exception $e) {
            $complete = "0";
            $message = $e->getMessage();
        }
        
        $aResponse = array(
          "complete" => $complete,
          "message" => $message,
        );

    	$this->loader->component('template/apiresponse', 'json');
        $this->json->assign("aResponse", $aResponse);
        $this->json->show();
    }
    

}