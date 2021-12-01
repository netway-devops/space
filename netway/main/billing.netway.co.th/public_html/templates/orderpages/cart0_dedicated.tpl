{if $custom_overrides.cart0_dedicated}
    {include file=$custom_overrides.cart0_dedicated}
{else}
    <link href="{$orderpage_dir}default/cart.css" rel="stylesheet" type="text/css"/>
    <div class="orderpage cart-dedicated">
        <h3>{$lang.browseprod}</h3>

        <div class="categories">
            <div class="category-list">
                {foreach from=$categories item=i name=categories name=cats}
                    <div class="category">
                        {if $i.id == $current_cat}
                            <strong>{$i.name}</strong>
                        {else}
                            <a href="{$ca_url}cart/{$i.slug}/&amp;step={$step}{if $addhosting}&amp;addhosting=1{/if}">{$i.name}</a>
                        {/if}
                    </div>
                {/foreach}
                {if $logged=='1'}
                    <div class="category">
                        {if $current_cat=='addons'}
                            <strong>{$lang.prodaddons}</strong>
                        {else}
                            <a href="{$ca_url}cart&amp;step={$step}&amp;cat_id=addons">{$lang.prodaddons}</a>
                        {/if}
                    </div>
                {/if}
            </div>


            {foreach from=$categories item=i name=categories name=cats}
                {if $i.id == $current_cat && $i.description!=''}
                    <div class="category-description">{$i.description}</div>
                {/if}
            {/foreach}
        </div>

        {if $current_cat!='addons' && $current_cat!='transfer' && $current_cat!='register'}
            {if $products}
                {if count($currencies)>1}
                    <form action="" method="post" id="currform">
                        <div class="currency">
                            <input name="action" type="hidden" value="changecurr">
                            {$lang.Currency} <select name="currency" class="styled span2" onchange="$('#currform').submit()">
                                {foreach from=$currencies item=crx}
                                    <option value="{$crx.id}" {if !$selcur && $crx.id==0}selected="selected"{elseif $selcur==$crx.id}selected="selected"{/if}>{if $crx.code}{$crx.code}{else}{$crx.iso}{/if}</option>
                                {/foreach}
                            </select>
                        </div>
                    </form>
                {/if}

                <div class="product-list-header serv_head1">
                    <table border="0" width="100%">
                        <tr>
                            <td class="list-header list-header-service">{$lang.service}</td>
                            <td class="list-header list-header-setupfee">{$lang.setupfee}</td>
                            <td class="list-header list-header-price">{$lang.price}</td>
                        </tr>
                    </table>
                </div>

                {foreach from=$products item=i}
                    <form name="" action="" method="post">
                        <input name="action" type="hidden" value="add">
                        <input name="id" type="hidden" value="{$i.id}">
                        <div class="orderbox sh1a">
                            <div class="product orderboxpadding" style="">
                                <table width="100%">
                                    <tbody>
                                        <tr>
                                            <td class="product-name" >
                                                <img src="{$orderpage_dir}default/img/more_info.gif" alt=""/>
                                                <strong>{$i.name}</strong>
                                            </td>
                                            {price product=$i first=true}
                                            {if $i.paytype=='Free'}
                                                <td class="product-setup">
                                                    -
                                                </td>
                                                <td class="product-price">
                                                    {$lang.Free}
                                                </td>
                                                <td class="product-full-price" >
                                                    {$lang.Free}
                                                </td>
                                            {elseif $i.paytype=='Once'}
                                                <td class="product-setup">
                                                    <input type="hidden" name="cycle" value="Once" />
                                                    @@setup @@setup!=-@
                                                </td>
                                                <td class="product-price">
                                                    @@price
                                                </td>
                                                <td class="product-full-price" >
                                                    @@line
                                                </td>
                                            {else}
                                                <td class="product-setup">
                                                    @@setup @@setup!=-@
                                                </td>
                                                <td class="product-price">
                                                    @@price
                                                </td>
                                                <td class="product-full-price" >
                                                    @@line
                                                </td>
                                            {/if}
                                            {/price}
                                        </tr>
                                    </tbody>
                                </table>
                            </div>
                            <div style="display:none" id="hid_{$i.id}" class="product-details subdesc_">
                                <table width="100%" cellspacing="2">
                                    <tr>
                                        <td class="product-config">
                                            {price product=$i}
                                            {if $i.paytype=='Free'}
                                                <h3>{$lang.Free}</h3>
                                            {elseif $i.paytype=='Once'}
                                                <span>@@line</span>
                                                {if $i.free_tlds.Once}<span class="freedomain">{$lang.freedomain}</span>{/if}
                                            {else}
                                                <label class="product-cycle">
                                                    <span>{$lang.pickcycle}</span>
                                                    <select  name="cycle" style="margin:4px 0px;">
                                                        <option value="@@cycle">@@line</option>
                                                    </select>
                                                </label>
                                            {/if}
                                            {/price}
                                            <div class="product-submit">
                                                <button type="submit" class="padded btn" {if $i.out_of_stock}disabled="disabled"{/if}>{if $i.out_of_stock}{$lang.out_of_stock_btn}{else}{$lang.ordernow}{/if}</button>
                                            </div>
                                        </td>
                                        <td class="product-description">
                                            {if $i.description!=''}{$i.description}
                                            {/if}
                                        </td>
                                    </tr>
                                </table>
                            </div>
                        </div>
                    </form>
                {/foreach}
            {/if}
        {/if}
    </div>
{/if}