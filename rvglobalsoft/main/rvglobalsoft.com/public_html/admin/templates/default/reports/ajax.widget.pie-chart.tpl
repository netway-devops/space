<canvas id="pie_{$widget.id|replace:".":""}"></canvas>
<script>

    var pie_{$widget.id|replace:".":""} = function(){literal} {
        {/literal}

        var alabels=[];
        var avalues=[];
        var acolors=[];
        var alabel = '{$widget.name}'
        {foreach from=$series item=data key=name}
            {foreach from=$data.labels item=r}
                alabels.push('{$r}');
            {/foreach}
            {foreach from=$data.values item=r}
                avalues.push('{$r}');
            {/foreach}

            {foreach from=$data.values key=k item=r}
                acolors.push(HBUtils.getNextColor({$k}));
            {/foreach}
        {/foreach}


        var ctx = document.getElementById("pie_{$widget.id|replace:".":""}");
        {literal}
        var data = {
            datasets: [{
                data: avalues,
                backgroundColor: acolors,
                label: alabel // for legend
            }],
            labels: alabels
        };

        var myPieChart = new Chart(ctx,{
            type: 'pie',
            data: data,
            options: {
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
    }
    {/literal}
    {if $ajax}
        pie_{$widget.id|replace:".":""}();
    {else}
        appendLoader('pie_{$widget.id|replace:".":""}');
    {/if}

</script>