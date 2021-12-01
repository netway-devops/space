{if $payment}
    {if $url}
        <a href="{$url}" target="_blank" class="btn btn-sm btn-info">Initiated: {$payment}</a>
    {else}
        <button class="btn btn-sm btn-warning">Pending</button>
    {/if}
{else}
    <a href="?cmd=gocardless&action=paynow&invoice_id={$invoice.id}&security_token={$security_token}" class="btn btn-sm btn-success" onclick="return confirm('Are you sure?');">Charge</a>
{/if}