<div class="wbox account_metrics">
    <div class="wbox_header">Quota usage</div>
    <div class="wbox_content">
        {foreach from=$metrics item=metric}
            {assign var="metrics_updated" value=$metric.date}
            <div class="mb-4">
                <div>{$metric.name}</div>
                <div class="progress">
                    <div class="progress-bar {if $metric.percent > 99} bg-danger {/if}" role="progressbar" aria-valuenow="{$metric.percent}" aria-valuemin="0" aria-valuemax="{$metric.limit}" style="width: {$metric.percent}%;">
                        <div class="progress-bar_text"><span>{$metric.value} / {$metric.limit} {$metric.unit}</span></div>
                    </div>
                </div>
            </div>
        {foreachelse}
            <p>{$lang.nothing}</p>
        {/foreach}
        {if $metrics_updated}
            <div>
                <small><small>Last updated: <b>{$metrics_updated|dateformat}</b></small></small>
            </div>
        {/if}
    </div>
</div>

{literal}
    <style>
        .account_metrics .progress {
            position: relative;
            box-shadow: none;
            background: #eaeaea;
            height: 22px;
        }
        .account_metrics .progress .progress-bar {
            height: 22px;
            background-color: #147df0;
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
        .account_metrics .progress .progress-bar.white .progress-bar_text {
            color: white;
        }
        .account_metrics .progress .progress-bar.gray .progress-bar_text {
            color: #555;
        }
    </style>
    <script>
        $(function () {
            $('.account_metrics .progress').each(function () {
                var s = $(this),
                    t = s.find('.progress-bar_text'),
                    ts = t.find('span'),
                    p = s.find('.progress-bar');
                if (p.width() >= ((t.width() / 2) + (ts.width() / 2)) ) {
                    p.removeClass('gray').addClass('white');
                } else {
                    p.removeClass('white').addClass('gray');
                }
            });
        });
    </script>
{/literal}


