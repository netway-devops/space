$(function () {
    var dediview = $('#dedimgr'),
        menutpl = $('#qm-port-menu'),
        portstatus = {
            NIC: {
                '0': 'down',
                '1': 'up',
                '-1': 'unknown'
            },
            PDU: {
                '0': 'off',
                '1': 'on',
                '-1': 'unknown'
            }
        };
    dediview.on('click', '.dropdown', function () {
        var self = $(this);
        if (self.is('.open'))
            return false;
        self.append(menutpl);
    })

    dediview.on('click', '#qm-port-menu a[href]', function () {
        var self = $(this),
            action = self.attr('href').substr(1),
            data = self.parents('.dropdown:first').data(),
            ports = $('.dropdown[data-port-id="' + data.portId + '"]');
        ports
            .find('.qm-port').addClass('disabled')
            .find('.status').text('Loading..');
        $.post('?cmd=dedimgr&do=quickmanage', {
            port_id: data.portId,
            togglePort: action
        }, function (data) {
            $('.dropdown.open').removeClass('open');
            if (!data.port)
                return;
            var status = portstatus[data.port.type][data.port.port_status];
            ports.find('.qm-port').attr('class', 'btn btn-xs qm-port qm-port-' + status).end()
                .find('.status').text(status);
        });
    })

    dediview.on('click', '.qm-graphs', function () {
        var self = $(this),
            data = self.data(),
            html = '<div class="row">',
            types = ['daily', 'weekly', 'monthly'],
            tpl = '<div class="bandwidth-graph"><img src="?cmd='
            + 'graphs&action=show&graph_id=$id'
            + '&type=$type" title="$name" alt="$name'
            + 'bandwidth graph"/></div>';

        $.each(data.sources, function () {
            html += '<div class="col-md-6">';
            html += '<h4>' + this.name + '</h4>';
            // if (this.rel_type == 'Hosting') {
            //     for (var i = 0; i < 3; i++) {
            //         var title = types[i].charAt(0).toUpperCase() + types[i].slice(1)
            //         html += tpl.replace('$id', this.graph_id)
            //             .replace('$type', types[i])
            //             .replace(/\$name/g, title)
            //     }
            // } else {
                html += tpl.replace('$id', this.graph_id)
                    .replace('$type','daily')
                    .replace(/\$name/g, this.name)
            // }
            html+="</div>";

        });

        bootbox.dialog({
            message: html + "</div>",
            size: 'large',
            closeButton: true
        })
    });

    // dediview.on('click', '.qm-item', function () {
    //     editRackItem($(this).data('id'))
    //     return false;
    // })

    $(document).on('submit', '#facebox #saveform', function () {
        var form = $(this),
            data = form.serializeForm();

        $('#updater').addLoader();
        $(document).trigger('close.facebox');

        $.post(form.attr('action'), data, function () {
            $.post($('#currentlist').attr('href'), {
                page: $.fn.pagination.getPage()
            }, function (data) {
                $('#updater').html(parse_response(data));
            });
        })
        return false;
    });

    function popoverClose(e) {
        var target = $(e.target);
        console.log('click.close.popover', target)
        //did not click a popover toggle, or icon in popover toggle, or popover
        if (!target.is('.popover')
            && target.closest('.popover').length === 0
            && target.closest('.popover.in').length === 0) {

            $('.popover').popover('hide');
            $(document).off('click.close.popover')
        }
    }

    dediview.on('click', '.qm-show-more-ports', function () {
        var self = $(this),
            popover = self.data('bs.popover');
        if (popover) {
            if (popover.$tip.is('.in')) {
                self.popover('hide');
                return;
            } else {
                $('.popover').popover('hide');
                self.popover('show');
            }
        } else {
            var items = self.parent()
                .children(":nth-child(4) ~ .dropdown")
            popover = self.popover({
                title: 'Device Ports',
                content: $('<div class="qm-more-ports"></div>').append(items),
                html: true,
                placement: 'bottom',
                trigger: 'manual',
                container: dediview
            }).data('bs.popover');

            self.one('inserted.bs.popover', function () {
                popover.$tip
                    .addClass('qm-more')
                    .find('.popover-title').remove();
            })
            $('.popover').popover('hide');
            self.popover('show');
        }

        $(document).on('click.close.popover', popoverClose);
        return false;
    })


    dediview.on('click', '.qm-ips-list .btn', function () {
        var self = $(this),
            popover = self.data('bs.popover');

        if (popover) {
            if (popover.$tip.is('.in')) {
                self.popover('hide');
                return;
            } else {
                $('.popover').popover('hide');
                self.popover('show');
            }
        } else {
            var items = self.parent()
                .children(":nth-child(1) ~ span").append(', ')
            popover = self.popover({
                content: items,
                html: true,
                placement: 'bottom',
                trigger: 'manual',
                container: dediview
            }).data('bs.popover');

            self.one('inserted.bs.popover', function () {
                popover.$tip
                    .addClass('qm-more')
                    .find('.popover-title').remove();
            })
            $('.popover').popover('hide');
            self.popover('show');
        }

        $(document).on('click.close.popover', popoverClose);
        return false;
    });

    $('#filter-items').on('click', function () {
        var modal = $('#filter-modal'),
            dialog = bootbox.dialog({
                message: '<br />',
                closeButton: true,
                title: 'Filter Items',
                show: false,
                buttons: {
                    cancel: {
                        label: 'Cancel',
                        className: 'btn-defaultr'
                    },
                    confirm: {
                        label: 'Apply',
                        className: 'btn-success',
                        callback: function (e) {
                            filter(dialog.find('form')[0])
                            return true;
                        }
                    }
                }
            })
        dialog.find(".bootbox-body").append(modal.clone().show());
        dialog.modal('show')

    })
})