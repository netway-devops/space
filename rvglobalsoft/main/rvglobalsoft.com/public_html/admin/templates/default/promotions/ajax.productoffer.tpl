{foreach from=$list item=item}
    <tr>
        <td>
            <a href="?cmd={$cmd}&action=edit&id={$item.id}">{$item.id}</a>
        </td>
        <td><a href="?cmd={$cmd}&action=edit&id={$item.id}">{$item.name|escape}</a></td>
        <td>
            <span class="{if $item.status}Active{else}Pending{/if}">{$item.status_name}</span>
        </td>
        <td>
            {if $item.expire_at}
                {$item.expire_at|dateformat:$date_format}
            {else} - {/if}
        </td>
        <td>{$item.description|escape}</td>
        <td widtd="20">
            <a href="?cmd={$cmd}&action=delete&id={$item.id}&security_token={$security_token}"
               class="btn btn-xs btn-danger"
               onclick="return confirm('Are you sure you wish to remove this offer?')">Delete</a>
        </td>
    </tr>
    {foreachelse}
    <tr>
        <td colspan="7" class="text-center">{$lang.nothingtodisplay}</td>
    </tr>
{/foreach}