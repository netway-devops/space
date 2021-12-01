{if $accounts}
    {foreach from=$accounts item=account}
<tr class="{if $account.manual=='1'}man{/if}" >
    <td><input type="checkbox" class="check" value="{$account.id}" name="selected[]"/></td>
    <td><a href="?cmd=accounts&action=edit&id={$account.id}&list={$currentlist}">{$account.id}</a></td>
    <td><a href="?cmd=clients&action=show&id={$account.client_id}">{$account.firstname} {$account.lastname}</a></td>
  
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