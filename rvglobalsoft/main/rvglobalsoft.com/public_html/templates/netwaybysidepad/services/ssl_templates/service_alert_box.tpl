<div class="table-box1 step0">
	<div class="step0">
	{if $service.status != 'Terminated'}
		{assign var="showAlert" value="0"}
        <div id="ssl-alert-box" style="background-color: pink; padding-bottom:10px; padding-top:20px; display:none;">
       	{if isset($cancelRequest)}
            <p style="margin-left:3%; text-indent:15px;">The revocation of this product is now being in progress. The revocation request was made by you on {$cancelRequest.date} with the following reason.</p>
            <p style="margin-left:3%; text-indent:15px;">"{$cancelRequest.reason}"</p>
            {assign var="showAlert" value="1"}
        {/if}

        {if ($service.phonecall_1 != '' || $service.phonecall_2 != '') && $service.symantec_status == 'RV_WF_AUTHORIZATION'}
        	<p style="margin-left:3%; text-indent:15px;">Your order is almost complete. Its status is "Waiting for Verification Call". Please click here in order to request Verification Call appointment, or contact your host provider with the Order ID specified.</p>
        	<br>
        	<p style="margin-left:5%;">
        		<b>Verification Call 1 :</b> {$service.time_verify_from|date_format:'%d %b %Y'} {$service.time_verify_from|substr:11:5} - {if $service.time_verify_from|substr:0:10 != $service.time_verify_to|substr:0:10}{$service.time_verify_to|date_format:'%d %b %Y'}{/if} {$service.time_verify_to|substr:11:5} {$service.time_zone[2]}
        		<br>
        		<b>Verification Call 2 :</b> {if $service.phonecall_2 != ''}{$service.time_verify_from2|date_format:'%d %b %Y'} {$service.time_verify_from2|substr:11:5} - {if $service.time_verify_from2|substr:0:10 != $service.time_verify_to2|substr:0:10}{$service.time_verify_to2|date_format:'%d %b %Y'}{/if} {$service.time_verify_to2|substr:11:5} {$service.time_zone2[2]}{else} - {/if}
        		<br>
        		<b>Administrative Contact :</b> Mr. {$service.contact.firstname} {$service.contact.lastname}
        		<br>
        		<b>Address :</b> {$service.contact.organization_name} {$service.contact.address} {$service.contact.city} {$service.contact.state} {$service.contact.country} {$service.contact.postal_code}
        		<br>
        		<b>Tel :</b> {if $service.contact.telephone}{$service.contact.telephone}{else} - {/if} Ext. {if $service.contact.ext_number}{$service.contact.ext_number}{else} - {/if}
        	</p>
        	<br>
        	<p style="margin-left:3%; text-indent:15px;">The Brand Authority will call to the telephone number which is the telephone number in publically listed in an approved telephone directory. If the telephone number you provided above is not the telephone number in publically listed in an approved telephone directory, and would like to change, just click on "Edit" button below.</p>
        	<div align="center"><hr style="border-color:black; width:95%;"/></div>
        	{assign var="showAlert" value="1"}
        {/if}

        {if $service.symantec_status|strstr:'APPROVAL'}
        	<p style="margin-left:3%; text-indent:15px;">Your order is almost complete, its status is "{$service.symantec_status|showsslstatus:state}".</p>
        	{assign var="showAlert" value="1"}
        {/if}

        {if $service.symantec_status != 'WAITING_SUBMIT_DOCUMENT' 
            && !$service.symantec_status|strstr:'APPROVAL' 
            && $service.symantec_status != 'AUTHORIZATION_FAILED' 
            && !(($service.phonecall_1 != '' || $service.phonecall_2 != '')  && $service.symantec_status == 'RV_WF_AUTHORIZATION')
            && ($service.symantec_status != 'COMPLETED' || ($service.symantec_status == 'COMPLETED' && $service.cert_status == 'Pending Reissue')) 
            && !$service.allowsubmitcsr }
            
            {if $service.ssl_validation_id != 1 && $service.symantec_status == 'COMPLETED' && $service.cert_status == 'Pending Reissue' }
            {assign var="showAlert" value="1"}
            {/if}
            
        	{if $service.symantec_status == 'WAITING_SUBMIT_ORDER' && $service.status == 'Unpaid'}
        	<p style="margin-left:3%; text-indent:15px;">Your order is almost complete, its status is "Waiting for your payment".</p>
	        {assign var="showAlert" value="1"}
	        {/if}
	        
	        {if $service.ssl_validation_id != 1 
	            && ($service.symantec_status != 'COMPLETED' || ($service.symantec_status == 'COMPLETED' && $service.cert_status == 'Pending Reissue'))
	            && $service.authority_orderid != ''}
        	{assign var="showAlert" value="1"}
        		{if isset($service.order_info.AuthenticationComments)}
                	<h4><u><p style="margin-left:3%; text-indent:15px;">Message about your order</p></u></h4>
                	<br />
                	<div align="center">
                		<table width="95%">
                		{foreach from=$service.order_info.AuthenticationComments item=eachAuth}
                			<tr>
                				<td valign="top" width="200px">{$eachAuth.TimeStamp}</td>
                				<td>{$eachAuth.Message}{if false && preg_match("/(telephone verification call).*(unable to reach)/", $eachAuth.Message)}<button onclick="tosubmitphonecall();" style="background-color: #5c6467; color:#fff; font-size:10px;">Click Here</button>{/if}</td>
                			</tr>
                			<tr>
                				<td colspan="2"><hr style="border-color:black;"/></td>
                			</tr>
                		{/foreach}
                		</table>
                	</div>
        		{/if}
	        <p style="margin-left:3%; text-indent:15px;">
	            If the SSL Certificate Authority asks your documents for validation your 
	            domain and business, please provide your documents by 
	            <button onclick="tosubmit_doc();" style="background-color: #5c6467; color:#fff; font-size:10px;">CLICK HERE</button> 
	           to submit through our secured portal,and it will automatically associate with your certificate order.
	        </p>
	        <p style="margin-left:3%; text-indent:15px;">If the SSL Certificate Authority required telephone 
	            validation and they want to make an appointment for calling. You can make an appointment 
	            with SSL Certificate Authority by 
	            <button onclick="tosubmitphonecall();" style="background-color: #5c6467; color:#fff; font-size:10px;">CLICK HERE</button>.
	        </p>
	        {/if}
        {/if}

        {if $service.allowsubmitcsr}
	        <p style="margin-left:3%; text-indent:15px;">&nbsp Your order is almost complete, its status is "Waiting for CSR". Please <input class="clearstyle btn green-custom-btn l-btn" type="button" onclick="tosubmitCsr();" style="margin-bottom:5px; background:#3285cb; border:1px solid #3285cb; padding: 1px 5px 1px 5px !important;" value="click here"> in order to send CSR now.</p>
	        {assign var="showAlert" value="1"}
	    {/if}
        </div>
        <script type="text/javascript">
			{literal}
			    if("{/literal}{$showAlert}{literal}" == "1"){
				    $("#ssl-alert-box").show();
				}
			{/literal}
		</script>
	{/if}
    </div>
</div>
