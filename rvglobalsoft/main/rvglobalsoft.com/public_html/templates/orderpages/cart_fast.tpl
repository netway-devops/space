{*
@@author:: HostBill team
@@name:: Lightweight & Fast
@@description:: Created purely with CSS this template is very light and loads instantly. Simple and flexible - will work with any kind of product.
@@thumb:: fast/thumb.png
@@img:: fast/preview.png
*}

<script type="text/javascript" src="{$orderpage_dir}common/cart.js?step={$step}"></script>
{include file='cart.progress.tpl'}

{if $step==0}
{include file='fast/cart0.tpl'}
	
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