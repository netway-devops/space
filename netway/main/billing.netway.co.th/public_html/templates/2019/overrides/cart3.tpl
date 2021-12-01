{include file="`$template_path`components/cart/cart.head.tpl"}
<link href="{$orderpage_dir}default/cart.css" rel="stylesheet" type="text/css"/>
{literal}
    <script type="text/javascript">
        function changeCycle(forms) {
            $(forms).append('<input type="hidden" name="ccycle" value="true"/>').submit();
            return true;
        }
    </script>
{/literal}
<div class="default-cart cart-configuration">
    <form action="" method="post" id="cart3">

        {if $parent_account}
            <div class="card">
                <div class="card-header">
                    <strong>{$lang.relatedservice}</strong>
                </div>
                <div class="card-body">
                    <span>{$lang.iamorderingforaccount}</span>
                    <a target="_blank" href="{$ca_url}clientarea&action=services&service={$parent_account.id}">#{$parent_account.id} {$parent_account.category_name} - {$parent_account.product_name} {if $parent_account.label} <small>({$parent_account.label})</small> {/if}</a>
                </div>
            </div>
        {/if}

        {if $product.description!='' || $product.paytype=='Once' || $product.paytype=='Free'}
            <div class="card">
                <div class="card-header">
                    <span>{$product.name}</span>
                </div>
                <div class="card-body" id="product_description">
                    <div class="mb-3">
                        {$product.description}
                    </div>
                    {if $product.paytype=='Free'}
                        <input type="hidden" name="cycle" value="Free"/>
                        <dl class="row align-items-center">
                            <dt class="col-md-3 col-12 font-weight-normal">{$lang.price}</dt>
                            <dd class="col-md-9 col-12 "><strong>{$lang.free}</strong></dd>
                        </dl>
                    {elseif $product.paytype=='Once'}
                        <input type="hidden" name="cycle" value="Once"/>
                        {price product=$product}
                            <dl class="row align-items-center">
                                <dt class="col-md-3 col-12 font-weight-normal">{$lang.price}</dt>
                                <dd class="col-md-9 col-12 "><strong>@@price</strong></dd>
                                <dt class="col-md-3 col-12 font-weight-normal">{$lang.once}</dt>
                                <dd class="col-md-9 col-12 "><strong>@@setupline<<' + '@</strong></dd>
                            </dl>
                        {/price}
                    {/if}
                </div>
            </div>
        {/if}

        {if $product.type=='Dedicated' || $product.type=='Server' || $product.hostname || $custom || ($product.paytype!='Once' && $product.paytype!='Free')}
            <div class="card">
                <div class="card-header">
                    <strong>{$lang.config_options}</strong>
                </div>
                <div class="card-body">
                    {if $product.paytype!='Once' && $product.paytype!='Free'}
                        <dl class="row align-items-center">
                            <dt class="col-md-3 col-12 font-weight-normal">{$lang.pickcycle}</dt>
                            <dd class="col-md-9 col-12 ">
                                <select name="cycle" onchange="{if $custom}changeCycle('#cart3');{else}simulateCart('#cart3');{/if}"  class="form-control">
                                    {price product=$product}
                                        <option value="@@cycle" @@selected>@@line</option>
                                    {/price}
                                </select>
                            </dd>
                        </dl>
                    {/if}
                    {if $product.hostname}
                        <dl class="row align-items-center">
                            <dt class="col-md-3 col-12 font-weight-normal">{$lang.hostname} *</dt>
                            <dd class="col-md-9 col-12 ">
                                <input name="domain" type="text" value="{$item.domain}" class="form-control"/>
                            </dd>
                        </dl>
                    {/if}
                    {if $custom}
                        <input type="hidden" name="custom[-1]" value="dummy"/>
                        {foreach from=$custom item=cf}
                            {if $cf.items}
                                <div class="form-group border-bottom my-3 cart-form cart-item {if $cf.key|strstr:'cf_'}{$cf.key} cf_option{/if}">
                                    <label class="font-weight-bold d-block" for="custom[{$cf.id}]">{$cf.name} {if $cf.options & 1}*{/if}</label>
                                    {if $cf.description!=''}
                                        <small class="d-block">{$cf.description}</small>
                                    {/if}
                                    {include file=$cf.configtemplates.cart}
                                </div>
                            {/if}
                        {/foreach}
                    {/if}
                    <small>{$lang.field_marked_required}</small>
                </div>
            </div>
        {/if}

        {if $subproducts}
            <div class="card">
                <div class="card-header">
                    <strong>{$lang.additional_services}</strong>
                </div>
                <div class="card-body">
                    {foreach from=$subproducts item=a key=k}
                        <div class="cart-item cart-subproduct">
                            <div class="form-check">
                                <input name="subproducts[{$k}]" type="checkbox" value="1" id="subproducts{$k}" {if $selected_subproducts.$k}checked="checked"{/if} onchange="simulateCart('#cart3');"/>
                                <label for="subproducts{$k}">{$a.category_name} - {$a.name}</label>
                            </div>
                            <div class="form-group my-3 cart-item-price">
                                {price product=$a}
                                {if $a.paytype=='Free'}
                                    {$lang.free}
                                    <input type="hidden" name="subproducts_cycles[{$k}]" value="free"/>
                                {elseif $a.paytype=='Once'}
                                    <input type="hidden" name="subproducts_cycles[{$k}]" value="once"/>
                                    @@line
                                {else}
                                    <select class="form-control" name="subproducts_cycles[{$k}]" onchange="if ($('input[name=\'subproducts[{$k}]\']').is(':checked'))simulateCart('#cart3');">
                                        <option value="@@cycle" @@selected>@@line</option>
                                    </select>
                                {/if}
                                {/price}
                            </div>
                        </div>
                        <hr>
                    {/foreach}
                </div>
            </div>
        {/if}

        {if $addons}
            <div class="card">
                <div class="card-header">
                    <strong>{$lang.addons_single}</strong>
                </div>
                <div class="card-body">
                    <p>{$lang.addons_single_desc}</p>
                    {foreach from=$addons item=a key=k}
                        <div class="cart-item cart-addon">
                            <div class="form-check">
                                <input name="addon[{$k}]" type="checkbox" value="1" id="addon{$k}" {if $selected_addons.$k}checked="checked"{/if} onchange="simulateCart('#cart3');"/>
                                <label for="addon{$k}">{$a.name}</label>
                            </div>
                            {if $a.description!=''}
                                <div class="cart-item-description">
                                    {$a.description}
                                </div>
                            {/if}
                            <div class="form-group cart-item-price">
                                {price product=$a}
                                {if $a.paytype=='Free'}
                                    {$lang.free}
                                    <input type="hidden" name="addon_cycles[{$k}]" value="free"/>
                                {elseif $a.paytype=='Once'}
                                    <input type="hidden" name="addon_cycles[{$k}]" value="once"/>
                                    @@line
                                {else}
                                    <select class="form-control" name="addon_cycles[{$k}]" onchange="if ($('input[name=\'addon[{$k}]\']').is(':checked'))simulateCart('#cart3');">
                                        <option value="@@cycle" @@selected>@@line</option>
                                    </select>
                                {/if}
                                {/price}
                            </div>
                        </div>
                    {/foreach}
                </div>
            </div>
        {/if}
        <input name='action' value='addconfig' type='hidden'/>
        <div class="d-flex flex-row justify-content-center my-5">
            <button class="btn btn-primary btn-lg btn-long" type="submit">{$lang.continue}</button>
        </div>
    </form>
</div>
{include file="`$template_path`components/cart/cart.foot.tpl"}