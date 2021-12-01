<div id="Regular_b" {if $product.paytype!='Regular'}style="display:none"{/if} class="boption">
    {include file="services/productbilling.tpl" billingoptions=$billingoptions.regular}
</div>