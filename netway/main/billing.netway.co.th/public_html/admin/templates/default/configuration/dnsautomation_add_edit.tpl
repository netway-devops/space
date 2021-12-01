<div class="tabs tab-add tab-edit">
    <form method="post" action="?cmd=dns_automation&action={$action}" id="whois_plugin"  style="margin: 10px 0" >
        <div class="container-fluid clear">
            <div class="row">
                <div>
                    <div class="col-sm-12">
                        <div class="panel panel-default">
                            <div class="panel-heading">
                                {if $action == 'add'}New DNS automation rule{elseif $action == 'edit'}Edit DNS automation rule{/if}
                            </div>
                            <div class="panel-body">
                                <div class="form-group">
                                    <label>Automation name</label>
                                    <input type="text" name="rule[name]" value="{$rule.name}" class="form-control" required>
                                </div>
                                <div class="form-group">
                                    <label>Description</label>
                                    <textarea class="form-control" rows="3" name="rule[description]" style="min-height: 60px; min-width: 100%;">{$rule.description}</textarea>
                                </div>
                                <div class="form-group">
                                    <label>Products <i class="vtip_description" title="Select products for which zone should be created upon account creation"></i></label>
                                    <select multiple class="form-control chosen-p" name="rule[products][]">
                                        {foreach from=$products item=product}
                                            <optgroup label="{$product.name}">
                                                {assign var=pid value="c`$product.id`"}
                                                <option value="c{$product.id}" {if in_array($pid, $rule.products)}selected{/if}>All products from {$product.name}</optn>
                                                {foreach from=$product.products item=pro}
                                                    {assign var=pid value="p`$pro.id`"}
                                                    <option value="p{$pro.id}" {if in_array($pid, $rule.products)}selected{/if}>{$pro.name}</option>
                                                {/foreach}
                                            </optgroup>
                                        {/foreach}
                                    </select>
                                </div>
                                <div class="form-group">
                                    <label>DNS Service package <i class="vtip_description" title="This package will be added to customer account (if it does not exit already) and zone will be created in it"></i></label>
                                    <select class="form-control chosen" name="rule[dns_package_id]" required>
                                        {foreach from=$packages item=package}
                                            <option value="{$package.id}" {if $package.id == $rule.dns_package_id}selected{/if}>{$package.name}</option>
                                        {/foreach}
                                    </select>
                                </div>
                                <div class="form-group">
                                    <label>Default IP  <i class="vtip_description" title="If HostBill will be unable to determine what IP to use when creating zone/A records, it will use this one"></i></label>
                                    <input type="text" class="form-control" value="{$rule.default_ip}" name="rule[default_ip]">
                                </div>
                                <div class="form-group">
                                    <label>DNS Template <i class="vtip_description" title="If selected, it will be applied on newly created zone"></i></label>
                                    <select class="form-control chosen" name="rule[dns_template_id]">
                                        <option value="">None</option>
                                        {foreach from=$dns_templates item=template}
                                            <option value="{$template[0].id}" {if $template[0].id == $rule.dns_template_id}selected{/if}>{$template[0].template}</option>
                                        {/foreach}
                                    </select>
                                </div>
                                <div class="checkbox">
                                    <label>
                                        <input type="checkbox" name="rule[options][]" value="1" {if $rule.options & 1}checked{/if}> <strong>Remove zone on terminate</strong>
                                    </label>
                                </div>
                            </div>
                        </div>
                        <div class="nicerblu" style="text-align:center; margin-bottom: 15px;">
                            <input type="submit" value="Save Changes" name="save[dnsautomation]" style="font-weight:bold" class="btn btn-primary">
                            <a href="?cmd=dns_automation&picked_tab=1" class="btn btn-warning">Back</a>
                        </div>
                    </div>
                </div>
            </div>
        </div>
        <input type="hidden" name="rule[id]" value="{if $rule.id}{$rule.id}{else}new{/if}">
        {securitytoken}
    </form>
</div>
{literal}
<script>
    $(function () {
        $('.chosen').chosenedge({width: '100%'});
        $('.chosen-p').chosenedge({width: '100%'}).on('change', function (e, data) {
            var select = $(this),
                values = select.val();

            $.each(values, function(i, v){
                if (v !== undefined && v.charAt(0) === 'c') {
                    var p = select.find('option[value='+v+']');
                    p.parent().children().each(function () {
                        var vv = $(this).attr('value');
                        if (vv.charAt(0) === 'p') {
                            values = jQuery.grep(values, function (va) {
                                return va !== vv;
                            });
                        }
                    });
                }
            });
            select.val(values).trigger('chosen:updated');
        });
    });
</script>
{/literal}