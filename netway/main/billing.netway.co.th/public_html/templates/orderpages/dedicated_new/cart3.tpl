{php}
$templatePath   = $this->get_template_vars('template_path');
include(dirname($templatePath) . '/orderpages/cart3.tpl.php');
{/php}
{literal}
    <script type="text/javascript">
        $(function(){
            function flyingSidemenu() {
                setTimeout(function(){
                    $('#right').height($('.cart-summary').outerHeight(true));
                    $(window).scroll(_slide);
                },450);
            }
            flyingSidemenu();
        });
    </script>
{/literal}
<div class="left clearfix">
    <h2><strong>{$lang.configuration}</strong></h2>
    <div class="separator"></div>
    <form id="config_form" method="post" action="">
        <input type="hidden" name="step" value="{$step}" />
        <input type="hidden" name="action" value="addconfig" />
        <div class="order-step">
            <div class="circle-header clearfix">
                <div>{counter name=step}</div>
                <h5 class="glyph-config">{$lang.config_options}</h5>
            </div>
            <div class="step-content">
                <div class="cart-option clearfx">
                    {if $product.paytype!='Once' && $product.paytype!='Free'}
                        {price product=$product}
                        <div class="option-title">
                            <strong>{$lang.pickcycle}</strong>
                        </div>
                        <div>
                            <select name="cycle"   onchange="{if $custom}changeCycle('#config_form');{else}simulateCart('#cart3');{/if}" style="width:98%">
                                <option value="@@cycle" @@selected>@@line</option>
                            </select>
                        </div>
                        {/price}
                    {/if}
                    {if $product.hostname}
                        <div class="option-title">
                            <strong>{$lang.hostname}:</strong>
                        </div>
                        <div>
                            <input name="domain" value="{$item.domain}" class="styled" size="50" style="width:96%"/>
                        </div>
                    {/if}
                </div>
                {if $subproducts}
                    <div class="cart-option clearfx">
                        <div class="option-title">
                            <strong>{$lang.additional_services}</strong>
                        </div>
                        <div>
                            <table cellspacing="0" cellpadding="0" border="0" width="100%" class="styled">
                                <colgroup class="firstcol"></colgroup>
                                <colgroup class="alternatecol"></colgroup>
                                <colgroup class="firstcol"></colgroup>

                                {foreach from=$subproducts item=a key=k}
                                    <tr>
                                        <td width="20"><input name="subproducts[{$k}]" type="checkbox" value="1" {if $selected_subproducts.$k}checked="checked"{/if}  onchange="simulateCart('#cart3');"/></td>
                                        <td>
                                            <strong>{$a.category_name} - {$a.name}</strong>
                                        </td>
                                        <td>
                                            {if $a.paytype=='Free'}
                                                {$lang.free}
                                                <input type="hidden" name="subproducts_cycles[{$k}]" value="free"/>
                                            {elseif $a.paytype=='Once'}
                                                <input type="hidden" name="subproducts_cycles[{$k}]" value="once"/>
                                            {$a.m|price:$currency} {$lang.once} {if $a.m_setup!=0}/ {$a.m_setup|price:$currency} {$lang.setupfee}{/if}
                                        {else}
                                            <select name="subproducts_cycles[{$k}]"   onchange="if($('input[name=\'subproducts[{$k}]\']').is(':checked'))simulateCart('#cart3');">
                                                {if $a.h!=0}<option value="h" {if $cycle=='h'} selected="selected"{/if}>{$a.h|price:$currency} {$lang.h}{if $a.h_setup!=0} + {$a.h_setup|price:$currency} {$lang.setupfee}{/if}</option>{/if}
                                                {if $a.d!=0}<option value="d" {if $cycle=='d'} selected="selected"{/if}>{$a.d|price:$currency} {$lang.d}{if $a.d_setup!=0} + {$a.d_setup|price:$currency} {$lang.setupfee}{/if}</option>{/if}
                                                {if $a.w!=0}<option value="w" {if $cycle=='w'} selected="selected"{/if}>{$a.w|price:$currency} {$lang.w}{if $a.w_setup!=0} + {$a.w_setup|price:$currency} {$lang.setupfee}{/if}</option>{/if}
                                                {if $a.m!=0}<option value="m" {if $cycle=='m'} selected="selected"{/if}>{$a.m|price:$currency} {$lang.m}{if $a.m_setup!=0} + {$a.m_setup|price:$currency} {$lang.setupfee}{/if}</option>{/if}
                                                {if $a.q!=0}<option value="q" {if $cycle=='q'} selected="selected"{/if}>{$a.q|price:$currency} {$lang.q}{if $a.q_setup!=0} + {$a.q_setup|price:$currency} {$lang.setupfee}{/if}</option>{/if}
                                                {if $a.s!=0}<option value="s" {if $cycle=='s'} selected="selected"{/if}>{$a.s|price:$currency} {$lang.s}{if $a.s_setup!=0} + {$a.s_setup|price:$currency} {$lang.setupfee}{/if}</option>{/if}
                                                {if $a.a!=0}<option value="a" {if $cycle=='a'} selected="selected"{/if}>{$a.a|price:$currency} {$lang.a}{if $a.a_setup!=0} + {$a.a_setup|price:$currency} {$lang.setupfee}{/if}</option>{/if}
                                                {if $a.b!=0}<option value="b" {if $cycle=='b'} selected="selected"{/if}>{$a.b|price:$currency} {$lang.b}{if $a.b_setup!=0} + {$a.b_setup|price:$currency} {$lang.setupfee}{/if}</option>{/if}
                                                {if $a.t!=0}<option value="t" {if $cycle=='t'} selected="selected"{/if}>{$a.t|price:$currency} {$lang.t}{if $a.t_setup!=0} + {$a.t_setup|price:$currency} {$lang.setupfee}{/if}</option>{/if}
                                                {if $a.p4!=0}<option value="p4" {if $cycle=='p4'} selected="selected"{/if}>{$a.p4|price:$currency} {$lang.p4}{if $a.p4_setup!=0} + {$a.p4_setup|price:$currency} {$lang.setupfee}{/if}</option>{/if}
                                                {if $a.p5!=0}<option value="p5" {if $cycle=='p5'} selected="selected"{/if}>{$a.p5|price:$currency} {$lang.p5}{if $a.p5_setup!=0} + {$a.p5_setup|price:$currency} {$lang.setupfee}{/if}</option>{/if}
                                            </select>
                                        {/if}
                                    </td>
                                </tr>
                            {/foreach}
                        </table>
                    </div>
                </div>
            {/if}
            {if $addons}
                <div class="cart-option clearfx">
                    <div class="option-title">
                        <strong>{$lang.addons_single}</strong>
                    </div>
                    <div>
                        <p>{$lang.addons_single_desc}</p>
                        <table cellspacing="0" cellpadding="0" border="0" width="100%" class="styled">
                            <colgroup class="firstcol"></colgroup>
                            <colgroup class="alternatecol"></colgroup>
                            <colgroup class="firstcol"></colgroup>

                            {foreach from=$addons item=a key=k}
                                <tr><td width="20"><input name="addon[{$k}]" type="checkbox" value="1" {if $selected_addons.$k}checked="checked"{/if}  onchange="simulateCart('#cart3');"/></td>
                                    <td>
                                        <strong>{$a.name}</strong>{if $a.description!=''} - {$a.description}{/if}
                                    </td>
                                    <td>
                                        {if $a.paytype=='Free'}
                                            {$lang.free}
                                            <input type="hidden" name="addon_cycles[{$k}]" value="free"/>
                                        {elseif $a.paytype=='Once'}
                                            <input type="hidden" name="addon_cycles[{$k}]" value="once"/>
                                        {$a.m|price:$currency} {$lang.once} {if $a.m_setup!=0}/ {$a.m_setup|price:$currency} {$lang.setupfee}{/if}
                                    {else}
                                        <select name="addon_cycles[{$k}]"   onchange="if($('input[name=\'addon[{$k}]\']').is(':checked'))simulateCart('#cart3');">
                                            {if $a.h!=0}<option value="h" {if $cycle=='h'} selected="selected"{/if}>{$a.h|price:$currency} {$lang.h}{if $a.h_setup!=0} + {$a.h_setup|price:$currency} {$lang.setupfee}{/if}</option>{/if}
                                            {if $a.d!=0}<option value="d" {if $cycle=='d'} selected="selected"{/if}>{$a.d|price:$currency} {$lang.d}{if $a.d_setup!=0} + {$a.d_setup|price:$currency} {$lang.setupfee}{/if}</option>{/if}
                                            {if $a.w!=0}<option value="w" {if $cycle=='w'} selected="selected"{/if}>{$a.w|price:$currency} {$lang.w}{if $a.w_setup!=0} + {$a.w_setup|price:$currency} {$lang.setupfee}{/if}</option>{/if}
                                            {if $a.m!=0}<option value="m" {if $cycle=='m'} selected="selected"{/if}>{$a.m|price:$currency} {$lang.m}{if $a.m_setup!=0} + {$a.m_setup|price:$currency} {$lang.setupfee}{/if}</option>{/if}
                                            {if $a.q!=0}<option value="q" {if $cycle=='q'} selected="selected"{/if}>{$a.q|price:$currency} {$lang.q}{if $a.q_setup!=0} + {$a.q_setup|price:$currency} {$lang.setupfee}{/if}</option>{/if}
                                            {if $a.s!=0}<option value="s" {if $cycle=='s'} selected="selected"{/if}>{$a.s|price:$currency} {$lang.s}{if $a.s_setup!=0} + {$a.s_setup|price:$currency} {$lang.setupfee}{/if}</option>{/if}
                                            {if $a.a!=0}<option value="a" {if $cycle=='a'} selected="selected"{/if}>{$a.a|price:$currency} {$lang.a}{if $a.a_setup!=0} + {$a.a_setup|price:$currency} {$lang.setupfee}{/if}</option>{/if}
                                            {if $a.b!=0}<option value="b" {if $cycle=='b'} selected="selected"{/if}>{$a.b|price:$currency} {$lang.b}{if $a.b_setup!=0} + {$a.b_setup|price:$currency} {$lang.setupfee}{/if}</option>{/if}
                                            {if $a.t!=0}<option value="t" {if $cycle=='t'} selected="selected"{/if}>{$a.t|price:$currency} {$lang.t}{if $a.t_setup!=0} + {$a.t_setup|price:$currency} {$lang.setupfee}{/if}</option>{/if}
                                            {if $a.p4!=0}<option value="p4" {if $cycle=='p4'} selected="selected"{/if}>{$a.p4|price:$currency} {$lang.p4}{if $a.p4_setup!=0} + {$a.p4_setup|price:$currency} {$lang.setupfee}{/if}</option>{/if}
                                            {if $a.p5!=0}<option value="p5" {if $cycle=='p5'} selected="selected"{/if}>{$a.p5|price:$currency} {$lang.p5}{if $a.p5_setup!=0} + {$a.p5_setup|price:$currency} {$lang.setupfee}{/if}</option>{/if}
                                         </select>
                                   {/if}
                                </td>
                            </tr>
                        {/foreach}
                    </table>
                </div></div>
            {/if}
    </div>
</div>
{if $custom}
    <input type="hidden" name="custom[-1]" value="dummy" />
    {foreach from=$custom item=cf}
        {if $cf.category == 'server'}
            <div class="order-step">
                <div class="circle-header clearfix">
                    <div>{counter name=step}</div>
                    <h5 class="glyph-server">{$lang.serverconfiguration}</h5>
                </div>
                <div class="step-content">
                    {foreach from=$custom item=cf}
                        {if $cf.category == 'server'}
                            {include file='dedicated_new/cart_customfields.tpl' cf=$cf}
                        {/if}
                    {/foreach}
                    <div class="content-arrow"><div></div></div>
                </div>
            </div>
            {break}
        {/if}
    {/foreach}
    {foreach from=$custom item=cf}
        {if $cf.category == 'network'}
            <div class="order-step">
                <div class="circle-header clearfix">
                    <div>{counter name=step}</div>
                    <h5 class="glyph-network">{$lang.networkconfiguration}</h5>
                </div>
                <div class="step-content">
                    {foreach from=$custom item=cf}
                        {if $cf.category == 'network'}
                            {include file='dedicated_new/cart_customfields.tpl' cf=$cf}
                        {/if}
                    {/foreach}
                    <div class="content-arrow"><div></div></div>
                </div>
            </div>
            {break}
        {/if}
    {/foreach}
    {foreach from=$custom item=cf}
        {if $cf.category == 'software'}
            <div class="order-step">
                <div class="circle-header clearfix">
                    <div>{counter name=step}</div>
                    <h5 class="glyph-software">{$lang.software}</h5>
                </div>
                <div class="step-content">
                    {foreach from=$custom item=cf}
                        {if $cf.category == 'software'}
                            {include file='dedicated_new/cart_customfields.tpl' cf=$cf}
                        {/if}
                    {/foreach}
                    <div class="content-arrow"><div></div></div>
                </div>
            </div>
            {break}
        {/if}
    {/foreach}
    {foreach from=$custom item=cf}
        {if $cf.category != 'software' && $cf.category != 'network' &&  $cf.category != 'server'}
            <div class="order-step">
                <div class="circle-header clearfix">
                    <div>{counter name=step}</div>
                    <h5 class="glyph-other">{$lang.other}</h5>
                </div>
                <div class="step-content">
                    {foreach from=$custom item=cf}
                        {if $cf.category != 'software' && $cf.category != 'network' &&  $cf.category != 'server'}
                            {include file='dedicated_new/cart_customfields.tpl' cf=$cf}
                        {/if}
                    {/foreach}
                    <div class="content-arrow"><div></div></div>
                </div>
            </div>
            {break}
        {/if}
    {/foreach}
{/if}
</form>
</div>
<div class="right clearfix">
    <h3>{$lang.cart}<strong>{$lang.summary}</strong></h3>
    <div id="right">
        <div class="cart-summary" >
            <div id="cartSummary">
                {include file='ajax.cart_dedicated_new.tpl'}
            </div>
        </div> 
    </div>
    <div class="separator"></div>
    <a class="btn btn-success btn-order btn-order-big" href="#" onclick="$('#config_form').submit(); return false;">{$lang.continue}</a>
</div>
<script language="JavaScript">
{literal}
$(document).ready( function () {
    $("[name='{/literal}{$namefreemonitor}{literal}']").prop('checked',true);
    $("[name='{/literal}{$namefreemonitor}{literal}']").attr('onclick','return false;');
    $("[name='{/literal}{$namefreemonitor}{literal}']").css('opacity','0.5');
    
});
{/literal}
</script>
