{if $estimates}
    {foreach from=$estimates item=estimate name=foo}
        <tr>
            <td>
                <span class="badge badge-estimate-{$estimate.status}">{$lang[$estimate.status]}</span>
            </td>
            <td class="bold invoice-c">
                {if $estimate.status != 'Invoiced'}
                    <a href="?action=estimate&amp;id={$estimate.hash}" class="roll-link">
                        <span data-title="#{$estimate.id}">#{$estimate.id}</span>
                    </a>
                {else}
                    <span data-title="#{$estimate.id}">#{$estimate.id}</span>
                {/if}
            </td>
            <td>{$estimate.total|price:$estimate.currency_id}</td>
            <td>
                {$estimate.date_expires|dateformat:$date_format}
            </td>
            <td>
                {if $estimate.status != 'Invoiced'}
                    <a href="?action=estimate&amp;id={$estimate.hash}">
                        <i class="material-icons icon-info-color">link</i>
                    </a>
                {/if}
            </td>
        </tr>
        {foreachelse}
        <tr><td colspan="3">{$lang.nothing}</td></tr>
    {/foreach}
{/if}
