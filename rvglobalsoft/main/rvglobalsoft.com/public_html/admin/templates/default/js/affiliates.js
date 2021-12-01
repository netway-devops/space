$(function () {
    $('#landingurl_disable').on('click change', function () {
        var self = $(this);
        self.prevAll('input').prop('disabled', self.is(':checked'));
    }).trigger('change');

    $('.commission-val').change(function () {
        var self = $(this),
            data = self.data(),
            accept = self.parents('tr').eq(0).find('.acceptref');

        accept.attr('href', accept.attr('href').replace(/&amount=[^&]*/, '')
            + '&amount=' + self.val());

        if (!data.save) {
            data.save = $('<a style="color:red" href="#">Save</a>');
            self.parent().append(data.save);
            data.save.click(function () {
                var va = self.val();
                data.save.remove();
                data.save = false;
                self.prop('disabled', true);
                $.post(window.location.href, {
                        editorder: 1,
                        order_id: data.ref,
                        value: va
                    },
                    function (data) {
                        parse_response(data);
                        self.prop('disabled', false);
                    });
            });
        }
    });

    $('#assign-client').each(function () {
        var self = $(this),
            select = $('select', self),
            help = select.next();

        select.chosensearch();
        select.on('change', function () {
            help.empty();
            $('.client-assign', self).addClass('diabled').prop('disabled', true)
            select.parent().removeClass('has-error');

            $.post('?cmd=affiliates&action=checkassign', {
                id: $('#affiliate_id').val(),
                client_id: select.val()
            }, function (data) {
                if (data.length == 0) {
                    $('.client-assign', self).removeClass('diabled').prop('disabled', false)
                } else {
                    for (var l in data) {
                        help.append('<div>' + data[l] + '</div>');
                    }
                    select.parent().addClass('has-error');
                }
            })
        });
    })


    $('#afforders').on('click', 'a.aff-review', function (e) {
        var data = $(this).data(),
            tpl = $('#ReviewComission');

        var dialog = bootbox.dialog({
            title: tpl.data('title'),
            message: tpl.html(),
            show: false,
            backdrop: true,
            buttons: {
                accept: {
                    label: 'Accept',
                    className: 'btn-success',
                    callback: function () {
                        $('form', this).submit();
                        return false;
                    }
                },
                cancel: {
                    label: 'Cancel',
                    className: 'btn-default'
                }
            }
        })
        console.log(dialog, data)
        $("#acceptref", dialog).val(data.id)
        $("input[name=amount]", dialog).val(data.amount);

        $.get('?cmd=affiliates&action=order_details&id=' + data.id, function (data) {
            $('#affdetails', dialog).html(data || 'Order details not found.');
        })
        dialog.modal('show');

        return false;
    })

    $('#afforders').on('click', 'a.aff-details', function (e) {

        var id = $(this).data('id'),
            tpl = $('#ComissionDetails'),
            dialog = bootbox.dialog({
                title: tpl.data('title'),
                message: tpl.html(),
                show: false,
                onEscape: true,
                backdrop: true,
            });

        $.get('?cmd=affiliates&action=order_details&id=' + id, function (data) {
            data = parse_response(data);
            $('#affdetails', dialog).html(data.length > 3 && data || 'Order details not found.');
        });

        dialog.modal('show');
        return false;
    })
});


var FilterAffiliateModal = {
    modal: function (target, el) {
        var src = $('#' + $.trim(target));
        var body = src.find('.modal-body');
        if ($.trim(body.text()) != '') {
            src.modal( );
        } else {
            ajax_update($(el).attr('href'), {}, function (data) {
                body.html(data).find('form').changeElementType('div');
                body.find('.freseter').remove();
                body.find('.filterform').removeAttributes();

                var forms = body.find('input,select');
                forms.keypress(function (event) {
                    if (event.keyCode == 13) {
                        FilterAffiliateModal.submit(target);
                        return false;
                    }
                });
                if (body.find('.filters-actions').length) {
                    body.find('.filters-actions').remove();
                    body.find('.form-group').removeClass('col-lg-3 col-md-4');
                } else {
                    forms.addClass('form-control')
                        .filter('[type=submit]')
                        .parents('tr').eq(0).remove();
                }
                src.modal( );
            })
        }
        return false;
    },
    submit: function (target) {
        var s = this.init(target);
        (s.footer).find('.btn-danger').show();
        (s.filter).removeClass('btn-default').addClass('btn-danger');
        (s.src).modal('hide');
        $('.orders_updater').addLoader();
        var c = (s.body).find('input,select').serialize();
        ajax_update(s.url + '&' + c,{},function(data){
            $('.orders_updater').html(data);
        });
        return false;
    },
    reset: function (target) {
        var s = this.init(target);
        (s.footer).find('.btn-danger').hide();
        (s.filter).removeClass('btn-danger').addClass('btn-default');
        (s.src).modal('hide');
        ajax_update(s.url + '&resetfilter=1',{},function(data){
            $('.orders_updater').html(data);
        });
        return false;
    },
    init: function (target) {
        return {
            src: $('#' + $.trim(target)),
            footer: $('#' + $.trim(target)).find('.modal-footer'),
            filter: $('.box-commissions').find('.btn-is-filter'),
            body: $('#' + $.trim(target)).find('.modal-body'),
            url: $('#' + $.trim(target)).attr('data-url')
        };
    }
};
if(typeof launchfiltermodal !== 'function') {
    var launchfiltermodal =  function (target,el) {
        var src = $('#'+$.trim(target));
        var body = src.find('.modal-body');
        if($.trim(body.text()) !== '') src.modal( );
        else {
            ajax_update($(el).attr('href'),{},function(data){
                body.html(data).find('input,select').addClass('form-control').filter('[type=submit]').parents('tr').eq(0).remove();
                src.modal( );
            })
        }
        return false;
    };
}