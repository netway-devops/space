{if !$hidecart}

    {*DOMAIN OPTIONS*}
    {if ($cart_contents[0].domainoptions.register)=='1' && ($allowregister || $allowtransfer || $allowown || $subdomain)}
        <div class="newbox1header">
            <h2 class="modern">{$lang.mydomains}</h2>
            <div class="hr"></div>
            <ul class="wbox_menu tabbme">
                {if $allowregister}<li class="t1 {if $contents[2].action=='register' || !$contents[2]}on{/if}" onclick="tabbme(this);">{$lang.register}</li>{/if}
                {if $allowtransfer}<li class="t2 {if $contents[2].action=='transfer'}on{/if}" onclick="tabbme(this);">{$lang.transfer}</li>{/if}
                {if $allowown}<li class="t3 {if $contents[2].action=='own' && !$subdomain}on{/if}" onclick="tabbme(this);">{$lang.alreadyhave}</li>{/if}
                {if $subdomain}<li class="t4 {if $contents[2].action=='own' && $subdomain}on{/if}" onclick="tabbme(this);">{$lang.subdomain}</li>{/if}
            </ul>
        </div>

        {if $contents[2]}
            <div id="domoptions22">
                {foreach from=$contents[2] item=domenka key=kk}
                    {if $domenka.action!='own'  && $domenka.action!='hostname'}
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
                                                {if $cf.description!=''}<div class="fs11 descr" style="">{$cf.description}</div>{/if}
                                                {include file=$cf.configtemplates.cart cf_opt_formId=".cartD" cf_opt_name="custom_domain"}
                                            </td>
                                        </tr>
                                    {/if}   
                                {/foreach}
                            </table>
                        </form>
                    {/if}
                {/foreach}
                <a href="#" onclick="$('#domoptions22').hide();
                $('#domoptions11').show();
                return false;">{$lang.change}</a>
            </div>
        {/if}
        <div {if $contents[2]}style="display:none"{/if} id="domoptions11">
            <form action="" method="post"  name="domainpicker" onsubmit="return on_submit();">
                <input type="hidden" value="{$cart_contents[0].id}" id="product_id" name="product_id" />
                <input type="hidden" name="make" value="checkdomain" />
                <div id="options">
                    {if $allowregister}
                        <div id="illregister" class="t1 slidme">
                            <input type="radio" name="domain" value="illregister" style="display: none;" checked="checked"/>
                            <div id="multisearch" class="left">
                                <textarea name="sld_register" id="sld_register"></textarea>
                            </div>
                            <div style="margin-left:10px;width:310px;float:left">
                                <table border="0" cellpadding="0" cellspacing="0" width="100%" style="" class="fs11">
                                    {foreach from=$tld_reg item=tldname name=ttld}
                                        {if $smarty.foreach.ttld.index % 3 =='0'}<tr>{/if}
                                            <td width="33%"><input type="checkbox" name="tld[]" value="{$tldname}" {if $smarty.foreach.ttld.first}checked="checked"{/if} class="tld_register"/> {$tldname}</td>
                                            {if $smarty.foreach.ttld.index % 3 =='5'}</tr>{/if}
                                        {/foreach}
                                    <tr></tr>
                                </table>
                            </div>
                            <div class="clear"></div>
                            <p class="align-right"><input type="submit" value="{$lang.check}" style="font-size:12px;font-weight:bold" class="padded btn"/></p>
                        </div>
                    {/if}
                    {if $allowtransfer}
                        <div id="illtransfer" style="{if $allowregister}display: none;{/if}"  class="t2 slidme align-center">
                            <input type="radio" style="display: none;" value="illtransfer" name="domain" {if !$allowregister}checked="checked"{/if}/>
                            www.
                            <input type="text" value="" size="40" name="sld_transfer" id="sld_transfer" class="styled"/>
                            <select name="tld_transfer" id="tld_transfer">
                                {foreach from=$tld_tran item=tldname}
                                    <option>{$tldname}</option> 	
                                {/foreach}
                            </select>  
                            <input type="submit" value="{$lang.check}" style="font-size:12px;font-weight:bold" class="padded btn"/>
                        </div>
                    {/if}
                    {if $allowown}
                        <div id="illupdate" style="{if $allowregister || $allowtransfer}display: none;{/if}"  class="t3 slidme align-center">
                            <input type="radio" style="display: none;" value="illupdate" name="domain" {if !$allowregister && !$allowtransfer}checked="checked"{/if}/>
                            www.
                            <input type="text" value="" size="40" name="sld_update" id="sld_update" class="styled"/>
                            .
                            <input type="text" value="" size="7" name="tld_update" id="tld_update" class="styled"/>  <input type="submit" value="{$lang.check}" style="font-size:12px;font-weight:bold" class="padded btn"/>
                        </div>
                    {/if}
                    {if $subdomain}
                        <div id="illsub" style="{if $allowregister || $allowtransfer || $allowown}display: none;{/if}"  class="t4 slidme align-center">
                            <input type="radio" style="display: none;" value="illsub" name="domain"  {if !($allowregister || $allowtransfer || $allowown)}checked="checked"{/if}/>
                            www.
                            <input type="text" value="" size="40" name="sld_subdomain" id="sld_subdomain" class="styled"/>  
                            {$subdomain} <input type="submit" value="{$lang.check}" style="font-size:12px;font-weight:bold" class="padded btn"/>
                        </div>
                    {/if}
                </div>
            </form>
            <form method="post" action="" onsubmit="return onsubmit_2();" id="domainform2">
                <div id="updater2">{include file="ajax.checkdomain.tpl"} </div>
            </form>
        </div>
    {/if}
    {*END DOMAIN OPTIONS
    PRODCT CONFIG*}
    <h2 class="modern">{$lang.config_options}</h2>
    <div class="hr"></div>
    <form id="cart2" action="" method="post">
        <div class="newbox1 configbox">
            <input type="hidden" name="cat_id" value="{$current_cat}" />
            {price product=$product}
            {if $product.paytype=='Free'}
                <input type="hidden" name="cycle" value="Free" />
                {$lang.price} <strong>{$lang.free}</strong>
            {elseif $product.paytype=='Once'}
                <input type="hidden" name="cycle" value="Once" />
                @@line
            {else}
                {$lang.pickcycle}
                <select name="cycle"   onchange="simulateCart('#cart2');"  id="product_cycle">
                    <option value="@@cycle" @@selected>@@line</option>
                </select>
            {/if}
            {/price}
        </div>
    </form>	
    {* ???????? *}
    {if $addons || $custom || $subproducts || (($product.hostname) && !($cart_contents[0].domainoptions.register=='1' ||  $allowown || $subdomain))}
        <form id="cart3" action="" method="post">
            <div class="newbox1">
                <input type="hidden" name="cat_id" value="{$current_cat}" />
                <table cellspacing="0" cellpadding="0" border="0" width="100%" class="styled">
                    <colgroup class="firstcol"></colgroup>
                    <colgroup class="alternatecol"></colgroup>
                    {if ($product.hostname) && !($cart_contents[0].domainoptions.register=='1' ||  $allowown || $subdomain)}
                        <tr>
                            <td><strong>{$lang.hostname}</strong> *</td>
                            <td><input name="domain" value="{$item.domain}" class="styled" size="50"  onchange="simulateCart('#cart3');"/></td>

                        </tr>
                        {if $product.extra.enableos=='1' && !empty($product.extra.os)}
                            <tr>
                                <td><strong>{$lang.ostemplate}</strong> *</td>
                                <td>
                                    <select name="ostemplate" class="styled"   onchange="simulateCart('#cart3');">
                                        {foreach from=$product.extra.os item=os}
                                            <option value="{$os.id}"  {if $item.ostemplate==$os.id}selected="selected"{/if}>{$os.name}</option>
                                        {/foreach}
                                    </select>
                                </td>
                            </tr>
                        {/if}
                    {/if}
                </table>
                {*FORM FIELDS*}
                {if $custom}
                    <input type="hidden" name="custom[-1]" value="dummy" />
                    <table cellspacing="0" cellpadding="0" border="0" width="100%" class="styled">
                        {foreach from=$custom item=cf} 
                            {if $cf.items}
                                <tr>
                                    <td colspan="2" class="{$cf.key} cf_option">

                                        <label for="custom[{$cf.id}]" class="styled">{$cf.name} {if $cf.options &1}*{/if}</label><br/>
                                        {if $cf.description!=''}<div class="fs11 descr" >{$cf.description}</div>{/if}

                                        {include file=$cf.configtemplates.cart}
                                    </td>
                                </tr>
                            {/if}
                        {/foreach}
                    </table>
                    <small>{$lang.field_marked_required}</small>
                {/if}
                {* SUBPRODUCTS *}
                {if $subproducts}
                    <input type="hidden" name="subproducts[0]" value="0" />
                    <table cellspacing="0" cellpadding="0" border="0" width="100%" class="styled">
                        {foreach from=$subproducts item=a key=k}
                            <tr>
                                <td width="20">
                                    <input name="subproducts[{$k}]" type="checkbox" value="1" {if $selected_subproducts.$k}checked="checked"{/if}  onclick="simulateCart('#cart3');"/>
                                </td>
                                <td>
                                    <strong>{$a.category_name} - {$a.name}</strong>
                                </td>
                                <td class="align-right">
                                    {price product=$a}
                                    {if $a.paytype=='Free'}
                                        {$lang.free}
                                        <input type="hidden" name="subproducts_cycles[{$k}]" value="free"/>
                                    {elseif $a.paytype=='Once'}
                                        <input type="hidden" name="subproducts_cycles[{$k}]" value="once"/>
                                        @@line
                                    {else}
                                        <select name="subproducts_cycles[{$k}]"   onchange="if ($('input[name=\'subproducts[{$k}]\']').is(':checked'))
                                                    simulateCart('#cart3');">
                                            <option value="@@cycle" @@selected>@@line</option>
                                        </select>
                                    {/if}
                                    {/price}
                                </td>
                            </tr>
                        {/foreach}
                    </table>
                {/if}
            </div>
            {* ADDONS *}
            {if $addons}
                <h2>{$lang.prodaddons}</h2>
                <div class="hr"></div>
                <div class="newbox1">
                    <input type="hidden" name="addon[0]" value="0" />
                    <table cellspacing="0" cellpadding="0" border="0" width="100%" class="styled">
                        {foreach from=$addons item=a key=k}
                            <tr>
                                <td width="20">
                                    <input name="addon[{$k}]" type="checkbox" value="1" {if $selected_addons.$k}checked="checked"{/if}  onclick="simulateCart('#cart3');"/>
                                </td>
                                <td>
                                    <strong>{$a.name}</strong>{if $a.description!=''} - {$a.description}{/if}
                                </td>
                                <td >
                                    {price product=$a}
                                    {if $a.paytype=='Free'}
                                        {$lang.free}
                                        <input type="hidden" name="addon_cycles[{$k}]" value="free"/>
                                    {elseif $a.paytype=='Once'}
                                        <input type="hidden" name="addon_cycles[{$k}]" value="once"/>
                                        @@line
                                    {else}
                                        <select name="addon_cycles[{$k}]"   onchange="if ($('input[name=\'addon[{$k}]\']').is(':checked'))
                                                    simulateCart('#cart3');">
                                            <option value="@@cycle" @@selected>@@line</option>
                                        </select>
                                    {/if}
                                    {/price}
                                </td>
                            </tr>
                        {/foreach}
                    </table>
                </div>
            {/if}
        </form>
    {/if}
    {* GATEWAYS *}
    {if $gateways}
        <h2>{$lang.choose_payment}</h2>
        <div class="hr"></div>
        <div class="newbox1" style="text-align: center">
            <form action="" method="post" id="gatewaylist" onchange="simulateCart('#gatewaylist');">
                {foreach from=$gateways item=module key=mid name=payloop}
                    <label><input type="radio" name="gateway" value="{$mid}" onclick="$('#gatewayform').show();
                        ajax_update('?cmd=cart&action=getgatewayhtml&gateway_id=' + $(this).val(), '', '#gatewayform', true)"  {if $submit && $submit.gateway==$mid||$mid==$paygateid}checked="checked"{elseif $smarty.foreach.payloop.first}checked="checked"{/if}/>&nbsp;{$module}</label>
                    {/foreach}
            </form>
        </div>
    {/if}


{/if}{*END HIDECART*}
    {* SUMMARY *}
    <div class="summaryupdate">
        <h2>{$lang.ordersummary}</h2>
        <div class="hr solid"></div>
        {counter start=1 print=false assign=start}

        {* PRODUCT *}
        {if $product}
            <ol>
                <li>{counter}
                    {* {$contents[0].category_name} -*}{$lang.planname}: <strong>{$contents[0].name}</strong> {if $contents[0].domain}({$contents[0].domain}){/if}<br/>
                    <span class="price">
                        {if $contents[0].price==0}
                            <strong>{$lang.Free}</strong>
                        {elseif $contents[0].prorata_amount}
                            <strong> {$contents[0].prorata_amount|price:$currency}</strong>
                            ({$lang.prorata} {$contents[0].prorata_date|dateformat:$date_format})
                        {else}
                            <strong>{$contents[0].price|price:$currency}</strong>
                        {/if}
                        {if $contents[0].setup!=0} 
                            + {$contents[0].setup|price:$currency} {$lang.setupfee}
                        {/if}
                    </span>	
                    {if $contents[0].recurring && $contents[0].price > 0}
                        {assign value=$contents[0].recurring var=recurring}{$lang[$recurring]}
                    {elseif $contents[0].price > 0}
                        {$lang.once}
                    {/if}

                </li>
            </ol>
        {/if}
        {* FORMS *}
        {if $cart_contents[1]}

            <ol start="{$start}">

                {foreach from=$cart_contents[1] item=cstom2}

                    {foreach from=$cstom2 item=cstom}
                        {if $cstom.total>0}
                            <li class="hr">{counter}
                                {$cstom.fullname}  {if $cstom.qty>=1}x {$cstom.qty}{/if} <br />
                                <strong class="price">
                                    {if $cstom.price==0}
                                        {$lang.Free}
                                    {elseif $cstom.prorata_amount}
                                        {$cstom.prorata_amount|price:$currency}
                                    {else}
                                        {$cstom.price|price:$currency}
                                    {/if} 
                                    {if $cstom.setup!=0}
                                        + {$cstom.setup|price:$currency} {$lang.setupfee}
                                    {/if}
                                </strong>
                                {if $cstom.recurring}
                                    {assign value=$cstom.recurring var=recurring}{$lang[$recurring]}
                                {elseif $cstom.price > 0}
                                    {$lang.once}
                                {/if}

                            </li>
                        {/if}
                    {/foreach}
                {/foreach}

            </ol>
        {/if}
        {* ADDONS *}
        {if $contents[3]}
            <ol start="{$start}">
                {foreach from=$contents[3] item=addon}
                    <li class="hr">{counter}
                        {$lang.addon}: <strong>{$addon.name}</strong><br />
                        <span class="price">
                            {if $addon.price==0}
                                <strong>{$lang.Free}</strong>
                            {elseif $addon.prorata_amount}
                                <strong>{$addon.prorata_amount|price:$currency}</strong> ({$lang.prorata} {$addon.prorata_date|dateformat:$date_format})
                            {else}
                                <strong>{$addon.price|price:$currency}</strong>
                            {/if}
                            {if $addon.setup!=0}
                                + {$addon.setup|price:$currency} {$lang.setupfee}
                            {/if}
                        </span>	
                        {if $addon.recurring}
                            {assign value=$addon.recurring var=recurring}{$lang[$recurring]}
                        {elseif $addon.price > 0}
                            {$lang.once}
                        {/if}

                    </li>
                {/foreach}
            </ol>
        {/if}
        {* DOMAINS *}
        {if $contents[2] && $contents[2][0].action!='own'}
            <ol start="{$start}">

                {foreach from=$contents[2] item=domenka key=kk}
                    <li class="hr">{counter}
                        <strong>
                            {if $domenka.action=='register'}
                                {$lang.domainregister}
                            {elseif $domenka.action=='transfer'}
                                {$lang.domaintransfer}
                            {/if}
                        </strong> - {$domenka.name}<br>
                        <span class="price">
                            {if $domenka.dns}
                                &raquo; {$lang.dnsmanage} (+ {$domenka.dns|price:$currency})<br/>
                            {/if}
                            {if $domenka.idp}
                                &raquo; {$lang.idprotect}(+ {$domenka.idp|price:$currency})<br/>
                            {/if}
                            {if $domenka.email}
                                &raquo; {$lang.emailfwd} (+ {$domenka.email|price:$currency})<br/>
                            {/if}
                            <strong>{$domenka.price|price:$currency}</strong><br />
                        </span>
                        {$domenka.period} {$lang.years}


                    </li>
                {/foreach}
            </ol>
        {/if}
        {* SUBPRODUCTS *}
        {if $contents[4]}

            <ol start="{$start}">

                {foreach from=$contents[4] item=subprod}
                    <li class="hr">{counter}
                        {*{$subprod.category_name} -*}{$lang.subproduct}: <strong>{$subprod.name}</strong><br />

                        <span class="price">
                            {if $subprod.price==0}
                                <strong>{$lang.Free}</strong>
                            {elseif $subprod.prorata_amount}
                                <strong> {$subprod.prorata_amount|price:$currency}</strong>
                                ({$lang.prorata} {$subprod.prorata_date|dateformat:$date_format})
                            {else}
                                <strong>{$subprod.price|price:$currency}</strong>
                            {/if}

                            {if $subprod.setup!=0}
                                + {$subprod.setup|price:$currency} {$lang.setupfee}
                            {/if}
                        </span>	
                        {if $subprod.recurring}
                            {assign value=$subprod.recurring var=recurring}{$lang[$recurring]}
                        {elseif $subprod.price > 0}
                            {$lang.once}
                        {/if}


                    </li>
                {/foreach}
            </ol>
        {/if}
        {* TAX *}
        <table id="taxsum" cellpadding="0" cellspacing="0">
            {if $tax}
                {if $subtotal.coupon}  
                    <tr >
                        <td>{$lang.discount}</td>
                        <td><strong>- {$subtotal.discount|price:$currency}</strong></td>
                    </tr>  
                {/if}
                {if $tax.tax1 && $tax.taxed1!=0}
                    <tr >
                        <td>{$tax.tax1name} @ {$tax.tax1}%  </td>
                        <td>{$tax.taxed1|price:$currency}</td>
                    </tr>
                {/if}
                {if $tax.tax2  && $tax.taxed2!=0}
                    <tr >
                        <td>{$tax.tax2name} @ {$tax.tax2}%  </td>
                        <td>{$tax.taxed2|price:$currency}</td>
                    </tr>
                {/if}
                {if $tax.credit!=0}
                    <tr>
                        <td><strong>{$lang.credit}</strong> </td>
                        <td><strong>{$tax.credit|price:$currency}</strong></td>
                    </tr>
                {/if}
            {elseif $credit}
                {if  $credit.credit!=0}
                    <tr>
                        <td><strong>{$lang.credit}</strong> </td>
                        <td><strong>{$credit.credit|price:$currency}</strong></td>
                    </tr>
                {/if}
                {if $subtotal.coupon}  
                    <tr >
                        <td>{$lang.discount}</td>
                        <td><strong>- {$subtotal.discount|price:$currency}</strong></td>
                    </tr>  
                {/if}
            {else}
                {if $subtotal.coupon}  
                    <tr >
                        <td>{$lang.discount}</td>
                        <td><strong>- {$subtotal.discount|price:$currency}</strong></td>
                    </tr>  
                {/if}
            {/if}
            {* RECURING *}
            {if !empty($tax.recurring)}
                <tr>
                    <td>{$lang.total_recurring}</td>
                    <td> {foreach from=$tax.recurring item=rec key=k}
                        {$rec|price:$currency} {$lang.$k}<br/>
                        {/foreach} </td>
                    </tr>
                    {elseif !empty($subtotal.recurring)}
                        <tr >
                            <td>{$lang.total_recurring}</td>
                            <td> {foreach from=$subtotal.recurring item=rec key=k}
                                {$rec|price:$currency} {$lang.$k}<br/>
                                {/foreach} </td>
                            </tr>
                            {/if}
                            </table>
                            {* TOTAL TODAY *}
                            <div class="hr solid"></div>
                            {* CUPON *}
                            {if !$subtotal.coupon}
                                <div id="promocode" style="display:none;">
                                    <form action="" method="post" id="promoform" {if $step!=4}onsubmit="return applyCoupon();" {/if}>
                                        <input type="hidden" name="addcoupon" value="true" />
                                        {$lang.code}: <input type="text" class="styled" name="promocode"/> <input type="submit" value="&raquo;" style="font-weight:bold" class="padded btn"/>
                                    </form>
                                </div>
                                <div id="coupon">
                                    <a href="#" onclick="$(this).hide();
                        $('#promocode').show();
                        return false;"><strong>{$lang.usecoupon}</strong></a>
                                </div>
                            {/if}
                            <div class="total">
                                {$lang.total_today} <br> 
                                <strong>
                                    {if $tax}
                                        {$tax.total|price:$currency}
                                    {elseif $credit}
                                        {$credit.total|price:$currency}
                                    {else}
                                        {$subtotal.total|price:$currency}
                                    {/if}
                                </strong>
                            </div>
                            <div class="load-img" style="display:none;" ><img src="{$template_dir}img/ajax-loading.gif" /></div>
                        </div>