{*
@@author:: HostBill team
@@name:: Bookshelf
@@description:: Designed to hold 4 packages. Wizard-style checkout means your clients configure their order step-by-step on separate screens, with checkout at the end.<br/><br/>
@@thumb:: cart_bookshelf/thumb.png
@@img:: cart_bookshelf/preview.png
*}
<script type="text/javascript"> var step = {$step}; </script>
<script type="text/javascript" src="{$orderpage_dir}common/cart.js?step={$step}"></script>
<link media="all" type="text/css" rel="stylesheet" href="{$orderpage_dir}cart_bookshelf/css/style.css" />
<script type="text/javascript" src="{$orderpage_dir}cart_bookshelf/js/script.js"></script>
{if $step==0}
    {include file='cart_bookshelf/cart0.tpl'}	
{elseif $step==1}
	{include file='cart_bookshelf/cart1.tpl'}
{elseif $step==2}
	{include file='cart_bookshelf/cart2.tpl'}
{elseif $step==3}
	{include file='cart_bookshelf/cart3.tpl'}
{elseif $step==4} 
	{include file='cart_bookshelf/cart4.tpl'}
{elseif $step==5} 
	{include file='cart_bookshelf/cart5.tpl'}
{/if}
