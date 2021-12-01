<div class="bundle-capsule" id="bundle_pricngopt">
    {include file="ajax.productbilling_Bundle.tpl" show='pricingopt'}
</div>
{*Breaking out fom td#priceoptions *}
</td>
</tr>
<tr>
    <td style="text-align: right; font-weight: bold; vertical-align: top">Items</td>
    <td>

        <div class="row">
            <div class="form-group col-md-3">
                <select class="bundle-select-type form-control" id="bundledprodctstype">
                    <option value="Product">Product</option>
                    <option value="Domain">Domain</option>
                    <option value="Addon">Addon</option>
                </select>
            </div>
            <div class="form-group col-md-9">
                <select class="bundle-select inp" id="bundledprodcts">
                    <option value="0" id="empty_opt">Select product..</option>
                    {foreach from=$bundle_categories item=category}
                        <optgroup class="{if $category.product_type=='DomainsType'}group_Domain{else}group_Product{/if}"
                                  label="{$category.name}">
                            {foreach from=$category.products item=catproduct}
                                <option value="{$catproduct.id}">{$catproduct.name}</option>
                            {/foreach}
                        </optgroup>
                    {/foreach}
                    <optgroup class="group_Addon" label="Addons">
                        {foreach from=$addons.addons item=addon}
                            <option value="{$addon.id}">{$addon.name}</option>
                        {/foreach}
                    </optgroup>
                </select>
            </div>

        </div>
        <div class="bundle-items clearfix">
            <div class="overlay">
                {$lang.nothingtodisplay}
            </div>
            <div class="bundle-list list-group">

                <div class="bundled-item list-group-item template" id="bundle_">
                    <a class="btn btn-default btn-sm sort"><i class="fa fa-sort"></i></a>

                    <div class="pull-right">
                        <a class="btn btn-default btn-sm config" href="#"
                           onclick="bundle_config(this); return false;"
                           title="Configure this item">
                            <i class="fa fa-pencil"></i>
                        </a>

                        <a class="btn btn-default btn-sm edit"
                           href="" target="_blank" title="Go to product page">
                            <i class="fa fa-link"></i>
                        </a>

                        <a class="btn btn-default btn-sm remove" href="#" title="Remove this item"
                           onclick="bundle_remove(this); return false">
                            <i class="fa fa-trash-o"></i>
                        </a>
                    </div>

                    <input type="hidden" value="" name="bundle_sort[]" class="bundle-sort">
                    <input type="hidden" value="" name="bundle_item[]">
                    <input type="hidden" value="" name="bundle_type[]">

                    <a href="#config" title="Configure" class="loadname"
                        onclick="bundle_config(this); return false;"></a>
                </div>
                {foreach from=$bundle_config.products item=bundled}
                    <div class="bundled-item list-group-item" id="bundle_{$bundled.id}_{$bundled.bunid}_{$bundled.type}">
                        <a class="btn btn-default btn-sm sort"><i class="fa fa-sort"></i></a>

                        <div class="pull-right">
                            <a class="btn btn-default btn-sm config" href="#"
                               onclick="bundle_config(this); return false;"
                               title="Configure this item">
                                <i class="fa fa-pencil"></i>
                            </a>

                            {if $bundled.type=='Addon'}
                                <a class="btn btn-default btn-sm edit"
                                   href="?cmd=productaddons&action=addon&id={$bundled.id}"
                                   target="_blank" title="Go to product page">
                                    <i class="fa fa-link"></i>
                                </a>
                            {else}
                                <a class="btn btn-default btn-sm edit"
                                   href="?cmd=services&action=product&id={$bundled.id}"
                                   target="_blank" title="Go to product page">
                                    <i class="fa fa-link"></i>
                                </a>
                            {/if}
                            <a class="btn btn-default btn-sm remove" href="#" title="Remove this item"
                               onclick="bundle_remove(this); return false">
                                <i class="fa fa-trash-o"></i>
                            </a>
                        </div>

                        <input type="hidden" value="{$bundled.bunid}" class="bundle-sort" name="bundle_sort[]">
                        <input type="hidden" value="{$bundled.type}" class="" name="bundle_type[{$bundled.bunid}]">
                        <input type="hidden" value="{$bundled.id}" name="bundle_item[{$bundled.bunid}]">

                        <a href="#config" title="Configure" class="loadname"
                           onclick="bundle_config(this); return false;">
                            {if $bundled.type=='Addon'}
                                {foreach from=$addons.addons item=addon}
                                    {if $addon.id == $bundled.id}Addons - {$addon.name}{break}
                                    {/if}
                                {/foreach}
                            {else}
                                {$bundled.name}
                            {/if}
                        </a>
                    </div>
                {/foreach}
                <div id="bundle_config" style="display: none"></div>
            </div>

            <div id="bundle_ajax" class="overlay"></div>
        </div>
        <script type="text/javascript" src="{$template_dir}js/bundle.js?v={$hb_version}"></script>
        <link media="all" type="text/css" rel="stylesheet" href="{$template_dir}js/bundle.css"/>

        {* breaking out fom td*}
    </td>
</tr>
{if ($product.valid_to && $product.valid_to!='0000-00-00') || ($product.valid_from && $product.valid_from!='0000-00-00')}
    {assign var=showtimecontrol value=true}
{/if}
<tr class="timecontrol" {if $showtimecontrol}style="display:table-row"{/if} >
    <td style="text-align: right; font-weight: bold; vertical-align: top">Time validation</td>
    <td>
        <a href="#" title="Control for what period of time this product will be available" class="vtip_description"></a>
    </td>
</tr>
<tr class="timecontrol" {if $showtimecontrol}style="display:table-row"{/if} >
    <td style="text-align: right; vertical-align: top">Valid from</td>
    <td>
        <input name="valid_from"
               value="{if $product.valid_from && $product.valid_from!='0000-00-00'}{$product.valid_from|dateformat:$date_format}{/if}"
               class="inp haspicker"/>
    </td>
</tr>
<tr class="timecontrol" {if $showtimecontrol}style="display:table-row"{/if} >
    <td style="text-align: right; vertical-align: top">Valid to</td>
    <td>
        <input name="valid_to"
               value="{if $product.valid_to && $product.valid_to!='0000-00-00'}{$product.valid_to|dateformat:$date_format}{/if}"
               class="inp haspicker"/>
    </td>
</tr>
<tr>
    <td>
            