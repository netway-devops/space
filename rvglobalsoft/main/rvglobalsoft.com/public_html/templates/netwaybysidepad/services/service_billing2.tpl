
{if $service.slug=='2-factor-authentication' || $service.slug=='rv2factor'}

    <!-- Start Detail Widget VIP -->
    {php}


        $service = $this->get_template_vars('service');

        if (isset($service['client_id'])) {

            $db = hbm_db();

            $query = sprintf("
                    SELECT
                       *
                    FROM
                        %s
                    WHERE
                        vip_info_id != ''
                    AND
                        usr_id = '%s'
                    ORDER BY
                        vip_info_id DESC
                    "
                    , 'hb_vip_info'
                    , $service['client_id']
            );

            $aRes = $db->query($query)->fetchAll();

            if (is_array($aRes[0]) && count($aRes[0]) > 0) {

                $aRes = $aRes[0];

                $UploadCerUrl = "upload/certificate_file/";
                $vip_view_file = "0";
                if ($aRes["certificate_file_path_p12"] != '') {
                    $vip_view_file = "1";
                    $download_url = $UploadCerUrl . $service['client_id'] . "/" . $aRes["certificate_file_path_p12"];
                }

                // ASSING
                // 1. Account Detail
                $this->assign('ou_number', $aRes["ou_number"]);
                $this->assign('quantity', $aRes["quantity"]);
                $this->assign('quantity_at_symantec', $aRes["quantity_at_symantec"]);

                // 2. Certificate File
                $this->assign('vip_view_file', $vip_view_file);
                $this->assign('certificate_file_path_p12', $aRes["certificate_file_path_p12"]);
                $this->assign('certificate_expire_date_p12', date("d/m/Y" , $aRes["certificate_expire_date_p12"]));

                // Dialog
                //$this->assign('certificate_file_path_p12', $aRes["certificate_file_path_p12"]);
                $this->assign('certificate_file_type_p12', $aRes["certificate_file_type_p12"]);
                $this->assign('certificate_file_size_p12', number_format($aRes["certificate_file_size_p12"], 0));
                $this->assign('date_file_upload_p12', date("d/m/Y" , $aRes["date_file_upload_p12"]));
                $this->assign('date_file_last_upload_p12', date("d/m/Y" , $aRes["date_file_last_upload_p12"]));
                $this->assign('md5sum_p12', $aRes["md5sum_p12"]);
                $this->assign('download_url_cer_p12', $download_url);

            }
        }
    {/php}
    <!-- End Detail Widget VIP -->
{/if}


{if $cid == 1}
{include file='services/ssl_templates/service_edit_contact.tpl'}
{include file='services/ssl_templates/service_alert_box.tpl'}

{if $pageAction == ''}
<div class="table-box1 step0">
	<table width="100%">
	    <tr style="width: 100%">
	        <td width="80%">
	            <h4>{$lang.service} : {$service.name} {$service.cname}</h4>
	            <table class="table table-striped account-details-tb tb-sh">
	                <tr>
	                    <td class="w30">Account ID</td>
	                    <td class="cell-border no-bold">{$service.id}</td>
	                </tr>
	                <tr>
	                    <td class="w30">Account {$lang.status}</td>
	                    <td class="cell-border no-bold">
	                    	<table class="table-striped account-details-tb tb-sh">
	                    		<tr>
	                    			<td style="background-color: white;">
				                   		<span class="label ssl-status-{$service.status}" style="opacity: 0.6">
					                        <font color="white">
					                        	{$service.status}
					                        </font>
				                        </span>
				                        &nbsp;&nbsp; 
				                        {if $service.status == 'Unpaid' || ($service.renewpayment == 'Unpaid')}
				                        <button class="label" id="invoice_payment_button" value="{$service.invoice_id}" onclick="javascript:window.location.href='clientarea/invoice/{$service.invoice_id}/'; return false;"> Pay Now </button>
				                        {elseif $service.status != 'Active' && $service.status != 'Terminated' && $service.status != 'Cancelled' && $service.symantec_status != 'WAITING_SUBMIT_CSR' && $service.symantec_status != 'WAITING_SUBMIT_ORDER'}
                                        <button class="label label-success" onclick='javascript:window.open("https:\/\/digicert.secure.force.com\/chat\/apex\/DigiCert_Legacy_PreChat_Questionnaire?endpoint=https%3A%2F%2F3l6ku.la4-c1-dfw.salesforceliveagent.com","_blank"); return false;'> Chat Now </button>
			                        </td>
			                        <td class="no-bold" style="background-color: white;">
				                        <p style="color: red;">Please click "Chat Now" for contact Brand Authority <br>to get faster process of issuing SSL Certificate.</p>
				                        {/if}
			                        </td>
			                    </tr>
	                        </table>
	                    </td>
	                </tr>
	                {if $service.authority_orderid}
	                <tr>
	                    <td class="w30">{$service.authority_name} Order ID</td>
	                    <td class="cell-border no-bold">{$service.authority_orderid}</td>
	                </tr>
	                {/if}
	                <tr>
	                    <td class="w30">Invoice ID</td>
	                    <td class="cell-border no-bold"><a href="clientarea/invoice/{$service.invoice_id}/" target="_blank">{$service.invoice_id}</a></td>
	                </tr>
	                <tr>
	                    <td class="w30">Certificate Issuing Status</td>
	                    <td class="cell-border no-bold">{if $service.status == 'Unpaid'}Waiting for payment.{else}{$service.symantec_status|showsslstatus:state}{/if}</td>
	                </tr>
	                {if isset($service.order_info.CertificateInfo.CertificateStatus) && $service.order_info.CertificateInfo.CertificateStatus != '' && $service.symantec_status == 'COMPLETED'}
	                <tr>
	                    <td class="w30">Certificate Status</td>
	                    <td class="cell-border no-bold">
	                        <span class="label ssl-status-{if $service.cert_status == 'Active'}Active{elseif $service.cert_status == 'Cancelled' || $service.cert_status == 'Revoked'}Terminated{else}Incomplete{/if}" style="opacity: 0.6"><font color="white">{$service.cert_status}</font></span>
	                    </td>
	                </tr>
	                {/if}
	                {if isset($service.order_info.QuickOrderDetail.ApproverEmailAddress)}
	              
    	                <tr>
    	                    <td class="w30">Email Approval</td>
    	                    <td class="cell-border no-bold" id='aa'>{$service.order_info.QuickOrderDetail.ApproverEmailAddress}
    	                       {if $service.cert_status == 'Pending Reissue' && $service.validationText =='Domain Validation SSL (DV)' && $service.status == 'Active'}
    	                        &nbsp;&nbsp;
    	                     
    	                        <!-- <button id="myMail" style="font-size: 12px;background-color: #f1f1c8;">
    	                           Change Email
    	                      </button> -->
                              
    	                       {/if}
    	                    </td>
    	                </tr>
    	                
        	                <!-- <tr id ="cEmail">
                                <td class="w30">Change Email Approval</td>
                                <td class="cell-border no-bold" >
                                    
                                   <form id="mailApproval" method="post" >
                                   
                                   <input type="email"  id="changeEmail" name="changeEmail" placeholder="New Email Approval" style=" font-size: 12px;height: 22px;"/>
                                   
                                   <p id="authority_orderid" style="display: none">{$service.authority_orderid}</p> 
                                   <p id="order_id" style="display: none">{$service.order_id}</p> 
                                    &nbsp;&nbsp;<button id="SubmitEmail"  style="font-size: 12px;background-color: #205f00;color: #ffff;margin-top: -10px;height: 29px;">
                                       Submit
                                  </button>
                                   &nbsp;&nbsp;<button id="Cancel"  style="font-size: 12px;background-color: #5f0012;color: #ffff;margin-top: -10px;height: 29px;">
                                       Cancel
                                  </button>
                                  </form>
                                </td>
                            </tr> -->
                       
	                {/if}
	                {if $service.showbilling}
	                <tr>
	                    <td class="w30">{$lang.registrationdate}</td>
	                    <td class="cell-border no-bold">{$service.date_created|date_format:'%d %b %Y'}</td>
	                </tr>
	                {/if}
	                {if $service.billingcycle!='Free' && $service.billingcycle!='Once' && $service.billingcycle!='One Time' && $service.total>0}
	                <tr>
	                    <td class="w30">{if $service.billingcycle=='Hourly'}{$lang.curbalance}{else}{$lang.reccuring_amount}{/if}</td>
	                    <td class="cell-border no-bold">{$service.total|price:$currency} {if $service.billingcycle=='Hourly'}({$lang.updatedhourly}){/if}</td>
	                </tr>
	                {/if}
	                {if $service.symantec_status != 'WAITING_SUBMIT_CSR'}
	                <tr>
	                    <td class="w30">Expiration Date</td>
	                    <td class="cell-border no-bold">{if $service.next_due!=0}{$service.next_due|date_format:'%d %b %Y'}{else}-{/if}</td>
	                </tr>
	                {elseif $service.billingcycle!='Free' && $service.billingcycle!='Once' && $service.billingcycle!='One Time' && $service.next_due!='' && $service.next_due!='0000-00-00'}
	                <tr>
	                    <td class="w30">{$lang.nextdue}</td>
	                    <td class="cell-border no-bold">{$service.next_due|date_format:'%d %b %Y'}</td>
	                </tr>
	                {/if}
	                <tr>
	                    <td class="w30">Validation Method</td>
	                    <td class="cell-border no-bold">{$service.validationText}</td>
	                </tr>
	                <tr>
	                    <td class="w30">Total Domain{if $totalDomain > 1}s{/if}</td>
	                    <td class="cell-border no-bold">{$totalDomain}</td>
	                </tr>
	                <tr>
	                    <td class="w30">Total Server{if $service.server_amount > 1}s{/if}</td>
	                    <td class="cell-border no-bold">{if $service.server_amount == 1}Unlimited{else}{$service.server_amount}{/if}</td>
	                </tr>
	                <tr>
	                    <td class="w30">Server Software</td>
	                    <td class="cell-border no-bold">{if $service.server_type == 'IIS'}Microsoft IIS (all versions){else}{$service.server_type}{/if}</td>
	                </tr>
	                {*if $test_mode*}
	                <tr>
	                    <td class="w30">Hashing Algorithm</td>
	                    <td class="cell-border no-bold">{$hashing_data[$service.hashing_algorithm].name}</td>
	                </tr>
	                {*/if*}
	                {/if}
	            </table>
	        </td>
	    </tr>
	</table>
</div>
{include file="services/services_ssl_details_table.tpl"}
{include file='services/ssl_templates/service_submit_csr_later.tpl'}
{include file='services/ssl_templates/service_vertification_call.tpl'}
<div class="resubmit table-box1 step0" style="display: none;">
	<div>
		<span class="editcontact_div">
			<input id="validate_button" style="width: 160px" class="editcontact_button" type="button" value="Edit Contact" onclick="editcontact('{$service.order_id}');">
		</span>
        &nbsp;<input id="validate_button" style="width: 160px" class="changeemail_button" type="button" value="Change Email Approval" onclick="changeemail('{$service.order_id}');">
        &nbsp;<input id="validate_button" style="width: 170px" class="sendemail_button" type="button" value="Resend Validation Email" onclick="sendemail('{$service.order_id}');">
        &nbsp;{if ($service.symantec_status|strstr:'FAILED' && $service.symantec_status != 'PAYMENT_FAILED' && $service.symantec_status != 'AUTHORIZATION_FAILED') || $service.symantec_status == 'DOMAIN_NOT_PREVETTED'}<input id="validate_button" style="width: 160px" class="resubmitcsr_button" type="button" value="Resubmit CSR" onclick="resubmitcsr('{$service.order_id}');">{/if}
    </div>
</div>
{include file='services/ssl_templates/service_change_email_approve.tpl'}
{include file='services/ssl_templates/service_upload_document.tpl'}
{include file="services/service_billing2_ssl.tpl"}
{else}
<p class="bold">{$service.catname} - {$service.name} {$service.cname}
    {if $upgrades && $upgrades!='-1' && $service.slug != 'rv2factor'}
        <small>
            <a href="{$ca_url}clientarea/services/{$service.slug}/{$service.id}/&make=upgrades&upgradetarget=service" class="lmore">
                {$lang.UpgradeDowngrade}
            </a>
        </small>
    {/if}
</p>

<div class="table-box">
    <div class="table-header">
        <p>{$lang.service}</p>
    </div>
    <table class="table table-striped account-details-tb tb-sh">
    	{if $service.domain!=''}
        <tr>
            <td class="w30">{$lang.domain}</td>
            <td class="cell-border no-bold"><a target="_blank" href="http://{$service.domain}">{$service.domain}</a></td>
        </tr>
        {/if}
        <tr>
            <td class="w30">{$lang.status}</td>
            <td class="cell-border no-bold"><span class="label-{$lang[$service.status]}">{$lang[$service.status]}</span></td>
        </tr>
        {if $service.showbilling}
        <tr>
            <td class="w30">{$lang.registrationdate}</td>
            <td class="cell-border no-bold">{$service.date_created|date_format:'%d %b %Y'}</td>
        </tr>
        {if $service.firstpayment!=0 }
        <tr>
            <td class="w30">{$lang.firstpayment_amount}</td>
            <td class="cell-border no-bold">{$service.firstpayment|price:$currency}</td>
        </tr>
        {/if}

        {if $service.billingcycle!='Free' && $service.billingcycle!='Once' && $service.billingcycle!='One Time' && $service.total>0}
        <tr>
            <td class="w30">{if $service.billingcycle=='Hourly'}{$lang.curbalance}{else}{$lang.reccuring_amount}{/if}</td>
            <td class="cell-border no-bold">{$service.total|price:$currency} {if $service.billingcycle=='Hourly'}({$lang.updatedhourly}){/if}</td>
        </tr>
        {/if}

        {if $service.billingcycle!='Free' && $service.billingcycle!='Once' && $service.billingcycle!='One Time' && $service.next_due!='' && $service.next_due!='0000-00-00'}
        <tr>
            <td class="w30">{$lang.nextdue}</td>
            <td class="cell-border no-bold">{$service.next_due|date_format:'%d %b %Y'}</td>
        </tr>
        {/if}
        <tr>
            <td class="w30">{$lang.bcycle}</td>
            <td class="cell-border no-bold">{$lang[$service.billingcycle]}</td>
        </tr>
        {/if}
    </table>
</div>
{/if}
{if $service.slug=='2-factor-authentication' || $service.slug=='rv2factor'}

        <!-- START DEFAULT WIDGET -->
        <br><br>

        <p class="bold">Subscription Symantec™ VIP detail</p>

        <div class="table-box">
            <div class="table-header">
                <p>1. Account Detail</p>
            </div>
            <table class="table table-striped account-details-tb tb-sh">
                <tr>
                    <td class="w30">Organizational Unit Number</td>
                    <td class="cell-border no-bold">{$ou_number}</td>
                </tr>
                <tr>
                    <td class="w30">Purchased Account</td>
                    <td class="cell-border no-bold">{$quantity}</td>
                </tr>
                <tr>
                    <td class="w30">Active Account</td>
                    <td class="cell-border no-bold">{$quantity_at_symantec}</td>
                </tr>
            </table>
        </div>


        <br />

        <div class="table-box">
            <div class="table-header">
                <p>2. Certificate File</p>
            </div>
            <table class="table table-striped account-details-tb tb-sh">
                <tr>
                    <td class="w30">Certificate File</td>
                    <td class="cell-border no-bold">{if $vip_view_file==1}<a href="{$download_url_cer_p12}" target="_blank" class="download">{$certificate_file_path_p12}</a> {/if}</td>
                </tr>
                <tr>
                    <td class="w30">File type</td>
                    <td class="cell-border no-bold">{$certificate_file_type_p12}</td>
                </tr>
                <tr>
                    <td class="w30">File size</td>
                    <td class="cell-border no-bold">{if $vip_view_file==1}{$certificate_file_size_p12} bytes{/if}</td>
                </tr>
                <tr>
                    <td class="w30">File upload date</td>
                    <td class="cell-border no-bold">{$date_file_upload_p12}</td>
                </tr>
                <tr>
                    <td class="w30">File last upload date</td>
                    <td class="cell-border no-bold">{$date_file_last_upload_p12}</td>
                </tr>
                <tr>
                    <td class="w30">md5sum</td>
                    <td class="cell-border no-bold">{$md5sum_p12}</td>
                </tr>
                <tr>
                    <td class="w30">Certificate File Expire Date</td>
                    <td class="cell-border no-bold">{$certificate_expire_date_p12}</td>
                </tr>
            </table>
        </div>


        <br />

<!-- END DEFAULT WIDGET -->
{/if}




{literal}

<script>
$(document).ready(function(){
    
      $("#cEmail").hide();
    $("#myMail").click(function(){
        $("#cEmail").show();
    });
    $("#cancel").click(function(){
        $("#cEmail").show();
    });
    
  //change Email approval  
    $('#SubmitEmail').click(function(){
        var email               = $('#changeEmail').val();    
        var authority_orderid   = $('#authority_orderid').text();  
        var order_id            = $('#order_id').text(); 
        event.preventDefault();
        $.post("?cmd=ssl&action=ChangeEmailApproval", 
        {
            email     : email,
            authority_orderid : authority_orderid,
            order_id  : order_id

        },function( aResponse ) {
            console.log(aResponse.aResponse);
        });
    });  
    
});
</script>
{/literal}
