{if $accounts}
    {foreach from=$accounts item=account}
<tr>
    <td><input type="checkbox" class="check" value="{$account.id}" name="selected[]"/></td>
    <td><a href="?cmd=accounts&action=edit&id={$account.id}&list={$currentlist}">{$account.id}</a></td>
    <td class="subjectline"><div class="df1"><div class="df2"><div class="df3"><a href="?cmd=clients&action=show&id={$account.client_id}">{$account.firstname} {$account.lastname}</a></div></div></div></td>
    <td class="subjectline"><div class="df1"><div class="df2"><div class="df3">{if $account.domain}<a href="?cmd=accounts&action=edit&id={$account.id}&list={$currentlist}">{$account.domain}</a>{else}-{/if}</div></div></div></td>
    <td><span class="{$account.status}">{$lang[$account.status]}</span></td>
    <td class="subjectline"><div class="df1"><div class="df2"><div class="df3">{$account.name}</div></div></div></td>
    <td>{$account.size} MB</td>
    <td>{$account.users}</td>
    <td>{$account.aliases}</td>
    <td>{if $account.billingcycle=='Free'}{$lang.Free}{else}{$account.total|price:$account.currency_id} <span class="fs11">({$lang[$account.billingcycle]})</span>{/if}</td>
    <td>{if $account.next_due == '0000-00-00'}-{else}{$account.next_due|dateformat:$date_format}{/if}</td>
    <td><a href="?cmd=accounts&action=edit&id={$account.id}&list={$currentlist}" class="editbtn">{$lang.Edit}</a></td>

</tr>
    {/foreach}
    {else}
<tr><td colspan="12"><p align="center" >{$lang.Click} <a href="?cmd=orders&action=add">{$lang.here}</a> {$lang.tocreateacc}</p></td></tr>
      {/if}