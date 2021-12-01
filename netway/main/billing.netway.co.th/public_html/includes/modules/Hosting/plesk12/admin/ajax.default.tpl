{foreach from=$list item=account}
    <tr>
        <td>
            <input type="checkbox" name="selected[]" value="{$account.id}" class="check">
        </td>
        <td><a href="?cmd=accounts&action=edit&id={$account.id}" target="_blank">#{$account.id} {$account.domain}</a></td>
        <td><a href="?cmd=services&action=product&id={$account.product_id}" target="_blank">{$account.category} - {$account.name}</a></td>
        <td>{$account.synch_date}</td>
        <td>{$account.extra_details.user_id}</td>
        <td>{$account.extra_details.webspace_id}</td>
        <td></td>
    </tr>
{/foreach}