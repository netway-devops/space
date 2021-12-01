<link href="{$template_dir}js/chosen/chosen.css" rel="stylesheet" media="all">
<script type="text/javascript" src="{$template_dir}js/chosen/chosen.min.js?v={$hb_version}"></script>
<script type="text/javascript" src="{$template_dir}js/import_products.js?v={$hb_version}"></script>
<form method="POST">
    <input type="hidden" name="make" value="{if $profile.id}edit{else}add{/if}"/>
    <div class="lighterblue2">
        <div class="row">
            <div class="col-md-12 col-lg-10">
                <table border="0" cellpadding="6" cellspacing="0" width="100%">
                    <tr>
                        <td width="200" align="right">
                            <strong>Name</strong>
                        </td>
                        <td>
                            <input type="hidden" name="id" value="{$profile.id}" id="profile_id">
                            <input type="text" name="name" id="name" style="font-weight:bold; width: 100%;" value="{$profile.name}" class="form-control" required="required">
                        </td>
                    </tr>
                    <tr>
                        <td width="200" align="right"><strong>Description</strong></a></td>
                        <td>
                            <textarea name="description" rows="10" style="width: 100%; resize: vertical;">{if $profile.description}{$profile.description}{/if}</textarea>
                        </td>
                    </tr>
                    <tr>
                        <td width="200" align="right">
                            <strong>Status</strong>
                        </td>
                        <td>
                            <select name="status" class="form-control chosen" data-chosen data-placeholder="Status" id="status" required="required">
                                <option {if $profile.status == 'Active'} selected="selected" {/if} value="Active">Active</option>
                                <option {if $profile.status == 'Inactive'} selected="selected" {/if} value="Inactive">Inactive</option>
                            </select>
                        </td>
                    </tr>
                    <tr>
                        <td width="200" align="right">
                            <strong>Select app</strong>
                        </td>
                        <td>
                            <select name="server_id" class="form-control chosenedge" id="server_id" >
                                {foreach from=$servers item=server_group}
                                    <optgroup label="{$server_group.name}">
                                        {foreach from=$server_group.servers item=srvr}
                                            <option value="{$srvr.id}" data-modid="{$server_group.module}" {if $profile.server_id == $srvr.id} selected="selected" {/if}>
                                                {$srvr.name}
                                                {if $srvr.ip} - {$srvr.ip}{elseif $srvr.host} - {$srvr.host}{/if}
                                            </option>
                                        {/foreach}
                                    </optgroup>
                                {/foreach}
                            </select>
                        </td>
                    </tr>

                    <tr>
                        <td></td>
                        <td>
                            <div id="warnings">
                                <div id="warn-no-support" class="import-warn alert alert-danger" style="display: none">
                                    {$lang.import_notsupported}
                                </div>
                            </div>
                        </td>
                    </tr>

                    <tr>
                        <td></td>
                        <td>
                            <div id="warnings">
                                <div id="warn-no-product" class="import-warn alert alert-info" style="display: none">
                                    To continue, please create <a href="?cmd=services" target="_blank">first product</a> using selected app that can be used as template for importing next products.
                                </div>
                            </div>
                        </td>
                    </tr>

                    <tr class="support_import_products">
                        <td width="200" align="right">
                            <strong>Default margin</strong>
                        </td>
                        <td>
                            <select name="default_margin_type" class="form-control chosen" data-chosen data-placeholder="Status" id="default_margin_type">
                                <option value="Fixed" {if $profile.default_margin_type == 'Fixed'} selected="selected" {/if}>Fixed</option>
                                <option value="Percent" {if $profile.default_margin_type == 'Percent'} selected="selected" {/if}>Percent</option>
                            </select>
                        </td>
                    </tr>

                    <tr class="support_import_products">
                        <td></td>
                        <td>
                            <div class="row">
                                <div class="col-12 col-md-6 col-lg-3">
                                    <div class="form-group">
                                        <label>Lowest price</label>
                                        <div class="input-group" style="margin: 2px 0;" >
                                            <div class="input-group-addon default_margin_type_char" data-char="Percent" style="display: none;">%</div>
                                            <div class="input-group-addon default_margin_type_char" data-char="Fixed" style="display: none;">{$currency.sign}</div>
                                            <input type="text" name="default_margin_registration" class="form-control" placeholder="0.00" value="{$profile.default_margin_registration}">
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </td>
                    </tr>

                    <tr class="support_import_products ">
                        <td width="200" align="right">
                            <strong>Default product</strong>
                            <a href="#" class="vtip_description" title='Default product acts as "source of data" for all items that import cannot automatically determine, like automation settings, nameservers, email notifications etc.'></a>
                        </td>
                        <td>
                            <select name="default_product" class="form-control chosenedge" id="default_product" required="required">
                                {foreach from=$products item=product}
                                    <option value="{$product.id}" data-parent="{$product.module_id}" {if $profile.default_product == $product.id} selected="selected" {/if}>
                                        {$product.category_name} - {$product.name}
                                    </option>
                                {/foreach}
                            </select>
                        </td>
                    </tr>

                    <tr class="support_import_products ">
                        <td width="200" align="right">
                            <strong>Auto-update</strong>
                            <a href="#" class="vtip_description" title='Use CRON to periodically pull price changes and update related Products automatically'></a>
                        </td>
                        <td>
                            <div class="checkbox" style="margin-left: 20px;">
                                <input type="checkbox" {if in_array(1,$profile.flags)} checked="checked" {/if} name="flags[]" value="1" /> Yes
                            </div>
                        </td>
                    </tr>

                    <tr class="support_import_products ">
                        <td width="200" align="right">
                            <strong>Fill missing Products</strong>
                            <a href="#" class="vtip_description" title='When selected all new products that are not in your offer will be imported from App. Default product will be used as template for imported product.'></a>
                        </td>
                        <td>
                            <div class="checkbox" style="margin-left: 20px;">
                                <input type="checkbox" {if in_array(2,$profile.flags)} checked="checked" {/if} name="flags[]" value="2" /> Yes
                            </div>
                        </td>
                    </tr>

                    <tr class="support_import_products ">
                        <td width="200" align="right">
                            <strong>Update missing periods</strong>
                            <a href="#" class="vtip_description" title='If registry does not return periods you currently offer, its prices will be auto-udpated based on minimal period. I.e.: if you offer 2 year product registration, and registry API returns only 1 year pricing, 2 year price will be set based on 1 year, multiplied by actual period (2).'></a>
                        </td>
                        <td>
                            <div class="checkbox" style="margin-left: 20px;">
                                <input type="checkbox" {if in_array(4,$profile.flags)} checked="checked" {/if} name="flags[]" value="4" /> Yes
                            </div>
                        </td>
                    </tr>
                </table>
            </div>
            <div class="col-md-12">
                {if $profile.id}
                    <div id="products_profile_settings" class="support_import_products">
                        <center>
                            <img src="ajax-loading.gif" />
                            <div>Loading settings...</div>
                        </center>
                        {literal}
                            <script type="text/javascript">
                            $(function () {
                                ajax_update("?cmd=importaccounts&action=products_profile_settings&id={/literal}{$profile.id}{literal}",{},'#products_profile_settings');
                            })
                            </script>
                        {/literal}
                    </div>
                {/if}
            </div>
        </div>
    </div>
    <div class="blu">
        <table border="0" cellpadding="2" cellspacing="0">
            <tr>
                <td>
                    <button type="submit" class="btn btn-primary" id="save_changes">{if !$profile.id}Add profile{else}Save changes{/if}</button>
                </td>
            </tr>
        </table>
    </div>
    {securitytoken}
</form>

<div id="taskexec" style="display:none">
    <h2 style="margin-bottom: 5px;" id="taskname">{$lang.taskrunning} <span></span></h2>
    <div id="taskindicator" style="display:none;padding:5px;text-align: center">
        <img src="ajax-loading.gif" alt="" />
    </div>
    <div id="output" style="display:none;">
        {$lang.taskoutput}
        <div class="consoleout">
            <pre></pre>
        </div>
    </div>
</div>

{literal}
    <style>
        .support_import_products {
            display: none;
        }
        select#default_product option[disabled] {
            display: none;
        }
        #default_product_chosen .disabled-result {
            display: none;
        }
        select:invalid {
            height: 0px !important;
            opacity: 0 !important;
            position: absolute !important;
            display: flex !important;
        }
        select:invalid[multiple] {
            margin-top: 15px !important;
        }
    </style>
{/literal}