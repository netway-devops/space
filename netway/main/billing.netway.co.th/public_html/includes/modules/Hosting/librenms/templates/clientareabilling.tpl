{if $bandwidth}
     
<table class="table table-striped fullscreen" width="100%" cellspacing="0" cellpadding="6">
   <tr>
         <td colspan="2"><h3>{$lang.bandwidthlimit}: {$bandwidth.formatted.limit}, {$lang.used}: {$bandwidth.formatted.used}{if $bandwidth.over},
                 <b style="color:red">{$lang.overage}: {$bandwidth.formatted.overage}</b>{/if} </h3>
</td>
     </tr>
     <tr>
         <td align="right" width="160">{$lang.overagerate}:</td>
        <td >{$bandwidth.cost|price:$currency:1:1} / 1 {$bandwidth.overage_unit}</td>
     </tr>

     <tr>
        <td align="right">{$lang.currentoveragecharge}:</td>
        <td >{$bandwidth.charge|price:$currency:1:1}</td>
     </tr>
     <tr>
        <td align="right">{$lang.projectedusage}:</td>
        <td >{$bandwidth.projected_usage}</td>
     </tr>
     {if $bandwidth.projected_overage}
      <tr>
        <td align="right">{$lang.projectedoverage}:</td>
        <td  style="color:red">{$bandwidth.projected_overage}</td>
     </tr>
      <tr>
        <td align="right">{$lang.projectedoveragecharge}:</td>
        <td><b style="color:red">{$bandwidth.projected_charge|price:$currency:1:1}</b></td>
     </tr>
     {/if}
</table>
{/if}