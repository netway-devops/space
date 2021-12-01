{*
@@author:: HostBill team
@@name:: One-step checkout slider, hand-drawn
@@description::  A One-Step checkout, with hand-drawn icons & page elements, where your client can pick package, configure it, add domains, addons, config options and signup, all on one page.
Great combination of slider to pick product and checkout on one page - you use this theme with large (5+) number of products.
@@thumb:: images/oneste_slider_draw_thumb.png
@@img:: images/oslider_draw_preview.png
*}
<div id="onestepcontainer" class="modified">
    <div id="ppicker" style="position:relative">

        {if $current_cat!='addons' && $current_cat!='transfer' && $current_cat!='register'}

            {if $products}
                <input id="pidi" value="0" type="hidden" />
                <script src="{$template_dir}js/jquery-ui-1.8.2.custom.min.js" type="text/javascript"></script>
                <script src="{$orderpage_dir}onestep_slider/cufon.js" type="text/javascript"></script>
                <script src="{$orderpage_dir}onestep_slider/daniel_400.font.js" type="text/javascript"></script>
                <script type="text/javascript">
                    Cufon.replace('.bubble');
                    {literal}
                        function mainsubmit(formel) {
                            var v = $('input[name="gateway"]:checked');
                            if (v.length > 0) {
                                $(formel).append("<input type='hidden' name='gateway' value='" + v.val() + "' />");
                            }
                            if ($('input[name=domain]').length > 0 && $('input[name=domain]').attr('type') != 'radio')
                                $(formel).append("<input type='hidden' name='domain' value='" + $('input[name=domain]').val() + "' />");

                            return true;
                        }

                        function onsubmit_2() {
                            $('#load-img').show();
                            ajax_update('index.php?cmd=cart&' + $('#domainform2').serialize(), {layer: 'ajax'}, '#configer');
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
                                ajax_update('index.php?cmd=checkdomain&action=checkdomain&product_id=' + $('#product_id').val() + '&product_cycle=' + $('#product_cycle').val() + '&' + $('.tld_register').serialize(), {layer: 'ajax', sld: $('#sld_register').val()}, '#updater2', true);
                            } else if ($("input[value='illtransfer']").is(':checked')) {
                                //transfer
                                ajax_update('index.php?cmd=checkdomain&action=checkdomain&transfer=true&sld=' + $('#sld_transfer').val() + '&tld=' + $('#tld_transfer').val() + '&product_id=' + $('#product_id').val() + '&product_cycle=' + $('#product_cycle').val(), {layer: 'ajax'}, '#updater2', true);
                            } else if ($("input[value='illupdate']").is(':checked')) {
                                ajax_update('index.php?cmd=cart&domain=illupdate&sld_update=' + $('#sld_update').val() + '&tld_update=' + $('#tld_update').val(), {layer: 'ajax'}, '#configer');
                                $('#load-img').show();
                            } else if ($("input[value='illsub']").is(':checked')) {
                                ajax_update('index.php?cmd=cart&domain=illsub&sld_subdomain=' + $('#sld_subdomain').val(), {layer: 'ajax'}, '#configer');
                                $('#load-img').show();
                            }

                            return false;
                        }
                        function applyCoupon() {
                            var f = $('#promoform').serialize();
                            ajax_update('?cmd=cart&addcoupon=true&' + f, {}, '#configer');
                            return false;
                        }
                        function simulateCart(forms, domaincheck) {
                            $('#load-img').show();
                            var urx = '?cmd=cart&';
                            if (domaincheck)
                                urx += '_domainupdate=1&';
                            ajax_update(urx, $(forms).serializeArray(), '#configer');
                        }
                        function removeCoupon() {

                            ajax_update('?cmd=cart&removecoupon=true', {}, '#configer');
                            return false;
                        }
                        function changeProduct(pid) {
                            if (pid == $('#pidi').val())
                                return;
                            $('#pidi').val(pid);

                            $('#errors').slideUp('fast', function() {
                                $(this).find('span').remove();
                            });
                            $('#load-img').show();
                            $.post('?cmd=cart&cat_id={/literal}{$current_cat}{literal}', {id: pid}, function(data) {
                                var r = parse_response(data);

                                $('#configer').html(r);
                            });
                        }


                        function bindSlider() {
                            $('.slix li').each(function(n) {
                                $(this).click(function() {
                                    scrollToEl(n);
                                    changeProduct($(this).attr('rel'));
                                    return false;
                                });
                            });
                            $('.bubble', '#ppicker').each(function(n) {
                                var ob = $('.slix li', '#ppicker').eq(n);
                                var o = ob.position();
                                var dif = Math.abs(Math.floor((ob.width() - $(this).width()) / 2));
                                var dif2 = (ob.width() - $(this).width());

                                if (dif2 > 0) {
                                    $(this).css({
                                        top: o.top + 95,
                                        left: o.left + dif - 17
                                    });
                                } else {
                                    $(this).css({
                                        top: o.top + 95,
                                        left: o.left - dif - 17
                                    });
                                }
                            });
                            $('#slider').width($('.slix').width() - 40);
                            $('#slider').slider({min: 0, max: ($('.slix li').length - 1) + 0.3, value: 0, step: 0.1, range: "min", animate: true, stop: function(e, ui) {
                                    slidCb(true);

                                }, change: function(e, ui) {
                                    slidCb(false);
                                }, slide: function(e, ui) {
                                    slidCb(false);
                                }
                            });
                        }
                        function slidCb(magic) {
                            var x = Math.floor($('#slider').slider("value"));
                            $('.slix li').removeClass('active');
                            $('.bubble').removeClass('active');
                            $('.descriptionx').hide();
                            $('.descriptionx').eq(x).show();
                            for (var a = 0; a < x + 1; a++) {
                                $('.slix li').eq(a).addClass('active');

                            }
                            $('.bubble').hide().eq(x).show();
                            if (magic) {
                                changeProduct($(this).attr('rel') ? $(this).attr('rel') : $('li.active:last').attr('rel'));
                            }
                        }
                        function scrollToEl(ele) {
                            $('#slider').slider("value", ele);
                            slidCb(false);

                        }
                        appendLoader('bindSlider');
                    {/literal}
                    {if $product}
                        {foreach from=$products item=i name=loop key=k}
                            {if $i.id==$product.id}
                                {literal}function slide1x() {
                                        scrollToEl({/literal}{$k}{literal});
                                    }
                                    appendLoader('slide1x');
                                {/literal}
                            {/if}
                        {/foreach}
                    {/if}
                </script>

                {foreach from=$products item=i name=loop key=k}
                    <div class="bubble"  rel="{$i.id}" {if $i.id==$product.id}style="display:block"{/if}>
                        {$i.name}
                    </div>		
                {/foreach}

                <div class="shead">
                    <div class="spicked">
                        {foreach from=$categories item=i name=categories}

                    {if $i.id == $current_cat} <strong>{$i.name}</strong>{/if}{/foreach}

                </div>
                <div class="snpicked">
                    {foreach from=$categories item=i name=categories name=cats}

                        {if $i.id != $current_cat}
                            <a href="{$ca_url}cart/{$i.slug}/&amp;step={$step}{if $addhosting}&amp;addhosting=1{/if}">{$i.name}</a> {if !$smarty.foreach.cats.last}|{/if}
                        {/if}
                    {/foreach}


{if $logged=='1'} | {if $current_cat=='addons'}<strong>{else}<a href="{$ca_url}cart&amp;step={$step}&amp;cat_id=addons">{/if}{$lang.prodaddons}{if $current_cat=='addons'}</strong>{else}</a>{/if}{/if}



</div>
<div class="clear"></div>
</div>
<div class="slidebg">
    {if count($currencies)>1}
        <div class="right p19 p_cont">
            <form action="" method="post" id="currform">
                <input name="action" type="hidden" value="changecurr">
                {$lang.Currency} <select name="currency" class="styled span2" onchange="$('#currform').submit()">
                    {foreach from=$currencies item=crx}
                        <option value="{$crx.id}" {if !$selcur && $crx.id==0}selected="selected"{elseif $selcur==$crx.id}selected="selected"{/if}>{if $crx.code}{$crx.code}{else}{$crx.iso}{/if}</option>
                    {/foreach}
                </select>
            </form></div>
        {/if}
    <div class="innerx" style="padding-bottom:45px;">
        <center>
            <ul class="slix slix2" style="width:{math equation="65 * y" y=$products|@count}px">
                {foreach from=$products item=i name=loop key=k}
                    <li {if $k=='0'}class="active"{/if} rel="{$i.id}">{$i.name}</li>		
                    {/foreach}
            </ul>
        </center>





        <center>
            <div class="slides slides2" id="slider">	
                <div class="sl"></div>
                <div class="sr"></div>		
            </div>
        </center>
        <div class="clear"></div>
    </div>


</div>



{else}
    {foreach from=$categories item=i name=categories name=cats}

    {if $i.id == $current_cat} <strong>{$i.name}</strong> {if !$smarty.foreach.cats.last}|{/if}
{else} <a href="{$ca_url}cart&amp;step={$step}&amp;cat_id={$i.id}{if $addhosting}&amp;addhosting=1{/if}">{$i.name}</a> {if !$smarty.foreach.cats.last}|{/if}
{/if}
{/foreach}

{if $logged=='1'} | {if $current_cat=='addons'}<strong>{else}<a href="{$ca_url}cart&amp;step={$step}&amp;cat_id=addons">{/if}{$lang.prodaddons}{if $current_cat=='addons'}</strong>{else}</a>{/if}{/if}


{/if}

{/if}

</div>




<div id="configer">
    {include file='ajax.onestep_slide.tpl'}

</div>





<form action="?cmd=cart&cat_id={$current_cat}" method="post" id="orderform" onsubmit="return mainsubmit(this)">
    <input type="hidden" name="make" value="order" />

    {if $gateways}
        <div id="gatewayform" {if $tax && $tax.total==0}style="display:none"{elseif $credit && $credit.total==0}style="display:none"{elseif $subtotal.total==0}style="display:none"{/if}>
            {$gatewayhtml}
        </div>
        <div class="clear"></div>
    {/if}




    {if $logged=="1"}
        <h3 class="modern"><span></span>{$lang.ContactInfo}</h3>
        <div class="newbox1">



            {include file="drawclientinfo.tpl"}



        </div>


    {else}


        <div class="newbox1header">
            <h3 class="modern"><span></span>{$lang.ContactInfo}</h3>

            <ul class="wbox_menu tabbme">
                <li {if !isset($submit) || $submit.cust_method=='newone'}class="t1 on"{else}class="t1"{/if} onclick="{literal}ajax_update('index.php?cmd=signup', {layer: 'ajax'}, '#updater', true);
                                        $(this).parent().find('li.t2').removeClass('on');
                                        $(this).addClass('on');{/literal}" >

                    {$lang.newclient}</li>
                <li {if $submit.cust_method=='login'}class="t2 on"{else}class="t2"{/if} onclick="{literal}ajax_update('index.php?cmd=login', {layer: 'ajax'}, '#updater', true);
                                        $(this).parent().find('li.t1').removeClass('on');
                                        $(this).addClass('on');{/literal}"}>
                    {$lang.alreadyclient}</li>
            </ul>
        </div>
        <div class="newbox1">


            <div id="updater" >{if $submit.cust_method=='login'}
                {include file='ajax.login.tpl'}
            {else}
                {include file='ajax.signup.tpl'}
            {/if} </div>

    </div>



    {/if}



        <div class="newbox1header">
            <h3 class="modern"><span></span>{$lang.cart_add}</h3>
        </div>

        <div class="newbox1">
            <textarea id="c_notes" {if !$submit.notes}onblur="if (this.value == '')
                                            this.value = '{$lang.c_tarea}';" onfocus="if (this.value == '{$lang.c_tarea}')
                                            this.value = '';"{/if} style="width:98%" rows="3"  name="notes">{if $submit.notes}{$submit.notes}{else}{$lang.c_tarea}{/if}</textarea>
        </div>


        <p align="right">
            <br />

            {if $tos}
                <input type="checkbox" value="1" name="tos"/> {$lang.tos1} <a href="{$tos}" target="_blank">{$lang.tos2}</a>
            {/if}



            <a href="#" onclick="$('#orderform').submit();
                                        return false;" id="checksubmit">{$lang.checkout}</a>
        </p>




    </form>


</div>