{if $bandwidth}
     
<table class="table table-striped fullscreen" width="100%" cellspacing="0" cellpadding="6">
   <tr>
         <td colspan="2"><h3>Bandwidth limit: {$bandwidth.formatted.limit}, Used: {$bandwidth.formatted.used}{if $bandwidth.over},
                 <b style="color:red">Overage: {$bandwidth.formatted.overage}</b>{/if} </h3>
</td>
     </tr>
     <tr>
         <td align="right" width="160">Overage rate:</td>
        <td >{$bandwidth.cost|price:$currency:1:1} / 1 {$bandwidth.overage_unit}</td>
     </tr>

     <tr>
        <td align="right">Current overage charge:</td>
        <td >{$bandwidth.charge|price:$currency:1:1}</td>
     </tr>
     <tr>
        <td align="right">Projected usage:</td>
        <td >{$bandwidth.projected_usage}</td>
     </tr>
     {if $bandwidth.projected_overage}
      <tr>
        <td align="right">Projected overage:</td>
        <td  style="color:red">{$bandwidth.projected_overage}</td>
     </tr>
      <tr>
        <td align="right">Projected overage charge:</td>
        <td><b style="color:red">{$bandwidth.projected_charge|price:$currency:1:1}</b></td>
     </tr>
     {/if}
</table>
{/if}