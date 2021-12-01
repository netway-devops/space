{include file="$tplPath/admin/header.tpl"}
<table cellpadding="2" cellspacing="2" width="80%">
<tr>
    <td><b>Pricing and offers on:</b></td>
    <td>{$msPricingOn}</td>
</tr>
<tr>
    <td width="250"><b>Subscriptions data from MSP on:</b></td>
    <td>{$timestampLastUpdateData|date_format:'%d %b %Y'}</td>
</tr>
<tr>
    <td><b>Total customer on MSP:</b></td>
    <td>{$totalCustomers} User(s).</td>
</tr>
<tr>
    <td><b>Total active subscription on MSP:</b></td>
    <td>{$totalSubscription} Subscription(s).</td>
</tr>
</table>

{if isset($aDebug)}
<pre>{$aDebug|@print_r}</pre>
{/if}
<script language="JavaScript">
{literal}

{/literal}
</script>

{include file="$tplPath/admin/footer.tpl"}