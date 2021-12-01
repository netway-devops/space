{foreach from=$connections item=connect}
    <tr>
        <td>
            <a href="?cmd={$modulename}&action=edit&id={$connect.id}">{$connect.id}</a>
        </td>
        <td>
            <a href="?cmd={$modulename}&action=edit&id={$connect.id}">{$connect.name}</a>
        </td>
        <td>
            <a href="?cmd={$modulename}&action=edit&id={$connect.id}">{$connect.api_key|truncate:8}</a>
        </td>
        <td>
            {if $connect.ote}
                <span class="label label-warning">OTE</span>
            {else}
                <span class="label label-success">Live</span>
            {/if}
        </td>
        <td>
            {if $connect.display}
                <span class="label label-success">Enabled</span>
            {else}
                <span class="label label-danger">Disabled</span>
            {/if}
        </td>
        <td>
            <a class="new_control" href="#" id="testing_button"
               data-id="{$connect.id}"
               data-api_key="{$connect.api_key}"
               data-ote="{$connect.ote}"
               onclick="testConfiguration(this);
                    return false;"><span class="wizard">Test Configuration</span></a>
            <div class="btn-group">
                <a href="?cmd={$modulename}&action=edit&id={$connect.id}"
                   class="btn btn-primary btn-sm">
                    <i class="fa fa-pencil"></i>
                </a>
                <a href="?cmd={$modulename}&action=delete&id={$connect.id}&security_token={$security_token}"
                   class="btn btn-danger btn-sm"
                   onclick="return confirm('Are you sure you want to remove this connection?')">
                    <i class="fa fa-trash-o"></i>
                </a>
            </div>
        </td>
    </tr>
    {foreachelse}
    <tr>
        <td colspan="8" style="text-align: center">
            No connections added yet.
        </td>
    </tr>
{/foreach}