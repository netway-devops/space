{if $accounts}
    {foreach from=$accounts item=account}
     <tr class="{if $account.manual=='1'}man{/if} {if $account.bw_percent >99 || $account.disk_percent > 99}alert{/if}" >
        <td><input type="checkbox" class="check" value="{$account.id}" name="selected[]"/></td>
        <td><a href="?cmd=accounts&action=edit&id={$account.id}&list={$currentlist}">{$account.id}</a></td>
		<td><a href="?cmd=clients&action=show&id={$account.client_id}">{$account.firstname} {$account.lastname}</a></td>
        <td>
            {if $account.onsrv}<a href="{if $account.solusurl}{$account.solusurl}clients.php?action=loginasclient&id={$account.user_id}" target="_blank" title="VPS Control panel{else}#{/if}">{/if}
            {$account.username}{if $account.onsrv}<a>{/if}
        </td>
        {if $account.options.type=='single'}
            <td>{$account.vps_type}</td>
            <td>{$account.cidxid}</td>
            <td>
            {if $account.onsrv}<a href="{if $account.solusurl}{$account.solusurl}managenode.php?id={$account.node_id}" target="_blank" title="Manage node{else}#{/if}">{/if}{$account.node}
                {if $account.onsrv}</a>{/if}
            </td>
            
            <td title="{$account.os}">{$account.os|truncate:15:'..':true:true}</td>
            <td>{$account.ip}</td>
            <td title="{$account.domain}">{$account.domain|truncate:15:'..':true}</td>
        {else}
            <td>-</td>
            <td>-</td>
            <td>-</td>
            <td>-</td>
            <td>-</td>
            <td>-</td> 
            <td>-</td>
        {/if}
		<td>
            {if $account.disk_limit>0}
                <div style="" class="progress-container">
                    <div style="width:{$account.bw_percent}%" class="progress-content  {if $account.bw_percent>90}progress-radius{/if}"></div>
                    <div class="progress-left {if $account.bw_percent<10}progress-dark{/if}">{$account.bw_usage}GB</div>
                    <div class="progress-right {if $account.bw_percent<90}progress-dark{/if}" >of {$account.bw_limit}GB</div>
                </div>
            {else}
                -
            {/if}
        </td>
		<td>
            {if $account.disk_limit>0}
                <div style="" class="progress-container">
                    <div style="width:{$account.disk_percent}%" class="progress-content  {if $account.disk_percent>90}progress-radius{/if}"></div>
                    <div class="progress-left {if $account.disk_percent<10}progress-dark{/if}">{$account.disk_usage}GB</div>
                    <div class="progress-right {if $account.disk_percent<90}progress-dark{/if}" >of {$account.disk_limit}GB</div>
                </div>
            {else}
                -
            {/if}
        </td>
        <td>{$account.total|price:$account.currency_id}</td>
        <td>{$lang[$account.billingcycle]}</td>
        <td><span class="{$account.status}">{$lang[$account.status]}</span></td>
        <td>{if $account.next_due == '0000-00-00'}-{else}{$account.next_due|dateformat:$date_format}{/if}</td>
        <td><a href="?cmd=accounts&action=edit&id={$account.id}&list={$currentlist}" class="editbtn">{$lang.Edit}</a></td>

        </tr>
    {/foreach}
{/if}