{literal}
    <script>
        function handleTriggerSelect() {
            var s = $('#what_after'),
                o = s.find('option:selected'),
                id = o.attr('data-id'),
                idF = $('input#_t_tid');
            idF.val(id);
        }
        $(function () {
            handleTriggerSelect();
        });
    </script>
{/literal}

<div>
    <label class="nodescr">After</label>
    <div class="row">
        <div class="form-group col-md-12">
            <input type="hidden" name="config[metric_id]" id="_t_tid" value="">
            <input type="hidden" name="days" value="0" id="_t_days">
            <input type="hidden" name="when" value="after">
            <input type="hidden" name="interval_type" value="DAY">
            <select name="what_after" id="what_after" class="form-control" onchange="handleTriggerSelect();">
                {foreach from=$task.events key=metric_id item=metric}
                    <option data-id="{$metric_id}" value="MetricTrigger">
                        {$metric.name},
                        {if $metric.form}Form: {$metric.form.name},
                        {else}{$metric.limit} {$metric.unit}+,
                        {/if}
                        {$metric.trigger_period} days
                    </option>
                {/foreach}
            </select>
        </div>
    </div>
</div>