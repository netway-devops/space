{*
@@author:: HostBill team
@@name:: Fancy comparison, one-step
@@description:: A One-Step checkout, where your client can pick package, configure it, add domains, addons, config options and signup, all on one page.
Nice clean template with current plan highlighted, can hold maximum of four products
@@thumb:: onestep_fancy/thumb.png
@@img:: onestep_fancy/preview.png
*}
<link media="all" type="text/css" rel="stylesheet" href="{$orderpage_dir}onestep_fancy/style.css" />
<div id="onestepcontainer">
    <div id="ppicker">
        {if $current_cat!='addons' && $current_cat!='transfer' && $current_cat!='register'}
            {if $products}
                <input id="pidi" value="0" type="hidden" />
                <script src="{$template_dir}js/jquery-ui-1.8.2.custom.min.js" type="text/javascript"></script>
                <script type="text/javascript">
                    {literal}
                        function mainsubmit(formel) {
                            var v = $('input[name="gateway"]:checked');
                            if (v.length > 0) {
                                $(formel).append("<input type='hidden' name='gateway' value='" + v.val() + "' />");
                            }
                            if ($('input[name=domain]').length > 0 && $('input[name=domain]').attr('type') != 'radio') $(formel).append("<input type='hidden' name='domain' value='" + $('input[name=domain]').val() + "' />");

                            return true;
                        }

                        function onsubmit_2() {
                            $('#load-img').show();
                            ajax_update('index.php?cmd=cart&' + $('#domainform2').serialize(), {
                                layer: 'ajax'
                            }, '#configer');
                            return false;
                        }

                        function tabbme(el) {
                            $(el).parent().find('li').removeClass('on');
                            $('#options div.slidme').hide().find('input[type=radio]').removeAttr('checked');
                            $('#options div.' + $(el).attr('class')).show().find('input[type=radio]').attr('checked', 'checked');
                            $(el).addClass('on');
                        }

                        function on_submit() {
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
                                }, '#configer');
                                $('#load-img').show();
                            } else if ($("input[value='illsub']").is(':checked')) {
                                ajax_update('index.php?cmd=cart&domain=illsub&sld_subdomain=' + $('#sld_subdomain').val(), {
                                    layer: 'ajax'
                                }, '#configer');
                                $('#load-img').show();
                            }

                            return false;
                        }

                        function applyCoupon() {
                            ajax_update('?cmd=cart&addcoupon=true', $('#promoform').serializeArray(), '#configer');
                            return false;
                        }

                        function simulateCart(forms, domaincheck) {
                            $('#load-img').show();
                            var urx = '?cmd=cart&';
                            if (domaincheck) urx += '_domainupdate=1&';
                            ajax_update(urx, $(forms).serializeArray(), '#configer');
                        }

                        function removeCoupon() {

                            ajax_update('?cmd=cart', {
                                removecoupon: 'true'
                            }, '#configer');
                            return false;
                        }

                        function changeProduct(pid) {
                            if (pid == $('#pidi').val()) return;
                            $('#pidi').val(pid);
                            $('#products-container .product-container').removeClass('active');
                            $('#products-container .product-container[rel=' + pid + ']').addClass('active');

                            $('#errors').slideUp('fast', function () {
                                $(this).find('span').remove();
                            });
                            $('#load-img').show();
                            $.post('?cmd=cart&cat_id={/literal}{$current_cat}{literal}', {
                                id: pid
                            }, function (data) {
                                var r = parse_response(data);

                                $('#configer').html(r);
                            });
                        }

                        function submitTheForm() {
                            $('form#cart3').find('input,select').each(function () {
                                if (($(this).attr('type') != 'radio' && $(this).attr('type') != 'checkbox') || $(this).is(':checked')) $('#orderform').append('<input type="hidden" value="' + $(this).val() + '" name="' + $(this).attr('name') + '" />');

                            });
                            $('#orderform').submit();
                        }
                    
                </script>
                <style>
                    .product-header h2{
                        color:{/literal}{if $opconfig.darker}#{$opconfig.darker}{else}#ff8a1a{/if}{literal};
                    }
                    
                    .active .product-header .mask-ie{
                        background-color: {/literal}{if $opconfig.darker}#{$opconfig.darker}{else}#ffa34b{/if}{literal};
                        background-image: -moz-linear-gradient(top, {/literal}{if $opconfig.lighter}#{$opconfig.lighter}{else}#ffa34b{/if}, {if $opconfig.darker}#{$opconfig.darker}{else}#ff8a1a{/if}{literal});
                        background-image: -ms-linear-gradient(top, {/literal}{if $opconfig.lighter}#{$opconfig.lighter}{else}#ffa34b{/if}, {if $opconfig.darker}#{$opconfig.darker}{else}#ff8a1a{/if}{literal});
                        background-image: -webkit-gradient(linear, 0 0, 0 100%, from({/literal}{if $opconfig.lighter}#{$opconfig.lighter}{else}#ffa34b{/if}), to({if $opconfig.darker}#{$opconfig.darker}{else}#ff8a1a{/if}{literal}));
                        background-image: -webkit-linear-gradient(top, {/literal}{if $opconfig.lighter}#{$opconfig.lighter}{else}#ffa34b{/if}, {if $opconfig.darker}#{$opconfig.darker}{else}#ff8a1a{/if}{literal});
                        background-image: -o-linear-gradient(top, {/literal}{if $opconfig.lighter}#{$opconfig.lighter}{else}#ffa34b{/if}, {if $opconfig.darker}#{$opconfig.darker}{else}#ff8a1a{/if}{literal});
                        background-image: linear-gradient(top, {/literal}{if $opconfig.lighter}#{$opconfig.lighter}{else}#ffa34b{/if}, {if $opconfig.darker}#{$opconfig.darker}{else}#ff8a1a{/if}{literal});
                        background-repeat: repeat-x;
                        filter: progid:DXImageTransform.Microsoft.gradient(startColorstr='{/literal}{if $opconfig.lighter}#{$opconfig.lighter}{else}#ffa34b{/if}', endColorstr='{if $opconfig.darker}#{$opconfig.darker}{else}#ff8a1a{/if}{literal}', GradientType=0);
                    }
                    
                    .active .product-actions a.btn{
                        background-color: {/literal}{if $opconfig.darker}#{$opconfig.darker}{else}#ff8a1a{/if}{literal};
                    }
                    .active .product-actions a.btn:hover,
                    .active .product-actions a.btn:active,
                    .active .product-actions a.btn.active{
                        background-color: {/literal}{if $opconfig.darker}#{$opconfig.darker}{else}#darker{/if}{literal};
                    }
                </style>
                {/literal}
                <div class="left">
                    {foreach from=$categories item=i name=categories name=cats}
                        {if $i.id != $current_cat}
                            <a href="{$ca_url}cart/{$i.slug}/&amp;step={$step}{if $addhosting}&amp;addhosting=1{/if}">{$i.name}</a> {if !$smarty.foreach.cats.last}|{/if}
                        {else}
                            <strong>{$i.name}</strong> {if !$smarty.foreach.cats.last}|{/if}
                        {/if}
                    {/foreach}
                    {if $logged=='1'} 
                        {if $current_cat=='addons'}                        | <strong>{$lang.prodaddons}</strong>
                        {else} | <a href="{$ca_url}cart&amp;step={$step}&amp;cat_id=addons">{$lang.prodaddons}</a>
                        {/if}
                    {/if}
                </div>
                {if count($currencies)>1}
                    <div class="right">
                        <form action="" method="post" id="currform">
                            <input name="action" type="hidden" value="changecurr">
                            {$lang.Currency}
                            <select name="currency" class="styled span2" onchange="$('#currform').submit()">
                                {foreach from=$currencies item=crx}
                                    <option value="{$crx.id}" {if !$selcur && $crx.id==0}selected="selected"{elseif $selcur==$crx.id}selected="selected"{/if}>{if $crx.code}{$crx.code}{else}{$crx.iso}{/if}</option>
                                {/foreach}
                            </select>
                        </form>
                    </div>
                {/if}
                <div class="clear"></div>
                <div id="products-container">
                    {foreach from=$products item=i name=loop key=k}
                        {if $smarty.foreach.loop.index > 3}{break}{/if}
                        <div class="left {if $i.id==$product.id}active{/if} product-container" rel="{$i.id}">
                            <div class="product-header">
                                <div class="mask-ie">
                                <h1>{$i.name}</h1>
                                <h2>
                                    {if $i.paytype=='Free'}
                                        {$lang.Free}
                                    {elseif $i.paytype=='Once'}
                                        {if $i.m < 999}{$i.m|price:$currency}{else}{$currency.sign}{$i.m}{/if}
                                    {else}
                                        <!--
                                        {if $i.d!=0}
                                            -->{if $i.d < 999}{$i.d|price:$currency}{else}{$currency.sign}{$i.d}{/if}<!--
                                        {elseif $i.w!=0}
                                            -->{if $i.w < 999}{$i.w|price:$currency}{else}{$currency.sign}{$i.w}{/if}<!--
                                        {elseif $i.m!=0}
                                            -->{if $i.m < 999}{$i.m|price:$currency}{else}{$currency.sign}{$i.m}{/if}<!--
                                        {elseif $i.q!=0}
                                            -->{if $i.q < 999}{$i.q|price:$currency}{else}{$currency.sign}{$i.q}{/if}<!--	
                                        {elseif $i.s!=0}
                                            -->{if $i.s < 999}{$i.s|price:$currency}{else}{$currency.sign}{$i.s}{/if}<!--	
                                        {elseif $i.a!=0}
                                            -->{if $i.a < 999}{$i.a|price:$currency}{else}{$currency.sign}{$i.a}{/if}<!--	
                                        {elseif $i.b!=0}
                                            -->{if $i.b < 999}{$i.b|price:$currency}{else}{$currency.sign}{$i.b}{/if}<!--	
                                        {elseif $i.t!=0}
                                            -->{if $i.t < 999}{$i.t|price:$currency}{else}{$currency.sign}{$i.t}{/if}<!--	
                                        {elseif $i.p4!=0}
                                            -->{if $i.p4 < 999}{$i.p4|price:$currency}{else}{$currency.sign}{$i.p4}{/if}<!--
                                        {elseif $i.p5!=0}
                                            -->{if $i.p5 < 999}{$i.p5|price:$currency}{else}{$currency.sign}{$i.p5}{/if}<!--
                                        {/if}
                                        -->
                                    {/if}
                                </h2>
                                <span>
                                    {if $i.paytype=='Free'}
                                    {elseif $i.paytype=='Once'}{$lang.once}
                                    {else}
                                        {if $i.d!=0}{$lang.d} 
                                        {elseif $i.w!=0}{$lang.w} 
                                        {elseif $i.m!=0}{$lang.m}
                                        {elseif $i.q!=0}{$lang.q}
                                        {elseif $i.s!=0}{$lang.s}
                                        {elseif $i.a!=0}{$lang.a}
                                        {elseif $i.b!=0}{$lang.b}
                                        {elseif $i.t!=0}{$lang.t}
                                        {elseif $i.p4!=0}{$lang.p4}
                                        {elseif $i.p5!=0}{$lang.p5}
                                        {/if}
                                    {/if}
                                </span>
                                </div>
                            </div>
                            <div class="product-description">
                                <div class="some-padding"></div>
                                {specs var="awords" string=$i.description}
                                {*{$i.description}*}
                                {foreach from=$awords item=prod name=lla key=k}
                                    <ul>
                                    {if $prod.specs} 
                                        {foreach from=$prod.specs item=feat name=ll key=ka}
                                            <li>
                                                <strong>{$feat[1]}</strong>
                                                <span >{$feat[0]}</span>
                                            </li>
                                        {/foreach}
                                    {/if}
                                    
                                    </ul>
                                    {if $prod.features} 
                                        {$prod.features}
                                    {/if}
                                {/foreach}
                                {if !$flabels}
                                    {assign var=flabels value=$awords}
                                {/if}
                                {assign var=awords value=false}
                            </div>
                            <div class="product-actions">
                                <a href="#" class="btn" onclick="changeProduct({$i.id});return false;">{$lang.ordernow}</a>
                            </div>
                            <div class="shadow-left"><img src="{$orderpage_dir}onestep_fancy/shadow-left.png" /></div>
                            <div class="shadow-right"><img src="{$orderpage_dir}onestep_fancy/shadow-right.png" /></div>
                        </div>
                    {/foreach}
                    <div class="left-labels">
                        
                        {foreach from=$flabels item=prod name=lla key=k}
                            <ul>
                            {if $prod.specs} 
                                {foreach from=$prod.specs item=feat name=ll key=ka}
                                    <li {if $smarty.foreach.ll.last}class="last"{/if}>
                                       <i><b>#</b></i> {$feat[0]}
                                    </li>
                                {/foreach}
                            {/if}
                            </ul>
                        {/foreach}
                        
                    </div>
                    <div class="clear"></div>
                </div>
                {literal}
                <script type="text/javascript">
                    var poss = $(".product-description ul:first").offset()
                    if($(".product-description ul:first").parents('.product-container').hasClass('active')){
                        poss.left += 14;
                        poss.top += 5;
                    }
                    $(".left-labels").offset({top:poss.top, left:poss.left-$(".left-labels").width()});
                    var maxrows = 0;
                    $(".product-container").each(function(){
                        var rows = $("li, .product-actions", this);
                        rows.each(function(i){
                            if(i % 2 != 0)
                            $(this).addClass('odd');
                        });
                        if(rows.length > maxrows)
                            maxrows = rows.length;
                    });
                    $(".product-container").each(function(){
                        var rows = $("li, .product-actions", this);
                        if(rows.length < maxrows){
                            if(rows.length == 1){
                                $(".product-description", this).append('<ul></ul>');
                                var ul = $("ul:last", this);
                                var alt = '';
                            }else{
                                var ul = $("ul:last", this);
                                var alt = ul.children('li:last').hasClass('odd') ? '' : 'odd';
                            }
                            for(var i = 0; i < maxrows - rows.length; i++ ){
                                ul.append('<li class="'+alt+'" />')
                                alt = alt=='odd' ? '' : 'odd';
                            }
                            if(!$(".product-actions", this).hasClass('odd') == (alt == 'odd')){
                                if(alt == 'odd')
                                    $(".product-actions", this).addClass('odd');
                                else
                                    $(".product-actions", this).removeClass('odd');
                            }
                        }     
                    });
                    $('.shadow-left img, .shadow-right img').height($('.product-container.active').height()+35);
                    $('.shadow-left').css('left',-15-((($('.product-container.active').height()-350) / 100)*2));
                    $('.shadow-right').css('right',-15-((($('.product-container.active').height()-350) / 100)*2))
                </script>
                {/literal}
            {else}
                {foreach from=$categories item=i name=categories name=cats}
                    {if $i.id == $current_cat} 
                        <strong>{$i.name}</strong> {if !$smarty.foreach.cats.last}|{/if}
                    {else} 
                        <a href="{$ca_url}cart&amp;step={$step}&amp;cat_id={$i.id}{if $addhosting}&amp;addhosting=1{/if}">{$i.name}</a> {if !$smarty.foreach.cats.last}|{/if}
                    {/if}
                {/foreach}
                {if $logged=='1'} 
                    {if $current_cat=='addons'} | <strong>{$lang.prodaddons}</strong>
                    {else} | <a href="{$ca_url}cart&amp;step={$step}&amp;cat_id=addons">{$lang.prodaddons}</a>
                    {/if}
                {/if}
            {/if}
        {/if}
    </div>
    {if $opconfig.description}
    <div class="custom-thing">
        <div class="right product-actions">
            <a class="btn go-to-ticket right" href="?cmd=tickets&action=new">{$lang.contactus}!</a>
        </div>
        {$opconfig.description}
        <div class="clear"></div>
    </div>
    {/if}
    <div id="configer">
        {include file='ajax.onestep_fancy.tpl'}
    </div>
    <form action="?cmd=cart&cat_id={$current_cat}" method="post" id="orderform" onsubmit="return mainsubmit(this)">
        {if $gateways}
            <div id="gatewayform" {if $tax && $tax.total==0}style="display:none"{elseif $credit && $credit.total==0}style="display:none"{elseif $subtotal.total==0}style="display:none"{/if}>
                {$gatewayhtml}
            </div>
            <div class="clear"></div>
        {/if}
        <input type="hidden" name="make" value="order" />
        {if $logged=="1"}
            <h3 class="modern modern-client">{$lang.ContactInfo}</h3>
            <div class="newbox1">
                {include file="drawclientinfo.tpl"}
            </div>
        {else}
            <div class="newbox1header">
                <h3 class="modern modern-client">{$lang.ContactInfo}</h3>
                <ul class="wbox_menu tabbme">
                    <li {if !isset($submit) || $submit.cust_method=='newone'}class="t1 on"{else}class="t1"{/if} onclick="{literal}ajax_update('index.php?cmd=signup',{layer:'ajax'},'#updater',true);$(this).parent().find('li.t2').removeClass('on');$(this).addClass('on');{/literal}" >

                        {$lang.newclient}</li>
                    <li {if $submit.cust_method=='login'}class="t2 on"{else}class="t2"{/if} onclick="{literal}ajax_update('index.php?cmd=login',{layer:'ajax'},'#updater',true);$(this).parent().find('li.t1').removeClass('on');$(this).addClass('on');{/literal}">
                        {$lang.alreadyclient}
                    </li>
                </ul>
            </div>
            <div class="newbox1">
                <div id="updater" >
                    {if $submit.cust_method=='login'}
                        {include file='ajax.login.tpl}
                    {else}
                        {include file='ajax.signup.tpl}
                    {/if} 
                </div>
            </div>
        {/if}
        <div class="newbox1header">
            <h3 class="modern modern-note">{$lang.cart_add}</h3>
        </div>
        <div class="newbox1">
            <textarea id="c_notes" {if !$submit.notes}onblur="if (this.value=='')this.value='{$lang.c_tarea}';" onfocus="if(this.value=='{$lang.c_tarea}')this.value='';"{/if} style="width:98%" rows="3"  name="notes">{if $submit.notes}{$submit.notes}{else}{$lang.c_tarea}{/if}</textarea>
        </div>
        <p align="right">
            <br />
            {if $tos}
                <input type="checkbox" value="1" name="tos"/> {$lang.tos1} <a href="{$tos}" target="_blank">{$lang.tos2}</a>
            {/if}
            <a href="#" onclick="$('#orderform').submit();return false;" id="checksubmit-cu">{$lang.checkout}</a>
        </p>
    </form>
</div>