
{if $customfile && $layer}
    {if $enomdo=='configure' && $csrinfo}
        <input type="hidden" name="edo" value="sendmail" />
        <input type="hidden" name="csr[CSROrganization]" value="{$csrinfo.Organization}" />
        <input type="hidden" name="csr[CSRAddress1]" value="{$csrinfo.Locality} {$csrinfo.State} {$csrinfo.Country}" />
        <input type="hidden" name="csr[CSRLocality]" value="{$csrinfo.Locality}" />
        <input type="hidden" name="csr[CSRPostalCode]" value="{$clientdata.postcode}" />
        <input type="hidden" name="csr[CSROrganizationUnit]" value="{$csrinfo.OrganizationUnit}" />
        <input type="hidden" name="csr[CSRStateProvince]" value="{$csrinfo.State}" />
        <input type="hidden" name="csr[CSRCountry]" value="{$csrinfo.Country}" />


        <h3>{$lang.en_appremailpick}</h3>
        {$lang.en_appemdesc}<br />
        <br />

        <table width="100%" cellspacing="0" cellpadding="0" border="0" class="checker table table-bordered">
            <tr>
                <td  align="right" width="160">
                    <strong>{$lang.domain}</strong>
                </td>
                <td>{$csrinfo.DomainName}</td>
            </tr>
            <tr class="lastone"
                <td align="right" width="160"><strong>{$lang.en_appemail}</strong></td>
                <td>
                    <select name="csr[ApproverEmail]">
                        {foreach from=$csrinfo.Approvers item=mail}
                            <option>{$mail}</option>
                        {/foreach}
                    </select>
                </td>
                <td></td>
            </tr>	
        </table>
        <br /><br />

        <center>
            <input type="submit" value="{$lang.en_sends}" class="padded btn btn-success" style="font-weight:bold" onclick="$(this).parent().addLoader();"/> 
            &nbsp;{$lang.or}&nbsp;
            <a href="?cmd=clientarea&action=services&cid={$cid}" class="btn btn" >{$lang.cancel}</a>
        </center>

    {elseif $enomdo=='getCertificate' && $sslcert}
        <textarea  style="width:80%;height:150px;font-size:11px;" readonly="readonly" >{$sslcert}</textarea>
    {elseif $enomdo=='getWebDetails' && $sslweb}
        <table width="100%" cellspacing="0" cellpadding="0" border="0" class="checker table">
            <tr>
                <td align="right" width="160">{$lang.en_servtype}</td>
                <td>
                    {$sslweb.type}
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
    {elseif $enomdo=='getContacts' && $sslcontact}
        <table width="100%" cellspacing="0" cellpadding="0" border="0" class="checker table">
            <tr>
                <td align="right" width="160">{$lang.en_admincontact}</td>
                <td>

                    {$sslcontact.Admin.OrgName}	<br/>
                    {$sslcontact.Admin.FName}	{$sslcontact.Admin.LName}<br/>
                    {$sslcontact.Admin.Address1}	{$sslcontact.Admin.Address2}<br/>
                    {$sslcontact.Admin.City}	{$sslcontact.Admin.StateProvince} {$sslcontact.Admin.PostalCode}	<br/>	
                    {$sslcontact.Admin.Country}	<br/>
                    {$sslcontact.Admin.Phone} ext. 	{$sslcontact.Admin.PhoneExt}<br/>
                    {$sslcontact.Admin.Fax}	<br/>
                    {$sslcontact.Admin.EmailAddress}	
                </td>
            </tr>
            <tr>
                <td align="right" width="160">{$lang.en_billcontact}</td>
                <td>
                    {$sslcontact.Admin.OrgName}	<br/>
                    {$sslcontact.Billing.FName}	{$sslcontact.Billing.LName}<br/>
                    {$sslcontact.Billing.Address1}	{$sslcontact.Billing.Address2}<br/>
                    {$sslcontact.Billing.City}	{$sslcontact.Billing.StateProvince} {$sslcontact.Billing.PostalCode}	<br/>	
                    {$sslcontact.Billing.Country}	<br/>
                    {$sslcontact.Billing.Phone} ext. 	{$sslcontact.Billing.PhoneExt}<br/>
                    {$sslcontact.Billing.Fax}	<br/>
                    {$sslcontact.Billing.EmailAddress}	

                </td>
            </tr>
            <tr class="lastone">
                <td align="right" width="160">{$lang.en_techcontact}</td>
                <td>
                    {$sslcontact.Tech.OrgName}	<br/>
                    {$sslcontact.Tech.FName}	{$sslcontact.Tech.LName}<br/>
                    {$sslcontact.Tech.Address1}	{$sslcontact.Tech.Address2}<br/>
                    {$sslcontact.Tech.City}	{$sslcontact.Tech.StateProvince} {$sslcontact.Tech.PostalCode}	<br/>	
                    {$sslcontact.Tech.Country}	<br/>
                    {$sslcontact.Tech.Phone} ext. 	{$sslcontact.Tech.PhoneExt}<br/>
                    {$sslcontact.Tech.Fax}	<br/>
                    {$sslcontact.Tech.EmailAddress}	

                </td>
            </tr>

        </table>		
    {/if}
{else}
    {if $reissue}
        <div style="border:#b2d5e6 solid 1px;padding:10px;background:#e5f1f7;margin-bottom:10px;">
            If you have lost your certificate, need to move servers or had a problem with the installation then it may be possible to reissue your certificate providing the common name remains exactly the same. SSL reissue means your certificate will be replaced with new one.<br /><br />

            {if $service.cert_type=='GeoTrust' || $service.cert_type=='RapidSSL'}	
                Reissue for Geotrust certificates like RapidSSL, RapidSSL Wildcard, QuickSSL, QuickSSL Premium, True BusinessID with EV certificates can be processed by Geotrust directly<br/><br/>
                <center><a href="https://products.geotrust.com/geocenter/reissuance/reissue.do" target="_blank"><strong>How to reissue certificate?</strong></a> <a href="?cmd=clientarea&action=service&service={$service.id}">{$lang.Cancel}</a>	</center>
            {elseif $service.cert_type=='VeriSign'}
                You are able to request a one time free re-issuance of a VeriSign branded certificate up to 30 days following the issuance of your certificate. If the certificate is older than 30 days then you can still request a re-issue however VeriSign will charge you $100 per re-issuance. <br/><br/>
                <center><a href="https://products.verisign.com/geocenter/reissuance/reissue.do" target="_blank"><strong>How to reissue certificate?</strong></a> <a href="?cmd=clientarea&action=service&service={$service.id}">{$lang.Cancel}</a>	</center>
            {elseif $service.cert_type=='SBS'}
                When you receive your SBS Secure Certificate, you should burn a copy on CD-ROM or keep a backup copy in a safe location. If you do lose your certificate, you can contact Secure Business Services customer service to resolve the issue to get a new certificate.<br/><br/>
                <center><a href="http://www.securebusinessservices.com/help/faq-ssl-secure-certificate.asp#7" target="_blank"><strong>How to reissue certificate?</strong></a> <a href="?cmd=clientarea&action=service&service={$service.id}">{$lang.Cancel}</a>	</center>
            {/if}


        </div>
    {/if}

    {if $service.status=='Active' && ($service.cert_status=='' || $service.cert_status=='Awaiting Configuration' || $service.cert_status=='Rejected by Customer') && $service.cert_id!=''}
        <form action="" method="post" id="cform">
            <input type="hidden" name="service" value="{$service.id}" />
            <div class="wbox" >
                <div class="wbox_header">
                    <strong>{$lang.en_confcert}</strong>
                </div>
                <div class="wbox_content">
                    <div id="firstform">
                        <table width="100%" cellspacing="0" cellpadding="0" border="0" class="checker table">
                            <tr>
                                <td align="right" width="160"><strong>{$lang.en_servtype}</strong></td>
                                <td>
                                    <select name="WebServerType">
                                        {if $service.cert_type!='SBS'}
                                            <option value="1" {if $service.software=='1'}selected="selected"{/if}>Apache + MOD SSL</option>
                                            <option value="2" {if $service.software=='2'}selected="selected"{/if}>Apache + Raven</option>
                                            <option value="3" {if $service.software=='3'}selected="selected"{/if}>Apache + SSLeay</option>
                                            <option value="4" {if $service.software=='4'}selected="selected"{/if}>C2Net Stronghold</option>
                                            <option value="24" {if $service.software=='24'}selected="selected"{/if}>Cpanel</option>
                                            <option value="25" {if $service.software=='25'}selected="selected"{/if}>Ensim</option>
                                            <option value="26" {if $service.software=='26'}selected="selected"{/if}>Hsphere</option>
                                            <option value="27" {if $service.software=='27'}selected="selected"{/if}>Ipswitch</option>
                                            <option value="28" {if $service.software=='28'}selected="selected"{/if}>Plesk</option>
                                            <option value="7" {if $service.software=='7'}selected="selected"{/if}>IBM HTTP</option>
                                            <option value="8" {if $service.software=='8'}selected="selected"{/if}>iPlanet Server 4.1</option>
                                            <option value="9" {if $service.software=='9'}selected="selected"{/if}>Lotus Domino Go 4.6.2.51</option>
                                            <option value="10" {if $service.software=='10'}selected="selected"{/if}>Lotus Domino Go 4.6.2.6+</option>
                                            <option value="11" {if $service.software=='11'}selected="selected"{/if}>Lotus Domino 4.6+</option>
                                            <option value="12" {if $service.software=='12'}selected="selected"{/if}>Microsoft IIS 4.0</option>
                                            <option value="13" {if $service.software=='13'}selected="selected"{/if}>Microsoft IIS 5.0</option>
                                            <option value="14" {if $service.software=='14'}selected="selected"{/if}>Netscape Enterprise/FastTrack</option>
                                            <option value="17" {if $service.software=='17'}selected="selected"{/if}>Zeus v3+</option>
                                            <option value="18" {if $service.software=='18'}selected="selected"{/if}>Other</option>
                                            <option value="20" {if $service.software=='20'}selected="selected"{/if}>Apache + OpenSSL</option>
                                            <option value="21" {if $service.software=='21'}selected="selected"{/if}>Apache 2</option>
                                            <option value="22" {if $service.software=='22'}selected="selected"{/if}>Apache + ApacheSSL</option>
                                            <option value="23" {if $service.software=='23'}selected="selected"{/if}>Cobalt Series</option>
                                            <option value="29" {if $service.software=='29'}selected="selected"{/if}>Jakart-Tomcat</option>
                                            <option value="30" {if $service.software=='30'}selected="selected"{/if}>WebLogic (all versions)</option>
                                            <option value="31" {if $service.software=='31'}selected="selected"{/if}>O’Reilly WebSite Professional</option>
                                            <option value="32" {if $service.software=='32'}selected="selected"{/if}>WebStar</option>
                                            <option value="33" {if $service.software=='33'}selected="selected"{/if}>Microsoft IIS 6.0</option>
                                        {else}
                                            <option value="1000" >Other</option>
                                            <option value="1001">AOL</option>
                                            <option value="1002">Apache/ModSSL</option>
                                            <option value="1003">Apache-SSL (Ben-SSL, not Stronghold)</option>
                                            <option value="1029">Ensim</option>
                                            <option value="1030">Plesk</option>
                                            <option value="1031">WHM/cPanel</option>
                                            <option value="1032">H-Sphere</option>
                                            <option value="1004">C2Net Stronghold</option>
                                            <option value="1005">Cobalt Raq</option>
                                            <option value="1006">Covalent Server Software</option>
                                            <option value="1007">IBM HTTP Server</option>
                                            <option value="1008">IBM Internet Connection Server</option>
                                            <option value="1009">iPlanet</option>
                                            <option value="1010">Java Web Server (Javasoft / Sun)</option>
                                            <option value="1011">Lotus Domino</option>
                                            <option value="1012">Lotus Domino Go!</option>
                                            <option value="1013">Microsoft IIS 1.x to 4.x</option>
                                            <option value="1014">Microsoft IIS 5.x and later</option>
                                            <option value="1015">Netscape Enterprise Server</option>
                                            <option value="1016">Netscape FastTrack</option>
                                            <option value="1017">Novell Web Server</option>
                                            <option value="1018">Oracle</option>
                                            <option value="1019">Quid Pro Quo</option>
                                            <option value="1020">R3 SSL Server</option>
                                            <option value="1021">Raven SSL</option>
                                            <option value="1022">RedHat Linux</option>
                                            <option value="1023">SAP Web Application Server</option>
                                            <option value="1024">Tomcat</option>
                                            <option value="1025">Website Professional</option>
                                            <option value="1026">WebStar 4.x and later</option>
                                            <option value="1027">WebTen (from Tenon)</option>
                                            <option value="1028">Zeus Web Server</option>
                                        </select>
                                    {/if}
                                </td>
                            </tr>
                            <tr>
                                <td align="right" valign="top">
                                    <strong>CSR</strong>
                                </td>
                                <td>
                                    <textarea class="styled" style="width:70%;height:150px;" name="CSR">{$service.csr}</textarea>
                                </td>
                            </tr>
                            <tr>
                                <td align="right" valign="top">
                                    <strong>{$lang.en_admincontact}</strong>
                                </td>
                                <td>
                                    <table border="0" cellpadding="3" cellspacing="0" width="100%">
                                        <tr class="lastone">
                                            <td width="150" align="right">{$lang.company} / {$lang.en_jobtitle}</td>
                                            <td><input name="admin[OrgName]"  value="{if $service.contacts.admin.OrgName}{$service.contacts.admin.OrgName}{else}{$clientdata.companyname}{/if}" class="styled"/>  / <input name="admin[JobTitle]"   class="styled" value="{if $service.contacts.admin.JobTitle}{$service.contacts.admin.JobTitle}{/if}"/></td>
                                        </tr>
                                        <tr class="lastone">
                                            <td width="150" align="right">{$lang.firstname} / {$lang.lastname}</td>
                                            <td><input name="admin[FName]"  value="{if $service.contacts.admin.FName}{$service.contacts.admin.FName}{else}{$clientdata.firstname}{/if}" class="styled"/> / <input name="admin[LName]"  value="{if $service.contacts.admin.LName}{$service.contacts.admin.LName}{else}{$clientdata.lastname}{/if}" class="styled"/></td>
                                        </tr>
                                        <tr class="lastone">
                                            <td width="150" align="right">{$lang.address} / {$lang.address2}</td>
                                            <td><input name="admin[Address1]"  class="styled" value="{if $service.contacts.admin.Address1}{$service.contacts.admin.Address1}{else}{$clientdata.address1}{/if}" /> / <input name="admin[Address2]"  value="{if $service.contacts.admin.Address2}{$service.contacts.admin.Address2}{else}{$clientdata.address2}{/if}" class="styled"/></td>
                                        </tr>
                                        <tr class="lastone">
                                            <td width="150" align="right">{$lang.city}</td>
                                            <td><input name="admin[City]" value="{if $service.contacts.admin.City}{$service.contacts.admin.City}{else}{$clientdata.city}{/if}" class="styled"/></td>
                                        </tr>
                                        <tr class="lastone">
                                            <td width="150" align="right">{$lang.state} / {$lang.postcode}</td>
                                            <td><input name="admin[State]"  value="{if $service.contacts.admin.State}{$service.contacts.admin.State}{else}{$clientdata.state}{/if}" class="styled"/> / <input name="admin[PostalCode]"  value="{if $service.contacts.admin.PostalCode}{$service.contacts.admin.PostalCode}{else}{$clientdata.postcode}{/if}" class="styled" size="6"/>
                                                <input type="hidden" name="admin[StateProvinceChoice]" value="S" />
                                            </td>
                                        </tr>
                                        <tr class="lastone">
                                            <td width="150" align="right">{$lang.country}</td>
                                            <td><select name="admin[Country]">
                                                    {foreach from=$countries key=k item=v}
                                                        <option value="{$k}" {if $service.contacts.admin.Country && $service.contacts.admin.Country==$k}selected="selected"{elseif !$service.contacts.admin.Country && $clientdata.country==$k}selected="selected"{/if}>{$v}</option>
                                                    {/foreach}
                                                </select>
                                            </td>
                                        </tr>
                                        <tr class="lastone">
                                            <td width="150" align="right">{$lang.email}</td>
                                            <td>
                                                <input  name="admin[EmailAddress]" class="styled" value="{if $service.contacts.admin.EmailAddress}{$service.contacts.admin.EmailAddress}{else}{$clientdata.email}{/if}"/>
                                            </td>
                                        </tr>
                                        <tr class="lastone">
                                            <td width="150" align="right">{$lang.phone}</td>
                                            <td>
                                                + <input size="2" name="admin[PreFix]" class="styled span1" value="{if $service.contacts.admin.PreFix}{$service.contacts.admin.PreFix}{else}{/if}"/> . <input name="admin[Phone]"  value="{if $service.contacts.admin.Phone}{$service.contacts.admin.Phone}{else}{$clientdata.phonenumber}{/if}" class="styled"/>
                                            </td>
                                        </tr>


                                        <tr class="lastone">
                                            <td width="150" align="right">Fax</td>
                                            <td>
                                                + <input size="2" name="admin[FPreFix]" class="styled span1" value="{if $service.contacts.admin.FPreFix}{$service.contacts.admin.FPreFix}{else}{/if}"/> . <input name="admin[Fax]"  value="{if $service.contacts.admin.Fax}{$service.contacts.admin.Fax}{else}{/if}" class="styled"/>
                                            </td>
                                        </tr>
                                    </table>
                                </td>
                            </tr>
                            <tr>
                                <td align="right" valign="top">
                                    <input type="checkbox" value="1" checked="checked" name="useadmin" onclick="sh_els(this)"/>
                                </td>
                                <td>
                                    {$lang.en_copybill}
                                </td>
                            </tr>
                            <tr id="bcontact" style="display:none">
                                <td align="right" valign="top">
                                    <strong>{$lang.en_billcontact}</strong>
                                </td>
                                <td>
                                    <table border="0" cellpadding="3" cellspacing="0" width="100%">
                                        <tr class="lastone">
                                            <td width="150" align="right">{$lang.company} / {$lang.en_jobtitle}</td>
                                            <td><input name="billing[OrgName]"  value="{if $service.contacts.billing.OrgName}{$service.contacts.billing.OrgName}{else}{$clientdata.companyname}{/if}" class="styled"/>  / <input name="billing[JobTitle]"   class="styled" value="{if $service.contacts.billing.JobTitle}{$service.contacts.billing.JobTitle}{/if}"/></td>
                                        </tr>
                                        <tr class="lastone">
                                            <td width="150" align="right">{$lang.firstname} / {$lang.lastname}</td>
                                            <td><input name="billing[FName]"  value="{if $service.contacts.billing.FName}{$service.contacts.billing.FName}{else}{$clientdata.firstname}{/if}" class="styled"/> / <input name="billing[LName]"  value="{if $service.contacts.billing.LName}{$service.contacts.billing.LName}{else}{$clientdata.lastname}{/if}" class="styled"/></td>
                                        </tr>
                                        <tr class="lastone">
                                            <td width="150" align="right">{$lang.address} / {$lang.address2}</td>
                                            <td><input name="billing[Address1]"  class="styled" value="{if $service.contacts.billing.Address1}{$service.contacts.billing.Address1}{else}{$clientdata.address1}{/if}" /> / <input name="billing[Address2]"  value="{if $service.contacts.billing.Address2}{$service.contacts.billing.Address2}{else}{$clientdata.address2}{/if}" class="styled"/></td>
                                        </tr>
                                        <tr class="lastone">
                                            <td width="150" align="right">{$lang.city}</td>
                                            <td><input name="billing[City]" value="{if $service.contacts.billing.City}{$service.contacts.billing.City}{else}{$clientdata.city}{/if}" class="styled"/></td>
                                        </tr>
                                        <tr class="lastone">
                                            <td width="150" align="right">{$lang.state} / {$lang.postcode}</td>
                                            <td><input name="billing[State]"  value="{if $service.contacts.billing.State}{$service.contacts.billing.State}{else}{$clientdata.state}{/if}" class="styled"/> / <input name="billing[PostalCode]"  value="{if $service.contacts.billing.PostalCode}{$service.contacts.billing.PostalCode}{else}{$clientdata.postcode}{/if}" class="styled" size="6"/>
                                                <input type="hidden" name="billing[StateProvinceChoice]" value="S" />
                                            </td>
                                        </tr>
                                        <tr class="lastone">
                                            <td width="150" align="right">{$lang.country}</td>
                                            <td>
                                                <select name="billing[Country]">
                                                    {foreach from=$countries key=k item=v}
                                                        <option value="{$k}" {if $service.contacts.billing.Country && $service.contacts.billing.Country==$k}selected="selected"{elseif !$service.contacts.billing.Country && $clientdata.country==$k}selected="selected"{/if}>{$v}</option>

                                                    {/foreach}
                                                </select>
                                            </td>
                                        </tr>
                                        <tr class="lastone">
                                            <td width="150" align="right">{$lang.email}</td>
                                            <td>
                                                <input  name="billing[EmailAddress]" class="styled" value="{if $service.contacts.billing.EmailAddress}{$service.contacts.billing.EmailAddress}{else}{$clientdata.email}{/if}"/></td>
                                        </tr>
                                        <tr class="lastone">
                                            <td width="150" align="right">{$lang.phone}</td>
                                            <td>
                                                + <input size="2" name="billing[PreFix]" class="styled span1" value="{if $service.contacts.billing.PreFix}{$service.contacts.billing.PreFix}{else}{/if}"/> . <input name="billing[Phone]"  value="{if $service.contacts.billing.Phone}{$service.contacts.billing.Phone}{else}{$clientdata.phonenumber}{/if}" class="styled"/>
                                            </td>
                                        </tr>


                                        <tr class="lastone">
                                            <td width="150" align="right">Fax</td>
                                            <td>
                                                + <input size="2" name="billing[FPreFix]" class="styled span1" value="{if $service.contacts.billing.FPreFix}{$service.contacts.billing.FPreFix}{else}{/if}"/> . <input name="billing[Fax]"  value="{if $service.contacts.billing.Fax}{$service.contacts.billing.Fax}{else}{/if}" class="styled"/>
                                            </td>
                                        </tr>
                                    </table>

                                </td>
                            </tr>
                            <tr  id="tcontact" style="display:none">

                                <td align="right" valign="top">
                                    <strong>{$lang.en_techcontact}</strong>
                                </td>
                                <td>

                                    <table border="0" cellpadding="3" cellspacing="0" width="100%">
                                        <tr class="lastone">
                                            <td width="150" align="right">{$lang.company} / {$lang.en_jobtitle}</td>
                                            <td><input name="tech[OrgName]"  value="{if $service.contacts.tech.OrgName}{$service.contacts.tech.OrgName}{else}{$clientdata.companyname}{/if}" class="styled"/>  / <input name="tech[JobTitle]"   class="styled" value="{if $service.contacts.tech.JobTitle}{$service.contacts.tech.JobTitle}{/if}"/></td>
                                        </tr>
                                        <tr class="lastone">
                                            <td width="150" align="right">{$lang.firstname} / {$lang.lastname}</td>
                                            <td><input name="tech[FName]"  value="{if $service.contacts.tech.FName}{$service.contacts.tech.FName}{else}{$clientdata.firstname}{/if}" class="styled"/> / <input name="tech[LName]"  value="{if $service.contacts.tech.LName}{$service.contacts.tech.LName}{else}{$clientdata.lastname}{/if}" class="styled"/></td>
                                        </tr>
                                        <tr class="lastone">
                                            <td width="150" align="right">{$lang.address} / {$lang.address2}</td>
                                            <td><input name="tech[Address1]"  class="styled" value="{if $service.contacts.tech.Address1}{$service.contacts.tech.Address1}{else}{$clientdata.address1}{/if}" /> / <input name="tech[Address2]"  value="{if $service.contacts.tech.Address2}{$service.contacts.tech.Address2}{else}{$clientdata.address2}{/if}" class="styled"/></td>
                                        </tr>
                                        <tr class="lastone">
                                            <td width="150" align="right">{$lang.city}</td>
                                            <td><input name="tech[City]" value="{if $service.contacts.tech.City}{$service.contacts.tech.City}{else}{$clientdata.city}{/if}" class="styled"/></td>
                                        </tr>
                                        <tr class="lastone">
                                            <td width="150" align="right">{$lang.state} / {$lang.postcode}</td>
                                            <td><input name="tech[State]"  value="{if $service.contacts.tech.State}{$service.contacts.tech.State}{else}{$clientdata.state}{/if}" class="styled"/> / <input name="tech[PostalCode]"  value="{if $service.contacts.tech.PostalCode}{$service.contacts.tech.PostalCode}{else}{$clientdata.postcode}{/if}" class="styled" size="6"/>
                                                <input type="hidden" name="tech[StateProvinceChoice]" value="S" />
                                            </td>
                                        </tr>
                                        <tr class="lastone">
                                            <td width="150" align="right">{$lang.country}</td>
                                            <td>
                                                <select name="tech[Country]">
                                                    {foreach from=$countries key=k item=v}
                                                        <option value="{$k}" {if $service.contacts.tech.Country && $service.contacts.tech.Country==$k}selected="selected"{elseif !$service.contacts.tech.Country && $clientdata.country==$k}selected="selected"{/if}>{$v}</option>

                                                    {/foreach}
                                                </select>
                                            </td>
                                        </tr>
                                        <tr class="lastone">
                                            <td width="150" align="right">{$lang.email}</td>
                                            <td>
                                                <input  name="tech[EmailAddress]" class="styled" value="{if $service.contacts.tech.EmailAddress}{$service.contacts.tech.EmailAddress}{else}{$clientdata.email}{/if}"/></td>
                                        </tr>
                                        <tr class="lastone">
                                            <td width="150" align="right">{$lang.phone}</td>
                                            <td>
                                                + <input size="2" name="tech[PreFix]" class="styled span1" value="{if $service.contacts.tech.PreFix}{$service.contacts.tech.PreFix}{else}{/if}"/> . <input name="tech[Phone]"  value="{if $service.contacts.tech.Phone}{$service.contacts.tech.Phone}{else}{$clientdata.phonenumber}{/if}" class="styled"/>
                                            </td>
                                        </tr>


                                        <tr class="lastone">
                                            <td width="150" align="right">Fax</td>
                                            <td>
                                                + <input size="2" name="tech[FPreFix]" class="styled span1" value="{if $service.contacts.tech.FPreFix}{$service.contacts.tech.FPreFix}{else}{/if}"/> . <input name="tech[Fax]"  value="{if $service.contacts.tech.Fax}{$service.contacts.tech.Fax}{else}{/if}" class="styled"/>
                                            </td>
                                        </tr>
                                    </table>

                                </td>
                            </tr>
                        </table>
                        <div style="padding:10px;text-align:center">
                            <input type="submit" value="{$lang.continue}" style="font-weight:bold" class="padded btn btn-success" onclick="return cform(this)"/>
                        </div>
                    </div>
                    <div id="nextform"></div>
                </div>
            </div>
        </form>

        <script type="text/javascript">
            {literal}
	
				function cform(ed)  {
				$(ed).parent().addLoader();
                    $('#errors span').remove();
                    $('#errors').hide();
                    var params = {layer:true, edo:'configure'};
                    $.each($('#cform').serializeArray(), function(i){
                        params[this.name] = this.value;
                    });
					 $.post('?cmd=clientarea&action=services', params , function(data){        
						var resp = parse_response(data);
						if (!resp) {            
							return false;
						}			 else {
							$('#nextform').hide().html(resp);
							$('#firstform').fadeOut('fast',function(){
							$('#nextform').fadeIn();
							});
						}	
											  
					});
					return false;
				}
				function sh_els(el) {
					if($(el).is(':checked')) {
						$('#bcontact').hide();
						$('#tcontact').hide();
					} else {
					$('#bcontact').show();
						$('#tcontact').show();
					}
				}
            {/literal}
        </script>
    {elseif $service.cert_id!=''  && ($service.cert_status=='Certificate Issued' || $service.cert_status=='Processing' || $service.cert_status=='Expired')}
        <link media="all" type="text/css" rel="stylesheet" href="includes/types/enomsslcert/assets/tipsy.css" />
        <script type="text/javascript" src="includes/types/enomsslcert/assets/tipsy.js"></script>
        {literal}
            <script type="text/javascript">
            $(document).ready(function(){
                $('.tipsing').tipsy({gravity: 'w',html:true});
            });
            </script>
        {/literal}
        <form action="" method="post">
            <div class="wbox" >
                <div class="wbox_header">
                    {$lang.en_sscertdetails}
                </div>
                <div class="wbox_content">
                    <table width="100%" cellspacing="0" cellpadding="0" border="0" class="checker table">
                        <tr>
                            <td align="right" width="160">
                                {$lang.type}
                            </td>
                            <td>
                                {$service.name}
                            </td>
                        </tr>

                        <tr>
                            <td align="right">{$lang.status}</td>
                            <td>{$service.cert_status} {if $service.cert_status=='Processing'}<img src="{$template_dir}../../includes/types/enomsslcert/information-white.png" class="tipsing" title="The order is waiting for the domain/whois approver to review and approve it. The approver should have received an email with a link to the approval page."/>{/if}  {if $service.status!='Pending' && $service.cert_status=='Certificate Issued'}<a href="?cmd=clientarea&amp;action={$action}&amp;service={$service.id}&amp;edo=reissue" class="fs11">Reissue</a>{/if}</td>
                        </tr>

                        <tr>
                            <td align="right">{$lang.expirydate}</td>

                            <td>{$service.cert_expires|dateformat:$date_format}</td>
                            </td>
                        </tr>
                        {if $service.cert_email!=''}
                            <tr>
                                <td align="right">{$lang.en_appemail}</td>

                                <td>{$service.cert_email}</td>

                            </tr>

                        {/if}
                        <tr>
                            <td align="right">{$lang.domain}</td>

                            <td>{$service.domain}</td>

                        </tr>
                        {if $service.status!='Pending' && ($service.cert_status=='Certificate Issued' || $service.cert_status=='Expired')}
                            <tr class="lastone">
                                <td align="right">{$lang.en_sslcert}</td>

                                <td><a href="#" onclick="$(this).hide();return getEnomInfo({$service.id},'getCertificate','#certdetails')" {if $enomdo=='getCertificate' && $sslcert}style="display:none"{/if}>{$lang.clicktoview}</a>
                                    <div id="certdetails">{if $enomdo=='getCertificate' && $sslcert}
                                        <textarea  style="width:80%;height:150px;font-size:11px;" readonly="readonly" >{$sslcert}</textarea>{/if}</div>
                                </td>

                            </tr>
                        {/if}
                    </table>
                </div>
            </div>

            <div class="wbox" >
                <div class="wbox_header">
                    Web Server Information
                </div>
                <div class="wbox_content">
                {if $service.cert_status=='Certificate Issued'}	{$lang.en_certiss_info}  {/if}<a href="#" onclick="$(this).hide();return getEnomInfo({$service.id},'getWebDetails','#webtdetails')">{$lang.clicktoview}</a>
                <div id="webtdetails"></div>
            </div></div>

        <div class="wbox" >
            <div class="wbox_header">
                Contact Information
            </div>
            <div class="wbox_content">

            {if $service.cert_status=='Certificate Issued'}	{$lang.en_certiss_info} {/if}<a href="#" onclick="$(this).hide();return getEnomInfo({$service.id},'getContacts','#cntdetails')">{$lang.clicktoview}</a>
            <div id="cntdetails"></div>
        </div></div>	


</form>	

{else}

    <div class="wbox">
        <div class="wbox_header">
            {$lang.billing_info|capitalize}
        </div>
        <div class="wbox_content">
            <table width="100%" cellspacing="0" cellpadding="0" border="0" class="checker table table-striped">{include file=$typetemplates.clientaccount.billing.service}</table>
        </div>
    </div>

{/if}
<script type="text/javascript">
    {literal}
		function getEnomInfo(accid,act,field) {
			ajax_update('?cmd=clientarea&action=services',{service:accid,edo:act,layer:true},field,true);
			return false;
		}
    {/literal}
</script>
{/if}