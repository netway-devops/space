{php}
    $templatePath = $this->get_template_vars('template_path');
    include(dirname($templatePath) . '/orderpages/cart_product_license/cart.product.tpl.php');
{/php}


<h2>You're going to order {$productName}</h2>
<hr />

{* เอาไว้ add item to cart *}
<div style="display: ;">
    <form id="formAddCart" name="" action="" method="post">
        <input name="action" type="hidden" value="add">
        <input name="step" type="hidden" value="0">
        <input name="id" type="hidden" value="">
        <input name="cycle" type="hidden" value="">
        <input name="CartIndex" type="hidden" value="">
    </form>
</div>

<div id="orderFormArea">

{if $product == 'cpanel'}
    {include file='cart_product_license/cart.cpanel.tpl'}
{elseif $product == 'ispmanager'}
    {include file='cart_product_license/cart.ispmanager.tpl'}
{elseif $product == 'cloudlinux'}
    {include file='cart_product_license/cart.cloudlinux.tpl'}
{elseif $product == 'rvskin'}
    {include file='cart_product_license/cart.rvskin.tpl'}
{elseif $product == 'rvsitebuilder'}
    {include file='cart_product_license/cart.rvsitebuilder.tpl'}
{elseif $product == 'softaculous'}
    {include file='cart_product_license/cart.softaculous.tpl'}
{elseif $product == 'litespeed'}
    {include file='cart_product_license/cart.litespeed.tpl'}
{/if}

<div id="additionalFormArea">

{if isset($aControlPanel)}
<div class="additionalProduct">
<h2>Control Panel</h2>
<hr />
{foreach from=$aControlPanel key="slug" item="item"}
    <div class="row">
        <div class="span4">
            <label>
                <input type="checkbox" id="additionalProduct_{$slug}" name="additional_product[]" value="{$slug}" onclick="additionalToShoppingCart();" />
                <input type="hidden" id="additionalProductId_{$slug}" name="additional_product_id[{$slug}]" value="0" />
                {$item.name}
                <span id="additionalBillingCycle{$slug}"></span>
            </label>
            <!--<a href="#productModal" onclick="loadProductInfo('{$slug}');" data-toggle="modal"><i class="icon-info-sign"></i></a>-->
        </div>
        <div id="additionalVerify{$slug}" class="span3"></div>
        <div class="span4"><input type="hidden" name="additional_product_order_type[{$slug}]" value="Register" /></div>
    </div>
{/foreach}
</div>

<div>
    <div class="row">
        <p align="center">&nbsp;</p>
    </div>
</div>

{/if}



{if isset($aAdditional)}
<div class="additionalProduct">
<h2>Additional Products</h2>
<hr />
{foreach from=$aAdditional key="slug" item="item"}
    <div class="row">
        <div class="span4">
            <label>
                <input type="checkbox" id="additionalProduct_{$slug}" name="additional_product[]" value="{$slug}" onclick="additionalToShoppingCart();" />
                <input type="hidden" id="additionalProductId_{$slug}" name="additional_product_id[{$slug}]" value="0" />
                {$item.name}
                <span id="additionalBillingCycle{$slug}"></span>
            </label>
            <!--<a href="#productModal" onclick="loadProductInfo('{$slug}');" data-toggle="modal"><i class="icon-info-sign"></i></a>-->
        </div>
        <div id="additionalVerify{$slug}" class="span3"></div>
        <div class="span4"><input type="hidden" name="additional_product_order_type[{$slug}]" value="Register" /></div>
    </div>
{/foreach}
</div>

<div>
    <div class="row">
        <p align="center">&nbsp;</p>
    </div>
</div>

{/if}

</div>



<div id="continueProcess">
    <div class="row well">
        <p align="center">
            <a href="{$ca_url}cart/" class="btn btn-primary">Continue</a>
        </p>
    </div>
</div>

</div>

<div>
    <div class="row">
        <p align="center">&nbsp;</p>
    </div>
</div>