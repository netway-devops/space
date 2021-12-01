
{if $listentrys}
    {foreach from=$listentrys item=entry key=index} 
        <tr {counter}{if $even % 2 !=0}class="even"{/if}>
            <td align="center">
                {if $entry.status == 'complete'}
                    <img src="{$widgetdir_url}ico_info.gif"
                         alt="{$entry.status|capitalize}" title="{$entry.status|capitalize}" />
                    <strong>{$entry.file}</strong>
                    ( {$entry.localtime} )
                    <div class="cp-btn-group pull-right">
                    <a href="{$widget_url}&act=download&file={$entry.file|escape:'url'}"
                       class="cp-btn"
                       ><i class="fa fa-download" target="_blank"></i>
                    </a>
                    <a href="{$widget_url}&act=del&file={$entry.file|escape:'url'}&security_token={$security_token}"
                       class="cp-btn"
                       onclick="return confirm('{$lang.cpanel_delete_backup_q}')"
                       ><i class="fa fa-trash" target="_blank"></i>
                    </a>
                       </div>
                {else}
                    <img class="backup-pending" src="{$widgeturl}ajax-loading2.gif"
                         alt="{$entry.status|capitalize}" title="{$entry.status|capitalize}" />
                    <strong>{$entry.file}</strong>
                    ( {$entry.localtime} )
                {/if}

            </td>
        </tr>
    {/foreach}
{else}
    <tr {counter}{if $even % 2 !=0}class="even"{/if}>
        <td align="center">
            <strong>{$lang.nobackups}</strong>
        </td>
    </tr>
{/if}
