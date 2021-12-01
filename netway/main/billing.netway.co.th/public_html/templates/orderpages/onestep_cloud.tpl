{*
@@author:: HostBill team
@@name:: Cloud order, One-step
@@description:: A One-Step checkout, where your client can pick package, configure it, add domains, addons, config options and signup, all on one page. 
@@thumb:: onestep_cloud/thumb.png
@@img:: onestep_cloud/prev.png
*}
<link rel="stylesheet" href="{$orderpage_dir}onestep_cloud/css/style.css">
<script type="text/javascript" src="{$orderpage_dir}onestep_cloud/js/raphael.js"></script>
<script type="text/javascript" src="{$orderpage_dir}onestep_cloud/js/script.js"></script>
<script type="text/javascript"> 
    var sliders = [],
    packages = [];
    {foreach from=$products item=i name=loop key=k}
        packages.push('{$i.id}');
    {/foreach}
</script>

<div class="cart-page center">
    <ul class="hosting-type">
        {foreach from=$categories item=i name=categories name=cats}
            {if $i.id != $current_cat}
                <li class="{if $smarty.foreach.cats.last}last{/if}"><a href="{$ca_url}cart/{$i.slug}/&amp;step={$step}{if $addhosting}&amp;addhosting=1{/if}">{$i.name}</a></li>
            {else}
                <li class="{if $smarty.foreach.cats.last}last{/if} active-hosting">{$i.name}</li>
            {/if}
        {/foreach}
    </ul>
    <!-- Setup Cloud Server -->

    <!-- Slider -->
    <div class="slider-container">
        <div class="slider-box">
            <div class="slider-bg"></div>
            <div class="slider-handle"></div>
            <div class="slider-shadow"></div>

            <div class="max-box">
                <div class="max-icon"></div>
                <span>{$lang.max}</span>
            </div>
            <div class="min-box">
                <div class="min-icon"></div>
                <span>{$lang.min}</span>
            </div>
        </div>
    </div>
    <div id="update">
        {include file='ajax.onestep_cloud.tpl'}
    </div>
    <form action="?cmd=cart&cat_id={$current_cat}" method="post" id="orderform" onsubmit="return mainsubmit(this)">
        <input type="hidden" name="make" value="order" />
        {* PAYMENT METHOD *}
        {if $gateways}
            <div class="gateways page-section">
                <h4>{$lang.payment}</h4>
                <div class="underline-title">
                    <div class="underline-bold"></div>
                </div>
                <div class="gateways-list clearfix">
                    {foreach from=$gateways item=module key=mid name=payloop}
                        <div class="left"><input type="radio" name="gateway" value="{$mid}"  onclick="return pop_ccform($(this).val())" {if $submit && $submit.gateway==$mid || $mid==$paygateid}checked="checked"{elseif $smarty.foreach.payloop.first}checked="checked"{/if}/> {$module} </div>
                        {/foreach}
                </div>
                <div class="clear"></div>

                <div id="gatewayform" class="clear"{if $tax && $tax.total==0}style="display:none"{elseif $credit && $credit.total==0}style="display:none"{elseif $subtotal.total==0}style="display:none"{/if}>
                    {$gatewayhtml}
                    <script type="text/javascript"> reform_ccform(); </script>
                </div>
            </div>
        {/if}

        {*CONTACT INFO*}
        <!-- Client Information -->

        <div class="page-section client-information">
            <h4>{$lang.clientinfo}</h4>
            {if $logged=="1"}
                <div id="clientinfo">
                    {include file="drawclientinfo.tpl"}
                </div>
            {else}
                <div class="client-toggle">
                    <div class="toggle-slider btn-group">
                        <div class="toggle-option-fix btn {if !$submit || !$submit.make || $submit.cust_method=='newone' || $submit.action!='login'}t1 active-toggle{else}t1{/if}" onclick="return clientForm(false)">
                            <span class="active-toggle">{$lang.newclient}</span>
                        </div>
                        <div class="toggle-option-fix btn {if $submit.cust_method=='login' || $submit.action=='login'}t2  active-toggle{else}t2{/if}" onclick="return clientForm(true)">
                            <span>{$lang.registered}</span>
                        </div>
                    </div>
                </div>
                <div id="clientform" class="clear {if !$submit || !$submit.make || $submit.cust_method=='newone' || $submit.action!='login'}new-client{/if}">
                    {if $submit.cust_method=='login' || $submit.action=='login'}
                        {include file='ajax.login.tpl}
                    {else}
                        {include file='ajax.signup.tpl}
                    {/if}
                </div>
            {/if}
        </div>
        <div class="notes">
            <h4>{$lang.cart_add}</h4>
            <textarea id="c_notes" placeholder="{$lang.c_tarea}"  name="notes">{if $submit.notes}{$submit.notes}{/if}</textarea>
        </div>
        <div class="list-of-steps-shadow"></div>
        <div class="tos">
            {if $tos}<p><input id="checkbox-tos" value="1" name="tos" type="checkbox">  {$lang.tos1} <a href="{$tos}"  target="_blank">{$lang.tos2}</a></p>{/if}
            <div class="checkout-center">
                <div class="checkout-button-fix center">
                    <input type="submit" class="checkout-button disabled" disabled="disabled" value="Checkout">
                </div>
            </div>
        </div>
    </form>
</div>