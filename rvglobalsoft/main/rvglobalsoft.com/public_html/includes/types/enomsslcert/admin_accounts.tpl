{if $layer && $customfile}
{if $enomdo=='getSSL'}
{if !$sslcert}
Certificate is not available
{else}
<textarea  style="width:80%;height:150px;font-size:11px;" readonly="readonly" >{$sslcert}</textarea>
{/if}
{elseif $enomdo=='getCSR'}
<table width="100%" cellspacing="0" cellpadding="3" border="0" class="checker">
	<tr>
		<td align="right" width="100">Server Type</td>
		<td>
		{if $sslweb.type}{$sslweb.type}{else}-{/if}
		</td>
		</tr>
	<tr class="lastone">
		<td align="right">
			CSR
		</td>
		<td>
		<textarea  style="width:80%;height:100px;font-size:11px;" readonly="readonly" >{$sslweb.csr}</textarea>
		</td>
	</tr>	
	</table>	
{/if}
{else}
<style type="text/css">
{literal}
	.progress_1 {
	background:#f0f0f0;padding:10px 15px;
	}
	.progress_1 div.p {
		float: left;
		margin-right:15px;
		color:#c4bdbc;
	}
	.progress_1 div.act, .progress_1 div.p.act {
		font-weight:bold;
		color:#0162a0;
	}
	.progress_1 div.done, .progress_1 div.p.done {
		
		color:#727272;
	}
	.progress_2 {
		padding:5px 15px;
		background:#f7f7f7;
		color:#565656;
	}
	.alert, .progress_2.alert {		
		background:#FFFBCC;
		color:#FF6600;
	}
	.progress_2 .inf {
		color:#0162a0;
	}
	.alert .inf, .progress_2.alert .inf {
		color:red;
	}
{/literal}
</style>
<div style="margin:10px 0px;">
	<div class="progress_1">
		<div class="p {if $details.status=='Pending'}act{else}done{/if}">1. Create order</div>
		<div class="p {if $details.cert_status=='Awaiting Configuration'}act{elseif $details.status=='Active'}done{else}{/if}">2. Configuration required</div>
		<div class="p {if $details.cert_status=='Processing'}act{elseif $details.cert_status=='Certificate Issued'}done{else}{/if}">3. Processing order</div>
		<div class="p {if $details.cert_status=='Certificate Issued'}act{else}{/if}">4. Certificate issued</div>		
		<div class="clear"></div>
	</div>
	<div class="progress_2 {if $details.cert_status=='Awaiting Configuration' && $details.cert_id==''}alert{/if}">
	{if $details.cert_status=='Awaiting Configuration' && $details.cert_id==''}
		<strong class="inf">Error:</strong> Order has been placed in enom, but certificate ID is unknown, please synchronize or  enter certificate ID  from enom backend below.
	{elseif $details.status=='Pending'}
		<strong class="inf">Info:</strong> If you've <a href="?cmd=services&action=product&id={$details.product_id}" target="_blank">set auto-create On</a>, order will be placed in enom automatically after receiving payment from client. 
		If you wish to do it manually use "Create" button.
	{elseif  $details.cert_status=='Awaiting Configuration'}
		<strong class="inf">Info:</strong> Order has been placed in enom, certificate now needs to be configured by client.
	 {elseif $details.cert_status=='Processing'}
	 	<strong class="inf">Info:</strong> Certificate is being processed, approval email will be send to {$details.cert_email}
		{elseif $details.cert_status=='Certificate Issued'}
		<strong class="inf">Info:</strong> Certificate has been issued, approval email was sent to {$details.cert_email}
	{/if}

	
	</div>

</div>

<ul class="accor">
				<li><a href="#">{$lang.en_certifno}</a>
				<div class="sor">

				<table cellspacing="2" cellpadding="3" border="0" width="100%" >
      <tbody>


		<tr >
          <td width="150">{$lang.en_certid}</td>
          <td >
		  
<input name="cert_id" value="{$details.cert_id}" size="5"  class="{if $details.status!='Pending' && $details.status!='Terminated' && $details.cert_id!=''}manumode{/if}"
{if $details.status!='Pending' && $details.status!='Terminated' && $details.cert_id!=''}style="display:none"{/if}/>

	<span class="{if $details.status!='Pending' && $details.status!='Terminated' && $details.cert_id!=''}livemode{/if}"
{if $details.status=='Pending' || $details.status=='Terminated' || $details.cert_id==''}style="display:none"{/if}><strong>{$details.cert_id}</strong></span></td>

		  </tr>

		  <tr>
          <td width="150">{$lang.en_certstat}</td>
          <td >
		        
	 <span >{if $details.cert_status!=''}{$details.cert_status}{else}Not Ordered Yet{/if}</span>
         <input type="hidden" name="cert_status" value="{$details.cert_status}"/>
		 
		 {if $details.status!='Pending'}
		 	<input type="submit" name="edo" value="Synchronize" onclick="$('body').addLoader();"/>
		 {/if}
</td>

		  </tr>
		  
		    <tr>
          <td width="150">{$lang.en_apprem}</td>
          <td >
		        
	 <span >{$details.cert_email}</span>
         <input type="hidden" name="cert_email" value="{$details.cert_email}"/><input type="hidden" name="cert_oid" value="{$details.cert_oid}"/>
</td>

		  </tr>
		  <tr>
          <td width="150">{$lang.Expires}</td>
          <td >
		        
	 <span class="{if $details.status!='Pending' && $details.status!='Terminated'}livemode{/if}"
{if $details.status=='Pending' || $details.status=='Terminated'}style="display:none"{/if}>{$details.cert_expires|dateformat:$date_format}</span>

	 
        <input name="cert_expires" value="{$details.cert_expires|dateformat:$date_format}" size="16"  class="{if $details.status!='Pending' && $details.status!='Terminated'}manumode{/if}"
{if $details.status!='Pending' && $details.status!='Terminated'}style="display:none"{/if}/>
</td>

		  </tr>
	<tr>
		<td>CSR</td>
		<td id="csrbox"><a href="#" onclick="ajax_update('?cmd=accounts&action=edit&id={$details.id}&edo=getCSR',false,'#csrbox',true);return false;">Show CSR</a></td>
	</tr>
	<tr>
		<td>Certicate</td>
		<td id="sslbox"><a href="#" onclick="ajax_update('?cmd=accounts&action=edit&id={$details.id}&edo=getSSL',false,'#sslbox',true);return false;">Show Certificate</a></td>
	</tr>
</tbody></table></div></li>

</ul>
{/if}