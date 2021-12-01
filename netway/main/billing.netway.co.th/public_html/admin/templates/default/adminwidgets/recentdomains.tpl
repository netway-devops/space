{if $recentdomainsfailed}
    <table cellspacing="0" cellpadding="3" border="0" width="100%" class="table table-fixed whitetable" style="">
        <tbody>
        <tr>
            <th>{$lang.Domain}</th>
            <th width="40%">{$lang.Action}</th>
            <th>{$lang.Success}</th>
            <th>{$lang.Date}</th>
        </tr>
        {foreach from=$recentdomainsfailed item=dom name=loop}
            <tr {if $smarty.foreach.loop.iteration%2==0}class="odd {if $dom.notseen}notseen{/if}"{else}class="even {if $dom.notseen}notseen{/if}"{/if}>
                <td><a href="?cmd=domains&action=edit&id={$dom.domain_id}">{$dom.name}</a></td>
                <td ><span class="text-overflow" title="{$dom.action}">{$dom.action}</span></td>
                <td>{if $dom.result=='1'}{$lang.Yes}{else}<font color="red">{$lang.No}</font>{/if}</td>
                <td>{$dom.date|dateformat:$date_format}</td>
            </tr>
        {/foreach}
        </tbody>
    </table>

{else}
    <table cellspacing="0" cellpadding="3" border="0" width="100%" class="table table-fixed whitetable" style="">
        <tbody>
        <tr>
            <th>{$lang.Domain}</th>
            <th width="40%">{$lang.Action}</th>
            <th>{$lang.Success}</th>
            <th>{$lang.Date}</th>
        </tr>
        {foreach from=$recentdomains item=dom name=loop}
            <tr {if $smarty.foreach.loop.iteration%2==0}class="odd {if $dom.notseen}notseen{/if}"{else}class="even {if $dom.notseen}notseen{/if}"{/if}>
                <td><a href="?cmd=domains&action=edit&id={$dom.domain_id}">{$dom.name}</a></td>
                <td ><span class="text-overflow" title="{$dom.action}">{$dom.action}</span></td>
                <td>{if $dom.result=='1'}{$lang.Yes}{else}<font color="red">{$lang.No}</font>{/if}</td>
                <td>{$dom.date|dateformat:$date_format}</td>
            </tr>
        {/foreach}
        </tbody>
    </table>

{/if}
