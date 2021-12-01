{*
@@author:: HostBill team
@@name:: Double Slider - wizard theme
@@description::  Designed to work with a few packages. Wizard-style checkout means your clients configure their order step-by-step on separate screens, with checkout at the end.<br/><br/>
@@thumb:: slidersquaretab/images/wizard_slidersquaretab_thumb.png
@@img:: slidersquaretab/images/slidersquaretab_preview.png
*}

<script type="text/javascript" src="{$orderpage_dir}common/cart.js?step={$step}"></script>
{include file='cart.progress.tpl'}


{if $step==0}
{include file='slidersquaretab/cart0.tpl'}	
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
