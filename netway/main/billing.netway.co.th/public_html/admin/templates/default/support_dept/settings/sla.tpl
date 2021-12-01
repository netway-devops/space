
<script type="text/javascript" src="{$template_dir}js/ticketdepts_sla.js?v={$hb_version}"></script>

<div class="panel panel-default">
    <div class="panel-heading"><strong>SLA Policies</strong></div>
    <div class="panel-body">
            <div class="slas">
                <table class="table" width="100%">
                    <thead>
                    <tr>
                        <th width="20%"><strong>Policy Name</strong> <span class="vtip_description" title="For admin/logging purposes only"></span></th>
                        <th width="10%" style=""><strong>Level</strong> <span class="vtip_description" title="Higher level is more severe. If ticket breaches certain level only SLA policy above this level applies"></span></th>
                        <th width="20%" style=""><strong>Trigger</strong> <span class="vtip_description" title="Event type breaching this policy"></span></th>
                        <th width="10%" style=""><strong>Trigger Value</strong> <span class="vtip_description" title="Policy breaches when  triggering value is higher or equal"></span></th>
                        <th width="10%" style=""><strong>Tags</strong> <span class="vtip_description" title="You can use &quot;and&quot;, &quot;or&quot;, &quot;not&quot; keywords when filtering with tags, default is &quot;and&quot;, example: <br> &bullet;&nbsp;tag1 tag2 or tag3 &raquo; (tag1 and tag2) or tag3<br><br>You can use the <b>untagged</b> tag for tickets that have no tags"></span></th>
                        <th width="10%" style=""><strong>De-escalate</strong> <span class="vtip_description" title="If this option is checked, Escalation will be removed after the staff member replies"></span></th>
                        <th width="20%" style=""><strong>Macro</strong> <span class="vtip_description" title="Executed on ticket when it breaches this SLA policy"></span></th>
                        <th width="20%" style=""><strong>Statuses</strong> <span class="vtip_description" title="Only tickets with selected statuses will be checked"></span</th>
                        <th width="10%"></th>
                    </tr>
                    </thead>
                    <tbody class="slas_body" data-rows="{$product.slas|@count}">
                    <tr class="slas_body_empty_row">
                        <td colspan="5">
                            <span>There are no SLA Policies set for this deparment</span>
                        </td>
                    </tr>
                    </tbody>
                </table>
            </div>
        </div>
    <div class="panel-footer">
        <a href="" class="btn btn-sm btn-info" onclick="addSLARow({$module_id});return false;">
            <i class="fa fa-plus-square"></i>
            Add another SLA policy
        </a>
    </div>
</div>


<div class="panel panel-default">
    <div class="panel-heading"><strong>Report to manager</strong></div>
    <div class="panel-body">
        <table class="table" width="100%">
            <thead>
            <tr>
                <th width="20%"><strong>Allow clients to report:</strong></th>
                <th width="5%"><strong>Enabled</strong></th>
                <th><strong>Execute macro after report</strong></th>

            </tr>
            </thead>
            <tbody class="">

            <tr >
                <td  >Single replies</td>
                <td>
                    <input type="checkbox" name="reportreply" {if $submit.options & 131072}checked="checked"{/if} value="1"/>
                </td>
                <td>
                    <select name="macro_reportreply" class="form-control input-sm " style="max-width:300px">
                        <option value="0"> --</option>
                        {foreach from=$macros item=macro}
                            <option {if $submit.macro_reportreply == $macro.id}selected="selected"{/if}
                                    value="{$macro.id}">{$macro.catname|escape} - {$macro.name|escape}</option>
                        {/foreach}
                    </select>
                </td>
            </tr>

            <tr >
                <td  >Entire threads</td>
                <td>
                    <input type="checkbox" name="reportticket" {if $submit.options & 262144}checked="checked"{/if} value="1"/>
                </td>
                <td>
                    <select name="macro_reportticket" class="form-control input-sm " style="max-width:300px">
                        <option value="0"> --</option>
                        {foreach from=$macros item=macro}
                            <option {if $submit.macro_reportticket == $macro.id}selected="selected"{/if}
                                    value="{$macro.id}">{$macro.catname|escape} - {$macro.name|escape}</option>
                        {/foreach}
                    </select>
                </td>
            </tr>

            </tbody>
        </table>
</div>
</div>





{literal}
    <script id="slas-form-options" type="text/x-handlebars-template">
        {{#each options}}
        <option {{#each data}}data-{{@key}}="{{this}}"{{/each}}
        value="{{@key}}" {{selected}}>
        {{name}}
        </option>
        {{/each}}
    </script>

    <script id="slas-form-statusoptions" type="text/x-handlebars-template">
        {{#each options}}
        <option {{#each data}}data-{{@key}}="{{this}}"{{/each}}
        value="{{status}}" {{selected}}>
        {{status}}
        </option>
        {{/each}}
    </script>

    <script id="slas-form-tagoptions" type="text/x-handlebars-template">
        {{#each options}}
        <option {{#each data}}data-{{id}}="{{this}}"{{/each}}
        value="{{id}}" {{selected}}>
        {{tag}}
        </option>
        {{/each}}
    </script>

    <script id="slas-form-macrooptions" type="text/x-handlebars-template">
        <option value="0">None</option>
        {{#each options}}
        <option  value="{{id}}" {{selected}}>{{catname}} -  {{name}} </option>
        {{/each}}
    </script>

<script id="slas-row-template" type="text/x-handlebars-template">
    <tr class="metric-row">

        <td style="vertical-align:top;" class="slas-row-name">
            <input type="text" name="sla[{{id}}][name]" value="{{name}}"
                   class="form-control input-sm" >
        </td>

        <td style="vertical-align: top;">
            <select name="sla[{{id}}][level]" class="form-control input-sm metric_choose">
                {{> select options=levels}}
            </select>
        </td>

        <td style="vertical-align: top;">
            <select name="sla[{{id}}][trigger]" class="sla_trigger form-control input-sm metric_choose">
                {{> select options=triggers}}
            </select>
        </td>

        <td style="vertical-align:top;">

            <div class="input-group">
            <input size="5" name="sla[{{id}}][trigger_value]" type="text" class=" input-sm  form-control"
                   min="1" step="1" oninput="validity.valid||(value='');"
                   value="{{trigger_value}}">
                <span class="input-group-addon" style="width:0px; padding-left:0px; padding-right:0px; border:none;"></span>
                <select name="sla[{{id}}][trigger_unit]" class="form-control input-sm metric_choose sla_trigger_unit">
                    {{> select options=_units}}
                </select>
            </div>

        </td>
        <td style="vertical-align: top;">
            <input type="text" name="sla[{{id}}][tags]" value="{{tags}}" class="form-control input-sm" >
        </td>
        <td style="vertical-align: top;">
            <input type="checkbox" name="sla[{{id}}][de_escalate]" value="1" {{de_escalate}} class=" input-sm">
        </td>
        <td style="vertical-align: top;">
            <select name="sla[{{id}}][macro_id]" class="form-control input-sm metric_choose">
                {{> macroselect options=macros}}
            </select>
        </td>
        <td style="vertical-align: top;">
            <select name="sla[{{id}}][trigger_status][]" multiple class="form-control input-sm sla-chosen">
                {{> statusselect options=statuses}}
            </select>
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
    initSLAsOptions({$slas|@json_encode},{$statuses|@json_encode},{$triggers|@json_encode},{$macros|@json_encode},{$tags|@json_encode});
</script>