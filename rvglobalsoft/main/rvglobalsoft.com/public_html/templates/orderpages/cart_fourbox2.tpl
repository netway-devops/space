{*
@@author:: HostBill team
@@name:: Small comparison boxes
@@description:: Simple, flexible template - works well with any type of product offered.
@@thumb:: fourbox2/images/fourbox2_thumb.png
@@img:: fourbox2/images/fourbox2.png
*}
<script type="text/javascript" src="{$orderpage_dir}common/cart.js?step={$step}"></script>
{include file='cart.progress.tpl'}

{if $step==0}
{include file='fourbox2/cart0_fourbox2.tpl'}
	
{elseif $step==1}
	{include file='cart1.tpl'}
{elseif $step==2}
	{include file='cart2.tpl'}
{elseif $step==3}
	{include file='cart3.tpl'}
{elseif $step==4} 
	{include file='cart4.tpl'}
{elseif $step==5} 
	{include file='cart5.tpl'}
{/if}