<link media="all" type="text/css" rel="stylesheet" href="{$orderpage_dir}enomssl/style.css"/>
{include file='enomssl/cprogress.tpl'}
<div class="wbox">
    <div class="wbox_header">
        <strong>{$lang.ordersummary}</strong>
    </div>
    <div class="wbox_content">
        <table cellspacing="0" cellpadding="0" border="0" align="center" width="100%" class="checker">
            <tbody>
            <tr>
                <th width="55%" align="left">{$lang.Description}</th>
                <th width="20%"> {$lang.setupfee}</th>
                <th width="25%">{$lang.price}</th>
            </tr>
            <tr class="srow">
                <td valign="top">{$contents[0].category_name} - <strong>{$contents[0].name}</strong>
                    {if $contents[0].domain}({$contents[0].domain}){/if} -
                    {if $contents[0].recurring=='a'} 1
                    {elseif $contents[0].recurring=='b'} 2
                    {elseif $contents[0].recurring=='t'} 3
                    {elseif $contents[0].recurring=='p4'} 4
                    {elseif $contents[0].recurring=='p5'} 5
                    {/if}{$lang.years}<br/>
                </td>
                <td align="center">{if $contents[0].setup!=0}{$contents[0].setup|price:$currency}{else}-{/if}</td>
                <td align="center">{if $contents[0].price==0}
                        <strong>{$lang.Free}</strong>{elseif $contents[0].prorata_amount}
                        <strong> {$contents[0].prorata_amount|price:$currency}</strong>
                        ({$lang.prorata} {$contents[0].prorata_date|dateformat:$date_format}){else}
                        <strong>{$contents[0].price|price:$currency}</strong>
                    {/if}
                </td>
            </tr>
            {if $cart_contents[1]}
                {foreach from=$cart_contents[1] item=cstom2}
                    {foreach from=$cstom2 item=cstom}
                        {if $cstom.total>0}
                            <tr>
                                <td valign="top" class="blighter fs11"
                                    style="padding-left:15px">{$cstom.fullname}  {if $cstom.qty>=1}x {$cstom.qty}{/if}
                                    <br/>
                                </td>
                                <td align="center"
                                    class="blighter fs11">{if $cstom.setup!=0}{$cstom.setup|price:$currency}{else}-{/if}</td>
                                <td align="center" class="blighter fs11">
                                    <strong>{if $cstom.price==0}{$lang.Free}{elseif $cstom.prorata_amount}{$cstom.prorata_amount|price:$currency}{else}{$cstom.price|price:$currency}{/if}</strong>
                                </td>
                            </tr>
                        {/if}
                    {/foreach}{/foreach}
            {/if}
            {if $contents[3]}
                {foreach from=$contents[3] item=addon}
                    <tr>
                        <td>{$lang.addon} <strong>{$addon.name}</strong></td>
                        <td align="center">{if $addon.setup!=0}{$addon.setup|price:$currency}{else}-{/if}</td>
                        <td align="center">{if $addon.price==0}
                                <strong>{$lang.Free}</strong>{elseif $addon.prorata_amount}
                                <strong>{$addon.prorata_amount|price:$currency}</strong> ({$lang.prorata} {$addon.prorata_date|dateformat:$date_format}){else}
                                <strong>{$addon.price|price:$currency}</strong>{/if}</td>
                    </tr>
                {/foreach}
            {/if}
            {if $contents[4]}
                {foreach from=$contents[4] item=subprod}
                    <tr >
                    <td>{$subprod.category_name} - <strong>{$subprod.name}</strong></td>
                    <td align="center">
                        {if $subprod.setup!=0}
                            + {$subprod.setup|price:$currency} {$lang.setupfee}
                        {else}-
                        {/if}
                    </td>
                    <td align="center">
                        {if $subprod.price==0}
                            <strong>{$lang.Free}</strong>
                        {elseif $subprod.prorata_amount}
                            <strong> {$subprod.prorata_amount|price:$currency}</strong>
                            ({$lang.prorata} {$subprod.prorata_date|dateformat:$date_format})
                        {else}
                            <strong>{$subprod.price|price:$currency}</strong>
                        {/if}
                    </td>
                {/foreach}
                </tr>
            {/if}
            {if $tax}
                <tr>
                    <td align="right" colspan="2">{$lang.subtotal}</td>
                    <td align="center">{$tax.subtotal|price:$currency}</td>
                </tr>
                {if $subtotal.coupon}
                    <tr>
                        <td align="right" colspan="2">{$lang.discount}</td>
                        <td align="center"><strong>- {$subtotal.discount|price:$currency}</strong></td>
                    </tr>
                {/if}
                {if $tax.tax1 && $tax.taxed1!=0}
                    <tr>
                        <td align="right" colspan="2">{$tax.tax1name} @ {$tax.tax1}%  </td>
                        <td align="center">{$tax.taxed1|price:$currency}</td>
                    </tr>
                {/if}
                {if $tax.tax2  && $tax.taxed2!=0}
                    <tr>
                        <td align="right" colspan="2">{$tax.tax2name} @ {$tax.tax2}%  </td>
                        <td align="center">{$tax.taxed2|price:$currency}</td>
                    </tr>
                {/if}
                {if $tax.credit!=0}
                    <tr>
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
                    <tr>
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
                    <tr>
                        <td align="right" colspan="2">{$lang.discount}</td>
                        <td align="center"><strong>- {$subtotal.discount|price:$currency}</strong></td>
                    </tr>
                {/if}
                <tr>
                    <td align="right" colspan="2">{$lang.subtotal}</td>
                    <td align="center">{$subtotal.total|price:$currency}</td>
                </tr>
            {/if}
            <tr>
                <td style="border:none">
                    {if $subtotal.coupon}

                    {else}
                        <div><a href="#" onclick="$(this).hide();$('#promocode').show();return false;"><strong>{$lang.usecoupon}</strong></a>
                        </div>
                        <div id="promocode" style="display:none;">
                            <form action="" method="post" id="promoform">
                                <input type="hidden" name="addcoupon" value="true"/>
                                {$lang.code}: <input type="text" class="styled" name="promocode"/>
                                <input type="submit" value="&raquo;" style="font-weight:bold" class="padded btn"/>
                            </form>
                        </div>
                    {/if}
                </td>
                <td align="right" style="border:none"><strong>{$lang.total_today}</strong> </td>
                <td align="center" style="border:none;line-height: 45px">
                    <span style="vertical-align: top; font-size: 20px; line-height: 35px;">{$currency.sign}</span>
                    {if $tax}
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

<form action="" method="post" onsubmit='if($("#c_notes").val()=="{$lang.c_tarea}")$("#c_notes").val("");' id="orderform">
    <input type="hidden" name="make" value="step4"/>
    <div class="wbox" {if $tax && $tax.total==0}style="display:none" {elseif $credit && $credit.total==0}style="display:none"
         {elseif $subtotal.total==0}style="display:none"{/if}>
        <div class="wbox_header">
            <strong>{$lang.choose_payment}</strong>
        </div>
        <div class="wbox_content">
            {if $gateways}
                <center>{foreach from=$gateways item=module key=mid name=payloop}
                        <input type="radio" name="gateway" value="{$mid}" {if $submit && $submit.gateway==$mid||$mid==$paygateid}checked="checked" {elseif $smarty.foreach.payloop.first}checked="checked"{/if}/>
                        {$module}
                    {/foreach}
                </center>
            {/if}
        </div>
    </div>
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
                    <li {if !isset($submit) || $submit.cust_method=='newone'}class="bgon2" {else}class="bgoff2"{/if}>
                        <input type="radio" name="cust_method" value="newone" {if !isset($submit) || $submit.cust_method=='newone'}checked='checked'{/if}onclick="{literal}ajax_update('index.php?cmd=signup',{layer:'ajax'},'#updater',true);$(this).parent().parent().find('li.bgon2').removeClass('bgon2').addClass('bgoff2');$(this).parent().removeClass('bgoff2').addClass('bgon2');{/literal}"/>
                        {$lang.newclient}</li>
                    <li {if $submit.cust_method=='login'}class="bgon2" {else}class="bgoff2"{/if}>
                        <input type="radio" name="cust_method" value="login"
                               {if $submit.cust_method=='login'}checked='checked'{/if}
                               onClick="{literal}ajax_update('index.php?cmd=login',{layer:'ajax'},'#updater',true);$(this).parent().parent().find('li.bgon2').removeClass('bgon2').addClass('bgoff2');$(this).parent().removeClass('bgoff2').addClass('bgon2');{/literal}"/>
                        {$lang.alreadyclient}</li>
                </ul>
            </div>
            <div class="wbox_content">
                <div id="updater">
                    {if $submit.cust_method=='login'}
                        {include file='ajax.login.tpl'}
                    {else}
                        {include file='ajax.signup.tpl'}
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
                        <textarea id="c_notes" onblur="if (this.value=='')this.value='{$lang.c_tarea}';" onfocus="if(this.value=='{$lang.c_tarea}')this.value='';" style="width:98%" rows="3" name="notes">{$lang.c_tarea}</textarea>
                    </td>
                </tr>
                {if $tos}
                    <tr>
                        <td align="center"><input type="checkbox" value="1" name="tos"/> {$lang.tos1} <a href="{$tos}" target="_blank">{$lang.tos2}</a>
                        </td>
                    </tr>
                {/if}</table>
        </div>
    </div>
    <p align="right">
        <a href="#" onclick="$('#orderform').submit();return false;" id="checksubmit">{$lang.checkout}</a>
    </p>
</form>