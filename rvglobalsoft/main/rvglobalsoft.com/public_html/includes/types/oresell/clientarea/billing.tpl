{include file="`$reselldir`header.cloud.tpl"}
<div class="header-bar">
    <h3 class="{$vpsdo} hasicon">Billing</h3>
    <div class="clear"></div>
</div>
<div class="content-bar ">
    <h3 class="summarize">Summary</h3>
    <table cellpadding="0" cellspacing="0" class="ttable" width="100%" style="margin-top:0px">
        <tr>
            <td class="title" width="160" align="right"><b>{$lang.registrationdate}</b></td>
            <td  width="268">{$service.date_created|dateformat:$date_format}</td>
            <td class="title" align="right"  width="160"><b>{$lang.status}</b></td>
            <td   width="268"><span class="{$service.status}"><strong>{$lang[$service.status]}</strong></span></td>
        </tr>
        {if $service.showbilling &&  $service.billingcycle!='Free' && $service.billingcycle!='Once'}

        <tr>
            <td class="title" align="right"><b>{if $service.billingcycle=='Hourly' || $service.metered}{$lang.curbalance}{else}{$lang.reccuring_amount}{/if}</b></td>
            <td> 
                {if $service.metered_total}   
                    {$service.metered_total|price:$currency}
                 {else}
                    {$service.total|price:$currency}{/if}
                <span class="fs11">{if $service.billingcycle=='Hourly'}({$lang.updatedhourly}){elseif $service.metered}({$lang.Metered}){else}({$lang[$service.billingcycle]}){/if}</span>
              </td>
            {if $service.billingcycle!='Free' && $service.billingcycle!='Once'}
            <td class="title" align="right"><b>Next invoice:</b></td>
            <td>{$service.next_invoice|dateformat:$date_format}</td>
            {else}
            <td colspan="2"></td>
            {/if}
        </tr>
        {/if}
            </table>
    <div class="mseparator"></div>
            


		{if $addons}
                <table cellpadding="0" cellspacing="0" class="ttable" width="100%">
        <tr><td colspan="4"><div>

                    <strong>{$lang.accaddons|capitalize}</strong>


                    <div >
                        <table width="100%" cellspacing="0" cellpadding="0" border="0" class="checker">

                            <tr><td colspan="2" style="border:none">


                                    <table cellspacing="0" cellpadding="0" border="0" width="100%" class="styled">
                                        <colgroup class="firstcol"></colgroup>
                                        <colgroup class="alternatecol"></colgroup>
                                        <colgroup class="firstcol"></colgroup>
                                        <colgroup class="alternatecol"></colgroup>

                                        <tbody>
                                            <tr>
                                                <th width="40%" align="left">{$lang.addon}</th>
                                                <th align="left">{$lang.price}</th>
                                                <th>{$lang.nextdue}</th>
                                                <th >{$lang.status}</th>

                                            </tr>
	{foreach from=$addons item=addon name=foo}
                                            <tr {if $smarty.foreach.foo.index%2 == 0}class="even"{/if}>
                                                <td>{$addon.name}</td>
                                                <td>{$addon.recurring_amount|price:$currency}</td>
                                                <td align="center">{$addon.next_due|dateformat:$date_format}</td>
                                                <td align="center" ><span class="{$addon.status}">{$lang[$addon.status]}</span></td>

                                            </tr>

	{/foreach}
                                        </tbody>

                                    </table>



                                </td></tr>
                        </table>
                    </div></div></td></tr>
        {/if}

    </table>
</div>

{include file="`$reselldir`footer.cloud.tpl"}