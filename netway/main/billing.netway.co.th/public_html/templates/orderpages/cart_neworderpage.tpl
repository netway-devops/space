{*
@@author:: Panya Boonla
@@name:: new cart template
@@description:: dynamic cart template
@@thumb:: dynamic_cart/images/website-monitor-ecom.gif
@@img:: dynamic_cart/images/website-monitor-ecom.gif
*}
{php}
$templatePath   = $this->get_template_vars('template_path');
include(dirname($templatePath) . '/orderpages/cart_neworderpage.tpl.php');
{/php}
 
<script type="text/javascript" src="{$orderpage_dir}common/cart.js?step={$step}"></script>
{include file='cart.progress.tpl'}
{if $step==0}
{include file='dynamic_cart/cart0_dynamic_cart.tpl'}
{elseif $step==1}{include file='cart1.tpl'}
{elseif $step==2}{include file='cart2.tpl'}
{elseif $step==3}{include file='cart3.tpl'}
{elseif $step==4}{include file='cart4.tpl'}
{elseif $step==5}{include file='cart5.tpl'}
{/if}