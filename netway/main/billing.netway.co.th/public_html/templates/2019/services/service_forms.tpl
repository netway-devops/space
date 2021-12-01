{if $service.custom}
    <h4 class="mt-5 mb-3">{if $service_details}{$lang[$service_details]}{else}{$lang.servicedetails}{/if}</h4>
    <section class="bordered-section mt-3 service-details">
        {foreach from=$service.custom item=cst}
            <div class="service-details-line p-4">
                <small class="d-block font-weight-bold mb-2">{$cst.name}</small>
                <span class="text-small break-word">
                    {if "acl_user:billing.serviceprices"|checkcondition}
                        {include file=$cst.configtemplates.clientarea}
                    {else}
                        {include file=$cst.configtemplates.clientarea hide_price=true}
                    {/if}
                </span class="text-small">
            </div>
        {/foreach}
    </section>
{/if}

