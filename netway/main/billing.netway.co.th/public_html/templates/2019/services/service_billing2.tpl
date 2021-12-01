<p>
{if $upgrades && $upgrades!='-1'}
    <small>
        <a href="{$ca_url}clientarea/services/{$service.slug}/{$service.id}/&make=upgrades&upgradetarget=service">
            {$lang.UpgradeDowngrade}
        </a>
    </small>
{/if}
</p>
<section class="bordered-section mt-3 service-details">
    {if $service.domain!=''}
        <div class="service-details-line p-4">
            <small class="d-block font-weight-bold mb-2">{$lang.domain}</small>
            <a href="http://{$service.domain}" target="_blank">
                <span class="text-small break-word" data-title="{$service.domain}">{$service.domain}</span>
            </a>
        </div>
    {/if}
    {if $service.showbilling}
        <div class="service-details-line p-4">
            <small class="d-block font-weight-bold mb-2">{$lang.registrationdate}</small>
            <span class="text-small break-word">{$service.date_created|dateformat:$date_format}</span>
        </div>
        {if $service.firstpayment!=0  && "acl_user:billing.serviceprices"|checkcondition}
            <div class="service-details-line p-4">
                <small class="d-block font-weight-bold mb-2">{$lang.firstpayment_amount}</small>
                <span class="text-small break-word">{$service.firstpayment|price:$currency}</span>
            </div>
        {/if}
        <hr>
        {if $service.billingcycle!='Free' && $service.billingcycle!='Once' && $service.billingcycle!='One Time' && $service.total>0 && "acl_user:billing.serviceprices"|checkcondition}
            <div class="service-details-line p-4">
                <small class="d-block font-weight-bold mb-2">{if $service.billingcycle=='Hourly'}{$lang.curbalance}{else}{$lang.reccuring_amount}{/if}</small>
                <span class="text-small break-word">{$service.total|price:$currency} {if $service.billingcycle=='Hourly'}({$lang.updatedhourly}){/if}</span>
            </div>
        {/if}
        {if $service.billingcycle!='Free' && $service.billingcycle!='Once' && $service.billingcycle!='One Time' && $service.next_due!='' && $service.next_due!='0000-00-00'}
            <div class="service-details-line p-4">
                <small class="d-block font-weight-bold mb-2">{$lang.nextdue}</small>
                <span class="text-small break-word">{$service.next_due|dateformat:$date_format}</span>
            </div>
        {/if}
        <div class="service-details-line p-4">
            <small class="d-block font-weight-bold mb-2">{$lang.bcycle}</small>
            <span class="text-small break-word">{$lang[$service.billingcycle]}</span>
        </div>

        {if $service.commitment_date != '0000-00-00'}
            <div class="service-details-line p-4">
                <small class="d-block font-weight-bold mb-2">{$lang.commitmentdate}</small>
                <span class="text-small break-word">{$service.commitment_date|dateformat:$date_format}</span>
            </div>
        {/if}
    {/if}
</section>
