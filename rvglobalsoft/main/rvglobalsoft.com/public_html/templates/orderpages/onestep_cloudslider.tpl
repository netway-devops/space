{*
@@author:: HostBill team
@@name:: Cloud Slider, One-step
@@description:: A One-Step checkout, where your client can pick package, configure it, add domains, addons, config options and signup, all on one page. 
@@thumb:: onestep_cloudslider/thumb.png
@@img:: onestep_cloudslider/preview.png
*}
<link rel="stylesheet" href="{$orderpage_dir}onestep_cloudslider/css/jquery-ui-1.8.21.custom.css">
<link rel="stylesheet" href="{$orderpage_dir}onestep_cloudslider/css/style.css">
<script src="{$orderpage_dir}onestep_cloudslider/js/script.js"></script>

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
    <!-- Clouds -->
    <div class="setup-cloud-server">
        <div class="clouds-bg"></div>
        <h1>{if $opconfig.header}{$opconfig.header}{else}{$lang.setupyour} <span>{$lang.cloudserver}</span>{/if}</h1>
        <ul class="slider-clouds clearfix">
            {foreach from=$products item=i key=k}
                <li rel="{$i.id}"><span onclick="setSlider({$k}, event); return false;">{$k+1}</span></li>
            {/foreach}
        </ul>
        <script type="text/javascript">
            alignCloud();
        </script>
        <div id="main-slider" class="top-slider-bg center">
        </div>
    </div>
    <div id="update">
        {include file="ajax.onestep_cloudslider.tpl"}
    </div>

    <form action="?cmd=cart&cat_id={$current_cat}" method="post" id="orderform" onsubmit="return mainsubmit(this)">
        <input type="hidden" name="make" value="order" />
        <div id="gatewayform" class="clear"{if $tax && $tax.total==0}style="display:none"{elseif $credit && $credit.total==0}style="display:none"{elseif $subtotal.total==0}style="display:none"{/if}>
            {$gatewayhtml}
            <script type="text/javascript"> reform_ccform(); </script>
        </div>

        <!-- Client Information -->
        <div class="client-information">
            <div class="white-box">
                <div class="white-box-header">
                    <div class="white-box-header-bg">
                        <h2 class="bold">{$lang.clientinfo}</h2>
                    </div>
                    <div class="white-box-header-img"></div>
                    {if $logged!="1"}
                        <div class="client-list btn-group">
                            <a class="dropdown-toggle" href="#" data-toggle="dropdown" >{if $submit.cust_method=='login' || $submit.action=='login'}{$lang.login}{else}{$lang.signup}{/if} <span class="caret"></span></a>
                            <ul class="dropdown-menu">
                                <li><a href="#" onclick="return clientForm(false)">{$lang.newclient}</a></li>
                                <li><a href="#" onclick="return clientForm(true)">{$lang.registered}</a></li>
                            </ul>
                        </div>
                    {/if}
                </div>

                <div class="white-container-bg">
                    <div class="white-container">
                        {if $logged=="1"}
                            <div id="clientinfo">
                                {include file="drawclientinfo.tpl"}
                            </div>
                        {else}
                            <div id="clientform" class="clear {if !$submit || !$submit.make || $submit.cust_method=='newone' || $submit.action!='login'}new-client{/if}">
                                {if $submit.cust_method=='login' || $submit.action=='login'}
                                    {include file='ajax.login.tpl}
                                {else}
                                    {include file='ajax.signup.tpl}
                                {/if}
                            </div>
                        {/if}
                    </div>
                </div>
            </div>
        </div>

        <!-- Notes -->
        <div class="notes">
            <div class="white-box">
                <div class="white-box-header">
                    <div class="white-box-header-bg">
                        <h2 class="bold">{$lang.cart_add}</h2>
                    </div>
                    <div class="white-box-header-img"></div>
                </div>
                <div class="white-container-bg">
                    <div class="white-container">
                        <textarea class="center" name="notes" placeholder="{$lang.c_tarea}">{if $submit.notes}{$submit.notes}{/if}</textarea>
                    </div>
                </div>
            </div>
        </div>

        <div class="tos">
            {if $tos}<p><input id="checkbox-tos" value="1" name="tos" type="checkbox"> {$lang.tos1} <a href="{$tos}"  target="_blank">{$lang.tos2}</a></p>
            {/if}
            <div class="checkout-center">
                <div class="checkout-button-fix center">
                    <input type="submit" class="checkout-button disabled" disabled="disabled"  value="{$lang.checkout}">
                </div>
            </div>
        </div>
    </form>
</div>
