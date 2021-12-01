{*
@@author:: Prasit Narkdee
@@name:: Product License
@@description:: Product License Order Page<br/><br/>
@@thumb:: cart_product_license/thumb.png
@@img:: cart_product_license/preview.png
*}
{php}
    $templatePath = $this->get_template_vars('template_path');
    include(dirname($templatePath) . '/orderpages/cart_product_license.tpl.php');
{/php}


<script type="text/javascript">
var step        = {$step};
var orderPage   = '{$ca_url}cart/{$currentSlug}/';
var caUrl       = '{$ca_url}';
var systemUrl   = '{$system_url}';
</script>

<link media="all" type="text/css" rel="stylesheet" href="{$orderpage_dir}cart_product_license/css/style.css" />
<script type="text/javascript" src="{$orderpage_dir}common/cart.js?step={$step}"></script>
<script type="text/javascript" src="{$orderpage_dir}cart_product_license/js/script.js?step={$step}"></script>

<!-- Modal -->
<div id="productModal" class="modal hide fade" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
  <div class="modal-header">
    <button type="button" class="close" data-dismiss="modal" aria-hidden="true">×</button>
    <h3 id="myModalLabel">Product Info</h3>
  </div>
  <div class="modal-body">
    <p id="productModalContent">Loading content ...</p>
  </div>
</div>


{*include file='cart_product_license/cart.progress.tpl'*}

{if $step==0 || $step==2 || $step==3}
    {if $product  || $step==3}
        {include file='cart_product_license/cart.product.tpl'}
    {else}
        {include file='cart_product_license/cart0.tpl'}
    {/if}
{elseif $step==4} 
    {include file='cart_product_license/cart4.tpl'}
{elseif $step==5} 
    {include file='cart_product_license/cart5.tpl'}
{/if}