{if $payment}
    <a href="?cmd=worldpay_futurepay&action=paynow&invoice_id={$invoice.id}&security_token={$security_token}" class="btn btn-sm btn-warning"
       onclick="return confirm('The transaction has the Pending status, do you still want to charge?');">Pending</a>
{else}
    <a href="?cmd=worldpay_futurepay&action=paynow&invoice_id={$invoice.id}&security_token={$security_token}" class="btn btn-sm btn-success" onclick="return confirm('Are you sure?');">Charge</a>
{/if}