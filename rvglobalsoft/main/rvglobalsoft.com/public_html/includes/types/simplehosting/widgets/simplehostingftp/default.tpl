{if $cperror}
	<div style="border-radius: 6px 6px 6px 6px; background: url('icons/ico_warn.gif') no-repeat scroll 8px 8px #FFFBCC; border: 1px solid #E6DB55;color: #FF0000;font-weight: bold;margin-bottom: 8px;padding: 8px 8px 8px 30px;">
		{$lang.couldconectto} <strong>CPanel</strong><br>
		{$lang.checkyourloginpassword}
	</di>
{else}
<div >
	<div id="billing_info" class="wbox form-inline">
		<div class="wbox_header">{if $lang[$widget.name]}{$lang[$widget.name]}{elseif $widget.fullname}{$widget.fullname}{else}{$widget.name}{/if}</div>
		<div class="wbox_content">
		{literal}
			<script type="text/javascript"> 
				$(document).ready(function(){
					$('.management_links').each(function (i){
						$(this).children().eq(0).click(function(){$(this).parents('tr').next().toggle();return false;});
					});
				});
			</script>
			{/literal}
		<form autocomplete="off" action="?cmd={$cmd}&action={$action}&service={$service.id}&widget={$widget.name}&act={$act}" method="post">
			<table class="checker table table-striped" width="100%" cellspacing="0" cellpadding="0" border="0">
			{counter start=1 skip=1 assign=even}
				<thead>
					<tr {counter}{if $even % 2 !=0}class="even"{/if} >
					<td align="right">{$lang.username}</td>
					<td align="center">{$lang.type}</td>
					<td align="center"> {$lang.homedirectory}</td>
					<td align="center">{$lang.managementfunctions}</a></td>
					</tr>
				</thead>
				<tbody id="updater">
				{if $listentrys}
				{foreach from=$listentrys item=entry key=index} 
					<tr {counter}{if $even % 2 !=0}class="even"{/if}>
						<td align="right">{$entry.user}</td>
						<td align="center">{$entry.type}</td>
						<td align="left">{$entry.homedir}</td>
						<td align="center" class="management_links">{if $entry.type == 'sub'}
						<a href="?cmd={$cmd}&action={$action}&service={$service.id}&widget={$widget.name}&act={$act}&changepass">{$lang.changepass}</a> |
						<a href="?cmd={$cmd}&action={$action}&service={$service.id}&widget={$widget.name}&act={$act}&deluser={$entry.user}" onclick="return confirm('Do You really want to delete this FTP account?')">{$lang.delete}</a> 
						{/if}
						</td>
					</tr>
					<tr {if $even % 2 !=0}class="even"{/if} style="display:none">
						<td align="right" ><input type="submit" name="save" value="{$lang.shortsave}" class="btn"></td>
						<td align="right"  colspan="2">	{$lang.password}: 						
						<input type="hidden" name="passchange[{$index}][user]" value="{$entry.user}">
							<input class="span2" autocomplete="off" type="password" name="passchange[{$index}][passmain]">
						</td>
						<td align="right">{$lang.confirmpassword}: 
							<input class="span2" autocomplete="off" type="password" name="passchange[{$index}][passcheck]">
						</td>
					</tr>
				{/foreach}
				{/if}
					<tr {counter}{if $even % 2 !=0}class="even"{/if}><td colspan="4">&nbsp;</td></tr>
					<tr {counter}{if $even % 2 !=0}class="even"{/if}>
						<td align="left" colspan="4">
							<strong>{$lang.specialaccounts}</strong>
						</td>
					</tr>
				{foreach from=$listmainentrys item=entry}
					<tr {counter}{if $even % 2 !=0}class="even"{/if}>
						<td align="right">{$entry.user}</td>
						<td align="center">{$entry.type}</td>
						<td align="left">{$entry.homedir}</td>
						<td align="center" class="management_links"></td>
					</tr>
				{/foreach} 
				</tbody>
				<tfoot>
					<tr {counter}{if $even % 2 !=0}class="even"{/if}><td colspan="4">&nbsp;</td></tr>
					<tr {counter}{if $even % 2 !=0}class="even"{/if}><td colspan="4">{$lang.addftpaccount}</td></tr>
					<tr {counter}{if $even % 2 !=0}class="even"{/if}>
					<td style="border:none" colspan="4" align="center">
						<table style="float:left" cellspacing="0" cellpadding="0">
							<tr>
							<td style="text-align:right;border:none">{$lang.username}: </td>
							<td style="text-align:left; border:none"> <input class="span2" autocomplete="off" type="text" name="name" >@{if $listdomains|@count == 1}{$listdomains[0].domain}{elseif $listdomains|@count == 0}{$domain}{/if}
							</td>
							</tr>
							<tr>
							<td  style="text-align:right;border:none">{$lang.password}: </td>
							<td style="text-align:left;border:none"> <input class="span2" autocomplete="off" type="password" name="passmain" ></td>
							</tr>
							<tr>
							<td style="text-align:right;border:none">{$lang.confirmpassword}: </td>
							<td style="text-align:left;border:none"> <input class="span2" autocomplete="off" type="password" name="passcheck" ></td>
							</tr>
						</table>
						<div style="float:left;padding:0 0 0 10px;vertical-align:middle">{$lang.homedirectory}:<br> <input autocomplete="off" type="text" name="dir" class="span4"></div>
						<div style="float:left; padding:15px 6px;vertical-align:middle"><input class="btn" type="submit" name="save" value="{$lang.shortsave}"> </div>
					</td></tr>
				</tfoot>
			</table>
			</form>
		</div>
	</div>
</div>
{/if}