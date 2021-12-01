<form action="?cmd=module&module=ssl&action=upload_csr" method="post" enctype="multipart/form-data" id="form_upload_csr" name="form_upload_csr" onsubmit="return false;">
	<input type="file" id="upload_csr" name="upload_csr" style="visibility: hidden; width: 1px; height: 1px" multiple />
	<input name="submit_upload_csr" id="submit_upload_csr" type="submit" style="visibility: hidden;width: 1px; height: 1px"/>
</form>
<form method="post" action="?cmd=module&module=ssl&action=ajax_submitcsr" name="frmMr" id="frmMr" onsubmit="return false;">
    <input type="hidden" id="varidate" name="varidate" value="{$service.ssl_validation_id}" />
    <input type="hidden" id="commonname" name="commonname" value="" />
    <input type="hidden" id="ssl_validation_id" name="ssl_validation_id" value="{$service.ssl_validation_id}" />
    <input type="hidden" id="order_id" name="order_id" value="{$service.order_id}" />
    <input type="hidden" id="ssl_name" name="ssl_name" value="{$service.ssl_name}" />
    <input type="hidden" name="resubmit_csr" id="resubmit_csr" value="" />

    {php}
        $client_info = $_SESSION['AppSettings']['login'];
        unset($client_info['server_time']);
        unset($client_info['group_id']);
        unset($client_info['ip_address']);
        unset($client_info['datecreated']);
        unset($client_info['currency_id']);
        unset($client_info['credit']);
        unset($client_info['lasthost']);
        unset($client_info['last']);
        unset($client_info['language']);
        unset($client_info['status']);
        unset($client_info['s_id']);
        unset($client_info['salt']);
        unset($client_info['HTTP_USER_AGENT']);
        $client_info['address'] = $client_info['address1'];
        if(isset($client_info['address2']) && $client_info['address2'] != ''){
            $client_info['address'] .= ' ' . $client_info['address2'];
        }
        if(isset($client_info['address3']) && $client_info['address3'] != ''){
            $client_info['address'] .= ' ' . $client_info['address3'];
        }
        $this->assign('client_login_info', json_encode($client_info));
     {/php}
    <input type="hidden" id="client_login_info" value='{$client_login_info}' />
    <div class="step1">
       <table class="table table-striped account-details-tb tb-sh" >
            <tr>
                <td>
                	<div class="table-header">
                		<p>Certificate Signing Request (CSR)</p>
                    </div>
                    <br>
                    <div>A Certificate Signing Request or "CSR" is required for SSL Certificate issuance. Please generate CSR on your server and submit in the following box. RSA or ECC-based CSR are acceptable.</div><br>
                    <div><a target="_blank" href="https://rvssl.com/generate-csr/"><u> How to generate CSR?</u></a></div>
                    <br>
                    <div>
                    <input class="clearstyle btn green-custom-btn l-btn" onclick="$('#upload_csr').click();" type="button" value="Upload CSR" style="margin-bottom:5px; background:#3285cb; border:1px solid #3285cb;"/> or Paste one below : </div>
                    <div class="format_textarea"><textarea rows="6" id="csr_data" name="csr_data"></textarea> </div>
                    <div>Server software :
                    <select name="servertype">
                        <option value="Other">Other</option>
                        <option value="IIS">Microsoft IIS (all versions)</option>
                    </select>
                    </div>
                    <div><font color="#c31818">*For best RSA browser compatibility, choose the SHA-256 with RSA and SHA-1 root option.</font></div>
                    <div>
                        Hashing Algorithm : 
                        <select name="hashing" style="width: auto;">
                        {assign var="hashingcount" value="0"}
                        {foreach from=$hashing_data|@array_reverse key=hashingKey item=hashingValue}
                        	{if $hashingValue.visible}<option value="{$hashingKey}"{if !$hashingValue.enable} disabled{elseif $hashingcount == "0"} selected{assign var="hashingcount" value="1"}{/if}>{$hashingValue.name}</option>{/if}
                        {/foreach}
                        </select>
                    </div>
                    <br>
                    <div style="text-indent: 10px;">
                    
                    </div>
                    <br>
                    <div id="csr_errorblock" class="message" style="display: none; background-color:#EEE:"></div>
                    <div>
                    <input id="validate_button" type="button" onclick="window.location.reload();" value="Back" /><input class="validate_button" id="validate_button" type="button" value="Continue" >
                    </div>
                    <div id="progressBar" style="display: none"><div></div><p></p></div>
                </td>
            </tr>
        </table>
    </div>
    <div class="step2">
        <div class="table-header">
        	<p>Certificate Signing Request (CSR)</p>
        </div>
        <div class="title" style="margin:13px 0 10px 26px;">CSR:Information</div>
        <div class="CSRinformation2">
        	<p style="padding-left:10px; text-indent:20px;">
        		The Common Name field should be the Fully Qualified Domain Name (FQDN) or the Web address for which you plan to use your Certificate, e.g. the area of your site you wish customers to connect to using SSL. For example, an SSL Certificate issued for example-name.com will not be valid for www.example-name.com or for secure.example-name.com. If the Web address to be used for SSL is www.example-name.com, ensure that the common name submitted in the CSR is www.example-name.com; similarly, if the Web address to be used for SSL is secure.example-name.com, ensure that the common name submitted in the CSR is secure.example-name.com.
        	</p>
        	<p style="padding-left:10px; text-indent:20px;">
        		If you want your domain name to be secured with SSL Certificate for both with and without "www". The CSR will need to be generated with "www" in the Common Name.
        	</p>
        	{if $supportSan}
        	{if $sanFirst > 1}
        	<p style="padding-left:10px; text-indent:20px;">
        		{$service.name} can include up to {$sanFirst-1} additional domain names in one certificate. These domain names are included in the certificate subject alternative name field and will be processed by browsers just like the common name. The second and third level domains can be different and internal host names / machine names are accepted as well.
        	</p>
        	{/if}
        	<p style="padding-left:10px; text-indent:20px;">
        	{if $service.ssl_id == 44}
        		<b>Important</b> : The top and second level domains must be the same for each value in the SAN field.
        	{else}
        		<b>Important</b> : All fully qualified domains should be registered to the same organization.
        	{/if}
        	</p>
        	{if false}
        	<p style="padding-left:10px; text-indent:20px;">
        		<b>Warning</b> : If you proceed with the enrollment without specifying additional domains you will be not be able to add additional domains on reissue of the certificate.
        	</p>
        	{/if}
        	<hr />
        	{/if}
        	<table border="0">
        		<tr>
        			<td width="160px"><b>Common Name</b></td>
        			<td>: <span id="csr_commonname" style="padding-left:10px;"></span></td>
        		</tr>
        		<tr>
        			<td width="160px"><b>Organization</b></td>
        			<td>: <span id="csr_organization" style="padding-left:10px;"></span></td>
        		</tr>
        		<tr>
        			<td width="160px"><b>Organization Unit</b></td>
        			<td>: <span id="csr_organization_unit" style="padding-left:10px;"></span></td>
        		</tr>
        		<tr>
        			<td width="160px"><b>Location</b></td>
        			<td>: <span id="csr_location" style="padding-left:10px;"></span></td>
        		</tr>
                <tr>
                	<td width="160px"><b>State</b></td>
                	<td>: <span id="csr_state" style="padding-left:10px;"></span></td>
                </tr>
                <tr>
                	<td width="160px"><b>Country</b></td>
                	<td>: <span id="csr_country" style="padding-left:10px;"></span></td>
                </tr>
                <tr>
                	<td width="160px"><b>Key Algorithm</b></td>
                	<td>: <span id="csr_key_algorithm" style="padding-left:10px;"></span></td>
                </tr>
                <tr>
                	<td width="160px"><b>Signature Algorithm</b></td>
                	<td>: <span id="csr_signature_algorithm" style="padding-left:10px;"></span></td>
                </tr>
                {if $supportSan}
                {php}
                	$sanAmount = $this->get_template_vars('sanAmount');
                	$sanFirst = $this->get_template_vars('sanFirst');
                	$service = $this->get_template_vars('service');
                	$pCode = $service['ssl_productcode'];
                	$sanCommonName = ($pCode == 'QuickSSLPremium') ? '<span class="sanCommonName"></span>' : '';

                	$sanFirst--;
                	$idCount = 1;
                	for($i = 1; $i <= $sanFirst; $i++){
                		echo '
                        <tr>
                            <td width="160px"><span id="textdnsName_' . $idCount . '"><b>Included Domain ' . $i;
                            if($sanAmount > 0 || $i == 1){
                                echo '<font color="red">*</font>';
                            }
                            echo '
                            </b></span></td>
                            <td>: <input name="dnsName[]" id="dnsName_' . $idCount++ . '" style="padding-left:10px;" />' . $sanCommonName . '</td>
                        </tr>
                        	';
                        }
                        for($j = 1; $j <= $sanAmount; $j++){
                            echo '
                        <tr>
                            <td width="160px"><span id="textdnsName_' . $idCount . '"><b>Additional Domain ' . $j . '<font color="red">*</font></b></span></td>
                            <td>: <input name="dnsName[]" id="dnsName_' . $idCount++ . '" style="padding-left:10px;" />' . $sanCommonName . '</td>
                        </tr>
';
                        }
                {/php}
                {/if}
            </table>
        </div>
    </div>
    <div class="step3">
    	<div class="title" style="margin:13px 0 10px 26px; {if $service.hide_email}display:none;{/if}">E-mail Approval:<font color="#FF0000">*</font></div>
    	<div class="emailApproval" {if $service.hide_email}style="display:none;"{/if}>
	    	<div style="margin-top:-30px; {if $service.hide_email}display:none;{/if}">
	    		<font>
	    			<hr><p style="padding-left: 15px; margin: -10px 0 -10px 0;">
	    				&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;The Email Verification will be sent to the "Email Approval" you specified here. Please don't miss to click the Owner Verification to confirm yourself on the email. If you don't feel convenience to verify by E-mail Approval, you can choose 2 alternative ways:
<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;1.HTTP Verification Method  
<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;2.DNS Record Approval 
<br>By contacting to <a href="https://www.digicert.com/security-certificate-support/#Contact" target="_blank">https://www.digicert.com/security-certificate-support/#Contact</a>, if the order processing is completed.
	    			</p><hr>
	    		</font>
	    	</div>
	    	<div style="padding-left:5px; {if $service.hide_email}display:none;{/if}"><div class="divCell" id="whois_emailinfo"></div></div>
    	</div>
    	<div class="clear"></div>
	    {if $service.ssl_validation_id != 1 || $service.ssl_id == 1}
	    <div class="organizeInfo" style="width: 87%; height: 100%; padding-top: 20px;">
	    	<div class="title" style="margin:13px 0 0 26px;">Organization Information :</div>
	    	<div class="contact_detail" style="width: 87%; height: 100%; padding-top: 20px;">
		    	<div style="text-indent: 10px;">The information entered below about your company will appear in your certificate. Some of the information was obtained from the CSR you submitted. You may edit this information, but make sure this information matches what you want to appear in the certificate. Delays in approving your request may result if the information does not match what is listed in the Articles of Incorporation for your company, which has been recorded and maintained in official third-party databases.</div>
		    	<hr>
		    	<div>Organization Name:<font color="red">*</font></div>
		    	<div><input type="text" id="o_name" name="organize[name]" class="txtContact" style="width: 40%"/></div>
		    	<div>Phone Number:<font color="red">*</font></div>
		    	<div><input type="text" id="o_phone" name="organize[phone]" class="txtContact" style="width: 40%"/></div>
		    	<div>Address:<font color="red">*</font></div>
		    	<div><input type="text" id="o_address" name="organize[address]" class="txtContact" style="width: 40%"/></div>
		    	<div>City:<font color="red">*</font></div>
		    	<div><input type="text" id="o_city" name="organize[city]" class="txtContact" style="width: 40%"/></div>
		    	<div>State/Province:<font color="red">*</font></div>
		    	<div><input type="text" id="o_state" name="organize[state]" class="txtContact" style="width: 40%"/></div>
		    	<div>Country:<font color="red">*</font></div>
		    	<div>
		    		<select id="o_country" name="organize[country]" class="txtContact" style="width: 40%;">
		    		{foreach from=$service.country_list item=langData}
		    			<option value="{$langData.code}">{$langData.name}</option>
		    		{/foreach}
		    		</select>
		    	</div>
		    	<div>Postal Code:<font color="red">*</font></div>
		    	<div><input type="text" id="o_postcode" name="organize[postcode]" class="txtContact" style="width: 40%"/></div>
	    	</div>
	    </div>
	    {/if}

	    <div class="clear"></div>
	    <table width="95%">
	    	<tr>
	    		<td valign="top">
	    			<div class="title" style="margin:13px 0 0 26px;">Administrative Contact:</div>
	    			<div id="adminContactDiv" class="contact_detail" style="width: 87%; height: 100%; padding-top: 20px;">
		    			<div>The administrative contact is the primary contact and will be contacted to assist in resolution of any questions about the order.</div>
		    			<div>Administrative person will be also used for Verification "Callbacks", that will be made for all Business/Extended Validation certificates. No callbacks will be made for Domain Validation Certificates.</div>
		    			<hr />
		    			<div id="admin_error_div" style="display:none; border:1px solid grey; padding:3px; background:#ECECEC; margin-bottom:10px;">
		    				<span><font id="admin_error_text" color="red"></font><span>
		    			</div>
		    			<div>First name:<font color="red">*</font></div>
		    			<div><input type="text" id="txt_name" name="admin[firstname]" class="txtContact" style="width: 100%"/></div>
		    			<div>Last name:<font color="red">*</font></div>
		    			<div><input type="text" id="txt_lastname" name="admin[lastname]" class="txtContact" style="width: 100%"/></div>
		    			<div>Email Address:<font color="red">*</font></div>
		    			<div><input type="text" id="txt_email" name="admin[email]" class="txtContact" style="width: 100%"/></div>
		    			{if $service.is_symantec}
		    			<div>Organization Name:<font color="red">*</font></div>
		    			<div><input type="text" id="txt_org" name="admin[organize]" class="txtContact" style="width: 100%"/></div>
		    			{/if}
		    			<div>Job Title:<font color="red">*</font></div>
		    			<div><input type="text" id="txt_job" name="admin[job]" class="txtContact" style="width: 100%"/></div>
		    			{if $service.is_symantec}
		    			<div>Address:<font color="red">*</font></div>
		    			<div><textarea name="admin[address]" id="txt_address" style="width: 100%"></textarea></div>
		    			<div>City:<font color="red">*</font></div>
		    			<div><input type="text" id="txt_city" name="admin[city]" class="txtContact" style="width: 100%"/></div>
		    			<div>State/Region:<font color="red">*</font></div>
		    			<div><input type="text" id="txt_state" name="admin[state]" class="txtContact" style="width: 100%"/></div>
		    			<div>Country:<font color="red">*</font></div>
		    			<div>
			    			<select name="admin[country]" id="txt_country" style="width: 100%">
			    			{foreach from=$service.country_list item=langData}
			    				<option value="{$langData.code}">{$langData.name}</option>
			    			{/foreach}
			    			</select>
		    			</div>
		    			<div>Postal Code:<font color="red">*</font></div>
		    			<div><input type="text" id="txt_post" name="admin[postcode]" class="txtContact" style="width: 100%"/></div>
		    			{/if}
		    			<div>Phone Number:<font color="red">*</font></div>
		    			<div><input type="text" id="txt_tel" name="admin[phone]" class="txtContact" style="width: 100%"/></div>
		    			<div>Ext Number:</div>
		    			<div><input type="text" id="txt_ext" name="admin[ext]" class="txtContact" style="width: 100%"/></div>
		    		</div>
		    	</td>
		    	<td valign="top">
		    		<div class="title" style="margin:13px 0 0 26px;">Technical Contact Details:</div>
		    		<div id="techContactDiv" class="contact_detail" style="width: 87%; height: 100%; padding-top:39px; padding-bottom:0px;">
		    			The Technical contact will receive the certificate and generally be the individual to install the certificate on the web server. Technical contact will also receive renewal notices.
		    			<br />
		    			<select id="techInfoType" style="width:85%;">
		    				<option value="sameAdmin">Same as administrative contact</option>
		    				<option value="sameBilling" selected>Same as billing contact</option>
		    				<option value="sameTech">Same as technical contact from whois</option>
		    			</select>
		    			<hr />
		    			<div class="not_same_address" style="display: none">
		    				<div id="tech_error_div" style="display:none; border:1px solid grey; padding:3px; background:#ECECEC; margin-bottom:10px;">
		    					<span><font id="tech_error_text" color="red"></font><span>
		    				</div>
		    				<div>First name:<font color="red">*</font></div>
		    				<div><input type="text" id="txt_name_1" name="tech[firstname]" class="txtContact" style="width: 100%"/></div>
		    				<div>Last name:<font color="red">*</font></div>
		    				<div><input type="text" id="txt_lastname_1" name="tech[lastname]" class="txtContact" style="width: 100%"/></div>
		    				<div>Email Address:<font color="red">*</font></div>
		    				<div><input type="text" id="txt_email_1" name="tech[email]" class="txtContact" style="width: 100%"/></div>
		    				{if $service.is_symantec}
		    				<div>Oraganization Name:<font color="red">*</font></div>
		    				<div><input type="text" id="txt_org_1" name="tech[organize]" class="txtContact" style="width: 100%"/></div>
		    				{/if}
		    				<div>Job Title:<font color="red">*</font></div>
		    				<div><input type="text" id="txt_job_1" name="tech[job]" class="txtContact" style="width: 100%"/></div>
		    				{if $service.is_symantec}
		    				<div>Address:<font color="red">*</font></div>
		    				<div><textarea name="tech[address]" id="txt_address_1" style="width: 100%"></textarea></div>
		    				<div>City:<font color="red">*</font></div>
		    				<div><input type="text" id="txt_city_1" name="tech[city]" class="txtContact" style="width: 100%"/></div>
		    				<div>State/Region:<font color="red">*</font></div>
		    				<div><input type="text" id="txt_state_1" name="tech[state]" class="txtContact" style="width: 100%"/></div>
		    				<div>Country:<font color="red">*</font></div>
		    				<div>
		    					<select name="tech[country]" id="txt_country_1" style="width: 100%">
		    					{foreach from=$service.country_list item=langData}
		    						<option value="{$langData.code}">{$langData.name}</option>
		    					{/foreach}
		    					</select>
		    				</div>
		    				<div>Postal Code:<font color="red">*</font></div>
		    				<div><input type="text" id="txt_post_1" name="tech[postcode]" class="txtContact" style="width: 100%"/></div>
		    				{/if}
		    				<div>Phone Number:<font color="red">*</font></div>
		    				<div><input type="text" id="txt_tel_1" name="tech[phone]" class="txtContact" style="width: 100%"/></div>
		    				<div>Ext Number:</div>
		    				<div><input type="text" id="txt_ext_1" name="tech[ext]" class="txtContact" style="width: 100%"/></div>
		    			</div>
		    		</div>
		    	</td>
		    </tr>
		</table>
		<div  style="margin-left: 30px;">
			<br><br>
			<div id="loadingImg" style="display:none;"><img src="{$template_dir}img/ajax-loading.gif" style="width:40%; height:15px;"/></div>
		    <input id="validate_button" class="back_on_step2" type="button" value="Back" style="display: none;"><input type="submit" value="Submit" id="validate_button"  class="order_button" style="display: none">
		</div>
	</div>
</form>