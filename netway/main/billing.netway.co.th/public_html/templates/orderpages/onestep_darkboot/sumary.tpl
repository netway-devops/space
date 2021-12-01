<div id="floating" class="clearfix">
    <h4>{$lang.ordersummary}</h4>
    <div class="cart-summary">
        {counter name=alter print=false start=1 assign=alter}
        <table>
            {if $product}
                <tr class="normal-bg">
                    <td class="left-cell">{$contents[0].category_name} - {$contents[0].name} {if $contents[0].domain}({$contents[0].domain}){/if}</td>
                    <td class="right-cell">

                        {if $contents[0].price==0}{$lang.Free}
                        {elseif $contents[0].prorata_amount}{$contents[0].prorata_amount|price:$currency:true:false:false} ({$lang.prorata} {$contents[0].prorata_date|dateformat:$date_format})
                        {else}{$contents[0].price|price:$currency:true:false:false}
                        {/if}

                        {if $contents[0].setup!=0} + {$contents[0].setup|price:$currency:true:false:false} {$lang.setupfee}
                        {/if}
                        {if $contents[0].recurring && $contents[0].price > 0}{assign value=$contents[0].recurring var=recurring}{$lang[$recurring]}
                        {elseif $contents[0].price > 0}{$lang.once}
                        {/if}
                    </td>
                </tr>
            {/if}
            {* FORMS *}
            {if $cart_contents[1]}
                {foreach from=$cart_contents[1] item=cstom2 key=cf}
                    {foreach from=$cstom2 item=cstom key=ci}
                        <tr class="{if $alter%2==0}normal-bg{else}darker-bg{/if}{if $cstom.price >0} border-bottom{/if}">
                            <td class="left-cell">
                                {if $cstom.type == 'slider' || $cstom.type == 'qty'}
                                    {$cstom.fullname}
                                {else}
                                    {$cstom.name}
                                {/if}
                            </td>
                            <td class="right-cell">
                                {if $cstom.type == 'slider' || $cstom.type == 'qty'}
                                    {$cstom.qty}
                                {else}
                                    {$cstom.sname}
                                {/if}

                            </td>
                        </tr>
                        {if $cstom.price >0}
                        <tr class="{if $alter%2==0}normal-bg{else}darker-bg{/if} border-top">
                            <td colspan="2" class="right-cell">
                                {if $cstom.price==0}{$lang.Free}
                                {elseif $cstom.prorata_amount}{$cstom.prorata_amount|price:$currency:true:false:false}
                                {else}{$cstom.price|price:$currency:true:false:false}
                                {/if} 

                                {if $cstom.recurring == 'once' && $cstom.price > 0}{$lang.once}
                                {/if}

                                {if $cstom.setup!=0} + {$cstom.setup|price:$currency:true:false:false} {$lang.setupfee}
                                {/if}
                            </td>
                        </tr>
                        {/if}
                        {counter name=alter}
                    {/foreach}
                {/foreach}
            {/if}
            {* ADDONS *}
            {if $contents[3]}
                {foreach from=$contents[3] item=addon}
                    <tr class="{if $alter%2==0}normal-bg{else}darker-bg{/if}">
                        <td class="left-cell">{$lang.addon} {$addon.name}</td>
                        <td class="right-cell">

                                {if $addon.price==0}{$lang.Free}
                                {elseif $addon.prorata_amount}{$addon.prorata_amount|price:$currency:true:false:false} ({$lang.prorata} {$addon.prorata_date|dateformat:$date_format})
                                {else}{$addon.price|price:$currency:true:false:false}
                                {/if}

                            {if $addon.setup!=0} + {$addon.setup|price:$currency:true:false:false} {$lang.setupfee}
                            {/if}

                            {if $addon.recurring}{assign value=$addon.recurring var=recurring}{$lang[$recurring]}
                            {elseif $addon.price > 0}{$lang.once}
                            {/if}
                        </td>
                    </tr>
                    {counter name=alter}
                {/foreach}
            {/if}

            {* SUBPRODUCTS *}
            {if $contents[4]}
                {foreach from=$contents[4] item=subprod}
                    <tr class="{if $alter%2==0}normal-bg{else}darker-bg{/if}">
                        <td class="left-cell">{$subprod.category_name} {$subprod.name}</td>
                        <td class="right-cell">

                                {if $subprod.price==0}{$lang.Free}
                                {elseif $subprod.prorata_amount}{$subprod.prorata_amount|price:$currency:true:false:false} ({$lang.prorata} {$subprod.prorata_date|dateformat:$date_format})
                                {else}{$subprod.price|price:$currency:true:false:false}
                                {/if}

                            {if $subprod.setup!=0} + {$subprod.setup|price:$currency:true:false:false} {$lang.setupfee}
                            {/if}

                            {if $subprod.recurring}{assign value=$subprod.recurring var=recurring}{$lang[$recurring]}
                            {elseif $subprod.price > 0}{$lang.once}
                            {/if}
                        </td>
                    </tr>
                    {counter name=alter}
                {/foreach}
            {/if}
            {* DOMAINS *}
            {if $contents[2] && $contents[2][0].action!='own'}
                {foreach from=$contents[2] item=domenka key=kk}
                    <tr class="{if $alter%2==0}normal-bg{else}darker-bg{/if}">
                        <td class="left-cell">
                            {$domenka.name}
                        </td>
                        <td class="right-cell">

                                {$domenka.price|price:$currency:true:false:false}
                            {$domenka.period}&nbsp;{$lang.years}
                            {if $domenka.dns}&raquo; {$lang.dnsmanage} (+ {$domenka.dns|price:$currency:true:false:false})<br/>
                            {/if}
                            {if $domenka.idp}&raquo; {$lang.idprotect}(+ {$domenka.idp|price:$currency:true:false:false})<br/>
                            {/if}
                            {if $domenka.email}&raquo; {$lang.emailfwd} (+ {$domenka.email|price:$currency:true:false:false})<br/>
                            {/if}
                        </td>
                    </tr>
                    {counter name=alter}
                {/foreach}
            {/if}
            {if $tax}
                {if $subtotal.coupon}  
                    <tr class="{if $alter%2==0}normal-bg{else}darker-bg{/if}"{counter name=alter}>
                        <td class="left-cell">{$lang.discount}</td>
                        <td class="right-cell">- {$subtotal.discount|price:$currency:true:false:false}</td>
                    </tr>  
                {/if}
                {if $tax.tax1 && $tax.taxed1!=0}
                    <tr class="{if $alter%2==0}normal-bg{else}darker-bg{/if}"{counter name=alter}>
                        <td class="left-cell">{$tax.tax1name} @ {$tax.tax1}%  </td>
                        <td class="right-cell">{$tax.taxed1|price:$currency:true:false:false}</td>
                    </tr>
                {/if}
                {if $tax.tax2  && $tax.taxed2!=0}
                    <tr class="{if $alter%2==0}normal-bg{else}darker-bg{/if}"{counter name=alter}>
                        <td class="left-cell">{$tax.tax2name} @ {$tax.tax2}%  </td>
                        <td class="right-cell">{$tax.taxed2|price:$currency:true:false:false}</td>
                    </tr>
                {/if}
                {if $tax.credit!=0}
                    <tr class="{if $alter%2==0}normal-bg{else}darker-bg{/if}"{counter name=alter}>
                        <td class="left-cell">{$lang.credit} </td>
                        <td class="right-cell">{$tax.credit|price:$currency:true:false:false}</td>
                    </tr>
                {/if}
            {elseif $credit}
                {if  $credit.credit!=0}
                    <tr class="{if $alter%2==0}normal-bg{else}darker-bg{/if}"{counter name=alter}>
                        <td class="left-cell">{$lang.credit} </td>
                        <td class="right-cell">{$credit.credit|price:$currency:true:false:false}</td>
                    </tr>
                {/if}
                {if $subtotal.coupon}  
                    <tr class="{if $alter%2==0}normal-bg{else}darker-bg{/if}"{counter name=alter}>
                        <td class="left-cell">{$lang.discount}</td>
                        <td class="right-cell">- {$subtotal.discount|price:$currency:true:false:false}</td>
                    </tr>  
                {/if}
            {else}
                {if $subtotal.coupon}  
                    <tr class="{if $alter%2==0}normal-bg{else}darker-bg{/if}"{counter name=alter}>
                        <td class="left-cell">{$lang.discount}</td>
                        <td class="right-cell">- {$subtotal.discount|price:$currency:true:false:false}</td>
                    </tr>  
                {/if}
            {/if}
            {if !empty($tax.recurring) || !empty($subtotal.recurring)}
                <tr class="last-row">
                    <td class="left-cell">{$lang.total_recurring}</td>
                    <td class="right-cell">
                        {if !empty($tax.recurring)}
                            {foreach from=$tax.recurring item=rec key=k}
                                <p class="recurring">{$rec|price:$currency:true:false:false} {$lang.$k}</p>
                            {/foreach}
                        {elseif !empty($subtotal.recurring)}
                            {foreach from=$subtotal.recurring item=rec key=k}
                                <p class="recurring">{$rec|price:$currency:true:false:false} {$lang.$k}</p>
                            {/foreach} 
                        {/if}
                    </td>

                </tr>
            {/if}
        </table>
        {if !$subtotal.coupon}
            <a href="#" class="promo-code" onclick="$(this).fadeOut('fast',{literal}function(){$(this).next().fadeIn()}{/literal}); return false">{$lang.promotionalcode}</a>
            <div class="coupon-field form-horizontal" style="display:none">
                <form onsubmit="applyCoupon(this); return false">
                    <div class="btn-group">
                        <input id="couponcde" class="coupon-input" name="promocode" placeholder="{$lang.usecoupon}">
                        <a href="#" class="btn" onclick="$(this).parents('form').submit();return false;">Ok</a>
                    </div>
                </form>
            </div>
        {else}
        <a href="#" class="promo-code" onclick="removeCoupon(); return false" title="{$lang.remove_coupon}">{$subtotal.coupon} <i class="icon icon-remove icon-white" style="vertical-align: sub"></i></a>
        {/if}

    </div>

    {if $billingcycles==2}
        <p>{$lang.billoptions}</p>
        <div class="billing-slider">
            {counter name=cyclect start=0 print=false assign=cyclect}
            {foreach from=$product item=p_price key=p_cycle}
                {if $p_cycle == 'd' || $p_cycle == 'w' || $p_cycle == 'm' || $p_cycle == 'q' || $p_cycle == 's' || $p_cycle == 'a' || $p_cycle == 'b' || $p_cycle == 't' || $p_cycle == 'p4' || $p_cycle == 'p5'}
                    {if $p_price > 0}
                        <div class="billing-mask{if $cyclect>0}-right{else}-left{/if}">
                            <div class="billing{if $cyclect>0}-right{else}-left{/if}-option {if $cycle==$p_cycle}active-billing{/if}" rel="{$p_cycle}">
                                <span class="text-center">{$lang.$p_cycle}</span>
                            </div>
                        </div>
                        {counter name=cyclect}
                    {/if}
                {/if}

            {/foreach}
        </div>
    {/if}

    <div class="current-total">
        <span>{$lang.currenttotal}</span>
        <p>
            {if $tax}
                {if $tax.total>9999}{$tax.total|price:$currency:true:false:false:0}
                {else}{$tax.total|price:$currency:true:false:false|regex_replace:'/\d+$/':''}<small>{$tax.total|price:$currency:true:false:false:2|regex_replace:'/.*(\d\d)$/':'$1'}</small>
                {/if}
            {elseif $credit}
                {if $credit.total>9999}{$tax.total|price:$currency:true:false:false:0}
                {else}{$credit.total|price:$currency:true:false:false|regex_replace:'/\d+$/':''}<small>{$tax.total|price:$currency:true:false:false:2|regex_replace:'/.*(\d\d)$/':'$1'}</small>
                {/if}
            {else}
                {if $subtotal.total>9999}{$tax.total|price:$currency:true:false:false:0}
                {else}{$subtotal.total|price:$currency:true:false:false|regex_replace:'/\d+$/':''}<small>{$tax.total|price:$currency:true:false:false:2|regex_replace:'/.*(\d\d)$/':'$1'}</small>
                {/if}
            {/if}
        </p>
    </div>
</div>