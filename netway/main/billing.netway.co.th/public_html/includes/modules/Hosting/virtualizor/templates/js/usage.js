function usage_init(data, lang) {
    console.log(lang)

    function byteUnit(n, base) {
        base = base || 1024
        var pow = 0;
        while (n > base) {
            n = n / base
            pow++;
        }
        return [n, pow];
    }

    function makedata(data) {
        var fdata = [], i = 1, x;
        for (x in data) {
            fdata.push([i, data[x]]);
            i++;
        }
        return fdata;
    }

    function timeFormatter(x, series) {
        return moment(x * 1000).format(series.delta > 3600 ? 'MMM D LT' : (series.delta > 60 ? 'LT' : 'LTS'))
    }

    function byteFormatter(startAt, sufix, round) {
        startAt = units.indexOf(startAt);
        sufix = sufix || 'B'
        round = Math.pow(10, round === undefined ? 2 : round)

        var byteunit = units.slice(startAt > -1 ? startAt : 0);
        return function (v) {
            var unit = byteUnit(v);
            return (Math.round(unit[0] * round) / round) + ' ' + byteunit[unit[1]] + sufix
        }
    }

    var bandwidth_graph, bandwidth_pie, cpu_graph, cpu_pie, ram_graph, ram_pie, network_graph, disk_graph, disk_pie,
        inodes_pie, inodes_graph, plottimeout,
        units = ['', 'K', 'M', 'G', 'T', 'P'],
        defaultGraph = {
            grid: {
                borderWidth: 0,
                labelMargin: 0,
                axisMargin: 0,
                minBorderMargin: 0
            },
            legend: {
                show: true,
                noColumns: 3,
            },
            series: {
                lines: {
                    show: true,
                    lineWidth: 0.07,
                    fill: true
                }
            },
            xaxis: {
                show: true,
                mode: "time",
                tickFormatter: timeFormatter,
                axisLabelUseCanvas: true,
                axisLabelFontSizePixels: 12,
                axisLabelFontFamily: "Verdana, Arial",
                axisLabelPadding: 10,
            },
            yaxis: {
                show: true,
                min: 0,
                max: null,
                tickFormatter: byteFormatter('M'),
                axisLabelUseCanvas: true,
                axisLabelFontSizePixels: 12,
                axisLabelFontFamily: "Verdana, Arial",
            },
            selection: {
                mode: "x"
            },
            grid: {
                borderWidth: 1,
                borderColor: "#FFF",
                hoverable: true,
            }
        },
        pieChart = {
            series: {
                pie: {
                    innerRadius: 0.6,
                    show: true,
                    radius: 1,
                    label: {
                        show: true,
                        radius: 0
                    }
                }
            },
            grid: {
                hoverable: true,
            },
            legend: {
                show: false,
                position: 'nw'
            }
        };

    function plot_pie(elem, data) {
        var plot = elem.data('plot'), last =0 ;
        if (plot) {
            console.log(elem.attr('id'), 'redraw')
            plot.setData(data)
            plot.draw();
            return;
        }

        var pie = $.extend(true, {}, pieChart);
        pie.series.pie.label.formatter = function (label, series) {
            console.log(elem.attr('id'), label, series.percent, data[0].label)
            return '<span class="pie-value">' + Math.round(series.percent * 10) / 10 + '%</span><span class="pie-label">' + label + '</span>';
        }
        plot = $.plot(elem, data, pie);
        elem.on('plothover', function(event, pos, item){
            if(last === (item && item.seriesIndex || 0))
                return;

            var labels = $('.pieLabel', elem).hide();

            if(item){
                labels.filter('#pieLabel' + item.seriesIndex).show();
                last = item.seriesIndex
            }else {
                labels.eq(0).show()
                last = 0
            }

        })
    }

    function plot_graph(elem, data, options) {
        var plot = elem.data('plot');
        if (plot) {
            plot.setData(data)
            plot.setupGrid();
            plot.draw();
            return;
        }

        options.legend.container = $('<div class="flot-legend-container"></div>')
        plot = $.plot(elem, data, options);
        elem.before(options.legend.container);

        elem.on("plotselected", function (event, ranges) {
            if (ranges.xaxis.to - ranges.xaxis.from < 0.00001) {
                ranges.xaxis.to = ranges.xaxis.from + 0.00001;
            }
            if (ranges.yaxis.to - ranges.yaxis.from < 0.00001) {
                ranges.yaxis.to = ranges.yaxis.from + 0.00001;
            }

            $.each(plot.getXAxes(), function (_, axis) {
                var opts = axis.options;
                opts.min = ranges.xaxis.from;
                opts.max = ranges.xaxis.to;
            });

            plot.setupGrid();
            plot.draw();
            plot.clearSelection();


            if ($(".zoom-out", elem).length) {
                return;
            }

            $('<a class="btn btn-default zoom-out" >Zoom Out</a>')
                .appendTo(elem).click(function (e) {
                e.preventDefault();

                $.each(plot.getXAxes(), function (_, axis) {
                    var opts = axis.options;
                    delete opts.min;
                    delete opts.max;
                });
                plot.setupGrid();
                plot.draw();

                $(this).remove();
            });
        });
    }

    function plothovertooltip(callback) {
        var previousPoint;
        return function (event, pos, item) {
            if (item) {
                if (previousPoint != item.dataIndex) {
                    previousPoint = item.dataIndex;
                    $("#tooltip").remove();
                    showTooltip(item.pageX, item.pageY,
                        callback(item));
                }
            } else {
                $("#tooltip").remove();
                previousPoint = null;
            }
        }
    }

    function plot_cpu(cpudata, cpu_data) {
        if(!cpu_graph.is(':visible'))
            return;

        plot_pie(cpu_pie, [
            {label: lang.used, data: cpudata['cpu']['percent']},
            {label: lang.Free, data: cpudata['cpu']['percent_free']}
        ]);

        $('#cpulimit').text(cpudata['cpu']['limit']);
        $('#cppercent').text(cpudata['cpu']['percent']);
        $('#cpuman').text(cpudata['cpu']['manu']);

        var graph = $.extend(true, {}, defaultGraph);
        graph.yaxis.tickFormatter = function (v) {
            return v + " %";
        };
        graph.yaxis.max=100;

        plot_graph(cpu_graph, [
            {label: lang.cpu_usage, data: cpu_data}
        ], graph)
    }

    function plot_ram(ramdata, ram_data) {
        if(!ram_graph.is(':visible'))
            return;

        plot_pie(ram_pie, [
            {label: lang.used, data: ramdata['percent']},
            {label: lang.Free, data: ramdata['percent_free']}
        ]);


        $('#ramlimit').text(ramdata['limit'] + ' MB');
        $('#swap_val').text((ramdata['burst'] || ramdata['swap']) + ' MB');
        $('#ramused').text(ramdata['used'] + ' MB');
        $('#raminpercent').text(ramdata['percent'] + '%');

        var graph = $.extend(true, {}, defaultGraph);
        graph.yaxis.tickFormatter = byteFormatter('M');
        graph.yaxis.byte = 3;

        plot_graph(ram_graph, [
            {label: lang.memory_usage, data: ram_data, color: "#ccff33"}
        ], graph)
    }

    function plot_disk(diskdata, disk_data, inode_data) {
        if(!disk_graph.is(':visible'))
            return;

        plot_pie(disk_pie, [
            {label: lang.used, data: diskdata['disk']['used_gb']},
            {label: lang.Free, data: diskdata['disk']['free_gb']}
        ]);

        plot_pie(inodes_pie, [
            {label: lang.used, data: diskdata['inodes']['used']},
            {label: lang.Free, data: diskdata['inodes']['free']}
        ]);

        $('#disk_limit').text(diskdata['disk']['limit_gb'] + ' GB');
        $('#disk_used').text(diskdata['disk']['used_gb'] + ' GB');
        $('#disk_percent').text(diskdata['disk']['percent'] + ' %');

        $('#inod_limit').text(diskdata['inodes']['limit']);
        $('#inod_used').text(diskdata['inodes']['used']);
        $('#inod_percent').text(diskdata['inodes']['percent'] + ' %');

        var graph = $.extend({}, defaultGraph);
        graph.yaxis.tickFormatter = byteFormatter('M');
        graph.yaxis.byte = 3;

        plot_graph(disk_graph, [
            {label: lang.disk_usage, data: disk_data, color: "#ff6600"}
        ], graph)

        var inodegr = $.extend(true, {}, defaultGraph);
        inodegr.yaxis.tickFormatter = '';

        plot_graph(inodes_graph, [
            {label: lang.inode_usage, data: inode_data, color: "#80b3ff"}
        ], inodegr)
    }

    function plot_network(netdata, ntw_in_data, ntw_out_data, ntw_total_data) {
        if(!network_graph.is(':visible'))
            return;

        var avg;
        avg = byteUnit(netdata.avg_download * 8)
        $("#avg_download").text(Math.round(avg[0]) + ' ' + units[avg[1]] + "bps");

        avg = byteUnit(netdata.avg_upload * 8)
        $("#avg_upload").text(Math.round(avg[0]) + ' ' + units[avg[1]] + "bps");

        var graph = $.extend(true, {}, defaultGraph),
            bit = byteFormatter('', 'bps', 0)
        graph.yaxis.tickFormatter = function (v) {
            return bit(v * 8)
        };

        plot_graph(network_graph, [
            {label: lang.netspeed_total, data: ntw_total_data},
            {label: lang.netspeed_in, data: ntw_in_data, color: "#0077FF"},
            {label: lang.netspeed_out, data: ntw_out_data, color: "#0000A0"},

        ], graph)
    }

    function plot_bandwidth(data){
        if(!bandwidth_graph.length || !bandwidth_graph.is(':visible'))
            return;

        plot_pie(bandwidth_pie, [
            {label: lang.used, data: data.used},
            {label: lang.Free, data: data.free}
        ]);

        $('#bandwidth_total').text(data.limit_gb + ' GB');
        $('#bandwidth_use').text(data.used_gb + ' GB');
        $('#bandwidth_percent').text(data.percent + ' %');

        var graph = $.extend(true, {}, defaultGraph)
        //graph.yaxis.tickFormatter = byteFormatter('', 'bps', 0);

        graph.xaxis.mode = null;
        graph.xaxis.tickFormatter = null;
        graph.xaxis.tickDecimals = false;

        console.log(data);
        plot_graph(bandwidth_graph, [
            {label: lang.bandwidth_total, data: data.usage},
            {label: lang.bandwidth_in, data: data.in},
            {label: lang.bandwidth_out, data: data.out},
        ], graph)
    }


    function showTooltip(x, y, contents) {
        $('<div id="tooltip">' + contents + '</div>').css({
            position: "absolute",
            display: "none",
            top: y + 20,
            left: x - 20,
            border: "1px solid #CCCCCC",
            padding: "2px",
            backgroundColor: "#EFEFEF",
            zIndex: 10000,
            opacity: 0.80
        }).appendTo("body").fadeIn(200);
    }

    function plot(stats) {
        $.extend(data, stats);
        clearTimeout(plottimeout)

        plot_cpu(stats.cpu, stats.series.cpu)
        plot_ram(stats.ram, stats.series.ram)
        plot_disk(stats.disk, stats.series.disk, stats.series.inode)
        plot_network(stats.net, stats.series.net_in, stats.series.net_out, stats.series.net_total)

        if(stats.hasOwnProperty('bandwidth'))
            plot_bandwidth(stats.bandwidth)

        plottimeout = setTimeout(function () {
            $.get(window.location.href, plot);
        }, 30000)
    }

    $(function () {

        bandwidth_graph = $("#bandwidth_graph");
        bandwidth_pie = $("#bandwidth_pie");
        cpu_graph = $("#cpu_graph");
        cpu_pie = $("#cpu_pie");
        ram_graph = $("#ram_graph");
        ram_pie = $("#ram_pie");
        network_graph = $("#network_graph");
        disk_graph = $("#disk_graph");
        disk_pie = $("#disk_pie");
        inodes_pie = $('#inodes_pie');
        inodes_graph = $('#inodes_graph');

        bandwidth_graph.on("plothover", plothovertooltip(function (item) {
            var x = item.datapoint[0].toFixed(2),
                y = item.datapoint[1].toFixed(2);
            return item.series.label + " : " + parseInt(y) + " MB <br> Day : " + parseInt(x);
        }));

        cpu_graph.add(inodes_graph).on("plothover", plothovertooltip(function (item) {
            return item.datapoint[1].toFixed(2) + ' at ' + moment(item.datapoint[0] * 1000).format('LLL');
        }));

        disk_graph.add(ram_graph).on("plothover", plothovertooltip(function (item) {
            return parseInt(item.datapoint[1]) + ' MB at ' + moment(item.datapoint[0] * 1000).format('LLL');
        }));

        network_graph.on("plothover", plothovertooltip(function (item) {
            var yval = parseInt(item.datapoint[1] * 8),
                time = moment(item.datapoint[0] * 1000).format('LLL'),
                unit = byteUnit(yval);
            return item.series.label + " " + unit[0].toFixed(2) + " " + units[unit[1]] + "bps at " + time;
        }));

        $usage = $('.usage')
        $(window).on('hashchange', function() {
            $usage.hide().filter('.usage-' + window.location.hash.replace('#', '')).show();
            plot(data)
        }).trigger('hashchange')
    })
}

