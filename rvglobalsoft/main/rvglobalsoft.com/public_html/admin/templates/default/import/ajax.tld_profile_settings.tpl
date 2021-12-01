<script type="text/javascript" src="{$template_dir}js/import_tld.js?v={$hb_version}"></script>

<div class="col-md-12">
    <hr>
    <a href="#" class="btn btn-default" onclick="$('.profile_settings').toggle();">Override margin/settings per TLD</a>
    <a href="?cmd=importaccounts&action=tld_profile_prices&id={$profile.id}" target="_blank" class="btn btn-default">Show TLD Registrar Prices</a>
    <a href="#" class="btn btn-info" onclick=" if (confirm('Do you really want to update current TLD prices?')) execute_price_update();">Update prices with current profile now</a>
    <hr>
</div>

<div class="col-md-12">
    <div class="profile_settings" {if $profile.items} {else} style="display: none;" {/if}>
        <table border="0" cellpadding="6" cellspacing="0" width="100%" class="table striped ">
            <thead>
            <tr>
                <th>TLD</th>
                <th>Overwrite protect</th>
                <th>Override margin</th>
                <th>Type</th>
                <th>Registration</th>
                <th>Renewal</th>
                <th>Transfer</th>
                <th>Redemption</th>
                <th></th>
            </tr>
            </thead>
            <tbody class="tld_settings_body">
            {foreach from=$profile.items item=item}
                <tr>
                    <td>
                        <input class="form-control" type="text" value="{$item.tld}" readonly="readonly">
                        <input type="hidden" name="items[{$item.tld}][tld]" value="{$item.tld}" readonly="readonly">
                    </td>
                    <td width="10%">
                        <input type="checkbox" class="disable_autoupdate" {if in_array(1,$item.flags)} checked="checked" {/if} name="items[{$item.tld}][flags][]" value="1" /> Yes
                        <a class="vtip_description" title="When enabled your prices set for this TLD in Product Configuration will not be overwritten"></a>
                    </td>
                    <td width="10%">
                        <input type="checkbox" class="override_margin" {if !in_array(1,$item.flags) && in_array(2,$item.flags)} checked="checked" {/if} name="items[{$item.tld}][flags][]" value="2"/> Yes
                        <a class="vtip_description" title="When enabled this particular TLD will have its own margins, different from profile. "></a>
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
                    <td width="10%">
                        <div class="input-group" style="margin: 2px 0;" >
                            <div class="input-group-addon margin_type_char" data-char="Percent" style="display: none;">%</div>
                            <div class="input-group-addon margin_type_char" data-char="Fixed" style="display: none;">{$currency.sign}</div>
                            <input type="text" name="items[{$item.tld}][margin_renewal]" class="override_margin_handler form-control" placeholder="0.00" value="{$item.margin_renewal}">
                        </div>
                    </td>
                    <td width="10%">
                        <div class="input-group" style="margin: 2px 0;" >
                            <div class="input-group-addon margin_type_char" data-char="Percent" style="display: none;">%</div>
                            <div class="input-group-addon margin_type_char" data-char="Fixed" style="display: none;">{$currency.sign}</div>
                            <input type="text" name="items[{$item.tld}][margin_transfer]" class="override_margin_handler form-control" placeholder="0.00" value="{$item.margin_transfer}">
                        </div>
                    </td>
                    <td width="10%">
                        <div class="input-group" style="margin: 2px 0;" >
                            <div class="input-group-addon margin_type_char" data-char="Percent" style="display: none;">%</div>
                            <div class="input-group-addon margin_type_char" data-char="Fixed" style="display: none;">{$currency.sign}</div>
                            <input type="text" name="items[{$item.tld}][margin_redemption]" class="override_margin_handler form-control" placeholder="0.00" value="{$item.margin_redemption}">
                        </div>
                    </td>
                    <td width="5%">
                        <a href="#" class="btn btn-sm btn-danger remove_tld_settings">Remove</a>
                    </td>
                </tr>
            {/foreach}
            </tbody>
            <tbody>
            <tr>
                <td colspan="7">
                    <a href="#" onclick="addTldSetting();return false;">Add TLD override</a>
                </td>
            </tr>
            </tbody>
        </table>
    </div>
</div>


{literal}
<script id="tld-setting-template" type="text/x-custom-template">
    <tr>
        <td>
            <select name="new_items[__itt][tld]" class="form-control chosenedge tld_select">
                {/literal}{foreach from=$profile.tlds key=tld item=tld_prices}
                    <option value="{$tld}" data-registration="{$tld_prices.register}" data-renewal="{$tld_prices.renew}" data-transfer="{$tld_prices.transfer}" data-redemption="{$tld_prices.redemption}">{$tld}</option>
                {/foreach}{literal}
            </select>
        </td>
        <td width="10%">
            <input type="checkbox" class="disable_autoupdate" name="new_items[__itt][flags][]" value="1" /> Yes
            <a class="vtip_description" title="When enabled your prices set for this TLD in Product Configuration will not be overwritten"></a>
        </td>
        <td width="10%">
            <input type="checkbox" class="override_margin" name="new_items[__itt][flags][]" value="2"/> Yes
            <a class="vtip_description" title="When enabled this particular TLD will have its own margins, different from profile. "></a>
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
        <td width="10%">
            <div class="input-group" style="margin: 2px 0;" >
                <div class="input-group-addon margin_type_char" data-char="Percent" style="display: none;">%</div>
                <div class="input-group-addon margin_type_char" data-char="Fixed" style="display: none;">{/literal}{$currency.sign}{literal}</div>
                <input type="text" name="new_items[__itt][margin_renewal]" data-type="renewal" class="override_margin_handler override_margin_handler_price form-control" placeholder="0.00">
            </div>
        </td>
        <td width="10%">
            <div class="input-group" style="margin: 2px 0;" >
                <div class="input-group-addon margin_type_char" data-char="Percent" style="display: none;">%</div>
                <div class="input-group-addon margin_type_char" data-char="Fixed" style="display: none;">{/literal}{$currency.sign}{literal}</div>
                <input type="text" name="new_items[__itt][margin_transfer]" data-type="transfer" class="override_margin_handler override_margin_handler_price form-control" placeholder="0.00">
            </div>
        </td>
        <td width="10%">
            <div class="input-group" style="margin: 2px 0;" >
                <div class="input-group-addon margin_type_char" data-char="Percent" style="display: none;">%</div>
                <div class="input-group-addon margin_type_char" data-char="Fixed" style="display: none;">{/literal}{$currency.sign}{literal}</div>
                <input type="text" name="new_items[__itt][margin_redemption]" data-type="redemption" class="override_margin_handler override_margin_handler_price form-control" placeholder="0.00">
            </div>
        </td>
        <td width="5%">
            <a href="#" class="btn btn-sm btn-danger remove_tld_settings">Remove</a>
        </td>
    </tr>
</script>
{/literal}