{if $accounts}
    {foreach from=$accounts item=account}
<tr class="{if $account.manual=='1'}man{/if}" >
    <td><input type="checkbox" class="check" value="{$account.id}" name="selected[]"/></td>
    <td><a href="?cmd=accounts&action=edit&id={$account.id}&list={$currentlist}">{$account.id}</a></td>
    <td><a href="?cmd=clients&action=show&id={$account.client_id}">{$account.firstname} {$account.lastname}</a></td>
    <td>{if $account.domain}<a href="?cmd=accounts&action=edit&id={$account.id}&list={$currentlist}">{$account.domain}</a>{else}-{/if}</td>
    <td>{if $account.mem_limit>0}<div style="" class="progress-container">
            <div style="width:{$account.mem_percent}%" class="progress-content {if $account.mem_percent>90}progress-radius{/if}"></div>
            <div class="progress-left {if $account.mem_percent<10}progress-dark{/if}">{$account.mem_used}MB</div>
            <div class="progress-right {if $account.mem_percent<90}progress-dark{/if}" >of {$account.mem_limit}MB</div>
        </div>{/if}</td>
    <td>{if $account.disk_limit>0}<div style="" class="progress-container">
            <div style="width:{$account.disk_percent}%" class="progress-content  {if $account.disk_percent>90}progress-radius{/if}"></div>
            <div class="progress-left {if $account.disk_percent<10}progress-dark{/if}">{$account.disk_usage}GB</div>
            <div class="progress-right {if $account.disk_percent<90}progress-dark{/if}" >of {$account.disk_limit}GB</div>
        </div>{/if}</td>
    <td><span class="{$account.status}">{$lang[$account.status]}</span></td>
    <td class="subjectline"><div class="df1"><div class="df2"><div class="df3">{$account.name}</div></div></div></td>
    <td>{if $account.billingcycle=='Free'}{$lang.Free}{else}{$account.total|price:$account.currency_id} <span class="fs11">({$lang[$account.billingcycle]})</span>{/if}</td>
    <td>{if $account.next_due == '0000-00-00'}-{else}{$account.next_due|dateformat:$date_format}{/if}</td>
    <td><a href="?cmd=accounts&action=edit&id={$account.id}&list={$currentlist}" class="editbtn">{$lang.Edit}</a></td>

</tr>
    {/foreach}
        {else}
<tr>
    <td colspan="11">{$lang.nothing}</td>
</tr>
{/if}