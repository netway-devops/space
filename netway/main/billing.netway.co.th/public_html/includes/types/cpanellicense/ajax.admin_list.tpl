{if $accounts}
    {foreach from=$accounts item=account}
          <tr {if $account.manual=='1'}class="man"{/if}>
          <td><input type="checkbox" class="check" value="{$account.id}" name="selected[]"/></td>
          <td><a href="?cmd=accounts&action=edit&id={$account.id}&list={$currentlist}">{$account.id}</a></td>
          <td><a href="?cmd=clients&action=show&id={$account.client_id}">{$account.firstname} {$account.lastname}</a></td>
          <td>{if $account.extra_details.option1}{$account.extra_details.option1}{elseif $account.domain}{$account.domain}{else}-{/if}</td>
          <td>{$account.name}</td>
          <td>{$account.total|price:$account.currency_id}</td>
          <td>{$lang[$account.billingcycle]}</td>
          <td><span class="{$account.status}">{$lang[$account.status]}</span></td>
                <td>{if $account.next_due == '0000-00-00'}-{else}{$account.next_due|dateformat:$date_format}{/if}</td>
          <td><a href="?cmd=accounts&action=edit&id={$account.id}&list={$currentlist}" class="editbtn">{$lang.Edit}</a></td>

        </tr>
    {/foreach}
{/if}