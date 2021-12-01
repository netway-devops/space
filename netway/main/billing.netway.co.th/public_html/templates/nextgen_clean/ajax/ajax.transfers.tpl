{foreach from=$transfers item=transfer name=foo}
    <tr>
        <td>{$transfer.rel_type}</td>
        <td>{$transfer.name}</td>
        <td>
            {if $transfer.companyname}
                {$transfer.companyname} ({$transfer.firstname} {$transfer.lastname})
            {else}
                {$transfer.firstname} {$transfer.lastname}
            {/if}
        </td>
        <td>{$transfer.date_request|date_format}</td>
        <td>
            <a class="btn btn-sm btn-success" href="?cmd=clientarea&action=transfers&rel_id={$transfer.rel_id}&rel_type={$transfer.rel_type}&make=approve&security_token={$security_token}">{$lang.approve}</a>
            <a class="btn btn-sm btn-danger" href="?cmd=clientarea&action=transfers&rel_id={$transfer.rel_id}&rel_type={$transfer.rel_type}&make=reject&security_token={$security_token}">{$lang.reject}</a>
        </td>
    </tr>
{foreachelse}
    <tr><td colspan="100%" class="text-center">{$lang.nothing}</td></tr>
{/foreach}