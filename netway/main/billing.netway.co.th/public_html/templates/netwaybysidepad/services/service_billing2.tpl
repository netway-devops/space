

<p class="bold">{$service.catname} - {$service.name} {
    if $upgrades && $upgrades!='-1'}
        <small>
            <a href="{$ca_url}clientarea/services/{$service.slug}/{$service.id}/&make=upgrades&upgradetarget=service" class="lmore">		
                {$lang.UpgradeDowngrade}
            </a>
        </small>
    {/if}
</p>
    
<div class="table-box">
    <div class="table-header">
        <p>{$lang.service}</p>
    </div>
    <table class="table table-striped account-details-tb tb-sh">
    
    {if $service.domain!=''}
        <tr>
            <td class="w30">{$lang.domain}</td>
            <td class="cell-border no-bold"><a target="_blank" href="http://{$service.domain}">{$service.domain}</a></td>
        </tr>
    {/if}
    
        <tr>
            <td class="w30">{$lang.status}</td>
            <td class="cell-border no-bold"><span class="label-{$lang[$service.status]}">{$lang[$service.status]}</span></td>
        </tr>
        
        {if $service.showbilling}
        <tr>
            <td class="w30">{$lang.registrationdate}</td>
            <td class="cell-border no-bold">{$service.date_created|date_format:'%d %b %Y'}</td>
        </tr>
        {if $service.firstpayment!=0 }
        <tr>
            <td class="w30">{$lang.firstpayment_amount}</td>
            <td class="cell-border no-bold">{$service.firstpayment|price:$currency}</td>
        </tr>
        {/if}
        
        {if $service.billingcycle!='Free' && $service.billingcycle!='Once' && $service.billingcycle!='One Time' && $service.total>0}
        <tr>
            <td class="w30">{if $service.billingcycle=='Hourly'}{$lang.curbalance}{else}{$lang.reccuring_amount}{/if}</td>
            <td class="cell-border no-bold">{$service.total|price:$currency} {if $service.billingcycle=='Hourly'}({$lang.updatedhourly}){/if}</td>
        </tr>
        {/if}
        
        {if $service.billingcycle!='Free' && $service.billingcycle!='Once' && $service.billingcycle!='One Time' && $service.next_due!='' && $service.next_due!='0000-00-00'}
        <tr>
            <td class="w30">{$lang.nextdue}</td>
            <td class="cell-border no-bold">{$service.next_due|date_format:'%d %b %Y'}</td>
        </tr>
        {/if}
        <tr>
            <td class="w30">{$lang.bcycle}</td>
            <td class="cell-border no-bold">{$lang[$service.billingcycle]}</td>
        </tr>
        {/if}
    </table>
   </div>