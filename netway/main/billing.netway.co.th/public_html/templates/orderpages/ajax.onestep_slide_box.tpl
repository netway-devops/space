{if $product}
    <div class="descbox">
        <div class="infopricetag left">
            <strong>{$product.name}</strong><br />
            <form id="cart2" action="" method="post">
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
            </form>	
            <div id="load-img" style="display:none;" ><center><img src="{$template_dir}img/ajax-loading.gif" /></center></div>
        </div>


        <div class="bigbluepricetag right">
            <strong>{$lang.total_today}</strong><br />
            <span style="vertical-align: top; font-size: 20px;color:#CCCCCC">{$currency.sign}</span>
            {if $tax}
                <span class="cart_total">{$tax.total|price:$currency:false}</span>
            {elseif $credit}
                <span class="cart_total">{$credit.total|price:$currency:false}</span>
            {else}
                <span class="cart_total">{$subtotal.total|price:$currency:false}</span>
            {/if}
        </div>

        <div class="graypricetag right">
            <strong>{$lang.subtotal}</strong><br />
            <span style="vertical-align: top; font-size: 20px;">{$currency.sign}</span>

            {if $tax}<span class="cart_total cart_total_light">{$tax.subtotal|price:$currency:false}</span>
            {elseif $credit}<span class="cart_total cart_total_light"> {$subtotal.total|price:$currency:false}</span>
            {elseif $subtotal.coupon}<span class="cart_total cart_total_light">{$subtotal.total|price:$currency:false}</span>
            {else}<span class="cart_total cart_total_light">{$subtotal.total|price:$currency:false}</span>
            {/if}	
        </div>






        <div class="clear"></div>
    </div>

{/if}
{if $product.description!=''}<div style="margin-bottom:20px" class="clear">{$product.description}</div>{/if}	
<div class="left mright20" style="width:520px;">
    {if ($cart_contents[0].domainoptions.register)=='1' && ($allowregister || $allowtransfer || $allowown || $subdomain)}
        <div class="newbox1header">
            <h3 class="modern">{$lang.mydomains}</h3>
            <ul class="wbox_menu tabbme">
                {if $allowregister}<li class="t1 {if $contents[2].action=='register' || !$contents[2]}on{/if}" onclick="tabbme(this);">{$lang.register}</li>{/if}
                {if $allowtransfer}<li class="t2 {if $contents[2].action=='transfer'}on{/if}" onclick="tabbme(this);">{$lang.transfer}</li>{/if}
                {if $allowown}<li class="t3 {if $contents[2].action=='own' && !$subdomain}on{/if}" onclick="tabbme(this);">{$lang.alreadyhave}</li>{/if}
                {if $subdomain}<li class="t4 {if $contents[2].action=='own' && $subdomain}on{/if}" onclick="tabbme(this);">{$lang.subdomain}</li>{/if}

            </ul>
        </div>
        <div class="newbox1">
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
                            <div align="center" id="illregister" class="t1 slidme">
                                <input type="radio" name="domain" value="illregister" style="display: none;" checked="checked"/>
                                <div id="multisearch" class="left">
                                    <textarea name="sld_register" id="sld_register"></textarea>
                                </div>
                                <div style="margin-left:10px;width:310px;float:left">
                                    <table border="0" cellpadding="0" cellspacing="0" width="100%"  class="fs11">
                                        {foreach from=$tld_reg item=tldname name=ttld}
                                            {if $smarty.foreach.ttld.index % 3 =='0'}<tr>{/if}
                                                <td width="33%"><input type="checkbox" name="tld[]" value="{$tldname}" {if $smarty.foreach.ttld.first}checked="checked"{/if} class="tld_register"/> {$tldname}</td>
                                                {if $smarty.foreach.ttld.index % 3 =='5'}</tr>{/if}

                                        {/foreach}
                                        <tr>

                                        </tr>

                                    </table>
                                </div>
                                <div class="clear"></div>
                                <p align="right"><input type="submit" value="{$lang.check}" style="font-size:12px;font-weight:bold" class="padded btn"/></p>
                            </div>
                        {/if}
                        {if $allowtransfer}
                            <div align="center" id="illtransfer" style="{if $allowregister}display: none;{/if}"  class="t2 slidme form-inline">
                                <input type="radio" style="display: none;" value="illtransfer" name="domain" {if !$allowregister}checked="checked"{/if}/>
                                www.
                                <input type="text" value="" size="40" name="sld_transfer" id="sld_transfer" class="styled span3"/>
                                <select name="tld_transfer" id="tld_transfer" class="span2">
                                    {foreach from=$tld_tran item=tldname}
                                        <option>{$tldname}</option> 	
                                    {/foreach}
                                </select>  <input type="submit" value="{$lang.check}" style="font-size:12px;font-weight:bold" class="padded btn"/>
                            </div>
                        {/if}
                        {if $allowown}
                            <div align="center" id="illupdate" style="{if $allowregister || $allowtransfer}display: none;{/if}"  class="t3 slidme form-inline">
                                <input type="radio" style="display: none;" value="illupdate" name="domain" {if !$allowregister && !$allowtransfer}checked="checked"{/if}/>
                                www.
                                <input type="text" value="" size="40" name="sld_update" id="sld_update" class="styled span3"/>
                                .
                                <input type="text" value="" size="7" name="tld_update" id="tld_update" class="styled span2"/>  <input type="submit" value="{$lang.check}" style="font-size:12px;font-weight:bold" class="padded btn"/>
                            </div>
                        {/if}
                        {if $subdomain}

                            <div align="center" id="illsub" style="{if $allowregister || $allowtransfer || $allowown}display: none;{/if}"  class="t4 slidme form-inline">
                                <input type="radio" style="display: none;" value="illsub" name="domain" {if !($allowregister || $allowtransfer || $allowown)}checked="checked"{/if}/>
                                www.
                                <input type="text" value="" size="40" name="sld_subdomain" id="sld_subdomain" class="styled span3"/>  
                                {$subdomain} <input type="submit" value="{$lang.check}" style="font-size:12px;font-weight:bold" class="padded btn"/>
                            </div>
                        {/if}
                    </div></center>

                </form>
                <form method="post" action="" onsubmit="return onsubmit_2();" id="domainform2">
                    <div id="updater2">{include file="ajax.checkdomain.tpl"} </div>
                </form>
            </div></div>
        {/if}





    <form id="cart3" action="" method="post">
        <input type="hidden" name="cat_id" value="{$current_cat}" />
        {if   $product.hostname ||  $product.extra.enableos || $addons || $custom }
            <h3 class="modern">{$lang.config_options}</h3>
            <div class="newbox1" style="width:510px;">

                <table cellspacing="0" cellpadding="0" border="0" width="100%" class="styled">
                    <colgroup class="firstcol"></colgroup>
                    <colgroup class="alternatecol"></colgroup>
                    {if ($product.hostname) && !($cart_contents[0].domainoptions.register=='1' ||  $allowown || $subdomain)}
                        <tr>
                            <td><strong>{$lang.hostname}</strong> *</td>
                            <td><input name="domain" value="{$item.domain}" class="styled" size="50" onchange="simulateCart('#cart3', true);"/></td>

                        </tr>
                        {if $product.extra.enableos=='1' && !empty($product.extra.os)}
                            <tr>
                                <td><strong>{$lang.ostemplate}</strong> *</td>
                                <td><select name="ostemplate" class="styled"   onchange="simulateCart('#cart3');">
                                        {foreach from=$product.extra.os item=os}
                                            <option value="{$os.id}"  {if $item.ostemplate==$os.id}selected="selected"{/if}>{$os.name}</option>
                                        {/foreach}
                                    </select></td>

                            </tr>
                        {/if}
                    {/if}

                </table>


                {if $custom} <input type="hidden" name="custom[-1]" value="dummy" /><table cellspacing="0" cellpadding="0" border="0" width="100%" class="styled">

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
                {/if}

                {if $subproducts}
                    <input type="hidden" name="subproducts[0]" value="0" />
                    <table cellspacing="0" cellpadding="0" border="0" width="100%" class="styled">

                        {foreach from=$subproducts item=a key=k}
                            <tr><td width="20"><input name="subproducts[{$k}]" type="checkbox" value="1" {if $selected_subproducts.$k}checked="checked"{/if}  onclick="simulateCart('#cart3');"/></td>
                                <td>
                                    <strong>{$a.category_name} - {$a.name}</strong>
                                </td>
                                <td align="right">
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
                {if $addons}

                    <input type="hidden" name="addon[0]" value="0" />

                    <table cellspacing="0" cellpadding="0" border="0" width="100%" class="styled">

                        {foreach from=$addons item=a key=k}
                            <tr><td width="20"><input name="addon[{$k}]" type="checkbox" value="1" {if $selected_addons.$k}checked="checked"{/if}  onclick="simulateCart('#cart3');"/></td>
                                <td>
                                    <strong>{$a.name}</strong>{if $a.description!=''} - {$a.description}{/if}
                                </td>
                                <td  align="right">
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


                {/if}


                <small>{$lang.field_marked_required}</small>
            </div>

        {/if}

</div>
</form>

<div style="width:320px;font-size:11px;" class="right">
    <h3 class="modern">{$lang.ordersummary}</h3>
    <div class="newbox1" >
        <table cellspacing="0" cellpadding="3" border="0"  width="100%" class="ttable">
            <tbody>
                <tr>
                    <th width="55%">{$lang.Description}</th>
                    <th width="45%">{$lang.price}</th>
                </tr>
                {if $product}
                    <tr >
                        <td>{$contents[0].category_name} - <strong>{$contents[0].name}</strong> {if $contents[0].domain}({$contents[0].domain}){/if}<br/>
                        </td>
                        <td align="center">{if $contents[0].price==0}<strong>{$lang.Free}</strong>
                            {elseif $contents[0].prorata_amount}
                            <strong> {$contents[0].prorata_amount|price:$currency}</strong>
                            ({$lang.prorata} {$contents[0].prorata_date|dateformat:$date_format})
                        {else}<strong>{$contents[0].price|price:$currency}</strong>{/if}{if $contents[0].setup!=0} + {$contents[0].setup|price:$currency} {$lang.setupfee}{/if}</td>
                </tr>
                {/if}
                    {if $cart_contents[1]}
                        {foreach from=$cart_contents[1] item=cstom2}
                            {foreach from=$cstom2 item=cstom}
                                {if $cstom.total>0}
                                    <tr >
                                        <td valign="top" class="blighter fs11" style="padding-left:15px">{$cstom.fullname}  {if $cstom.qty>=1}x {$cstom.qty}{/if}<br/>
                                        </td>	 
                                        <td align="center" class="blighter fs11"><strong>{if $cstom.price==0}{$lang.Free}{elseif $cstom.prorata_amount}{$cstom.prorata_amount|price:$currency}{else}{$cstom.price|price:$currency}{/if} 
                                                {if $cstom.setup!=0} + {$cstom.setup|price:$currency} {$lang.setupfee}{/if}</strong></td>
                                    </tr>


                                {/if}
                        {/foreach}{/foreach}

                    {/if}

                    {if $contents[3]}

                        {foreach from=$contents[3] item=addon}
                            <tr >
                                <td>{$lang.addon} <strong>{$addon.name}</strong></td>
                                <td align="center">{if $addon.price==0}<strong>{$lang.Free}</strong>{elseif $addon.prorata_amount}<strong>{$addon.prorata_amount|price:$currency}</strong> ({$lang.prorata} {$addon.prorata_date|dateformat:$date_format}){else}<strong>{$addon.price|price:$currency}</strong>{/if}{if $addon.setup!=0} + {$addon.setup|price:$currency} {$lang.setupfee}{/if}</td>
                            </tr>
                        {/foreach}
                    {/if}	{if $product}

                    {/if}
                    {if $contents[2] && $contents[2][0].action!='own'}
                        {foreach from=$contents[2] item=domenka key=kk}

                            <tr >
                                <td><strong>{if $domenka.action=='register'}{$lang.domainregister}{elseif $domenka.action=='transfer'}{$lang.domaintransfer}{/if}</strong> - {$domenka.name} - {$domenka.period} {$lang.years}
                                    <br/>
                                    {if $domenka.dns}&raquo; {$lang.dnsmanage} (+ {$domenka.dns|price:$currency})<br/>{/if}
                                    {if $domenka.idp}&raquo; {$lang.idprotect}(+ {$domenka.idp|price:$currency})<br/>{/if}
                                    {if $domenka.email}&raquo; {$lang.emailfwd} (+ {$domenka.email|price:$currency})<br/>{/if}
                                </td>
                                <td align="center"><strong>{$domenka.price|price:$currency}</strong></td>
                            </tr>


                        {/foreach}
                    {/if}

                    {if $contents[4]}{foreach from=$contents[4] item=subprod}
                            <tr >
                                <td>{$subprod.category_name} - <strong>{$subprod.name}</strong></td>
                                <td align="center">{if $subprod.price==0}<strong>{$lang.Free}</strong>
                                        {elseif $subprod.prorata_amount}
                                        <strong> {$subprod.prorata_amount|price:$currency}</strong>
                                        ({$lang.prorata} {$subprod.prorata_date|dateformat:$date_format})
                                        {else}<strong>{$subprod.price|price:$currency}</strong>{/if}{if $subprod.setup!=0} + {$subprod.setup|price:$currency} {$lang.setupfee}{/if}</td>
                                        </tr>
                                        {/foreach}{/if}
                                                {if $tax}


                                                    {if $subtotal.coupon}  
                                                        <tr >
                                                            <td align="right">{$lang.discount}</td>
                                                            <td align="center"><strong>- {$subtotal.discount|price:$currency}</strong></td>
                                                        </tr>  
                                                    {/if}

                                                    {if $tax.tax1 && $tax.taxed1!=0}
                                                        <tr >
                                                            <td align="right">{$tax.tax1name} @ {$tax.tax1}%  </td>
                                                            <td align="center">{$tax.taxed1|price:$currency}</td>
                                                        </tr>
                                                    {/if}

                                                    {if $tax.tax2  && $tax.taxed2!=0}
                                                        <tr >
                                                            <td align="right">{$tax.tax2name} @ {$tax.tax2}%  </td>
                                                            <td align="center">{$tax.taxed2|price:$currency}</td>
                                                        </tr>
                                                    {/if}

                                                    {if $tax.credit!=0}
                                                        <tr>
                                                            <td align="right"><strong>{$lang.credit}</strong> </td>
                                                            <td align="center"><strong>{$tax.credit|price:$currency}</strong></td>
                                                        </tr>
                                                    {/if}

                                                {elseif $credit}
                                                    {if  $credit.credit!=0}
                                                        <tr>
                                                            <td align="right"><strong>{$lang.credit}</strong> </td>
                                                            <td align="center"><strong>{$credit.credit|price:$currency}</strong></td>
                                                        </tr>
                                                    {/if}

                                                    {if $subtotal.coupon}  
                                                        <tr >
                                                            <td align="right">{$lang.discount}</td>
                                                            <td align="center"><strong>- {$subtotal.discount|price:$currency}</strong></td>
                                                        </tr>  
                                                    {/if}






                                                {else}


                                                    {if $subtotal.coupon}  
                                                        <tr >
                                                            <td align="right">{$lang.discount}</td>
                                                            <td align="center"><strong>- {$subtotal.discount|price:$currency}</strong></td>
                                                        </tr>  
                                                    {/if}





                                                {/if}

                                                {if !empty($tax.recurring)}
                                                    <tr >
                                                        <td align="right">{$lang.total_recurring}</td>
                                                        <td align="center"> {foreach from=$tax.recurring item=rec key=k}
                                                            {$rec|price:$currency} {$lang.$k}<br/>
                                                            {/foreach} </td>
                                                        </tr>

                                                        {elseif !empty($subtotal.recurring)}
                                                            <tr >
                                                                <td align="right">{$lang.total_recurring}</td>
                                                                <td align="center"> {foreach from=$subtotal.recurring item=rec key=k}
                                                                    {$rec|price:$currency} {$lang.$k}<br/>
                                                                    {/foreach} </td>
                                                                </tr>
                                                                {/if}



                                                                    <tr>
                                                                        <td colspan="2" align="right">
                                                                            {if $subtotal.coupon}

                                                                            {else}
                                                                                <div style="text-align:right"><a href="#" onclick="$(this).hide();
                                                                                        $('#promocode').show();
                                                                                        return false;"><strong>{$lang.usecoupon}</strong></a></div>
                                                                                <div id="promocode" style="display:none;text-align:right">
                                                                                    <form action="" method="post" id="promoform" onsubmit="{if $step!=4}return applyCoupon();{else}{/if}">

                                                                                        <input type="hidden" name="addcoupon" value="true" />
                                                                                        {$lang.code}: <input type="text" class="styled" name="promocode"/> <input type="submit" value="&raquo;" style="font-weight:bold" class="padded btn"/></form>
                                                                                </div>

                                                                            {/if}
                                                                        </td>

                                                                    </tr>




                                                                </tbody>
                                                            </table>


                                                        </div>
                                                                        {if $gateways}
                                                        <div {if $tax && $tax.total==0}style="display:none"{elseif $credit && $credit.total==0}style="display:none"{elseif $subtotal.total==0}style="display:none"{/if}>
                                                            <h3 class="modern">{$lang.choose_payment}</h3>
                                                            <div class="newbox1">





                                                                {if $gateways}
                                                                    <form action="" method="post" id="gatewaylist" onchange="simulateCart('#gatewaylist');">
                                                                        {foreach from=$gateways item=module key=mid name=payloop}
                                                                            <div class="left"><input  onclick="$('#gatewayform').show();
                                                                                    ajax_update('?cmd=cart&action=getgatewayhtml&gateway_id=' + $(this).val(), '', '#gatewayform', true)" type="radio" name="gateway" value="{$mid}" {if $submit && $submit.gateway==$mid || $mid==$paygateid}checked="checked"{elseif $smarty.foreach.payloop.first}checked="checked"{/if}/> {$module} </div>
                                                                        {/foreach}</form>
                                                                    <div class="clear"></div>
                                                                {/if}
                                                            </div></div>{/if}

                                                    </div>
                                                    <div class="clear"></div>




