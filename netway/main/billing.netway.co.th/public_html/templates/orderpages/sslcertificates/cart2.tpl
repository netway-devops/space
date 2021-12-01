<link media="all" type="text/css" rel="stylesheet" href="{$orderpage_dir}enomssl/tipsy/tipsy.css" />
<script type="text/javascript" src="{$orderpage_dir}enomssl/tipsy/tipsy.js"></script>
<link media="all" type="text/css" rel="stylesheet" href="{$orderpage_dir}enomssl/facebox/facebox.css" />
<script type="text/javascript" src="{$orderpage_dir}enomssl/facebox/facebox.js"></script>
<link media="all" type="text/css" rel="stylesheet" href="{$orderpage_dir}sslcertificates/style.css" />
{include file='sslcertificates/cprogress.tpl'}

{if $logged!='1'}
	<div id="loginform" style="display:none">
		<center>
            <form name="" action="" method="post">
				<table border="0" cellpadding="0" cellspacing="6" width="80%">
					<tr>
						<td align="left" colspan="2">
							<label for="username" class="styled">{$lang.email}</label>
							<input name="username" value="{$submit.username}" class="styled" style="width:96%"/>
						</td>
					</tr>
					<tr>
						<td align="left" colspan="2">
							<label for="password"  class="styled">{$lang.password}</label>
							<input name="password" type="password" class="styled"  style="width:96%"/>
						</td>
					</tr>
					<tr>
						<td align="left"  >
							<a href="{$ca_url}root&amp;action=passreminder" class="list_item" target="_blank">{$lang.passreminder}</a>
						</td>
						<td align="right">
							<input type="hidden" name="action" value="login"/>
							<input type="submit" value="{$lang.login}" class="padded btn" style="font-weight:bold"/>
						</td>
					</tr>
					<tr>
						<td>
						</td>
					</tr>
				</table>
			</form>
		</center>
	</div>
{/if}

<div class="blue-pad">
    <h4>{$lang.step} 3</h4>
    <h3>{$lang.en_contacts}</h3>
</div>
<form id="mform" action="" method="post">
    <div id="celeft">
        {if !$noorg}
            <div class="white-box form-horizontal">
                <h3>{$lang.en_orgdetails}</h3>
                <div class="strike-line"></div>
                <table border="0" cellpadding="0" cellspacing="6" width="100%">
                    <tr>
                        <td width="60%">
                            <table class="checker org-info" width="100%" cellpadding="6" cellspacing="0">
                                <tr>
                                    <td class="first-td"><strong>{$lang.en_orgname}</strong></td>
                                    <td><input name="organization[name]" class="styled tipsing span3" value="{$customdata.organization.name}" title="{$lang.en_tip1}"/></td>
                                </tr>
                                <tr>
                                    <td class="first-td"><strong>{$lang.en_orgunit}</strong></td>
                                    <td><input name="organization[unit]" class="styled tipsing span3" value="{$customdata.organization.unit}" title="{$lang.en_tip2}"/></td>
                                </tr>
                                <tr>
                                    <td class="first-td"><strong>{$lang.address}</strong></td>
                                    <td><input name="organization[address1]" class="styled tipsing span3" value="{$customdata.organization.address1}" title="{$lang.en_tip3}"/></td>
                                </tr>
                                <tr>
                                    <td class="first-td">{$lang.address2}</td>
                                    <td><input name="organization[address2]" class="styled tipsing span3" value="{$customdata.organization.address2}" title="{$lang.en_optional}"/></td>
                                </tr>
                                <tr>
                                    <td class="first-td"><strong>{$lang.city}</strong></td>
                                    <td><input name="organization[locality]" class="styled tipsing span3" value="{$customdata.organization.locality}" title="{$lang.en_tip4}"/></td>
                                </tr>
                                <tr>
                                    <td class="first-td"><strong>{$lang.state}</strong></td>
                                    <td><input name="organization[state]" class="styled tipsing span3" value="{$customdata.organization.state}" title="{$lang.en_tip5}"/></td>
                                </tr>
                                <tr>
                                    <td class="first-td"><strong>{$lang.postcode}</strong></td>
                                    <td><input name="organization[postalcode]" class="styled tipsing span3" value="{$customdata.organization.postalcode}" title="{$lang.en_tip6} "/></td>
                                </tr>
                                <tr>
                                    <td class="first-td"><strong>{$lang.country}</strong></td>
                                    <td><select name="organization[country]" class="tipsing span3" title="{$lang.en_tip6} ">
                                            {foreach from=$countries key=k item=v}
                                                <option value="{$k}" {if $customdata.organization.country==$k} selected="selected"{/if}>{$v}</option>
                                            {/foreach}
                                        </select>
                                    </td>
                                </tr>
                            </table>
                        </td>
                        <td valign="top">
                            {if $approveremails}<div class="greenbox">
                                    <h3>{$lang.en_appemail}</h3><br />
                                    {$lang.en_appemail_desc}<br /><br />
                                    <center>
                                        <select name="approval_email">	

                                            {foreach from=$approveremails item=email}
                                                <option value="{$email}">{$email}</option>
                                            {/foreach}			
                                            {* if $approveremails *}
                                        </select>
                                    </center>
                                </div>
                            {/if}
                        </td>
                    </tr>
                </table>
            </div>
        {else}
            <div class="white-box">
                <h3>{$lang.en_admincontact}</h3>
                <div class="strike-line"></div>
                <table border="0" cellpadding="0" cellspacing="6" width="100%">
                    <tr>
                        <td width="60%">
                            <table class="checker" border="0" cellpadding="3" cellspacing="0" width="100%">
                                <tr>
                                    <td><strong>{$lang.en_jobtitle}</strong></td>
                                    <td><input name="admin[JobTitle]"   class="styled span3" value="{if $customdata.admin.JobTitle}{$customdata.admin.JobTitle}{/if}"/></td>
                                </tr>
                                <tr>
                                    <td><strong>{$lang.firstname}</strong></td>
                                    <td><input name="admin[FName]"  value="{if $customdata.admin.FName}{$customdata.admin.FName}{else}{$clientdata.firstname}{/if}" class="styled span3"/></td>
                                </tr>
                                <tr>
                                    <td><strong>{$lang.lastname}</strong></td>
                                    <td><input name="admin[LName]"  value="{if $customdata.admin.LName}{$customdata.admin.LName}{else}{$clientdata.lastname}{/if}" class="styled span3"/></td>
                                </tr>
                                <tr>
                                    <td><strong>{$lang.address}</strong></td>
                                    <td><input name="admin[Address1]" value="{if $customdata.admin.Address1}{$customdata.admin.Address1}{else}{$clientdata.address1}{/if}" class="styled span3"/></td>
                                </tr>
                                <tr>
                                    <td>{$lang.address2}</td>
                                    <td><input name="admin[Address2]"  value="{if $customdata.admin.Address2}{$customdata.admin.Address2}{else}{$clientdata.address2}{/if}" class="styled span3"/></td>
                                </tr>
                                <tr>
                                    <td><strong>{$lang.city}</strong></td>
                                    <td><input name="admin[City]" value="{if $customdata.admin.City}{$customdata.admin.City}{else}{$clientdata.city}{/if}" class="styled span3"/></td>
                                </tr>
                                <tr>
                                    <td><strong>{$lang.state} / {$lang.postcode}</strong></td>
                                    <td>
                                        <div class="form-inline">
                                            <input class="styled span2" name="admin[State]"  value="{if $customdata.admin.State}{$customdata.admin.State}{else}{$clientdata.state}{/if}" /> / <input class="styled span1" name="admin[PostalCode]"  value="{if $customdata.admin.PostalCode}{$customdata.admin.PostalCode}{else}{$clientdata.postcode}{/if}" size="6"/>
                                            <input type="hidden" name="admin[StateProvinceChoice]" value="S" />
                                        </div>
                                    </td>
                                </tr>
                                <tr>
                                    <td><strong>{$lang.country}</strong></td>
                                    <td><select name="admin[Country]" class="span3">
                                            {foreach from=$countries key=k item=v}
                                                <option value="{$k}" {if $customdata.admin.Country && $customdata.admin.Country==$k}selected="selected"{elseif !$customdata.admin.Country && $clientdata.country==$k}selected="selected"{/if}>{$v}</option>
                                            {/foreach}
                                        </select>
                                    </td>
                                </tr>
                                <tr>
                                    <td><strong>{$lang.email}</strong></td>
                                    <td>
                                        <input  name="admin[EmailAddress]" class="styled span3" value="{if $customdata.admin.EmailAddress}{$customdata.admin.EmailAddress}{else}{$clientdata.email}{/if}"/>
                                    </td>
                                </tr>
                                <tr>
                                    <td><strong>{$lang.phone}</strong></td>
                                    <td class="form-inline">
                                        <input size="2" name="admin[PreFix]" class="styled span1" value="{if $customdata.admin.PreFix}{$customdata.admin.PreFix}{/if}"/> . <input name="admin[Phone]"  value="{if $customdata.admin.Phone}{$customdata.admin.Phone}{else}{$clientdata.phonenumber}{/if}" class="styled span2"/>
                                    </td>
                                </tr>
                                <tr>
                                    <td>Fax</td>
                                    <td class="form-inline">
                                        <input size="2" name="admin[FPreFix]" class="styled span1" value="{if $customdata.admin.FPreFix}{$customdata.admin.FPreFix}{/if}" /> . <input name="admin[Fax]"  value="{if $customdata.admin.Fax}{$customdata.admin.Fax}{/if}" class="styled span2"/>
                                    </td>
                                </tr>
                            </table>
                        <td valign="top">
                            {if $approveremails}<div class="greenbox">
                                    <h3>{$lang.en_appemail}</h3>
                                    {$lang.en_appemail_desc}<br /><br />
                                    <center>
                                        <select name="approval_email">	

                                            {foreach from=$approveremails item=email}
                                                <option value="{$email}">{$email}</option>
                                            {/foreach}			
                                            {* if $approveremails *}
                                        </select>
                                    </center>
                                </div>
                            {/if}
                        </td>
                    </tr>
                </table>
            </div>
        {/if}
        <div class="white-box clearfix">
            <a href="#" class="btn btn-custom btn-custom-inline right" onclick="return step3.submitmform(this)">{$lang.continuetostep} 4 &raquo;</a>
            <div class="step-info">
            {$lang.fboldrequired} {if $logged=='1'}{else}<br />
                <a href="#" onclick="{literal}$.facebox({div:'#loginform'});return false;{/literal}">{$lang.login}</a> {$lang.en_tofill}{/if}
            </div>
        </div>
        <div class="white-box">
            <table border="0" cellpadding="0" cellspacing="0" width="100%" style="margin-top:10px">
                <tr>
                    {if !$noorg }
                        <td width="50%" valign="top" style="padding-right:5px;" >
                            <h3>{$lang.en_admincontact}</h3>
                            <div class="strike-line"></div>
                            <table border="0" cellpadding="3" cellspacing="0" width="100%" class="contacttables">
                                <tr class="lastone">
                                    <td  align="right"><strong>{$lang.en_jobtitle}</strong></td>
                                    <td><input name="admin[JobTitle]"   class="styled span3" value="{if $customdata.admin.JobTitle}{$customdata.admin.JobTitle}{/if}"/></td>
                                </tr>
                                <tr class="lastone">
                                    <td  align="right"><strong>{$lang.firstname}</strong></td>
                                    <td><input name="admin[FName]"  value="{if $customdata.admin.FName}{$customdata.admin.FName}{else}{$clientdata.firstname}{/if}" class="styled span3"/></td>
                                </tr><tr class="lastone">
                                    <td  align="right"><strong>{$lang.lastname}</strong></td>
                                    <td><input name="admin[LName]"  value="{if $customdata.admin.LName}{$customdata.admin.LName}{else}{$clientdata.lastname}{/if}" class="styled span3"/></td>
                                </tr>
                                <tr class="lastone">
                                    <td  align="right"><strong>{$lang.address}</strong></td>
                                    <td><input name="admin[Address1]" value="{if $customdata.admin.Address1}{$customdata.admin.Address1}{else}{$clientdata.address1}{/if}" class="styled span3"/></td>
                                </tr>
                                <tr class="lastone">
                                    <td  align="right">{$lang.address2}</td>
                                    <td><input name="admin[Address2]"  value="{if $customdata.admin.Address2}{$customdata.admin.Address2}{else}{$clientdata.address2}{/if}" class="styled span3"/></td>
                                </tr>
                                <tr class="lastone">
                                    <td  align="right"><strong>{$lang.city}</strong></td>
                                    <td><input name="admin[City]" value="{if $customdata.admin.City}{$customdata.admin.City}{else}{$clientdata.city}{/if}" class="styled span3"/></td>
                                </tr>
                                <tr class="lastone">
                                    <td  align="right"><strong>{$lang.state} / {$lang.postcode}</strong></td>
                                    <td><input name="admin[State]"  value="{if $customdata.admin.State}{$customdata.admin.State}{else}{$clientdata.state}{/if}" class="styled span2"/> / <input name="admin[PostalCode]"  value="{if $customdata.admin.PostalCode}{$customdata.admin.PostalCode}{else}{$clientdata.postcode}{/if}" class="styled span1" size="6"/>
                                        <input type="hidden" name="admin[StateProvinceChoice]" value="S" />
                                    </td>
                                </tr>
                                <tr class="lastone">
                                    <td  align="right"><strong>{$lang.country}</strong></td>
                                    <td><select name="admin[Country]" class="span3">
                                            {foreach from=$countries key=k item=v}
                                                <option value="{$k}" {if $customdata.admin.Country && $customdata.admin.Country==$k}selected="selected"{elseif !$customdata.admin.Country && $clientdata.country==$k}selected="selected"{/if}>{$v}</option>
                                            {/foreach}
                                        </select>
                                    </td>
                                </tr>
                                <tr class="lastone">
                                    <td  align="right"><strong>{$lang.email}</strong></td>
                                    <td>
                                        <input  name="admin[EmailAddress]" class="styled span3" value="{if $customdata.admin.EmailAddress}{$customdata.admin.EmailAddress}{else}{$clientdata.email}{/if}"/>
                                    </td>
                                </tr>
                                <tr class="lastone" >
                                    <td  align="right"><strong>{$lang.phone}</strong></td>
                                    <td class="form-inline">
                                        <input size="2" name="admin[PreFix]" class="styled span1" value="{if $customdata.admin.PreFix}{$customdata.admin.PreFix}{/if}"/> . <input name="admin[Phone]"  value="{if $customdata.admin.Phone}{$customdata.admin.Phone}{else}{$clientdata.phonenumber}{/if}" class="styled span2"/>
                                    </td>
                                </tr>
                                <tr class="lastone">
                                    <td  align="right">Fax</td>
                                    <td class="form-inline">
                                        <input size="2" name="admin[FPreFix]" class="styled span1" value="{if $customdata.admin.FPreFix}{$customdata.admin.FPreFix}{/if}" /> . <input name="admin[Fax]"  value="{if $customdata.admin.Fax}{$customdata.admin.Fax}{/if}" class="styled span2"/>
                                    </td>
                                </tr>
                            </table>
                            </div>
                        </td>
                    {/if}
                    <td style="padding-left:5px;" valign="top">
                        <div id="biltech">
                            <h3>{$lang.en_billtech}</h3>
                            <div class="strike-line"></div>
                        </div>
                        
                        <div id="bcontact" style="display:none;">

                            <h3>{$lang.en_billcontact}</h3>
                            <div class="strike-line"></div>
                            <table border="0" cellpadding="3" cellspacing="0" width="100%" class="contacttables">

                                <tr class="lastone">
                                    <td  align="right"><strong>{$lang.en_jobtitle}</strong></td>
                                    <td><input name="billing[JobTitle]"   class="styled span3" value="{if $customdata.billing.JobTitle}{$customdata.billing.JobTitle}{/if}"/></td>
                                </tr>
                                <tr class="lastone">
                                    <td  align="right"><strong>{$lang.firstname}</strong></td>
                                    <td><input name="billing[FName]"  value="{if $customdata.billing.FName}{$customdata.billing.FName}{else}{$clientdata.firstname}{/if}" class="styled span3"/></td>
                                </tr><tr class="lastone">
                                    <td  align="right"><strong>{$lang.lastname}</strong></td>
                                    <td><input name="billing[LName]"  value="{if $customdata.billing.LName}{$customdata.billing.LName}{else}{$clientdata.lastname}{/if}" class="styled span3"/></td>
                                </tr>
                                <tr class="lastone">
                                    <td  align="right"><strong>{$lang.address}</strong></td>
                                    <td><input name="billing[Address1]" value="{if $customdata.billing.Address1}{$customdata.billing.Address1}{else}{$clientdata.address1}{/if}" class="styled span3"/></td>
                                </tr>
                                <tr class="lastone">
                                    <td  align="right">{$lang.address2}</td>
                                    <td><input name="billing[Address2]"  value="{if $customdata.billing.Address2}{$customdata.billing.Address2}{else}{$clientdata.address2}{/if}" class="styled span3"/></td>
                                </tr>
                                <tr class="lastone">
                                    <td  align="right"><strong>{$lang.city}</strong></td>
                                    <td><input name="billing[City]" value="{if $customdata.billing.City}{$customdata.billing.City}{else}{$clientdata.city}{/if}" class="styled span3"/></td>
                                </tr>
                                <tr class="lastone">
                                    <td  align="right"><strong>{$lang.state} / {$lang.postcode}</strong></td>
                                    <td><input name="billing[State]"  value="{if $customdata.billing.State}{$customdata.billing.State}{else}{$clientdata.state}{/if}" class="styled span2"/> / <input name="billing[PostalCode]"  value="{if $customdata.billing.PostalCode}{$customdata.billing.PostalCode}{else}{$clientdata.postcode}{/if}" class="styled span1" size="6"/>
                                        <input type="hidden" name="billing[StateProvinceChoice]" value="S" />
                                    </td>
                                </tr>

                                <tr class="lastone">
                                    <td  align="right"><strong>{$lang.country}</strong></td>
                                    <td><select name="billing[Country]" class="span3">
                                            {foreach from=$countries key=k item=v}
                                                <option value="{$k}" {if $customdata.billing.Country && $customdata.billing.Country==$k}selected="selected"{elseif !$customdata.billing.Country && $clientdata.country==$k}selected="selected"{/if}>{$v}</option>

                                            {/foreach}
                                        </select></td>
                                </tr>
                                <tr class="lastone">
                                    <td  align="right"><strong>{$lang.email}</strong></td>
                                    <td>
                                        <input  name="billing[EmailAddress]" class="styled span3" value="{if $customdata.billing.EmailAddress}{$customdata.billing.EmailAddress}{else}{$clientdata.email}{/if}"/></td>
                                </tr>
                                <tr class="lastone">
                                    <td  align="right"><strong>{$lang.phone}</strong></td>
                                    <td class="form-inline">
                                        <input size="2" name="billing[PreFix]" class="styled span1" value="{if $customdata.billing.PreFix}{$customdata.billing.PreFix}{/if}"/> . <input name="billing[Phone]"  value="{if $customdata.billing.Phone}{$customdata.billing.Phone}{else}{$clientdata.phonenumber}{/if}" class="styled span2"/></td>
                                </tr>


                                <tr class="lastone">
                                    <td  align="right">Fax</td>
                                    <td class="form-inline">
                                        <input size="2" name="billing[FPreFix]" class="styled span1" value="{if $customdata.billing.FPreFix}{$customdata.billing.FPreFix}{/if}"/> . <input name="billing[Fax]"  value="{if $customdata.billing.Fax}{$customdata.billing.Fax}{/if}" class="styled span2"/></td>
                                </tr>
                            </table>
                            <br />


                            <h3>{$lang.en_techcontact}</h3>
                            <div class="strike-line"></div>
                            <table border="0" cellpadding="3" cellspacing="0" width="100%" class="contacttables">

                                <tr class="lastone">
                                    <td  align="right"><strong>{$lang.en_jobtitle}</strong></td>
                                    <td><input name="tech[JobTitle]"   class="styled span3" value="{if $customdata.tech.JobTitle}{$customdata.tech.JobTitle}{/if}"/></td>
                                </tr>
                                <tr class="lastone">
                                    <td  align="right"><strong>{$lang.firstname}</strong></td>
                                    <td><input name="tech[FName]"  value="{if $customdata.tech.FName}{$customdata.tech.FName}{else}{$clientdata.firstname}{/if}" class="styled span3"/></td>
                                </tr><tr class="lastone">
                                    <td  align="right"><strong>{$lang.lastname}</strong></td>
                                    <td><input name="tech[LName]"  value="{if $customdata.tech.LName}{$customdata.tech.LName}{else}{$clientdata.lastname}{/if}" class="styled span3"/></td>
                                </tr>
                                <tr class="lastone">
                                    <td  align="right"><strong>{$lang.address}</strong></td>
                                    <td><input name="tech[Address1]" value="{if $customdata.tech.Address1}{$customdata.tech.Address1}{else}{$clientdata.address1}{/if}" class="styled span3"/></td>
                                </tr>
                                <tr class="lastone">
                                    <td  align="right">{$lang.address2}</td>
                                    <td><input name="tech[Address2]"  value="{if $customdata.tech.Address2}{$customdata.tech.Address2}{else}{$clientdata.address2}{/if}" class="styled span3"/></td>
                                </tr>
                                <tr class="lastone">
                                    <td  align="right"><strong>{$lang.city}</strong></td>
                                    <td><input name="tech[City]" value="{if $customdata.tech.City}{$customdata.tech.City}{else}{$clientdata.city}{/if}" class="styled span3"/></td>
                                </tr>
                                <tr class="lastone">
                                    <td  align="right"><strong>{$lang.state} / {$lang.postcode}</strong></td>
                                    <td><input name="tech[State]"  value="{if $customdata.tech.State}{$customdata.tech.State}{else}{$clientdata.state}{/if}" class="styled span2"/> / <input name="tech[PostalCode]"  value="{if $customdata.tech.PostalCode}{$customdata.tech.PostalCode}{else}{$clientdata.postcode}{/if}" class="styled span1" size="6"/>
                                        <input type="hidden" name="tech[StateProvinceChoice]" value="S" />
                                    </td>
                                </tr>

                                <tr class="lastone">
                                    <td  align="right"><strong>P$lang.country}</strong></td>
                                    <td><select name="tech[Country]" class="span3">
                                            {foreach from=$countries key=k item=v}
                                                <option value="{$k}" {if $customdata.tech.Country && $customdata.tech.Country==$k}selected="selected"{elseif !$customdata.tech.Country && $clientdata.country==$k}selected="selected"{/if}>{$v}</option>

                                            {/foreach}
                                        </select></td>
                                </tr>
                                <tr class="lastone">
                                    <td  align="right"><strong>{$lang.email}</strong></td>
                                    <td>
                                        <input  name="tech[EmailAddress]" class="styled span3" value="{if $customdata.tech.EmailAddress}{$customdata.tech.EmailAddress}{else}{$clientdata.email}{/if}"/></td>
                                </tr>
                                <tr class="lastone">
                                    <td  align="right"><strong>{$lang.phone}</strong></td>
                                    <td class="form-inline">
                                        <input size="2" name="tech[PreFix]" class="styled span1" value="{if $customdata.tech.PreFix}{$customdata.tech.PreFix}{/if}"/> . <input name="tech[Phone]"  value="{if $customdata.tech.Phone}{$customdata.tech.Phone}{else}{$clientdata.phonenumber}{/if}" class="styled span2"/></td>
                                </tr>


                                <tr class="lastone">
                                    <td  align="right">Fax</td>
                                    <td class="form-inline">
                                        <input size="2" name="tech[FPreFix]" class="styled span1" value="{if $customdata.tech.FPreFix}{$customdata.tech.FPreFix}{/if}" /> . <input name="tech[Fax]"  value="{if $customdata.tech.Fax}{$customdata.tech.Fax}{/if}" class="styled span2"/></td>
                                </tr>
                            </table>
                        </div>
                        <input type="checkbox" value="1" checked="checked" name="useadmin" onclick="step3.sh_els(this)"/> {$lang.en_copybill}
                    </td>
                </tr>
            </table>
        </div>
    </div>
</form>
<div class="clear"></div>
<script type="text/javascript">
    step3.init();
</script>