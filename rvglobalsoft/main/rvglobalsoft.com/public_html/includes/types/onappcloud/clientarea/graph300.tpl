<html lang="en">
    <head>
        <meta charset="utf-8" />
        <script type="text/javascript" src="{$system_url}includes/types/onappcloud/js/jquery.js"></script>
        <script type="text/javascript" src="{$address}/assets/highcharts/highcharts.js"></script>
    </head>
    <body class="" >
        <div id="highcharts-chart" style="text-align:center"></div>
        <div id="highcharts-disk_usage" style="text-align:center"></div>
        {literal}
        <script type="text/javascript">

            $(document).ready(function(){
                new Highcharts.Chart({
                     
                    credits: {enabled: false}, 
                    chart: {height: 300, renderTo: 'highcharts-chart', defaultSeriesType: 'line', zoomType: 'x', width: 700}, 
                    xAxis: {type: 'datetime', labels: {formatter: function() { return Highcharts.dateFormat("%e %b %H:%M", this.value); }}}, 
                    plotOptions: {series: {marker: {states: {hover: {enabled: true}}, enabled: false, lineWidth: 0}}},
                    lang: {downloadPNG: 'Download PNG image', printButtonTitle: 'Print the chart', downloadJPEG: 'Download JPEG image', weekdays: ['Sunday', 'Monday', 'Tuesday', 'Wednesday', 'Thursday', 'Friday', 'Saturday'], downloadPDF: 'Download PDF document', loading: 'Loading....', downloadSVG: 'Download SVG vector image', months: ['January', 'February', 'March', 'April', 'May', 'June', 'July', 'August', 'September', 'October', 'November', 'December'], shortMonths: ['Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun', 'Jul', 'Aug', 'Sep', 'Oct', 'Nov', 'Dec'], resetZoomTitle: 'Reset zoom level 1:1', exportButtonTitle: 'Export to raster or vector image', decimalPoint: '.', thousandsSep: 3, resetZoom: 'Reset zoom'},
                {/literal}{if $vpsdo=='showcpuusage'}{literal}
                    title: {text: 'Hourly', x: -20},
                    yAxis: {title: {text: null}}, tooltip: {crosshairs: true, shared: true}, 
                    series: [{data: {/literal}{$xaxis}{literal}, name: 'CPU Usage (Cores)'}]
                {/literal}{elseif $vpsdo=='shownetworkusage'}{literal}
                    title: {text: 'Hourly', x: -20},
                    yAxis: {title: {text: 'Mbps'}}, tooltip: {crosshairs: true, shared: true}, 
                    series: [{data: {/literal}{$sentaxis}{literal}, name: 'Data Sent'},  {data: {/literal}{$receivedaxis}{literal}, name: 'Data Received'}]
                {/literal}{elseif $vpsdo=='showdiskusage'}{literal}
                    title: {text: 'Hourly IOPS'},
                    yAxis: {title: {text: null}}, tooltip: {shared: true, crosshairs: true}, 
                    series: [{data: {/literal}{$iops_reads}{literal}, name: 'Reads'}, {data: {/literal}{$iops_writes}{literal}, name: 'Writes'}]
                {/literal}{/if}{literal}
                    });
                
                {/literal}{if $vpsdo=='showdiskusage'}{literal}
                 new Highcharts.Chart({
                    title: {text: 'Hourly data written/read', x: -20}, 
                    credits: {enabled: false}, 
                    chart: {height: 300, renderTo: 'highcharts-disk_usage', defaultSeriesType: 'line', zoomType: 'x', width: 700}, 
                    yAxis: {title: {text: 'MB'}}, 
                    xAxis: {type: 'datetime', labels: {formatter: function() { return Highcharts.dateFormat("%e %b %H:%M", this.value); }}}, 
                    tooltip: {shared: true, crosshairs: true}, plotOptions: {series: {marker: {states: {hover: {enabled: true}}, enabled: false, lineWidth: 0}}}, 
                    series: [{data: {/literal}{$data_read}{literal}, name: 'Data Read'}, {data: {/literal}{$data_write}{literal}, name: 'Data Written'}], 
                    lang: {printButtonTitle: 'Print the chart', downloadPDF: 'Download PDF document', weekdays: ['Sunday', 'Monday', 'Tuesday', 'Wednesday', 'Thursday', 'Friday', 'Saturday'], downloadSVG: 'Download SVG vector image', shortMonths: ['Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun', 'Jul', 'Aug', 'Sep', 'Oct', 'Nov', 'Dec'], loading: 'Loading....', decimalPoint: '.', thousandsSep: 3, months: ['January', 'February', 'March', 'April', 'May', 'June', 'July', 'August', 'September', 'October', 'November', 'December'], downloadPNG: 'Download PNG image', resetZoomTitle: 'Reset zoom level 1:1', exportButtonTitle: 'Export to raster or vector image', resetZoom: 'Reset zoom', downloadJPEG: 'Download JPEG image'}
                });
                {/literal}{/if}{literal}
            });
        </script>
        {/literal}
    </body>
</html>


