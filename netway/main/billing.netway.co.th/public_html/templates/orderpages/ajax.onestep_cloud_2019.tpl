{assign var="scount" value=1}

<form action="?cmd=cart" method="post" class="w-100" id="cartforms" name="cartforms">
    <input type="hidden" name="subproducts[0]" value="0" />
    <input type="hidden" name="addon[0]" value="0" />
    <input type="hidden" name="parent_account" value="{$parent_account.id}" />

    {if $parent_account}
        <div class="row">
            <div class="col-12 mb-5 mt-0">
                <div class="d-flex flex-row align-items-center mb-3">
                    <h3>{$lang.relatedservice}</h3>
                </div>
                <div class="alert alert-info">
                    <span class="alert-heading text-secondary">{$lang.iamorderingforaccount}: </span>
                    <a target="_blank" href="{$ca_url}clientarea&action=services&service={$parent_account.id}">#{$parent_account.id} {$parent_account.category_name} - {$parent_account.product_name} {if $parent_account.label} <small>({$parent_account.label})</small> {/if}</a>
                </div>
            </div>
        </div>
    {/if}

    {if $custom}
        <div class="row bindcart_js">
            {foreach from=$custom item=cf}
                {if $cf.items}
                    <div class="form-group col-12 mb-5 mt-0 option-val cart-form cart-item cf-{$cf.type} {if $cf.key|strstr:'cf_'}{$cf.key} cf_option{/if}">
                        <div class="d-flex flex-row align-items-center mb-3">
                            <span class="cart-products-scount cart-products-scount_js pb-2">{assign var="scount" value=$scount+1}{$scount}</span> <h3>{$cf.name} {if $cf.options &1}*{/if}</h3>
                        </div>
                        {if $cf.description!=''}
                            <div class="my-3 text-secondary text-small">{$cf.description}</div>
                        {/if}
                        {include file=$cf.configtemplates.cart}
                    </div>
                {/if}
            {/foreach}
        </div>
    {/if}

    {if $addons}
        <div class="row bindcart_js">
            <div class="col-12 mb-5 mt-0">
                <div class="d-flex flex-row align-items-center mb-3">
                    <span class="cart-products-scount cart-products-scount_js pb-2">{assign var="scount" value=$scount+1}{$scount}</span> <h3>{$lang.addons_single}</h3>
                </div>
                {foreach from=$addons item=a key=k name=ul}
                    <div class="card">
                        <div class="card-body item">
                            <div class="form-check">
                                <input class="cart_items_check" id="addon__{$k}" name="addon[{$k}]" onchange="if (typeof(simulateCart) == 'function') simulateCart();"  type="checkbox" value="1" {if $contents[3].$k}checked="checked"{/if}/>
                                <label class="form-check-label" for="addon__{$k}">{$a.name}</label>
                            </div>
                            <div class="mt-3 items" {if $contents[3].$k} {else} style="display:none" {/if}>
                                {price product=$a}
                                {if $a.paytype=='Free'}
                                    <span class="product-cycle cycle-free">{$lang.free}</span>
                                    <input type="hidden" name="addon_cycles[{$k}]" value="free"/>
                                {elseif $a.paytype=='Once'}
                                    <span class="product-price cycle-once">@@price</span>
                                    <span class="product-cycle cycle-once">{$lang.once}</span>
                                    {if $a.m_setup!=0}<span class="product-setup cycle-once">@@setupline</span>
                                    {/if}
                                    <input type="hidden" name="addon_cycles[{$k}]" value="once"/>
                                {else}
                                    <select class="form-control" name="addon_cycles[{$k}]" >
                                        <option value="@@cycle" @@selected>@@line</option>
                                    </select>
                                {/if}
                                {/price}
                                <span class="text-small mt-3">{$a.description}</span>
                            </div>
                        </div>
                    </div>
                {/foreach}
            </div>
        </div>
    {/if}

    {if $subproducts}
        <div class="row bindcart_js">
            <div class="col-12 mb-5 mt-0">
                <div class="d-flex flex-row align-items-center mb-3">
                    <span class="cart-products-scount cart-products-scount_js pb-2">{assign var="scount" value=$scount+1}{$scount}</span> <h3>{$lang.subproduct}</h3>
                </div>
                {foreach from=$subproducts item=a key=k name=ul}
                    <div class="card">
                        <div class="card-body item">
                            <div class="form-check">
                                <input class="cart_items_check" id="subproducts__{$k}" name="subproducts[{$k}]" onchange="if (typeof(simulateCart) == 'function') simulateCart('#cart0');"  type="checkbox" value="1" {if $contents[4].$k}checked="checked"{/if}/>
                                <label class="form-check-label" for="subproducts__{$k}">{$a.category_name} - {$a.name}</label>
                            </div>
                            <div class="mt-3 items" style="display:none" >
                                {price product=$a}
                                {if $a.paytype=='Free'}
                                    <span class="product-cycle cycle-free">{$lang.free}</span>
                                    <input type="hidden" name="subproducts_cycles[{$k}]" value="free"/>
                                {elseif $a.paytype=='Once'}
                                    <span class="product-price cycle-once">@@price</span>
                                    <span class="product-cycle cycle-once">{$lang.once}</span>
                                    {if $a.m_setup!=0}<span class="product-setup cycle-once">@@setupline</span>
                                    {/if}
                                    <input type="hidden" name="subproducts_cycles[{$k}]" value="once"/>
                                {else}
                                    <select class="form-control" name="subproducts_cycles[{$k}]" >
                                        <option value="@@cycle" @@selected>@@line</option>
                                    </select>
                                {/if}
                                {/price}
                                <span class="text-small mt-3">{$a.description}</span>
                            </div>
                        </div>
                    </div>
                {/foreach}
            </div>
        </div>
    {/if}

    {if ($product.hostname) && !($cart_contents[0].domainoptions.register=='1' ||  $allowown || $subdomain)}
        <div class="row bindcart_js">
            <div class="col-12 mb-5 mt-0">
                <div class="d-flex flex-row align-items-center mb-3">
                    <span class="cart-products-scount cart-products-scount_js pb-2">{assign var="scount" value=$scount+1}{$scount}</span> <h3>{$lang.hostname}</h3>
                </div>

                <div class="form-group row">
                    <div class="col-12 col-lg-12">
                        <input type="text" name="domain" value="{$cart_contents[0].domain}" class="form-control"/>
                    </div>
                </div>
            </div>
        </div>
    {/if}

    {if ($cart_contents[0].domainoptions.register)=='1' && ($allowregister || $allowtransfer || $allowown || $subdomain)}
        <div class="row">
            <div class="col-12 mb-5 mt-0">
                <div class="d-flex flex-row align-items-center mb-3">
                    <span class="cart-products-scount cart-products-scount_js pb-2">{assign var="scount" value=$scount+1}{$scount}</span> <h3>{$lang.domains}</h3>
                </div>
                <div class="nav-tabs-wrapper">
                    <ul class="nav nav-tabs nav-slider horizontal d-flex flex-nowrap align-items-center" role="tablist" id="domainTab">
                        {if $allowregister}
                            <li class="nav-item {if !$cart_contents[2] || !$cart_contents[2][0] || $cart_contents[2][0].action == 'register'} active {/if}"><a class="nav-link" data-toggle="tab" href="#illregister" onclick="setAction(this);">{$lang.register}</a></li>
                        {/if}
                        {if $allowtransfer}
                            <li class="nav-item {if $cart_contents[2][0] && $cart_contents[2][0].action == 'transfer'} active {/if}"><a class="nav-link" data-toggle="tab" href="#transfer" onclick="setAction(this);">{$lang.transfer}</a></li>
                        {/if}
                        {if $allowown}
                            <li class="nav-item {if (!$allowregister && !$allowtransfer) || $cart_contents[2][0].action == 'own'} active {/if}"><a  class="nav-link" data-toggle="tab" href="#own" onclick="setAction(this);">{$lang.alreadyhave}</a></li>
                        {/if}
                        {if $subdomain}
                            <li class="nav-item"><a class="nav-link" data-toggle="tab" href="#subdomain" onclick="setAction(this);">{$lang.subdomain}</a></li>
                        {/if}
                    </ul>
                </div>
                <div id="domoptions11" class="domain-tab tab-content">
                    <div class="tab-content">
                        {if $contents[2]}
                            <div id="domoptions22">
                                {foreach from=$contents[2] item=domenka key=kk}
                                    {if $domenka.action=='register'}

                                        <input type="hidden" name="domain" value="illregister" />
                                    {elseif $domenka.action=='transfer'}

                                        <input type="hidden" name="domain" value="illtransfer"  />
                                    {/if}

                                    <input class="domoptions22_saved" type="hidden" name="sld[{$domenka.name}]" value="{$domenka.sld}">
                                    <input class="domoptions22_saved" type="hidden" name="tld[{$domenka.name}]" value="{$domenka.tld}">
                                    <input class="domoptions22_saved" type="hidden" name="period[{$domenka.name}]" value="{$domenka.period}">
                                    {if $domenka.action!='own' && $domenka.action!='hostname'}
                                        <strong>{if $domenka.action=='register'}{$lang.domainregister}{elseif $domenka.action=='transfer'}{$lang.domaintransfer}{/if}</strong> - {$domenka.name} - {$domenka.period} {$lang.years}
                                        {$domenka.price|price:$currency}<br />
                                    {else}
                                        {$domenka.name}<br />
                                    {/if}
                                    {if $domenka.custom}
                                        <form class="cartD" action="" method="post">
                                            <table class="table" width="100%" cellspacing="" cellpadding="6" border="0">
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
                                <br>
                                <a href="#" class="btn btn-default" onclick="$('#domoptions22').hide().find('.domoptions22_saved').remove(); $($('#domainTab li.active a').click()); return false;">{$lang.change}</a>
                            </div>
                        {/if}
                        <input type="hidden" value="{$cart_contents[0].id}" id="product_id" name="product_id" />
                        {if $allowregister}
                            <div id="illregister" {if $contents[2]}style="display: none"{/if} class="tab-pane active t1 slidme">
                                <input type="radio" name="domain" value="illregister" style="display: none;" {if !$contents[2]}checked="checked"{/if}/>
                                {if $opconfig.simple_field_for_registering}
                                    <div class="col-12 col-md-9">
                                        <div class="d-flex flex-column flex-md-row ">
                                            <div class="input-group">
                                                <div class="input-group-prepend">
                                                    <div class="input-group-text">www.</div>
                                                </div>
                                                <input type="text" value="" size="40" name="sld_register" id="sld_register" class="form-control" placeholder="example"/>
                                            </div>
                                            <select name="tld" id="tld[]" class="tld_register form-control my-2 my-md-0 mx-0 mx-md-3">
                                                {foreach from=$tld_reg item=tldname}
                                                    <option>{$tldname}</option>
                                                {/foreach}
                                            </select>
                                            <input type="submit" value="{$lang.check}" class="btn btn-primary" onclick="domainCheck(); return false;"/>
                                        </div>
                                    </div>
                                {else}
                                    <div class="domain-box d-flex flex-column flex-sm-row my-3">
                                        <textarea name="sld_register" id="sld_register" class="form-control domain-sld"></textarea>
                                        <div class="domain-tld-bulk domain-tld bordered-section pt-1 pb-3 px-0 ml-0 ml-sm-3 my-3 my-sm-0">
                                            <input type="text" class="form-control form-control-sm domain-tld-search" placeholder="{$lang.search}">
                                            <div class="domain-tld-checkbox-all w-100 py-1 px-3 my-2">{$lang.checkunall}</div>
                                            {foreach from=$tld_reg item=tldname name=ttld}
                                                <div class="domain-tld-checkbox-item w-100 py-1 px-3 {if $smarty.foreach.ttld.first}checked{/if}" data-tld="{$tldname}">
                                                    <i class="material-icons size-sm text-muted domain-tld-checkbox-icon">done</i>
                                                    <input type="checkbox" name="tld[]" value="{$tldname}" {if $smarty.foreach.ttld.first}checked="checked"{/if} class="tld_register" style="display: none;"/>
                                                    <span class="ml-2">{$tldname}</span>
                                                </div>
                                            {/foreach}
                                        </div>
                                    </div>
                                    <input type="submit" value="{$lang.check}" class="btn btn-primary" onclick="domainCheck(); return false;"/>
                                {/if}
                            </div>
                        {/if}

                        <!-- Transfer -->
                        {if $allowtransfer}
                            <div class="tab-pane mb-4" {if $contents[2]}style="display: none"{/if} id="transfer">
                                <input class="form-check-input" type="radio" style="display: none;" value="illtransfer" name="domain" {if !$allowregister}checked="checked"{/if}/>
                                <div id="illtransfer" class="row">
                                    <div class="col-12 col-md-9">
                                        <div class="d-flex flex-column flex-md-row ">
                                            <div class="input-group">
                                                <div class="input-group-prepend">
                                                    <div class="input-group-text">www.</div>
                                                </div>
                                                <input type="text" value="" size="40" name="sld_transfer" id="sld_transfer" class="form-control" placeholder="example"/>
                                            </div>
                                            <select name="tld_transfer" id="tld_transfer" class="form-control my-2 my-md-0 mx-0 mx-md-3">
                                                {foreach from=$tld_tran item=tldname}
                                                    <option>{$tldname}</option>
                                                {/foreach}
                                            </select>
                                            <input type="submit" value="{$lang.check}" class="btn btn-primary" onclick="domainCheck(); return false;"/>
                                        </div>
                                    </div>
                                </div>
                                <div id="transfer-updater" class="updater2 my-2">{include file="ajax.checkdomain.tpl"} </div>
                            </div>
                        {/if}

                        <!-- Own -->
                        {if $allowown}
                            <div class="tab-pane mb-4 {if !$allowregister && !$allowtransfer} active {/if}" {if $contents[2]}style="display: none"{/if}  id="own">
                            <input class="form-check-input" type="radio" style="display: none;" value="illupdate" name="domain" {if !$allowregister && !$allowtransfer}checked="checked"{/if}/>
                            <div id="illupdate" class="row">
                                <div class="col-12">
                                    <div class="d-flex flex-column items">
                                        {if $allowownoutside}
                                            <div class="my-3 w-100 card item">
                                                <div class="card-body d-flex flex-column">
                                                    <div class="form-check cursor-pointer d-flex flex-row justify-content-start align-items-center">
                                                        <input id="iwantupdate_outside" type="radio" class="owndomain_card_toggler" checked="checked" onclick="toggleCard($(this));" />
                                                        <label for="iwantupdate_outside" class="form-check-label">{$lang.iwantupdate_outside|sprintf:$business_name}</label>
                                                    </div>
                                                    <div class="item-body form-group">
                                                        <hr>
                                                        <div class="input-group">
                                                            <div class="input-group-prepend">
                                                                <div class="input-group-text rounded-0">www.</div>
                                                            </div>
                                                            <input type="text" value="" size="40" name="sld_update" id="sld_update" class="form-control" placeholder="example"/>
                                                            <div class="input-group-append">
                                                                <input type="text" value="" size="7" name="tld_update" id="tld_update" class="form-control domain-tld rounded-0 rounded-top-right rounded-bottom-right " placeholder="com"/>
                                                            </div>
                                                        </div>
                                                    </div>
                                                </div>
                                            </div>
                                        {else}
                                            <input type="hidden" name="sld_update" id="sld_update"/>
                                            <input type="hidden" name="tld_update" id="tld_update"/>
                                        {/if}
                                        {foreach from=$shoppingcart item=order}
                                            {foreach from=$order.domains item=domenka}
                                                {if $domenka.action === 'register' || $domenka.action === 'transfer'}
                                                    {assign var=showcartdomainselect value=true}
                                                    {break}
                                                {/if}
                                            {/foreach}
                                        {/foreach}
                                        {if $showcartdomainselect}
                                            <div class="mb-3 w-100 card item">
                                                <div class="card-body">
                                                    <div class="form-check cursor-pointer d-flex flex-row justify-content-start align-items-center">
                                                        <input id="iwantupdate_cart" type="radio" class="owndomain_card_toggler" onclick="toggleCard($(this));" />
                                                        <label for="iwantupdate_cart" class="form-check-label">{$lang.iwantupdate_cart}</label>
                                                    </div>
                                                    <div class="item-body" style="display: none">
                                                        <select class="form-control mt-3 iwantupdate_cart_select">
                                                            {foreach from=$shoppingcart item=order key=k}
                                                                {foreach from=$order.domains item=domenka key=kk}
                                                                    {if $domenka.action === 'register' || $domenka.action === 'transfer'}
                                                                        {assign var=showdomenka value=true}

                                                                        {foreach from=$shoppingcart item=order2}
                                                                            {if $order2.product.domain === $domenka.name}
                                                                                {assign var=showdomenka value=false}
                                                                                {break}  {* domain is already used by other hosting *}
                                                                            {/if}
                                                                        {/foreach}

                                                                        {if $showdomenka}
                                                                            <option data-sld="{$domenka.sld}" data-tld="{$domenka.tld}">{$domenka.name}</option>
                                                                        {/if}
                                                                    {/if}
                                                                {/foreach}
                                                            {/foreach}
                                                        </select>
                                                    </div>
                                                </div>
                                            </div>
                                        {/if}
                                        <div class="mb-3 w-100 card item">
                                            <div class="card-body">
                                                <div class="form-check cursor-pointer d-flex flex-row justify-content-start align-items-center">
                                                    <input id="iwantupdate_myaccount" type="radio" class="owndomain_card_toggler" onclick="toggleCard($(this));" />
                                                    <label for="iwantupdate_myaccount" class="form-check-label">{$lang.iwantupdate_myaccount}</label>
                                                </div>
                                                <div class="item-body" style="display: none">
                                                    {if $logged=="1"}
                                                        {clientservices}
                                                        {if $client_domains}
                                                            <select class="form-control mt-3 iwantupdate_myaccount_select">
                                                                {foreach from=$client_domains item=domenka key=kk}
                                                                    {if $domenka.status === 'Active' || $domenka.status === 'Pending Registration' || $domenka.status === 'Pending Transfer'}
                                                                        <option data-domain="{$domenka.name}">{$domenka.name}</option>
                                                                    {/if}
                                                                {/foreach}
                                                            </select>
                                                        {else}
                                                            <div class="mt-3 text-left">
                                                                <span>{$lang.youdonthaveactivedomain}</span>
                                                            </div>
                                                        {/if}
                                                    {else}
                                                        <div class="mt-3 text-left">
                                                            <span>{$lang.pleaseloginyouraccount}</span>.
                                                            <a href="?cmd=login">{$lang.login}</a>
                                                        </div>
                                                    {/if}
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                    <button class="btn btn-primary d-inline-block w-auto my-2 my-md-0" onclick="domainCheck(); return false;">{$lang.check}</button>
                                </div>
                            </div>
                            </div>
                        {/if}

                        <!-- Subdomain -->
                        {if $subdomain}
                            <div class="tab-pane mb-4" {if $contents[2]}style="display: none"{/if}  id="subdomain">
                                <input class="form-check-input" type="radio" style="display: none;" value="illsub" name="domain"  {if !($allowregister || $allowtransfer || $allowown)}checked="checked"{/if}/>
                                <div id="illsub"  class="row">
                                    <div class="col-12 col-md-9">
                                        <div class="d-flex flex-column flex-md-row ">
                                            <div class="input-group">
                                                <div class="input-group-prepend">
                                                    <div class="input-group-text">www.</div>
                                                </div>
                                                <input type="text" value="" size="40" name="sld_subdomain" id="sld_subdomain" class="form-control"/>
                                                <div class="input-group-append">
                                                    <div class="input-group-text">{$subdomain}</div>
                                                </div>
                                            </div>
                                            <input type="submit" value="{$lang.check}" class="btn btn-primary my-2 my-md-0 mx-0 mx-md-3" onclick="domainCheck(); return false;"/>
                                            </div>
                                        </div>
                                </div>
                            </div>
                        {/if}
                        <div id="updater2" class="my-3">{include file="ajax.checkdomain.tpl"} </div>
                    </div>
                </div>
            </div>
        </div>
    {/if}
    {if $contents[0] || $contents[1] || $contents[2] || $contents[3]}
    <div class="row">
        <div class="col-12 mb-5 mt-0 input-coupon_js">
            <div class="d-flex flex-row align-items-center mb-3">
                <span class="cart-products-scount cart-products-scount_js pb-2">{assign var="scount" value=$scount+1}{$scount}</span> <h3>{$lang.usecoupon}</h3>
            </div>
            {if $subtotal.coupon}
                <div class="card">
                    <div class="card-body item">
                        <div class="form-check">
                            {$lang.promotionalcode}: <strong>{$subtotal.coupon}
                        </div>
                        <div class="mt-3 items">
                            <span>- {$subtotal.discount|price:$currency}</span>
                            <a href="#" class="text-danger" onclick="return removeCoupon();">{$lang.removecoupon}</a>
                        </div>
                    </div>
                </div>
            {else}
                <section class="input-self-box fluid col-lg-6 col-12 orderpage-couponbox">
                    <div class="input-group d-flex align-items-center">
                        <input type="text" name="promocode" class="form-control form-control-noborders"  placeholder="{$lang.code}" aria-label="{$lang.code}">
                        <span class="input-group-btn">
                            <button type="submit" class="btn btn-primary" onclick="return applyCoupon();">
                                <span class="p-3 text-small">{$lang.submit}</span>
                            </button>
                        </span>
                    </div>
                </section>
            {/if}
        </div>
    </div>
    {/if}
</form>

<div id="orderpage-lastblock"></div>  {* Please do not delete this. It's needed for the #orderpage-summary section *}
{if $contents[0] || $contents[1] || $contents[2] || $contents[3]}
<section class="orderpage-summary body-bg border-top" id="orderpage-summary">
	<div class="orderpage-summary-details" style="display: none;">
        <table class="checker table table-borderless w-100">
            <thead class="thead-transparent">
                <tr>
                    <th class="static" width="55%" align="left">{$lang.Description}</th>
                    <th class="static" width="25%">{$lang.price}</th>
                </tr>
            </thead>
            <tbody>
            {if $product}
                <tr>
                    <td>
                        {$contents[0].name}
                        {if $contents[0].domain}({$contents[0].domain})
                        {/if}
                    </td>
                    <td>
                        {if $contents[0].prorata_amount}
                            {$contents[0].prorata_amount|price:$currency}
                            ({$lang.prorata} {$contents[0].prorata_date|dateformat:$date_format})
                        {elseif $contents[0].price>0}
                            {$contents[0].price|price:$currency}
                            {if $opconfig.show_cycles_in_summary}{assign var="scycl" value=$contents[0].recurring}{$lang.$scycl}{/if}
                        {/if}

                        {if $contents[0].setup!=0}
                            {if $contents[0].price>0} + {/if}
                            {$contents[0].setup|price:$currency} {$lang.setupfee}
                        {/if}
                    </td>
                </tr>
            {/if}

            {if $cart_contents[1]}
                {foreach from=$cart_contents[1] item=cstom2}
                    {foreach from=$cstom2 item=cstom}
                        {if $cstom.total>0}
                            <tr>
                                <td>
                                    {$cstom.fullname} {if $cstom.qty>=1}x {$cstom.qty}{/if}
                                </td>
                                <td>
                                    {if $cstom.prorata_amount}
                                        {$cstom.prorata_amount|price:$currency} ({$lang.prorata}, {$cstom.price|price:$currency} {$lang[$cstom.recurring]})
                                    {elseif $cstom.pricee>0}
                                        {$cstom.price|price:$currency}
                                        {if $opconfig.show_cycles_in_summary}{$lang[$cstom.recurring]}{/if}
                                    {/if}
                                    {if $cstom.setup!=0}
                                        {if $cstom.price>0} + {/if}
                                        {$cstom.setup|price:$currency} {$lang.setupfee}
                                    {/if}
                                </td>
                            </tr>
                        {/if}
                    {/foreach}
                {/foreach}
            {/if}

            {if $contents[3]}
                {foreach from=$contents[3] item=addon}
                    <tr>
                        <td>
                            {$lang.addon} <strong>{$addon.name}</strong>
                        </td>
                        <td>
                            {if $addon.prorata_amount}<strong>{$addon.prorata_amount|price:$currency}</strong> ({$lang.prorata} {$addon.prorata_date|dateformat:$date_format})
                            {elseif $addon.price>0}<strong>{$addon.price|price:$currency}</strong>
                                {if $opconfig.show_cycles_in_summary}{$lang[$addon.recurring]}{/if}
                            {/if}
                            {if $addon.setup!=0}
                                {if $addon.price > 0} + {/if}{$addon.setup|price:$currency} {$lang.setupfee}
                            {/if}
                        </td>
                    </tr>
                {/foreach}
            {/if}

            {if $contents[2] && $contents[2][0].action!='own'}
                {foreach from=$contents[2] item=domenka key=kk}
                    <tr>
                        <td>
                            {if $domenka.action=='register'}{$lang.domainregister}
                            {elseif $domenka.action=='transfer'}{$lang.domaintransfer}
                            {/if} - {$domenka.name} - {$domenka.period} {$lang.years}
                        </td>
                        <td>
                            {$domenka.price|price:$currency}
                        </td>
                    </tr>
                {/foreach}
            {/if}

            {if $contents[4]}
                {foreach from=$contents[4] item=subprod}
                    <tr>
                        <td>
                            {$subprod.category_name} - <strong>{$subprod.name}</strong>
                        </td>
                        <td>
                            {if $subprod.prorata_amount}
                                <strong> {$subprod.prorata_amount|price:$currency}</strong>
                                ({$lang.prorata} {$subprod.prorata_date|dateformat:$date_format})
                            {elseif $subprod.price>0}<strong>{$subprod.price|price:$currency}</strong>
                                {if $opconfig.show_cycles_in_summary}{$lang[$subprod.recurring]}{/if}
                            {/if}
                            {if $subprod.setup!=0}
                                {if $subprod.price>0} + {/if}
                                {$subprod.setup|price:$currency} {$lang.setupfee}
                            {/if}
                        </td>
                    </tr>
                {/foreach}
            {/if}



            {if $tax}
                <tr>
                    <td>
                        {$lang.subtotal}
                    </td>
                    <td>
                        {$tax.subtotal|price:$currency}
                    </td>
                </tr>
                {if $subtotal.coupon}
                    <tr>
                        <td>
                            {$lang.discount}
                        </td>
                        <td>
                            - {$subtotal.discount|price:$currency}
                        </td>
                    </tr>
                {/if}
                {if $tax.tax1 && $tax.taxed1!=0}
                    <tr>
                        <td>
                            {$tax.tax1name} @ {$tax.tax1}%
                        </td>
                        <td>
                            {$tax.taxed1|price:$currency}
                        </td>
                    </tr>
                {/if}
                {if $tax.tax2  && $tax.taxed2!=0}
                    <tr>
                        <td>
                            {$tax.tax2name} @ {$tax.tax2}%
                        </td>
                        <td>
                            {$tax.taxed2|price:$currency}
                        </td>
                    </tr>
                {/if}
                {if $tax.credit!=0}
                    <tr>
                        <td>
                            {$lang.credit}
                        </td>
                        <td>
                            {$tax.credit|price:$currency}
                        </td>
                    </tr>
                {/if}
            {elseif $credit}
                {if  $credit.credit!=0}
                    <tr>
                        <td>
                            {$lang.credit}
                        </td>
                        <td>
                            {$credit.credit|price:$currency}
                        </td>
                    </tr>
                {/if}
                {if $subtotal.coupon}
                    <tr>
                        <td>
                            {$lang.discount}
                        </td>
                        <td>
                            - {$subtotal.discount|price:$currency}
                        </td>
                    </tr>
                {/if}
                <tr>
                    <td>
                        {$lang.subtotal}
                    </td>
                    <td>
                        {$subtotal.total|price:$currency}
                    </td>
                </tr>
            {else}
                {if $subtotal.coupon}
                    <tr>
                        <td>
                            {$lang.discount}
                        </td>
                        <td>
                            - {$subtotal.discount|price:$currency}
                        </td>
                    </tr>
                {/if}
                <tr>
                    <td>
                        {$lang.subtotal}
                    </td>
                    <td>
                        {$tax.subtotal|price:$currency}
                    </td>
                </tr>
            {/if}
            {if !empty($tax.recurring)}
                <tr>
                    <td>
                        {$lang.total_recurring}
                    </td>
                    <td>
                        {foreach from=$tax.recurring item=rec key=k}
                            {$rec|price:$currency} {$lang.$k}<br/>
                        {/foreach}
                    </td>
                </tr>
            {elseif !empty($subtotal.recurring)}
                <tr>
                    <td>
                        {$lang.total_recurring}
                    </td>
                    <td>
                        {foreach from=$subtotal.recurring item=rec key=k}
                            {$rec|price:$currency} {$lang.$k}<br/>
                        {/foreach}
                    </td>
                </tr>
            {/if}
            <tr>
                <td>
                    <strong>{$lang.total_today}</strong>
                </td>
                <td>
                    <h3>
                        {if $tax}
                            {$tax.total|price:$currency}
                        {elseif $credit}
                            {$credit.total|price:$currency}
                        {else}
                            {$subtotal.total|price:$currency}
                        {/if}
                    </h3>
                </td>
            </tr>
            </tbody>
        </table>
        <hr>
    </div>
    <div class="orderpage-summary-content">
        {if $product.paytype=='Free'}
            <input type="hidden" name="cycle" value="Free">
            {elseif $product.paytype=='Once'}
            <input type="hidden" name="cycle" value="Once">
            {else}
            {assign var="prcycles" value=0}
            {foreach from=$product item=p_price key=p_cycle}
                {if $p_cycle == 'd' || $p_cycle == 'w' || $p_cycle == 'm' || $p_cycle == 'q' || $p_cycle == 's' || $p_cycle == 'a' || $p_cycle == 'b' || $p_cycle == 't' || $p_cycle == 'p4' || $p_cycle == 'p5'}
                    {if $p_price > 0}{assign var="prcycles" value=$prcycles+1}{/if}
                {/if}
            {/foreach}
            {* show billing cycle select if cycles > 1*}
            <div class="form-group orderpage-summary_bcycle bindcart_js" {if $prcycles < 2} style="display: none;" {/if}>
                <div class="d-flex flex-row align-items-center mb-3 orderpage-summary_title">
                    <h3>{$lang.changebillingcycle}</h3>
                </div>
                <div class="w-100">
                    {include file="common/price.tpl" allprices='cycle'}
                </div>
            </div>
        {/if}

        {if $opconfig.show_reccuring_price_instead_today}
            <div class="form-group orderpage-summary_total">
                <div class="d-flex flex-row align-items-center mb-3 orderpage-summary_title">
                    <h3>{if !empty($tax.recurring.m)}{$lang.total_recurring}{elseif !empty($subtotal.recurring.m)}{$lang.total_recurring}{else}{$lang.total_today}{/if}</h3>
                </div>
                <div class="text-primary h1 d-flex flex-row align-items-center">
                    <span>
                        {if !empty($tax.recurring.m)}
                            {$tax.recurring.m|price:$currency} <small>{$lang.m}</small>
                            <br/>
                        {elseif !empty($subtotal.recurring.m)}
                            {$subtotal.recurring.m|price:$currency} <small>{$lang.m}</small>
                            <br/>
                        {else}

                                {if $tax}
                                    {$tax.total|price:$currency}
                                {elseif $credit}
                                    {$credit.total|price:$currency}
                                {else}
                                    {$subtotal.total|price:$currency}
                                {/if}
                        {/if}
                    </span>
                    <span class="d-inline-block vtip_description orderpage-summary_recurring" data-content="
                        <b>{$lang.total_today}</b><br/>
                        {if $step!=4}
                            {$subtotal.total|price:$currency}
                        {else}
                        {if $tax}
                            {$tax.total|price:$currency}
                        {elseif $credit}
                            {$credit.total|price:$currency}
                        {else}
                            {$subtotal.total|price:$currency}
                        {/if}
                        {/if}
                        <hr>
                        <b>{$lang.total_recurring}</b><br/>
                        {if !empty($tax.recurring)}
                            {foreach from=$tax.recurring item=rec key=k}
                                <b>{$rec|price:$currency}</b> <small>{$lang.$k}</small>
                                <br/>
                            {/foreach}
                        {elseif !empty($subtotal.recurring)}
                            {foreach from=$subtotal.recurring item=rec key=k}
                                <b>{$rec|price:$currency}</b> <small>{$lang.$k}</small>
                                <br/>
                            {/foreach}
                        {/if}"></span>
                    <script>{literal}$('.popover').popover('dispose');$('.orderpage-summary_recurring').popover({trigger: 'hover', placement:'top', html: true});{/literal}</script>
                </div>
            </div>
        {else}
            <div class="form-group orderpage-summary_total">
                <div class="d-flex flex-row align-items-center mb-3 orderpage-summary_title">
                    <h3>{$lang.total_today}</h3>
                </div>
                <div class="text-primary h1">
                    <span>
                        {if $step!=4}
                            {$subtotal.total|price:$currency}
                        {else}
                        {if $tax}
                            {$tax.total|price:$currency}
                        {elseif $credit}
                            {$credit.total|price:$currency}
                        {else}
                            {$subtotal.total|price:$currency}
                        {/if}
                        {/if}
                    </span>
                    <span class="d-inline-block vtip_description orderpage-summary_recurring" title="{$lang.total_recurring}" data-content="
                        {if !empty($tax.recurring)}
                            {foreach from=$tax.recurring item=rec key=k}
                                <b>{$rec|price:$currency}</b> <small>{$lang.$k}</small>
                                <br/>
                            {/foreach}
                        {elseif !empty($subtotal.recurring)}
                            {foreach from=$tax.recurring item=rec key=k}
                                <b>{$rec|price:$currency}</b> <small>{$lang.$k}</small>
                                <br/>
                            {/foreach}
                        {/if}"></span>
                    <script>{literal}$('.popover').popover('dispose');$('.orderpage-summary_recurring').popover({trigger: 'hover', placement:'top', html: true});{/literal}</script>
                </div>
            </div>
        {/if}
        <div class="orderpage-summary_submit">
            <button type="submit" class="btn btn-success btn-lg w-100" onclick="submitOrder();return false;">{$lang.order}</button>
        </div>
    </div>
    <div class="orderpage-summary-details-info border-top pt-2">
        <i class="material-icons size-sm text-primary domain-tld-checkbox-icon">info</i>
        {if $tax}
            <span><small>{$lang.cart_additional_tax}</small></span>
        {/if}
        <a href="#" onclick="$('.orderpage-summary-details').toggle();return false;" class="ml-2"><small>{$lang.show_details}</small></a>
    </div>
</section>
{/if}
