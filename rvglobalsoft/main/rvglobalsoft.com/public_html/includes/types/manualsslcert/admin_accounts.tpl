{if $layer && $customfile}
	{if $docommand=='getCSR'}
		<tr>
			<td>Server Type</td>
			<td>
				{foreach from=$csr_servers item=server key=pos}
				{if $service.software == $pos}{$server}{/if}
			{/foreach}
            
		</td>
	</tr>
	<tr>
		<td>
			CSR
		</td>
		<td>
			<textarea  style="width:80%;height:100px;font-size:11px;" readonly="readonly" >{$details.csr}</textarea>
		</td>
	</tr>	
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
	{if $details.status=='Pending' || ($details.status=='Active' && ($details.cert_status=='awaiting-approval' || $details.cert_status=='complete' || $details.cert_status=='active'))}
		<div style="margin:10px 0px;">
			<div class="progress_2">
			{if $details.status=='Pending' && ($needsconfig.organization || $needsconfig.contacts || $needsconfig.csr)}
			<strong class="inf">Info:</strong> Certificate needs to be configured by client.
			<ul>
			{if $needsconfig.organization}<li>Missing Organization details</li>{/if}
			{if $needsconfig.contacts}<li>Missing Contacts information</li>{/if}
			{if $needsconfig.csr}<li>Missing CSR</li>{/if}
			</ul>
			{elseif $details.status=='Pending'}
			<strong class="inf">Info:</strong> Certificate is configured and ready to be issued.
			{/if}
			{if $details.status=='Active' && $details.cert_status=='awaiting-approval'}
			<strong class="inf">Info:</strong> Order has been placed, it needs to be approved by certificate supplier.
			{elseif $details.status=='Active' && ($details.cert_status=='completed' || $details.cert_status=='active')}
			<strong class="inf">Info:</strong> Certificate has been issued
			{/if}
			</div>
		</div>
	{/if}

	
	</div>
	<ul class="accor">
		<li><a href="#">Certificate Info</a>
			<div class="sor">
				<table cellspacing="2" cellpadding="3" border="0" width="100%" >
					<tbody>
						<tr >
							<td width="150">SSL Cert Reference</td>
							<td >
								<input name="cert_id" value="{$details.cert_id}" size="5"  class="manumode"
								{if $details.manual != '1'}style="display:none"{/if} />
								<span class="livemode"
								{if $details.manual == '1'}style="display:none"{/if}><strong>{if $details.cert_id}{$details.cert_id}{else}{$lang.none}{/if}</strong>
								</span>
							</td>
						</tr> 
						<tr>
							<td width="150">SSL Order Reference</td>
							<td >
								<input name="cert_oid" value="{$details.cert_oid}" size="5"  
									class="manumode"
								{if $details.manual != '1'}style="display:none"{/if} />
								<span class="livemode"
								{if $details.manual == '1'}style="display:none"{/if}><strong>{if $details.cert_oid}{$details.cert_oid}{else}{$lang.none}{/if}</strong>
								</span>
							</td>
						</tr>
						<tr>
							<td width="150">{$lang.en_certstat}</td>
							<td >
                                <span class="livemode" {if $details.manual == '1'}style="display:none"{/if}>
                                   <strong>{if $details.cert_status!=''}{$details.cert_status}{else}Not Ordered Yet{/if}</strong>
								</span>
                                <input name="cert_status" value="{$details.cert_status}" 
									class="manumode"
								{if $details.manual != '1'}style="display:none"{/if} />
							</td>
						</tr>
						<tr>
							<td width="150">{$lang.en_apprem}</td>
							<td >
								<span >{if $details.cert_email}{$details.cert_email}{else}{$lang.none}{/if}</span>
								<input type="hidden" name="cert_email" value="{$details.cert_email}"/>
							</td>
						</tr>
						<tr>
							<td width="150">{$lang.Expires}</td>
							<td >
								<span class="{if $details.status!='Pending' && $details.status!='Terminated'}livemode{/if}"
								{if $details.status=='Pending' || $details.status=='Terminated'}style="display:none"{/if}>
								{$details.cert_expires|dateformat:$date_format}
							</span>
							<input name="cert_expires" value="{$details.cert_expires|dateformat:$date_format}" size="16"  class="{if $details.status!='Pending' && $details.status!='Terminated'}manumode{/if}"
							{if $details.status!='Pending' && $details.status!='Terminated'}style="display:none"{/if}/>
						</td>
					</tr>
				</tbody>	
				<tbody id="csrbox">
					<tr >
						<td>CSR</td>
						<td ><a href="#" onclick="ajax_update('?cmd=accounts&action=edit&id={$details.id}&edo=getCSR',false,'#csrbox',true);return false;">Show CSR</a></td>
					</tr>
				</tbody>
			</table>
		</div>
	</li>
</ul>
{/if}	