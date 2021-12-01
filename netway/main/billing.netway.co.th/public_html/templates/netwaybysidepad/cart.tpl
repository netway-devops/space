{php}
$templatePath   = $this->get_template_vars('template_path');
include($templatePath . '/cart.tpl.php');
{/php}
<div class="wbox container">
    <div class="wbox_header">
        <strong>{$lang.ordersummary}</strong>
        {if count($currencies)>1}<div style="position:absolute;top:3px;right:10px;">
                <form action="" method="post" id="currform">
                    <input name="action" type="hidden" value="changecurr">
                    {$lang.Currency} <select name="currency" class="styled span2" onchange="$('#currform').submit()">
                        {foreach from=$currencies item=crx}
                            <option value="{$crx.id}" {if !$selcur && $crx.id==0}selected="selected"{elseif $selcur==$crx.id}selected="selected"{/if}>{if $crx.code}{$crx.code}{else}{$crx.iso}{/if}</option>
                        {/foreach}
                    </select>
                </form>
            </div>
        {/if}
    </div>
    {literal}
        <style>
            .table td, .table th{
                text-align: center;
            }
            .table td:first-child, .table th:first-child{
                text-align: left;
            }
        </style>
    {/literal}
    <div class="wbox_content">
        <table cellspacing="0" cellpadding="0" border="0" width="100%" class="checker table">
            <thead>
                <tr>
                    <th width="55%" align="left">{$lang.Description}</th>

                    <th width="20%"> {$lang.setupfee}</th>
                    <th width="25%">{$lang.price}</th>
                </tr>
            </thead>
            {if $contents}
                {foreach from=$contents item=order key=k}
                    <tbody>
                        {if $order.product}
                            <tr class="srow">
                                <td valign="top">
                                    {$order.product.category_name} - {$order.product.name}
                                    {if $order.product.domain}({$order.product.domain})
                                    {/if}
                                </td>
                                <td>
                                    {if $order.product.setup!=0}{$order.product.setup|price:$currency}
                                    {else}-
                                    {/if}
                                </td>
                                <td>
                                    {if $order.product.price==0}{$lang.Free}
                                    {elseif $order.product.prorata_amount} {$order.product.prorata_amount|price:$currency} ({$lang.prorata} {$order.product.prorata_date|dateformat:$date_format})
                                    {else}{$order.product.price|price:$currency}
                                    {/if}
                                </td>
                            </tr>
                        {/if}
                        {if $order.product_configuration}
                            {foreach from=$order.product_configuration item=cstom2}
                                {foreach from=$cstom2 item=cstom}
                                    {if $cstom.total>=0}
                                        <tr >
                                            <td valign="top" >
                                                {$cstom.fullname}  
                                                {if $cstom.qty>=1}x {$cstom.qty}
                                                {/if}
                                            </td>
                                            <td >
                                                {if $cstom.setup!=0}{$cstom.setup|price:$currency}
                                                {else}-
                                                {/if}
                                            </td>
                                            <td >
                                                {if $cstom.price==0}{$lang.Free}
                                                {elseif $cstom.prorata_amount}{$cstom.prorata_amount|price:$currency}
                                                {else}{$cstom.price|price:$currency}
                                                {/if}
                                            </td>
                                        </tr>
                                    {/if}
                                {/foreach}
                            {/foreach}
                        {/if}	

                        {if $order.addons}
                            {foreach from=$order.addons item=addon}
                                <tr >
                                    <td>{$lang.addon} {$addon.name}</td>
                                    <td >
                                        {if $addon.setup!=0}{$addon.setup|price:$currency}
                                        {else}-
                                        {/if}
                                    </td>
                                    <td>
                                        {if $addon.price==0}{$lang.Free}
                                        {elseif $addon.prorata_amount} {$addon.prorata_amount|price:$currency} ({$lang.prorata} {$addon.prorata_date|dateformat:$date_format})
                                        {else} {$addon.price|price:$currency}
                                        {/if}
                                    </td>
                                </tr>
                            {/foreach}
                        {/if}	
                        {if $order.domains }
                            {foreach from=$order.domains item=domenka key=kk}{if $domenka.action!='own' && $domenka.action!='hostname'}
                                    <tr >
                                        <td>
                                            {if $domenka.action=='register'}{$lang.domainregister}
                                            {elseif $domenka.action=='transfer'}{$lang.domaintransfer}
                                            {elseif $domenka.action=='renew'}{$lang.domainrenewal}{assign var="haverenewdomain" value=1}
                                            {/if}
                                            - {$domenka.name} - {$domenka.period} {$lang.years}
                                        </td>
                                        <td>-</td>
                                        <td>{$domenka.price|price:$currency}</td>
                                    </tr>
                                    {if $domenka.forms}
                                        {foreach from=$domenka.forms item=cstom2}
                                            {foreach from=$cstom2 item=cstom}
                                                {if $cstom.total>0}
                                                    <tr >
                                                        <td valign="top" >
                                                            {$cstom.fullname}
                                                            {if $cstom.qty>=1}x {$cstom.qty}
                                                            {/if}
                                                        </td>
                                                        <td >
                                                            {if $cstom.setup!=0}{$cstom.setup|price:$currency}
                                                            {else}-
                                                            {/if}
                                                        </td>
                                                        <td >
                                                            {if $cstom.price==0}{$lang.Free}
                                                            {elseif $cstom.prorata_amount}{$cstom.prorata_amount|price:$currency}
                                                            {else}{$cstom.price|price:$currency}
                                                            {/if}
                                                        </td>
                                                    </tr>
                                                {/if}
                                            {/foreach}
                                        {/foreach}
                                    {/if}
                                {/if}
                            {/foreach}
                        {/if}
                        {if $order.subproducts}
                            {foreach from=$order.subproducts item=subprod}
                                <tr class="srow">
                                    <td valign="top">{$subprod.category_name} - <strong>{$subprod.name}</strong>
                                    </td>
                                    <td>{if $subprod.setup!=0}{$subprod.setup|price:$currency}{else}-{/if}</td>
                                    <td>{if $subprod.price==0}<strong>{$lang.Free}</strong>{elseif $subprod.prorata_amount}
                                        <strong> {$subprod.prorata_amount|price:$currency}</strong>
                                        ({$lang.prorata} {$subprod.prorata_date|dateformat:$date_format}){else}<strong>{$subprod.price|price:$currency}</strong>{/if}</td>
                                </tr>
                            {/foreach}
                        {/if}
                        <tr>
                            <td colspan="3">
                                <a style="color: rgb(0, 153, 0);" href="{$ca_url}cart&cart=edit&order={$k}"  class="fs11">
                                    [{$lang.edit_config}]
                                </a> 

                                {if !$contents[2] && $order.product.domainoptions}
                                    <a style="color: rgb(0, 153, 0);" href="{$ca_url}cart&cart=edit&order={$k}&step=1"  class="fs11">[{$lang.add_domain}]</a>
                                {/if}
                                <a style="color: rgb(153, 0, 0);" href="{$ca_url}cart&cart=clear&order={$k}"  class="fs11">
                                    [{$lang.remove}]
                                </a> 
                            </td>
                        </tr>
                    </tbody>
                {/foreach}
            {/if}	
            {if $tax}
                <tr >
                    <td align="right" colspan="2">{$lang.subtotal}</td>
                    <td >{$tax.subtotal|price:$currency}</td>
                </tr>

                {if $subtotal.coupon}  
                    <tr >
                        <td align="right" colspan="2">{$lang.discount}</td>
                        <td><strong>- {$subtotal.discount|price:$currency}</strong></td>
                    </tr>  
                {/if}

                {if $tax.tax1 && $tax.taxed1!=0}
                    <tr >
                        <td align="right" colspan="2">{$tax.tax1name} @ {$tax.tax1}%  </td>
                        <td>{$tax.taxed1|price:$currency}</td>
                    </tr>
                {/if}

                {if $tax.tax2  && $tax.taxed2!=0}
                    <tr >
                        <td align="right" colspan="2">{$tax.tax2name} @ {$tax.tax2}%  </td>
                        <td>{$tax.taxed2|price:$currency}</td>
                    </tr>
                {/if}

                {if $tax.credit!=0}
                    <tr>
                        <td align="right" colspan="2"><strong>{$lang.credit}</strong> </td>
                        <td><strong>{$tax.credit|price:$currency}</strong></td>
                    </tr>
                {/if}

            {elseif $credit}
                {if  $credit.credit!=0 && ! $isRenewDomain}
                    <tr>
                        <td align="right" colspan="2"><strong>{$lang.credit}</strong> </td>
                        <td><strong>{$credit.credit|price:$currency}</strong></td>
                    </tr>
                {/if}

                {if $subtotal.coupon}  
                    <tr >
                        <td align="right" colspan="2">{$lang.discount}</td>
                        <td><strong>- {$subtotal.discount|price:$currency}</strong></td>
                    </tr>  
                {/if}

                <tr>
                    <td align="right" colspan="2">{$lang.subtotal}</td>
                    <td>{$subtotal.total|price:$currency}</td>
                </tr>
            {else}

                {if $subtotal.coupon}  
                    <tr >
                        <td align="right" colspan="2">{$lang.discount}</td>
                        <td><strong>- {$subtotal.discount|price:$currency}</strong></td>
                    </tr>  
                {/if}

                <tr>
                    <td align="right" colspan="2">{$lang.subtotal}</td>
                    <td>{$subtotal.total|price:$currency}</td>
                </tr>

            {/if}

            {if !empty($tax.recurring)}
                <tr >
                    <td align="right" colspan="2">{$lang.total_recurring}</td>
                    <td> 
                        {foreach from=$tax.recurring item=rec key=k}
                            {$rec|price:$currency} {$lang.$k}<br/>
                        {/foreach} 
                    </td>
                </tr>

            {elseif !empty($subtotal.recurring)}
                <tr >
                    <td align="right" colspan="2">{$lang.total_recurring}</td>
                    <td> 
                        {foreach from=$subtotal.recurring item=rec key=k}
                            {$rec|price:$currency} {$lang.$k}<br/>
                        {/foreach} 
                    </td>
                </tr>
            {/if}

            <tr >
                <td align="left" style="border:none">

                </td>
                <td align="right" style="border:none" ><strong>{$lang.total_today}</strong> </td>
                <td  style="border:none">
                    <span style="vertical-align: top; font-size: 20px;">{$currency.sign}</span>
                    {if $tax && $isRenewDomain}
                        <span class="cart_total">{$tax.total+$tax.credit|price:$currency:false}</span>
                    {elseif $tax}
                        <span class="cart_total">{$tax.total|price:$currency:false}</span>
                    {elseif $credit}
                        <span class="cart_total">{$credit.total|price:$currency:false}</span>
                    {else}
                        <span class="cart_total">{$subtotal.total|price:$currency:false}</span>
                    {/if}
                </td>
            </tr>
            </tbody>
        </table>
    </div>
</div>
{if $suggestions}
    <div class="wbox container">
        <div class="wbox_header">
            <strong>You may also be interested in</strong>
        </div>
        <div class="wbox_content suggested" id="slides">
            <div class="suggested-products row">
                {foreach from=$suggestions item=item}
                    <div class="service-box pull-left span2">
                        <div class="vert">
                            <p><a href="{$ca_url}cart/{$item.slug}/&action=add&id={$item.id}"><i class="icon-domain-service"></i>{$item.name}</a></p>
                        </div>
                    </div>
                {/foreach}
            </div>
        </div>
    </div>
    <script type="text/javascript" src="{$template_dir}js/slides.min.jquery.js"></script>
    <script type="text/javascript" src="{$template_dir}js/suggest.js"></script>
{/if}
<form action="{$ca_url}cart" method="post">
    <input type="hidden" name="make" value="checkout" />
    <div class="wbox container" {if $tax && $tax.total==0 && !$isRenewDomain}style="display:none"{elseif $credit && $credit.total==0}style="display:none"{elseif $subtotal.total==0}style="display:none"{/if}>
        <div class="wbox_header">
            <strong>{$lang.choose_payment}</strong>
        </div>
        <div class="wbox_content">
            {if $gateways}
                <center>
                    {foreach from=$gateways2 item=module key=mid name=payloop}
                        {if $module == 'Counter Service'}
                            {if $mid != 196 }
                            <label class="btn"><input onclick="$('#gatewayform').show();
                                ajax_update('?cmd=cart&action=getgatewayhtml&gateway_id=' + $(this).val(), '', '#gatewayform', true)" type="radio" name="gateway" value="{$mid}" {if $submit && $submit.gateway==$mid||$mid==$paygateid}checked="checked"{elseif $smarty.foreach.payloop.first}checked="checked"{/if} class="pull-left" /> &nbsp; <img src='https://www.paysbuy.com/images/cash_stand02.png'></label>
                            {/if}
                        {else}
                            {if $mid != 196 }
                            <label class="btn"><input onclick="$('#gatewayform').show();
                                ajax_update('?cmd=cart&action=getgatewayhtml&gateway_id=' + $(this).val(), '', '#gatewayform', true)" type="radio" name="gateway" value="{$mid}" {if $submit && $submit.gateway==$mid||$mid==$paygateid}checked="checked"{elseif $smarty.foreach.payloop.first}checked="checked"{/if} class="pull-left" /> &nbsp; {$module}</label>
                            {/if}
                        {/if}
                    {/foreach}
                </center>  
            {/if}
        </div>
    </div>
    {if $gateways}
        <div id="gatewayform">
            {$gatewayhtml}
        </div>
    {/if}
    {if $logged=="1"}
        <div class="wbox container">
            <div class="wbox_header">
                <strong>{$lang.ContactInfo}</strong>

            </div>
            <div class="wbox_content">
                {include file="drawclientinfo.tpl"}
            </div>
        </div>
    {else}
        <div class="wbox container">
            <div class="wbox_header">
                <strong>{$lang.ContactInfo}</strong>

                <ul class="wbox_menu">
                    <li {if !isset($submit) || $submit.cust_method=='newone'}class="bgon2"{else}class="bgoff2"{/if}>
                        <label><input type="radio" name="cust_method" value="newone" {if !isset($submit) || $submit.cust_method=='newone'}checked='checked'{/if}  onclick="{literal}ajax_update('index.php?cmd=signup', {layer: 'ajax'}, '#updater', true);
                            $(this).parent().parent().find('li.bgon2').removeClass('bgon2').addClass('bgoff2');
                            $(this).parent().removeClass('bgoff2').addClass('bgon2');{/literal}" />
                        {$lang.newclient}</label></li>
                    <li {if $submit.cust_method=='login'}class="bgon2"{else}class="bgoff2"{/if}>
                        <label><input type="radio" name="cust_method" value="login" {if $submit.cust_method=='login'}checked='checked'{/if} onClick="{literal}ajax_update('index.php?cmd=login&isAjaxLogin=1&isReloadContent=1', {layer: 'ajax'}, '#updater', true);
                            $(this).parent().parent().find('li.bgon2').removeClass('bgon2').addClass('bgoff2');
                            $(this).parent().removeClass('bgoff2').addClass('bgon2');{/literal}" />
                        {$lang.alreadyclient}</label></li>
                </ul>
            </div>
            <div class="wbox_content">
                <div id="updater" >
                    {if $submit.cust_method=='login'}
                        {include file="ajax.login.tpl"}
                    {else}
                        {include file="ajax.signup.tpl"}
                    {/if}
                </div>
            </div>
        </div>
    {/if} 

    <div class="wbox container">
        <div class="wbox_header">
            <strong>{$lang.cart_add}</strong></div>
        <div class="wbox_content">

            <table border="0" cellpadding="0" cellspacing="6" width="100%">
                <tr>
                    <td>
                        <textarea id="c_notes" Placeholder="{$lang.c_tarea}"style="width:98%" rows="3"  name="notes">{if $submit.notes}{$submit.notes}{/if}</textarea>
                    </td>
                </tr>

                {if $tos}
                    <tr>
                        <td><center><input type="checkbox" value="1" name="tos"/> {$lang.tos1} <a href="{$tos}" target="_blank">{$lang.tos2}</a><a id="er" style="color:red;display:none;">&nbsp;&nbsp;&nbsp;**</a></center></td>
                    </tr>
                {/if}
            </table>
        </div>
    </div>
    <div class="orderbox container"  id="checkout">
        <div class="orderboxpadding">
            <center>
                
                {if $haverenewdomain == 1}
                    <input type="submit" value="{$lang.checkout}" name="submit" class="padded btn  btn-primary" onclick="return swapcredit();"/>
                {else}
                    <input type="submit" value="{$lang.checkout}" name="submit" class="padded btn  btn-primary"/>
                {/if}
                <input type="submit" value="{$lang.clear_cart}" name="clear" class="padded btn" onclick="removeCartItems(); return false;"/>
            </center>
        </div>
    </div>	
</form>

<script language="javascript">
{literal}
function swapcredit(){

    $.post('?cmd=clientcredithandle&action=swapclientcredit');
        
    return true;
    
}

var cartItems       = {/literal}{$cartItems}{literal};

function removeCartItems ()
{
    var myIntv  = setInterval(function (){
        $.get('{/literal}{$system_url}{literal}index.php/cart&cart=clear&order=0&idx='+ cartItems, function (data) {
            cartItems--;
        });
        
        if (cartItems <= 0) {
            document.location = '{/literal}{$system_url}{literal}index.php/cart';
        }
    }, 1500);
    
}
$(document).ready( function () {
    $('form').submit(function(){
        if($('input[name="tos"]').prop('checked')){
            return;
        }
        else{   
             $('#er').show();         
            alert('กรุณาคลิ๊กยอมรับเงื่อนไขก่อน');
            return false;
        }
    });
});

{/literal}
</script>