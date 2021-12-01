
{include file='cart_bookshelf/cart.progress.tpl'}
<div class="line-header clearfix first"><h3>{$lang.ordersummary}</h3></div>

{if count($currencies)>1}<div style="position:absolute;top:3px;right:10px;">
        <form action="" method="post" id="currform">
            <input name="action" type="hidden" value="changecurr">
            {$lang.Currency} <select name="currency" class="styled span2" onchange="$('#currform').submit()">
                {foreach from=$currencies item=crx}
                    <option value="{$crx.id}" {if !$selcur && $crx.id==0}selected="selected"{elseif $selcur==$crx.id}selected="selected"{/if}>{if $crx.code}{$crx.code}{else}{$crx.iso}{/if}</option>
                {/foreach}
            </select>
        </form></div>
    {/if}

<div class="white-box cart-sumary">
    <table cellspacing="0" cellpadding="0" border="0" align="center" width="100%" class="checker table table-striped">
        <tbody>
            <tr>
                <th width="55%" align="left">{$lang.Description}</th>

                <th width="20%"> {$lang.setupfee}</th>
                <th width="25%">{$lang.price}</th>
            </tr>
            {if $product}
                <tr class="srow">
                    <td valign="top">{$contents[0].category_name} - <strong>{$contents[0].name}</strong> {if $contents[2].domain}({$contents[2].domain}){/if}<br/>
                    </td>
                    <td align="center">{if $contents[0].setup!=0}{$contents[0].setup|price:$currency}{else}-{/if}</td>
                    <td align="center">{if $contents[0].price==0}<strong>{$lang.Free}</strong>{elseif $contents[0].prorata_amount}
                        <strong> {$contents[0].prorata_amount|price:$currency}</strong>
                        ({$lang.prorata} {$contents[0].prorata_date|dateformat:$date_format}){else}<strong>{$contents[0].price|price:$currency}</strong>{/if}
                    </td>
                </tr>
            {/if}

            {if $cart_contents[1]}
                {foreach from=$cart_contents[1] item=cstom2}
                    {foreach from=$cstom2 item=cstom}
                        {if $cstom.total>0}
                            <tr >
                                <td valign="top" class="blighter fs11" style="padding-left:15px">{$cstom.fullname}  {if $cstom.qty>=1}x {$cstom.qty}{/if}<br/>
                                </td>
                                <td align="center" class="blighter fs11">{if $cstom.setup!=0}{$cstom.setup|price:$currency}{else}-{/if}</td>
                                <td align="center" class="blighter fs11"><strong>{if $cstom.price==0}{$lang.Free}{elseif $cstom.prorata_amount}{$cstom.prorata_amount|price:$currency}{else}{$cstom.price|price:$currency}{/if}</strong></td>
                            </tr>
                        {/if}
                    {/foreach}
                {/foreach}
            {/if}	
            {if $contents[3]}
                {foreach from=$contents[3] item=addon}
                    <tr >
                        <td>{$lang.addon} <strong>{$addon.name}</strong></td>
                        <td  align="center">{if $addon.setup!=0}{$addon.setup|price:$currency}{else}-{/if}</td>
                        <td align="center">{if $addon.price==0}<strong>{$lang.Free}</strong>{elseif $addon.prorata_amount}<strong>{$addon.prorata_amount|price:$currency}</strong> ({$lang.prorata} {$addon.prorata_date|dateformat:$date_format}){else}<strong>{$addon.price|price:$currency}</strong>{/if}</td>
                    </tr>
                {/foreach}
            {/if}	
            {if $product}
                <tr >
                    <td><a style="color: rgb(0, 153, 0);" href="{$ca_url}cart&amp;step=3"  class="fs11">[{$lang.edit_config}]</a> {if !$contents[2] && $contents[0].domainoptions}<a style="color: rgb(0, 153, 0);" href="{$ca_url}cart&amp;step=1"  class="fs11">[{$lang.add_domain}]</a>{/if}</td>
                    <td colspan="2"></td>
                </tr>
            {/if}
            {if $contents[2] }
                {foreach from=$contents[2] item=domenka key=kk}
                    {if $domenka.action!='own' && $domenka.action!='hostname'}
                        <tr >
                            <td><strong>{if $domenka.action=='register'}{$lang.domainregister}{elseif $domenka.action=='transfer'}{$lang.domaintransfer}{elseif $domenka.action=='renew'}{$lang.domainrenewal}{/if}</strong> - {$domenka.name} - {$domenka.period} {$lang.years}
                                <br/>
                            </td>
                            <td  align="center">-</td>
                            <td align="center"><strong>{$domenka.price|price:$currency}</strong></td>
                        </tr>
                        {if $domenka.forms}
                            {foreach from=$domenka.forms item=cstom2}
                                {foreach from=$cstom2 item=cstom}
                                    {if $cstom.total>0}
                                        <tr >
                                            <td valign="top" class="blighter fs11" style="padding-left:15px">{$cstom.fullname}  {if $cstom.qty>=1}x {$cstom.qty}{/if}<br/>
                                            </td>
                                            <td align="center" class="blighter fs11">{if $cstom.setup!=0}{$cstom.setup|price:$currency}{else}-{/if}</td>
                                            <td align="center" class="blighter fs11"><strong>{if $cstom.price==0}{$lang.Free}{elseif $cstom.prorata_amount}{$cstom.prorata_amount|price:$currency}{else}{$cstom.price|price:$currency}{/if}</strong></td>
                                        </tr>
                                    {/if}
                                {/foreach}
                            {/foreach}
                        {/if}
                        <tr >
                            <td class="blighter fs11" style="padding-left:15px"><a style="color: rgb(0, 153, 0);" href="{$ca_url}cart&amp;step=2" class="fs11">[{$lang.config_extras}]</a> <a style="color: rgb(204, 0, 0);"  href="{$ca_url}cart&amp;step=4&amp;removedomain=true&key={$kk}"  class="fs11">[{$lang.remove}]</a></td>
                            <td colspan="2"></td>
                        </tr>
                    {/if}
                {/foreach}
            {/if}
            {if $contents[4]}
                {foreach from=$contents[4] item=subprod}
                    <tr class="srow">
                        <td valign="top">{$subprod.category_name} - <strong>{$subprod.name}</strong>
                        </td>
                        <td align="center">{if $subprod.setup!=0}{$subprod.setup|price:$currency}{else}-{/if}</td>
                        <td align="center">{if $subprod.price==0}<strong>{$lang.Free}</strong>{elseif $subprod.prorata_amount}
                            <strong> {$subprod.prorata_amount|price:$currency}</strong>
                            ({$lang.prorata} {$subprod.prorata_date|dateformat:$date_format}){else}<strong>{$subprod.price|price:$currency}</strong>{/if}</td>
                    </tr>
                {/foreach}
            {/if}
            {if $tax}
                <tr class="subtotal-line" >
                    <td></td>
                    <td align="right" >{$lang.subtotal}</td>
                    <td align="center" >{$tax.subtotal|price:$currency}</td>
                </tr>
                {if $subtotal.coupon}  
                    <tr >
                        <td></td>
                        <td align="right">{$lang.discount}</td>
                        <td align="center"><strong>- {$subtotal.discount|price:$currency}</strong></td>
                    </tr>  
                {/if}
                {if $tax.tax1 && $tax.taxed1!=0}
                    <tr >
                        <td></td>
                        <td align="right">{$tax.tax1name} @ {$tax.tax1}%  </td>
                        <td align="center">{$tax.taxed1|price:$currency}</td>
                    </tr>
                {/if}
                {if $tax.tax2  && $tax.taxed2!=0}
                    <tr >
                        <td></td>
                        <td align="right">{$tax.tax2name} @ {$tax.tax2}%  </td>
                        <td align="center">{$tax.taxed2|price:$currency}</td>
                    </tr>
                {/if}
                {if $tax.credit!=0}
                    <tr>
                        <td></td>
                        <td align="right"><strong>{$lang.credit}</strong> </td>
                        <td align="center"><strong>{$tax.credit|price:$currency}</strong></td>
                    </tr>
                {/if}
            {elseif $credit}
                {if  $credit.credit!=0}
                    <tr>
                        <td align="right" colspan="2"><strong>{$lang.credit}</strong> </td>
                        <td align="center"><strong>{$credit.credit|price:$currency}</strong></td>
                    </tr>
                {/if}
                {if $subtotal.coupon}  
                    <tr >
                        <td align="right" colspan="2">{$lang.discount}</td>
                        <td align="center"><strong>- {$subtotal.discount|price:$currency}</strong></td>
                    </tr>  
                {/if}
                <tr class="subtotal-line">
                    <td></td>
                    <td align="right">{$lang.subtotal}</td>
                    <td align="center">{$subtotal.total|price:$currency}</td>
                </tr>
            {else}
                {if $subtotal.coupon}  
                    <tr >
                        <td align="right" colspan="2">{$lang.discount}</td>
                        <td align="center"><strong>- {$subtotal.discount|price:$currency}</strong></td>
                    </tr>  
                {/if}
                <tr class="subtotal-line">
                    <td></td>
                    <td align="right" >{$lang.subtotal}</td>
                    <td align="center">{$subtotal.total|price:$currency}</td>
                </tr>
            {/if}
            {if !empty($tax.recurring)}
                <tr class="subtotal-line2">
                    <td></td>
                    <td align="right">{$lang.total_recurring}</td>
                    <td align="center"> 
                        {foreach from=$tax.recurring item=rec key=k}
                            {$rec|price:$currency} {$lang.$k}<br/>
                        {/foreach}
                    </td>
                </tr>
            {elseif !empty($subtotal.recurring)}
                <tr class="subtotal-line2">
                    <td></td>
                    <td align="right" >{$lang.total_recurring}</td>
                    <td align="center"> 
                        {foreach from=$subtotal.recurring item=rec key=k}
                            {$rec|price:$currency} {$lang.$k}<br/>
                        {/foreach} 
                    </td>
                </tr>
            {/if}
            <tr id="pricetotal">
                <td align="left" style="border:none">
                    {if $subtotal.coupon} 
                    {else}
                        <div class="coupon" ><a href="#" onclick="$(this).hide();$('#promocode').show();return false;"><strong>{$lang.usecoupon}</strong></a></div>
                        <div id="promocode" style="display:none;">
                            <form action="" method="post" id="promoform" >
                                <input type="hidden" name="addcoupon" value="true" />

                                {$lang.code}: <input type="text" class="styled" name="promocode"/> <input type="submit" value="&raquo;" style="font-weight:bold" class="padded btn"/></form>
                        </div>
                    {/if}
                </td>
                <td align="right" style="border:none" ><strong>{$lang.total_today}</strong> </td>
                <td align="center"  style="border:none" >
                    {if $tax}
                        <span class="cart_total">{$tax.total|price:$currency}</span>
                    {elseif $credit}
                        <span class="cart_total">{$credit.total|price:$currency} </span>
                    {else}
                        <span class="cart_total">{$subtotal.total|price:$currency}</span>
                    {/if}
                    
                </td>
            </tr>
        </tbody>
    </table>
</div>

<form action="" method="post" onsubmit='if($("#c_notes").val()=="{$lang.c_tarea}")$("#c_notes").val("");$("#checkout").addLoader();' id="subbmitorder">
    <input type="hidden" name="make" value="step4" />
    <div {if $tax && $tax.total==0}style="display:none"{elseif $credit && $credit.total==0}style="display:none"{elseif $subtotal.total==0}style="display:none"{/if}>
        <div class="line-header clearfix"><h3>{$lang.choose_payment}</h3></div>
        {if $gateways}
            <center>
                {foreach from=$gateways item=module key=mid name=payloop}
                    <span style="padding:5px; white-space: nowrap"><input  onclick="return pop_ccform($(this).val())" type="radio" name="gateway" value="{$mid}" {if $submit && $submit.gateway==$mid||$mid==$paygateid}checked="checked"{elseif $smarty.foreach.payloop.first}checked="checked"{/if}/> {$module}</span>
                {/foreach}
            </center>  
        {/if}
    </div>
    {if $gateways}
        <div id="gatewayform">
            {$gatewayhtml}
        </div>
        <script type="text/javascript">reform_ccform();</script>
    {/if}

    {if $logged=="1"}
        <div class="line-header clearfix"><h3>{$lang.ContactInfo}</h3></div>
        {include file="drawclientinfo.tpl"}
    {else}
        
        <div class="cart-switch tabbme">
            <span {if !$submit || !$submit.make || $submit.cust_method=='newone' || $submit.action!='login'}class="t1 active on"{else}class="t1"{/if} onclick="ajax_update('{$system_url}index.php?cmd=signup',{literal}{layer:'ajax'},'#updater',true);$(this).parent().find('li.t2').removeClass('on');$(this).addClass('on');{/literal}" >
                {$lang.newclient}</span>
            <span {if $submit.cust_method=='login' || $submit.action=='login'}class="t2 active on"{else}class="t2"{/if} onclick="ajax_update('{$system_url}index.php?cmd=login',{literal}{layer:'ajax'},'#updater',true);$(this).parent().find('li.t1').removeClass('on');$(this).addClass('on');{/literal}"}>
                                                                                {$lang.alreadyclient}</span>
            <div></div>
        </div>
        <div class="line-header clearfix"><h3>{$lang.ContactInfo}</h3></div>
        <div id="updater" >
            {if $submit.cust_method=='login'}
                {include file="ajax.login.tpl"}
            {else}
                {include file="ajax.signup.tpl"}
            {/if}
        </div>
    {/if} 
    <div class="line-header clearfix"><h3>{$lang.cart_add}</h3></div>

    <table border="0" cellpadding="0" cellspacing="6" width="100%">
        <tr>
            <td align="center">
                <textarea id="c_notes" {if !$submit.notes}onblur="if (this.value=='')this.value='{$lang.c_tarea}';" onfocus="if(this.value=='{$lang.c_tarea}')this.value='';"{/if} style="width:98%" rows="3"  name="notes">{if $submit.notes}{$submit.notes}{else}{$lang.c_tarea}{/if}</textarea>
            </td></tr>

        {if $tos}
            <tr>
                <td align="center"><input type="checkbox" value="1" name="tos"/> {$lang.tos1} <a href="{$tos}" target="_blank">{$lang.tos2}</a></td></tr>
        {/if}</table>


    <div id="checkout">
    </div>	
    <br />
    <a href="#" class="big-btn clear" onclick="$('#subbmitorder').submit(); return false;">{$lang.checkout}</a>
</form>
{include file='cart_bookshelf/cart.footer.tpl'}