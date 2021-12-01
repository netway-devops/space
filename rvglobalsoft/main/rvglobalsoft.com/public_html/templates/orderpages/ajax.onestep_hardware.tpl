<input type="hidden" id="pidi" value="{$product.id}"/>
<!-- Plan Details -->

<div class="plan-details clearfix _setupstage">
    <form id="cartforms">
        <h2>{$lang.plandetails}</h2>
        {if $product.description}<p>{$product.description}</p>{/if}
        {*<p>Here’s your plan details. You can <b>tweak your options</b></p>
        <p>at any time, before proceeding to checkout.</p>*}
        
        {if $custom}
            {foreach from=$custom item=cf}
                {if $cf.items}
                    <div class="plan-option clearfix">
                        <p> 
                            {$cf.name} {if $cf.options &1}*
                            {/if}
                        </p>
                        <div class="option-custom {$cf.type}_0{$cf.key} {$cf.type}_1{$cf.variable} {$cf.type}_2{$cf.category|lower|regex_replace:'/[^a-z]/':''} {$cf.type}_3{$cf.name|lower|regex_replace:'/[^a-z]/':''}">
                            {if $cf.type!='slider'}<div class="clear"></div>
                            {/if}
                            {include file=$cf.configtemplates.cart}
                        </div>
                    </div>
                {/if}
            {/foreach}
        {/if}
        <script type="text/javascript">$('[id$=_value_indicator]').addClass('plan-value').prev('div').removeAttr('style');</script>
        {if ($product.hostname) && !($cart_contents[0].domainoptions.register=='1' ||  $allowown || $subdomain)}
            <div class="plan-option clearfix">
                <p>  {$lang.hostname}* </p>
                <div class="option-custom">
                    <input name="domain" style="width: 96%;" value="{$item.domain}" class="styled" size="50" onchange="if(typeof simulateCart == 'function') simulateCart();"/>
                </div>
            </div>
            {if $product.extra.enableos=='1' && !empty($product.extra.os)}
               <div class="plan-option clearfix">
                    <p> {$lang.ostemplate} *</p>
                    <div class="option-custom">
                        <select name="ostemplate" class="styled"   onchange="simulateCart('#cart3');">
                            {foreach from=$product.extra.os item=os}
                                <option value="{$os.id}"  {if $item.ostemplate==$os.id}selected="selected"{/if}>{$os.name}</option>
                            {/foreach}
                        </select>      
                    </div>
                </div>
            {/if}
        {/if}
        <input type="hidden" name="addon[0]" value="0" />
        {foreach from=$addons item=a key=k}
            <div class="plan-option clearfix">
                <p> 
                    <input name="addon[{$k}]" type="checkbox" value="1" {if $contents[3].$k}checked="checked"{/if}/> 
                    {$a.name}
                </p>
                <div class="option-custom right">

                    {if $a.paytype=='Free'}
                        <span class="product-cycle cycle-free">{$lang.free}</span>
                        <input type="hidden" name="addon_cycles[{$k}]" value="free"/>
                    {elseif $a.paytype=='Once'}
                        <span class="product-price cycle-once">{$a.m|price:$currency}</span>
                        <span class="product-cycle cycle-once">{$lang.once}</span>
                        {if $a.m_setup!=0}<span class="product-setup cycle-once">{$a.m_setup|price:$currency} {$lang.setupfee}</span>
                        {/if}
                        <input type="hidden" name="addon_cycles[{$k}]" value="once"/>
                    {else}
                        <select name="addon_cycles[{$k}]" >
                            {foreach from=$a item=p_price key=p_cycle}
                                {if $p_price > 0 && ($p_cycle == 'd' || $p_cycle == 'w' || $p_cycle == 'm' || $p_cycle == 'q' || $p_cycle == 's' || $p_cycle == 'a' || $p_cycle == 'b' || $p_cycle == 't' || $p_cycle == 'p4' || $p_cycle == 'p5') }
                                    <option value="{$p_cycle}" {if (!$contents[3][$k] && $cycle==$p_cycle) || $contents[3][$k].recurring==$p_cycle} selected="selected"{/if}>{$a.$p_cycle|price:$currency} {assign var=p_scycle value="`$p_cycle`_setup"}{$lang.$p_cycle}{if $a.$p_scycle!=0} + {$a.$p_scycle|price:$currency} {$lang.setupfee}{/if}</option>
                                {/if}
                            {/foreach}
                        </select>
                    {/if}

                </div>
            </div>
        {/foreach}
        <input type="hidden" name="subproducts[0]" value="0" />

        {foreach from=$subproducts item=a key=k}
            <div class="plan-option  clearfix">
                <p> 
                    <input name="subproducts[{$k}]" type="checkbox" value="1" {if $contents[4].$k}checked="checked"{/if}/> 
                    {$a.category_name} - {$a.name}
                </p> 
                <div class="option-custom right">
                    {if $a.paytype=='Free'}
                        <span class="product-cycle cycle-free">{$lang.free}</span>
                        <input type="hidden" name="subproducts_cycles[{$k}]" value="free"/>
                    {elseif $a.paytype=='Once'}
                        <span class="product-price cycle-once">{$a.m|price:$currency}</span>
                        <span class="product-cycle cycle-once">{$lang.once}</span>
                        {if $a.m_setup!=0}<span class="product-setup cycle-once">{$a.m_setup|price:$currency} {$lang.setupfee}</span>
                        {/if}
                        <input type="hidden" name="subproducts_cycles[{$k}]" value="once"/>
                    {else}
                        <select name="subproducts_cycles[{$k}]" >
                            {foreach from=$a item=p_price key=p_cycle}
                                {if $p_price > 0 && ($p_cycle == 'd' || $p_cycle == 'w' || $p_cycle == 'm' || $p_cycle == 'q' || $p_cycle == 's' || $p_cycle == 'a' || $p_cycle == 'b' || $p_cycle == 't' || $p_cycle == 'p4' || $p_cycle == 'p5') }
                                    <option value="{$p_cycle}" {if (!$contents[4][$k] && $cycle==$p_cycle) || $contents[3][$k].recurring==$p_cycle} selected="selected"{/if}>{$a.$p_cycle|price:$currency} {assign var=p_scycle value="`$p_cycle`_setup"}{$lang.$p_cycle}{if $a.$p_scycle!=0} + {$a.$p_scycle|price:$currency} {$lang.setupfee}{/if}</option>
                                {/if}
                            {/foreach}
                        </select>
                    {/if}
                </div>
            </div>
        {/foreach}

        {if ($cart_contents[0].domainoptions.register)=='1' && ($allowregister || $allowtransfer || $allowown || $subdomain)}
            <div class="plan-option clearfix">

                <div class="btn-group">
                    {if $allowregister}
                        <button rel="t1" class="btn {if $contents[2].action=='register' || !$contents[2]}active{/if}" onclick="tabbme(this); return false;">{$lang.register}</button>
                    {/if}
                    {if $allowtransfer}
                        <button rel="t2" class="btn {if $contents[2].action=='transfer'}active{/if}" onclick="tabbme(this);  return false;">{$lang.transfer}</button>
                    {/if}
                    {if $allowown}
                        <button rel="t3" class="btn {if $contents[2].action=='own' && !$subdomain}active{/if}" onclick="tabbme(this); return false;">{$lang.alreadyhave}</button>
                    {/if}
                    {if $subdomain}
                        <button rel="t4" class="btn {if $contents[2].action=='own' && $subdomain}active{/if}" onclick="tabbme(this);  return false;">{$lang.subdomain}</button>
                    {/if}
                </div>
                {if $contents[2]}
                    <div id="domoptions22">
                        {foreach from=$contents[2] item=domenka key=kk}
                            {if $domenka.action!='own' && $domenka.action!='hostname'}
                                <strong>{if $domenka.action=='register'}{$lang.domainregister}{elseif $domenka.action=='transfer'}{$lang.domaintransfer}{/if}</strong> - {$domenka.name} - {$domenka.period} {$lang.years}
                                {$domenka.price|price:$currency}<br />
                            {else}
                                {$domenka.name}<br />
                            {/if}
                            {if $domenka.custom}
                                <form class="cartD" action="" method="post">
                                    <table class="styled" width="100%" cellspacing="" cellpadding="6" border="0">
                                        {foreach from=$domenka.custom item=cf}
                                            {if $cf.items}
                                                <tr>
                                                    <td class="configtd" >
                                                        <label for="custom[{$cf.id}]" class="styled">{$cf.name}{if $cf.options & 1}*{/if}</label>
                                                        {if $cf.description!=''}<div class="fs11 descr" style="">{$cf.description}</div>
                                                        {/if}
                                                        {include file=$cf.configtemplates.cart cf_opt_formId=".cartD" cf_opt_name="custom_domain"}
                                                    </td>
                                                </tr>
                                            {/if}   
                                        {/foreach}
                                    </table>
                                </form>
                            {/if}
                        {/foreach}
                        <a href="#" class="btn" onclick="$('#domoptions22').hide();$('#domoptions11').show();return false;">{$lang.change}</a>
                    </div>
                {/if}
                <div {if $contents[2]}style="display:none"{/if} id="domoptions11">
                    <input type="hidden" value="{$cart_contents[0].id}" id="product_id" name="product_id" />
                    <input type="hidden" name="make" value="checkdomain" />
                    <div id="options">
                        {if $allowregister}
                            <div id="illregister" class="t1 slidme">
                                <input type="radio" name="domain" value="illregister" style="display: none;" checked="checked"/>
                                <div class="domain-input-bulk domain-input left" id="multisearch">
                                    <textarea name="sld_register" id="sld_register" style="resize: none"></textarea>
                                </div>

                                <div class="domain-tld-bulk domain-tld" style="margin-left:10px;width:310px;float:left">
                                    <table border="0" cellpadding="0" cellspacing="0" width="100%" style="" class="fs11">
                                        {foreach from=$tld_reg item=tldname name=ttld}
                                            {if !$smarty.foreach.ttld.first && $smarty.foreach.ttld.index % 3 == 0}
                                                </tr>
                                            {/if}
                                            {if !$smarty.foreach.ttld.last && $smarty.foreach.ttld.index % 3 == 0}
                                                <tr>
                                                {/if}
                                                <td width="33%"><input type="checkbox" name="tld[]" value="{$tldname}" {if $smarty.foreach.ttld.first}checked="checked"{/if} class="tld_register"/> 
                                                    {$tldname}
                                                </td>
                                                {if $smarty.foreach.ttld.last}</tr>
                                                {/if}
                                            {/foreach}
                                        <tr></tr>
                                    </table>
                                </div>
                                <div class="clear"></div>
                                <p class="align-right domain-check-bulk">
                                    <input type="submit" value="{$lang.check}" class="btn domain-check" onclick="domainCheck(); return false;"/>
                                </p>
                            </div>
                        {/if}
                        {if $allowtransfer}
                            <div id="illtransfer" style="{if $allowregister}display: none;{/if}"  class="t2 slidme align-center form-horizontal">
                                <input type="radio" style="display: none;" value="illtransfer" name="domain" {if !$allowregister}checked="checked"{/if}/>
                                www.
                                <input type="text" value="" size="40" name="sld_transfer" id="sld_transfer" class="styled domain-input"/>
                                <select name="tld_transfer" id="tld_transfer" class="span2 domain-tld">
                                    {foreach from=$tld_tran item=tldname}
                                        <option>{$tldname}</option> 	
                                    {/foreach}
                                </select>  
                                <input type="submit" value="{$lang.check}" class="btn domain-check" onclick="domainCheck(); return false;"/>
                            </div>
                        {/if}
                        {if $allowown}
                            <div id="illupdate" style="{if $allowregister || $allowtransfer}display: none;{/if}"  class="t3 slidme align-center form-horizontal">
                                <input type="radio" style="display: none;" value="illupdate" name="domain" {if !$allowregister && !$allowtransfer}checked="checked"{/if}/>
                                www.
                                <input type="text" value="" size="40" name="sld_update" id="sld_update" class="styled domain-input"/>
                                .
                                <input type="text" value="" size="7" name="tld_update" id="tld_update" class="styled span2 domain-tld"/>  <input type="submit" value="{$lang.check}" class="btn domain-check" onclick="domainCheck(); return false;"/>
                            </div>
                        {/if}
                        {if $subdomain}
                            <div id="illsub" style="{if $allowregister || $allowtransfer || $allowown}display: none;{/if}"  class="t4 slidme align-center form-horizontal">
                                <input type="radio" style="display: none;" value="illsub" name="domain"  {if !($allowregister || $allowtransfer || $allowown)}checked="checked"{/if}/>
                                www.
                                <input type="text" value="" size="40" name="sld_subdomain" id="sld_subdomain" class="styled domain-input"/>  
                                {$subdomain} <input type="submit" value="{$lang.check}" class="btn domain-check" onclick="domainCheck(); return false;"/>
                            </div>
                        {/if}
                    </div>
                    <div id="updater2">{include file="ajax.checkdomain.tpl"} </div>
                </div>
            </div>   
        {/if}
    </form>
    <div class="promotional-code-box">
        {if !$subtotal.coupon}
            <p>Have <b>promotional code?</b></p>
            <div class="promocode-field">
                <input id="couponcde" type="text">
                <a href="#" onclick="applyCoupon(); return false">{$lang.check}</a>
            </div>
        {else}
            <a href="#"onclick="removeCoupon(); return false" title="Remove coupon">{$subtotal.coupon}</a>
        {/if}
        
    </div>
</div>

<!-- Order Summary -->

<div class="order-summary" id="summarybox">
    <h2>{$lang.ordersummary}</h2>
    <p>If your happy with your plan, please click on <b>Checkout</b> button and follow next steps.</p>

    <div class="billing-method">
        <div class="billing-method-field">
            {include file="common/price.tpl" allprices='cycle' product=$product}
        </div>
       {$lang.pickcycle}
    </div>

    <div class="summary-table-bg-fix clear">
        <div class="summary-table-bg">
            <table>
                <tr class="header-row">
                    <th class="description-cell">{$lang.Description}</th>
                    <th>{$lang.price}</th>
                </tr>
                {counter name=alter print=false start=1 assign=alter}
                {if $product}
                    <tr class="th-margin">
                        <td class="description-col">{$contents[0].category_name} - {$contents[0].name} {if $contents[0].domain}({$contents[0].domain}){/if}</td>
                        <td >
                            <span class="bold">
                                {if $contents[0].price==0}{$lang.Free}
                                {elseif $contents[0].prorata_amount}{$contents[0].prorata_amount|price:$currency} ({$lang.prorata} {$contents[0].prorata_date|dateformat:$date_format})
                                {else}{$contents[0].price|price:$currency}
                                {/if}
                            </span>
                            {if $contents[0].setup!=0} + {$contents[0].setup|price:$currency} {$lang.setupfee}
                            {/if}
                            {if $contents[0].recurring && $contents[0].price > 0}{assign value=$contents[0].recurring var=recurring}{$lang[$recurring]}
                            {elseif $contents[0].price > 0}{$lang.once}
                            {/if}
                        </td>
                    </tr>
                {/if}
                {* FORMS *}
                {if $cart_contents[1]}
                    {foreach from=$cart_contents[1] item=cstom2 key=ckey}
                        {foreach from=$cstom2 item=cstom}
                            {if $cstom.price!=0 || $custom[$ckey].config.dontchargedefault}
                            <tr {if $alter%2==0}class="th-margin"{else}class="dark-row"{/if}>
                                <td class="description-col">
                                    {if $cstom.type == 'slider' || $cstom.type == 'qty'}
                                        {$cstom.fullname} {if $cstom.qty>1} <span class="green-val"> {$cstom.qty}</span>
                                        {/if}
                                    {elseif $cstom.type == 'select' || $cstom.type == 'radio'}
                                        {$cstom.name} 
                                        {$cstom.sname}
                                    {else}
                                        {$cstom.name}
                                    {/if}
                                </td>
                                <td>
                                    <span class="bold">
                                        {if $cstom.price==0}{$lang.Free}
                                        {elseif $cstom.prorata_amount}{$cstom.prorata_amount|price:$currency}
                                        {else}{$cstom.price|price:$currency}
                                        {/if} 
                                    </span>
                                    {if $cstom.recurring == 'once' && $cstom.price > 0}{$lang.once}
                                    {/if}

                                    {if $cstom.setup!=0} + {$cstom.setup|price:$currency} {$lang.setupfee}
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
                        <tr {if $alter%2==0}class="th-margin"{else}class="dark-row"{/if}>
                            <td class="description-col">{$lang.addon} {$addon.name}</td>
                            <td >
                                <span class="bold">
                                    {if $addon.price==0}{$lang.Free}
                                    {elseif $addon.prorata_amount}{$addon.prorata_amount|price:$currency} ({$lang.prorata} {$addon.prorata_date|dateformat:$date_format})
                                    {else}{$addon.price|price:$currency}
                                    {/if}
                                </span>
                                {if $addon.setup!=0} + {$addon.setup|price:$currency} {$lang.setupfee}
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
                        <tr {if $alter%2==0}class="th-margin"{else}class="dark-row"{/if}>
                            <td class="description-col">{$subprod.category_name} {$subprod.name}</td>
                            <td >
                                <span class="bold">
                                    {if $subprod.price==0}{$lang.Free}
                                    {elseif $subprod.prorata_amount}{$subprod.prorata_amount|price:$currency} ({$lang.prorata} {$subprod.prorata_date|dateformat:$date_format})
                                    {else}{$subprod.price|price:$currency}
                                    {/if}
                                </span>
                                {if $subprod.setup!=0} + {$subprod.setup|price:$currency} {$lang.setupfee}
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
                        <tr {if $alter%2==0}class="th-margin"{else}class="dark-row"{/if}>
                            <td class="description-col">

                                {if $domenka.action=='register'}{$lang.domainregister}
                                {elseif $domenka.action=='transfer'}{$lang.domaintransfer}
                                {/if} 


                                {$domenka.name}

                            </td>
                            <td >
                                <span class="bold">
                                    {$domenka.price|price:$currency}
                                </span> {$domenka.period}&nbsp;{$lang.years}
                                {if $domenka.dns}&raquo; {$lang.dnsmanage} (+ {$domenka.dns|price:$currency})<br/>
                                {/if}
                                {if $domenka.idp}&raquo; {$lang.idprotect}(+ {$domenka.idp|price:$currency})<br/>
                                {/if}
                                {if $domenka.email}&raquo; {$lang.emailfwd} (+ {$domenka.email|price:$currency})<br/>
                                {/if}
                            </td>
                        </tr>
                        {counter name=alter}
                    {/foreach}
                {/if}
                {if $tax}
                    {if $subtotal.coupon}  
                        <tr {if $alter%2==0}class="th-margin"{else}class="dark-row"{/if}{counter name=alter}>
                            <td class="description-col">{$lang.discount}</td>
                            <td >- {$subtotal.discount|price:$currency}</td>
                        </tr>  
                    {/if}
                    {if $tax.tax1 && $tax.taxed1!=0}
                        <tr {if $alter%2==0}class="th-margin"{else}class="dark-row"{/if}{counter name=alter}>
                            <td class="description-col">{$tax.tax1name} @ {$tax.tax1}%  </td>
                            <td >{$tax.taxed1|price:$currency}</td>
                        </tr>
                    {/if}
                    {if $tax.tax2  && $tax.taxed2!=0}
                        <tr {if $alter%2==0}class="th-margin"{else}class="dark-row"{/if}{counter name=alter}>
                            <td class="description-col">{$tax.tax2name} @ {$tax.tax2}%  </td>
                            <td >{$tax.taxed2|price:$currency}</td>
                        </tr>
                    {/if}
                    {if $tax.credit!=0}
                        <tr {if $alter%2==0}class="th-margin"{else}class="dark-row"{/if}{counter name=alter}>
                            <td class="description-col">{$lang.credit} </td>
                            <td >{$tax.credit|price:$currency}</td>
                        </tr>
                    {/if}
                {elseif $credit}
                    {if  $credit.credit!=0}
                        <tr {if $alter%2==0}class="th-margin"{else}class="dark-row"{/if}{counter name=alter}>
                            <td class="description-col">{$lang.credit} </td>
                            <td >{$credit.credit|price:$currency}</td>
                        </tr>
                    {/if}
                    {if $subtotal.coupon}  
                        <tr {if $alter%2==0}class="th-margin"{else}class="dark-row"{/if}{counter name=alter}>
                            <td class="description-col">{$lang.discount}</td>
                            <td >- {$subtotal.discount|price:$currency}</td>
                        </tr>  
                    {/if}
                {else}
                    {if $subtotal.coupon}  
                        <tr {if $alter%2==0}class="th-margin"{else}class="dark-row"{/if}{counter name=alter}>
                            <td class="description-col">{$lang.discount}</td>
                            <td >- {$subtotal.discount|price:$currency}</td>
                        </tr>  
                    {/if}
                {/if}
                {if !empty($tax.recurring) || !empty($subtotal.recurring)}
                    <tr class="total-row">
                        <td class="total-text">{$lang.total_recurring}</td>
                        <td>
                            {if !empty($tax.recurring)}
                                {foreach from=$tax.recurring item=rec key=k}
                                    {$rec|price:$currency} {$lang.$k}
                                {/foreach}
                            {elseif !empty($subtotal.recurring)}
                                {foreach from=$subtotal.recurring item=rec key=k}
                                    {$rec|price:$currency} {$lang.$k}
                                {/foreach} 
                            {/if}
                        </td>

                    </tr>
                {/if}
            </table>
            <span class="total-value">{$lang.total_today}</span>
            <p>
                {if $tax}
                    {$tax.total|price:$currency:true:false:false}
                {elseif $credit}
                    {$credit.total|price:$currency:true:false:false}
                {else}
                    {$subtotal.total|price:$currency:true:false:false}
                {/if}
            </p>
        </div>
    </div>

    <div class="order-button-fix">
        <a class="order-button _setupstage" href="#" onclick="orderstage(); return false;">{$lang.ordernow}</a>
        <a class="order-button _orderstage" href="#" onclick="$('#orderform').submit(); return false;">{$lang.checkout}</a>
    </div>
</div>
                
{if $gateways}
    <div class="payment-methods _orderstage">
        <h2>{$lang.paymethod}</h2>
        <ul class="clearfix">
            {foreach from=$gateways item=module key=mid name=payloop}
                <li><input type="radio" name="gateway" value="{$mid}"  onclick="return pop_ccform($(this).val())" {if $submit && $submit.gateway==$mid || $mid==$paygateid}checked="checked"{elseif $smarty.foreach.payloop.first}checked="checked"{/if}/> {$module} </li>
                {/foreach}
        </ul>
    </div>
{/if}
<div id="gatewayform" class="_orderstage" {if $tax && $tax.total==0}style="display:none"{elseif $credit && $credit.total==0}style="display:none"{elseif $subtotal.total==0}style="display:none"{/if}>
    {$gatewayhtml}
    <script type="text/javascript"> reform_ccform(); </script>
</div>
<script type="text/javascript">$(function(){literal}{{/literal}setcustomvisible({if $submit.make}true{else}false{/if}){literal}}{/literal}); </script>  