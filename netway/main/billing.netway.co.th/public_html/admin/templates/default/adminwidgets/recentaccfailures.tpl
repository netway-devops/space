        <table cellspacing="0" cellpadding="3" border="0" width="100%" class="table table-fixed whitetable" style="">
            <tbody>
            <tr>
                <th>{$lang.Account}</th>
                <th>{$lang.Action}</th>
                <th width="40%">{$lang.Error}</th>
                <th>{$lang.Date}</th>
            </tr>
            {foreach from=$accountfailures item=acc name=loop}
                <tr   {if $smarty.foreach.loop.iteration%2==0}class="odd {if $acc.notseen}notseen{/if}"{else}class="even {if $acc.notseen}notseen{/if}"{/if} >
                    <td>
                        <a href="?cmd=accounts&action=edit&id={$acc.account_id}">
                            {if $acc.domain}{$acc.domain}
                            {else}<em>#{$acc.account_id} <small>( {$lang.emptyhost} )</small></em>
                            {/if}
                        </a>
                    </td>
                    <td >{$acc.action}</td>
                    <td width="40%"><span class="text-overflow" title="{$acc.error}">{$acc.error}</span></td>
                    <td>{$acc.date|dateformat:$date_format}</td>
                </tr>
            {/foreach}
            </tbody>
        </table>
