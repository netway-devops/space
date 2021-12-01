<script type="text/javascript" src="{$template_dir}js/import_products.js?v={$hb_version}"></script>

<div class="col-md-12">
    <hr>
    <a href="#" class="btn btn-default" onclick="$('.profile_settings').toggle();">Override margin/settings per Product</a>
    <a href="#" class="btn btn-info" onclick=" if (confirm('Do you really want to update current Product prices?')) execute_price_update();">Update prices with current profile now</a>
    <hr>
</div>

<div class="col-md-12">
    <div class="profile_settings" {if $profile.items} {else} style="display: none;" {/if}>
        <table border="0" cellpadding="6" cellspacing="0" width="100%" class="table striped ">
            <thead>
            <tr>
                <th>Product</th>
                <th>Overwrite protect</th>
                <th>Override margin</th>
                <th>Type</th>
                <th>Lowest price</th>
                <th></th>
            </tr>
            </thead>
            <tbody class="product_settings_body">
            {foreach from=$profile.items item=item}
                <tr>
                    <td>
                        <input class="form-control" type="text" value="{$item.name} ({$item.cycle_friendly})" readonly="readonly">
                        <input type="hidden" name="items[{$item.tld}][tld]" value="{$item.tld}" readonly="readonly">
                    </td>
                    <td width="10%">
                        <input type="checkbox" class="disable_autoupdate" {if in_array(1,$item.flags)} checked="checked" {/if} name="items[{$item.tld}][flags][]" value="1" /> Yes
                        <a class="vtip_description" title="When enabled your prices set for this product in Configuration will not be overwritten. If this checkbox is set, and product does not exist in HostBill it will not be imported"></a>
                    </td>
                    <td width="10%">
                        <input type="checkbox" class="override_margin" {if !in_array(1,$item.flags) && in_array(2,$item.flags)} checked="checked" {/if} name="items[{$item.tld}][flags][]" value="2"/> Yes
                        <a class="vtip_description" title="When enabled this particular product will have its own margins, different from profile. "></a>
                    </td>
                    <td width="10%">
                        <select name="items[{$item.tld}][margin_type]" class="form-control margin_type override_margin_handler">
                            <option value="Fixed" {if $item.margin_type == 'Fixed'} selected="selected" {/if}>Fixed</option>
                            <option value="Percent" {if $item.margin_type == 'Percent'} selected="selected" {/if}>Percent</option>
                        </select>
                    </td>
                    <td width="10%">
                        <div class="input-group" style="margin: 2px 0;">
                            <div class="input-group-addon margin_type_char" data-char="Percent" style="display: none;">%</div>
                            <div class="input-group-addon margin_type_char" data-char="Fixed" style="display: none;">{$currency.sign}</div>
                            <input type="text" name="items[{$item.tld}][margin_registration]" class="override_margin_handler form-control" placeholder="0.00" value="{$item.margin_registration}">
                        </div>
                    </td>
                    <td width="5%">
                        <a href="#" class="btn btn-sm btn-danger remove_product_settings">Remove</a>
                    </td>
                </tr>
            {/foreach}
            </tbody>
            <tbody>
            <tr>
                <td colspan="7">
                    <a href="#" onclick="addProductSetting();return false;">Add Product override</a>
                </td>
            </tr>
            </tbody>
        </table>
    </div>
</div>

{literal}
<script id="product-setting-template" type="text/x-custom-template">
    <tr>
        <td>
            <select name="new_items[__itt][tld]" class="form-control chosenedge product_select">
                {/literal}{foreach from=$profile.products item=product}
                    <option value="{$product.code}" data-registration="{$product.price}">{$product.name} ({$product.cycle_friendly})</option>
                {/foreach}{literal}
            </select>
        </td>
        <td width="10%">
            <input type="checkbox" class="disable_autoupdate" name="new_items[__itt][flags][]" value="1" /> Yes
            <a class="vtip_description" title="When enabled your prices set for this product in Configuration will not be overwritten. If this checkbox is set, and product does not exist in HostBill it will not be imported"></a>
        </td>
        <td width="10%">
            <input type="checkbox" class="override_margin" name="new_items[__itt][flags][]" value="2"/> Yes
            <a class="vtip_description" title="When enabled this particular Product will have its own margins, different from profile. "></a>
        </td>
        <td width="10%">
            <select name="new_items[__itt][margin_type]" class="form-control margin_type override_margin_handler override_margin_handler_type">
                <option value="Fixed">Fixed</option>
                <option value="Percent">Percent</option>
            </select>
        </td>
        <td width="10%">
            <div class="input-group" style="margin: 2px 0;">
                <div class="input-group-addon margin_type_char" data-char="Percent" style="display: none;">%</div>
                <div class="input-group-addon margin_type_char" data-char="Fixed" style="display: none;">{/literal}{$currency.sign}{literal}</div>
                <input type="text" name="new_items[__itt][margin_registration]" data-type="registration" class="override_margin_handler override_margin_handler_price form-control" placeholder="0.00">
            </div>
        </td>
        <td width="5%">
            <a href="#" class="btn btn-sm btn-danger remove_product_settings">Remove</a>
        </td>
    </tr>
</script>
{/literal}