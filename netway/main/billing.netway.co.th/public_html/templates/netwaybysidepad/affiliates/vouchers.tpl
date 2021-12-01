
<div class="text-block clear clearfix">

    {include file='affiliates/summary.tpl'}

    <div class="clear clearfix">
        <div class="table-box">
            <div class="table-header">
                <div class="right-btns-l">
                    <a href="{$ca_url}{$cmd}/addvoucher/" class="clearstyle btn green-custom-btn l-btn"><i class="icon-white-add"></i> {$lang.newvoucher}</a>
                </div>
                <h6>{$lang.promocodes}</h6>
                <p class="inline-block header-p">{$lang.voucherinfo}</p>
            </div>
            <table class="table table-striped table-hover promo-codes">
                <tr class="table-header-high">
                    <th class="w30">{$lang.vouchercode}</th>
                    <th class="w10 cell-border">{$lang.discount}</th>
                    <th class="w15 cell-border">{$lang.margin}</th>
                    <th class="w15 cell-border">{$lang.used}</th>
                        {if 'config:AffVAudience:1'|checkcondition}
                        <th class="cell-border">{$lang.audience}</th>
                        {/if}
                    <th class="w15 cell-border">{$lang.expires}</th>
                    <th class="w10 cell-border"></th>
                </tr>
            </table>
            {if $vouchers}
                <table class="table table-striped table-hover promo-codes">
                    {foreach from=$vouchers item=voucher name=vouchers}
                        <tr>
                            <td class="bold">{$voucher.code}</td>
                            <td class="cell-border">
                                {if $voucher.type=='Percent'}{$voucher.value}%
                                {else}{$voucher.value|price:$affiliate.currency_id}
                                {/if}
                            </td>
                            <td class="cell-border">
                                {if $voucher.type=='Percent'}{$voucher.margin}%
                                {else}{$voucher.margin|price:$affiliate.currency_id}
                                {/if}
                            </td>
                            <td class="cell-border">
                                {$voucher.num_usage}
                            </td>
                            {if 'config:AffVAudience:1'|checkcondition}
                                <td>
                                    {if $voucher.clients=='new'}
                                        {$lang.newcustommers}
                                    {elseif $voucher.clients=='existing'}
                                        {$lang.existingcustommers}
                                    {else}
                                        {$lang.allcustommers}
                                    {/if}
                                </td>
                            {/if}
                            <td class="cell-border">
                                {if $voucher.expires|date_format:'%d %b %Y'}{$voucher.expires|date_format:'%d %b %Y'}
                                {else}-
                                {/if}
                            </td>
                            <td class="cell-border center-cell">
                                <span id="tool-1" class="config-service-inset">
                                    <a href="{$ca_url}{$cmd}/{$action}/&make=delete&id={$voucher.id}&security_token={$security_token}"><i class="icon-trash"></i></a>
                                </span>
                            </td>
                        </tr>
                    {/foreach}
                </table>
            {else}
                <div class="no-results">
                    <p>{$lang.nothing}</p>
                </div>
            {/if}
        </div>
    </div>
</div>
