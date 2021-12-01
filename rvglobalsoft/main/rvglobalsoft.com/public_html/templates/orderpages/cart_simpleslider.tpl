{*
@@author:: HostBill team
@@name:: Simple Slider - wizard theme
@@description::  Designed to work with 4 packages. Wizard-style checkout means your clients configure their order step-by-step on separate screens, with checkout at the end.<br/><br/>
<strong>How-To Videos:</strong></br>
<a href="http://cdn.hostbillapp.com/videos/orderpages/simpleslider_260/slider_new_description.swf" target="_blank" class="external">Setting your packages specifications</a></br>
@@thumb:: images/simpleslider_thumb.png
@@img:: images/simpleslider_preview.png
*}

<script type="text/javascript" src="{$orderpage_dir}common/cart.js?step={$step}"></script>
{include file='cart.progress.tpl'}


{if $step==0}
{include file='_simple_slider/cart0.tpl'}	
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
