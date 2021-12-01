{*
@@author:: HostBill team
@@name:: Premade sliders, Wizard theme
@@description:: Allows creating predefined configurations that can help your clients choose their desired package. Wizard-style checkout means your clients configure their order step-by-step on separate screens, with checkout at the end.
@@thumb:: cart_premade/img/thumb.png
@@img:: cart_premade/img/preview.png
*}

<script type="text/javascript" src="{$orderpage_dir}common/cart.js?step={$step}"></script>
{include file='cart.progress.tpl'}

{if $step==0}
    {include file='cart_premade/cart.tpl'}
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
