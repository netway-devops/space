$(function () {
    var url = "?cmd=" + bwModule.module,
        account_id = $('#account_id').val();

    ajax_update(url + '&action=billingdata&account_id=' + account_id, {}, '#bandwidth_billing');

    if (window.bandwidthInit)
        return;
    window.bandwidthInit = true;

    function loadbandwidthMgr() {
        ajax_update(url + '&action=accountdetails', {
            id: $('#account_id').val(),
            loadbyajax: true
        }, '#bandwidth-mgr');

        $('#blank_bandwidth').toggle($('.bw-unasign', '#bandwidth-mgr').length == 0);
    }

    function loadbandwidthPorts() {
        var dialog, devices, ports;
        dialog = bootbox.dialog({
            message: $('#add_bandwidth').html(),
            title: 'Assign new switch & port fom bandwidth',
            buttons: {
                cancel: {
                    label: 'Cancel',
                    className: 'btn-defaultr'
                },
                confirm: {
                    label: 'Assign',
                    className: 'btn-success',
                    callback: function (e) {
                        var switch_id = $('#bw-switch', dialog),
                            port_id = $('#bw-port', dialog);

                        $.post(url + '&action=addassignment', {
                            account_id: account_id,
                            switch_id: switch_id.val(),
                            port_id: port_id.val(),
                            server_id: $('.server-id', dialog).val(),
                            billforit: $('#billforit', dialog).is(':checked') ? 1 : 0,
                            switch_name: $('option:selected', switch_id).text(),
                            port_name: $('option:selected', port_id).text()
                        }, loadbandwidthMgr);

                        return true;
                    }
                }
            }
        });

        $('.btn-success', dialog).prop("disabled", true);
        devices = dialog.find('#bw-switch');
        ports = dialog.find('#bw-port');

        var assigned = $('.bw-load-graphs').map(function () {
            var x = $(this).data();
            return x.server + '_' + x.device + '_' + x.port;
        }).get();

        function renderDevices(data) {
            if (!data.switches || !data.switches.length) {
                dialog.find('.bw-port-preload')
                    .attr('class', 'alert alert-warning')
                    .text('Unable to load switches from related App')
                return;
            }

            $.each(data.switches, function (key, swch) {
                var device_id = swch.hasOwnProperty('id') ? swch.id : swch.device_id,
                    device_name = swch.hasOwnProperty('description') ? swch.description + ' - ' + swch.hostname : swch.hostname,
                    device = $('<option value="' + device_id + '">' + device_name + '</option>');

                device.data('switch', swch);
                devices.append(device);
                //list[device_id] = '';
            })

            devices.trigger("chosen:updated")
                .on('change', renderPorts)
                .trigger('change');

            dialog.find('.server-id').val(data.graph_server);
            dialog.find('.bw-port-preload').hide()
                .next().show();
        }

        function renderPorts() {
            var self = $(this),
                device_id = self.val();
            
            ports[0].innerHTML = '';
            ports.trigger("chosen:updated");
            
            $.post(url + '&action=loadswitchportsjs', {
                account_id: account_id,
                device_id: device_id,
            }).done(function (data) {
                if (!data.ports)
                    return false;

                var html = '';
                $.each(data.ports, function (k, i) {
                    if(!k)
                        return;
                    
                    var name = !i ? '' : (typeof i === 'object' && i.hasOwnProperty('ifName') ? i.ifName : i),
                        portkey = data.graph_server + '_' + device_id + '_' + k;

                    if (assigned.indexOf(portkey) !== -1)
                        return;

                    html += '<option value="' + k + '">#' + k + ' ' + name + '</option>';
                })
                ports[0].innerHTML = html;
                ports.data('ports', data)
                    .val('').trigger("chosen:updated");
            }).fail(function () {
                dialog.find('.bw-port-preload')
                    .text('Error: unable to load ports for related device')
            }).always(function(){
                
            });
        }
 
        devices.chosenedge({width: '100%'})
        ports.chosenedge({
            width: '100%', 
            enable_split_word_search: true,
            placeholder_text_single: 'Loading ports .. '
        });

        $('.btn-success', dialog).prop("disabled", false);

        $.post(url + '&action=loadswitchjs', {
            account_id: account_id
        }).done(renderDevices).fail(function () {
            dialog.find('.bw-port-preload')
                .text('Error: unable to load switches from related App')
        });

        return false;
    }

    function showbandwidthGraphs(sw, p, btn) {
        $(btn).toggleClass('active');
        var imurl = url + "&action=showgraph&account_id="
            + account_id + "&switch_id=" + sw + "&port_id=" + p;

        var target = $('#graphs_' + sw + '_' + p).toggle();

        if (target.hasClass('loaded'))
            return false;

        var width = Math.min(target.width(), 900);
        imurl += "&width=" + width + "&height=" + Math.floor(width * 0.33);

        target.addClass('loaded');

        var createImg = function(type){
            var img = document.createElement('img');
            img.src = imurl + '&type=' + type;

            $(img).on('load', function (type) {
                target.width(img.width);
            });

            return img;
        };

        $('.ldaily', target).append(createImg('daily'));
        $('.lweekly', target).append(createImg('weekly'));
        $('.lmonthly', target).append(createImg('monthly'));

        return false;
    }


    function  unassignbandwidthPort(ID) {
        if (!confirm('Are you sure you wish to unassign this port? This may change billing totals')) {
            return false;
        }
        $.post(url + '&action=rmassignment', {
            account_id: account_id,
            graph_id: ID,
        }, loadbandwidthMgr);

        return false;

    }

    var view = $('#bandwidth-mgr');
    view.on('click', '.bandwidth-add-port', function () {
        loadbandwidthPorts();
        return false;
    });
    view.on('click', '.bw-unasign', function () {
        var self = $(this),
            data = self.data();
        unassignbandwidthPort(data.id, this);
        return false;
    });
    view.on('click', '.bw-load-graphs', function () {
        var self = $(this),
            data = self.data();
        showbandwidthGraphs(data.device, data.port, this);
        return false;
    });
    view.on('click', '.bw-load-ports', function () {
        var self = $(this);
        loadbandwidthPorts()
        return false;
    })
});