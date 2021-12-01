<div id="cart_contents" class="summary-section">
    <table border="0" cellpadding="0" cellspacing="1" width="100%">
        {if $cart_contents[0]}
            <tr>
                <td colspan="2">
                    {$cart_contents[0].category_name} - <strong>{$cart_contents[0].name}</strong>
                </td>
            </tr>
            <tr>
                <td >
                    {$lang.setupfee}
                </td>
                <td align="right" >
                    {$cart_contents[0].setup|price:$currency}
                </td>
            </tr>
            <tr>
                <td>
                    {if $cart_contents[0].price!=0}
                        {assign var=tit value=$cart_contents[0].recurring}
                        {$lang[$tit]}
                    {/if}

                </td>
                <td align="right">
                    {if $cart_contents[0].price!=0}
                        {$cart_contents[0].price|price:$currency}
                    {else}
                        {$lang.FreeSummary}
                    {/if}
                </td>
            </tr>
        {/if}

        {if $cart_contents[1]}
            <tr><td colspan="2"><hr></td></tr>
            {foreach from=$cart_contents[1] item=cstom2}
                {foreach from=$cstom2 item=cstom}
                    {if $cstom.total>0}
                        <tr><td >{$cstom.sname} {if $cstom.qty>=1}x {$cstom.qty}{/if}</td>
                            <td align="right" >{$cstom.total|price:$currency}</td>
                        </tr>
                        {/if}
                    {/foreach}
                {/foreach}

        {/if}



        {foreach from=$cart_contents[4] item=subprod}
            <tr><td colspan="2"><hr></td></tr>
            <tr>
                <td colspan="2" >
                    {$subprod.category_name} - <strong>{$subprod.name}</strong>
                </td>
            </tr>
            <tr>
                <td >
                    {$lang.setupfee}
                </td>
                <td align="right" >
                    {$subprod.setup|price:$currency}
                </td>
            </tr>

            <tr>
                <td >
                    {if $subprod.price!=0}
                        {assign var=tit value=$subprod.recurring}
                        {$lang[$tit]}
                    {/if}

                </td>
                <td align="right" >
                    {if $subprod.price!=0}
                        {$subprod.price|price:$currency}
                    {else}
                        {$lang.FreeSummary}
                    {/if}

                </td>
            </tr>
        {/foreach}

        {foreach from=$cart_contents[3] item=addon}
            <tr><td colspan="2"><hr></td></tr>
            <tr >
                <td colspan="2"  >{$lang.addon} <strong>{$addon.name}</strong></td>
            </tr>

            <tr>
                <td >
                    {$lang.setupfee}
                </td>
                <td align="right" >
                    {$addon.setup|price:$currency}
                </td>
            </tr>

            <tr >
                <td  >
                    {if $addon.price!=0}
                        {assign var=tit value=$addon.recurring}
                        {$lang[$tit]}
                    {/if}

                </td>
                <td  align="right" >
                    {if $addon.price!=0}
                        {$addon.price|price:$currency}
                    {else}
                        {$lang.FreeSummary}
                    {/if}
                </td>
            </tr>
        {/foreach}

        {if $cart_contents[2] && $cart_contents[2][0].name!='yep'}
            <tr><td colspan="2"><hr></td></tr>
            {foreach from=$cart_contents[2] item=domenka key=kk}{if $domenka.action!='own'  && $domenka.action!='hostname'}
                    <tr >
                        <td colspan="2"  class="midtext name">
                            <strong title="{$domenka.name}">{$domenka.name}</strong>
                        </td>
                    </tr>
                    <tr>
                        <td >{if $domenka.action=='register'}{$lang.domainregister}{elseif $domenka.action=='transfer'}{$lang.domaintransfer}{elseif $domenka.action=='renew'}{$lang.domainrenewal}{/if} {$domenka.period} {$lang.years}</td>
                        <td  align="right">{$domenka.price|price:$currency}</td>
                    </tr>
                    {if $domenka.forms}
                        {foreach from=$domenka.forms item=cstom2}
                            {foreach from=$cstom2 item=cstom}
                                {if $cstom.total>0}
                                    <tr><td >{$cstom.sname} {if $cstom.qty>=1}x {$cstom.qty}{/if}</td>
                                        <td align="right" >{$cstom.total|price:$currency}</td></tr>
                                    {/if}
                                {/foreach}
                            {/foreach}
                        {/if}
                    <tr><td  colspan="2">&nbsp;</td></tr>
                {/if}
            {/foreach}
        {/if}

        {if $subtotal.coupon}
            <tr><td colspan="2"><hr></td></tr>
            <tr>
                <td >{$lang.promotionalcode}: <strong>{$subtotal.coupon}</strong>
                </td>
                <td  align="right">- {$subtotal.discount|price:$currency}
                </td>
            </tr>
            <tr><td  colspan="2" align="right">
                    <form id="remove" method="post">
                        <input type="hidden" name="step" value="{$step}" />
                        <input type="hidden" name="removecoupon" value="true" />
                    </form>
                    <a href="#" onclick="{if $step!=4}return removeCoupon();{else}$('#remove').submit();{/if}">{$lang.removecoupon}</a>
                </td>
            </tr>
        {/if}
    </table>

    {if $subtotal.coupon}

    {else}
        <div class="d-flex flex-row justify-content-end my-3">
            <a class="text-small" href="#" onclick="$(this).hide(); $('#promocode').show(); return false;">{$lang.usecoupon}</a>
        </div>
        <div id="promocode" style="display:none;">
            <form action="" method="post" id="promoform" onsubmit="{if $step!=4}return applyCoupon();{else}{/if}">
                <input type="hidden" name="step" value="{$step}" />
                <div class="input-group">
                    <input type="text" class="form-control" name="promocode" placeholder="{$lang.code}" aria-label="{$lang.code}">
                    <div class="input-group-append">
                        <button type="submit" class="btn btn-success">{$lang.submit}</button>
                    </div>
                </div>
            </form>
        </div>
    {/if}
</div>
<hr>
<div class="d-flex flex-column align-items-end summary-section">
    <strong class="font-weight-bold text-uppercase text-muted iconfont-size2"><small>{if $step==4}{$lang.total_today}{else}{$lang.carttoday}{/if}</small></strong>
    <div class="h1 font-weight-bold my-2">
        <span>{$currency.sign}</span>
        <span>
        {if $step!=4}
            {$subtotal.total|price:$currency:false}
        {else}
            {if $tax}
                {$tax.total|price:$currency:false}
            {elseif $credit}
                {$credit.total|price:$currency:false}
            {else}
                {$subtotal.total|price:$currency:false}
            {/if}
        {/if}
        </span>
    </div>
</div>
