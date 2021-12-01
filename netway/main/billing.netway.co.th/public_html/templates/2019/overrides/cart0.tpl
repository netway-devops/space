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
                <div class="col-12 mt-4">
                    <form name="" action="" method="post" class="bordered-section p-4">
                        <input name="action" type="hidden" value="add">
                        <input name="id" type="hidden" value="{$i.id}">
                        <div class="row">
                            <div class="col-md-10 col-12">
                                <strong class="mb-3 text-primary">{$i.name}</strong>
                                {if $i.description}
                                    <div class="my-3">{$i.description}</div>
                                {/if}
                                <div class="my-4 row align-items-center">
                                    {price product=$i}
                                    {if $i.paytype=='Free'}
                                        <input type="hidden" name="cycle" value="Free" />
                                        <div class="col-md-2 col-12 font-weight-normal">{$lang.price}:</div>
                                        <div class="col-md-10 col-12 font-weight-bold">{$lang.FreeSummary}</div>
                                    {elseif $i.paytype=='Once'}
                                        <input type="hidden" name="cycle" value="Once" />
                                        <div class="col-md-2 col-12 font-weight-normal">{$lang.price}:</div>
                                        <div class="col-md-10 col-12 font-weight-bold">@@line</div>
                                    {else}
                                        <div class="col-md-2 col-12 font-weight-normal">{$lang.pickcycle}</div>
                                        <div class="col-md-10 col-12">
                                            <select name="cycle" class="form-control">
                                                <option value="@@cycle" @@selected>@@line</option>
                                            </select>
                                        </div>
                                    {/if}
                                    {/price}
                                </div>
                            </div>
                            <div class="col-md-2 col-12 w-100 d-flex align-items-center justify-content-center">
                                <button type="submit" class="btn  mt-3 {if $i.out_of_stock} disabled btn-default {else}btn-success{/if}" {if $i.out_of_stock}disabled="disabled"{/if}>{if $i.out_of_stock}{$lang.out_of_stock_btn}{else}{$lang.ordernow}{/if}</button>
                            </div>
                        </div>
                    </form>
                </div>
            {/foreach}
        </div>
    {else}
        <div class="text-center">
            <h3 class="mb-4">{$lang.noservicesyet}</h3>
            {if $adminlogged}
                <div>
                    <p class="mb-3">{$lang.noservicesyetadmin}</p>
                    {if !$categories}
                        <a class="btn btn-link mx-2" href="{$admin_url}/?cmd=configuration" target="_blank">{$lang.Configuration}</a>
                        <a class="btn btn-link mx-2" href="{$admin_url}/?cmd=services" target="_blank">{$lang.productsandservices}</a>
                        <a class="btn btn-link mx-2" href="{$admin_url}/?cmd=services&action=addcategory" target="_blank">{$lang.addneworpage}</a>
                    {else}
                        <a class="btn btn-link mx-2" href="{$admin_url}/?cmd=configuration" target="_blank">{$lang.Configuration}</a>
                        <a class="btn btn-link mx-2" href="{$admin_url}/?cmd=services" target="_blank">{$lang.productsandservices}</a>
                        <a class="btn btn-link mx-2" href="{$admin_url}/?cmd=services&action=product&id=new&cat_id={$current_cat}" target="_blank">{$lang.addnewproduct}</a>
                    {/if}
                </div>
            {/if}
        </div>
    {/if}
{elseif $current_cat=='addons'}
    {if $addons}
        <div class="row">
            {foreach from=$addons.addons item=i  key=k}
                <div class="col-12 mt-4">
                    <form name="" action="" method="post" class="bordered-section p-4">
                        <input name="action" type="hidden" value="add">
                        <input name="id" type="hidden" value="{$i.id}">
                        <div class="row">
                            <div class="col-md-10 col-12">
                                <strong class="mb-3 text-primary">{$i.name}</strong>
                                {if $i.description}
                                    <div class="my-3">{$i.description}</div>
                                {/if}
                                <dl class="my-4 row align-items-center">
                                    {if $i.paytype=='Free'}
                                        <input type="hidden" name="addon_cycles[{$k}]" value="free" />
                                        <dt class="col-md-2 col-12 font-weight-normal">{$lang.price}:</dt>
                                        <dd class="col-md-10 col-12 font-weight-bold">{$lang.FreeSummary}</dd>
                                    {elseif $i.paytype=='Once'}
                                        <input type="hidden" name="addon_cycles[{$k}]" value="once" />
                                        <dt class="col-md-2 col-12 font-weight-normal">{$lang.price}:</dt>
                                        <dd class="col-md-10 col-12 font-weight-bold">{$i.m|price:$currency} {$lang.once} / {$i.m_setup|price:$currency} {$lang.setupfee}</dd>
                                    {else}
                                        <dt class="col-md-2 col-12 font-weight-normal">{$lang.pickcycle}</dt>
                                        <dd class="col-md-10 col-12">
                                            <select name="addon_cycles[{$k}]" class="form-control">
                                                {if $i.h!=0}<option value="d" {if $cycle=='h'} selected="selected"{/if}>{$i.h|price:$currency} {$lang.h}{if $i.h_setup!=0} + {$i.h_setup|price:$currency} {$lang.setupfee}{/if}</option>{/if}
                                                {if $i.d!=0}<option value="d" {if $cycle=='d'} selected="selected"{/if}>{$i.d|price:$currency} {$lang.d}{if $i.d_setup!=0} + {$i.d_setup|price:$currency} {$lang.setupfee}{/if}</option>{/if}
                                                {if $i.w!=0}<option value="w" {if $cycle=='w'} selected="selected"{/if}>{$i.w|price:$currency} {$lang.w}{if $i.w_setup!=0} + {$i.w_setup|price:$currency} {$lang.setupfee}{/if}</option>{/if}
                                                {if $i.m!=0}<option value="m" {if $cycle=='m'} selected="selected"{/if}>{$i.m|price:$currency} {$lang.m}{if $i.m_setup!=0} + {$i.m_setup|price:$currency} {$lang.setupfee}{/if}</option>{/if}
                                                {if $i.q!=0}<option value="q" {if $cycle=='q'} selected="selected"{/if}>{$i.q|price:$currency} {$lang.q}{if $i.q_setup!=0} + {$i.q_setup|price:$currency} {$lang.setupfee}{/if}</option>{/if}
                                                {if $i.s!=0}<option value="s" {if $cycle=='s'} selected="selected"{/if}>{$i.s|price:$currency} {$lang.s}{if $i.s_setup!=0} + {$i.s_setup|price:$currency} {$lang.setupfee}{/if}</option>{/if}
                                                {if $i.a!=0}<option value="a" {if $cycle=='a'} selected="selected"{/if}>{$i.a|price:$currency} {$lang.a}{if $i.a_setup!=0} + {$i.a_setup|price:$currency} {$lang.setupfee}{/if}</option>{/if}
                                                {if $i.b!=0}<option value="b" {if $cycle=='b'} selected="selected"{/if}>{$i.b|price:$currency} {$lang.b}{if $i.b_setup!=0} + {$i.b_setup|price:$currency} {$lang.setupfee}{/if}</option>{/if}
                                                {if $i.t!=0}<option value="t" {if $cycle=='t'} selected="selected"{/if}>{$i.t|price:$currency} {$lang.t}{if $i.t_setup!=0} + {$i.t_setup|price:$currency} {$lang.setupfee}{/if}</option>{/if}
                                                {if $i.p4!=0}<option value="p4" {if $cycle=='p4'} selected="selected"{/if}>{$i.p4|price:$currency} {$lang.p4}{if $i.p4_setup!=0} + {$i.p4_setup|price:$currency} {$lang.setupfee}{/if}</option>{/if}
                                                {if $i.p4!=0}<option value="p5" {if $cycle=='p5'} selected="selected"{/if}>{$i.p5|price:$currency} {$lang.p5}{if $i.p5_setup!=0} + {$i.p5_setup|price:$currency} {$lang.setupfee}{/if}</option>{/if}
                                            </select>
                                        </dd>
                                    {/if}
                                    <dt class="col-md-2 col-12 font-weight-normal d-flex align-items-center">{$lang.applyto}</dt>
                                    <dd class="col-md-10 col-12">
                                        <select name="account_id" class="form-control">
                                            {foreach from=$i.services item=a}
                                                <option value="{$a.id}" {if $s_account==$a.id}selected="selected"{/if}>{$a.name}</option>
                                            {/foreach}
                                        </select>
                                    </dd>
                                </dl>
                            </div>
                            <div class="col-md-2 col-12 w-100 d-flex align-items-center justify-content-center">
                                <button type="submit" class="btn btn-success mt-3">{$lang.ordernow}</button>
                            </div>
                        </div>
                    </form>
                </div>
            {/foreach}
        </div>
    {else}
        {$lang.nothing}
    {/if}
{elseif $current_cat=='transfer' || $current_cat=='register'}

{/if}
