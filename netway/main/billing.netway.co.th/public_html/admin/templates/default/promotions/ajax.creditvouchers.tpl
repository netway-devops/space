{if $action=='display_codes'}
    {foreach from=$codes item=code}
        <tr>
            <td>{$code.id}</td>
            <td>{$code.code}</td>
            <td>{if $code.used_at}<span style="color: green;">Yes</span>{else}<span style="color: red;">No</span>{/if}
            </td>
            <td>
                {if $code.used_at}
                    <a href="?cmd=clients&action=show&id={$code.user_id}">#{$code.user_id} {$code.lastname} {$code.firstname}</a>
                {else}
                    -
                {/if}
            </td>
            <td>
                {if $code.used_at}
                    {$code.used_at|dateformat:$date_format}
                {else}
                    -
                {/if}
            </td>
            <td>
                <a href="#" onclick="deleteCode($(this),{$code.id});return false;"
                   class="btn btn-xs btn-default" style="color:red;">Delete</a>
            </td>
        </tr>
    {/foreach}
{else}
    {foreach from=$batches item=batch}
        <tr>
            <td><a href="?cmd=creditvouchers&action=manage_batch&id={$batch.id}">{$batch.name}</a></td>
            <td>
                {if $batch.code_layout == 4}
                    <small>Voucher code:</small>
                {else}
                    <small>Prefix:</small>
                {/if}
                <a href="?cmd=creditvouchers&action=manage_batch&id={$batch.id}">{$batch.prefix}</a>
            </td>
            <td>{$batch.created_at|dateformat:$date_format}</td>
            <td>{$batch.expires_at|dateformat:$date_format}</td>
            <td>{if strtotime($batch.expires_at) > time()}
                    <span style="color: green;">Yes</span>
                {else}
                    <span style="color: red;">No</span>
                {/if}</td>
            <td>{$currencies[$batch.currency_id].iso}</td>
            <td>{$batch.value|price:$batch.currency_id}</td>
            <td>{$batch.amount}</td>
            <td>{$batch.used}</td>
            <td>
                <a href="?cmd=creditvouchers&action=display_codes&id={$batch.id}"
                   class="btn btn-xs btn-default">List Codes</a>
                <a href="?cmd=creditvouchers&action=manage_batch&id={$batch.id}" class="btn btn-xs btn-info">Manage</a>
                <a href="?cmd=creditvouchers&action=delete_batch&id={$batch.id}&security_token={$security_token}"
                   class="btn btn-xs btn-default" style="color: red;"
                   onclick="return confirm('Are you sure you wish to remove this batch with codes?')">Delete</a>
            </td>
        </tr>
    {/foreach}
{/if}