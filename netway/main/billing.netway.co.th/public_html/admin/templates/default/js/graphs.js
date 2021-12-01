$(function () {
    var url = "?cmd=graphs&rel_id=" + graph_rel_id + "&rel_type="+graph_rel_type;

    loadbandwidthMgr();

    if (window.graphInit)
        return;
    window.graphInit = true;


    function loadbandwidthMgr() {
        if($('.gw-unassign','#gw-assigned-graphs').length)
            return true;

        var featured = $('#gw-assigned-graphs').data('featured');
        $.post(url , {
            action: 'loadassignments',
            featured: featured
        }, function(data){
            $('#gw-assigned-graphs').html(data);
            $('#gw-graph-blank').toggle($('.col-graph', '#gw-assigned-graphs').length == 0);
        });
        return false;
    }

    function loadbandwidthPorts() {
        var dialog, devices, ports;
        dialog = bootbox.dialog({
            message: $('#add-graph-window').html(),
            title: 'Assign new graph',
            buttons: {
                cancel: {
                    label: 'Cancel',
                    className: 'btn-default'
                },
                confirm: {
                    label: 'Assign',
                    className: 'btn-success',
                    callback: function (e) {
                        var port_id = $('#gw-ports-select', dialog).val();
                        var graph_type = port_id ? $('#gw-port-graphs-select', dialog).val() : $('#gw-device-graphs-select', dialog).val();

                        var options = $('[name*=options]',dialog).serialize();
                        $.post(url + '&action=assign&'+options, {
                            server_id: $('#gw-app-select', dialog).val(),
                            port_id: port_id,
                            device_id: $('#gw-device-select', dialog).val(),
                            type: graph_type,
                            show_client: $('#gw-show-client', dialog).is(':checked') ? 1 : 0,
                            name: $('#gw-name', dialog).val()
                        }, loadbandwidthMgr);

                        return true;
                    }
                }
            }
        });

        var titlechanged=false;
        $('#gw-name',dialog).on('keyup',function(){
            titlechanged=true;
        });
        $('#gw-period',dialog).on('change',title);
        $('.btn-success', dialog).prop("disabled", true);

        dialog.modal('show');

        function loader(show) {
            if(show) {
                dialog.find('.gw-port-preload').show();
            } else {

                dialog.find('.gw-port-preload').hide();
            }
        }



        function renderApps(data) {
            loader(false);
            $('#gw-app',dialog).html(data);
            $('#gw-app-select',dialog).change(function(){
                var app_id = $(this).val();
                if(app_id==0) {
                    $('#gw-devices',dialog).html("");
                    return;
                } else {
                    loader(true);
                    $.post(url + '&action=devices', {
                        server_id: app_id
                    }).done(renderDevices).fail(function () {
                        dialog.find('.bw-port-preload')
                            .text('Error: unable to load devices').show();
                    });

                }
            }).chosenedge({width: '100%'});
        }


        function title() {
            if(titlechanged)
                return;

            var device = $('#gw-device-select',dialog);


            if(device.val()==0)
                return;

            var device_type = $('#gw-device-graphs-select',dialog);
            var ports_type = $('#gw-port-graphs-select',dialog);
            var ports = $('#gw-ports-select',dialog).val();
            var period = $('#gw-period',dialog);

            var title = $('option:selected',device).text();
            if(ports) {
                title = title + " "+$('option:selected',ports_type).text();
            } else if(device_type.val()!=0) {
                title = title + " "+$('option:selected',device_type).text();
            }
            title = title + ", "+ $('option:selected',period).text();
            $('#gw-name',dialog).val(title);
        }

        function renderDevices(data) {

            loader(false);
            var data = parse_response(data);

            $('#gw-devices',dialog).html(data);
            $('#gw-device-select',dialog).change(function(){

                title();
                var device_id = $(this).val();
                var app_id = $('#gw-app-select',dialog).val();
                if(device_id == 0) {

                    $('#gw-options',dialog).hide();
                    $('#gw-device-graphs',dialog).html("");
                    return;
                } else {

                    loader(true);
                    $('#gw-options',dialog).show();
                    $.post(url + '&action=devicegraphs', {
                        server_id: app_id,
                        device_id: device_id
                    }).done(renderPorts).fail(function () {
                        dialog.find('.bw-port-preload')
                            .text('Error: unable to load ports').show();
                    });

                }
            }).chosenedge({width: '100%'});
        }

        function renderPorts(data) {

            loader(false);
            var data = parse_response(data);
            $('#gw-device-graphs',dialog).html(data);
            $('#gw-device-graphs-select',dialog).change(function(){

                title();
                if($(this).val()!=0) {
                    $('#gw-port-graphs',dialog).hide();
                    $('#gw-ports',dialog).hide();
                } else {
                    $('#gw-port-graphs',dialog).show();
                    $('#gw-ports',dialog).show();
                }
            }).chosenedge({width: '100%'});
            $('.btn-success', dialog).prop("disabled", false);
            var loaded = false;

            $('#gw-ports-select',dialog).change(function(){
                var port_id = $(this).val();
                var app_id = $('#gw-app-select',dialog).val();
                var device_id = $('#gw-device-select',dialog).val();
                if(!port_id || loaded) {
                    return;
                } else {
                    loader(true);
                    $.post(url + '&action=portgraphs', {
                        server_id: app_id,
                        device_id: device_id,
                        port_id: port_id
                    }).done(function(data){
                        loaded = true;
                        renderPortGraphs(data);
                    }).fail(function () {
                        dialog.find('.bw-port-preload')
                            .text('Error: unable to load port graphs').show();
                    });

                }
            }).chosenedge({width: '100%'});

        }

        function renderPortGraphs(data) {
            loader(false);
            var data = parse_response(data);
            $('#gw-port-graphs',dialog).html(data);
            $('#gw-port-graphs-select',dialog).change(title).chosenedge({width: '100%'});
        }


        $.post(url + '&action=apps', {}).done(renderApps).fail(function () {
            dialog.find('.bw-port-preload')
                .text('Error: unable to apps').show();
        });

        return false;
    }



    function  unassignbandwidthPort(ID) {
        if (!confirm('Are you sure you wish to unassign this graph? ')) {
            return false;
        }
        $.post(url + '&action=unassign', {
            graph_id: ID,
        }, function(){
            $('[data-id='+ID+']').parents('.box').eq(0).remove();
        });

        return false;

    }

    var view = $('#gw-manager');

    view.on('click', '.btn-add-graph', function () {
        loadbandwidthPorts();
        return false;
    })
    $('#gw-assigned-graphs').on('click', '.gw-unassign', function () {
        var self = $(this),
            data = self.data();
        unassignbandwidthPort(data.id, this)
        return false;
    });

    $('#gw-assigned-graphs').on('click', '.gw-pin', function () {
        var self = $(this),
            data = self.data();
        $.post(url,{action:'toggleflag',flag:1,graph_id:data.id});
        $(this).toggleClass('active');
        $(this).find('i').toggleClass('fa-star').toggleClass('fa-star-o');
        return false;
    });
    $('#gw-assigned-graphs').on('click', '.gw-refresh', function () {
        var self = $(this),
            data = self.data();
        var src = '?cmd=graphs&action=show&refresh=1&graph_id='+data.id;
        self.parents('.box').find('img').replaceWith(
            '<img src="'+src+'" class="img-responsive center-block" />'
        );
        return false;
    });

})