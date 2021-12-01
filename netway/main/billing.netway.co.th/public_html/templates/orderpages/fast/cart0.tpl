<link media="all" type="text/css" rel="stylesheet" href="{$orderpage_dir}fast/style.css" />
<h3 class="title-b">{$lang.browseprod}</h3>
<div class="menu-prod">
{foreach from=$categories item=i name=categories name=cats}
{if $i.id == $current_cat} <strong>{$i.name}</strong> {if !$smarty.foreach.cats.last}{/if}
{else} 
	<a href="{$ca_url}cart/{$i.slug}/&amp;step={$step}{if $addhosting}&amp;addhosting=1{/if}">{$i.name}</a> {if !$smarty.foreach.cats.last}{/if}
{/if}
{/foreach}

{if $logged=='1'} | {if $current_cat=='addons'}<strong>{else}<a href="{$ca_url}cart&amp;step={$step}&amp;cat_id=addons">{/if}{$lang.prodaddons}{if $current_cat=='addons'}</strong>{else}</a>{/if}{/if}
<br />
<div class="nw-host-border"></div>
<h3 class="title-b">
{foreach from=$categories item=i name=categories name=cats}
    {if $i.id == $current_cat && $i.description!=''}
        {$i.description}
    {/if}
{/foreach}
</h3>

</div>

{if $products}
    {if count($currencies)>1}
        <form action="" method="post" id="currform">
            <p align="right">
                <input name="action" type="hidden" value="changecurr">
                {$lang.Currency} <select name="currency" class="styled span2" onchange="$('#currform').submit()">
                    {foreach from=$currencies item=crx}
                        <option value="{$crx.id}" {if !$selcur && $crx.id==0}selected="selected"{elseif $selcur==$crx.id}selected="selected"{/if}>{if $crx.code}{$crx.code}{else}{$crx.iso}{/if}</option>
                    {/foreach}
                </select>
            </p>
        </form>
    {/if}
    {foreach from=$products item=i}
        <div class="product-container">
            <form name="" action="" method="post">
                <input name="action" type="hidden" value="add">
                <input name="id" type="hidden" value="{$i.id}">
                <div  class="left">
                    <h3>{$i.name}</h3>
                    {if $i.paytype=='Free'}
                        <h3>{$lang.Free}</h3>
                    {elseif $i.paytype=='Once'}
                        {$i.m|price:$currency} {$lang.once} 
                        {if $i.m_setup>0} 
                            + {$i.m_setup|price:$currency} {$lang.setupfee}
                        {/if}
                        {if $i.free_tlds.Once}
                            <span class="freedomain">{$lang.freedomain}</span>
                        {/if}
                    {else}
                        {$lang.pickcycle}<br />
                        <select name="cycle" style="margin:4px 0px;">
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
                        </select>
                    {/if} 
                </div>
                <div class="product-description">
                    <center>
                        <div style="display:inline-block; width:100%; text-align:left; padding-top:10px;">
                    {if $i.description!=''}
                        {$i.description}
                    {/if}
                        </div>
                    </center>
                </div>
                <div class="right product-actions">
                    <div class="product-price">
                    {if $i.paytype=='Free'}<input type="hidden" name="cycle" value="Free" /> {$lang.Free}
                    {elseif $i.paytype=='Once'}<input type="hidden" name="cycle" value="Once" />
                        {if $i.m>0}
                            {$i.m|price:$currency} {$lang.once} 
                            {if $i.m_setup>0} 
                                + {$i.m_setup|price:$currency} {$lang.setupfee}
                            {/if}
                        {else}{$lang.Free}
                        {/if}
                    {else}
                        {counter print=false start=0 name=pricedisp assign=pricedisp }
                        {if $i.h!='0.00'}<span {counter name=pricedisp}{if $pricedisp > 1}style="display:none"{/if}>{$i.h|price:$currency} / {$lang.h}{if $i.h_setup!=0} + {$i.h_setup|price:$currency} {$lang.setupfee}{/if}</span> {/if}
                        {if $i.d!='0.00'}<span {counter name=pricedisp}{if $pricedisp > 1}style="display:none"{/if}>{$i.d|price:$currency} / {$lang.d}{if $i.d_setup!=0} + {$i.d_setup|price:$currency} {$lang.setupfee}{/if}</span> {/if}
                        {if $i.w!='0.00'}<span {counter name=pricedisp}{if $pricedisp > 1}style="display:none"{/if}>{$i.w|price:$currency} / {$lang.w}{if $i.w_setup!=0} + {$i.w_setup|price:$currency} {$lang.setupfee}{/if}</span> {/if}
                        {if $i.m!='0.00'}<span {counter name=pricedisp}{if $pricedisp > 1}style="display:none"{/if}>{$i.m|price:$currency} / {$lang.m}{if $i.m_setup!=0} + {$i.m_setup|price:$currency} {$lang.setupfee}{/if}</span> {/if}
                        {if $i.q!='0.00'}<span {counter name=pricedisp}{if $pricedisp > 1}style="display:none"{/if}>{$i.q|price:$currency} / {$lang.q}{if $i.q_setup!=0} + {$i.q_setup|price:$currency} {$lang.setupfee}{/if}</span> {/if}
                        {if $i.s!='0.00'}<span {counter name=pricedisp}{if $pricedisp > 1}style="display:none"{/if}>{$i.s|price:$currency} / {$lang.s}{if $i.s_setup!=0} + {$i.s_setup|price:$currency} {$lang.setupfee}{/if}</span> {/if}
                        {if $i.a!='0.00'}<span {counter name=pricedisp}{if $pricedisp > 1}style="display:none"{/if}>{$i.a|price:$currency} / {$lang.a}{if $i.a_setup!=0} + {$i.a_setup|price:$currency} {$lang.setupfee}{/if}</span> {/if}
                        {if $i.b!='0.00'}<span {counter name=pricedisp}{if $pricedisp > 1}style="display:none"{/if}>{$i.b|price:$currency} / {$lang.b}{if $i.b_setup!=0} + {$i.b_setup|price:$currency} {$lang.setupfee}{/if}</span> {/if}
                        {if $i.t!='0.00'}<span {counter name=pricedisp}{if $pricedisp > 1}style="display:none"{/if}>{$i.t|price:$currency} / {$lang.t}{if $i.t_setup!=0} + {$i.t_setup|price:$currency} {$lang.setupfee}{/if}</span> {/if}
                        {if $i.p4!='0.00'}<span {counter name=pricedisp}{if $pricedisp > 1}style="display:none"{/if}>{$i.p4|price:$currency} / {$lang.p4}{if $i.p4_setup!=0} + {$i.p4_setup|price:$currency} {$lang.setupfee}{/if}</span> {/if}
                        {if $i.p5!='0.00'}<span {counter name=pricedisp}{if $pricedisp > 1}style="display:none"{/if}>{$i.p5|price:$currency} / {$lang.p5}{if $i.p5_setup!=0} + {$i.p5_setup|price:$currency} {$lang.setupfee}{/if}</span> {/if}
                        
                    {/if}
                    </div>
                    <input type="submit" value="{$lang.ordernow}" class="padded btn btn-primary"/>
                </div>
                <div class="clear"></div>
            </form>
        </div>
    {/foreach}
{else}
    <div class="product-container">{$lang.nothing}</div>
{/if}
<script type="text/javascript" >
{literal}
    var mwidth = 0;
    $('.product-description center > div').each(function(){
        var width = $(this).width();
        if(width > mwidth){
            mwidth = width;
        }
    });
    $('.product-description center > div').width(mwidth);
    $(function(){
        $('select[name="cycle"]').change(function(){
            $('.product-price span', $(this).parents('.product-container')).hide().eq(this.selectedIndex).show();
        });
    })
{/literal}
</script>
{if $opconfig.footer} 
<!-- display none  custom footer 
<div class="custom-footer" style="display:none;"> 
    <div class="right product-actions">
        <a class="btn go-to-ticket right" href="?cmd=tickets&action=new">{$lang.getintouch}!</a>
    </div>
   
    {$opconfig.footer}
    
    <div class="clear"></div>
</div>
-->
{/if}
<div>
    
</div>
