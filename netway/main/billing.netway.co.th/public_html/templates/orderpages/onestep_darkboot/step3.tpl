<div class="left-side">
    <form action="?cmd=cart&cat_id={$current_cat}" method="post" id="orderform">
        <input type="hidden" name="make" value="order" />
    <h3>{$lang.choose_payment}</h3>
    <div class="underline-title">
        <div class="underline-bolder"></div>
    </div>
    
    <div class="payment-method">
        {foreach from=$gateways item=module key=mid name=payloop}
            <span class="radio"><input type="radio"  name="gateway" value="{$mid}"  onclick="return pop_ccform($(this).val())" {if $submit && $submit.gateway==$mid || $mid==$paygateid}checked="checked"{elseif $smarty.foreach.payloop.first}checked="checked"{/if}/> {$module}</span>
        {/foreach}
    </div>

    <div id="gatewayform" class="clear"{if $tax && $tax.total==0}style="display:none"{elseif $credit && $credit.total==0}style="display:none"{elseif $subtotal.total==0}style="display:none"{/if}>
        {$gatewayhtml}
        <script type="text/javascript"> reform_ccform(); </script>
    </div>
    {if $logged!="1"}
        <div class="client-list select-list-fix right">
            <select onchange="return clientForm(this)">
                <option value="1">{$lang.newclient}</option>
                <option value="0">{$lang.alreadyclient}</option>
            </select>
        </div>
    {/if}
    <h3>{$lang.ContactInfo}</h3>
    
    <div class="underline-title">
        <div class="underline-bolder"></div>
    </div>

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
    <h3>{$lang.cart_add}</h3>
    <div class="underline-title">
        <div class="underline-bolder"></div>
    </div>
    <textarea id="c_notes" placeholder="{$lang.c_tarea}" style="width: 93%"  name="notes">{if $submit.notes}{$submit.notes}{/if}</textarea>
    {if $tos}
    <div class="tos">
        <p class="checkbox"><input id="checkbox-tos" value="1" name="tos" type="checkbox"> {$lang.tos1} <a href="{$tos}"  target="_blank">{$lang.tos2}</a></p>
    </div>
    {/if}
    </form>
    <script type="text/javascript">jQuery.fn.chosen = function() {literal}{}{/literal};</script>
</div>
