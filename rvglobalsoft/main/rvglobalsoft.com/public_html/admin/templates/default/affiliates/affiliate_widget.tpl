<div class="box box-primary" data-widget-id="affiliates_{$widget.report_id}">
    <div class="box-header">
        <h3 class="box-title">
            {$widget.name}
            <i class="fa fa-line-chart pull-left"></i>
        </h3>
    </div>
    <div class="box-body">
        <div>
            <div style="height:300px">
                <canvas id="affiliates_{$widget.report_id}_canvas"></canvas>
            </div>
            <script>
                var widget_affiliates_{$widget.report_id} = function(){literal} { {/literal}
                    var alabels=[];
                    var aseries=[];
                    var avalues=[[]];
                    var acolors=[];
                    var alabel = '{$widget.name|addslashes}';
                    {foreach from=$widget.series item=data key=name name=ser}
                    aseries.push('{$name|addslashes}');
                    acolors.push(HBUtils.getNextColor({$smarty.foreach.ser.iteration-1},1));
                    {foreach from=$data.values item=r name=foo}
                    {if $smarty.foreach.foo.first}
                    avalues[{$smarty.foreach.ser.iteration-1}]=[];
                    {/if}
                    avalues[{$smarty.foreach.ser.iteration-1}].push('{$r}');
                    {/foreach}
                    {/foreach}
                    {foreach from=$widget.series item=data key=name name=ser}
                    {foreach from=$data.labels item=r}
                    alabels.push('{$r}');
                    {/foreach}
                    {break}
                    {/foreach}
                    var ctx = document.getElementById("affiliates_{$widget.report_id}_canvas");
                    {literal}
                    var adatasets=[];
                    for(var i=0; i<avalues.length;i++) {
                        adatasets.push({
                            data: avalues[i],
                            label: aseries[i],
                            backgroundColor: "rgba("+acolors[i]+", 0.31)",
                            borderColor: "rgba("+acolors[i]+", 0.7)",
                            pointBorderColor: "rgba("+acolors[i]+", 0.7)",
                            pointBackgroundColor: "rgba("+acolors[i]+", 0.7)"
                        });
                    }
                    var data = {
                        datasets:  adatasets,
                        labels: alabels
                    };
                    var myChart = new Chart(ctx,{
                        type: 'line',
                        data: data,
                        options: {
                            maintainAspectRatio: false,
                            responsive: true,
                            scales: {
                                yAxes: [{
                                    ticks: {
                                        beginAtZero: true,
                                        stepSize: 1
                                    }
                                }]
                            },
                        }
                    });
                };
                {/literal}
                appendLoader('widget_affiliates_{$widget.report_id}');
            </script>
        </div>
    </div>
</div>