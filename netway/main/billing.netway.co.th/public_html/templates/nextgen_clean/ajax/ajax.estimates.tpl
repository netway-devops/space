{if $estimates}
    {foreach from=$estimates item=estimate name=foo}
        <tr>
            <td style="padding-left: 22px;">
                <span class="label flat-ui-label label-{$estimate.status}">{$lang[$estimate.status]}</span>
            </td>
            <td class="bold invoice-c" style="padding-left: 22px;">
                {if $estimate.status != 'Invoiced'}
                    <a href="?action=estimate&amp;id={$estimate.hash}" class="roll-link">
                        <span data-title="#{$estimate.id}">#{$estimate.id}</span>
                    </a>
                {else}
                    <span data-title="#{$estimate.id}">#{$estimate.id}</span>
                {/if}
            </td>
            <td style="padding-left: 22px;">{$estimate.total|price:$estimate.currency_id}</td>
            <td style="padding-left: 22px;">
                {$estimate.date_expires|dateformat:$date_format}
            </td>
            <td style="padding-left: 22px;">
                {if $estimate.status != 'Invoiced'}
                    <a href="?action=estimate&amp;id={$estimate.hash}">
                        {$lang.view}
                    </a>
                {else}
                    <i class="icon-link" style="color: #5f5f5f"></i>
                {/if}
            </td>
        </tr>
        {foreachelse}
        <tr><td colspan="3">{$lang.nothing}</td></tr>
    {/foreach}
{/if}
