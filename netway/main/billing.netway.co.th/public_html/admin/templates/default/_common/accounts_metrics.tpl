<div class="wbox account_metrics">
    <div class="wbox_content">
        <div class="row">
            {foreach from=$metrics item=metric}
                {assign var="metrics_updated" value=$metric.date}
                <div class="col-md-6 col-sm-12">
                    <h5>{$metric.name}</h5>
                    <div class="progress">
                        <div class="progress-bar {if $metric.percent > 99} progress-bar-danger {else} progress-bar-info {/if}  " role="progressbar" aria-valuenow="{$metric.percent}" aria-valuemin="0" aria-valuemax="{$metric.limit}" style="width: {$metric.percent}%;">
                            <div class="progress-bar_text">{$metric.value} / {$metric.limit} {$metric.unit}</div>
                        </div>
                    </div>
                </div>
            {foreachelse}
                <div class="col-md-12">
                    <p>This account does not have any quota usage collected yet, it will be automatically updated in next cron runs.</p>
                </div>
            {/foreach}
            <div class="col-md-12">
                <small><small>Last updated: <b>{if $metrics_updated}{$metrics_updated|dateformat}{else} n/a {/if}</b></small></small>
                <a href="" onclick="execute_metrics_update({$details.id});return false;"><small>Update now</small></a>
            </div>
            <div id="taskmetrics" style="display:none">
                <h2 style="margin-bottom: 5px;" class="taskname">{$lang.taskrunning} <span>Account metrics update</span></h2>
                <div class="taskindicator" style="display:none;padding:5px;text-align: center">
                    <img src="ajax-loading.gif" alt="" />
                </div>
                <div class="output" style="display:none;">
                    {$lang.taskoutput}
                    <div class="consoleout">
                        <pre></pre>
                    </div>
                </div>
            </div>
            {literal}
                <script>
                    function execute_metrics_update(account_id) {
                        $('#taskmetrics .output').hide();
                        $('#taskmetrics .taskindicator').show();
                        $.facebox({
                            div: '#taskmetrics',
                            opacity: 0.5
                        });
                        $.get("?cmd=configuration&action=executetask", {
                            task: 'updateAccountsMetrics',
                            enforce: true,
                            account_id: account_id
                        }, function (data) {
                            $('#taskmetrics .taskindicator').hide();
                            $('#taskmetrics .output').show();
                            $('#taskmetrics .output pre').text(data);
                        });
                    }
                </script>
            {/literal}
        </div>
    </div>
</div>

{literal}
    <style>
        .account_metrics .progress {
            position: relative;
            box-shadow: none;
            background: #eaeaea;
            height: 20px;
        }
        .account_metrics .progress .progress-bar {
            height: 20px;
        }
        .account_metrics .progress .progress-bar .progress-bar_text {
            margin: 0 10px;
            position: absolute;
            width: 100%;
            left: 0;
            right: 0;
            text-align: center;
            line-height: 20px;
        }
        .account_metrics .progress .progress-bar.progress-bar-info .progress-bar_text {
            color: #000;
        }
        .account_metrics .progress .progress-bar.progress-bar-danger .progress-bar_text {
            color: #fff;
        }
    </style>
{/literal}