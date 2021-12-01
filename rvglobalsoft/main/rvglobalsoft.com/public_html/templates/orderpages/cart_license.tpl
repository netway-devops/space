{*
@@author:: Netway Team
@@name:: License
@@description:: Simple, flexible template - works well with any type of product offered.
@@thumb:: images/wizard_dedicated_thumb.png
@@img:: images/dedicated_preview.png
*}
{php}
    $templatePath = $this->get_template_vars('template_path');
    include(dirname($templatePath) . '/orderpages/cart_license.tpl.php');
{/php}

<script type="text/javascript">
var step        = {$step};
var orderPage   = '{$ca_url}cart/{$currentSlug}/';
var caUrl       = '{$ca_url}';
var systemUrl   = '{$system_url}';
var loading     = '<span><img src="'+ systemUrl +'templates/netwaybysidepad/img/ajax-loading2.gif" align="left" /> &nbsp; Validating</span>';
</script>

<script type="text/javascript" src="{$orderpage_dir}common/cart.js?step={$step}"></script>
<script type="text/javascript" src="{$orderpage_dir}cart_license/js/script.js?step={$step}"></script>

{include file='cart.progress.tpl'}

{if $step==0}
{include file='cart_license/cart0.tpl'}
    
{elseif $step==1}
    {include file='cart1.tpl'}
{elseif $step==2}
    {include file='cart2.tpl'}
{elseif $step==3}
    {include file='cart_license/cart3.tpl'}
{elseif $step==4} 
    {include file='cart4.tpl'}
{elseif $step==5} 
    {include file='cart5.tpl'}
{/if}