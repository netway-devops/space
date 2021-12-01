<script src="{$system_url}includes/modules/Hosting/symantecvip/public_html/js/external/jquery.ui/1.8.24/jquery-ui.min.js?v={$hb_version}"></script>
<script src="{$system_url}includes/modules/Hosting/symantecvip/public_html/js/VIP.js"></script>
<script src="{$system_url}includes/modules/Hosting/symantecvip/public_html/js/symantecvip.js"></script>

<link href="{$system_url}includes/modules/Hosting/symantecvip/public_html/js/external/jquery.ui/1.8.24/themes/base/jquery-ui.css?v={$hb_version}" rel="stylesheet" media="all" />

<script type="text/javascript">

	var system_url = "{$system_url}";

{literal}	

     $(document).ready(function () {
    	 $.symantecvip.init();
	 });
	</script>
	
	<style>
		/* .ui-dialog-titlebar-close {
			visibility: hidden;
		} */
		.no-close .ui-dialog-titlebar-close {
			display: none;
		}
	</style>
	
{/literal}

<strong>Symantec&trade; VIP Account & Server Management</strong> 

	<br />
		
		<div id="vipcontent">
		
		
			<div class="titlevip">
				<div>Symantec&trade; VIP Account Management for <strong>{$u_email}</strong></div>
				
				
				<div style="text-align:right">	
				
			{if $2factorStatus != 'Terminated'}	
				<span class="ui-button">
					<input type="button" id="add-vip-account" value="Add Symantec&trade; VIP Account">
				</span>
				|
			{/if}
			Quota: {$quantity_used}/{$quantity}
			
			</div>
			
			
			</div>
			
			<div><br /></div>
		
<!-- 
{$userinfo|@print_r}

{php} print_r($_SESSION); {/php}

 {foreach from=$userinfo key=k item=i}
 <br />{$k} {$i->vip_acct_name} {$i->vip_acct_comment}
 {/foreach}
</pre>-->
<!-- 
{php} echo "<pre>"; print_r($_SESSION); echo "</pre>"; {/php}  -->
			
			<div id="listvip">
			
		
				<table cellpadding="3" cellspacing="0" width="100%" style="font-size:14px;">
					<tr bgcolor="#91b0c1">
						<th width="30%" style="color:#fff; padding:4px; font-weight:bold;border-right:1px solid #ffffff; border-bottom:1px solid #ffffff; text-align:center;">Symantec&trade; VIP Account</th>
						<th width="20%" style="color:#fff; padding:4px; font-weight:bold;border-right:1px solid #ffffff; border-bottom:1px solid #ffffff; text-align:center;">Credential ID</th>
						<th width="10%" style="color:#fff; padding:4px; font-weight:bold;border-right:1px solid #ffffff; border-bottom:1px solid #ffffff; text-align:center;">Manage</th>
						<th width="30%" style="color:#fff; padding:4px; font-weight:bold;border-right:1px solid #ffffff; border-bottom:1px solid #ffffff; text-align:center;">Comment</th>
						<th width="10%" style="color:#fff; padding:4px; font-weight:bold;border-right:1px solid #ffffff; border-bottom:1px solid #ffffff; text-align:center;">Delete</th>
					</tr>
					
					
				 {foreach from=$userinfo key=k item=i}
			
			
					<tr>
						<td style="text-align:left; background:#e2e2e2; border-bottom:1px solid #ffffff;">{$i->vip_acct_name}</td>
						<td style="text-align:center; background:#e2e2e2; border-bottom:1px solid #ffffff;">


						{if $i->cred_count > 0}
						<span class="ui-button"><input type="button" id="{$i->vip_acct_id}" value="List" 
						class="show-dialog"></span></a>
						{else}
						<input type="button" enable="disabled" style="background-color: #CCCCCC" value="List" onclick="javascript:alert('This VIP account doesn\'t has credential id.')">
						{/if}
						
						
						 
						{if $i->can_add_cred == '1'}
						<span class="ui-button"><input type="button" id="{$i->vip_acct_id}" value="Add" 
						class="show-dialog-add"></span></a>
						
						{else}
						<input type="button" enable="disabled" style="background-color: #CCCCCC" value="Add" onclick="javascript:alert('This VIP account has 5 credentials id already.')">
						{/if}
						
						
						</td>
						<td style="text-align:center; background:#e2e2e2; border-bottom:1px solid #ffffff;">
						
						<span class="ui-button"><input type="button" id="{$i->vip_acct_id}" value="Manage" 
						class="show-dialog-manage"></span></a>
					
						
						</td>
						
						<td style="text-align:left; background:#e2e2e2; border-bottom:1px solid #ffffff;">{$i->vip_acct_comment}</td>
						
						<td style="text-align:center; background:#e2e2e2; border-bottom:1px solid #ffffff;">
						
						<span class="ui-button"><input type="button"  class="delete-acct" id="{$i->vip_acct_id}"
						value="Delete"></span>
					
						</td>
					</tr>
					
					 {/foreach}
					<tr>
						<td colspan="5" bgcolor="#CCCCCC">&nbsp;</td>
					</tr>
					
				</table>
			</div>
			

			
		</div>
		
	<!--  add vip acct -->
	
	<div id="dialog-add-vip-account" title="Add Symantec&trade; VIP Account" style="display:none;">
	
	{if $quantity_used < $quantity}
	
	<form name="create-vip-account" method="post"  action="">

	
		<h1 style="color:#166dbd; font-size:16px; font-weight:bold;">Add Symantec&trade; VIP Account</h1>
		
		
		<table>
		<tr>
			<td style="padding-right:5px; width:200px;"> <div align="right" style="font-size:14px;">Symantec&trade; VIP Account : </div></td>
			<td><input type="hidden" name="acct-prefix" id="acct-prefix" value="{$vip_user_prefix}"><table style="border:1px;">
					<tr>
						<td>{$vip_user_prefix}</td>
						<td valign="top" style="padding-left:0px;"><input type="text" id="vip-acct-name" name="vip-acct-name" /></td>
					</tr>
				</table>
			</td>
			<td align="left" valign="top">
			<ul class="inlinehelp">
				<li>
					<ul>
						<li style="font-size:12px;"><strong>What is the Symantec&trade; VIP Account?</strong>
						<br />The Symantec&trade; VIP Account is a unique identifier for a VIP end user. 
			The Symantec&trade; VIP Account can be any alphanumeric string, or name, but has a maximum length of 100 characters. 
			<br />Example : yourusername_user1</li>
					</ul>
				</li>
			</ul>
			</td>
		</tr>	
		<tr>
			<td style="padding-right:5px;"><div align="right"  style="font-size:14px;">Note : </div></td>
			<td><div align="left"><input type="text" id="vip-acct-comment" name="vip-acct-comment" /></div></td>
			<td align="left" valign="top">
			<ul class="inlinehelp">
				<li>
					<ul>
						<li style="font-size:12px;"><strong>What is the Symantec&trade; VIP Account Note?</strong>
						<br />The Symantec&trade; VIP Account Note is a comment or friendly name of VIP Account.</li>
					</ul>
				</li>
			</ul>
			</td>
		</tr>
		<tr>
			<td></td>
			<td align="left">
			
			
			<input type="button" id="add-acct" name="add-acct" value="Add Account" class="ui-button" />
			
		    <input type="button" value="Cancel" id="vip-cancel-add-acct" class="ui-button">
			
			
			
			</td>
		</tr>
		</table>
		
	    </form>
	    
	    
	    {else}
	    
	    <br />
		
		Your Symantec&trade; VIP Account is over quota, please make an upgrade/downgrade.
		
		<br />
		<br />
		
		<a href="/index.php/clientarea/services/rv2factor/{$accountId}/&make=upgrades&upgradetarget=config" class="btn">Upgrade Now</a>
		
		<br />
		<br />
	
		{/if}


	
	
	</div>
	
	
	
	<div id="dialog-listvipcredential" title="List Credential ID"  style="display:none;" >
		<div id="itemContent"></div>
	</div>
	
	
	<!-- form add credential -->
	<div id="dialog-addvipcredential" title="Add Symantec&trade; VIP Credential" style="display:none;">
	
	
<form name="createvipcredential" method="post" action="">

<div id="htmlFormAddCred"></div>
		
		
	<div class="titlevip">
			
			<div>
			<table cellpadding="0" cellspacing="2" width="100%" style=" font-size:14px;">
			<tr>
			<td align="right" valign="top" width="30%" style="padding-right:5px;"><div align="right">Credential ID : </div></td>
			<td align="left" valign="top"><div class="left"><input type="text" id="vip-cred" /></div></td>
			<td align="left" valign="top" width="36%">
			<ul class="inlinehelp">
			<li>
			<ul>
			<li><strong>What is a credential ID?</strong>
			<br />The credential ID is typically a 12-character alphanumeric identifier used when registering the user's credential.
			 This ID associates the credential with the Symantec&trade; VIP's account.</li>
			</ul>
			</li>
			</ul>
			</td>
			</tr>
			<tr>
			<td align="right" valign="top" style="padding-right:5px;"><div align="right">Name :</div> </td>
			<td align="left" valign="top"><div class="left"><input type="text" id="vip-cred-comment" /></div></td>
			<td align="left" valign="top" width="36%">
			<ul class="inlinehelp">
			<li>
			<ul>
			<li><strong>What is the credential name?</strong>
			<br />This is an informal name to easily identify this credential.</li>
			</ul>
			</li>
			</ul>
			</td>
			</tr>
		
		
		<tr>
			<td align="right" valign="top">&nbsp;</td>
			<td align="left" valign="top">
			
			
			<input type="button" id="vip-save-credential" name="vip-save-credential" value="Add Credential ID" class="ui-button" />
			
			
			<input type="button" class="ui-button" value="Cancel" id="vip-cancel-add-cred">
			
			
			</td>
			</tr>
						
			</table>
			</div>
			</form>
			
			
			
	</div>
	
	
	
	<div id="dialog-validatecredential" title="Validate Symantec&trade; VIP Credential" style="display:none;">
		
		<div id="htmlFormValidate"></div>
		
		<br /><br />
				
		Security Code : <input type="text" id="otp" name="otp" style="width:100px;"  />
		
		<br /><br />
		
		<input type="button" id="confirm-code" value="Confirm Security Code" class="ui-button"> 
		
		<input type="button" id="cancel-validate-cred" value="Cancel" class="ui-button"> 	 
	
		</div>
		
		
		
		
		
	<div id="dialog-listhost" title="Manage Symantec&trade; VIP Account for servers" style="display:none;">
	
		<div id="itemContentHost"></div>
	
	</div>