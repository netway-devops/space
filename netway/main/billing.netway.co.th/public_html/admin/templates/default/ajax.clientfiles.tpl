
{if !$files}
    <em>This client does not have any files yet</em>
{else}
<ul style="border:solid 1px #ddd;border-bottom:none;margin-bottom:10px" id="grab-sorter" >
    {foreach from=$files item=f}
<li style="background:#ffffff"><div style="border-bottom:solid 1px #ddd;">
        <table width="100%" cellspacing="0" cellpadding="5" border="0">
            <tr>
                <td><a class="dwbtn left" href="?cmd=root&amp;action=download&amp;type=downloads&amp;id={$f.id}">download</a> <a href="?cmd=root&amp;action=download&amp;type=downloads&amp;id={$f.id}">{$f.name}</a></td>
                <td width="20" >
                    {if !$forbidAccess.editClients}
                    <a onclick="return confirm('Are you sure you want to delete this file?')" class="delbtn" href="?cmd=clients&amp;action=deleteclientfile&amp;&client_id={$client_id}&file_id={$f.id}&amp;security_token={$security_token}">delete</a>
                    {/if}
                </td>

            </tr>
        </table>
    </div>
</li>

    {/foreach}
</ul>
{/if}
{if !$forbidAccess.editClients}
<div id="fileform" class="blu" style="display:none">
    <table cellpadding="0" cellspacing="6" width="100%">
		<tr>
			<td  align="right"><strong>{$lang.Name}</strong></td>
			<td><input name="name" /></td>
		
			<td align="right"  ><strong>{$lang.file}</strong></td>
			<td >
				 <input type="file" name="file" />
			</td>
		
			<td align="right"><strong>Admin only</strong></td>
			<td><input type="checkbox" name="admin_only" value="1" /></td>
			<td  align="right"><input type="submit" name="uploadfile" value="Upload"  class="btn btn-primary btn-sm" onclick="$('#clientform').append('<input name=\'action\' value=\'uploadclientfile\' type=\'hidden\' />')" /></td>
		</tr>



	</table>
</div>
<input type="hidden" name="client_id" value="{$client_id}" />
<a href="#" class="menuitm right" onclick="$(this).hide();$('#fileform').show();return false;"><span>Upload file</span></a>
{/if}
<div class="clear"></div>
{literal}<script></script>{/literal}