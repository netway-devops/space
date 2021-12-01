{*
@@author:: HostBill team
@@name:: Volume slider, One-step
@@description:: A One-Step checkout, where your client can pick package, configure it, add domains, addons, config options and signup, all on one page. 
@@thumb:: onestep_volume/thumb.png
@@img:: onestep_volume/preview.png
*}

<link href="{$orderpage_dir}onestep_volume/css/orderpage.css" rel="stylesheet">
<script type="text/javascript" src="{$orderpage_dir}onestep_volume/js/script.js"></script>

<div class="orderpage">
    <h1>{if $opconfig.header}{$opconfig.header}{else}Setup your <span>dream server</span>{/if}</h1>
    <h2>{if $opconfig.subheader}{$opconfig.subheader}{else}Pick your best option. 60 second setup. Free to go!{/if}</h2>
    <div class="main-slider">
        <!-- Main Slider -->
        <div class="main-slider-bg">
            <div class="main-slider-dots">
                <div class="main-slider-body">
                    <div class="m-slider-fix">
                        <div class="main-slider-handle" id="sliderHandle">
                        </div>
                        {foreach from=$products item=i name=loop}
                            <div class="plan_ plan-{$smarty.foreach.loop.index}">
                                <div class="plan-rel" rel="{$i.id}">
                                    <p>{$i.name}</p>
                                    <span>{include file='common/price.tpl' product=$i}</span>
                                </div>
                            </div>
                        {/foreach}
                    </div>
                </div>
            </div>
        </div>
        <!-- End of Main Slider -->
    </div>
    <div id="update">
        {include file="ajax.onestep_volume.tpl"}
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

        <div class="client-info">
            {if $logged!="1"}
                <div class="pull-right client-select">
                    <i class="icon-client-select"></i>
                    <select onchange="clientForm(this); false;">
                        <option value="0">{$lang.newclient}</option>
                        <option value="1" {if $submit.cust_method=='login' || $submit.action=='login'}selected="selected"{/if}>{$lang.registered}</option>
                    </select>
                </div>
            {/if}
            <h3><i class="icon-client-info"></i>{$lang.clientinfo}</h3>
            {if $logged=="1"}
                <div class="client-info-t">
                    {include file="drawclientinfo.tpl"}
                </div>
            {else}
                <div id="clientform" class="client-info-t clear {if !$submit || !$submit.make || $submit.cust_method=='newone' || $submit.action!='login'}new-client{/if}">
                    {if $submit.cust_method=='login' || $submit.action=='login'}
                        {include file='ajax.login.tpl}
                    {else}
                        {include file='ajax.signup.tpl}
                    {/if}
                </div>
            {/if}
        </div>
        <div class="notes" >
            <h3><i class="icon-notes"></i>{$lang.cart_add}</h3>
            <textarea id="c_notes" {if !$submit.notes}onblur="if (this.value == '')this.value = '{$lang.c_tarea}';" onfocus="if (this.value == '{$lang.c_tarea}') this.value = '';"{/if} rows="3"  name="notes"></textarea>
        </div>

        <div class="tos">
            {if $tos}<p><input id="checkbox-tos" type="checkbox" value="1" name="tos"> {$lang.tos1} <a href="{$tos}"  target="_blank">{$lang.tos2}</a></p>{/if}
            <div class="checkout-center">
                <div class="checkout-button-fix center">
                    <button type="submit" class="checkout-button disabled" disabled="disabled">Order now <i class="icon-submit-arrow-b"></i></button>
                </div>
            </div>
        </div>

    </div>

    <!-- Orderpage -->

</div>