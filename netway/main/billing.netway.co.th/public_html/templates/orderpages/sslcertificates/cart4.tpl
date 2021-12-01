<link media="all" type="text/css" rel="stylesheet" href="{$orderpage_dir}sslcertificates/style.css" />
{include file='sslcertificates/cprogress.tpl'}
<div class="blue-pad">
    <h4>{$lang.step} 5</h4>
    <h3>{$lang.en_payment}</h3>
</div>
{if $gateways}
    <div class="white-box right step-gateway form-inline" {if $tax && $tax.total==0}style="display:none"{elseif $credit && $credit.total==0}style="display:none"{elseif $subtotal.total==0}style="display:none"{/if}>
        <h3>{$lang.choose_payment}</h3>
        <div class="strike-line"></div>

        {foreach from=$gateways item=module key=mid name=payloop}
            <label>
                <input onclick="return pop_ccform($(this).val())" type="radio" name="gate" value="{$mid}" {if $submit && $submit.gateway==$mid||$mid==$paygateid}checked="checked"{elseif $smarty.foreach.payloop.first}checked="checked"{/if}/> {$module}
            </label>
        {/foreach}

    </div>
{/if}
<div class="white-box step-order-sum">
    <h3>{$lang.ordersummary}</h3>
    <div class="strike-line"></div>
    {include file='ajax.cart.summary.tpl'}
</div>
<form action="" method="post" onsubmit="return checkout()" id="orderform">
    <input type="hidden" id="gateway_form" name="gateway" value="{if $submit && $submit.gateway}{$submit.gateway}{elseif $paygateid}{$paygateid}{/if}" />
    {if $gateways}
        <div id="gatewayform">
            {$gatewayhtml}
        </div>
    {/if}

    <input type="hidden" name="make" value="step4" />
    {if $logged=="1"}
        <div class="white-box">
            <h3>{$lang.ContactInfo}</h3>
            <div class="strike-line"></div>
            {include file="drawclientinfo.tpl"}
        </div>

    {else}

        <div class="white-box">

            <div class="cart-switch tabbme">
                <span {if !$submit || !$submit.make || $submit.cust_method=='newone' || $submit.action!='login'}class="t1 active on"{else}class="t1"{/if} onclick="ajax_update('{$system_url}index.php?cmd=signup',{literal} {layer: 'ajax'}, '#updater', true);
                        $(this).parent().find('li.t2').removeClass('on');
                        $(this).addClass('on');{/literal}" >
                    {$lang.newclient}</span>
                <span {if $submit.cust_method=='login' || $submit.action=='login'}class="t2 active on"{else}class="t2"{/if} onclick="ajax_update('{$system_url}index.php?cmd=login',{literal} {layer: 'ajax'}, '#updater', true);
                        $(this).parent().find('li.t1').removeClass('on');
                        $(this).addClass('on');{/literal}"}>
                    {$lang.alreadyclient}</span>
                <div></div>
            </div>
            <h3>{$lang.ContactInfo}</h3>
            <div class="strike-line"></div>
            <div id="updater" >
                {if $submit.cust_method=='login'}
                    {include file='ajax.login.tpl'}
                {else}
                    {include file='ajax.signup.tpl'}
                {/if} 
            </div>
        </div>
    {/if} 
    <div class="white-box">

        <h3>{$lang.cart_add}</h3>
        <div class="strike-line"></div>
        <table border="0" cellpadding="0" cellspacing="6" width="100%">
            <tr>
                <td align="center">
                    <textarea id="c_notes" onblur="if (this.value == '')
                                this.value = '{$lang.c_tarea}';" onfocus="if (this.value == '{$lang.c_tarea}')
                                            this.value = '';" style="width:98%" rows="3"  name="notes">{$lang.c_tarea}</textarea>
                </td>
            </tr>
            {if $tos}
                <tr>
                    <td align="center"><input type="checkbox" value="1" name="tos"/> {$lang.tos1} <a href="{$tos}" target="_blank">{$lang.tos2}</a>
                    </td>
                </tr>
            {/if}
        </table>
    </div>
    <a href="#" class="btn btn-custom right" onclick="$('#orderform').submit();
            return false;">{$lang.checkout} &raquo;</a>
</form>
<script type="text/javascript">
    step5();
</script>
<div class="clear"></div>