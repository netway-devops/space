<tr>
    <td style="padding-top: 15px;" align="right" valign="top"><strong>RVSkin Server Type:</strong></td>
    <td style="padding-top: 15px;" valign="top">
    	<select id="conf_opt_server_type" name="cpanel[server_type]">
    		{foreach from=$aServerOpts key=item_code item=item_name}
    		<option value="{$item_name}" {if $item_name eq $server_type }selected="selected"{/if}>{$item_name}</option>
    		{/foreach}
    	</select>
    </td>
</tr>
{include file="`$rvcpanelManage2Template`"}