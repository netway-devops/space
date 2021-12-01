{*
@@author:: HostBill team
@@name:: Listing + more info
@@description:: Simple, flexible template - works well with any type of product offered.
@@thumb:: images/wizard_dedicated_thumb.png
@@img:: images/dedicated_preview.png
*}

{if $custom_overrides.cart_dedicated}
    {include file=$custom_overrides.cart_dedicated}
{else}
    <script type="text/javascript" src="{$orderpage_dir}common/cart.js?step={$step}"></script>
    {include file='cart.progress.tpl'}
    {if $step==0}
        {include file='cart0_dedicated.tpl'}
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
{/if}