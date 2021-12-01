{foreach from=$webhooks item=hook}
    <tr>
        <td>
            <a href="?cmd={$modulename}&action=edit&id={$hook.id}">{$hook.id}</a>
        </td>
        <td>
            <code>{$hook.url}</code>
        </td>
        <td>
            <a href="?cmd={$modulename}&action=details&id={$hook.id}">{$hook.name|escape}</a>
        </td>
        <td>
            <span class="label label-default label-{if $hook.options.active}success{else}default{/if}">{if $hook.options.active}Active{else}Disabled{/if}</span>
        </td>
        <td>
            {$hook.created_at|dateformat:$date_format}
        </td>
        <td>
            <a href="?cmd={$modulename}&delete&selected={$hook.id}"
               class="btn btn-danger btn-xs"
               onclick="return confirm('Are you sure you want to remove this webhook?')">
                <i class="fa fa-trash-o"></i>
            </a>
        </td>
    </tr>
    {foreachelse}
    <tr>
        <td colspan="8">
            No webhooks added yet.
        </td>
    </tr>
{/foreach}