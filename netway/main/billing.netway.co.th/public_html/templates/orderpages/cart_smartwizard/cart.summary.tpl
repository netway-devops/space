<!-- Right Column -->
<div class="right-column right">
    <div class="order-summary-box" id="cartSummary">
        <div class="bg-arrow-1"></div>
        <div class="order-summary-pattern">
            <div class="order-summary">
                <h2 class="openSansBold">{$lang.cartsum1} <span class="ajax-indicator"></span></h2>
            </div>
        </div>

        {counter name=darkbg print=false start=1 assign=darkbg}

        <div class="order-header-title-row center">
            <div class="order-left-cell">
                <p>{$lang.Description}</p>
            </div>

            <div class="order-right-cell">
                <p>{$lang.price}</p>
            </div>
        </div>
        <div class="underline-title center">
            <span class="underline-title-bold"></span>
        </div>
        {if !$step}
            <div class="order-row center blank">
                <h3>{$lang.yourcartisempty}</h3>
            </div>
        {else}

            {if $cart_contents[0]}
                <div class="order-row center clearfix {if $darkbg%2==0}dark-bg{/if}{counter name=darkbg}">
                    <div class="order-left-cell">
                        <p class="openSansBold">
                            {$cart_contents[0].category_name} - {$cart_contents[0].name}
                            {assign var=tit value=$cart_contents[0].recurring}
                            {if $cart_contents[0].price!=0}<br />{$lang[$tit]}
                            {/if}
                            {if $cart_contents[0].setup!=0}
                                <br/>
                                {$lang.setupfee}
                            {/if}
                        </p>
                    </div>

                    <div class="order-right-cell">
                        <p>
                            {if $cart_contents[0].price!=0}
                                <br/>
                                {$cart_contents[0].price|price:$currency:true:false:false} 
                            {else}
                                {$lang.Free}
                            {/if}
                            {if $cart_contents[0].setup!=0}
                                <br/>
                                {$cart_contents[0].setup|price:$currency} 
                            {/if}
                        </p>
                    </div>
                </div>
            {/if}
            {if $cart_contents[1]}
                {foreach from=$cart_contents[1] item=cstom2}
                    {foreach from=$cstom2 item=cstom} 
                        {if $cstom.total>0}
                            <div class="order-row center clearfix {if $darkbg%2==0}dark-bg{/if}{counter name=darkbg}">
                                <div class="order-left-cell">
                                    <p>{$cstom.sname} {if $cstom.qty>=1}x {$cstom.qty}{/if}</p>
                                </div>

                                <div class="order-right-cell">
                                    <p>{$cstom.total|price:$currency:true:false:false}</p>
                                </div>
                            </div>
                        {/if}
                    {/foreach}
                {/foreach}
            {/if}	
            {foreach from=$cart_contents[4] item=subprod}
                <div class="order-row center clearfix {if $darkbg%2==0}dark-bg{/if}{counter name=darkbg}">
                    <div class="order-left-cell">
                        <p>
                            {$subprod.category_name} - {$subprod.name}
                            {assign var=tit value=$subprod.recurring}
                            {if $subprod.price!=0}<br />{$lang[$tit]}
                            {/if}
                            {if $subprod.setup!=0}
                                <br/>
                                {$lang.setupfee}
                            {/if}
                        </p>
                    </div>

                    <div class="order-right-cell">
                        <p>
                            {if $subprod.price!=0}
                                <br/>
                                {$subprod.price|price:$currency:true:false:false} 
                            {else}
                                {$lang.Free}
                            {/if}
                            {if $subprod.setup!=0}
                                <br/>
                                {$subprod.setup|price:$currency} 
                            {/if}
                        </p>
                    </div>
                </div>
            {/foreach}

            {foreach from=$cart_contents[3] item=addon}
                <div class="order-row center clearfix {if $darkbg%2==0}dark-bg{/if}{counter name=darkbg}">
                    <div class="order-left-cell">
                        <p>
                            {$lang.addon} {$addon.name}
                            {assign var=tit value=$addon.recurring}
                            {if $addon.price!=0}<br />{$lang[$tit]}
                            {/if}
                            {if $addon.setup!=0}
                                <br/>
                                {$lang.setupfee}
                            {/if}
                        </p>
                    </div>

                    <div class="order-right-cell">
                        <p>
                            {if $addon.price!=0}
                                <br/>
                                {$addon.price|price:$currency:true:false:false} 
                            {else}
                                {$lang.Free}
                            {/if}
                            {if $addon.setup!=0}
                                <br/>
                                {$addon.setup|price:$currency} 
                            {/if}
                        </p>
                    </div>
                </div>
            {/foreach}
            {if $cart_contents[2] && $cart_contents[2][0].name!='yep'}
                {foreach from=$cart_contents[2] item=domenka key=kk}
                    {if $domenka.action!='own'  && $domenka.action!='hostname'}
                        <div class="order-row center clearfix {if $darkbg%2==0}dark-bg{/if}{counter name=darkbg}">
                            <div class="order-left-cell">
                                <p>
                                    {if $domenka.action=='register'}{$lang.domainregister}
                                    {elseif $domenka.action=='transfer'}{$lang.domaintransfer}
                                    {elseif $domenka.action=='renew'}{$lang.domainrenewal}
                                    {/if} 
                                    {$domenka.period} {$lang.years}
                                    <br />{$domenka.name}
                                    {if $domenka.forms}
                                        {foreach from=$domenka.forms item=cstom2 name=domainfo}
                                            {foreach from=$cstom2 item=cstom}
                                                {if $cstom.total>0}
                                                    <br /><small>{$cstom.sname} {if $cstom.qty>=1}x {$cstom.qty}{/if}</small>
                                                {/if}
                                            {/foreach}
                                        {/foreach}
                                    {/if}
                                </p>
                            </div>

                            <div class="order-right-cell">
                                <p><br />
                                    {$domenka.price|price:$currency:true:false:false}
                                    {if $domenka.forms}
                                        {foreach from=$domenka.forms item=cstom2 name=domainfo}
                                            {foreach from=$cstom2 item=cstom}
                                                {if $cstom.total>0}
                                                    <br />{$cstom.total|price:$currency:true:false:false}
                                                {/if}
                                            {/foreach}
                                        {/foreach}
                                    {/if}
                                </p>
                            </div>
                        </div>
                    {/if}
                {/foreach}
            {/if}


            {if $step > 3}
                <div class="underline-title center">
                    <span class="underline-title-bold"></span>
                </div>
                {if $tax}
                    <div class="order-row center clearfix {if $darkbg%2==0}dark-bg{/if}{counter name=darkbg} unpad">
                        <div class="order-left-cell">
                            <p>{$lang.subtotal}</p>
                        </div>
                        <div class="order-right-cell">
                            <p>{$tax.subtotal|price:$currency:true:false:false}</p>
                        </div>
                    </div>
                    {if $tax.tax1 && $tax.taxed1!=0}
                        <div class="order-row center clearfix {if $darkbg%2==0}dark-bg{/if}{counter name=darkbg} unpad">
                            <div class="order-left-cell">
                                <p>{$tax.tax1name} @ {$tax.tax1}%</p>
                            </div>
                            <div class="order-right-cell">
                                <p>{$tax.taxed1|price:$currency:true:false:false}</p>
                            </div>
                        </div>

                    {/if}
                    {if $tax.tax2  && $tax.taxed2!=0}
                        <div class="order-row center clearfix {if $darkbg%2==0}dark-bg{/if}{counter name=darkbg} unpad">
                            <div class="order-left-cell">
                                <p>{$tax.tax2name} @ {$tax.tax2}%</p>
                            </div>
                            <div class="order-right-cell">
                                <p>{$tax.taxed2|price:$currency:true:false:false}</p>
                            </div>
                        </div>

                    {/if}
                    {if $tax.credit!=0}
                        <div class="order-row center clearfix {if $darkbg%2==0}dark-bg{/if}{counter name=darkbg} unpad">
                            <div class="order-left-cell">
                                <p>{$lang.credit}</p>
                            </div>
                            <div class="order-right-cell">
                                <p>{$tax.credit|price:$currency:true:false:false}</p>
                            </div>
                        </div>
                    {/if}
                {elseif $credit}
                    {if  $credit.credit!=0}
                        <div class="order-row center clearfix {if $darkbg%2==0}dark-bg{/if}{counter name=darkbg} unpad">
                            <div class="order-left-cell">
                                <p>{$lang.credit}</p>
                            </div>
                            <div class="order-right-cell">
                                <p>{$credit.credit|price:$currency:true:false:false}</p>
                            </div>
                        </div>
                    {/if}
                    <div class="order-row center clearfix {if $darkbg%2==0}dark-bg{/if}{counter name=darkbg} unpad">
                        <div class="order-left-cell">
                            <p>{$lang.subtotal}</p>
                        </div>
                        <div class="order-right-cell">
                            <p>{$subtotal.total|price:$currency:true:false:false}</p>
                        </div>
                    </div>
                {else}
                    <div class="order-row center clearfix {if $darkbg%2==0}dark-bg{/if}{counter name=darkbg} unpad">
                        <div class="order-left-cell">
                            <p>{$lang.subtotal}</p>
                        </div>
                        <div class="order-right-cell">
                            <p>{$subtotal.total|price:$currency:true:false:false}</p>
                        </div>
                    </div>
                {/if}

                {if !empty($tax.recurring)}
                    <div class="order-row center clearfix {if $darkbg%2==0}dark-bg{/if}{counter name=darkbg} unpad">
                        <div class="order-left-cell">
                            <p>{$lang.total_recurring}
                                {foreach from=$tax.recurring item=rec key=k}
                                    <br />{$lang.$k}
                                {/foreach}
                            </p>
                        </div>
                        <div class="order-right-cell">
                            <p>
                                {foreach from=$tax.recurring item=rec key=k}
                                    <br/>{$rec|price:$currency:true:false:false}
                                {/foreach}
                            </p>
                        </div>
                    </div>
                {elseif !empty($subtotal.recurring)}
                    <div class="order-row center clearfix {if $darkbg%2==0}dark-bg{/if}{counter name=darkbg} unpad">
                        <div class="order-left-cell">
                            <p>{$lang.total_recurring}
                                {foreach from=$subtotal.recurring item=rec key=k}
                                    <br />{$lang.$k}
                                {/foreach}
                            </p>
                        </div>
                        <div class="order-right-cell">
                            <p>
                                {foreach from=$subtotal.recurring item=rec key=k}
                                    <br/>{$rec|price:$currency:true:false:false}
                                {/foreach}
                            </p>
                        </div>
                    </div>
                {/if}
            {/if}
            {if $subtotal.coupon}
                <div class="order-row center clearfix {if $darkbg%2==0}dark-bg{/if}{counter name=darkbg} unpad">
                    <div class="order-left-cell">
                        <p>
                            {$lang.discount}
                        </p>
                    </div>

                    <div class="order-right-cell">
                        <p>
                            - {$subtotal.discount|price:$currency:true:false:false}
                        </p>
                    </div>
                </div>
            {/if}
            <br />
            <div class="payment-row">
                <div class="bg-arrow-2"></div>
                <div class="order-header-title-row center">
                    <div class="order-left-cell">
                        <p>{$lang.usecoupon}</p>
                    </div>
                </div>
                <div class="underline-title center">
                    <span class="underline-title-bold"></span>
                </div>
                {if $subtotal.coupon}
                    <div class="order-row center openSansBold">
                        <form id="remove" method="post" action="">
                            <input type="hidden" name="step" value="{$step}" />
                            <input type="hidden" name="removecoupon" value="true" />
                        </form>
                        <a href="#" onclick="{if $step!=4}return removeCoupon();{else}$('#remove').submit();{/if} return false;">{$lang.removecoupon}</a>
                    </div>
                {else}
                    <div class="order-row center openSansBold">
                        <form action="" method="post" id="promoform" onsubmit="return applyCoupon();">
                            <input type="hidden" name="step" value="{$step}" />
                            <input name="promocode" type="text" class="coupon-input openSansSemiBold" placeholder="Your code here...">
                        </form>
                    </div>
                {/if}
            </div>
        {/if}
        <div class="total-price-bg">
            <div class="total-price-box-pattern">
                <div class="total-price-box">
                    <div class="cart-img"></div>
                    <p class="openSansBold">{$lang.total_today}</p>
                    <h5 class="openSansBold">
                        <span class="ajax-indicator-dark"></span>
                        {if $tax}
                            {$currency.sign}{$tax.total|price:$currency:false}
                        {elseif $credit}
                            {$currency.sign}{$credit.total|price:$currency:false}
                        {else}
                            {$currency.sign}{$subtotal.total|price:$currency:false}
                        {/if}
                    </h5>
                </div>
            </div>
        </div>
    </div>
</div> 
<script type="text/javascript"> $('.ajax-indicator, .ajax-indicator-dark').hide(); </script>