{if $previous}
    <a href="https://www.mollie.com/dashboard/payments/{$previous.transaction_id}" target="_blank" class="btn btn-sm btn-info">Sepa initiated: {$previous.transaction_id}</a>
    {else}
    <a href="?cmd=mollie_nl_modern&action=paynow&invoice_id={$invoice.id}&security_token={$security_token}" class="btn btn-sm btn-success" onclick="return confirm('Are you sure?');">Charge Sepa DD</a>
{/if}