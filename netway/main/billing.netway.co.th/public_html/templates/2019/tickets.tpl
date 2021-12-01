{if $newticket}
    {include file='support/addticket.tpl'}
{/if}

{if $ticketcreated}
    <h1 class="mb-3">{$lang.ticketcreated} <a href="{$ca_url}tickets/view/{$tnum}/&amp;hash={$thash}">#{$tnum}</a></h1>
    <p>{$lang.tcreatednfo}</p>
    <a href="{$ca_url}tickets/view/{$tnum}/&amp;hash={$thash}" class="btn btn-primary">{$lang.viewticket}</a>
{/if}

{if $ticket}
    {include file='support/viewticket.tpl'}
{/if}

{if $action=='default' || $action=='_default'}
    {include file='support/listtickets.tpl'}
{/if}

{if $action=='rate_ticket'}
    {include file="support/rateticket.tpl"}
{/if}

{if $action=='report_reply'}
    {include file="support/reportreply.tpl"}
{/if}

{if $action=='report_ticket'}
    {include file="support/reportticket.tpl"}
{/if}