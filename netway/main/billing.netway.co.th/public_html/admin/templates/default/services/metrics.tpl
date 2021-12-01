<script type="text/javascript" src="{$template_dir}js/services_metrics.js?v={$hb_version}"></script>

<p style="text-align: left">Related App(s) provide account metrics that you can set quotas for and inform your client about current use. You can also define automation tasks that will execute when usage hits quota.</p>

{foreach from=$available_metrics key=module_id item=modulem}
<div class="panel panel-default" style="text-align: left">
    <div class="panel-heading"><strong>{$modulem.name} metrics</strong></div>
    <div class="panel-body">

        <div class="metrics">
            <table class="table" width="100%">
                <thead>
                    <tr>
                        <th width="20%"><strong>Metric</strong></th>
                        <th width="20%" style="padding-left: 50px;"><strong>Name</strong></th>
                        <th width="20%" style="padding-left: 50px;"><strong>Quota</strong></th>
                        <th width="10%">
                            <strong>Forms</strong>
                            <span class="vtip_description"
                                  title="If enabled quota value is taken from client account forms"></span>
                        </th>
                        <th width="10%">
                            <strong>Show client</strong>
                            <span class="vtip_description"
                                  title="If enabled client will be able to see this metric
                                  in clientarea for his accounts"></span>
                        </th>
                        <th width="15%"><strong>Trigger event</strong>
                            <span class="vtip_description"
                                  title="When enabled and usage hits limit or is over it for number of days defined,
                                   trigger will fire allowing you to handle it in Custom Automation Task below"></span>
                        </th>
                        <th width="10%"></th>
                    </tr>
                </thead>
                <tbody class="metrics_body" data-rows="{$product.metrics|@count}" data-module="{$module_id}">
                    <tr class="metrics_body_empty_row">
                        <td colspan="5">
                            <span>There are no configured metrics for this app</span>
                        </td>
                    </tr>
                </tbody>
            </table>
        </div>
    </div>

    <div class="panel-footer">
        <a href="" class="btn btn-sm btn-info" onclick="addMetricRow({$module_id});return false;">
            <i class="fa fa-plus-square"></i>
            Add another quota
        </a>

    </div>
</div>

{/foreach}

<div class="" style="text-align: left;">
    <a href="#" class="btn btn-success btn-sm" onclick="return HBTasklist.assignNew({$product_id}, 'metrics');">
        <strong>{$lang.addcustomautomation}</strong>
    </a>
</div>

<div id="import-metrics" hidden bootbox
     data-title="Copy Metrics/Quotas"
     data-btntitle="Copy"
     data-btnclass="btn-primary">
    <input type="hidden" value="1" data-name="copy_metrics"/>
    <div class="form-group">
        <label>Product</label>
        <select class="form-control" data-name="copy_from">
            {foreach from=$otherproducts item=oth}
                <option value="{$oth.id}">
                    {$oth.catname} - {$oth.name}
                </option>
            {/foreach}
        </select>
        <div class="help-block">
            Select product to copy metrics from.
        </div>
    </div>
    <div class="checkbox">
        <label>
            <input type="checkbox" data-name="copy_metric_tasks" checked>
            Copy metrics custom automation tasks.
        </label>
    </div>
</div>

{literal}
<script id="metrics-form-options" type="text/x-handlebars-template">
    {{#each options}}
        <option {{#each data}}data-{{@key}}="{{this}}"{{/each}}
                value="{{@key}}" {{selected}}>
            {{name}}
        </option>
    {{/each}}
</script>
<script id="metrics-row-template" type="text/x-handlebars-template">
    <tr class="metric-row">
        <td style="vertical-align: top;">
            <select name="metrics[{{id}}][metric]" class="form-control input-sm metric_choose">
                {{> select options=metrics}}
            </select>
            <input type="hidden" class="metric_unit" name="metrics[{{id}}][unit]" value="{{unit}}">
            <input type="hidden" name="metrics[{{id}}][module_id]" value="{{module_id}}">
        </td>
        <td style="padding-left:50px;vertical-align:top;" class="metrics-row-name">
            <input type="text" name="metrics[{{id}}][name]" value="{{_name}}"
                   class="form-control input-sm hbinput" >
        </td>
        <td style="padding-left:50px;vertical-align:top;">
            <div class="input-group input-group-sm">
                <input size="10" name="metrics[{{id}}][limit]" type="number" class="metric_limit form-control"
                       min="0" step="0.01" oninput="validity.valid||(value='');"
                       value="{{limit}}">
                <select name="metrics[{{id}}][config_cat]" class="metric_forms form-control"
                        disabled style="display: none">
                    {{> select options=forms}}
                </select>
                <span class="input-group-addon quota_unit">{{unit}}</span>
            </div>
        </td>
        <td style="vertical-align: top;">
            <input name="metrics[{{id}}][flags][]" type="checkbox" value="4" {{flags.[4]}}
                class="metric_use_forms">
            Yes
        </td>
        <td style="vertical-align: top;">
            <input name="metrics[{{id}}][flags][]" type="checkbox" value="1" {{flags.[1]}}>
            Yes
        </td>
        <td style="vertical-align: top;">
            <input class="metric_enable_trigger" name="metrics[{{id}}][flags][]"
                   type="checkbox" value="2" {{flags.[2]}} >
            <input class="metric_input_trigger" size="20" name="metrics[{{id}}][trigger_period]"
                   style="width:60px;" type="number" min="0" value="{{trigger_period}}"
                   oninput="validity.valid||(value='');" disabled="disabled">
            days
        </td>
        <td style="vertical-align: top;">
            <button type="button" class="btn btn-danger btn-sm metric_remove">
                <i class="fa fa-trash"></i> {/literal}{$lang.Remove}{literal}
            </button>
        </td>
    </tr>
</script>

{/literal}
<script>
    initMetricsOptions({$available_metrics|@json_encode}, {$product.metrics|@json_encode});
</script>