
{include file="cart_smartwizard/header.tpl"}
{include file="cart_smartwizard/cart.summary.tpl"}

<!-- Left Column -->
<div class="left-column left">
    <div class="cart-container-sw"> 

        <!-- Addons -->
        <form action="" method="post" id="cart3">
            <div>
                {if $product.paytype!='Once' && $product.paytype!='Free'}
                    <div class="option-row center">
                        <div class="option-box left">
                            <h4 class="openSansBold left">{$lang.config_options}</h4>
                            <div class="open-box right">
                                <a href="#" class="openSansBold">{$lang.Open}</a>
                                <div class="arrow-box">
                                    <span class="arrow-down"></span>
                                </div>
                            </div>
                        </div>

                        <div class="option-hidden-content left">
                            <p>
                                {$lang.pickcycle}
                                {price product=$product}
                            <select name="cycle"   onchange="{if $custom}changeCycle('#cart3');{else}simulateCart('#cart3');{/if}" style="width:99%">
                                <option value="@@cycle" @@selected>@@line</option>
                            </select>
                            {/price}
                            </p>
                        </div>
                    </div>
                {/if}
                {if $product.hostname}
                    <div class="option-row center">
                        <div class="option-box left">
                            <h4 class="openSansBold left">{$lang.hostname}*</h4>
                            <div class="open-box right">
                                <a href="#" class="openSansBold">{$lang.Open}</a>
                                <div class="arrow-box">
                                    <span class="arrow-down"></span>
                                </div>
                            </div>
                        </div>

                        <div class="option-hidden-content left">
                            <input name="domain" value="{$item.domain}" class="styled" size="50" style="width:96%"/>
                        </div>

                    </div>
                {/if}
                {if $subproducts}
                    {foreach from=$subproducts item=a key=k}
                        <div class="option-row center">
                            <div class="option-box left">
                                <h4 class="openSansBold left"> <input name="subproducts[{$k}]" type="checkbox" value="1" {if $selected_subproducts.$k}checked="checked"{/if}  onchange="simulateCart('#cart3');"/> {$a.category_name}</h4>
                                <p class="openSansRegular left">{$a.name}</p>
                                <div class="open-box right">
                                    <a href="#" class="openSansBold">{$lang.Open}</a>
                                    <div class="arrow-box">
                                        <span class="arrow-down"></span>
                                    </div>
                                </div>
                            </div>

                            <div class="option-hidden-content left form-horizontal">
                                <p>{$lang.billoptions}:
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
                                </p>
                            </div>

                        </div>
                    {/foreach}
                {/if}
                {if $addons}
                    {foreach from=$addons item=a key=k}
                        <div class="option-row center">
                            <div class="option-box left">
                                <h4 class="openSansBold left">
                                    <input name="addon[{$k}]" type="checkbox" value="1" {if $selected_addons.$k}checked="checked"{/if}  onchange="simulateCart('#cart3');"/> 
                                    {$a.name}
                                </h4>
                                <div class="open-box right">
                                    <a href="#" class="openSansBold">{$lang.Open}</a>
                                    <div class="arrow-box">
                                        <span class="arrow-down"></span>
                                    </div>
                                </div>
                            </div>

                            <div class="option-hidden-content left form-horizontal">
                                <p> {$lang.billoptions}:
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
                                </p>
                                {if $a.description!=''} 
                                    <p>{$a.description}</p>
                                {/if}
                            </div>
                        </div>
                    {/foreach}
                {/if}
                {if $custom}
                    {foreach from=$custom item=cf} 
                        <div class="option-row center clearfix">
                            <div class="option-box left">
                                <h4 class="openSansBold left">{$cf.name} {if $cf.options & 1}*{/if}</h4>
                                {*<p class="openSansRegular left">{$lang.none}</p>*}
                                <div class="open-box right">
                                    <a href="#" class="openSansBold">{$lang.Open}</a>
                                    <div class="arrow-box">
                                        <span class="arrow-down"></span>
                                    </div>
                                </div>
                            </div>

                            <div class="option-hidden-content left ">
                                <p>
                                {if $cf.description!=''}<div class="fs11 descr" style="">{$cf.description}</div>
                                {/if}
                                </p>
                                {include file=$cf.configtemplates.cart}
                            </div>
                        </div>
                    {/foreach}
                {/if}
                <input type="hidden" name="custom[-1]" value="dummy" />
                <input name='action' value='addconfig' type='hidden' />

            </div>
        </form>
        <!-- end -->
    </div>

    <div class="pagination-box">
        {include file='cart_smartwizard/pagination.tpl'}

        <div class="pagination-right-button right" onclick="$('#cart3').submit(); return false;">
            <span class="pag-arrow"></span>
            <span class="openSansBold">{$lang.next}</span>
        </div>
    </div>
</div>

<div class="clear"></div>