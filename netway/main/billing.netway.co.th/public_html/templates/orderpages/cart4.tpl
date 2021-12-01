{php}
$templatePath   = $this->get_template_vars('template_path');
include(dirname($templatePath) . '/orderpages/cart4.tpl.php');
{/php}
{if $custom_overrides.cart4}
    {include file=$custom_overrides.cart4}
{else}
<link href="{$orderpage_dir}default/cart.css" rel="stylesheet" type="text/css"/>
<div class="default-cart"></div>
<div class="wbox">
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
    <div class="wbox_content">
        <table cellspacing="0" cellpadding="0" border="0" align="center" width="100%" class="checker table">
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
                            ({$lang.prorata} {$contents[0].prorata_date|dateformat:$date_format}){else}<strong>{$contents[0].price|price:$currency}</strong>{/if}</td>
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
                    {foreach from=$contents[2] item=domenka key=kk}{if $domenka.action!='own' && $domenka.action!='hostname'}

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
                {if $contents[4]}{foreach from=$contents[4] item=subprod}
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
                    <tr >
                        <td align="right" colspan="2">{$lang.subtotal}</td>
                        <td align="center" >{$tax.subtotal|price:$currency}</td>
                    </tr>

                    {if $subtotal.coupon}
                        <tr >
                            <td align="right" colspan="2">{$lang.discount}</td>
                            <td align="center"><strong>- {$subtotal.discount|price:$currency}</strong></td>
                        </tr>
                    {/if}

                    {if $tax.tax1 && $tax.taxed1!=0}
                        <tr >
                            <td align="right" colspan="2">{$tax.tax1name} @ {$tax.tax1}%  </td>
                            <td align="center">{$tax.taxed1|price:$currency}</td>
                        </tr>
                    {/if}

                    {if $tax.tax2  && $tax.taxed2!=0}
                        <tr >
                            <td align="right" colspan="2">{$tax.tax2name} @ {$tax.tax2}%  </td>
                            <td align="center">{$tax.taxed2|price:$currency}</td>
                        </tr>
                    {/if}

                    {if $tax.credit!=0}
                        <tr style="{if $isRenewDomain}display:none;{/if}" >
                            <td align="right" colspan="2"><strong>{$lang.credit}</strong> </td>
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

                    <tr>
                        <td align="right" colspan="2">{$lang.subtotal}</td>
                        <td align="center">{$subtotal.total|price:$currency}</td>
                    </tr>
                {else}

                    {if $subtotal.coupon}
                        <tr >
                            <td align="right" colspan="2">{$lang.discount}</td>
                            <td align="center"><strong>- {$subtotal.discount|price:$currency}</strong></td>
                        </tr>
                    {/if}

                    <tr>
                        <td align="right" colspan="2">{$lang.subtotal}</td>
                        <td align="center">{$subtotal.total|price:$currency}</td>
                    </tr>

                {/if}

                {if !empty($tax.recurring)}
                    <tr >
                        <td align="right" colspan="2">{$lang.total_recurring}</td>
                        <td align="center">
                            {foreach from=$tax.recurring item=rec key=k}
                                {$rec|price:$currency} {$lang.$k}<br/>
                            {/foreach}
                        </td>
                    </tr>

                {elseif !empty($subtotal.recurring)}
                    <tr >
                        <td align="right" colspan="2">{$lang.total_recurring}</td>
                        <td align="center">
                            {foreach from=$subtotal.recurring item=rec key=k}
                                {$rec|price:$currency} {$lang.$k}<br/>
                            {/foreach}
                        </td>
                    </tr>
                {/if}

                <tr >
                    <td align="left" style="border:none">
                        {if $subtotal.coupon}
                        {else}
                            <div ><a href="#" onclick="$(this).hide();
                            $('#promocode').show();
                            return false;"><strong>{$lang.usecoupon}</strong></a></div>
                            <div id="promocode" style="display:none;">
                                <form action="" method="post" id="promoform" >
                                    <input type="hidden" name="addcoupon" value="true" />

                                    {$lang.code}: <input type="text" class="styled" name="promocode"/> <input type="submit" value="&raquo;" style="font-weight:bold" class="padded btn"/></form>
                            </div>
                        {/if}
                    </td>
                    <td align="right" style="border:none" ><strong>{$lang.total_today}</strong> </td>
                    <td align="center"  style="border:none">
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

<form action="" method="post" onsubmit='if ($("#c_notes").val() == "{$lang.c_tarea}")
                                $("#c_notes").val("");
                            $("#checkout").addLoader();'>
    <input type="hidden" name="make" value="step4" />
    {if $gateways}
    <div class="wbox" {if $tax && $tax.total==0 && !$isRenewDomain }style="display:none"{elseif $credit && $credit.total==0}style="display:none"{elseif $subtotal.total==0}style="display:none"{/if}>
        <div class="wbox_header">
            <strong>{$lang.choose_payment}</strong>
        </div>
        <div class="wbox_content">
            {if $gateways}
                <center>
                    {foreach from=$gateways2 item=module key=mid name=payloop}
                        <input onclick="$('#gatewayform').show();
                            ajax_update('?cmd=cart&action=getgatewayhtml&gateway_id=' + $(this).val(), '', '#gatewayform', true)" type="radio" name="gateway" value="{$mid}" {if $submit && $submit.gateway==$mid||$mid==$paygateid}checked="checked"{elseif $smarty.foreach.payloop.first}checked="checked"{/if}/> {$module}
                    {/foreach}
                </center>
            {/if}
        </div>
    </div>

        <div id="gatewayform">
            {$gatewayhtml}
        </div>
    {/if}
    {if $logged=="1"}
        <div class="wbox">
            <div class="wbox_header">
                <strong>{$lang.ContactInfo}</strong>

            </div>
            <div class="wbox_content">
                {include file="drawclientinfo.tpl"}
            </div>
        </div>
    {else}
        <div class="wbox">
            <div class="wbox_header">
                <strong>{$lang.ContactInfo}</strong>

                <ul class="wbox_menu">
                    <li {if !isset($submit) || $submit.cust_method=='newone'}class="bgon2"{else}class="bgoff2"{/if}>
                        <input type="radio" name="cust_method" value="newone" {if !isset($submit) || $submit.cust_method=='newone'}checked='checked'{/if}  onclick="{literal}ajax_update('index.php?cmd=signup', {layer: 'ajax'}, '#updater', true);
                            $(this).parent().parent().find('li.bgon2').removeClass('bgon2').addClass('bgoff2');
                            $(this).parent().removeClass('bgoff2').addClass('bgon2');{/literal}" />
                        {$lang.newclient}</li>
                    <li {if $submit.cust_method=='login'}class="bgon2"{else}class="bgoff2"{/if}>
                        <input type="radio" name="cust_method" value="login" {if $submit.cust_method=='login'}checked='checked'{/if} onClick="{literal}ajax_update('index.php?cmd=login', {layer: 'ajax'}, '#updater', true);
                            $(this).parent().parent().find('li.bgon2').removeClass('bgon2').addClass('bgoff2');
                            $(this).parent().removeClass('bgoff2').addClass('bgon2');{/literal}" />
                        {$lang.alreadyclient}</li>
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

    <div class="wbox">
        <div class="wbox_header">
            <strong>{$lang.cart_add}</strong></div>
        <div class="wbox_content">

            <table border="0" cellpadding="0" cellspacing="6" width="100%">
                <tr>
                    <td align="center">
                        <textarea id="c_notes" {if !$submit.notes}onblur="if (this.value == '')
                                this.value = '{$lang.c_tarea}';" onfocus="if (this.value == '{$lang.c_tarea}')
                                this.value = '';"{/if} style="width:98%" rows="3"  name="notes">{if $submit.notes}{$submit.notes}{else}{$lang.c_tarea}{/if}</textarea>
                    </td>
                </tr>

                {if $tos}
                    <tr>
                        <td align="left">
                            <input class="tos-checkbox" type="checkbox" name="tos" value="1" style="display:none!important;">
                            {foreach from=$terms item=tt name=termsloop}
                                <div class="">
                                    <input class="term-checkbox" type="checkbox" id="term{$smarty.foreach.termsloop.iteration}" onchange="$('.tos-checkbox').prop('checked', $('.term-checkbox:checked').length == $('.term-checkbox').length)">
                                    <label for="term{$smarty.foreach.termsloop.iteration}" class="text-small">
                                        {if $tt.url} <span class="mr-1">{$lang.tos1}</span> <a href="{$tt.url}" target="_blank" >{$tt.name}</a>
                                        {else} {$tt.name}
                                        {/if}
                                    </label>
                                </div>
                            {/foreach}
                        </td>
                    </tr>
                {/if}
            </table>
        </div>
    </div>
    <div class="orderbox"  id="checkout">
        <div class="orderboxpadding">
            <center>
                <input type="submit" value="{$lang.checkout}" style="font-size:12px;font-weight:bold"  class="padded btn  btn-primary"/>
                <input type="submit" value="{$lang.clear_cart}" name="clear" style="font-size:12px;" class="padded btn"/>
            </center>
        </div>
    </div>
</form>
</div>
{/if}