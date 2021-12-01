<link media="all" type="text/css" rel="stylesheet" href="templates/common/css/flatpickr.min.css" />
<link media="all" type="text/css" rel="stylesheet" href="templates/common/css/widget-graphs.css" />
<script type="text/javascript" src="templates/common/js/flatpickr.js"></script>
<script type="text/javascript" src="templates/common/js/flatpickr/rangePlugin.js"></script>
<script type="text/javascript" src="templates/common/js/widget-graphs.js"></script>


{if $datasources}
    <form action="" method="POST" autocomplete="off">
        {if $range}
            <div class="widget-graph-control form-inline">

                <div class="inline-no-wrap">
                    {$lang.from|capitalize}
                    <input type="text" name="from" value="{$range.from|dateformat:$date_format}"
                           data-format="{$date_format}"  data-default="{$range.from}"
                           id="graph-from" class="date-time-picker"/>
                </div>

                <div class="inline-no-wrap">
                    {$lang.to}
                    <input type="text" name="to" value="{$range.to|dateformat:$date_format}"
                           data-format="{$date_format}" data-default="{$range.to}"
                           id="graph-to" class="date-time-picker"/>
                </div>

                <button type="submit" class="btn btn-default" id="graph-update">{$lang.refresh}</button>
            </div>
        {/if}

        {foreach from=$datasources item=ds}
            <div class="widget-graph">
                <strong>{$ds.name}</strong>
                <div class="widget-graph-group">
                    {foreach from=$ds.graphs item=graph}
                        <div class="widget-graph-image-container loading">
                            <img class="widget-graph-image" src="{$graph.url}" alt="{$graph.name}"/>
                        </div>
                    {/foreach}
                </div>
            </div>
        {/foreach}
        {securitytoken}
    </form>
{else}
    <h4>No graphs assigned to this account yet</h4>
{/if}