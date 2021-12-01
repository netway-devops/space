{if $custom_overrides.ajax_cart_summary}
    {include file=$custom_overrides.ajax_cart_summary}
{else}
<div id="cart_contents" class="summary-section">
    <table border="0" cellpadding="0" cellspacing="1" width="100%">
   
        {if $cart_contents[0]}
            <tr>
                <td colspan="2" class="midtext">			
                    {$cart_contents[0].category_name} - <strong>{$cart_contents[0].name}</strong>
                </td>
            </tr>

            <tr>
                <td class="smalltext">
                    {$lang.setupfee}
                </td>
                <td align="right" class="smalltext">
                    {$cart_contents[0].setup|price:$currency}
                </td>		
            </tr>

            <tr>
                <td class="smalltext">
                    {if $cart_contents[0].price!=0}
                        {assign var=tit value=$cart_contents[0].recurring}
                        {$lang[$tit]}
                    {/if}

                </td>
                <td align="right" class="smalltext">
                    {if $cart_contents[0].price!=0}
                        {$cart_contents[0].price|price:$currency}
                    {else}
                        {$lang.Free}
                    {/if}
                </td>		
            </tr>
        {/if}
        <tr><td class="smalltext" colspan="2">&nbsp;</td></tr>

        {if $cart_contents[1]}
            {foreach from=$cart_contents[1] item=cstom2}
                {foreach from=$cstom2 item=cstom} 
                    {if $cstom.total>0}
                        <tr><td class="smalltext">{$cstom.sname} {if $cstom.qty>=1}x {$cstom.qty}{/if}</td>
                            <td align="right" class="smalltext">{$cstom.total|price:$currency}</td></tr>
                        {/if}
                    {/foreach}
                {/foreach}
            <tr><td class="smalltext" colspan="2">&nbsp;</td></tr>
        {/if}	

        {foreach from=$cart_contents[4] item=subprod}
            <tr>
                <td colspan="2" class="midtext">
                    {$subprod.category_name} - <strong>{$subprod.name}</strong>
                </td>
            </tr>

            <tr>
                <td class="smalltext">
                    {$lang.setupfee}
                </td>
                <td align="right" class="smalltext">
                    {$subprod.setup|price:$currency}
                </td>
            </tr>

            <tr>
                <td class="smalltext">
                    {if $subprod.price!=0}
                        {assign var=tit value=$subprod.recurring}
                        {$lang[$tit]}
                    {/if}

                </td>
                <td align="right" class="smalltext">
                    {if $subprod.price!=0}
                        {$subprod.price|price:$currency}
                    {else}
                        {$lang.Free}
                    {/if}

                </td>
            </tr>

            <tr><td class="smalltext" colspan="2">&nbsp;</td></tr>
        {/foreach}

        {foreach from=$cart_contents[3] item=addon}
            <tr >
                <td colspan="2"  class="midtext">{$lang.addon} <strong>{$addon.name}</strong></td>
            </tr>

            <tr>
                <td class="smalltext">
                    {$lang.setupfee}
                </td>
                <td align="right" class="smalltext">
                    {$addon.setup|price:$currency}
                </td>
            </tr>

            <tr >
                <td  class="smalltext">
                    {if $addon.price!=0}
                        {assign var=tit value=$addon.recurring}
                        {$lang[$tit]}
                    {/if}

                </td>
                <td  align="right" class="smalltext">
                    {if $addon.price!=0}
                        {$addon.price|price:$currency}
                    {else}
                        {$lang.Free}
                    {/if}
                </td>
            </tr>
            <tr><td class="smalltext" colspan="2">&nbsp;</td></tr>
        {/foreach}


        {if $cart_contents[2] && $cart_contents[2][0].name!='yep'}
            {foreach from=$cart_contents[2] item=domenka key=kk}{if $domenka.action!='own'  && $domenka.action!='hostname'}
                    <tr >
                        <td colspan="2"  class="midtext name">
                            <strong title="{$domenka.name}">{$domenka.name}</strong>
                        </td>
                    </tr>
                    <tr>

                        <td class="smalltext">{if $domenka.action=='register'}{$lang.domainregister}{elseif $domenka.action=='transfer'}{$lang.domaintransfer}{elseif $domenka.action=='renew'}{$lang.domainrenewal}{/if} {$domenka.period} {$lang.years}
                        </td>
                        <td class="smalltext" align="right">{$domenka.price|price:$currency}
                        </td>
                    </tr>

                    {if $domenka.forms}
                        {foreach from=$domenka.forms item=cstom2}
                            {foreach from=$cstom2 item=cstom}
                                {if $cstom.total>0}
                                    <tr><td class="smalltext">{$cstom.sname} {if $cstom.qty>=1}x {$cstom.qty}{/if}</td>
                                        <td align="right" class="smalltext">{$cstom.total|price:$currency}</td></tr>
                                    {/if}
                                {/foreach}
                            {/foreach}
                        {/if}

                    <tr><td class="smalltext" colspan="2">&nbsp;</td></tr>
                {/if}
            {/foreach}
        {/if}

        <tr><td class="smalltext" colspan="2">&nbsp;</td></tr>
        {if $subtotal.coupon}
            <tr> 
                <td class="smalltext">{$lang.promotionalcode}: <strong>{$subtotal.coupon}</strong>
                </td>
                <td class="smalltext" align="right">- {$subtotal.discount|price:$currency}
                </td>
            </tr>
            <tr><td class="smalltext" colspan="2" align="right">
                    <form id="remove" method="post">
                        <input type="hidden" name="step" value="{$step}" />
                        <input type="hidden" name="removecoupon" value="true" />
                    </form>
                    <a href="#" onclick="{if $step!=4}return removeCoupon();{else}$('#remove').submit();{/if}">{$lang.removecoupon}</a></td></tr>
            <tr><td class="smalltext" colspan="2">&nbsp;</td></tr>
        {/if}

    </table>

    {if $subtotal.coupon}

    {else}
        <div style="text-align:right"><a href="#" onclick="$(this).hide(); $('#promocode').show(); return false;"><strong>
        <button style="border-color: #003902;color: #156401;border: 2px solid;padding: 5px 7px;font-size: 16px;cursor: pointer;background-color: white;">{$lang.usecoupon}</button></strong></a></div>
        <div id="promocode" style="display:none;text-align:right">
            <form action="" method="post" id="promoform" onsubmit="{if $step!=4}return applyCoupon();{else}{/if}">
                <input type="hidden" name="step" value="{$step}" />

                {$lang.code}: <input type="text" class="styled span2" name="promocode"/ style="padding: 11px;margin-top: 10px;"> 
                <input type="submit" value="Use" style="font-weight: bold;border-color: #003902;color: #156401;border: 2px solid;padding: 0px 7px;font-size: 14px;cursor: pointer;text-transform: none;" class="padded btn"/></form>
        </div>

    {/if}
</div>
<div class="summary-section">
    <div style="text-align:right"><strong>{if $step==4}{$lang.total_today}{else}{$lang.carttoday}{/if}</strong></div>
    <div class="cart_total">
        <span style="vertical-align: top; font-size: 20px;">{$currency.sign}</span>
        {if $step!=4}
            <span style="vertical-align: top;line-height:43px">{$subtotal.total|price:$currency:false}</span>
        {else}
            {if $tax}
                <span style="vertical-align: top;line-height:43px">{$tax.total|price:$currency:false}</span>
            {elseif $credit}
                <span style="vertical-align: top;line-height:43px">{$credit.total|price:$currency:false}</span>
            {else}
                <span style="vertical-align: top;line-height:43px">{$subtotal.total|price:$currency:false}</span>
            {/if}
        {/if}
        
        {if $cart_contents[0].prorata_date}
          <br><span style="vertical-align: top;line-height:35px;font-size: 14px;">
                ({$lang.prorata} {$cart_contents[0].prorata_date|dateformat:$date_format})
          </span>
        {/if}
        
    </div>
    
    {* rv start display price recurring *}
    {if $contents[0].prorata_date}
        <div style="text-align:right"><strong>Recurring Total:</strong></div>
        <div class="cart_total">
        {$currency.sign}&nbsp;{foreach from=$subtotal.recurring item=totalnet key=recur}{$totalnet}{/foreach}
        </div>
    {/if}
    {* rv end display price recurring *}
    
</div>
{/if}