{include file='cart_bookshelf/cart.progress.tpl'}
{include file='cart_bookshelf/cart.summary.tpl'}
<div class="left left-column">
    <form action="" method="post" id="cart3">
        {if $product.paytype=='Once' || $product.paytype=='Free'}

            <div class="line-header clearfix first"><h3>{$product.name}</h3></div>
            <div id="product_description">
                {if $product.paytype=='Free'}<br />
                    <input type="hidden" name="cycle" value="Free" />
                    {$lang.price} <strong>{$lang.free}</strong>
                {elseif $product.paytype=='Once'}<br />
                    <input type="hidden" name="cycle" value="Once" />
                    {$lang.price}  <strong>{$product.m|price:$currency}</strong> {$lang.once} / {$product.m_setup|price:$currency} {$lang.setupfee}
                {/if}
            </div>
        {/if}

        {if   $product.type=='Dedicated' || $product.type=='Server' || $product.hostname || $custom || ($product.paytype!='Once' && $product.paytype!='Free')}

            <div class="line-header clearfix first"><h3>{$lang.config_options}</h3></div>
            <table cellspacing="0" cellpadding="0" border="0" width="100%" class="styled form-horizontal product-items">
                <colgroup class="firstcol"></colgroup>
                <colgroup class="alternatecol"></colgroup>

                {if $product.paytype!='Once' && $product.paytype!='Free'}
                    <tr>
                        <td class="pb10"><strong>{$lang.pickcycle}</strong></td>
                        <td class="pb10">
                            {price product=$product}
                            <select name="cycle"   onchange="{if $custom}changeCycle('#cart3');{else}simulateCart('#cart3');{/if}" style="width:99%">
                                <option value="@@cycle" @@selected>@@line</option>
                            </select>
                            {/price}
                        </td>
                    </tr>
                {/if}
            </table>
            <div class="line-header clearfix"><h3>{$lang.serviceconfiguration}</h3></div>
            <table cellspacing="0" cellpadding="0" border="0" width="100%" class="styled form-horizontal product-items">
                {if $product.hostname}
                    <tr>
                        <td class="pb10 cf-name"><strong>{$lang.hostname}</strong> *</td>
                        <td class="pb10"><input name="domain" value="{$item.domain}" class="styled" size="50" style="width:96%"/></td>	
                    </tr>
                {/if}

                {if $custom}
                    <input type="hidden" name="custom[-1]" value="dummy" />
                    {foreach from=$custom item=cf} 
                        {if $cf.items}
                            <tr>
                                <td class="cf-name"><strong>{$cf.name} {if $cf.options & 1}*{/if}</strong></td>
                                <td colspan="2" >
                                    {if $cf.description!=''}<div class="fs11 descr" style="">{$cf.description}</div>
                                    {/if}
                                    {include file=$cf.configtemplates.cart}
                                </td>
                            </tr>
                        {/if}
                    {/foreach}
                {/if}
            </table>
            <small>{$lang.field_marked_required}</small>
        {/if}

        {if $subproducts}
            <div class="line-header clearfix"><h3>{$lang.additional_services}</h3></div>

            <table cellspacing="0" cellpadding="0" border="0" width="100%" class="styled form-horizontal product-items">
                <colgroup class="firstcol"></colgroup>
                <colgroup class="alternatecol"></colgroup>
                <colgroup class="firstcol"></colgroup>

                {foreach from=$subproducts item=a key=k}
                    <tr>
                        <td width="20"><input name="subproducts[{$k}]" type="checkbox" value="1" {if $selected_subproducts.$k}checked="checked"{/if}  onchange="simulateCart('#cart3');"/></td>
                        <td>
                            <strong>{$a.category_name} - {$a.name}</strong>
                        </td>
                        <td class="last">
                            {price product=$a}
                                {if $a.paytype=='Free'}
                                    {$lang.free}
                                    <input type="hidden" name="subproducts_cycles[{$k}]" value="free"/>
                                {elseif $a.paytype=='Once'}
                                    <input type="hidden" name="subproducts_cycles[{$k}]" value="once"/>
                                    @@line
                                {else}
                                    <select name="subproducts_cycles[{$k}]"   onchange="if ($('input[name=\'subproducts[{$k}]\']').is(':checked'))simulateCart('#cart3');">
                                        <option value="@@cycle" @@selected>@@line</option>
                                    </select>
                                {/if}
                                {/price}
                                <span class="prod-desc">{$a.description}</span>
                        </td>
                    </tr>
                {/foreach}
            </table>
        {/if}

        {if $addons}

            <div class="line-header clearfix"><h3>{$lang.addons_single}</h3></div>
            <p>{$lang.addons_single_desc}</p>
            <table cellspacing="0" cellpadding="0" border="0" width="100%" class="styled product-items form-horizontal">
                <colgroup class="firstcol"></colgroup>
                <colgroup class="alternatecol"></colgroup>
                <colgroup class="firstcol"></colgroup>

                {foreach from=$addons item=a key=k}
                    <tr class="{if $a.description!=''}less-padding{/if}" >
                        <td width="20"><input name="addon[{$k}]" type="checkbox" value="1" {if $selected_addons.$k}checked="checked"{/if}  onchange="simulateCart('#cart3');"/></td>
                        <td>
                            <strong>{$a.name}</strong>
                        </td>
                        <td class="last">
                            {price product=$a}
                            {if $a.paytype=='Free'}
                                {$lang.free}
                                <input type="hidden" name="addon_cycles[{$k}]" value="free"/>
                            {elseif $a.paytype=='Once'}
                                <input type="hidden" name="addon_cycles[{$k}]" value="once"/>
                                @@line
                            {else}
                                <select name="addon_cycles[{$k}]"   onchange="if ($('input[name=\'addon[{$k}]\']').is(':checked')) simulateCart('#cart3');">
                                    <option value="@@cycle" @@selected>@@line</option>
                                </select>
                            {/if}
                            {/price}
                        </td>
                    </tr>
                    {if $a.description!=''} 
                        <tr>
                            <td colspan="6" style="padding: 0;"><p>{$a.description}</p></td>
                        </tr>
                    {/if}
                {/foreach}
            </table>
        {/if}
        <input name='action' value='addconfig' type='hidden' /><br />

    </form>
</div>
<a href="#" onclick="$('#cart3').submit(); return false;" class="big-btn clear"> {$lang.continue} &raquo;</a>
{include file='cart_bookshelf/cart.footer.tpl'}