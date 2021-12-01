{if $service.flavor_enabled && $service.showbilling && ($service.status=='Active' || $service.status=='Suspended')}
    <div class="mseparator"></div>
    <div id="pricingdetails">
        <div style="margin-bottom:8px;padding-bottom:2px;border-bottom:1px solid #DADBDD">
            <h3 class="summarize left" style="border-bottom:none;margin:0px;padding:0px;">
                {$lang.usagedetails}
            </h3>

            <div class="clear"></div>
        </div>
        <div id="pricingtable">
            <table class="table">
                <thead>
                    <tr>
                        <th>{$lang.Description}</th>
                        <th>{$lang.flavor_hours_qty}</th>
                        <th>{$lang.price}</th>
                    </tr>
                </thead>
                <tbody>
                    {foreach from=$service.flavor_usage key=da item=val name=usageloop}
                        {if $val.total_on}
                            <tr >
                                <td>
                                    {if $val.parent_id}&nbsp;-&nbsp;{/if}
                                    {$val.descr_on}
                                <td>{$val.hours_on}</td>
                                <td>{$val.total_on|price:$currency:1:1}</td>
                            </tr>
                        {/if}
                        {if $val.total_off}
                            <tr >
                                <td>
                                    {if $val.parent_id}&nbsp;-&nbsp;{/if}
                                    {$val.descr_off}
                                </td>
                                <td>{$val.hours_off}</td>
                                <td>{$val.total_off|price:$currency:1:1}</td>
                            </tr>
                        {/if}
                    {/foreach}
                </tbody>
                <tfoot>
                    <tr>
                        <th colspan="2" style="text-align: right">{$lang.total}</th>
                        <th>{$service.flavor.total|price:$currency}</th>
                    </tr>
                </tfoot>
            </table>
        </div>
        <div class="clear"></div>
    </div>
{/if}