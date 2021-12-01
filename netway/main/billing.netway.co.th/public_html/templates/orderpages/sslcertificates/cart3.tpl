<link media="all" type="text/css" rel="stylesheet" href="{$orderpage_dir}sslcertificates/style.css" />
{include file='sslcertificates/cprogress.tpl'}

<div class="blue-pad">
    <h4>{$lang.step} 4</h4>
    <h3>{$lang.config_options}</h3>
</div>

<div id="right" class="right step-summary">
    <div style="position:relative;">
        <div id="floater" style="position:absolute;" class="step-summary">
            <div class="white-box smaller">
                <h3>{$lang.cartsum1}</h3>
                <div class="strike-line"></div>
                <div id="cartSummary"> 
                    {include file='ajax.cart.summary.tpl'}
                </div>
            </div>
        </div>
    </div>
</div>
<a href="#" class="btn btn-custom right" style="clear:right" onclick="$('#cart3').submit();return false;" >{$lang.continuetostep} 5 &raquo;</a>
<script type="text/javascript">
    flyingSidemenu();
</script>
<div id="left" class="step-config">
    <form action="" method="post" id="cart3">
        <input name='action' value='addconfig' type='hidden' />
        <div class="white-box">
            <h3>{$lang.serviceconfiguration}</h3>
            <div class="strike-line"></div>
            
            <table cellspacing="0" cellpadding="0" border="0" width="100%" class="styled form-horizontal">
                <colgroup class="firstcol"></colgroup>
                <colgroup class="alternatecol"></colgroup>
                {if $product.paytype=='Free'}
                    <tr>
                        <td><strong>{$product.name}</strong></td>
                        <td>
                            {$lang.price} <strong>{$lang.free}</strong>
                            <input type="hidden" name="cycle" value="Free" />
                        </td>
                    </tr>
                {elseif $product.paytype=='Once'}<br />
                    <tr>
                        <td><strong>{$product.name}</strong></td>
                        <td>
                            {$lang.price}  <strong>{$product.m|price:$currency}</strong> 
                            {$lang.once} / {$product.m_setup|price:$currency} {$lang.setupfee}
                            <input type="hidden" name="cycle" value="Once" />
                        </td>
                    </tr>
                {else}
                    <tr>
                        <td class="pb10"  width="175">
                            <strong>{$lang.chooseperiod}</strong>
                        </td>
                        <td class="pb10">
                            <select name="cycle"   onchange="{if $custom}changeCycle('#cart3');{else}simulateCart('#cart3');{/if}" style="width:99%">
                                {if $product.a!=0}
                                    <option value="a" {if $cycle=='a'} selected="selected"{/if}> 1 {$lang.years} - {$product.a|price:$currency}{if $product.a_setup!=0}  + {$product.a_setup|price:$currency} {$lang.setupfee}{/if} {if $product.free_tlds.cycles.Annually}{$lang.freedomain}{/if}</option>
                                {/if}
                                {if $product.b!=0}
                                    <option value="b" {if $cycle=='b'} selected="selected"{/if}> 2 {$lang.years} - {$product.b|price:$currency}{if $product.b_setup!=0} + {$product.b_setup|price:$currency} {$lang.setupfee}{/if} {if $product.free_tlds.cycles.Biennially}{$lang.freedomain}{/if}</option>
                                {/if}
                                {if $product.t!=0}
                                    <option value="t" {if $cycle=='t'} selected="selected"{/if}> 3 {$lang.years} - {$product.t|price:$currency}{if $product.t_setup!=0} + {$product.t_setup|price:$currency} {$lang.setupfee}{/if} {if $product.free_tlds.cycles.Triennially}{$lang.freedomain}{/if}</option>
                                {/if}
                                {if $product.p4!=0}
                                    <option value="p4" {if $cycle=='p4'} selected="selected"{/if}> 4 {$lang.years} - {$product.p4|price:$currency}{if $product.p4_setup!=0} + {$product.p4_setup|price:$currency} {$lang.setupfee}{/if} {if $product.free_tlds.cycles.Quadrennially}{$lang.freedomain}{/if}</option>
                                {/if}
                                {if $product.p5!=0}
                                    <option value="p5" {if $cycle=='p5'} selected="selected"{/if}> 5 {$lang.years} - {$product.p5|price:$currency}{if $product.p5_setup!=0} + {$product.p5_setup|price:$currency} {$lang.setupfee}{/if} {if $product.free_tlds.cycles.Quinquennially}{$lang.freedomain}{/if}</option>
                                {/if}
                            </select>
                        </td>
                    </tr>
                {/if}

                {if $custom || ($product.paytype!='Once' && $product.paytype!='Free')}
                    {if $custom} <input type="hidden" name="custom[-1]" value="dummy" />
                        {foreach from=$custom item=cf key=ck} 
                            {if $cf.items}
                                <tr>
                                    <td colspan="2" class="{$cf.key} cf_option">
                                        <label for="custom[{$cf.id}]" class="styled">{$cf.name} {if $cf.options & 1}*{/if}</label>
                                        {if $cf.description!=''}
                                            <div class="fs11 descr" style="">{$cf.description}</div>
                                        {/if}
                                        {include file=$cf.configtemplates.cart}
                                    </td>
                                </tr>
                            {/if}
                        {/foreach}
                    {/if}
                    {if $subproducts}
                        <input type="hidden" name="subproducts[0]" value="0" />
                        {foreach from=$subproducts item=a key=k}
                            <tr>
                                <td>
                                    <input name="subproducts[{$k}]" type="checkbox" value="1" {if $selected_subproducts.$k}checked="checked"{/if}  onclick="simulateCart('#cart3');"/>
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
                                    <select name="subproducts_cycles[{$k}]"   onchange="if($('input[name=\'subproducts[{$k}]\']').is(':checked'))simulateCart('#cart2');">
                                        {if $a.h!=0}
                                            <option value="h" {if (!$contents[4][$k] && $cycle=='h') || $contents[4][$k].recurring=='h'} selected="selected"{/if}>{$a.h|price:$currency} {$lang.h}{if $a.h_setup!=0} + {$a.h_setup|price:$currency} {$lang.setupfee}{/if}</option>
                                        {/if}
                                        {if $a.d!=0}
                                            <option value="d" {if (!$contents[4][$k] && $cycle=='d') || $contents[4][$k].recurring=='d'} selected="selected"{/if}>{$a.d|price:$currency} {$lang.d}{if $a.d_setup!=0} + {$a.d_setup|price:$currency} {$lang.setupfee}{/if}</option>
                                        {/if}
                                        {if $a.w!=0}
                                            <option value="w" {if (!$contents[4][$k] && $cycle=='w') || $contents[4][$k].recurring=='w'}  selected="selected"{/if}>{$a.w|price:$currency} {$lang.w}{if $a.w_setup!=0} + {$a.w_setup|price:$currency} {$lang.setupfee}{/if}</option>
                                        {/if}
                                        {if $a.m!=0}
                                            <option value="m" {if (!$contents[4][$k] && $cycle=='m') || $contents[4][$k].recurring=='m'}  selected="selected"{/if}>{$a.m|price:$currency} {$lang.m}{if $a.m_setup!=0} + {$a.m_setup|price:$currency} {$lang.setupfee}{/if}</option>
                                        {/if}
                                        {if $a.q!=0}
                                            <option value="q" {if (!$contents[4][$k] && $cycle=='q') || $contents[4][$k].recurring=='q'} selected="selected"{/if}>{$a.q|price:$currency} {$lang.q}{if $a.q_setup!=0} + {$a.q_setup|price:$currency} {$lang.setupfee}{/if}</option>
                                        {/if}
                                        {if $a.s!=0}
                                            <option value="s" {if (!$contents[4][$k] && $cycle=='s') || $contents[4][$k].recurring=='s'} selected="selected"{/if}>{$a.s|price:$currency} {$lang.s}{if $a.s_setup!=0} + {$a.s_setup|price:$currency} {$lang.setupfee}{/if}</option>
                                        {/if}
                                        {if $a.a!=0}
                                            <option value="a" {if (!$contents[4][$k] && $cycle=='a') || $contents[4][$k].recurring=='a'} selected="selected"{/if}>{$a.a|price:$currency} {$lang.a}{if $a.a_setup!=0} + {$a.a_setup|price:$currency} {$lang.setupfee}{/if}</option>
                                        {/if}
                                        {if $a.b!=0}
                                            <option value="b" {if (!$contents[4][$k] && $cycle=='b') || $contents[4][$k].recurring=='b'} selected="selected"{/if}>{$a.b|price:$currency} {$lang.b}{if $a.b_setup!=0} + {$a.b_setup|price:$currency} {$lang.setupfee}{/if}</option>
                                        {/if}
                                        {if $a.t!=0}
                                            <option value="t" {if (!$contents[4][$k] && $cycle=='t') || $contents[4][$k].recurring=='t'} selected="selected"{/if}>{$a.t|price:$currency} {$lang.t}{if $a.t_setup!=0} + {$a.t_setup|price:$currency} {$lang.setupfee}{/if}</option>
                                        {/if}
                                        {if $a.p4!=0}
                                            <option value="p4" {if (!$contents[4][$k] && $cycle=='p4') || $contents[4][$k].recurring=='p4'} selected="selected"{/if}>{$a.p4|price:$currency} {$lang.p4}{if $a.p4_setup!=0} + {$a.p4_setup|price:$currency} {$lang.setupfee}{/if}</option>
                                        {/if}
                                        {if $a.p5!=0}
                                            <option value="p5" {if (!$contents[4][$k] && $cycle=='p5') || $contents[4][$k].recurring=='p5'} selected="selected"{/if}>{$a.p5|price:$currency} {$lang.p5}{if $a.p5_setup!=0} + {$a.p5_setup|price:$currency} {$lang.setupfee}{/if}</option>
                                        {/if}
                                    </select>
                                {/if}
                            </td>
                        </tr>
                    {/foreach}
                {/if}
    {/if}
    </table>
    {if $custom || ($product.paytype!='Once' && $product.paytype!='Free')}
        <small>{$lang.field_marked_required}</small>
    {/if}
    </div>
    {if $addons}
        <div class="white-box">
            <h3>{$lang.addons_single}</h3>
            <div class="strike-line"></div>
            <p>{$lang.addons_single_desc}</p>
            <table cellspacing="0" cellpadding="0" border="0" width="100%" class="styled form-horizontal">
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
                                {if $a.h!=0}
                                    <option value="h" {if $cycle=='h'} selected="selected"{/if}>{$a.h|price:$currency} {$lang.h}{if $a.h_setup!=0} + {$a.h_setup|price:$currency} {$lang.setupfee}{/if}</option>
                                {/if}
                                {if $a.d!=0}
                                    <option value="d" {if $cycle=='d'} selected="selected"{/if}>{$a.d|price:$currency} {$lang.d}{if $a.d_setup!=0} + {$a.d_setup|price:$currency} {$lang.setupfee}{/if}</option>
                                {/if}
                                {if $a.w!=0}
                                    <option value="w" {if $cycle=='w'} selected="selected"{/if}>{$a.w|price:$currency} {$lang.w}{if $a.w_setup!=0} + {$a.w_setup|price:$currency} {$lang.setupfee}{/if}</option>
                                {/if}
                                {if $a.m!=0}
                                    <option value="m" {if $cycle=='m'} selected="selected"{/if}>{$a.m|price:$currency} {$lang.m}{if $a.m_setup!=0} + {$a.m_setup|price:$currency} {$lang.setupfee}{/if}</option>
                                {/if}
                                {if $a.q!=0}
                                    <option value="q" {if $cycle=='q'} selected="selected"{/if}>{$a.q|price:$currency} {$lang.q}{if $a.q_setup!=0} + {$a.q_setup|price:$currency} {$lang.setupfee}{/if}</option>
                                {/if}
                                {if $a.s!=0}
                                    <option value="s" {if $cycle=='s'} selected="selected"{/if}>{$a.s|price:$currency} {$lang.s}{if $a.s_setup!=0} + {$a.s_setup|price:$currency} {$lang.setupfee}{/if}</option>
                                {/if}
                                {if $a.a!=0}
                                    <option value="a" {if $cycle=='a'} selected="selected"{/if}>{$a.a|price:$currency} {$lang.a}{if $a.a_setup!=0} + {$a.a_setup|price:$currency} {$lang.setupfee}{/if}</option>
                                {/if}
                                {if $a.b!=0}
                                    <option value="b" {if $cycle=='b'} selected="selected"{/if}>{$a.b|price:$currency} {$lang.b}{if $a.b_setup!=0} + {$a.b_setup|price:$currency} {$lang.setupfee}{/if}</option>
                                {/if}
                                {if $a.t!=0}
                                    <option value="t" {if $cycle=='t'} selected="selected"{/if}>{$a.t|price:$currency} {$lang.t}{if $a.t_setup!=0} + {$a.t_setup|price:$currency} {$lang.setupfee}{/if}</option>
                                {/if}
                                {if $a.p4!=0}
                                    <option value="p4" {if $cycle=='p4'} selected="selected"{/if}>{$a.p4|price:$currency} {$lang.p4}{if $a.p4_setup!=0} + {$a.p4_setup|price:$currency} {$lang.setupfee}{/if}</option>
                                {/if}
                                {if $a.p5!=0}
                                    <option value="p5" {if $cycle=='p5'} selected="selected"{/if}>{$a.p5|price:$currency} {$lang.p5}{if $a.p5_setup!=0} + {$a.p5_setup|price:$currency} {$lang.setupfee}{/if}</option>
                                {/if}
                            </select>
                        {/if}
                    </td>
                </tr>       
            {/foreach}
        </table>
    </div>
{/if}
</div>
</form>

<div class="clear"></div>