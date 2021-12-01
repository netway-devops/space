{include file="`$onappdir`header.cloud.tpl"}
<script src="{$moduledir_url}js/jquery.flot.min.js" type="text/javascript"></script>
<script src="{$moduledir_url}js/jquery.flot.axislabels.js" type="text/javascript"></script>
<script src="{$moduledir_url}js/jquery.flot.pie.min.js" type="text/javascript"></script>
<script src="{$moduledir_url}js/jquery.flot.resize.min.js" type="text/javascript"></script>
<script src="{$moduledir_url}js/jquery.flot.selection.min.js" type="text/javascript"></script>
<script src="{$moduledir_url}js/jquery.flot.stack.min.js" type="text/javascript"></script>
<script src="{$moduledir_url}js/jquery.flot.symbol.min.js" type="text/javascript"></script>
<script src="{$moduledir_url}js/jquery.flot.time.min.js" type="text/javascript"></script>
<script src="{$moduledir_url}js/jquery.flot.tooltip.min.js" type="text/javascript"></script>

<script src="{$moduledir_url}js/moment-with-locales.js" type="text/javascript"></script>
<script src="{$moduledir_url}js/usage.js" type="text/javascript"></script>
<script>
    usage_init({$stats|@json_encode}, {$stats_lang|@json_encode})
</script>
{literal}
    <style>
        .flot-legend-container {
            padding: 5px;
        }

        .flot-legend-container table {
            margin: auto;
        }

        .zoom-out {
            position: absolute;
            right: 25px;
            top: 10px;
            z-index: 1;
            opacity: 0.3;
        }

        .zoom-out:hover {
            opacity: 0.8
        }

        .data-graph {
            height: 300px;
            min-height: 40vh;
        }

        .pie-chart {
            min-height: 150px;
            min-width: 150px;
        }

        .data-row {
            flex-grow: 1;
            display: flex;
            justify-content: space-around;
            align-items: center;
            flex-wrap: wrap;
            margin: 0 20px 20px;
            background-color: white;
        }
        .data-info{
            margin-bottom:20px;
        }

        .usage,
        .pie-chart .pieLabel {
            display: none;
        }

        .usage:first-of-type,
        .pie-chart .pieLabel:first-of-type {
            display: block;
        }

        .pie-chart .pieLabel span {
            display: block;
            text-align: center;
        }

        .pie-chart .pieLabel .pie-value {
            font-size: 120%;
        }
    </style>
{/literal}

<div class="header-bar">
    <h3 class="cpuusage hasicon">{$lang.Usage}</h3>
</div>
<div class="content-bar">
    <div class="usage usage-cpu">

        <div class="data-row">
            <div class="data-info">
                <strong>CPU usage</strong>
                <div>Total CPU: <span id="cpulimit"></span></div>
                <div>Utilised: <span id="cppercent"></span></div>
                <div>Manufacturer: <span id="cpuman"></span></div>
            </div>
            <div id="cpu_pie" class="pie-chart"></div>
        </div>
        <div id="cpu_graph" class="data-graph"></div>
    </div>

    <div class="usage usage-memory">
        <div class="data-row">
            <div class="data-info">
                <strong>Memory usage</strong>
                <div>RAM: <span id="ramlimit"></span></div>
                {if $stats.ram.burst || $stats.ram.swap}
                    <div>{if $stats.ram.burst}Burst{else}SWAP{/if}: <span id="swap_val"></span></div>
                {/if}
                <div>Utilised: <span id="ramused"></span> (<span id="raminpercent"></span>)</div>
            </div>
            <div id="ram_pie" class="pie-chart"></div>
        </div>
        <div id="ram_graph" class="data-graph"></div>
    </div>

    <div class="usage usage-disk">
        <div class="data-row">
            <div class="data-row">
                <div class="data-info">
                    <strong>Disk Information</strong>
                    <div>Total Disk: <span id="disk_limit"></span></div>
                    <div>Utilised: <span id="disk_used"></span> (<span id="disk_percent"></span>)</div>
                </div>
                <div id="disk_pie" class="pie-chart"></div>
            </div>
            <div class="data-row">
                <div class="data-info">
                    <strong>Inodes Information</strong>
                    <div>Total Inodes: <span id="inod_limit"></span></div>
                    <div>Utilised: <span id="inod_used"></span> (<span id="inod_percent"></span>)</div>
                </div>
                <div id="inodes_pie" class="pie-chart"></div>
            </div>
        </div>
        <div id="disk_graph" class="data-graph"></div>
        <div id="inodes_graph" class="data-graph"></div>
    </div>

    <div class="usage usage-network">
        <div class="data-row">
            <div class="data-info">
                <strong>Network usage</strong>
                {if $stats.bandwidth}
                    <div>Total Bandwidth: <span id="bandwidth_total"></span></div>
                    <div>Utilised: <span id="bandwidth_use"></span> (<span id="bandwidth_percent"></span>)</div>
                {/if}
                <div>Average Download Speed: <span id="avg_download"></span></div>
                <div>Average Upload Speed: <span id="avg_upload"></span></div>
            </div>
            <div id="bandwidth_pie" class="pie-chart"></div>
        </div>
        <div id="network_graph" class="data-graph"></div>
        {if $stats.bandwidth}
            <div id="bandwidth_graph" class="data-graph"></div>
        {/if}
    </div>
</div>
{include file="`$onappdir`footer.cloud.tpl"}