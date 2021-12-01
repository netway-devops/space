<!-- Right Column -->
<div class="right-column right">

    <!-- Payment Details -->
    <div class="payment left">
        <h2 class="openSansLightItalic">{$lang.paymentdetails}<span></span></h2>
        <div class="payment-period">

            <div class="payment-period-select">
                <p class="openSansBold left">
                    {foreach from=$product item=p_price key=p_cycle}
                        {if $p_cycle == $cycle}
                            {if $p_price > 0}
                                <p class="openSansBold left" rel="{$p_cycle}">{$lang.$p_cycle} {$lang.payment} ({$p_price|price:$currency:true:false:false:2:true})</p>
                            {/if}
                        {/if}
                    {/foreach}
                </p>
                <span></span>
            </div>
            <div class="payment-period-list clearfix">
                {price product=$product}
                    <p class="openSansBold left" rel="@@cycle">@@cyclename {$lang.payment} (@@price)</p>
                {/price}
            </div>
        </div>

        <div class="summary clearfix">
            <table class="center openSansBold">
                <tr>
                    <th>{$lang.Description}</th> 
                    <th>{$lang.price}</th>
                </tr>
                {if $product}
                    <tr>
                        <td>{$contents[0].category_name}: {$contents[0].name}</td>
                        <td>
                            {if $contents[0].price==0}
                                {$lang.Free}
                            {elseif $contents[0].prorata_amount}
                                {$contents[0].prorata_amount|price:$currency:true:false:false}
                                ({$lang.prorata} {$contents[0].prorata_date|dateformat:$date_format})
                            {else}
                                {$contents[0].price|price:$currency:true:false:false}
                            {/if}
                            {if $cyclecount == 1 && $contents[0].recurring && $contents[0].price > 0}
                                {assign value=$contents[0].recurring var=recurring}{$lang[$recurring]}
                            {/if}


                            {if $contents[0].setup!=0}
                                <br />
                                <small>+ {$contents[0].setup|price:$currency:true:false:false} {$lang.setupfee}</small>
                            {/if}
                        </td>
                    </tr>
                {/if}
                {if $cart_contents[1]}
                    {foreach from=$cart_contents[1] item=cstom2}
                        {foreach from=$cstom2 item=cstom}
                            {if ($cstom.price > 0 || $cstom.itname != $cstom.name || $cstom.qty > 1) && $cstom.itname != $lang.none}
                                <tr>
                                    <td>
                                        {$cstom.itname}  {if $cstom.qty>=1}x {$cstom.qty}
                                        {/if}
                                    </td>
                                    <td>
                                        {if $cstom.price==0}
                                            -
                                        {elseif $cstom.prorata_amount}
                                            {$cstom.prorata_amount|price:$currency:true:false:false}
                                        {else}
                                            {$cstom.price|price:$currency:true:false:false}
                                        {/if} 

                                        {if $cstom.setup!=0} 
                                            <br />
                                            <small>+ {$cstom.setup|price:$currency:true:false:false} {$lang.setupfee}</small>
                                        {/if}
                                    </td>
                                </tr>
                            {/if}
                        {/foreach}
                    {/foreach}
                {/if}
                {* ADDONS *}
                {if $contents[3]}
                    {foreach from=$contents[3] item=addon}
                        <tr>
                            <td>{$lang.addon} -{$addon.name}</td>
                            <td>
                                {if $addon.price==0}
                                    -
                                {elseif $addon.prorata_amount}
                                    <strong>{$addon.prorata_amount|price:$currency:true:false:false}</strong> ({$lang.prorata} {$addon.prorata_date|dateformat:$date_format})
                                {else}
                                    <strong>{$addon.price|price:$currency:true:false:false}</strong>
                                {/if}


                                {if $addon.recurring && $addon.recurring != 'free'}
                                    {assign value=$addon.recurring var=recurring}{$lang[$recurring]}
                                {elseif $addon.price > 0}
                                    {$lang.once}
                                {/if}

                                {if $addon.setup!=0} 
                                    <br />
                                    <small>+ {$addon.setup|price:$currency:true:false:false} {$lang.setupfee}</small>

                                {/if}
                            </td>
                        </tr>
                    {/foreach}
                {/if}
                {* DOMAINS *}
                {if $contents[2] && $contents[2][0].action!='own'}
                    {foreach from=$contents[2] item=domenka key=kk}
                        <tr>
                            <td>
                                {if $domenka.action=='register'}
                                    {$lang.domainregister}:
                                {elseif $domenka.action=='transfer'}
                                    {$lang.domaintransfer}:
                                {/if}
                                {$domenka.name}
                            </td>
                            <td>
                                {if $domenka.dns}
                                    &raquo; {$lang.dnsmanage} (+ {$domenka.dns|price:$currency:true:false:false})<br/>
                                {/if}
                                {if $domenka.idp}
                                    &raquo; {$lang.idprotect}(+ {$domenka.idp|price:$currency:true:false:false})<br/>
                                {/if}
                                {if $domenka.email}
                                    &raquo; {$lang.emailfwd} (+ {$domenka.email|price:$currency:true:false:false})<br/>
                                {/if}
                                <strong>{$domenka.price|price:$currency:true:false:false}</strong>

                                {$domenka.period} {$lang.years}
                            <td>
                        </tr>
                    {/foreach}
                {/if}
                {* SUBPRODUCTS *}
                {if $contents[4]}

                    {foreach from=$contents[4] item=subprod}
                        <tr>
                            <td>{$subprod.category_name}: {$subprod.name}</td>
                            <td>
                                {if $subprod.price==0}
                                    -
                                {elseif $subprod.prorata_amount}
                                    <strong> {$subprod.prorata_amount|price:$currency:true:false:false}</strong>
                                    ({$lang.prorata} {$subprod.prorata_date|dateformat:$date_format})
                                {else}
                                    <strong>{$subprod.price|price:$currency:true:false:false}</strong>
                                {/if}
                                </span>	
                                {if $subprod.recurring && $subprod.recurring != 'free' }
                                    {assign value=$subprod.recurring var=recurring}{$lang[$recurring]}
                                {elseif $subprod.price > 0}
                                    {$lang.once}
                                {/if}

                                {if $subprod.setup!=0} 
                                    <br />
                                    <small> + {$subprod.setup|price:$currency:true:false:false} {$lang.setupfee}</small>
                                {/if}
                            </td>
                        </tr>
                    {/foreach}
                {/if}

                <tr>
                    <td class="openSansRegular">{$lang.total_recurring}</td>
                    <td>
                        {if !empty($tax.recurring)}
                            {foreach from=$tax.recurring item=rec key=k}
                                {$rec|price:$currency} {$lang.$k}<br/>
                            {/foreach}
                        {elseif !empty($subtotal.recurring)}
                            {foreach from=$subtotal.recurring item=rec key=k}
                                {$rec|price:$currency} {$lang.$k}<br/>
                            {/foreach}
                        {/if}
                    </td>
                </tr>
            </table>
            <div class="total-summary right">
                <p class="openSansRegular text-right">{$lang.total_today}:</p>
                <p class="openSansBold text-right">

                    {if $tax}
                        {$tax.total|price:$currency}
                    {elseif $credit}
                        {$credit.total|price:$currency}
                    {else}
                        {$subtotal.total|price:$currency}
                    {/if}
                </p>
            </div>
        </div>

        <!-- Promotional Code -->
        <div class="promotional-code clearfix">
            <a href="#" onclick="$(this).hide();
                        $('#promocode').sh
                        ow();
                        return false;" class="openSansBold left">{$lang.usecoupon}</a>
            <span class="right"></span>
            <div id="promocode" style="display:none;" class="left">
                <form action="" method="post" id="promoform" onsubmit="{if $step!=4}return applyCoupon();{/if}" class="openSansBold">
                    <input type="hidden" name="addcoupon" value="true" />
                    <small style="font-size: 12px">{$lang.code}:</small> <input type="text" class="styled" style="width: 100px;" name="promocode"/> <input type="submit" value="GO!" class="padded btn"/>
                </form>
            </div>
        </div>
        <!-- Order Now -->
        <div class="order-now">
            <div class="order-now-button">
                <a href="#" class="openSansBold text-center" onclick="$('#configuration').fadeOut('fast', function(){literal} {$('#checkout').fadeIn();}{/literal});$(this).hide().next().show();return false;">{$lang.ordernow}</a>
                <a href="#" class="openSansBold text-center" onclick="$('#orderform').submit();return false;">{$lang.checkout}</a>
            </div>
        </div>
    </div>
</div>

<div id="configuration" class="left-column left">
    <!-- Current Selection -->
    <div class="current-selection left">
        <h2 class="openSansLightItalic">{$lang.currentselection}<span></span></h2>
        <form id="cart3" >
            {counter start=$counter_start name=form_custom_counter print=false assign=form_custom_counter}
            <input type="hidden" name="custom[-1]" value="dummy" />
            <input type="hidden" name="addon[0]" value="0" />
            <input type="hidden" name="subproducts[0]" value="0" />
            {if $product.hostname}
                <div class="server-detail control-plus {if $form_custom_counter % 2 == 0}server-detail-dark{else}server-detail-light{/if} {if $form_custom_counter == 0}first{/if}">
                    <p class="openSansBold domain-option">{$lang.hostname}*</p>
                    <div class="openSansBold form-inline"> 
                        <input name="domain" style="width: 99%" value="{$item.domain}" class="styled" size="50" onchange="if (typeof simulateCart == 'function')
                                simulateCart();"/>
                    </div>
                </div>
                {counter name=form_custom_counter}
            {/if}
            {if $custom }
                {foreach from=$custom item=cf}
                    {include file="onestep_premade/forms.tpl"}
                    {counter name=form_custom_counter}
                {/foreach}
            {/if}
            {if $addons }
                {foreach from=$addons item=a key=k}
                    <div class="server-detail control-plus {if $form_custom_counter % 2 == 0}server-detail-dark{else}server-detail-light{/if} {if $form_custom_counter == 0}first{/if}">

                        <div class="openSansBold right form-inline"> 
                            {price product=$a}
                            {if $a.paytype=='Free'}
                                <span class="product-cycle cycle-free">{$lang.free}</span>
                                <input type="hidden" name="addon_cycles[{$k}]" value="free"/>
                            {elseif $a.paytype=='Once'}
                                <span class="product-price cycle-once">@@price</span>
                                <span class="product-cycle cycle-once">{$lang.once}</span>
                                {if $a.m_setup!=0}<span class="product-setup cycle-once">@@setupline</span>
                                {/if}
                                <input type="hidden" name="addon_cycles[{$k}]" value="once"/>
                            {else}
                                <select name="addon_cycles[{$k}]" >
                                    <option value="@@cycle" @@selected>@@line</option>
                                </select>
                            {/if}
                            {/price}
                        </div>
                        <p class="openSansBold option-empty"><input name="addon[{$k}]" type="checkbox" value="1" {if $selected_addons.$k}checked="checked"{/if} onchange="simulateCart();"/> {$a.name}</p>
                        {if $a.description!=''}<div class="cart-addon-descr clear" >{$a.description}</div>
                        {/if}
                    </div>
                    {counter name=form_custom_counter}
                {/foreach}
            {/if}
            {if $subproducts }
                {foreach from=$subproducts item=a key=k}
                    <div class="server-detail control-plus {if $form_custom_counter % 2 == 0}server-detail-dark{else}server-detail-light{/if} {if $form_custom_counter == 0}first{/if}">
                        
                        <div class="openSansBold right form-inline">
                            {price product=$a}
                            {if $a.paytype=='Free'}
                                <span class="product-cycle cycle-free">{$lang.free}</span>
                                <input type="hidden" name="subproducts_cycles[{$k}]" value="free"/>
                            {elseif $a.paytype=='Once'}
                                <span class="product-price cycle-once">@@price</span>
                                <span class="product-cycle cycle-once">{$lang.once}</span>
                                {if $a.m_setup!=0}<span class="product-setup cycle-once">@@setupline<<' + '@</span>
                                {/if}
                                <input type="hidden" name="subproducts_cycles[{$k}]" value="once"/>
                            {else}
                                <select name="subproducts_cycles[{$k}]" >
                                    <option value="@@cycle" @@selected>@@line</option>
                                </select>
                            {/if}
                            {/price}
                        </div>
                        <p class="openSansBold option-empty"> <input name="subproducts[{$k}]" type="checkbox" value="1" {if $selected_subproducts.$k}checked="checked"{/if} onchange="simulateCart();"/> {$a.category_name} - {$a.name}</p>
                        {if $a.description!=''}<div class="cart-subproduct-descr clear" >{$a.description}</div>
                        {/if}
                    </div>
                    {counter name=form_custom_counter}
                {/foreach}
            {/if}
            <input id="cycle2" name="cycle" value="{$cycle}" type="hidden"/>
        </form>
        <div class="server-detail control-plus {if $form_custom_counter % 2 == 0}server-detail-dark{else}server-detail-light{/if} {if $form_custom_counter == 0}first{/if}">
            {include file="common/onestep_domains.tpl" show_tabs=true}
        </div>
    </div>
</div>
<script type="text/javascript">rebind_after_ajax();</script>