{*
@@author:: HostBill team
@@name:: Listing + more info
@@description:: Simple, flexible template - works well with any type of product offered.
@@thumb:: images/wizard_dedicated_thumb.png
@@img:: images/dedicated_preview.png
*}
<script type="text/javascript" src="{$orderpage_dir}common/cart.js?step={$step}"></script>
{include file='cart.progress.tpl'}


{if $step==0}
    {if $current_cat==1}
        {include file='cart_ssl/cart_ssl.tpl'}
    {else}
        {include file='cart0_dedicated.tpl'}
    {/if}
{elseif $step==1}
	{include file='cart1.tpl'}
{elseif $step==2}
	{include file='cart2.tpl'}
{elseif $step==3}
	{if $current_cat==1}
	    <div style="display:none;">  
        {include file='cart3.tpl'}
        </div>
        <strong>Processing...</strong>
        <script type="text/javascript">
	       $('#cart3').submit();
        </script>
	{else}
	   {include file='cart3.tpl'}
	{/if}
{elseif $step==4} 

	{include file='cart4.tpl'}
	
{elseif $step==5} 
	{include file='cart5.tpl'}
{/if}