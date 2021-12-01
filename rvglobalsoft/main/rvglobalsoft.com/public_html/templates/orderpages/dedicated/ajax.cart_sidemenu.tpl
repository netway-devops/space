<span class="bT"></span>
<div class="bC">
    <h1 class="h1">
        <span class="s1"  id="pre_indicator"></span>
        <span class="s2">{$lang.cartsum1}</span>

    </h1>
    {counter start=2 print=false assign=alter }
    <ul id="products">
        {if $cart_contents[0]}
            <li class="i2 odd">
                <span class="s1"></span>
                <span class="s2">{$cart_contents[0].name}</span>
                <span class="s3">{$cart_contents[0].price|price:$currency}</span>
            </li>
        {/if}
        {if $cart_contents[1]}

            {foreach from=$cart_contents[1] item=cstom2 name=foo}
                {foreach from=$cstom2 item=cstom}
                    {if $cstom.total>0}
                        {counter}
                        {debug output=chrome var=cstom}
                        <li class="i2 {if $alter%2==0}odd{/if}"><span class="s1"></span>
                            <span class="s2">{$cstom.name} {if $cstom.hasQty}x {$cstom.qty}{/if}</span>
                            {if $cstom.itname !=$cstom.name}<span title="{$cstom.itname}">&nbsp;- {$cstom.sname}</span>{/if}
                            <span class="s3">{$cstom.total|price:$currency}</span></li>
                        {/if}
                    {/foreach}
                {/foreach}

        {/if}

        {foreach from=$cart_contents[3] item=addon name=foo}
            {counter}
            <li class="i2 {if $alter%2==0}odd{/if}"><span class="s1"></span>
                <span class="s2">{$lang.addon} <strong>{$addon.name}</strong></span>
                <span class="s3">
                    {$addon.price|price:$currency}</span></li>

        {/foreach}
        {foreach from=$cart_contents[4] item=addon name=foo}
            {counter}
            <li class="i2 {if $alter%2==0}odd{/if}"><span class="s1"></span>
                <span class="s2">{$addon.category_name} <strong>{$addon.name}</strong></span>
                <span class="s3">
                    {$addon.price|price:$currency}</span></li>

        {/foreach}

        {if $subtotal.coupon}
            <li class="i2  ">
                <span class="s1"></span>
                <span class="s2" >{$lang.discount}</span>
                <span class="s3">- {$subtotal.discount|price:$currency}</span>
            </li>
        {/if}
    </ul>
    <h1 class="h2">
        <span class="s1"></span>
        <span class="s2">{$lang.ordersummary}</span>
    </h1>
    <p class="price">

        {if $progress<6}
            <span class="s2">{$lang.total_today} <strong>{$subtotal.total|price:$currency}</strong></span>
        {else}

            {if $tax}
                <span class="s1">{$lang.subtotal} <strong> {$tax.subtotal|price:$currency}</strong></span>

                {if $tax.tax1 && $tax.taxed1!=0}
                    <span class="s1">{$tax.tax1name} @ {$tax.tax1}%  <strong> {$tax.taxed1|price:$currency}</strong></span>
                {/if}

                {if $tax.tax2  && $tax.taxed2!=0}
                    <span class="s1">{$tax.tax2name} @ {$tax.tax2}%   <strong> {$tax.taxed2|price:$currency}</strong></span>
                {/if}

                {if $tax.credit!=0}
                    <span class="s1">{$lang.credit} <strong> {$tax.credit|price:$currency}</strong></span>
                {/if}

            {elseif $credit}
                {if  $credit.credit!=0}
                    <span class="s1">{$lang.credit} <strong> {$credit.credit|price:$currency}</strong></span>
                {/if}

                <span class="s1">{$lang.subtotal} <strong> {$subtotal.total|price:$currency}</strong></span>
            {else}

                <span class="s1">{$lang.subtotal} <strong> {$subtotal.total|price:$currency}</strong></span>

            {/if}

            {if !empty($tax.recurring)}
                <span class="s1">{$lang.total_recurring}
                    <strong> 
                        {foreach from=$tax.recurring item=rec key=k}
                            {$rec|price:$currency} {$lang.$k}<br/>
                        {/foreach}</strong>
                </span>

            {elseif !empty($subtotal.recurring)}
                <span class="s1">{$lang.total_recurring}
                    <strong>  
                        {foreach from=$subtotal.recurring item=rec key=k}
                            {$rec|price:$currency} {$lang.$k}<br/>
                        {/foreach} </strong>
                </span>
            {/if}

            <span class="s2">{$lang.total_today} <strong> 
                    {if $tax}
                        {$tax.total|price:$currency}
                    {elseif $credit}
                        {$credit.total|price:$currency}
                    {else}
                        {$subtotal.total|price:$currency}
                    {/if}
                </strong></span>
            {/if}

        {if $product.paytype!='Once' && $product.paytype!='Free' && $progress<5}
            <a href="#" class="code" onclick="$(this).hide();
                                $('#cycleform').show();
                                return false;" style="display:block">- {$lang.changebillingcycle}</a>
            <span id="cycleform" style="display: none;text-align:right;padding:4px 0px;">
                <select   onchange="changeCycleC()" style="width:99%">
                    {if $product.d!=0}<option value="d" {if $cycle=='d'} selected="selected"{/if}>{$lang.d}</option>{/if}
                    {if $product.w!=0}<option value="w" {if $cycle=='w'} selected="selected"{/if}>{$lang.w}</option>{/if}
                    {if $product.m!=0}<option value="m" {if $cycle=='m'} selected="selected"{/if}>{$lang.m}</option>{/if}
                    {if $product.q!=0}<option value="q" {if $cycle=='q'} selected="selected"{/if}>{$lang.q}</option>{/if}
                    {if $product.s!=0}<option value="s" {if $cycle=='s'} selected="selected"{/if}>{$lang.s}</option>{/if}
                    {if $product.a!=0}<option value="a" {if $cycle=='a'} selected="selected"{/if}>{$lang.a}</option>{/if}
                    {if $product.b!=0}<option value="b" {if $cycle=='b'} selected="selected"{/if}>{$lang.b}</option>{/if}
                    {if $product.t!=0}<option value="t" {if $cycle=='t'} selected="selected"{/if}>{$lang.t}</option>{/if}
                    {if $product.p4!=0}<option value="p4" {if $cycle=='p4'} selected="selected"{/if}>{$lang.p4}</option>{/if}
                    {if $product.p5!=0}<option value="p5" {if $cycle=='p5'} selected="selected"{/if}>{$lang.p5}</option>{/if}

                </select>
            </span>
        {/if}

        {if count($currencies)>1}
            <a href="#" class="code" onclick="$(this).hide();$('#currform').show();
                                return false;" style="display:block">- {$lang.changecurrency}</a>

            <span id="currform" style="display: none;text-align:right;padding:4px 0px;">
                {$lang.Currency} <select name="currencyx" class="styled" onchange="changeCurrencyC()">
                    {foreach from=$currencies item=crx}
                        <option value="{$crx.id}" {if !$selcur && $crx.id==0}selected="selected"{elseif $selcur==$crx.id}selected="selected"{/if}>{if $crx.code}{$crx.code}{else}{$crx.iso}{/if}</option>
                    {/foreach}
                </select>
            </span>
        {/if}

        {if $subtotal.coupon}
        {else}
            <a href="#" class="code" onclick="$(this).hide();
                                $('#promocode').show();return false;" style="display:block">- {$lang.usecoupon}</a>

            <span id="promocode" style="display: none;text-align:right;padding:4px 0px;">

                {$lang.code}: <input type="text" class="styled" id="promocodev" style="font-weight:bold"/> <input type="submit" value="" id="promosubmit" onclick="return applyCoupon();" />
            </span>
        {/if}

    </p>
    {if $progress==2}
        <a href="?cmd=cart&do=3" class="checkout">{$lang.continue2} &raquo;</a>
    {elseif $progress==3}
        <a href="?cmd=cart&do=4" class="checkout">{$lang.continuetostep} 3 &raquo;</a>
    {elseif $progress==4}
        <a href="?cmd=cart&do=5" class="checkout">{$lang.continuetostep} 4 &raquo;</a>
    {elseif $progress==5}
        <a href="?cmd=cart&do=6" class="checkout">{$lang.continuetostep} 5 &raquo;</a>

    {/if}

</div>
<span class="bB"></span>