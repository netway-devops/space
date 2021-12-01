<link href="{$orderpage_dir}default/cart.css" rel="stylesheet" type="text/css"/>

<section class="section-account-header d-flex flex-row justify-content-between align-items-center">
    <h1>{$lang.browseprod}</h1>
    {include file="`$template_path`components/cart/cart.currencies.tpl"}
</section>

{include file="`$template_path`components/cart/cart.nav.tpl"}

<section class="section-cart cart-dedicated">
    {if $current_cat!='addons' && $current_cat!='transfer' && $current_cat!='register'}
        {if $products}
            <div class="card p-0">
                <div class="card-header d-flex flex-row justify-content-between">
                    <div class="w-50">{$lang.service}</div>
                    <div class="w-50 d-flex flex-row justify-content-between">
                        <div style="flex-basis: 33.33333%">{$lang.setupfee}</div>
                        <div class="text-center" style="flex-basis: 33.33333%">{$lang.reccuringprice}</div>
                        <div  class="text-right" style="flex-basis: 33.33333%">{$lang.price}</div>
                    </div>
                </div>
                <div class="card-body p-0">
                    {foreach from=$products item=i}
                        <div class="card accordion m-0 no-borders">
                            <form name="" action="" method="post">
                                <div class="card-header cursor-pointer d-flex flex-row justify-content-between"  data-toggle="collapse" data-target="#cart_{$i.id}" aria-expanded="false" aria-controls="#cart_{$i.id}">
                                    <div class="w-50">
                                        <i class="material-icons icon-info-color mr-3">add</i>
                                        <strong>{$i.name}</strong>
                                    </div>
                                    <div class="w-50 d-flex flex-row justify-content-between">
                                        {price product=$i first=true}
                                        {if $i.paytype=='Free'}
                                            <div style="flex-basis: 33.33333%">
                                                -
                                            </div>
                                            <div class="text-center" style="flex-basis: 33.33333%">
                                                {$lang.Free}
                                            </div>
                                            <div class="text-right" style="flex-basis: 33.33333%" >
                                                {$lang.Free}
                                            </div>
                                        {elseif $i.paytype=='Once'}
                                            <div style="flex-basis: 33.33333%">
                                                <input type="hidden" name="cycle" value="Once" />
                                                @@setup @@setup!=-@
                                            </div>
                                            <div class="text-center" style="flex-basis: 33.33333%">
                                                @@price
                                            </div>
                                            <div class="text-right" style="flex-basis: 33.33333%" >
                                                @@line
                                            </div>
                                        {else}
                                            <div style="flex-basis: 33.33333%">
                                                @@setup @@setup!=-@
                                            </div>
                                            <div class="text-center" style="flex-basis: 33.33333%">
                                                @@price
                                            </div>
                                            <div class="text-right" style="flex-basis: 33.33333%" >
                                                @@line
                                            </div>
                                        {/if}
                                        {/price}
                                    </div>
                                </div>
                                <div class="transaparent collapse fade" id="cart_{$i.id}" aria-labelledby="#cart_parent_{$i.id}">
                                    <div class="card-body text-small">
                                        <div class="d-flex flex-column flex-md-row justify-content-between align-items-center">
                                            <div class="d-flex flex-column align-items-start">
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
                                                            <option value="@@cycle" @@selected>@@line</option>
                                                        </select>
                                                    </label>
                                                {/if}
                                                {/price}
                                                {if $i.description!=''}{$i.description}{/if}
                                            </div>
                                            <button type="submit" class="btn  my-2 {if $i.out_of_stock} disabled btn-default {else}btn-primary{/if}" {if $i.out_of_stock}disabled="disabled"{/if}>{if $i.out_of_stock}{$lang.out_of_stock_btn}{else}{$lang.ordernow}{/if}</button>
                                        </div>
                                        <input name="action" type="hidden" value="add">
                                        <input name="id" type="hidden" value="{$i.id}">
                                    </div>
                                </div>
                            </form>
                        </div>
                    {/foreach}
                </div>
            </div>
        {/if}
    {/if}
</section>
