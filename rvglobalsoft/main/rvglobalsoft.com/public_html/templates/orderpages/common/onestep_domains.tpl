{*
{include file='common/onestep_subproducts.tpl' counter_start=0 show_tabs=false bulktld_col=3}
counter_start - used for alternating rows
show_tabs - display tabs for transfer etc.
bulktld_col - number of columns 

*}{if !$counter_start}{assign value=0 var=counter_start}{/if}{*
*}{if !$bulktld_col}{assign value=3 var=bulktld_col}{/if}{*
*}{counter start=$counter_start name=form_custom_counter print=false assign=form_custom_counter}
{literal}
    <script type="text/javascript">
        if (typeof tabbme != 'function'){
            window.tabbme = function (el) {
                $(el).parent().find('button').removeClass('active');
                $('#options div.slidme').hide().find('input[type=radio]').removeAttr('checked');
                $('#options div.' + $(el).attr('rel')).show().find('input[type=radio]').attr('checked', 'checked');
                $(el).addClass('active');
            }
        }
        if (typeof on_submit != 'function') {
            window.on_submit = function () {
                if ($("input[value='illregister']").is(':checked')) {
                    //own
                    ajax_update('index.php?cmd=checkdomain&action=checkdomain&product_id=' + $('#product_id').val() + '&product_cycle=' + $('#product_cycle').val() + '&' + $('.tld_register').serialize(), {
                        layer: 'ajax',
                        sld: $('#sld_register').val()
                    }, '#updater2', true);
                } else if ($("input[value='illtransfer']").is(':checked')) {
                    //transfer
                    ajax_update('index.php?cmd=checkdomain&action=checkdomain&transfer=true&sld=' + $('#sld_transfer').val() + '&tld=' + $('#tld_transfer').val() + '&product_id=' + $('#product_id').val() + '&product_cycle=' + $('#product_cycle').val(), {
                        layer: 'ajax'
                    }, '#updater2', true);
                } else if ($("input[value='illupdate']").is(':checked')) {
                    ajax_update('index.php?cmd=cart&domain=illupdate&sld_update=' + $('#sld_update').val() + '&tld_update=' + $('#tld_update').val(), {
                        layer: 'ajax'
                    }, '#update');
                    $('.load-img').show();
                } else if ($("input[value='illsub']").is(':checked')) {
                    ajax_update('index.php?cmd=cart&domain=illsub&sld_subdomain=' + $('#sld_subdomain').val(), {
                        layer: 'ajax'
                    }, '#update');
                    $('.load-img').show();
                }
                return false;
            }
        }
        if (typeof onsubmit_2 != 'function') {
            window.onsubmit_2 = function () {
                $('.load-img').show();
                ajax_update('index.php?cmd=cart&' + $('#domainform2').serialize(), {
                    layer: 'ajax'
                }, '#update');
                return false;
            }
        }
    </script>
{/literal}
{if ($product.hostname) && !($cart_contents[0].domainoptions.register=='1' ||  $allowown || $subdomain)}
    <div class="cart-domains cart-item {if $form_custom_counter % 2 == 0}even{/if} {if $form_custom_counter == 0}first{/if}"> 
        <span class="cart-hostname">{$lang.hostname}*</span>
        <input name="domain" value="{$item.domain}" class="styled" size="50" onchange="if (typeof simulateCart == 'function')
                    simulateCart();"/>
    </div>
    {counter name=form_custom_counter}
    {if $product.extra.enableos=='1' && !empty($product.extra.os)}
        <div class="item {if $alterval % 2 == 0}even{/if} {if $alterval == 0}first{/if}"> 
            <h3>{$lang.ostemplate} *</h3>
            <select name="ostemplate" class="styled"   onchange="simulateCart('#cart3');">
                {foreach from=$product.extra.os item=os}
                    <option value="{$os.id}"  {if $item.ostemplate==$os.id}selected="selected"{/if}>{$os.name}</option>
                {/foreach}
            </select>      
        </div>
        {counter name=form_custom_counter}
    {/if}
{/if}
{if ($cart_contents[0].domainoptions.register)=='1' && ($allowregister || $allowtransfer || $allowown || $subdomain)}
    <div class="cart-domains cart-item {if $form_custom_counter % 2 == 0}even{/if} {if $form_custom_counter == 0}first{/if}"> 
        {if $show_tabs}
            <div class="btn-group">
                {if $allowregister}
                    <button rel="t1" class="btn {if $contents[2].action=='register' || !$contents[2]}active{/if}" onclick="tabbme(this); return false;">{$lang.register}</button>
                {/if}
                {if $allowtransfer}
                    <button rel="t2" class="btn {if $contents[2].action=='transfer'}active{/if}" onclick="tabbme(this);  return false;">{$lang.transfer}</button>
                {/if}
                {if $allowown}
                    <button rel="t3" class="btn {if $contents[2].action=='own' && !$subdomain}active{/if}" onclick="tabbme(this); return false;">{$lang.alreadyhave}</button>
                {/if}
                {if $subdomain}
                    <button rel="t4" class="btn {if $contents[2].action=='own' && $subdomain}active{/if}" onclick="tabbme(this);  return false;">{$lang.subdomain}</button>
                {/if}
            </div>
        {/if}
        {if $contents[2]}
            <div id="domoptions22">
                {foreach from=$contents[2] item=domenka key=kk}
                    {if $domenka.action!='own' && $domenka.action!='hostname'}
                        <strong>{if $domenka.action=='register'}{$lang.domainregister}{elseif $domenka.action=='transfer'}{$lang.domaintransfer}{/if}</strong> - {$domenka.name} - {$domenka.period} {$lang.years}
                        {$domenka.price|price:$currency}<br />
                    {else}
                        {$domenka.name}<br />
                    {/if}
                    {if $domenka.custom}
                        <form class="cartD" action="" method="post">
                            <table class="styled" width="100%" cellspacing="" cellpadding="6" border="0">
                                {foreach from=$domenka.custom item=cf}
                                    {if $cf.items}
                                        <tr>
                                            <td class="configtd" >
                                                <label for="custom[{$cf.id}]" class="styled">{$cf.name}{if $cf.options & 1}*{/if}</label>
                                                {if $cf.description!=''}<div class="fs11 descr" style="">{$cf.description}</div>{/if}
                                                {include file=$cf.configtemplates.cart cf_opt_formId=".cartD" cf_opt_name="custom_domain"}
                                            </td>
                                        </tr>
                                    {/if}   
                                {/foreach}
                            </table>
                        </form>
                    {/if}
                {/foreach}
                <a href="#" onclick="$('#domoptions22').hide();
                        $('#domoptions11').show();
                        return false;">{$lang.change}</a>
            </div>
        {/if}
        <div {if $contents[2]}style="display:none"{/if} id="domoptions11">
            <form action="" method="post"  name="domainpicker" onsubmit="return on_submit();">
                <input type="hidden" value="{$cart_contents[0].id}" id="product_id" name="product_id" />
                <input type="hidden" name="make" value="checkdomain" />
                <div id="options">
                    {if $allowregister}
                        <div id="illregister" class="t1 slidme">
                            <input type="radio" name="domain" value="illregister" style="display: none;" checked="checked"/>
                            <div class="domain-input-bulk domain-input left" id="multisearch" >
                                <textarea name="sld_register" id="sld_register" style="resize: none"></textarea>
                            </div>

                            <div class="domain-tld-bulk domain-tld" style="margin-left:10px;width:310px;float:left">
                                <table border="0" cellpadding="0" cellspacing="0" width="100%" style="" class="fs11">
                                    {foreach from=$tld_reg item=tldname name=ttld}
                                        {if !$smarty.foreach.ttld.first && $smarty.foreach.ttld.index % $bulktld_col == 0}</tr>{/if}
                                        {if !$smarty.foreach.ttld.last && $smarty.foreach.ttld.index % $bulktld_col == 0}<tr>{/if}
                                            <td width="33%"><input type="checkbox" name="tld[]" value="{$tldname}" {if $smarty.foreach.ttld.first}checked="checked"{/if} class="tld_register"/> 
                                                {$tldname}
                                            </td>
                                            {if $smarty.foreach.ttld.last}</tr>{/if}
                                        {/foreach}
                                    <tr></tr>
                                </table>
                            </div>
                            <div class="clear"></div>
                            <p class="align-right domain-check-bulk">
                                <input type="submit" value="{$lang.check}" class="btn domain-check"/>
                            </p>
                        </div>
                    {/if}
                    {if $allowtransfer}
                        <div id="illtransfer" style="{if $allowregister}display: none;{/if}"  class="t2 slidme align-center form-horizontal">
                            <input type="radio" style="display: none;" value="illtransfer" name="domain" {if !$allowregister}checked="checked"{/if}/>
                            www.
                            <input type="text" value="" size="40" name="sld_transfer" id="sld_transfer" class="styled domain-input"/>
                            <select name="tld_transfer" id="tld_transfer" class="span2 domain-tld">
                                {foreach from=$tld_tran item=tldname}
                                    <option>{$tldname}</option> 	
                                {/foreach}
                            </select>  
                            <input type="submit" value="{$lang.check}" class="btn domain-check"/>
                        </div>
                    {/if}
                    {if $allowown}
                        <div id="illupdate" style="{if $allowregister || $allowtransfer}display: none;{/if}"  class="t3 slidme align-center form-horizontal">
                            <input type="radio" style="display: none;" value="illupdate" name="domain" {if !$allowregister && !$allowtransfer}checked="checked"{/if}/>
                            www.
                            <input type="text" value="" size="40" name="sld_update" id="sld_update" class="styled domain-input"/>
                            .
                            <input type="text" value="" size="7" name="tld_update" id="tld_update" class="styled span2 domain-tld"/>  <input type="submit" value="{$lang.check}" class="btn domain-check"/>
                        </div>
                    {/if}
                    {if $subdomain}
                        <div id="illsub" style="{if $allowregister || $allowtransfer || $allowown}display: none;{/if}"  class="t4 slidme align-center form-horizontal">
                            <input type="radio" style="display: none;" value="illsub" name="domain"  {if !($allowregister || $allowtransfer || $allowown)}checked="checked"{/if}/>
                            www.
                            <input type="text" value="" size="40" name="sld_subdomain" id="sld_subdomain" class="styled domain-input"/>  
                            {$subdomain} <input type="submit" value="{$lang.check}" class="btn domain-check"/>
                        </div>
                    {/if}
                </div>
            </form>
            <form method="post" action="" onsubmit="return onsubmit_2();" id="domainform2">
                <div id="updater2">{include file="ajax.checkdomain.tpl"} </div>
            </form>
        </div>
    </div>
    {counter name=form_custom_counter}
{/if}