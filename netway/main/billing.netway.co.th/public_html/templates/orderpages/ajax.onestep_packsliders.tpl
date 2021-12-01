<div class="cart-page left">
    <input type="hidden" value="{$product.id}" id="product_id" />
    <input type="hidden" value="{$cycle}" id="product_cycle" />
    <form id="cartforms" action="" method="post">

        {productspec products=$products features=features parsed=$products limit=5}
        {counter name=sliderto print=false assign=sliderto start=0 }
        {foreach from=$features item=values}
            {foreach from=$values item=value key=id}
                {if $products[$id].id==$product.id }{counter name=sliderto}
                {/if}
            {/foreach}
        {/foreach}

        <div class="select-plan-box tail">
            <div class="select-plan-bg-fix ">
                <div class="select-plan-bg clearfix">
                    <script type="text/javascript">
                        slideron = {if $sliderto}{$sliderto}{else}0{/if};
                        sliders = [];
                        {foreach from=$custom item=cf name=sliders}{*
                            *}{if $cf.type == 'slider'}{foreach from=$cf.items item=cit name=fconf}
                                sliders.push({literal}{{/literal}
                                    max : parseInt('{$cf.config.maxvalue}') || 100 ,
                                    min : parseInt('{$cf.config.minvalue}') || 0,
                                    step : parseInt('{$cf.config.step}') || 1 ,
                                    value : parseInt('{if $contents[1][$cf.id][$cit.id].qty}{$contents[1][$cf.id][$cit.id].qty}{else}{$cf.config.initialval}{/if}') || 0,
                                    id: '{$cf.id}'{literal}}{/literal});{*
                            *}{/foreach}{/if}
                         {/foreach}
                    </script>
                    {if $product.paytype=='Free'}
                        <input type="hidden" name="cycle" value="Free" />
                    {elseif $product.paytype=='Once'}
                        <input type="hidden" name="cycle" value="Once" />
                    {else}
                        {counter name=cycles print=false assign=cycles start=0}
                        {foreach from=$product item=p_price key=p_cycle}
                            {if $p_cycle == 'd' || $p_cycle == 'w' || $p_cycle == 'm' || $p_cycle == 'q' || $p_cycle == 's' || $p_cycle == 'a' || $p_cycle == 'b' || $p_cycle == 't' || $p_cycle == 'p4' || $p_cycle == 'p5'}
                                {if $p_price > 0}
                                    {counter name=cycles}
                                {/if}
                            {/if}
                        {/foreach}
                        {if $cycles > 1}
                            <div class="additional-option-box">
                                <h3>{$lang.billoptions}</h3>
                                <div class="toggle-slider" rel="cycle">
                                    {price product=$product}
                                        <div class="toggle-option-fix @@selected=active-toggle@" rel="@@cycle">
                                            <span>@@cyclename</span>
                                        </div>
                                    {/price}
                                </div>
                            </div>
                        {/if}
                    {/if}

                    {if ($product.hostname) && !($cart_contents[0].domainoptions.register=='1' ||  $allowown || $subdomain)}
                        <div class="additional-option-box">
                            <h3>{$lang.hostname}*</h3>
                            <div class="domain-bg">
                                <input type="text" value="{$item.domain}" placeholder="Your domain name" name="domain" onchange="if(typeof simulateCart == 'function') simulateCart();">    
                            </div>
                        </div>
                        {if $product.extra.enableos=='1' && !empty($product.extra.os)}
                            <div class="additional-option-box">
                                <h3>{$lang.ostemplate} *</h3>
                                <div class="toggle-slider dropdown">
                                    <select name="ostemplate" class="styled"   onchange="simulateCart('#cart3');">
                                        {foreach from=$product.extra.os item=os}
                                            <option value="{$os.id}"  {if $item.ostemplate==$os.id}selected="selected"{/if}>{$os.name}</option>
                                        {/foreach}
                                    </select>
                                    {foreach from=$cf.items item=cit name=fconf}
                                        {if $item.ostemplate}
                                            {if $item.ostemplate==$os.id}
                                                <a class="dropdown-toggle" data-toggle="dropdown" href="#{$os.id}">  <span>{$os.name}</span>  <b class="caret"></b> </a>
                                                {break}
                                            {/if}
                                        {else}
                                            <a class="dropdown-toggle" data-toggle="dropdown" href="#{$os.id}">  <span>{$os.name}</span>  <b class="caret"></b> </a>
                                            {break}
                                        {/if}
                                    {/foreach}
                                    <ul class="dropdown-menu" rel="ostemplate">
                                        {foreach from=$product.extra.os item=os}
                                            <li><a href="#{$os.id}">{$os.name} </a></li>
                                        {/foreach}
                                    </ul>
                                </div>
                            {/if}
                        {/if}

                        {if $custom}
                            {counter name=sliders print=false assign=slidersc start=0 }
                            {foreach from=$custom item=cf}
                                {if $cf.items}
                                    {if $cf.type == 'slider' && $slidersc < $sliderto}
                                        {foreach from=$cf.items item=cit name=fconf}
                                            <input type="hidden" value="{if $contents[1][$cf.id][$cit.id].qty}{$contents[1][$cf.id][$cit.id].qty}{elseif $cf.config.initialval}{$cf.config.initialval}{else}0{/if}"  
                                                   name="custom[{$cf.id}][{$cit.id}]" id="custom_field_{$cf.id}" 
                                                   class="custom_field_{$cf.id}" rel="{$slidersc}"/>
                                            {if $cf.config.conditionals}
                                                
                                                <script type="text/javascript">
                                                $('.custom_field_{$cf.id}').fieldLogic({literal}{{/literal}type: '{$cf.type}'{literal}}{/literal},[{foreach from=$cf.config.conditionals item=cd name=cond}{literal}{{/literal}
                                                     value: '{$cd.targetval}',
                                                     condition_type: '{$cd.condition}',
                                                     target: '.custom_field_{$cd.target}',
                                                     condition: '{if $cd.conditionval}{$cd.conditionval}{else}{$cd.val}{/if}',
                                                     action: '{$cd.action}'
                                                     {literal}}{/literal}{if !$smarty.foreach.cond.last},{/if}{/foreach}]);
                                                </script>
                                            {/if}
                                        {/foreach}{counter name=sliders}{continue}
                                    {/if}
                                    <div class="additional-option-box custom_box_{$cf.id}">
                                        <h3>{$cf.name} {if $cf.options &1}*{/if}</h3>
                                        {if $cf.type=='select'}
                                            <div class="toggle-slider dropdown">
                                                {foreach from=$cf.items item=cit name=fconf}
                                                    {if $cart_contents[1][$cf.id]}
                                                        {if $cart_contents[1][$cf.id][$cit.id]}
                                                            <a class="dropdown-toggle" data-toggle="dropdown" href="#{$cit.id}">  <span>{$cit.name}{if $cit.price!=0} (  + {$cit.price|price:$currency}){/if}</span>  <b class="caret"></b> </a>
                                                            {break}
                                                        {/if}
                                                    {else}
                                                        <a class="dropdown-toggle" data-toggle="dropdown" href="#{$cit.id}">  <span>{$cit.name}{if $cit.price!=0} (  + {$cit.price|price:$currency}){/if}</span>  <b class="caret"></b> </a>
                                                        {break}
                                                    {/if}
                                                {/foreach}

                                                <ul class="dropdown-menu" rel="custom[{$cf.id}]">
                                                    {foreach from=$cf.items item=cit name=fconf}
                                                        <li><a href="#{$cit.id}">{$cit.name}{if $cit.price!=0} (  + {$cit.price|price:$currency}){/if} </a></li>
                                                    {/foreach}
                                                </ul>
                                                <select name="custom[{$cf.id}]" style="display:none;" class="custom_field_{$cf.id}" onchange="simulateCart()">
                                                    {foreach from=$cf.items item=cit}
                                                    <option value="{$cit.id}" {if $contents[1][$cf.id][$cit.id]}selected="selected"{/if}>{$cit.name} {if $cit.price!=0}(
                                                        {if $cit.fee!=0} {$cit.fee|price:$currency} {$lang[$cit.recurring]}{/if}
                                                        {if $cit.setup!=0} {$cit.setup|price:$currency} {$lang.setupfee}{/if}
                                                    ){/if}</option>
                                                    {/foreach}
                                                </select>
                                                {if $cf.config.conditionals}
                                                    <script type="text/javascript">
                                                    $('.custom_field_{$cf.id}').fieldLogic({literal}{{/literal}type: '{$cf.type}'{literal}}{/literal},[{foreach from=$cf.config.conditionals item=cd name=cond}{literal}{{/literal}
                                                         value: '{$cd.targetval}',
                                                         condition_type: '{$cd.condition}',
                                                         target: '.custom_field_{$cd.target}',
                                                         condition: '{if $cd.conditionval}{$cd.conditionval}{else}{$cd.val}{/if}',
                                                         action: '{$cd.action}'
                                                         {literal}}{/literal}{if !$smarty.foreach.cond.last},{/if}{/foreach}]);
                                                    </script>
                                                {/if}
                                            </div>
                                        {elseif $cf.type=='radio'}
                                            <div class="toggle-slider" rel="custom[{$cf.id}]">
                                                {foreach from=$cf.items item=cit name=fconf}
                                                    <div class="toggle-option-fix{if $cart_contents[1][$cf.id][$cit.id]} active-toggle{/if}" {if $cit.price!=0} title="{$cit.price|price:$currency}"{/if} rel="{$cit.id}">
                                                        <span>{$cit.name}</span>
                                                    </div>
                                                {/foreach}
                                            </div>
                                        {elseif $cf.type=='slider'}
                                            {foreach from=$cf.items item=cit name=fconf}
                                                <div class="slider-box left" rel="custom[{$cf.id}][{$cit.id}]">
                                                    <div class="slider-bg"></div>
                                                </div>
                                                <div class="qty-td">0</div>
                                            {/foreach}
                                        {else}
                                            {include file=$cf.configtemplates.cart}
                                        {/if}
                                    </div>
                                {/if}
                            {/foreach}
                        {/if}
                        {if $opconfig.description}
                            <div class="additional-option-box">
                                <p>{$opconfig.description}</p>
                            </div>
                        {/if}
                        <div class="ajax-overlay"></div>
                    </div>
                </div>
                <div class="back-tail"></div>
            </div>

            <!-- Addons -->
            {if $addons || $subproducts || ($cart_contents[0].domainoptions.register=='1' ||  $allowown || $subdomain) }
                <div class="addons-box">
                    <h1>{$lang.addons_single}</h1>
                    <h2>{$lang.extrafeatures}</h2>
                    <div class="underline-title">
                        <div class="underline-bold"></div>
                    </div>

                    <div class="addons-bg">
                        {foreach from=$addons item=a key=k}
                            <div class="addon-row">
                                <div class="left-section">
                                    <h3>{$a.name}</h3>

                                    <div class="addon-select-bg dropdown">
                                        {if $contents[3][$k]}{assign var=addon value=$contents[3][$k]}

                                            <a class="dropdown-toggle" data-toggle="dropdown" href="#{$addon.recurring}"> 
                                                <span>
                                                    {price product=$addon}
                                                    {if $sub.recurring=='free'}{$lang.free}
                                                    {else}
                                                        @@line
                                                    {/if}
                                                    {/price}
                                                </span> 
                                                <b class="caret"></b>
                                            </a>
                                        {else}
                                            <a class="dropdown-toggle" data-toggle="dropdown" href="#"> <span>{$lang.none}</span> <b class="caret"></b></a>
                                        {/if}
                                        <ul class="dropdown-menu" rel="addon_cycles[{$k}]" item-toggle="addon[{$k}]">
                                            <li {if !$contents[3][$k]}style="display:none"{/if}><a href="#" class="off" rel="None">{$lang.removethisaddon}</a></li>
                                            {price product=$a}
                                            {if $a.paytype=='Free'}
                                                <li><a href="#free">{$lang.free}</a></li>
                                            {else}
                                                <li><a href="#@@cycle">@@line</a></li>
                                            {/if}
                                            {/price}
                                        </ul>
                                    </div>
                                </div>
                                <div class="addon-description">
                                    {$a.description}
                                </div>
                            </div>
                        {/foreach}

                        {foreach from=$subproducts item=a key=k}
                            <div class="addon-row">
                                <div class="left-section">
                                    <h3>{$a.name}</h3>
                                    <div class="addon-select-bg dropdown">
                                        {if $contents[4][$k]}{assign var=sub value=$contents[4][$k]}
                                            <a class="dropdown-toggle" data-toggle="dropdown" href="#{$sub.recurring}"> 
                                                <span>
                                                    {price product=$sub}
                                                    {if $sub.recurring=='free'}{$lang.free}
                                                    {else}
                                                        @@line
                                                    {/if}
                                                    {/price}
                                                </span> 
                                                <b class="caret"></b>
                                            </a>
                                        {else}
                                            <a class="dropdown-toggle" data-toggle="dropdown" href="#"> <span>{$lang.none}</span> <b class="caret"></b></a>
                                        {/if}
                                        <ul class="dropdown-menu" rel="subproducts_cycles[{$k}]" item-toggle="subproducts[{$k}]">
                                            <li {if !$contents[4][$k]}style="display:none"{/if}><a href="#" class="off" rel="None">{$lang.removethisproduct}</a></li>
                                            {price product=$a}
                                                {if $a.paytype=='Free'}
                                                    <li><a href="#free">{$lang.free}</a></li>
                                                {else}
                                                    <li><a href="#@@cycle">@@line</a></li>
                                                {/if}
                                            {/price}
                                        </ul>
                                    </div>

                                </div>

                                <div class="addon-description">
                                    {$a.description}
                                </div>
                            </div>
                        {/foreach}
                        {* PROTO DOMAINS
                        <div class="addon-row">
                        <div class="left-section">
                        <h3>Domain Name</h3>
                        <div class="domain-bg">
                        <input type="text" placeholder="Your domain name" name="sld" id="sld">
                        <div class="domain-ext-bg dropdown">  
                        <a class="dropdown-toggle" data-toggle="dropdown" href="#">  <span>.com</span>  <b class="caret"></b> </a>          
                        <ul class="dropdown-menu" rel="tld[]" change-event="false">
                        <li><a href="#.com">.com</a></li>
                        <li><a href="#.eu">.eu</a></li>
                        <li><a href="#.pl">.pl</a></li>
                        </ul>
                        </div>
                        </div>
                        <div class="check-domain-fix">
                        <a href="#" class="check-domain" onclick="domainCheck(); return false;">Check domain</a>
                        </div>
                        </div>
            
                        <div class="addon-description">
                        <p>Please enter the domain you would like to use below, then click "Check domain" button. To use our default provided domain (for testing purposes only), enter xxx.vm-host.net where xxx represents a unique subdomain.</p>
                        </div>
                        
                        </div>
                        <div id="updater2" class="addon-row"></div>
                        *}

                        {if ($cart_contents[0].domainoptions.register)=='1' && ($allowregister || $allowtransfer || $allowown || $subdomain)}
                            <div class="addon-row domains-row">

                                {include file='onestep_packsliders/domains.tpl'}
                            </div>
                        {/if}
                    </div>
                </div>
            {/if}
    </form>
</div>


<!-- Order Summary -->
<div class="order-summary">
    <h1>{$lang.ordersummary}</h1>
    <h2>{$lang.yourcarttotal}</h2>
    <div class="underline-title">
        <div class="underline-bold"></div>
    </div>

    <div class="summary-box">
        <div class="summary-header-fix">
            <div class="summary-header">
                <span class="desc-col">{$lang.Description}</span>
                <span class="price-col">{$lang.price}</span>
            </div>
        </div>
        <div class="summary-bg">
            <div class="ajax-overlay"></div>
            <table class="summary-table">
                {counter name=alter print=false start=1 assign=alter}
                {* PRODUCT *}
                {if $product}
                    <tr {if $alter%2==0}class="dark-col"{/if}>
                        <td class="order-description"><span class="lighter-txt"> {$contents[0].category_name}</span> {$contents[0].name} {if $contents[0].domain}({$contents[0].domain}){/if}</td>
                        <td class="price">
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
                    {counter name=alter}
                {/if}
                {* FORMS *}
                {if $cart_contents[1]}
                    {foreach from=$cart_contents[1] item=cstom2}
                        {foreach from=$cstom2 item=cstom}
                            <tr id="order-{$alter}" {if $alter%2==0}class="dark-col"{/if}>
                                <td class="order-description">
                                    {if $cstom.type == 'slider' || $cstom.type == 'qty'}
                                    {$cstom.fullname} {if $cstom.qty>=1} <span class="green-val"> {$cstom.qty}</span>{/if}
                                {elseif $cstom.type == 'select' || $cstom.type == 'radio'}
                                    <span class="lighter-txt">{$cstom.name}</span>
                                    <span class="sub-item">{$cstom.sname}</span>
                                {else}
                                    {$cstom.name}
                                {/if}
                            </td>
                            <td class="price">
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
                    <tr id="order-{$alter}" {if $alter%2==0}class="dark-col"{/if}>
                        <td class="order-description"><span class="lighter-txt">{$lang.addon}</span> {$addon.name}</td>
                        <td class="price">
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
                    <tr id="order-{$alter}" {if $alter%2==0}class="dark-col"{/if}>
                        <td class="order-description"><span class="lighter-txt">{$subprod.category_name}</span> {$subprod.name}</td>
                        <td class="price">
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
                    <tr id="order-{$alter}" {if $alter%2==0}class="dark-col"{/if}>
                        <td class="order-description">
                            <span class="lighter-txt">
                                {if $domenka.action=='register'}{$lang.domainregister}
                                {elseif $domenka.action=='transfer'}{$lang.domaintransfer}
                                {/if} 
                            </span>
                            {$domenka.name}
                        </td>
                        <td class="price">
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
        </table>
        <div class="summary-shadow"></div>
        <div class="summary-total">
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

        <div class="summary-underline"></div>
        <div class="summary-total">
            {if !empty($tax.recurring) || !empty($subtotal.recurring)}
                <span class="recurring">{$lang.total_recurring}</span>
                {if !empty($tax.recurring)}
                    {foreach from=$tax.recurring item=rec key=k}
                        <p class="recurring">{$rec|price:$currency} {$lang.$k}</p>
                    {/foreach}
                {elseif !empty($subtotal.recurring)}
                    {foreach from=$subtotal.recurring item=rec key=k}
                        <p class="recurring">{$rec|price:$currency} {$lang.$k}</p>
                    {/foreach} 
                {/if}
            {/if}
            {if !$subtotal.coupon}
                <a href="#" onclick="$(this).hide().next().show(); return false;"><small>>></small> {$lang.promotionalcode}</a>
                <div style="display:none" class="input-append">
                    <input id="couponcde" type="text" placeholder="{$lang.usecoupon}" style="width: 75%; display: inline; margin: 0px; height: 20px;">
                    <a href="#" class="btn" onclick="applyCoupon(); return false" style="display: inline; margin: 0px 0 0 -4px;">{$lang.Go}</a>
                </div>
            {else}
                <a href="#"onclick="removeCoupon(); return false" title="{$lang.remove_coupon}">{$subtotal.coupon}</a>
            {/if}

        </div>
    </div>
</div>
</div>
<script type="text/javascript">            
    packageSliders();
    dropdownForms();
    toggleForms();
    sliderForms();
    domainToggles();
</script>