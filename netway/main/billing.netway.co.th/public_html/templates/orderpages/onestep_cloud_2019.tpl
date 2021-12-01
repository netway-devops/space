{*
@@author:: HostBill team
@@name:: Cloud 2019
@@description:: Designed to use with 2019 template only. It will not work on other themes
@@thumb:: onestep_cloud_2019/thumb.png
@@img:: onestep_cloud_2019/preview.png
*}
{php}
$templatePath   = $this->get_template_vars('template_path');
 include(dirname($templatePath) . '/orderpages/cart_neworderpage.tpl.php');
{/php}

<link rel="stylesheet" href="{$orderpage_dir}onestep_cloud_2019/css/orderpage.css">

<script>
    var scrollToConfig = {if $opconfig.scroll_to_configuration}true{else}false{/if};
</script>

<section class="section-account-header d-flex flex-row justify-content-between align-items-start mb-5">
    <div>
        <h1>{$opconfig.headertext}</h1>
        {if $opconfig.subheadertext}
            <h5 class="mt-5">{$opconfig.subheadertext}</h5>
        {/if}
    </div>

    {if count($currencies)>1}
        <div class="d-flex flex-row justify-content-end my-2">
            <form action="" method="post" id="currform" class="form-inline">
                <input name="action" type="hidden" value="changecurr">
                <span class="mr-3">{$lang.Currency}</span>
                <select name="currency" class="form-control" onchange="$('#currform').submit()">
                    {foreach from=$currencies item=crx}
                        <option value="{$crx.id}" {if !$selcur && $crx.id==0}selected="selected"{elseif $selcur==$crx.id}selected="selected"{/if}>{if $crx.code}{$crx.code}{else}{$crx.iso}{/if}</option>
                    {/foreach}
                </select>
            </form>
        </div>
    {/if}
</section>

{if $opconfig.show_parent_category_contents && $main_category}
    <section class="mb-4">
        {include file="`$main_category.template`.tpl"
        cat=$main_category
        subcategories=$main_category.subcategories
        opconfig=$main_category.opconfig
        selected_cat=$category.id}
    </section>
{/if}

{assign var="scount" value=0}

<div id="orderpage" class="orderpage">
    {if $opconfig.hide_product_choosing && $products|@count == 1}
    {else}
        <div class="cart-products mb-5">
            <div class="d-flex flex-row align-items-center mb-3">
                <span class="cart-products-scount cart-products-scount_js pb-2">{assign var="scount" value=$scount+1}{$scount}</span>
                <h3>{$lang.selectproduct}</h3>
            </div>
            <div class="row">
                {if $products}
                {foreach from=$products item=i name=loop}
                    <div class="col-lg-3 col-md-6 col-12">
                        <div class="card cart-product {if $product.id == $i.id} selected {/if} {if $i.out_of_stock} outofstock {/if}" data-value="{$i.id}">
                            {if $opconfig.show_features}
                                {assign var="showfeats" value=false}
                                {specs var="awords" string=$i.description}
                                {foreach from=$awords item=prod name=lla key=k}
                                    {foreach from=$prod item=feat name=desc key=ka}
                                        {if $smarty.foreach.desc.index == 1}
                                            {assign var="showfeats" value=true}
                                            {break}
                                        {/if}
                                    {/foreach}
                                {/foreach}

                                {if $showfeats}
                                        <span class="vtip_description vtip_features" title="
                                        {foreach from=$awords item=prod name=lla key=k}
                                            {foreach from=$prod item=feat name=desc key=ka}
                                                {if $smarty.foreach.desc.index == 1}
                                                    {$feat|@strip_tags}
                                                {/if}
                                            {/foreach}
                                        {/foreach}
                                    "></span>
                                        {assign var=awords value=false}
                                {/if}
                            {/if}
                            {if $i.out_of_stock}
                                <div class="cart-product-outofstock-badge">{$lang.out_of_stock_badge}</div>
                            {/if}
                            <div class="text-center cart-product-section py-4">
                                <h4 class="">{$i.name}</h4>
                                <div class="card-subtitle mt-3 font-weight-bold" style="display:none;">
                                    <span class="h1 text-primary">{include file="common/price.tpl" product=$i allprices=true}</span>
                                    <span class="h6 text-primary"> / {include file='common/cycle.tpl' product=$i allprices=true}</span>
                                </div>
                            </div>
                            <div class="text-small cart-product-section">
                                {specs var="awords" string=$i.description}
                                {foreach from=$awords item=prod name=lla key=k}
                                    {if $prod.specs}
                                        {if $smarty.foreach.lla.index == 0 || $smarty.foreach.lla.index == 1}<div class="my-3">{/if}
                                        {foreach from=$prod.specs item=feat name=plan key=ka}
                                            <div class="row mx-3">
                                                <div class="col-6 p-1 text-right font-weight-light text-muted">{$feat[0]}</div>
                                                <div class="col-6 p-1 text-left font-weight-bold">{$feat[1]}</div>
                                            </div>
                                        {/foreach}
                                        {if $smarty.foreach.lla.index == 0 || $smarty.foreach.lla.index == 1}</div>{/if}
                                    {/if}
                                {/foreach}
                                {assign var=awords value=false}
                            </div>
                        </div>
                    </div>
                {/foreach}
                {/if}
            </div>
        </div>
    {/if}

    <div id="updater" class="orderpage-configuration">
        {include file="ajax.onestep_cloud_2019.tpl" }
    </div>

    <form action="" method="post" class="w-100" id="cartdetails" name="cartdetails">
        {if !'config:ShopingCartMode'|checkcondition}
            <div class="row bindcart_js" {if $tax && $tax.total==0}style="display:none"{elseif $credit && $credit.total==0}style="display:none"{elseif $subtotal.total==0}style="display:none"{/if}>
                <div class="col-12 mb-5 mt-0">
                    <div class="d-flex flex-row align-items-center mb-3">
                        <span class="cart-products-scount cart-products-scount_js pb-2">{assign var="scount" value=$scount+1}{$scount}</span> <h3>{$lang.choose_payment}</h3>
                    </div>

                    <div class="my-2" id="cart-gateway-list">
                        {if $gateways}
                            <div class="d-flex flex-row justify-content-start flex-wrap cart-gateway-list">
                                {foreach from=$gateways item=module key=mid name=payloop}
                                    <span class="mr-3">
                                    <input onclick="ajax_update('?cmd=cart&action=getgatewayhtml&gateway_id=' + $(this).val(), '', '#gatewayform', true)" type="radio" name="gateway" value="{$mid}" {if $submit && $submit.gateway==$mid||$mid==$paygateid}checked="checked"{elseif $smarty.foreach.payloop.first}checked="checked"{/if}/>
                                    <span>{$module}</span>
                                </span>
                                {/foreach}
                            </div>
                        {/if}
                    </div>
                </div>
            </div>
            {if $gateways}
                <div id="gatewayform" class=" my-3">
                    {$gatewayhtml}
                </div>
            {/if}
            {if $logged=="1"}
                <div class="row">
                    <div class="col-12 mb-5 mt-0">
                        <div class="d-flex flex-row align-items-center mb-3">
                            <span class="cart-products-scount cart-products-scount_js pb-2">{assign var="scount" value=$scount+1}{$scount}</span> <h3>{$lang.ContactInfo}</h3>
                        </div>

                        <div class="my-2" id="cart-gateway-list">
                            {include file="drawclientinfo.tpl"}
                        </div>
                    </div>
                </div>
            {else}
                <div class="row">
                    <div class="col-12 mb-5 mt-0">
                        <div class="d-flex flex-row align-items-center mb-3">
                            <span class="cart-products-scount cart-products-scount_js pb-2">{assign var="scount" value=$scount+1}{$scount}</span> <h3>{$lang.ContactInfo}</h3>
                        </div>

                        <div class="toggle-forms">

                            <div class="card">
                                <div class="card-body item">
                                    <div class="form-check">
                                        <input type="radio" name="cust_method" value="login" {if $submit.cust_method == 'login'}checked='checked'{/if} onchange="{literal}toggle_client($(this));ajax_update('index.php?cmd=login', {layer: 'ajax'}, '#updater_login', true);{/literal}" />
                                        <label class="form-check-label">{$lang.alreadyclient}</label>
                                    </div>
                                    <div class="mt-3 toggle-forms-body" {if $submit.cust_method=='login'}{else}style="display:none"{/if} id="updater_login">
                                        {if $submit.cust_method=='login'}
                                            {include file="ajax.loginform.tpl"}
                                        {/if}
                                    </div>
                                </div>
                            </div>

                            <div class="card">
                                <div class="card-body item">
                                    <div class="form-check">
                                        <input type="radio" name="cust_method" value="newone" {if !isset($submit) || $submit.cust_method != 'login'}checked='checked'{/if} onchange="{literal}toggle_client($(this));ajax_update('index.php?cmd=signup', {layer: 'ajax'}, '#updater_signup', true);{/literal}" />
                                        <label class="form-check-label">{$lang.newclient}</label>
                                    </div>
                                    <div class="mt-3 toggle-forms-body" {if !isset($submit) || $submit.cust_method != 'login'}{else}style="display:none" {/if} id="updater_signup">
                                        {if $submit.cust_method=='login'}

                                        {else}
                                            {include file="ajax.signup.tpl"}
                                        {/if}
                                    </div>
                                </div>
                            </div>
                        </div>

                    </div>
                </div>
            {/if}

            <div class="row">
                <div class="col-12 mb-5 mt-0">
                    <div class="d-flex flex-row align-items-center mb-3">
                        <span class="cart-products-scount cart-products-scount_js pb-2">{assign var="scount" value=$scount+1}{$scount}</span> <h3>{$lang.cart_add}</h3>
                    </div>

                    <div class="my-2">
                        <div class="w-100">
                            <textarea id="c_notes" class="w-100 form-control textarea-autoresize" placeholder="{$lang.c_tarea}" rows="5" name="notes">{if $submit.notes}{$submit.notes}{/if}</textarea>
                        </div>
                    </div>
                </div>
            </div>

            <div class="row">
                <div class="col-12 mb-5 mt-0">
                    <div class="d-flex flex-row align-items-center mb-3">
                        <span class="cart-products-scount cart-products-scount_js pb-2">{assign var="scount" value=$scount+1}{$scount}</span> <h3>{$lang.tos2}</h3>
                    </div>

                    <div class="my-2">
                        <div class="w-100">
                            <input class="tos-checkbox" type="checkbox" name="tos" value="1" style="display:none!important;">
                            {foreach from=$terms item=tt name=termsloop}
                                <div class="">
                                    <input class="term-checkbox" type="checkbox" id="term{$smarty.foreach.termsloop.iteration}" onchange="$('.tos-checkbox').prop('checked', $('.term-checkbox:checked').length == $('.term-checkbox').length)">
                                    <label for="term{$smarty.foreach.termsloop.iteration}" class="text-small">
                                        {if $tt.url} <span class="mr-1">{$lang.tos1}</span><a href="{$tt.url}" target="_blank" >{$tt.name}</a>
                                        {else} {$tt.name}
                                        {/if}
                                    </label>
                                </div>
                            {/foreach}
                        </div>
                    </div>
                </div>
            </div>
        {/if}
        <input type='hidden' name='make' value='order' />
    </form>
</div>

<script src="{$orderpage_dir}onestep_cloud_2019/js/script.js"></script>
<!-- End of Orderpage -->