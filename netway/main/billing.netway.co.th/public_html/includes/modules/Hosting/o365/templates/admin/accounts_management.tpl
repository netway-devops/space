{include file=$csslocation}

{php}
//echo '<pre>'; print_r($this->get_template_vars()); echo '</pre>';
//echo '<pre>'; print_r($this->get_template_vars('accounts')); echo '</pre>';
{/php}
<ul class="accor">
<li>
        <a href="#">Subscription From Azure Partner Center</a>
    </li>
	<div style='background-color: #d4e6fc;'>
    <table cellspacing='2' cellpadding='3' border='0' width='100%' id="o365-setting">
        <tr>
            <td align="left"><input id="bt_get_subscription" type="button" value="Get Subscription" onclick="getAzureSubscriptionFromPartnerCenter({$accounts.module}, {$accounts.id})"></td>
		</tr>
		<tr>
            <td align="left"><div id="result_azure_subscription"></div></td>
		</tr>
	</table>
</ul>
<ul class="accor">
    <li>
        <a href="#">O365 Setting</a>
    </li>
    <div style='background-color: #d4e6fc;'>
    <table cellspacing='2' cellpadding='3' border='0' width='100%' id="o365-setting">
        <tr>
            <!--<td><a href="javascript:void(0);" id="refreshpage" title="refresh page">&#8634;</a></td>-->
            <td align="left">
            	ส่วนงานนี้ช่วยอัพเดท DNS ให้เท่านั้น เจ้าหน้าที่จะต้อง Click Verify ที่ฝั่งของ Office365 ด้วย<br>
            	Link : <a href="https://partnercenter.microsoft.com/en-us/partner/home" target="_blank">https://partnercenter.microsoft.com/en-us/partner/home</a>
            	<br>
            	<h3>Step 1</h3>
            	<div id="step-1-status"></div>
            	
            	<form>
            		<table width="350px" cols="0" cellspacing="0">
            			<tr>
            				<th>TXT name</th>
            				<th>TXT value</th>
            				<th>TTL</th>
            				<th></th>
            			</tr>
            			<tr>
            				<th><input type="text" id="txtName" name="txtName" value="@" disabled="disabled"/></th>
            				<th><input type="text" id="txtData" name="txtData" placeholder="Ex.MS=msxxxxxx"/></th>
            				<th><input type="text" id="txtTtl" name="txtTtl" value="3600" disabled="disabled"/></th>
            				<th><input type="button" value="Modify DNS" id="addTxt"></th>
            			</tr>
            		</table>
            		<input type="hidden" name="domainName" id="domainName" value="{$domainName}" />
            	</form>
            	<br>
            </td>
        </tr>
        <td align="left">
            	
            	<form>
            		<h3>Step 2 &nbsp;&nbsp;&nbsp;<input type="button" value="Modify DNS" id="addAllDns"></h3>
            		
            	<div id="step-2-status"></div>
            	            	
            		<table width="450px" cols="0" cellspacing="0">
            			<tr><td colspan="5"><b><u>Exchange Online</u></b></td></tr>
            			<tr>
            				<th>Type</th>
            				<th>Host Name</th>
            				<th>Point To Address / TXT Value</th>
            				<th>TTL</th>
            				<th>Priority</th>
            				<th></th>
            			</tr>
            			<tr>
            				<th><input type="text" id="exMxType" name="exMxType" value="MX" disabled="disabled" size="8"/></th>
            				<th><input type="text" value="{$domainName}." disabled="disabled" size="20"/>
            					<input type="hidden" id="hostname" name="hostname" value="{$domainName}."/>
            				</th>
            				<th><input type="text" id="exMxPta" name="exMxPta"  value=""  size="50" />
            				</th>
            				<th><input type="text" id="txtTtl" name="txtTtl" value="3600" disabled="disabled" size="5"/></th>
            				<th><input type="text" id="txtTtl" name="txtTtl" value="0" disabled="disabled" size="1"/></th>
            			</tr>
            			<tr>
            				<th><input type="text" id="exCnameType" name="exCnameType" value="CNAME" disabled="disabled" size="8"/></th>
            				<th><input type="text" id="hostname1" name="hostname1" value="autodiscover" disabled="disabled" size="20"/></th>
            				<th><input type="text" id="exCnamePta" name="exCnamePta" value="autodiscover.outlook.com." disabled="disabled"  size="50"/></th>
            				<th><input type="text" id="txtTtl" name="txtTtl" value="3600" disabled="disabled" size="5"/></th>
            			</tr>
            			<tr>
            				<th><input type="text" id="exTxtType" name="exTxtType" value="TXT" disabled="disabled" size="8"/></th>
            				<th><input type="text" id="hostname2" name="hostname2" value="{$domainName}." disabled="disabled" size="20"/></th>
            				<th><input type="text" id="exTxtPta" name="exTxtPta" value='"v=spf1 include:spf.protection.outlook.com -all"' disabled="disabled"  size="50"/></th>
            				<th><input type="text" id="txtTtl" name="txtTtl" value="3600" disabled="disabled" size="5"/></th>
            			</tr>
            		</table>
            		<br>
            		<table width="450px" cols="0" cellspacing="0">
            			<tr><td colspan="5"><b><u>Skype for Business</u></b></td></tr>
            			<tr>
            				<th>Type</th>
            				<th>Host Name</th>
            				<th>Port</th>
            				<th>Weight</th>
            				<th>Priority</th>
            				<th>Target</th>
            				<th>TTL</th>
            			</tr>
            			<tr>
            				<th><input type="text" value="SRV" disabled="disabled" size="8"/></th>
            				<th><input type="text" value="_sip._tls" disabled="disabled" size="20"/></th>
            				<th><input type="text" value="443" disabled="disabled" size="4"/></th>
            				<th><input type="text" value="1" disabled="disabled" size="1"/></th>
            				<th><input type="text" value="100" disabled="disabled" size="3"/></th>
            				<th><input type="text" value="sipdir.online.lync.com." disabled="disabled" size="25"/></th>
            				<th><input type="text" value="3600" disabled="disabled" size="5"/></th>
            			</tr>
            			<tr>
            				<th><input type="text" value="SRV" disabled="disabled" size="8"/></th>
            				<th><input type="text" value="_sipfederationtls._tcp" disabled="disabled" size="20"/></th>
            				<th><input type="text" value="5061" disabled="disabled" size="4"/></th>
            				<th><input type="text" value="1" disabled="disabled" size="1"/></th>
            				<th><input type="text" value="100" disabled="disabled" size="3"/></th>
            				<th><input type="text" value="sipfed.online.lync.com." disabled="disabled" size="25"/></th>
            				<th><input type="text" value="3600" disabled="disabled" size="5"/></th>
            			</tr>
            		</table>
            		<br>
            		<table width="450px" cellpadding="0" cellspacing="0">
            			<tr>
            				<th>Type</th>
            				<th>Host Name</th>
            				<th>Points To Address</th>
            				<th>TTL</th>
            			</tr>
            			<tr>
            				<th><input type="text" value="CNAME" disabled="disabled" size="8"/></th>
            				<th><input type="text" value="sip" disabled="disabled"/ size="20"></th>
            				<th><input type="text" value="sipdir.online.lync.com." disabled="disabled" size="30"/></th>
            				<th><input type="text" value="3600" disabled="disabled" size="5"/></th>
            			</tr>
            			<tr>
            				<th><input type="text" value="CNAME" disabled="disabled" size="8"/></th>
            				<th><input type="text" value="lyncdiscover" disabled="disabled"/ size="20"></th>
            				<th><input type="text" value="webdir.online.lync.com." disabled="disabled" size="30"/></th>
            				<th><input type="text" value="3600" disabled="disabled" size="5"/></th>
            			</tr>
            		</table>
            		<br>
            		<table width="450px" cols="0" cellspacing="0">
            			<tr><td colspan="5"><b><u>Mobile Device Management for Office 365</u></b></td></tr>
            			<tr>
            				<th>Type</th>
            				<th>Host Name</th>
            				<th>Points To Address</th>
            				<th>TTL</th>
            			</tr>
            			<tr>
            				<th><input type="text" value="CNAME" disabled="disabled" size="8"/></th>
            				<th><input type="text" value="enterpriseregistration" disabled="disabled"/ size="20"></th>
            				<th><input type="text" value="enterpriseregistration.windows.net." disabled="disabled" size="30"/></th>
            				<th><input type="text" value="3600" disabled="disabled" size="5"/></th>
            			</tr>
            			<tr>
            				<th><input type="text" value="CNAME" disabled="disabled" size="8"/></th>
            				<th><input type="text" value="enterpriseenrollment" disabled="disabled"/ size="20"></th>
            				<th><input type="text" value="enterpriseenrollment.manage.microsoft.com." disabled="disabled" size="30"/></th>
            				<th><input type="text" value="3600" disabled="disabled" size="5"/></th>
            			</tr>
            		</table>
            		<br>
            		<table width="450px" cols="0" cellspacing="0">
            			<tr><td colspan="5"><b><u>Additional Office 365 records</u></b></td></tr>
            			<tr>
            				<th>Type</th>
            				<th>Host Name</th>
            				<th>Points To Address</th>
            				<th>TTL</th>
            			</tr>
            			<tr>
            				<th><input type="text" value="CNAME" disabled="disabled" size="8"/></th>
            				<th><input type="text" value="msoid" disabled="disabled"/ size="20"></th>
            				<th><input type="text" value="clientconfig.microsoftonline-p.net." disabled="disabled" size="30"/></th>
            				<th><input type="text" value="3600" disabled="disabled" size="5"/></th>
            			</tr>
            			
            		</table>
            		            		
            		<input type="hidden" name="domainName" id="domainName" value="{$domainName}" />
            	</form>
            	
            </td>
        <tr>
        	<td>
            <pre>{*$accounts|@print_r*}</pre>
            <pre>{*$accountConfig|@print_r*}</pre>
            </td>
        </tr>
    </table>
    </div>
</ul>
{include file=$jslocation}