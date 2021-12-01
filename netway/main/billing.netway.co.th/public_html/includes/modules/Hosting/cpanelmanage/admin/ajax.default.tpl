{foreach from=$licenses item=license}
    {if empty($license.status)}
        {assign var=label value="primary"}
    {elseif $license.status == 'Active'}
        {assign var=label value="success"}
    {elseif $license.status == 'Request Timeout' || $license.response_code >= 500}
        {assign var=label value="danger"}
    {else}
        {assign var=label value="warning"}
    {/if}

    <tr class="{if $label != 'primary' && $label != 'success'}{$label}{/if}">
        <td>
            <input class="to-check" type="checkbox" name="license[]" value="{$license.id}">
        </td>
        <td>
            <span>{$license.ip}</span>
        </td>
        <td>
            <span class="label label-{$label}">{if $license.response_code != 0}{$license.response_code}:
                    {/if}{if empty($license.status)}Not checked{else}{$license.status}{/if}</span>
        </td>
        <td>
            {if $license.account_id}
                <a href="?cmd=accounts&action=edit&id={$license.account_id}" target="_blank">#{$license.account_id}</a>
            {else}
                <span>---</span>
            {/if}
        </td>
        <td>
            {if $license.account_id && isset($clients[$license.account_id])}
                {$clients[$license.account_id]|@profilelink}
            {else}
                <span>---</span>
            {/if}
        </td>
        <td>
            {if $license.date}
                <span>{$license.date|dateformat}</span>
            {else}
                <span>---</span>
            {/if}
        </td>
        <td>
            <a href="http://{$license.ip}:2086" target="_blank">http://{$license.ip}:2086</a>
        </td>
        <td>
            <span>{$license.error}</span>
        </td>
    </tr>
    {foreachelse}
    <tr>
        <td colspan="8" style="text-align: center">
            No license found yet
        </td>
    </tr>
{/foreach}