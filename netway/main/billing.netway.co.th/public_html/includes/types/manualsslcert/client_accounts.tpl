
{if $service.status=='Pending' && (!$service.csr || $service.csr=='') && !$csrvalid && !$nocsr}
	<form action="" method="post" id="cform">
		<div class="wbox" >
			<div class="wbox_header">
				<strong>{$lang.en_confcert}</strong>
			</div>
			<div class="wbox_content">
				<table width="100%" cellspacing="0" cellpadding="0" border="0" class="checker">
					<tr>
						<td style="border:none" colspan="2">{$lang.en_step2intro}</td>
					</tr>
					<tr>
						<td style="min-width:200px;">
							<strong>{$lang.en_servsoft}</strong>
							<br><br>
							<select size="2" style="font-size: 12px;height: 200px;width: 100%;" id="servers_types" name="WebServerType">
								{if $csr_servers}
									{foreach from=$csr_servers item=server key=pos}
										<option {if $csrsoftware == $pos}selected="selected"{/if} value="{$pos}">{$server}</option>
									{/foreach}
								{/if}
							</select>
						</td>
						<td style="min-width:60%">
							<strong>{$lang.en_pastecsr}</strong>
							<br><br>
							<textarea class="styled" style="width:100%;height:200px;" name="CSR">{$csrdata}</textarea>
						</td>
					</tr>
					<tr>
						<td style="border:none" colspan="2" align="center"><input type="submit" value="{$lang.continue}" style="font-weight:bold" class="padded" name="submit"/></td>
					</tr>
				</table>
			</div>
		</div>
	</form>
{/if}{* END MISSING CSR & CONTACS *}

	{*
	SERVICE PENDING, CSR IS VALID
	*}
	{if $service.status=='Pending' && ($service.csr || $csrvalid || $nocsr)}

		<form action="{$ca_url}clientarea&action=services&service={$service.id}" method="post" id="cform">
			<input type="hidden" name="service" value="{$service.id}" />
			<div class="wbox" >
				<div class="wbox_header">
					<strong>{$lang.en_confcert}</strong>
				</div>
				<div class="wbox_content">
					<div id="firstform">
						<table width="100%" cellpadding="3" cellspacing="0" border="0" class="checker table table-striped">
							{* IF PENDING - CSR CAN BE CHANGED*}
							{if !$nocsr}
								<tbody >
									<tr>
										<td align="right" width="160"><strong>{$lang.en_servtype}</strong></td>
										<td colspan="2">
											<select name="WebServerType">
												{foreach from=$csr_servers item=server key=pos}
													<option {if $csrsoftware == $pos || $service.software == $pos}selected="selected"{/if} value="{$pos}">{$server}</option>
												{/foreach}
											</select>
										</td>
									</tr>
									<tr>
										<td align="right" valign="top" >
											<strong>CSR</strong>
										</td>
										<td colspan="2">
											<textarea class="styled" style="width:70%;height:150px;" name="CSR">{if $csrdata}{$csrdata}{else}{$service.csr}{/if}</textarea>
										</td>
									</tr>
								</tbody>
							{/if}
							{* 
							END CSR EDIT BLOCK
							
							APPROVER EMAIL SELECTION 
							*}
							{if !$nocsr}
							<tbody >
								<tr>
									<td valign="top" colspan="3">
										<strong>{$lang.en_appemail}</strong>
									</td>
                                </tr>
                                <tr>
                                    <td  width="150" align="right" colspan="2">{$lang.en_appremailpick}</td>
                                    <td >
                                        <select name="approval_email">	
                                            {if $approveremails}
                                                {foreach from=$approveremails item=email}
                                                    {if $email}
                                                    <option value="{$email}" {if $approval_email==$email || $service.cert_email==$email}selected="selected"{/if}>{$email}</option>
                                                    {/if}
                                                {/foreach}
                                            {/if}
                                        </select>	
                                    </td>
								</tr>
							</tbody>
							{/if}
							{* 
							END APPROVER EMAIL SELECTION
							
							ORGANIZATION CONTACT SETUP
							*}
							{if !$noorg}
							{if (!$service.organization && !$organization.updated) || $editOrg}
								<tbody>
									<tr>
										<td valign="top" colspan="4">
											<strong>{$lang.organizationdetails}</strong>
										</td>
                                       
									</tr>
                                    <tr class="lastone">
                                        <td></td>
                                        <td width="150" align="right"><strong>{$lang.en_orgname}</strong></td>
                                        <td><input name="organization[name]" class="styled tipsing" value="{if $organization.name}{$organization.name}{elseif $service.organization.name}{$service.organization.name}{else}{$csr_data.O}{/if}" title="{$lang.en_tip1|replace:'<br/>':''}"/></td>
                                    </tr>
                                    <tr class="lastone">
                                        <td></td>
                                        <td width="150" align="right"><strong>{$lang.en_orgunit}</strong></td>
                                        <td><input name="organization[unit]" class="styled tipsing" value="{if $organization.unit}{$organization.unit}{elseif $service.organization.unit}{$service.organization.unit}{else}{$csr_data.OU}{/if}" title="{$lang.en_tip2|regex_replace:"/[\r\t\n]/":" "}"/></td>
                                    </tr>
                                    <tr class="lastone">
                                        <td></td>
                                        <td width="150" align="right"><strong>{$lang.address}</strong></td>
                                        <td><input name="organization[address1]" class="styled tipsing" value="{if $organization.address1}{$organization.address1}{elseif $service.organization.address1}{$service.organization.address1}{/if}" title="{$lang.en_tip3|regex_replace:"/[\r\t\n]/":" "}"/></td>
                                    </tr>
                                    <tr class="lastone">
                                        <td></td>
                                        <td width="150" align="right">{$lang.address2}</td>
                                        <td><input name="organization[address2]" class="styled tipsing" value="{if $organization.address2}{$organization.address2}{elseif $service.organization.address2}{$service.organization.address2}{/if}" title="{$lang.en_optional|regex_replace:"/[\r\t\n]/":" "}"/></td>
                                    </tr>
                                    <tr class="lastone">
                                        <td></td>
                                        <td width="150" align="right"><strong>{$lang.city}</strong></td>
                                        <td><input name="organization[locality]" class="styled tipsing" value="{if $organization.locality}{$organization.locality}{elseif $service.organization.locality}{$service.organization.locality}{else}{$csr_data.L}{/if}" title="{$lang.en_tip4|regex_replace:"/[\r\t\n]/":" "}"/></td>
                                    </tr>
                                    <tr class="lastone">
                                        <td></td>
                                        <td width="150" align="right"><strong>{$lang.state}</strong></td>
                                        <td><input name="organization[state]" class="styled tipsing" value="{if $organization.state}{$organization.state}{elseif $service.organization.state}{$service.organization.state}{else}{$csr_data.S}{/if}" title="{$lang.en_tip5|regex_replace:"/[\r\t\n]/":" "}"/></td>
                                    </tr>
                                    <tr class="lastone">
                                        <td></td>
                                        <td width="150" align="right"><strong>{$lang.postcode}</strong></td>
                                        <td><input name="organization[postalcode]" class="styled tipsing" value="{if $organization.postalcode}{$organization.postalcode}{elseif $service.organization.postalcode}{$service.organization.postalcode}{/if}" title="{$lang.en_tip6|regex_replace:"/[\r\t\n]/":" "} "/></td>
                                    </tr>
                                    <tr >
                                        <td></td>
                                        <td width="150" align="right"><strong>{$lang.country}</strong></td>
                                        <td><select name="organization[country]" class=" tipsing" title="{$lang.en_tip6|regex_replace:"/[\r\t\n]/":" "} ">
                                                {foreach from=$countries key=k item=v}
                                                    <option value="{$k}"
                                                            {if $organization.country==$k}selected="selected"
                                                            {elseif $service.organization.country==$k && !$organization.country }selected="selected"
                                                    {elseif !$service.organization.country && !$organization.country && $csr_data.C==$k}selected="selected"{/if}>{$v}</option>
                                            {/foreach}
                                        </select>
                                    </td>
                                </tr>
								
							</tbody>
						{else}
							<tbody>
								<tr>
									<td  valign="top" >
										<strong>{$lang.organizationdetails}</strong>
									</td>
									<td style="text-align: center" colspan="4">
										<a href="{$ca_url}clientarea&action=services&service={$service.id}&edo=editOrg" style="color:red; ">{$lang.edityourorganizationdetails}</a>
									</td>
								</tr>
							</tbody>
						{/if}
						{/if}
						{*
						END ORGANIZATION CONTACT SETUP
						
						ADMIN/BILLING/TECH CONTACTS SETUP
						*}
						{if (!$service.contacts && !$contacts.updated) || $editContacts}
                            {foreach from=$contactType item=iname}
                                <tbody {if $iname == 'billing'}id="bcontact" style="display:none"{elseif $iname == 'tech'}id="tcontact" style="display:none"{/if}>
									<tr >
										<td  valign="top" colspan="3">
											<strong>
												{if $iname == 'admin'}
													{$lang.en_admincontact}
												{elseif $iname == 'billing'}
													{$lang.en_billcontact}
												{elseif $iname == 'tech'}
													{$lang.en_techcontact}
												{/if}
											</strong>
										</td>
                                    </tr>

                                    <tr class="lastone">
                                        <td></td>
                                        <td width="150" align="right">{$lang.company} / {$lang.en_jobtitle}</td>
                                        <td>
                                            <input name="{$iname}[OrgName]"  value="{if $contacts[$iname].OrgName}{$contacts[$iname].OrgName}{elseif $service.contacts[$iname].OrgName}{$service.contacts[$iname].OrgName}{else}{$clientdata.companyname}{/if}" class="styled"/>
                                            / <input name="{$iname}[JobTitle]"   class="styled" value="{if $contacts[$iname].JobTitle}{$contacts[$iname].JobTitle}{elseif $service.contacts[$iname].JobTitle}{$service.contacts[$iname].JobTitle}{/if}"/>
                                        </td>
                                    </tr>
                                    <tr class="lastone">
                                        <td></td>
                                        <td width="150" align="right">{$lang.firstname} / {$lang.lastname}</td>
                                        <td>
                                            <input name="{$iname}[FName]"  value="{if $contacts[$iname].FName}{$contacts[$iname].FName}{elseif $service.contacts[$iname].FName}{$service.contacts[$iname].FName}{else}{$clientdata.firstname}{/if}" class="styled"/>
                                            / <input name="{$iname}[LName]"  value="{if $contacts[$iname].LName}{$contacts[$iname].LName}{elseif $service.contacts[$iname].LName}{$service.contacts[$iname].LName}{else}{$clientdata.lastname}{/if}" class="styled"/>
                                        </td>
                                    </tr>
                                    <tr class="lastone">
                                        <td></td>
                                        <td width="150" align="right">{$lang.address} / {$lang.address2}</td>
                                        <td>
                                            <input name="{$iname}[Address1]"  class="styled span3" value="{if $contacts[$iname].Address1}{$contacts[$iname].Address1}{elseif $service.contacts[$iname].Address1}{$service.contacts[$iname].Address1}{else}{$clientdata.address1}{/if}" />
                                            / <input name="{$iname}[Address2]"  value="{if $contacts[$iname].Address2}{$contacts[$iname].Address2}{elseif $service.contacts[$iname].Address2}{$service.contacts[$iname].Address2}{else}{$clientdata.address2}{/if}" class="styled span3"/>
                                        </td>
                                    </tr>
                                    <tr class="lastone">
                                        <td></td>
                                        <td width="150" align="right">{$lang.city}</td>
                                        <td>
                                            <input name="{$iname}[City]" value="{if $contacts[$iname].City}{$contacts[$iname].City}{elseif $service.contacts[$iname].City}{$service.contacts[$iname].City}{else}{$clientdata.city}{/if}" class="styled"/>
                                        </td>
                                    </tr>
                                    <tr class="lastone">
                                        <td></td>
                                        <td width="150" align="right">{$lang.state} / {$lang.postcode}</td>
                                        <td>
                                            <input name="{$iname}[State]"  value="{if $contacts[$iname].State}{$contacts[$iname].State}{elseif $service.contacts[$iname].State}{$service.contacts[$iname].State}{else}{$clientdata.state}{/if}" class="styled span2"/>
                                            / <input name="{$iname}[PostalCode]"  value="{if $contacts[$iname].PostalCode}{$contacts[$iname].PostalCode}{elseif $service.contacts[$iname].PostalCode}{$service.contacts[$iname].PostalCode}{else}{$clientdata.postcode}{/if}" class="styled span1" size="6"/>
                                            <input type="hidden" name="{$iname}[StateProvinceChoice]" value="S" />
                                        </td>
                                    </tr>

                                    <tr class="lastone">
                                        <td></td>
                                        <td width="150" align="right">{$lang.country}</td>
                                        <td>
                                            <select name="{$iname}[Country]">
                                                {foreach from=$countries key=k item=v}
                                                    <option value="{$k}"
                                                            {if $contacts[$iname].Country && $service.contacts[$iname].Country==$k}selected="selected"
                                                            {elseif !$contacts[$iname].Country && $service.contacts[$iname].Country && $service.contacts[$iname].Country==$k}selected="selected"
                                                    {elseif !$service.contacts[$iname].Country && $clientdata.country==$k}selected="selected"{/if}
                                                    >{$v}
                                                    </option>
                                                {/foreach}
                                            </select>
                                        </td>
                                    </tr>
                                    <tr class="lastone">
                                        <td></td>
                                        <td width="150" align="right">{$lang.email}</td>
                                        <td>
                                            <input  name="{$iname}[EmailAddress]" class="styled" value="{if $contacts[$iname].EmailAddress}{$contacts[$iname].EmailAddress}{elseif $service.contacts[$iname].EmailAddress}{$service.contacts[$iname].EmailAddress}{else}{$clientdata.email}{/if}"/>
                                        </td>
                                    </tr>
                                    <tr class="lastone">
                                        <td></td>
                                        <td width="150" align="right">{$lang.phone}</td>
                                        <td>
                                            + <input size="2" name="{$iname}[PreFix]" class="styled span1" value="{if $contacts[$iname].PreFix}{$contacts[$iname].PreFix}{elseif $service.contacts[$iname].PreFix}{$service.contacts[$iname].PreFix}{else}{/if}"/>.
                                            <input name="{$iname}[Phone]"  value="{if $contacts[$iname].Phone}{$contacts[$iname].Phone}{elseif $service.contacts[$iname].Phone}{$service.contacts[$iname].Phone}{else}{$clientdata.phonenumber}{/if}" class="styled span2"/>
                                        </td>
                                    </tr>
                                    <tr {if $iname == 'admin'}class="lastone"{/if}>
                                        <td></td>
                                        <td width="150" align="right">Fax</td>
                                        <td>
                                            + <input size="2" name="{$iname}[FPreFix]" class="styled span1" value="{if $contacts[$iname].FPreFix}{$contacts[$iname].FPreFix}{elseif $service.contacts[$iname].FPreFix}{$service.contacts[$iname].FPreFix}{else}{/if}"/>.
                                            <input name="{$iname}[Fax]"  value="{if $contacts[$iname].Fax}{$contacts[$iname].Fax}{elseif $service.contacts[$iname].Fax}{$service.contacts[$iname].Fax}{else}{/if}" class="styled span2"/>
                                        </td>
                                    </tr>
                                            
								{if $iname == 'admin'}
									<tr>
                                        <td></td>
										<td align="right" valign="top">
											<input type="checkbox" value="1" checked="checked" name="useadmin" onclick="sh_els(this)"/>
                                            <script type="text/javascript">
                                            {literal}
                                                function sh_els(el) {if($(el).is(':checked')) {$('#bcontact').hide();$('#tcontact').hide();} else {$('#bcontact').show();$('#tcontact').show();}}
                                            {/literal}
                                            </script>
										</td>
										<td>
											{$lang.en_copybill}
										</td>
									</tr>
								{/if}
                            </tbody>
                        {/foreach}
						
					{else}
						<tbody>
							<tr>
								<td align="right" valign="top">
									<strong>{$lang.contactdetails}</strong>
								</td>
								<td style="text-align: center" colspan="4">
									<a href="{$ca_url}clientarea&action=services&service={$service.id}&edo=editContacts" style="color:red; ">{$lang.edityourcontactsdetails}</a>
								</td>
							</tr>
						</tbody>
					{/if}
					{*
					END CONTACTS SETUP
					*}
				</table>
				<input type="submit" value="{$lang.savechanges}" name="submit2" style="font-weight:bold;display: block;margin: 5px auto;" class="padded"/>
			</div>
		</div>
	</div>
	{*
	WBOX TABLE END

	BILLING INFO
	*}
</form>
{/if}
{*
END SERVICE PENDING, CSR IS VALID

SERVICE ACTIVE
*}
<div class="wbox">
    <div class="wbox_header">
        {$lang.billing_info|capitalize} {if $service.status!='Fraud' && $service.status!='Cancelled' && $service.status!='Terminated' }<a  class="fs11 lmore" style="float:right; font-weight:normal" href="{$ca_url}clientarea&action=services&service={$service.id}&cid={$service.category_id}&cancel">{$lang.cancelrequest}</a> {/if}
    </div>
    <div class="wbox_content">
        <table width="100%" cellspacing="0" cellpadding="0" border="0" class="checker table table-striped ">
            {include file=`$typetemplates.clientaccount.billing.service`}
        </table>
    </div>
</div>


