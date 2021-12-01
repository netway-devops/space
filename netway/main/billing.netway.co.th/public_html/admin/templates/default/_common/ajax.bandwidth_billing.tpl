{if $bandwidth}
<h1 style="font-size:20px">
    Limit: {$bandwidth.formatted.limit},
    Used: {$bandwidth.formatted.used}
    {if $bandwidth.over},
        <b style="color:red">Overage: {$bandwidth.formatted.overage}</b>
    {/if}
</h1>

<table class="whitetable" width="100%" cellspacing="0" cellpadding="6">
    <tr>
        <td width="200" align="right">Billing method:</td>
        <td width="300">
            <b>
                {if $bandwidth.model=='total'}
                    Total transfer
                {elseif $bandwidth.model=='average'}
                    Average
                {else}
                    95th percentile
                {/if}
            </b>
        </td>
        <td width="200" align="right">Period:</td>
        <td><b>{$bandwidth.period_from} - {$bandwidth.period_to}</b></td>
     </tr>
     <tr>
        <td align="right">Overage rate:</td>
        <td colspan="3">{$bandwidth.cost|price:$account.currency_id:1:1} / 1 {$bandwidth.overage_unit}</td>
     </tr>

     <tr>
        <td align="right">Current overage charge:</td>
        <td colspan="3">{$bandwidth.charge|price:$account.currency_id:1:1}</td>
     </tr>
      <tr>
        <td align="right">Projected usage:</td>
        <td colspan="3">{$bandwidth.projected_usage}</td>
     </tr>
      <tr>
        <td align="right">Projected overage:</td>
        <td colspan="3">{$bandwidth.projected_overage}</td>
     </tr>
      <tr>
        <td align="right">Projected overage charge:</td>
        <td colspan="3">{$bandwidth.projected_charge|price:$account.currency_id:1:1}</td>
     </tr>
</table>
{else}
<em>Bandwidth billing is not enabled in related package.</em>
{/if}