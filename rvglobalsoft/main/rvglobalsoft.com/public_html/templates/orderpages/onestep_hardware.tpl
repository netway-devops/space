{*
@@author:: HostBill team
@@name:: VPS Hardware, One-step
@@description:: Designed for products that let user customize their orders with sliders, where stadard vps resources are presented in form of server components. A One-Step checkout, where your client can pick package, configure it, add domains, addons, config options and signup, all on one page.
@@thumb:: onestep_hardware/thumb.png
@@img:: onestep_hardware/preview.png
*}
<link rel="stylesheet" href="{$orderpage_dir}onestep_hardware/css/jquery-ui-1.8.21.custom.css">
<link rel="stylesheet" href="{$orderpage_dir}onestep_hardware/css/style.css">
<script src="{$orderpage_dir}onestep_hardware/js/script.js"></script>

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

    <!-- Setup Server-->
    <div class="setup-server clearfix">
        <h1>Setup <span>Your</span> Server</h1>
        <p>Use the slider to setup your best server within minutes.</p>
        <div class="bundle-slider">
            <div class="bundle-active-bg">
                <div class="bundle-slider-bg">
                </div>
                <ul class="slider-separators">
                    {foreach from=$products item=i name=loop}
                        {if !$smarty.foreach.loop.first}{*
                            *}<li></li>{*
                            *}<li></li>{*
                            *}<li></li>{*
                            *}<li></li>{*
                        *}{/if}{*
                        *}<li class="large-separator {if $smarty.foreach.loop.first}first{/if}"></li>
                    {/foreach}
                    <div id="main-slider" class="bundle-slider-path">
                    </div>
                </ul>
            </div>
            <div class="predefinied-servers">

                {section loop=$products start=-1 step=-1 name=loop}
                    <div class="predefinied-server" rel="{$products[loop].id}">
                        <div class="point-bed">
                            <span class="point"></span>
                        </div>
                        <div class="server-text">
                            <p class="server-title">{$products[loop].name}</p>
                            <p class="server-price">{include file="common/price.tpl" product=$products[loop]}</p>
                        </div>
                    </div>
                {/section}
            </div>
        </div>
        <div class="mb"></div>
        <div class="motherboard">
            <ul class="cpu-1">
                <li></li>
                <li></li>
                <li></li>
                <li></li>
            </ul>

            <ul class="cpu-2">
                <li></li>
                <li></li>
                <li></li>
                <li></li>
            </ul>

            <ul class="hdd-1">
                <li></li>
                <li></li>
                <li></li>
                <li></li>
            </ul>

            <ul class="ram-1 hidden-ram">
                <ul class="chip-ram">
                    <li class="first-ele"></li>
                    <li></li>
                    <li class="last-ele"></li>
                </ul>
            </ul>

            <ul class="ram-2 hidden-ram">
                <ul class="chip-ram">
                    <li class="first-ele"></li>
                    <li></li>
                    <li class="last-ele"></li>
                </ul>
            </ul>

            <ul class="ram-3 hidden-ram">
                <ul class="chip-ram">
                    <li class="first-ele"></li>
                    <li></li>
                    <li class="last-ele"></li>
                </ul>
            </ul>

            <ul class="ram-4 hidden-ram">
                <ul class="chip-ram">
                    <li class="first-ele"></li>
                    <li></li>
                    <li class="last-ele"></li>
                </ul>
            </ul>
        </div>
    </div>
    <div class="setup-server-shadow center clear"></div>
    <div id="update">
        {include file="ajax.onestep_hardware.tpl" }
    </div>
    <form action="?cmd=cart&cat_id={$current_cat}" method="post" id="orderform" class="clear" onsubmit="return mainsubmit(this)">
        <input type="hidden" name="make" value="order" />

        <!-- Client Information -->
        <div class="client-information">
            <h2>Client Info</h2>

            {if $logged!="1"}
                <div class="btn-group">
                    <button class="btn _new {if !$submit.cust_method=='login' && !$submit.action=='login'}active{/if}" onclick="return clientForm(false)">New Client</button>
                    <button class="btn _reg {if  $submit.cust_method=='login' || $submit.action=='login'}active{/if}" onclick="return clientForm(true)">Registered</button>
                </div>
            {/if}

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
        <div class="client-information">
            <h2>{$lang.cart_add}</h2>

            <textarea class="center notes" name="notes" placeholder="{$lang.c_tarea}">{if $submit.notes}{$submit.notes}{/if}</textarea>
        </div>
        <div class="client-information">
            <div class="tos">
                {if $tos}<p><input id="checkbox-tos" value="1" name="tos" type="checkbox"> {$lang.tos1} <a href="{$tos}"  target="_blank">{$lang.tos2}</a></p>
                    {/if}
            </div>
        </div>
    </form>
</div>