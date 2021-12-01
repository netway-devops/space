{literal}
<style>
#error {
margin:10px;background:#F2DEDE;border-radius:4px;border:solid 1px #EED3D7;color:#B94A48;
font-size:13px;font-family:"Helvetica Neue",Helvetica,Arial,sans-serif;line-height:18px;
padding:14px;text-shadow:0 1px 0 rgba(255, 255, 255, 0.5);
}
.alert-success {
border-radius:4px;border:solid 1px green;
padding:14px;text-shadow:0 1px 0 rgba(255, 255, 255, 0.5);
}
</style>
{/literal}

<script type="text/javascript" language="javascript" src="{$template_dir}rvlicense/script_change_ip.js"></script>

<div class="alert-success sta_ok" style="display:none;">
<span id="txt_response_yes"></span>
</div>
<div id="error"class="sta_no" style="display:none;">
<span id="txt_response_no"></span>
</div>
<h3>
{if $REQUEST.rvcmd eq 'rvskin_license'}
	Add RVSkin License
{elseif $REQUEST.rvcmd eq 'rvsitebuilder_license'}
	Add RVSitebuider License
{elseif $REQUEST.rvcmd eq 'remote_issue'}
	 Remote API Access
{/if}
</h3>

{if $REQUEST.rvcmd eq 'rvskin_license' || $REQUEST.rvcmd eq 'rvsitebuilder_license'}
<form name="frmaddlicense" onsubmit="action_addlicense();return false;"id="frmaddlicense" method="post"  action="">
<input type="hidden" name="acc_id" value="{$acc_id}">
<input type="hidden" name="cmd" id="cmd" value="{$REQUEST.rvcmd}">
<input type="hidden" name="product_id" id="cmd" value="{$REQUEST.product_id}">
<table>
<tr>
      <td width="120" align="right" nowrap="nowrap"><label>Add public IP <a href="#" data-toggle="tooltip" title="Public IP Address: the Public IP if your server is running behind NAT or Firewall
">?</a> : </label></td>
      <td>
        	<input  type="text" name="main_ip" id="main_ip" value=""size="18" >
        </td>
</tr>
<tr>
 		<td width="120" align="right" nowrap="nowrap"><label>Add private IP <a href="#" data-toggle="tooltip" title="
 		Server IP Address: the Private IP(NAT/Firewall IP) 
If your serer is not running this setup, just insert only Public IP and contiue.
 		">?</a> :</label></td>
        <td>
    	<input  type="text" name="sec_ip" id="sec_ip" value=""size="18" >
	  </td>
</tr>
{if $REQUEST.product_id  eq '159'}
<tr>
  <td width="120" align="right" nowrap="nowrap"></td>
  <td><input type="hidden" name="server_type" id="typede" value="ded"></td>
</tr>
{else}
<tr>
      <td width="120" align="right" nowrap="nowrap"><label>Server Type :</label></td>
      <td>
      	{if $REQUEST.rvcmd eq 'rvskin_perpetual_license'}
	      	{if $REQUEST.q_ded neq 0}
	        <label for="typede"><input type="radio" id="typede" name="server_type" value="ded" checked/> Dedicate</label>
	        {/if}
	        {if $REQUEST.q_vps neq 0}
	        <label for="typevps"><input type="radio" id="typevps" name="server_type" value="vps" /> VPS</label>
	        {/if}
		{else}
	        <label for="typede"><input type="radio" id="typede" name="server_type" value="ded" checked/> Dedicate</label>
	        <label for="typevps"><input type="radio" id="typevps" name="server_type" value="vps" /> VPS</label>
		{/if}
      </td>
</tr>
{/if}

<tr>
    <td colspan="2" align="center">
    <input type="button" name="bu_addlicense" onclick="action_addlicense();" value="Add License"/>
    </td>
</tr>
</table>
</form>
{elseif $REQUEST.rvcmd eq 'remote_issue'}
	{php}
		$templatePath   = $this->get_template_vars('template_path');
		include($templatePath . 'clientarea/rv_remote_issue.tpl.php');
	{/php}
	{if $isNotConvert}
		<span>
			<font color="red">
				Sorry, "Remote API Access" function is still inactive in your account. Please contact <a href="https://rvglobalsoft.com/tickets/new&deptId=2">RVStaff</a> to activate this function for you.
			</font>
		</span>
	{else}
{literal}
<script language="JavaScript">
	
function validate_numip(id)
{
	num = $('#' + id).val()
	if (!num.match(/\d/g) || num > 255) {
		alert('Please input number 0-255 only.');
		$('#' + id).css( "color", "red" );
		$('#' + id).focus();
		return false;
	} else {
		$('#' + id).css( "color", "green" );
		return true;
	}
}

function action_addremote()
{
	if (!validate_numip('remote_main_1') 
		|| !validate_numip('remote_main_2') 
		|| !validate_numip('remote_main_3') 
		|| !validate_numip('remote_sub_first')) {
		alert('Please input number 0-255 only.');
		return false;
	}
	return true;
}
</script>
{/literal}
		{if $isSuccess}
			<div class="alert-success">
				{$SuccessMsg}
			</div>
		{/if}
		{if $isError}
			<div id="error">
				{$ErrorMsg}
			</div>
		{/if}
		
		<div class="partner-license">
			<div class="col-md-9 clear-mp">
				<p>
				This function allows our partner to add server IP(s) for Remote API Access freely. 
				This's more easier way than making API request to us via ticket. 
				Here you can add IP(s) for API connection anytime.
				Please carefully fill the IP list for Remote API Access below.
				</p>
			</div>
			<div class="clear"></div>
			<div class="row-fluid padd">
				<div class="col-md-12 clear-mp">
					<table cellpadding="0" cellspacing="0" width="90%">
						<tr>
							<td><span class="icon-note"></span></td>
							<td class="des-note" width="99%">
							Sample: 00.00.00.01-09, to define server IPs between x.01 - x.09<br />
							Or: 00.00.00.01-01, to define 1 server IP.
							</td>
						</tr>
					</table>
				</div>
				
				<div class="clear"></div>
				
				<div class="col-md-12 clear-mp">
					<p class="padd">
					After that, back to the main NOC Licenses page to find "API Setup" in order to set up API Connection to your server(s).
					</p>
				</div>
			</div>

			<div class="pl-border">
					<div class="content">
						<p>
							<h5><span class="icon-title"></span> Add New Remote API Access</h5>
							<div class="padl">
							<form form name="frmaddremote" onsubmit="return action_addremote();return false;"id="frmaddremote" method="post"  action="index.php?cmd=clientarea&rvaction=partner">
								<input name="rvaction" value="partner" type="hidden" />
								<input name="rvcmd" value="remote_issue" type="hidden" />
								<input name="rvcallaction" value="add" type="hidden" />
								{securitytoken}
								<b>Remote IP:</b>
								<input id="remote_main_1" name="remote_main_1" size="3" maxlength="3" style="width:30px;" tabindex="101" onblur="return validate_numip(this.id);" />.
							<input id="remote_main_2" name="remote_main_2" size="3" maxlength="3" style="width:30px;" tabindex="102" onblur="return validate_numip(this.id);"/>.
							<input id="remote_main_3" name="remote_main_3" size="3" maxlength="3" style="width:30px;" tabindex="103" onblur="return validate_numip(this.id);"/>.
							<input id="remote_sub_first" name="remote_sub_first" size="3" maxlength="3" style="width:30px;" tabindex="104" onblur="return validate_numip(this.id);"/>-
							<input id="remote_sub_last" name="remote_sub_last" size="3" maxlength="3" style="width:30px;" tabindex="105" onblur="return validate_numip(this.id);"/>
							<button tabindex="106" class="clearstyle btn green-custom-btn l-btn">Add</button>
						</form>
						</div>
					</p>
			
					<h5><span class="icon-title"></span> Remote API Access List</h5>
					<table border="0" width="100%" class="tbl-remote">
						<tr>
							<th align="center">Main IP</th>
							<th align="center">Sub First IP</th>
							<th align="center">Sub Last IP</th>
							<th align="center">Actions</th>
						</tr>
						{foreach from=$aRemoteList key=k item=item}
						<tr>
							<td align="center">{$item.remote_main_ip}</td>
							<td align="center">{$item.remote_sub_first_ip}</td>
							<td align="center">{$item.remote_sub_last_ip}</td>
							<td align="center">
							<form form name="frmdelremote" id="frmdelremote" method="post" action="index.php?cmd=clientarea&rvaction=partner">
								<input name="rvaction" value="partner" type="hidden" />
								<input name="rvcmd" value="remote_issue" type="hidden" />
								<input name="rvcallaction" value="delete" type="hidden" />
								<input name="main_ip" value="{$item.remote_main_ip}" type="hidden" />
								<input name="remote_sub_first" value="{$item.remote_sub_first_ip}" type="hidden" />
								<input name="remote_sub_last" value="{$item.remote_sub_last_ip}" type="hidden" />
								<input name="quota_id" value="{$item.quota_id}" type="hidden" />
								{securitytoken}
								<button tabindex="106" class="clearstyle btn green-custom-btn l-btn">Remove</button>
							</form>
							</td>
						</tr>
						{/foreach}
					</table>
				</div>
			</div>
		</div>	
	{/if}
{/if}
