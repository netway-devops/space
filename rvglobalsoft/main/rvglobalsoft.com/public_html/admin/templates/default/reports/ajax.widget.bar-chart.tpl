<div style="height:300px">
    <canvas id="bar_{$widget.id|replace:".":""}"></canvas>
</div>
<script>


    var pie_{$widget.id|replace:".":""} = function(){literal} {
        {/literal}

        var alabels=[];
        var aseries=[];
        var avalues=[[]];
        var acolors=[];
        var alabel = '{$widget.name|addslashes}'
        {foreach from=$series item=data key=name name=ser}
             aseries.push('{$name|addslashes}');
             acolors.push({if $data.color[0]}'{$data.color[0]}'{else}HBUtils.getNextColor({$smarty.foreach.ser.iteration-1}){/if});
             {foreach from=$data.values item=r name=foo}
                    {if $smarty.foreach.foo.first}
                    avalues[{$smarty.foreach.ser.iteration-1}]=[];
                    {/if}
                    avalues[{$smarty.foreach.ser.iteration-1}].push('{$r}');
            {/foreach}
        {/foreach}
        {foreach from=$series item=data key=name name=ser}
            {foreach from=$data.labels item=r}
                alabels.push('{$r}');
            {/foreach}
            {break}
        {/foreach}

        var ctx = document.getElementById("bar_{$widget.id|replace:".":""}");
        {literal}
        var adatasets=[];
        for(var i=0; i<avalues.length;i++) {
            adatasets.push({
                data: avalues[i],
                label: aseries[i],
                backgroundColor: acolors[i]
            });
        }
        var data = {
            datasets:  adatasets,
            labels: alabels
        };
        var myPieChart{/literal}{$widget.id|replace:".":""}{literal} = new Chart(ctx,{
            type: 'bar',
            data: data,
            options: {
                maintainAspectRatio: false,
                responsive: true,
                scales: {
                    yAxes: [{
                        ticks: {
                            beginAtZero: true
                        }
                    }]
                },
                {/literal}{if $cachedon}
                title: {literal}{{/literal}
                    display: true,
                    text: 'Report generated on: {$cachedon}',
                    position: 'bottom',
                    fontStyle: '',
                    fontSize: 10,
                    padding: 1
                    {literal}}{/literal}
                {/if} {literal}
            }
        });
        $('[data-widget-group]').on( "sortstop", function( event, ui ) {
            myPieChart{/literal}{$widget.id|replace:".":""}{literal}.resize();
        } );
    };
    {/literal}
        {if $ajax}
            pie_{$widget.id|replace:".":""}();
        {else}
             appendLoader('pie_{$widget.id|replace:".":""}');
        {/if}

</script>