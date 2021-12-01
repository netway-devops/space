{if $bandwidth}
    {if strpos($tpl_name, '2019') !== false}
        <h4 class="mt-5 mb-3">{$lang.bandwidth_limit} {$bandwidth.formatted.limit}, {$lang.used} {$bandwidth.formatted.used}
            {if $bandwidth.over},
                <b style="color:red">{$lang.overage} {$bandwidth.formatted.overage}</b>
            {/if}
        </h4>
        <section class="bordered-section mt-3 service-details">
            <div class="service-details-line p-4">
                <small class="d-block font-weight-bold mb-2">{$lang.overage_rate}</small>
                <span class="text-small break-word">{$bandwidth.cost|price:$currency:1:1} / 1 {$bandwidth.overage_unit}</span>
            </div>
            <div class="service-details-line p-4">
                <small class="d-block font-weight-bold mb-2">{$lang.current_overage_charge}</small>
                <span class="text-small break-word">{$bandwidth.charge|price:$currency:1:1}</span>
            </div>
            <div class="service-details-line p-4">
                <small class="d-block font-weight-bold mb-2">{$lang.projected_usage}</small>
                <span class="text-small break-word">{$bandwidth.projected_usage}</span>
            </div>
            {if $bandwidth.projected_overage}
                <div class="service-details-line p-4">
                    <small class="d-block font-weight-bold mb-2">{$lang.projected_overage}</small>
                    <span class="text-small break-word" style="color: red">{$bandwidth.projected_overage}</span>
                </div>
                <div class="service-details-line p-4">
                    <small class="d-block font-weight-bold mb-2">{$lang.projected_overage_charge}</small>
                    <span class="text-small break-word" style="color: red">{$bandwidth.projected_charge|price:$currency:1:1}</span>
                </div>
            {/if}
        </section>
    {else}
        <table class="table table-striped fullscreen" width="100%" cellspacing="0" cellpadding="6">
            <tr>
                <td colspan="2"><h3>{$lang.bandwidth_limit} {$bandwidth.formatted.limit}, {$lang.used} {$bandwidth.formatted.used}{if $bandwidth.over},
                            <b style="color:red">{$lang.overage} {$bandwidth.formatted.overage}</b>{/if} </h3>
                </td>
            </tr>
            <tr>
                <td align="right" class="w30 bold">{$lang.overage_rate}</td>
                <td >{$bandwidth.cost|price:$currency:1:1} / 1 {$bandwidth.overage_unit}</td>
            </tr>

            <tr>
                <td align="right" class="w30 bold">{$lang.current_overage_charge}</td>
                <td >{$bandwidth.charge|price:$currency:1:1}</td>
            </tr>
            <tr>
                <td align="right" class="w30 bold">{$lang.projected_usage}</td>
                <td >{$bandwidth.projected_usage}</td>
            </tr>
            {if $bandwidth.projected_overage}
                <tr>
                    <td align="right" class="w30 bold">{$lang.projected_overage}</td>
                    <td  style="color:red">{$bandwidth.projected_overage}</td>
                </tr>
                <tr>
                    <td align="right" class="w30 bold">{$lang.projected_overage_charge}</td>
                    <td><b style="color:red">{$bandwidth.projected_charge|price:$currency:1:1}</b></td>
                </tr>
            {/if}
        </table>
    {/if}
{/if}