<table cellspacing="0" cellpadding="3" border="0" width="100%" class="glike hover">
    <thead>
        <tr>
            <th class="sortorder col-sm-1 acenter">{$lang.Account}</th>
            <th class="sortorder col-sm-offset-1 ">{$lang.domainname}</th>
        </tr>
    </thead>
    <tbody>
        {foreach from=$zones item=zone name=foo}
            <tr {if $smarty.foreach.foo.index%2 == 0}class="even"{/if}>
                <td class="acenter"><a
                            href="?cmd=accounts&action=edit&id={$zone.account_id}&security_token={$security_token}">{$zone.account_id}</a>
                </td>
                <td>
                    <a href="?cmd={$module}&action=show&zone_id={$zone.domain_id}&zone_name={$zone.domain}&server_id={$zone.server_id}&security_token={$security_token}">{$zone.domain}</a>
                </td>
            </tr>
            {foreachelse}
            <tr>
                <td colspan="2">No zons assigned to this client yet.</td>
            </tr>
        {/foreach}

    </tbody>
</table>
{if $totalpages}
    <center class="blu paginercontainer">
        <strong>{$lang.Page} </strong>
        {section name=foo loop=$totalpages}
            <a href='?cmd={$module}&action=allzoneforclient&client={$client}&page={$smarty.section.foo.iteration-1}&security_token={$security_token}'
               class="npaginer
                               {if $smarty.section.foo.iteration-1==$currentpage}
                                   currentpage
                               {/if}"
            >{$smarty.section.foo.iteration}</a>
        {/section}
    </center>
    <script> $('.paginercontainer', 'div.slide:visible').infinitepages();
        FilterModal.bindsorter('{$orderby.orderby}', '{$orderby.type}');</script>
{/if}
