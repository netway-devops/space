<form id="cartforms" action="" method="post">
    <input type="hidden" id="pidi" value="{$product.id}" />
    <div class="setup-server center">
        <h1>{$lang.setupyour}
            <strong>{$contents[0].category_name}</strong>
        </h1>
        <div class="grid">
        </div>
        <div class="glow"></div>
        <div class="cloud-right"></div>
        <div class="clouds">
            <div class="cloud-center">

                <p>&nbsp;</p>
                <span>{$product.name}</span>
            </div>
            <div class="cloud-center-shadow"></div>
        </div>
        <div class="left-options clear">
            <div class="server-options clear">
                <!-- #1  -->
                {counter name=vsliderc print=false assign=vslider start=0}
                {foreach from=$custom item=cf name=vsliders}
                    {if $cf.type == 'slider'}
                        {if $vslider == 0}
                            {include file="onestep_cloud/toggleform.tpl" slideno=$smarty.foreach.vsliders.index}
                        {/if}
                        {counter name=vsliderc}
                    {/if}
                {/foreach}

                <!-- #2 -->

                {counter name=vsliderc print=false assign=vslider start=0}
                {foreach from=$custom item=cf name=vsliders}
                    {if $cf.type == 'slider'}
                        {if $vslider == 1}
                            {include file="onestep_cloud/toggleform.tpl" slideno=$smarty.foreach.vsliders.index}
                        {/if}
                        {counter name=vsliderc}
                    {/if}
                {/foreach}

                <!-- #3 -->

                {counter name=vsliderc print=false assign=vslider start=0}
                {foreach from=$custom item=cf name=vsliders}
                    {if $cf.type == 'slider'}
                        {if $vslider == 2}
                            {include file="onestep_cloud/toggleform.tpl" slideno=$smarty.foreach.vsliders.index}
                        {/if}
                        {counter name=vsliderc}
                    {/if}
                {/foreach}

            </div>
            {if $product.paytype!='Free' && $product.paytype!='Once'}
                <div class="billing-cycle">
                    <p>{$lang.changebillingcycle}:</p>
                    <div class="billing-bg" >
                        {include file='common/price.tpl' allprices='cycle' product=$product }
                    </div>
                </div>
            {/if}
        </div>

        <!-- Plan includes -->
        <div class="plan-includes">
            <div class="plan-includes-pattern">
                <div class="plan-corner-top"></div>
                <div class="plan-corner-down"></div>
                <div class="plan-includes-top">
                    <h2>{$lang.planincludes}</h2>
                    <table class="center">
                        {if $cart_contents[1]}
                            {foreach from=$cart_contents[1] item=cstom2 name=counto}
                                {if $smarty.foreach.counto.index==7}{break}
                                {/if}
                                {foreach from=$cstom2 item=cstom name=counto2}
                                    <tr>
                                        <td class="plan-name">
                                            {if $cstom.type == 'slider' || $cstom.type == 'qty'}
                                                {$cstom.fullname} {if $cstom.qty>=1} {$cstom.qty}
                                                {/if}
                                            {elseif $cstom.type == 'select' || $cstom.type == 'radio'}
                                                {$cstom.name} {$cstom.sname}
                                            {else}
                                                {$cstom.name}
                                            {/if}
                                        </td>
                                        <td class="plan-value">
                                            {if $cstom.price==0}{$lang.Free}
                                            {elseif $cstom.prorata_amount}{$cstom.prorata_amount|price:$currency:true:false:false}
                                            {else}{$cstom.price|price:$currency:true:false:false}
                                            {/if} 
                                        </td>
                                    </tr>
                                    {break}
                                {/foreach}
                            {/foreach}
                        {/if}
                    </table>
                </div>
                <div class="plan-includes-shade"></div>
                <div class="total-price">
                    <span>{$lang.totalprice}:</span>
                    <p>
                        {if $tax}
                            {$tax.total|price:$currency:true:false:false}
                        {elseif $credit}
                            {$credit.total|price:$currency:true:false:false}
                        {else}
                            {$subtotal.total|price:$currency:true:false:false}
                        {/if}
                    </p>
                    {if !$subtotal.coupon}
                        <input id="couponcde" type="text" placeholder="{$lang.usecoupon}">
                        <a href="#" onclick="applyCoupon();
                            return false">{$lang.Go}</a>
                    {else}
                        <a href="#"onclick="removeCoupon();
                                return false" title="{$lang.remove_coupon}">{$subtotal.coupon}</a>
                    {/if}
                </div>
            </div>
        </div>
        <div class="ajax-overlay"></div>
    </div>
    <div class="setup-server-shadow"></div>

    <!--  -->
    <div class="list-of-steps center">
        <h3>{if $opconfig.steps}{$opconfig.steps}{else}Fast and easy{/if}</h3>

        <div class="step-box">
            <div class="customize-icon center"></div>
            {if $opconfig.steps1}<p>{$opconfig.steps1}</p>{else}<p>1. Select a package</p>{/if}
            {if $opconfig.steps1d} <span>{$opconfig.steps1d}</span>{else} <span>Use the slider to setup your plan</span>{/if}

        </div>
        <div class="step-arrow"></div>

        <div class="step-box">
            <div class="details-icon center"></div>
            {if $opconfig.steps2}<p>{$opconfig.steps1}</p>{else}<p>2. Customize your server</p>{/if}
            {if $opconfig.steps2d} <span>{$opconfig.steps1d}</span>{else} <span>Select desired components</span>{/if}
        </div>
        <div class="step-arrow"></div>

        <div class="step-box">
            <div class="launch-icon center"></div>
            {if $opconfig.steps3}<p>{$opconfig.steps3}</p>{else}<p>3. Start your cloud!</p>{/if}
            {if $opconfig.steps3d} <span>{$opconfig.steps3d}</span>{else} <span>Create your cloud hosting with us!</span>{/if}
        </div>

    </div>
    <div class="list-of-steps-shadow"></div>
    <div class="form-details-box">
        {counter name=slidersx print=false assign=slidersx start=0 }
        {foreach from=$custom item=cf}
            {if $cf.items}
                {if $cf.type == 'slider' && $slidersx > 3}
                    {assign value=true var=custom_more}
                {/if}{counter name=slidersx}{continue}
            {/if}
        {/foreach}
        {if $addons || $subproducts || $custom_more || $product.hostname || ($cart_contents[0].domainoptions.register=='1' ||  $allowown || $subdomain) }
            <div class="additional-details">
                <h4>{$lang.additionaldetails}</h4>
                <table>
                    {counter name=slidersnow print=false assign=slidersnow start=0 }
                    {if $custom}
                        {foreach from=$custom item=cf}
                            {if $cf.items}
                                <tr>
                                    {if $cf.type == 'slider' && $slidersnow < 3}
                                        {counter name=slidersnow}
                                    {else}
                                        <td class="detail-name">{$cf.name} {if $cf.options &1}*{/if}</td>
                                        <td class="cf-{$cf.type}">
                                            {include file=$cf.configtemplates.cart}
                                        </td>
                                    {/if}
                                </tr>
                            {/if}
                        {/foreach}
                    {/if}
                    <input type="hidden" name="addon[0]" value="0" />
                    {foreach from=$addons item=a key=k}
                        <tr>
                            <td class="detail-name"> <input name="addon[{$k}]" type="checkbox" value="1" {if $contents[3].$k}checked="checked"{/if}/> <span class="inlbl"> {$a.name}</span></td>
                            <td>
                                {price product=$a}
                                {if $a.paytype=='Free'}
                                    <span class="product-cycle cycle-free">{$lang.free}</span>
                                    <input type="hidden" name="addon_cycles[{$k}]" value="free"/>
                                {elseif $a.paytype=='Once'}
                                    <span class="product-price cycle-once">@@price</span>
                                    <span class="product-cycle cycle-once">{$lang.once}</span>
                                    {if $a.m_setup!=0}<span class="product-setup cycle-once">@@setupline<<' + '@</span>
                                    {/if}
                                    <input type="hidden" name="addon_cycles[{$k}]" value="once"/>
                                {else}
                                    <select name="addon_cycles[{$k}]" >
                                        <option value="@@cycle" @@selected>@@line</option>
                                    </select>
                                {/if}
                                {/price}
                            </td>
                        </tr>
                    {/foreach}
                    <input type="hidden" name="subproducts[0]" value="0" />

                    {foreach from=$subproducts item=a key=k}
                        <tr>
                            <td class="detail-name"> <input name="subproducts[{$k}]" type="checkbox" value="1" {if $contents[4].$k}checked="checked"{/if}/> <span class="inlbl">{$a.category_name} - {$a.name}</span></td>
                            <td>
                                {price product=$a}
                                {if $a.paytype=='Free'}
                                    <span class="product-cycle cycle-free">{$lang.free}</span>
                                    <input type="hidden" name="subproducts_cycles[{$k}]" value="free"/>
                                {elseif $a.paytype=='Once'}
                                    <span class="product-price cycle-once">@@price</span>
                                    <span class="product-cycle cycle-once">{$lang.once}</span>
                                    {if $a.m_setup!=0}<span class="product-setup cycle-once">@@setupline<<' + '@</span>{/if}
                                    <input type="hidden" name="subproducts_cycles[{$k}]" value="once"/>
                                {else}
                                    <select name="subproducts_cycles[{$k}]" >
                                        <option value="@@cycle" @@selected>@@line</option>
                                    </select>
                                {/if}
                                {/price}
                            </td>
                        </tr>
                    {/foreach}

                    {if ($product.hostname) && !($cart_contents[0].domainoptions.register=='1' ||  $allowown || $subdomain)}
                        <tr>
                            <td class="detail-name">{$lang.hostname}*</td>
                            <td><input name="domain" value="{$item.domain}" class="styled" size="50" onchange="if (typeof simulateCart == 'function')
                                        simulateCart();"/>
                            </td>
                        </tr>
                        {if $product.extra.enableos=='1' && !empty($product.extra.os)}
                            <tr>
                                <td class="detail-name">{$lang.ostemplate} *</td>
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
                    {if ($cart_contents[0].domainoptions.register)=='1' && ($allowregister || $allowtransfer || $allowown || $subdomain)}
                        <tr>
                            <td colspan="2" >
                                <div class="btn-group">
                                    {if $allowregister}
                                        <button rel="t1" class="btn {if $contents[2].action=='register' || !$contents[2]}active{/if}" onclick="tabbme(this);
                                                return false;">{$lang.register}</button>
                                    {/if}
                                    {if $allowtransfer}
                                        <button rel="t2" class="btn {if $contents[2].action=='transfer'}active{/if}" onclick="tabbme(this);
                                                return false;">{$lang.transfer}</button>
                                    {/if}
                                    {if $allowown}
                                        <button rel="t3" class="btn {if $contents[2].action=='own' && !$subdomain}active{/if}" onclick="tabbme(this);
                                                return false;">{$lang.alreadyhave}</button>
                                    {/if}
                                    {if $subdomain}
                                        <button rel="t4" class="btn {if $contents[2].action=='own' && $subdomain}active{/if}" onclick="tabbme(this);
                                                return false;">{$lang.subdomain}</button>
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
                                        <br>
                                        <a href="#" class="btn" onclick="$('#domoptions22').hide();
                                                $('#domoptions11').show();
                                                return false;">{$lang.change}</a>
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

                                                <div class="domain-tld-bulk domain-tld" style="margin-left:10px;width:260px;float:left">
                                                    <table border="0" cellpadding="0" cellspacing="0" width="100%" style="" class="fs11">
                                                        {foreach from=$tld_reg item=tldname name=ttld}
                                                            {if !$smarty.foreach.ttld.first && $smarty.foreach.ttld.index % 3 == 0}</tr>
                                                            {/if}
                                                            {if !$smarty.foreach.ttld.last && $smarty.foreach.ttld.index % 3 == 0}<tr>
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
                                                    <input type="submit" value="{$lang.check}" class="btn domain-check" onclick="domainCheck();
                                                            return false;"/>
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
                                                <input type="submit" value="{$lang.check}" class="btn domain-check" onclick="domainCheck();
                                                        return false;"/>
                                            </div>
                                        {/if}
                                        {if $allowown}
                                            <div id="illupdate" style="{if $allowregister || $allowtransfer}display: none;{/if}"  class="t3 slidme align-center form-horizontal">
                                                <input type="radio" style="display: none;" value="illupdate" name="domain" {if !$allowregister && !$allowtransfer}checked="checked"{/if}/>
                                                www.
                                                <input type="text" value="" size="40" name="sld_update" id="sld_update" class="styled domain-input"/>
                                                .
                                                <input type="text" value="" size="7" name="tld_update" id="tld_update" class="styled span2 domain-tld"/>  <input type="submit" value="{$lang.check}" class="btn domain-check" onclick="domainCheck();
                                                        return false;"/>
                                            </div>
                                        {/if}
                                        {if $subdomain}
                                            <div id="illsub" style="{if $allowregister || $allowtransfer || $allowown}display: none;{/if}"  class="t4 slidme align-center form-horizontal">
                                                <input type="radio" style="display: none;" value="illsub" name="domain"  {if !($allowregister || $allowtransfer || $allowown)}checked="checked"{/if}/>
                                                www.
                                                <input type="text" value="" size="40" name="sld_subdomain" id="sld_subdomain" class="styled domain-input"/>  
                                                {$subdomain} <input type="submit" value="{$lang.check}" class="btn domain-check" onclick="domainCheck();
                                                        return false;"/>
                                            </div>
                                        {/if}
                                    </div>
                                </div>
                            </td>
                        </tr>
                        <tr>
                            <td colspan="2"><div id="updater2" style="position: relative">{include file="ajax.checkdomain.tpl"} </td></td>
                        </tr>
                    {/if}


                </table>
            </div>
        {/if}
        <div class="order-summary">
            <h4>{$lang.ordersummary}</h4>
            <div class="summary-bg">
                <table>
                    <tr class="th-header">
                        <th class="description-cell">{$lang.Description}</th>
                        <th class="price-cell">{$lang.price}</th>
                    </tr>
                    {counter name=alter print=false start=1 assign=alter}
                    {if $product}
                        <tr class="th-margin">
                            <td class="description-cell">{$contents[0].category_name} - <strong>{$contents[0].name} {if $contents[0].domain}({$contents[0].domain}){/if}</strong></td>
                            <td class="price-cell">
                                {if $contents[0].price==0}{$lang.Free}
                                {elseif $contents[0].prorata_amount}{$contents[0].prorata_amount|price:$currency} ({$lang.prorata} {$contents[0].prorata_date|dateformat:$date_format})
                                {else}{$contents[0].price|price:$currency}
                                {/if}
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
                        {foreach from=$cart_contents[1] item=cstom2}
                            {foreach from=$cstom2 item=cstom}
                                <tr {if $alter%2==0}class="th-margin"{else}class="dark-row"{/if}>
                                    <td class="description-cell">
                                        {if $cstom.type == 'slider' || $cstom.type == 'qty'}
                                            <strong>{$cstom.fullname}</strong> {if $cstom.qty>=1} <span class="green-val"> {$cstom.qty}</span>{/if}
                                        {elseif $cstom.type == 'select' || $cstom.type == 'radio'}
                                            {$cstom.name} 
                                            <strong>{$cstom.sname}</strong>
                                        {else}
                                            <strong>{$cstom.name}</strong>
                                        {/if}
                                    </td>
                                    <td class="price-cell">
                                        {if $cstom.price==0}{$lang.Free}
                                        {elseif $cstom.prorata_amount}{$cstom.prorata_amount|price:$currency}
                                        {else}{$cstom.price|price:$currency}
                                        {/if} 

                                        {if $cstom.recurring == 'once' && $cstom.price > 0}{$lang.once}
                                        {/if}

                                        {if $cstom.setup!=0} + {$cstom.setup|price:$currency} {$lang.setupfee}
                                        {/if}
                                    </td>
                                </tr>
                                {counter name=alter}
                            {/foreach}
                        {/foreach}
                    {/if}
                    {* ADDONS *}
                    {if $contents[3]}
                        {foreach from=$contents[3] item=addon}
                            <tr {if $alter%2==0}class="th-margin"{else}class="dark-row"{/if}>
                                <td class="description-cell">{$lang.addon} <strong>{$addon.name}</strong></td>
                                <td class="price-cell">
                                    {if $addon.price==0}{$lang.Free}
                                    {elseif $addon.prorata_amount}{$addon.prorata_amount|price:$currency} ({$lang.prorata} {$addon.prorata_date|dateformat:$date_format})
                                    {else}{$addon.price|price:$currency}
                                    {/if}
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
                                <td class="description-cell">{$subprod.category_name} <strong>{$subprod.name}</strong></td>
                                <td class="price-cell">
                                    {if $subprod.price==0}{$lang.Free}
                                    {elseif $subprod.prorata_amount}{$subprod.prorata_amount|price:$currency} ({$lang.prorata} {$subprod.prorata_date|dateformat:$date_format})
                                    {else}{$subprod.price|price:$currency}
                                    {/if}

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
                                <td class="description-cell">

                                    {if $domenka.action=='register'}{$lang.domainregister}
                                    {elseif $domenka.action=='transfer'}{$lang.domaintransfer}
                                    {/if} 

                                    <strong>
                                        {$domenka.name}
                                    </strong>
                                </td>
                                <td class="price-cell">
                                    {$domenka.price|price:$currency} {$domenka.period}&nbsp;{$lang.years}
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
                                <td class="description-cell">{$lang.discount}</td>
                                <td class="price-cell">- {$subtotal.discount|price:$currency}</td>
                            </tr>  
                        {/if}
                        {if $tax.tax1 && $tax.taxed1!=0}
                            <tr {if $alter%2==0}class="th-margin"{else}class="dark-row"{/if}{counter name=alter}>
                                <td class="description-cell">{$tax.tax1name} @ {$tax.tax1}%  </td>
                                <td class="price-cell">{$tax.taxed1|price:$currency}</td>
                            </tr>
                        {/if}
                        {if $tax.tax2  && $tax.taxed2!=0}
                            <tr {if $alter%2==0}class="th-margin"{else}class="dark-row"{/if}{counter name=alter}>
                                <td class="description-cell">{$tax.tax2name} @ {$tax.tax2}%  </td>
                                <td class="price-cell">{$tax.taxed2|price:$currency}</td>
                            </tr>
                        {/if}
                        {if $tax.credit!=0}
                            <tr {if $alter%2==0}class="th-margin"{else}class="dark-row"{/if}{counter name=alter}>
                                <td class="description-cell"><strong>{$lang.credit}</strong> </td>
                                <td class="price-cell">{$tax.credit|price:$currency}</td>
                            </tr>
                        {/if}
                    {elseif $credit}
                        {if  $credit.credit!=0}
                            <tr {if $alter%2==0}class="th-margin"{else}class="dark-row"{/if}{counter name=alter}>
                                <td class="description-cell"><strong>{$lang.credit}</strong> </td>
                                <td class="price-cell">{$credit.credit|price:$currency}</td>
                            </tr>
                        {/if}
                        {if $subtotal.coupon}  
                            <tr {if $alter%2==0}class="th-margin"{else}class="dark-row"{/if}{counter name=alter}>
                                <td class="description-cell">{$lang.discount}</td>
                                <td class="price-cell">- {$subtotal.discount|price:$currency}</td>
                            </tr>  
                        {/if}
                    {else}
                        {if $subtotal.coupon}  
                            <tr {if $alter%2==0}class="th-margin"{else}class="dark-row"{/if}{counter name=alter}>
                                <td class="description-cell">{$lang.discount}</td>
                                <td class="price-cell">- {$subtotal.discount|price:$currency}</td>
                            </tr>  
                        {/if}
                    {/if}
                    {if !empty($tax.recurring) || !empty($subtotal.recurring)}
                        <tr {if $alter%2==0}class="th-margin"{else}class="dark-row"{/if}>
                            <td class="description-cell">{$lang.total_recurring}</td>
                            <td class="price-cell total-recurring">
                                {if !empty($tax.recurring)}
                                    {foreach from=$tax.recurring item=rec key=k}
                                        <p class="recurring">{$rec|price:$currency} {$lang.$k}</p>
                                    {/foreach}
                                {elseif !empty($subtotal.recurring)}
                                    {foreach from=$subtotal.recurring item=rec key=k}
                                        <p class="recurring">{$rec|price:$currency} {$lang.$k}</p>
                                    {/foreach} 
                                {/if}
                            </td>
                            {counter name=alter}
                        </tr>
                    {/if}
                </table>
                <div class="total-summary">
                    <span>{$lang.total_today}</span>
                    <p>
                        {if $tax}
                            {$tax.total|price:$currency}
                        {elseif $credit}
                            {$credit.total|price:$currency}
                        {else}
                            {$subtotal.total|price:$currency}
                        {/if}
                    </p>
                </div>
            </div>
            <div class="ajax-overlay overlay2"></div>
        </div>
    </div>
</form>
<script type="text/javascript">
    bindSimulateCart();
    if (!firsttimeblock)
        afterAjax();
    firsttimeblock = false;
</script>