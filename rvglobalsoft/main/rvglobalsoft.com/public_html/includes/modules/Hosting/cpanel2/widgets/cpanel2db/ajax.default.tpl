{if $act=='usermanage'}
    {if $listentrys}
        {foreach from=$listentrys item=entry key=index} 
            <tr class="tr-lead">
                <td align="right">{$entry.user}</td>
                <td align="center" class="management_links"> 
                    <div class="cp-btn-group">
                        <a class="cp-btn" data-manage="1" href="{$widget_url}&act={$act}#{$entry.user}" 
                           title="{$widget_lang.permissions}">
                            <i class="fa fa-check-square-o"></i> {$widget_lang.permissions}
                        </a>
                        <a class="cp-btn" data-manage="2" href="{$widget_url}&act={$act}&password={$entry.user}"
                           title="{$lang.password}">
                            <i class="fa fa-lock"></i> {$lang.password}
                        </a>
                        <a class="cp-btn cp-danger" href="&act={$act}&deluser={$entry.user}" 
                           onclick="return confirm('{$widget_lang.confirm_delusr}')" title="{$lang.delete}">
                            <i class="fa fa-trash"></i> {$lang.delete}
                        </a> 
                    </div>
                </td>
            </tr>
            <tr class="tr-follower" >
                <td align="center" class="no-padding manage-cnt" colspan="2">
                    {if $entry.dblist}
                        <table class="table">
                            <tr>
                                <th>{$widget_lang.db_list}</th> 
                                <th>Grant Access</th> 
                            </tr>
                            {foreach from=$widgets item=wig}
                                {if $widget.name == $wig.name}
                                    {assign value=$wig.location var=widgeturl}
                                {/if}
                            {/foreach}
                            {foreach from=$entry.dblist item=dblist} 
                                <tr>
                                    <td>{$dblist.db}</td>
                                    <td>
                                        <input class="db-permissions" type="checkbox" title="Grant Access" 
                                               value="{$dblist.db}" data-user="{$entry.user}" 
                                               {if $dblist.acces == 1}checked{/if}>
                                    </td>
                                </tr>
                            {/foreach}
                        </table>
                    {else}
                        {$widget_lang.nodatabase}
                    {/if}
                </td>
                <td class="manage-cnt" align="center" colspan="2">
                    <input type="hidden" name="passchange[{$index}][user]" value="{$entry.user}">
                    <div style="display:table-cell; padding:0 3px">{$lang.password}: <br>
                        <input autocomplete="off" type="password" name="passchange[{$index}][passmain]">
                    </div>
                    <div style="display:table-cell; padding:0 3px">{$lang.confirmpassword}:<br> 
                        <input autocomplete="off" type="password" name="passchange[{$index}][passcheck]">
                    </div> 
                </td>
            </tr>

        {/foreach}
    {else}
        <tr>
            <td align="center" colspan="2">{$widget_lang.nousers}</td> 
        </tr>
    {/if}
{elseif $act=='hostmanage'}
    {if $listentrys}
        {foreach from=$listentrys item=entry} 
            <tr>
                <td align="right">{$entry.host}</td>
                <td align="center">
                    <a class="cp-btn cp-danger" href="{$widget_url}&act={$act}&delhost={$entry.host}" 
                       onclick="return confirm('{$widget_lang.confirm_delhost}')" title="{$lang.delete}">
                        <i class="fa fa-trash"></i> {$lang.delete}
                    </a>
                </td>
            </tr>
        {/foreach}
    {else}
        <tr>
            <td align="center" colspan="2">{$widget_lang.nohosts}</td>
        </tr>
    {/if}
{else}	
    {if $listentrys}
        {foreach from=$listentrys item=entry} 
            <tr >
                <td align="right">{$entry.db}</td>
                <td align="center">MySQL</td>
                <td align="center">
                    <div class="cp-btn-group">
                        <a class="cp-btn" href="{$widget_url}&act=redirect&db={$entry.db}&security_token={$security_token}" 
                           title="{$widget_lang.db_admin}" target="_blank">
                            <i class="fa fa-external-link-square"></i> {$widget_lang.db_admin}
                        </a>
                        <a class="cp-btn" href="{$widget_url}&act=backup&db={$entry.db}&security_token={$security_token}" 
                           title="Backup" target="_blank">
                            <i class="fa fa-download"></i> Backup
                        </a>
                        <a class="cp-btn cp-danger" href="{$widget_url}&act={$act}&deldb={$entry.db}" 
                           onclick="return confirm('{$widget_lang.confirm_deldb}')" title="{$lang.delete}">
                            <i class="fa fa-trash"></i> {$lang.delete}
                        </a> 
                    </div>
                </td>
            </tr>
        {/foreach}
    {else}
        <tr>
            <td align="center" colspan="4">{$widget_lang.nodatabase}</td>
        </tr>
    {/if}
{/if}