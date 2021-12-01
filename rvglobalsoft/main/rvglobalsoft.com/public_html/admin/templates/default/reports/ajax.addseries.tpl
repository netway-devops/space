

<link href="{$template_dir}css/jquery-ui.css" rel="stylesheet" media="all" />
<form action="?cmd=reports&action=savenewseries&widget_id={$widget.id}" method="post">
    {if  $series}
        <input type="hidden" name="series_id" value="{$series.id}" />
    {/if}
    <div id="aconditions">
    <label>Series name:</label>
    <input class="form-control" name="series-name" placeholder="Series name" value="{$series.name}" type="text" />
    <br/>
        <a href="#" class="btn btn-default btn-xs" onclick="$(this).hide();$('#columncontainer').show();return false;">Edit series columns (max two in output)</a>
        <div id="columncontainer" style="display: none">
            {include file='reports/report.columns.tpl'}
        </div>
            <br/>
        <a href="#" class="btn btn-default btn-xs" onclick="$(this).hide();$('#conditionscontainer').show();return false;">Edit series parameters</a>
        <div id="conditionscontainer"  style="display: none">
    {include file='reports/report.params.tpl'}
        </div>
</div>
    <div style="margin:20px;text-align: center">
        {if  $series}
            <input type="submit" class="btn  btn-primary" value="Save changes" />
            {else}
            <input type="submit" class="btn  btn-primary" value="Add new series" />
        {/if}

    </div>
{securitytoken}</form>
{literal}
<script>

    $("#aconditions a.vtip_description").vTip();
    $('#facebox .haspicker').datePicker({
        startDate: startDate
    });
</script>
{/literal}