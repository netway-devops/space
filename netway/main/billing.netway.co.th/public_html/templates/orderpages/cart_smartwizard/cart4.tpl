
{include file="cart_smartwizard/header.tpl"}
{include file="cart_smartwizard/cart.summary.tpl"}

<!-- Left Column -->
<div class="left-column left">
    <div class="cart-container-sw"> 

        <!-- Contact Info -->
        <form action="" method="post" onsubmit='if($("#c_notes").val()=="{$lang.c_tarea}")$("#c_notes").val("");' id="subbmitorder">
            <div class="contact-info-box left">
                <div class="payment-method">
                    <h3 class="openSansBold">{$lang.choose_payment}</h3>
                    <div class="contact-underline">
                        <span class="underline-title-bold"></span>
                    </div>
                    {if $gateways}
                        <ul class="openSansRegular left form-horizontal" style="list-style: none;">
                            {foreach from=$gateways item=module key=mid name=payloop}
                                <li>
                                    <input style="vertical-align: text-top" onclick="return pop_ccform($(this).val())" type="radio" name="gateway" value="{$mid}" {if $submit && $submit.gateway==$mid||$mid==$paygateid}checked="checked"{elseif $smarty.foreach.payloop.first}checked="checked"{/if} />
                                    <span>{$module}</span>
                                </li>
                            {/foreach}
                        </ul>
                    {/if}
                </div>
                {if $gateways}
                    <div id="gatewayform">
                        {$gatewayhtml}
                    </div>
                    <script type="text/javascript">reform_ccform();</script>
                {/if}
                

                <div class="client-info left">
                    <h3 class="openSansBold">{$lang.ContactInfo}</h3>
                    <div class="contact-underline">
                        <span class="underline-title-bold"></span>
                    </div>
                    {if $logged=="1"}
                        {include file="drawclientinfo.tpl"}
                    {else}
                        <div class="cart-switch tabbme">
                            <span {if !$submit || !$submit.make || $submit.cust_method=='newone' || $submit.action!='login'}class="t1 active on"{else}class="t1"{/if} onclick="ajax_update('{$system_url}index.php?cmd=signup',{literal}{layer:'ajax'},'#updater',true);$(this).parent().find('li.t2').removeClass('on');$(this).addClass('on');{/literal}" >
                                {$lang.newclient}</span>
                            <span {if $submit.cust_method=='login' || $submit.action=='login'}class="t2 active on"{else}class="t2"{/if} onclick="ajax_update('{$system_url}index.php?cmd=login',{literal}{layer:'ajax'},'#updater',true);$(this).parent().find('li.t1').removeClass('on');$(this).addClass('on');{/literal}"}>
                                                                                              {$lang.alreadyclient}</span>
                            <div></div>
                        </div>

                        <div id="updater" class="openSansRegular" >
                            {if $submit.cust_method=='login'}
                                {include file="ajax.login.tpl"}
                            {else}
                                {include file="ajax.signup.tpl"}
                            {/if}
                        </div>
                    {/if} 
                </div>

                <div class="additional-notes left">
                    <h3 class="openSansBold">{$lang.cart_add}</h3>
                    <div class="contact-underline">
                        <span class="underline-title-bold"></span>
                    </div>
                    <textarea class="center"  id="c_notes" placeholder="{$lang.c_tarea}"  name="notes">{if $submit.notes}{$submit.notes}{/if}</textarea>
                </div>

                {if $tos}
                    <div class="additional-notes left">
                        <h3 class="openSansBold">{$lang.tos2}</h3>
                        <div class="contact-underline">
                            <span class="underline-title-bold"></span>
                        </div>
                        <div class="openSansBold" style="margin: 10px 0 0 40px">
                            <input type="checkbox" value="1" name="tos"/> {$lang.tos1} <a href="{$tos}" target="_blank">{$lang.tos2}</a>
                        </div>
                    </div>
                {/if}

            </div>
            <input type="hidden" name="make" value="step4" />
        </form>
    </div>


    <div class="pagination-box">
        {include file='cart_smartwizard/pagination.tpl'}

        <div class="pagination-right-button right" onclick="$('#subbmitorder').submit(); return false;">
            <span class="pag-arrow"></span>
            <span class="openSansBold">{$lang.next}</span>
        </div>
    </div>
</div>
<div class="order-button-pattern right" onclick="$('#subbmitorder').submit(); return false;">
        <div class="order-button">
            <a href="#" class="openSansBold text-center">{$lang.ordernow}</a>
        </div>
    </div>
<div class="clear"></div>