<link media="all" type="text/css" rel="stylesheet" href="{$orderpage_dir}slide_step/style.css" />

<div class="order-step">
    <div class="circle-header clearfix">
        <div>1</div>
        <h3>{$lang.selectcategory} &nbsp; <img src="{$orderpage_dir}slide_step/arrow-head-down.gif" alt="Arrow" /></h3>
    </div>
    <div class="step-content">
        <ul class="category-list" style="margin-bottom: 10px;">    
            {foreach from=$categories item=i name=categories name=cats}
                {if $i.id == $current_cat}
                    <li><div class="title">{$i.name}</div></li>
                    {if !$smarty.foreach.cats.last}
                        <li class="sep"></li>
                    {/if}
                {/if}
            {/foreach}
            {counter name=dupli assign=dupli start=0 print=false}
            {foreach from=$categories item=i name=categories name=cats}
                
                {if $i.id != $current_cat}
                    {if !$smarty.foreach.cats.first && $dupli}
                        <li class="sep"></li>
                    {/if}
                    {counter name=dupli}
                    <li class="l_{$ka}">
                        <div class="title"><a href="{$ca_url}cart/{$i.slug}/&amp;step={$step}{if $addhosting}&amp;addhosting=1{/if}">{$i.name}</a></div>
                    </li>
                {/if}
            {/foreach}
        </ul>
        <div class="clear"></div>
    </div>
</div>
<div class="order-step">
    <div class="circle-header clearfix">
        <div>2</div>
        <h3>{$lang.quicksetup} &nbsp; <img src="{$orderpage_dir}slide_step/arrow-head-down.gif" alt="Arrow" /></h3>
    </div>
    <div class="step-content">
        <div class="product-container">
            <div class="cart-ribbon left clearfix">
                <div class="first-left">
                    <h2>{$lang.setupyourplan}</h2>
                </div>
                <div class="left"></div>
            </div>
            <p class="right italic-light" style="padding-top:10px">
                <img src="{$orderpage_dir}slide_step/quest.gif" alt="Info" /> 
                {$opconfig.info}
                
            </p>
            {if count($currencies)>1}
                <form action="" method="post" id="currform">
                    <input name="action" type="hidden" value="changecurr">
                    <p class="right" style="clear:right">
                        {$lang.Currency}
                        <select name="currency" class="styled span2" onchange="$('#currform').submit()" >
                            {foreach from=$currencies item=crx}
                                <option value="{$crx.id}" {if !$selcur && $crx.id==0}selected="selected"{elseif $selcur==$crx.id}selected="selected"{/if}>{if $crx.code}{$crx.code}{else}{$crx.iso}{/if}</option>
                            {/foreach}
                        </select>
                    </p>
                </form>
            {/if}
            <div class="clear"></div>
            <div class="cart-slider">
                <div class="cart-tooltip-area">
                    <div class="cart-tooltip">
                        <div class="cart-tooltip-grad">
                            {foreach from=$products item=i name=loop key=k}
                                <div {if !$smarty.foreach.loop.first}style="display:none"{/if}>{$i.name}</div>
                            {/foreach}

                        </div>
                        <div class="cart-tooltip-tail"></div>
                    </div>
                </div>
                <div id="slider" class="slider-bg">
                </div>
                <div class="product-list">
                    <table cellpadding="0" cellspacing="0">
                        <tr>
                            {foreach from=$products item=i name=loop key=k}
                                <td>
                                    <a href="#" rel="{$i.id}">
                                        <span></span>
                                        {$i.name}
                                    </a>
                                </td>
                            {/foreach}
                        </tr>
                    </table>
                </div>
            </div>
            <div style="clear: both"></div>
            <div class="info-out">
                <div class="price right">
                    <h2>{$lang.yourtotalprice}</h2>
                    {counter print=false start=0 name=productno assign=productno}
                    {foreach from=$products item=i name=loop key=k}
                        {counter name=productno}
                        <div {if !$smarty.foreach.loop.first}style="display:none"{/if}>
                            {if $i.paytype=='Free'}
                                {$lang.Free}
                            {elseif $i.paytype=='Once'}
                                <strong><sup>{$currency.sign}</sup>{$i.m|price:$currency:false}</strong> <em>{$lang.Once}</em>
                            {else}
                                {counter name=prices print=false start=0 assign=prices}
                                {if $i.d!=0}					
                                    <span class="cycle_d" {if $prices>0}style="display:none"{/if}{counter name=prices}><strong><sup>{$currency.sign}</sup>{$i.d|price:$currency:false}</strong> <em>{$lang.d}</em></span>
                                {/if}
                                {if $i.w!=0}
                                    <span class="cycle_w" {if $prices>0}style="display:none"{/if}{counter name=prices}><strong><sup>{$currency.sign}</sup>{$i.w|price:$currency:false}</strong> <em>{$lang.w}</em></span>
                                {/if}
                                {if $i.m!=0}
                                    <span class="cycle_m" {if $prices>0}style="display:none"{/if}{counter name=prices}><strong><sup>{$currency.sign}</sup>{$i.m|price:$currency:false}</strong> <em>{$lang.m}</em></span>
                                {/if}
                                {if $i.q!=0}
                                    <span class="cycle_q" {if $prices>0}style="display:none"{/if}{counter name=prices}><strong><sup>{$currency.sign}</sup>{$i.q|price:$currency:false}</strong> <em>{$lang.q}</em></span>
                                {/if}
                                {if $i.s!=0}
                                    <span class="cycle_s" {if $prices>0}style="display:none"{/if}{counter name=prices}><strong><sup>{$currency.sign}</sup>{$i.s|price:$currency:false}</strong> <em>{$lang.s}</em></span>
                                {/if}
                                {if $i.a!=0}
                                    <span class="cycle_a" {if $prices>0}style="display:none"{/if}{counter name=prices}><strong><sup>{$currency.sign}</sup>{$i.a|price:$currency:false}</strong> <em>{$lang.a}</em></span>
                                {/if}
                                {if $i.b!=0}
                                    <span class="cycle_b" {if $prices>0}style="display:none"{/if}{counter name=prices}><strong><sup>{$currency.sign}</sup><{$i.b|price:$currency:false}/strong> <em>{$lang.b}</em></span>
                                {/if}
                                {if $i.t!=0}
                                    <span class="cycle_t" {if $prices>0}style="display:none"{/if}{counter name=prices}><strong><sup>{$currency.sign}</sup>{$i.t|price:$currency:false}</strong> <em>{$lang.t}</em></span>
                                {/if}
                                {if $i.p4!=0}
                                    <span class="cycle_p4" {if $prices>0}style="display:none"{/if}{counter name=prices}><strong><sup>{$currency.sign}</sup>{$i.p4|price:$currency:false}</strong> <em>{$lang.p4}</em></span>
                                {/if}
                                {if $i.p5!=0}
                                    <span class="cycle_p4" {if $prices>0}style="display:none"{/if}{counter name=prices}><strong><sup>{$currency.sign}</sup>{$i.p5|price:$currency:false}</strong> <em>{$lang.p5}</em></span>
                                {/if}
                            {/if}	
                        </div>
                    {/foreach}
                </div>
                <div class="info left clearfix">
                    <h2 class="left">{$lang.planconfiguration}</h2>
                    {foreach from=$products item=i name=loop key=k}
                        {specs var="awords" string=$i.description}
                        <select name="cycle" style="display:none" class="cycle right" onchange="change_price(this);">
                            {if $i.paytype!='Free' &&$i.paytype!='Once'}
                            {if $i.h!=0}
                                <option value="h">{$i.h|price:$currency} {$lang.h}{if $i.h_setup!=0} + {$i.h_setup|price:$currency} {$lang.setupfee}{/if}{if $i.free_tlds.Hourly} {$lang.freedomain}{/if}</option>
                            {/if}
                            {if $i.d!=0}
                                <option value="d">{$i.d|price:$currency} {$lang.d}{if $i.d_setup!=0} + {$i.d_setup|price:$currency} {$lang.setupfee}{/if}{if $i.free_tlds.Daily} {$lang.freedomain}{/if}</option>
                            {/if}
                            {if $i.w!=0}
                                <option value="w">{$i.w|price:$currency} {$lang.w}{if $i.w_setup!=0} + {$i.w_setup|price:$currency} {$lang.setupfee}{/if} {if $i.free_tlds.Weekly}{$lang.freedomain}{/if}</option>
                            {/if}
                            {if $i.m!=0}
                                <option value="m">{$i.m|price:$currency} {$lang.m}{if $i.m_setup!=0} + {$i.m_setup|price:$currency} {$lang.setupfee}{/if} {if $i.free_tlds.Monthly}{$lang.freedomain}{/if}</option>
                            {/if}
                            {if $i.q!=0}
                                <option value="q">{$i.q|price:$currency} {$lang.q}{if $i.q_setup!=0} + {$i.q_setup|price:$currency} {$lang.setupfee}{/if} {if $i.free_tlds.Quarterly}{$lang.freedomain}{/if}</option>
                            {/if}
                            {if $i.s!=0}
                                <option value="s">{$i.s|price:$currency} {$lang.s}{if $i.s_setup!=0} + {$i.s_setup|price:$currency} {$lang.setupfee}{/if} {if $i.free_tlds.SemiAnnually}{$lang.freedomain}{/if}</option>
                            {/if}
                            {if $i.a!=0}
                                <option value="a">{$i.a|price:$currency} {$lang.a}{if $i.a_setup!=0} + {$i.a_setup|price:$currency} {$lang.setupfee}{/if} {if $i.free_tlds.Annually}{$lang.freedomain}{/if}</option>
                            {/if}
                            {if $i.b!=0}
                                <option value="b">{$i.b|price:$currency} {$lang.b}{if $i.b_setup!=0} + {$i.b_setup|price:$currency} {$lang.setupfee}{/if} {if $i.free_tlds.Biennially}{$lang.freedomain}{/if}</option>
                            {/if}
                            {if $i.t!=0}
                                <option value="t">{$i.t|price:$currency} {$lang.t}{if $i.t_setup!=0} + {$i.t_setup|price:$currency} {$lang.setupfee}{/if} {if $i.free_tlds.Triennially}{$lang.freedomain}{/if}</option>
                            {/if}
                            {if $i.p4!=0}
                                <option value="p4">{$i.p4|price:$currency} {$lang.p4}{if $i.p4_setup!=0} + {$i.p4_setup|price:$currency} {$lang.setupfee}{/if} {if $i.free_tlds.Quadrennially}{$lang.freedomain}{/if}</option>
                            {/if}
                            {if $i.p5!=0}
                                <option value="p5">{$i.p5|price:$currency} {$lang.p5}{if $i.p5_setup!=0} + {$i.p5_setup|price:$currency} {$lang.setupfee}{/if} {if $i.free_tlds.Quinquennially}{$lang.freedomain}{/if}</option>
                            {/if}
                            {/if}
                        </select>
                    {/foreach}
                    {foreach from=$awords item=j name=lla key=k}

                        <ul class="l_ul" {if $k!='0'}style="display:none"{/if}>
                            {if $j.specs} 
                                {foreach from=$j.specs item=i name=ll key=ka}

                                    <li class="l_{$ka}">
                                        <div class="title"><span>{$i[0]}</span></div>
                                        <div class="value"><span>{$i[1]}</span></div>
                                    </li>
                                    {if !$smarty.foreach.ll.last}
                                        <li class="sep"></li>
                                    {/if}
                                {/foreach}        
                            {/if}
                        </ul>
                    {/foreach}
                </div>
                <div style="clear: both"></div>
            </div>
        </div>
    </div>
</div>
<div class="order-step">
    <div class="circle-header clearfix">
        <div>3</div>
        <h3>{$lang.orderyourplan} &nbsp; <img src="{$orderpage_dir}slide_step/arrow-head-down.gif" alt="Arrow" /></h3>
    </div>
    <div class="step-content step-content-last">
        {if $opconfig.feature_first}
        <div class="left">
            <img class="mark" src="{$orderpage_dir}slide_step/mark.gif" alt="Valid" />
            {$opconfig.feature_first}
            
        </div>
        {/if}
        {if $opconfig.feature_second}
        <div class="left">
            <img class="mark" src="{$orderpage_dir}slide_step/mark.gif" alt="Valid" />
            {$opconfig.feature_second}
            
        </div>
        {/if}
        <div class="right cart-submit" onclick="$(this).children('form').submit(); return false;">
            <form action="{$ca_url}cart&amp;action=add&cat_id={$current_cat}" method="post">
                <input type="hidden" name="id" id="product_id" value="0" />
                <input type="hidden" name="cycle" id="product_cycle" value="" />
                {$lang.ordernow}
            </form>
        </div>
        <div class="clear"></div>
    </div>
    <div class="last-step italic-light">
        <img src="{$orderpage_dir}slide_step/quest.gif" alt="Info" /> 
        {$opconfig.footer}
        <div class="arrow-up"></div>
    </div>
</div>
{literal}
    <script type="text/javascript">
        if($('.info-out').width() < 830)
            $('.info-out').addClass('short');
        $('.info-out .info').width($('.info-out').width()-285);   
        if($('.info-out .info').width() < 545)
            $('.info-out .info').addClass('short');

        var stepsperp = 100;
        var prc = {/literal}{$productno}{literal};
        var max = prc*stepsperp;
        var borders = [];
        var values = [];

        $('#slider').slider({
            range: "min",
            value: 1,
            min: 1,
            max: max,
            animate:true,
            change: chose_product,
            slide: chose_product
        });

        $('.product-list td').css('width', (100/$('.product-list td').length) + '%').each(function(i){
            var w = $(this).outerWidth();
            borders[i] = [$(this).offset().left+w/2,$(this).offset().left+w];
            //$('<div style="position:absolute; width:0px; height:100px; border: 1px dotted green">').offset({top:450, left:$(this).offset().left}).appendTo('body');
            //$('<div style="position:absolute; width:0px; height:100px; border: 1px dotted red">').offset({top:450, left:$(this).offset().left+w}).appendTo('body');
            //$('<div style="position:absolute; width:0px; height:100px; border: 1px dotted green">').offset({top:450, left:$(this).offset().left+w/2}).appendTo('body');
        });

        var wwidth = $('#slider').width();
        var loffset = $('.ui-slider-range').offset().left;  


        for(var x = 0; x < borders.length; x++){
            for(var i = 0; i <= max; i++ ){
                var p = i/max;
                var a = loffset+(wwidth*p);
                if(values[x] == undefined)
                    values[x] = [];
                if(values[x][0] == undefined && borders[x][0] < a){
                    values[x][0] = i;
                }
                if(values[x][1] == undefined && borders[x][1] < a){
                    values[x][1] = i;
                }
                if(values[x][1] != undefined && values[x][0] != undefined)
                    break;
            }
            //$('<div style="position:absolute; width:0px; height:100px; border: 1px solid red">').offset({top:450, left:loffset+(wwidth*(values[x][0]/max))}).appendTo('body');
            //$('<div style="position:absolute; width:0px; height:100px; border: 1px solid blue">').offset({top:450, left:loffset+(wwidth*(values[x][1]/max))}).appendTo('body');
        }
        function fix_sep(){
            var pst = 0;
            $('.info-out .info .sep:visible').each(function(i){
                if(pst == 0) 
                    pst = $(this).position().top; 
                else if($(this).position().top > pst) {
                    pst = $(this).position().top; 
                    $('.info-out .info .sep:nth-child('+((i+1)*2)+')').hide(); 
                }
            });
            $('.info-out .info .value:visible span').each(function(){
                var par = $(this).parent().width()-5;
                while($(this).width() > par)
                    $(this).css({fontSize: parseInt($(this).css('font-size'))-1 + 'px'});
            })
        }
        function chose_product(a) {
            var p = $('#slider').slider( "value" );
            var node = false; 
            for(var x = 0; x < values.length; x++){
                if(p < values[x][1]){
                    node = true;
                    show_product(x);
                    break;
                }
            }
            if(!node)
                show_product(prc-1);
            var v = p/max;
            var a = loffset+(wwidth*v) -  $('.cart-tooltip').outerWidth()/2;
                $('.cart-tooltip').offset({left: a});
        } 

        function show_product(no){
            $('#product_id').val($('.product-list a').removeClass('active').eq(no).addClass('active').attr('rel'));
            
            $('.price div').hide().eq(no).show();
            $('.info ul').hide().eq(no).show();
            $('.info .cycle').hide();
                if($('.info .cycle:eq('+no+')').children().length > 1)
                    $('.info .cycle:eq('+no+')').show();
            $('#product_cycle').val($('.info .cycle:eq('+no+')').val());
            $('.cart-tooltip-grad div').hide().eq(no).show();
            //$('.product-list a').removeClass('active').eq(no).addClass('active');
            fix_sep();
        }
        function change_price(thi){
            $('.price div:visible span').hide().filter('.cycle_'+$(thi).val()).show();
            $('#product_cycle').val($(thi).val());
        }
        $('#slider').slider("value", values[0][0]);
        fix_sep();
        $('.product-list a').each(function(i){$(this).click(function(){
            $('#slider').slider("value", values[i][0]); return false;
        });});
        
    </script>
{/literal}