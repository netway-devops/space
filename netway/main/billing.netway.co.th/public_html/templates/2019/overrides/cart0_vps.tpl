<link href="{$orderpage_dir}default/cart.css" rel="stylesheet" type="text/css"/>

<section class="section-account-header d-flex flex-row justify-content-between align-items-center">
    <h1>{$lang.browseprod}</h1>
    {include file="`$template_path`components/cart/cart.currencies.tpl"}
</section>

{include file="`$template_path`components/cart/cart.nav.tpl"}

{if $current_cat!='addons' && $current_cat!='transfer' && $current_cat!='register'}
    {if $products}
        <div class="row">
            {foreach from=$products item=i name=loop}
                <div class="col-md-6 col-12 mt-4">
                    <form name="" action="" method="post" class="bordered-section p-4">
                        <input name="action" type="hidden" value="add">
                        <input name="id" type="hidden" value="{$i.id}">
                        <div class="d-flex flex-column justify-content-start align-items-start">
                            <strong class="mb-3">{$i.name}</strong>
                            {if $i.description}
                                <div class="my-3">{$i.description}</div>
                            {/if}
                            {price product=$i}
                            {if $i.paytype=='Free'}
                                <input type="hidden" name="cycle" value="Free" />
                                {$lang.price}:
                                <div>{$lang.Free}</div>
                            {elseif $i.paytype=='Once'}
                                <input type="hidden" name="cycle" value="Once" />
                                {$lang.price}:
                                <div>@@line</div>
                            {else}
                                <select name="cycle" class="form-control">
                                    <option value="@@cycle" @@selected>@@line</option>
                                </select>
                            {/if}
                            {/price}
                            <button type="submit" class="btn  mt-3 {if $i.out_of_stock} disabled btn-default {else}btn-success{/if}" {if $i.out_of_stock}disabled="disabled"{/if}>{if $i.out_of_stock}{$lang.out_of_stock_btn}{else}{$lang.ordernow}{/if}</button>
                        </div>
                    </form>
                </div>
            {/foreach}
        </div>
    {else}
        <div class="d-flex flex-row justify-content-center">{$lang.nothing}</div>
    {/if}
{/if}