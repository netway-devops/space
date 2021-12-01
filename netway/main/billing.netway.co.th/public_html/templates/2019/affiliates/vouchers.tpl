{include file="affiliates/top_nav.tpl"}

<h5 class="my-5">{$lang.voucherinfo}</h5>

<section class="section-affiliates">
    <div class="table-responsive table-borders table-radius">
        <table class="table vouchers-table position-relative stackable">
            <thead>
                <tr>
                    <th></th>
                    <th>{$lang.vouchercode}</th>
                    <th>{$lang.discount}</th>
                    <th>{$lang.margin}</th>
                    <th>{$lang.used}</th>
                    {if 'config:AffVAudience:1'|checkcondition}
                        <th>{$lang.audience}</th>
                    {/if}
                    <th>{$lang.expires}</th>
                    <th class="text-md-right text-left">
                        <a href="#" onclick="delete_vouchers(); return false" class="btn btn-sm btn-danger">{$lang.deleteselected}</a>
                    </th>
                </tr>
            </thead>
            <tbody>
            {if $vouchers}
                {foreach from=$vouchers item=voucher name=vouchers}
                    <tr>
                        <td>
                            <input type="checkbox"/>
                        </td>
                        <td data-label="{$lang.vouchercode}">{$voucher.code}</td>
                        <td data-label="{$lang.discount}">
                            {if $voucher.type=='Percent'}{$voucher.value}%
                            {else}{$voucher.value|price:$affiliate.currency_id}
                            {/if}
                        </td>
                        <td data-label="{$lang.margin}">
                            {if $voucher.type=='Percent'}{$voucher.margin}%
                            {else}{$voucher.margin|price:$affiliate.currency_id}
                            {/if}
                        </td>
                        <td data-label="{$lang.used}">
                            {$voucher.num_usage}
                        </td>
                        {if 'config:AffVAudience:1'|checkcondition}
                            <td data-label="{$lang.audience}">
                                {if $voucher.clients=='new'}
                                    {$lang.newcustommers}
                                {elseif $voucher.clients=='existing'}
                                    {$lang.existingcustommers}
                                {else}
                                    {$lang.allcustommers}
                                {/if}
                            </td>
                        {/if}
                        <td data-label="{$lang.expires}">
                            {if $voucher.expires|dateformat:$date_format}{$voucher.expires|dateformat:$date_format}
                            {else}-
                            {/if}
                        </td>
                        <td class="text-md-right text-left">
                            <a href="{$ca_url}{$cmd}/{$action}/&make=delete&id={$voucher.id}&security_token={$security_token}" class="btn btn-sm btn-danger">
                                <i class="material-icons size-sm">delete</i>
                            </a>
                        </td>
                    </tr>
                {/foreach}
            {else}
                <tr>
                    <td colspan="8" class="text-center">{$lang.nothing}</td>
                </tr>
            {/if}
            </tbody>
        </table>
    </div>
</section>