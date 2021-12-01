<?php

class afterregisterfivedays_controller extends HBController {
    /* 
     * Under $this->module HostBill will load your module
     * in this case it will be Example 
    */
    public $module;
    
    public function call_Daily()  
    {
        $this->fivedays_no_order(); //pipedrive
		$this->twodays(); //email
        $message    = '';
        return $message;
    }
    
	public function twodays(){
		
		$db     = hbm_db();
		$last2days  =   date('Y-m-d', strtotime("-2 days"));
        $result = $db->query("
                                SELECT
                                	c.id , c.companyname , c.phonenumber , c.firstname , c.lastname , ca.email
                                FROM
                                	hb_client_details c , hb_client_access ca
                                WHERE
                                	datecreated = '{$last2days}'
                                	AND c.id = ca.id
                            ")->fetchAll();
							
		foreach($result as $aClient){
							
        
			$subject = 'Good News for New Registered Account!';
			$headers = 'From: Rvglobalsoft <admin@rvglobalsoft.com>' . "\r\n" .
					    'Reply-To: admin@rvglobalsoft.com' . "\r\n" .
					    'X-Mailer: PHP/' . phpversion() . "\r\n";
			$headers .= "Content-Type: text/html; charset=ISO-8859-1rn";
			
	        $message	=	'<table border="0">
							<tbody>
								<tr>
									<td colspan="7"><span style="font-size: small;">&nbsp;<img title="logo" src="http://rvglobalsoft.com/picForMailTemplate/RV_LOGO.png" alt="Logo" width="131" height="50" /></span></td>
								</tr>
								<tr>
									<td colspan="7">
										<p><span style="font-size: small;"><a href="http://rvsitebuilder.com/" target="_blank">RVSiteBuilder</a>&nbsp;|&nbsp;<a href="http://www.rvskin.com/">RVSkin</a>&nbsp;|&nbsp;<a href="https://www.rvssl.com/">RVSSL</a>&nbsp;|&nbsp;<a href="http://rv2factor.com/">RV2Factor&nbsp;</a>|&nbsp;<a href="http://rvlogin.technology/">RVLogin</a>&nbsp;|&nbsp;<a href="http://www.rvlicense.com/">RVLicense</a>&nbsp;|&nbsp;<a href="https://rvglobalsoft.com/knowledgebase/">Support</a></span></p>
									</td>
								</tr>
								<tr>
									<td colspan="7">
										<p dir="ltr"><span style="font-size: small;">DEAR '. $aClient['firstname'] .' '.$aClient['lastname'] .',<br /><br /></span><span style="font-size: small;">This email sent to you according to your registered account with us RVGlobalsoft a few days ago.<br /><br /></span><span style="font-size: small;">We would like to offer you few briefs of our products for your </span><strong style="font-size: small;">interests</strong><span style="font-size: small;"> and </span><strong style="font-size: small;">BENEFIT</strong><span style="font-size: small;">!<br /><br /></span><strong style="font-size: small;">NEW!</strong><span style="font-size: small;"> Every Registered Account can make BENEFIT in our SSL Certificates Reseller program!<br /></span><span style="font-size: small;">Come jois us here, you can resell SSL Certificates in the most easiest way on </span><a style="font-size: small;" href="https://rvssl.com/reseller/">WHMCS</a><span style="font-size: small;">, and also </span><a style="font-size: small;" href="https://rvssl.com/ssl-certificates/">Resale Manual</a><span style="font-size: small;">!<br /></span><span style="font-size: small;">Doesn\'t matter you have your own server or not, you can join this program. </span><a style="font-size: small;" href="https://rvglobalsoft.com/tickets/new&amp;deptId=3">Contact US Now<br /><br /></a><span style="font-size: small;">If you\'re Host Provider, who owns the hosting company<br /></span><span style="font-size: small;">- </span><a style="font-size: small;" href="http://www.rvsitebuilder.com/">RVSitebuilder</a><span style="font-size: small;">, a site building tool for clients under your control panel.<br /></span><span style="font-size: small;">A license for the every user account under your one physical server!<br /></span><span style="font-size: small;">- </span><a style="font-size: small;" href="http://www.rvskin.com/">RVSkin</a><span style="font-size: small;">, a modern and brandable theme for cPanel skins.<br /></span><span style="font-size: small;">A license for the every user account under your one physical server!<br /></span><span style="font-size: small;">- </span><a style="font-size: small;" href="http://rv2factor.com/">RV2Factor</a><span style="font-size: small;">, the 2-Step verification login for WHM, cPanel, Hostbill, and WordPress.<br /></span><span style="font-size: small;">Secure both your WHM and cPanel with APPs for your users. 30-day free trial Now!<br /></span><span style="font-size: small;">- </span><a style="font-size: small;" href="http://www.rvlogin.technology/">RVLogin</a><span style="font-size: small;">, a Single Sign-on for Server Management<br /></span><span style="font-size: small;">Totally FREE!<br /></span><span style="font-size: small;">- </span><a style="font-size: small;" href="http://www.rvlicense.com/">RVLicenses</a><span style="font-size: small;">, a One-Stop Shop for your server management.<br /></span><span style="font-size: small;">cPanel, ISP manager, CloudLinux, Softaculous, LiteSpeed, and more.<br /><em><strong>Purchase cPanel license today, FREE RVSkin!</strong></em><br /><br /></span><span style="font-size: small;">If you\'re end-user, who owns website but not server, but woyld like to use our products above.&nbsp;<br /></span><span style="font-size: small;">Please contact your Host Provider to ask if they provide those in their service. We\'re sure they have!<br /><br /></span><span style="font-size: small;">Any questions about our products? Please submit a ticket&nbsp;</span><a style="font-size: small;" href="https://rvglobalsoft.com/tickets/new&amp;deptId=5">here</a><span style="font-size: small;">.<br /><br /></span><span style="font-size: small;">Best Regards,<br /></span><span style="font-size: small;">RVGlobalsoft Co.,Ltd.&nbsp;</span></p>
										<div><span style="font-size: small;"><br /></span></div>
									</td>
								</tr>
							</tbody>
							</table>';
				
				@mail($aClient['email'], $subject, $message, $headers);
			
		}
				
    }
	
	
    public function fivedays_no_order(){
            
        $db     = hbm_db();
		$last5days  =   date('Y-m-d', strtotime("-5 days"));
        $result = $db->query("
                                SELECT
                                	c.id , c.companyname , c.phonenumber , c.firstname , c.lastname , ca.email
                                FROM
                                	hb_client_details c , hb_client_access ca
                                WHERE
                                	datecreated = '{$last5days}'
                                	AND c.id = ca.id
                            ")->fetchAll();
		
		foreach($result as $aId){
			
			$result1 = $db->query("
                                SELECT
                                	id
                                FROM
                                	hb_orders
                                WHERE
                                	client_id = '{$aId['id']}'
                            ")->fetchAll();
			
			if(!empty($result1)){
				continue;
			}else{
				       
	            $title          = 'Follow up the new registered client';
	            $linkToOrder    = "Following client " . $aId['id'] ." had registered as a new customer 5 days ago with no new order. 
								   Please motivate the client for some new orders. 
								   Link : https://rvglobalsoft.com/7944web/?cmd=clients&action=show&id=" . $aId['id'];
	            $companyname    = $aId['companyname'];
	            $email          = $aId['email'];
	            $phone          = $aId['phonenumber'];
	            $name			= $aId['firstname'] . ' ' . $aId['lastname'];
	            
	            $pipeLineID = 38;//Opportunities => RV
	            $user_id    = 603306;//Sirishom Potchong
	            
	            $this->pipedriveAPI($user_id,$pipeLineID,$title,$linkToOrder,$companyname,$name,$email,$phone);
				
			}
			
		}
		
    }
    
    public function pipedriveAPI($user_id,$pipeLineID,$title,$linkToOrder,$companyname,$name,$email,$phone){
        
                $api_url    = "https://api.pipedrive.com/v1/";
                $username   = 'pairote@netway.co.th';
                $password   = 'ritik,g0Hf';
                /**
                 * Authorizations Get token
                 */
                $ch = curl_init();
                
                curl_setopt($ch, CURLOPT_URL,"https://api.pipedrive.com/v1/authorizations");
                curl_setopt($ch, CURLOPT_POST, 1);
                
                $dateLogin = array('email'=>$username,
                                   'password'=>$password);
                
                curl_setopt($ch, CURLOPT_POSTFIELDS,http_build_query($dateLogin));
                          
                curl_setopt($ch, CURLOPT_RETURNTRANSFER, true);
                
                $arrOutPut = json_decode(curl_exec ($ch));
                curl_close ($ch);
                $apitoken           = $arrOutPut->data[0]->api_token;
             
                //--------------end Authorizations Get token--------------------------
                
                $addOrganization_url= $api_url."organizations?api_token=".$apitoken;
                $addPerson_url      = $api_url."persons?api_token=".$apitoken;
                $addDeal_url        = $api_url."deals?api_token=".$apitoken;
                $addNoteToDeal_url =  $api_url."notes?api_token=".$apitoken;
                
                $getOrganizations_url = $api_url."organizations/find?term=".$companyname."&start=0&api_token=".$apitoken;
                
                /**
                 * Get Organizations ID or Add Organizations
                 */
                $ch = curl_init();
                
                curl_setopt($ch, CURLOPT_URL,$getOrganizations_url);  
                curl_setopt($ch, CURLOPT_RETURNTRANSFER, 1);
                
                $arrOutPut = json_decode(curl_exec ($ch));
                curl_close ($ch);
                
                $arrOrganizations = $arrOutPut->data;
                
                
                if($arrOrganizations == null){
                    
                    $ch = curl_init();
                
                    curl_setopt($ch, CURLOPT_URL,$addOrganization_url);
                    curl_setopt($ch, CURLOPT_POST, 1);
                    
                    $date = array('name'=>$companyName,
                                  'visible_to'=>'0');
                    
                    curl_setopt($ch, CURLOPT_POSTFIELDS,http_build_query($date));
                              
                    curl_setopt($ch, CURLOPT_RETURNTRANSFER, true);
                    
                    $arrOutPut = json_decode(curl_exec ($ch));
                    curl_close ($ch);
                    $organID = $arrOutPut->data->id;
                }
                else{
                    $organID = $arrOrganizations[0]->id;
                }
                
                /**
                 * Get Person ID or Add Person
                 */
                $getPerson_url = $api_url."persons/find?term=".$name."&org_id=".$organID."&start=0&api_token=".$apitoken;
                $ch = curl_init();
            
                curl_setopt($ch, CURLOPT_URL,$getPerson_url);  
                curl_setopt($ch, CURLOPT_RETURNTRANSFER, 1);
                
                $arrOutPut = json_decode(curl_exec ($ch));
                curl_close ($ch);
                
                $arrPerson = $arrOutPut->data;
                
                if($arrPerson == null){
                    $ch = curl_init();
            
                    curl_setopt($ch, CURLOPT_URL,$addPerson_url);
                    curl_setopt($ch, CURLOPT_POST, 1);
                    
                    $date = array('name'=>$name,
                                  'org_id'=>$organID,
                                  'email'=>$email,
                                  'phone'=>$phone);
                    
                    curl_setopt($ch, CURLOPT_POSTFIELDS,http_build_query($date));
                              
                    curl_setopt($ch, CURLOPT_RETURNTRANSFER, true);
                    
                    $arrOutPut = json_decode(curl_exec ($ch));
                    curl_close ($ch);
                    $personID = $arrOutPut->data->id;
                }
                else{
                    $personID = $arrPerson[0]->id;
                }
                
                /**
                 * Add Deals
                 */
            
                $ch = curl_init();
            
                curl_setopt($ch, CURLOPT_URL,$addDeal_url);
                curl_setopt($ch, CURLOPT_POST, 1);
                
                $date = array('title'=>$title,
                              'currency'=>"THB",
                              'user_id'=>$user_id,
                              'person_id'=>$personID,
                              'org_id'=>$organID,
                              'stage_id'=>$pipeLineID,
                              '87244ecdac1ac8178ade6a9a2a16e5656b4a5fdd'=>"New");
                
                curl_setopt($ch, CURLOPT_POSTFIELDS,http_build_query($date));
                          
                curl_setopt($ch, CURLOPT_RETURNTRANSFER, true);
                
                $arrOutPut = json_decode(curl_exec ($ch));
                curl_close ($ch);
                
                $dealID = $arrOutPut->data->id;
                
                /**
                 * Add note
                 */
                 
                 $ch = curl_init();
            
                curl_setopt($ch, CURLOPT_URL,$addNoteToDeal_url);
                curl_setopt($ch, CURLOPT_POST, 1);
               
                $date = array('content'=>$linkToOrder,
                              'deal_id'=>$dealID);
                
                curl_setopt($ch, CURLOPT_POSTFIELDS,http_build_query($date));
                          
                curl_setopt($ch, CURLOPT_RETURNTRANSFER, true);
                
                curl_exec ($ch);
                curl_close ($ch);
    }

}
