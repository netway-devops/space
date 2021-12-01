<?php

/**
 * 
 * Widget Symantec VIP Subscription Symantec™ VIP detail
 * 
 * http://schlitt.info/opensource/blog/0581_reflecting_private_properties.html
 * 
 */

include_once(APPDIR_MODULES . "Hosting/symantecvip/include/api/class.symantecvip.dao.php");

class widget_symantecvip_subscription extends HostingWidget {

    protected $description = 'This is description of widget that will be displayed in adminarea';
    protected $widgetfullname = "Subscription Symantec™ VIP detail";
    protected $download_cer_path;

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
        
       // $vipData = SymantecvipDao::singleton()->getVIPInfoByID($accountId);
        
        $vipData = SymantecvipDao::singleton()->getVIPInfoByUsrID($clientId);
        
        $this->UploadCerUrl = "upload/certificate_file/";
        
        $exp_date = date("d/m/Y" , $vipData["certificate_expire_date_p12"]);
        
        
        $date_file_upload = date("d/m/Y" , $vipData["date_file_upload_p12"]);
        $date_file_last_upload = date("d/m/Y" , $vipData["date_file_last_upload_p12"]);
        
        $vip_view_file = "0";
        if ($vipData["certificate_file_path_p12"] != '') {
        	$vip_view_file = "1";
        	$download_url = $this->UploadCerUrl . $clientId . "/" . $vipData["certificate_file_path_p12"];
        }
                
        return array(
                               "symantecvip_subscription.tpl", 
                               array(
                                   	'accountId' => $accountId, 
                                   	'serverId' => $serverId,
                                   	'vip_info_type' => $vipData["vip_info_type"],
                                   	'vip_subscription_status' => $vipData["vip_subscription_status"],
                                   	'vip_manage_status' => $vipData["vip_manage_status"],
                                   	'subscription_start_date' => $vipData["subscription_start_date"],
	                               	'subscription_expire_date' => $vipData["subscription_expire_date"],
	                               	'ou_number' => $vipData["ou_number"],
	                               	'quantity' => $vipData["quantity"],
	                              	'quantity_at_symantec' => $vipData["quantity_at_symantec"],
                                   	'certificate_file_path_p12' => $vipData["certificate_file_path_p12"],
                                  	'certificate_expire_date_p12' => $exp_date,
                                  	'vip_view_file' => $vip_view_file,
                               		'certificate_file_type_p12' => $vipData["certificate_file_type_p12"],
                               		'certificate_file_size_p12' => number_format($vipData["certificate_file_size_p12"],0),
                               		'date_file_upload_p12' => $date_file_upload,
                               		'date_file_last_upload_p12' => $date_file_last_upload,
                               		'certificate_download_link' => $download_link,
                                    'md5sum_p12' => $vipData["md5sum_p12"],
                                    'download_url_cer_p12' => $download_url,
 
                               )
                      );
    }


}