{*
@@author:: HostBill team
@@name:: 2019 Wizard
@@description:: Can hold any amount of products. Wizard-style checkout means your clients configure their order step-by-step on separate screens, with checkout at the end.<br/><br/>
@@thumb:: cart_2019wizard/thumb.png
@@img:: cart_2019wizard/preview.png
*}
{php}
    $templatePath   = $this->get_template_vars('template_path');//ลอง include script ของ cart_neworderpage
    include(dirname($templatePath) . '/orderpages/cart_neworderpage.tpl.php');
{/php}
<link media="all" type="text/css" rel="stylesheet" href="{$orderpage_dir}cart_2019wizard/css/style.css"/>
<link media="all" type="text/css" rel="stylesheet" href="{$orderpage_dir}cart_2019wizard/css/slick.min.css"/>

<script type="text/javascript"> var step = {$step};</script>
<script type="text/javascript" src="{$orderpage_dir}common/cart.js?step={$step}"></script>
<script type="text/javascript" src="{$orderpage_dir}cart_2019wizard/js/slick.min.js"></script>
<script type="text/javascript" src="{$orderpage_dir}cart_2019wizard/js/script.js"></script>

<div id="cart-wrapper" class="px-2">
    {if $step==0}
        {include file='cart_2019wizard/cart0.tpl'}
    {elseif $step==1}
        {include file='cart_2019wizard/cart1.tpl'}
    {elseif $step==2}
        {include file='cart_2019wizard/cart2.tpl'}
    {elseif $step==3}
        {include file='cart_2019wizard/cart3.tpl'}
    {elseif $step==4}
        {include file='cart_2019wizard/cart4.tpl'}
    {elseif $step==5}
        {include file='cart5.tpl'}
    {/if}
</div>