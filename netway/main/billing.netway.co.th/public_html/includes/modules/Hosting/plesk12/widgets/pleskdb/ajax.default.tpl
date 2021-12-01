{counter start=0 skip=1 assign=even}
{if $act=='usermanage'}
    {if $listentrys}
        {foreach from=$listentrys item=entry key=index} 
            <tr {counter}{if $even % 2 !=0}class="even"{/if}>
                <td align="right">{$entry.login}</td>
                <td align="right">{$entry.database.name}</td>
                <td align="center" class="db_management_links"> 
                    <a href="{$widget_url}&act={$act}#{$entry.id}">{$lang.plesk_permissions}</a> |
                    <a href="{$widget_url}&act={$act}&password={$entry.id}">{$lang.password}</a> |
                    <a href="{$widget_url}&act={$act}&deluser={$entry.id}&security_token={$security_token}" 
                       onclick="return confirm('{$lang.plesk_confirm_delusr}')">{$lang.delete}</a>
                </td>
            </tr>
            <tr {if $even % 2 !=0}class="even"{/if} style="display:none">
                <td align="center" class="management_del" colspan="3">
                    <input type="hidden" name="hosts[{$index}][user]" value="{$entry.id}">
                    <div style="display:table-cell; padding:0 3px; width: 50%">{$lang.plesk_ip_list}: <br>
                        <ul style="margin: 0 0 0 15px; padding: 0; line-height: 1em;">
                            {foreach from=$entry.acl item=acl}
                                <li>
                                    {$acl}
                                    <input type="hidden" name="hosts[{$index}][host][]" value="{$acl|escape}">
                                    <a href="#del" class="editbtn" style="font-size: 80%; color: red" 
                                       onclick="$(this).parent().remove(); return false;">{$lang.remove}</a>
                                </li>
                            {/foreach}
                        </ul>
                    </div>
                    <div style="display:table-cell; padding:0 3px">{$lang.addnewhost}:<br> 
                        <input autocomplete="off" type="text" name="hosts[{$index}][host][]">
                    </div> 
                    <div style="display:table-cell; padding:0 3px"><br> 
                        <input type="submit" name="hostsave" value="{$lang.shortsave}" class="btn btn-primary">
                    </div>
                </td>
            </tr>
            <tr {if $even % 2 !=0}class="even"{/if} style="display:none">
                <td align="center" colspan="3"><input type="hidden" name="passchange[{$index}][user]" value="{$entry.id}">
                    <div style="display:table-cell; padding:0 3px">{$lang.password}: <br>
                        <input autocomplete="off" type="password" name="passchange[{$index}][passmain]"></div>
                    <div style="display:table-cell; padding:0 3px">{$lang.confirmpassword}:<br> 
                        <input autocomplete="off" type="password" name="passchange[{$index}][passcheck]">
                    </div> 
                    <div style="display:table-cell; padding:0 3px"><br> 
                        <input type="submit" name="passchangesave" value="{$lang.shortsave}" class="btn btn-primary">
                    </div> 
                </td>
            </tr>
        {/foreach}
    {else}
        <tr {counter}{if $even % 2 !=0}class="even"{/if}>
            <td align="center" colspan="3">{$lang.plesk_nousers}</td>
        </tr>
    {/if}
{else}	
    {if $listentrys}
        {foreach from=$listentrys item=entry} 
            <tr {counter}{if $even % 2 !=0}class="even"{/if}>
                <td align="right">{$entry.name}</td>
                <td align="center">MySQL</td>
                <td align="center">
                    <a href="{$plesk_url}{$panellink}&success_redirect_url=/smb/database/webadmin/id/{$entry.id}?_randomId={$random}" target="_blank" rel="noreferrer">{$lang.plesk_db_admin}</a> |
                    <a href="{$widget_url}&act={$act}&deldb={$entry.id}&security_token={$security_token}" 
                       onclick="return confirm('{$lang.plesk_confirm_deldb}')">{$lang.delete}</a>
                </td>
            </tr>
        {/foreach}
    {else}
        <tr {counter}{if $even % 2 ==0}class="even"{/if}>
            <td align="center" colspan="3">{$lang.plesk_nodatabase}</td>
        </tr>
    {/if}
{/if}