
$(function(){
    var form = $('#account_form'),
        form_submit = $('#formsubmiter'),
        product = $('#product_id'),
        custom_field = $('[name^="custom["]');

    product.data('initialValue', product.val());
    custom_field.each(function (){
        var self = $(this);
        if(['checkbox', 'radio'].indexOf(self.attr('type')) > -1){
            self.data('initialState', self.is(':checked'))
        }
        self.data('initialValue', self.val());
    })

    form_submit.on('click', function (e){
        return check_form_changes();
    })

    function check_form_changes(){
        if(window.forms_confirmed){
            return true;
        }

        var status = $('select[name="status"]').val();
        if(['Active', 'Suspended'].indexOf(status) === -1){
            return true;
        }

        var customized = $('[name^="custom["]').filter(function (){
            var self = $(this),
                data = self.data();

            if(!data.hasOwnProperty('variable') || !data.variable){
                return false;
            }

            if(!data.hasOwnProperty('initialValue') || data['initialValue'] !== self.val()){
                return true;
            }

            return ['checkbox', 'radio'].indexOf(self.attr('type')) > -1
                && data['initialState'] !== self.is(':checked')
        })

        if(customized.length === 0){
            return true;
        }

        $('#ConfirmUpdate').trigger('show', [{
            callback: function (e){
                var val = $(this).find('input[name="update_remote"]:checked').val();
                form.find('input[name="update_remote"][value='+val+']').prop('checked', true);

                window.forms_confirmed = true;
                form_submit.click();
            }
        }])
        return false;
    }

    $('#ConfirmUpdate').bootboxform()

    $('#ChangeOwner').bootboxform()
        .on('bootbox-form.shown', function (e, dialog) {
            $('select', dialog).chosensearch();
        });
    $('#ChangeContract').bootboxform()
        .on('bootbox-form.shown', function (e, dialog) {
            $('select', dialog).chosenedge({width: '100%'});
        });

    $('#RequestCancellation').bootboxform()
        .on('bootbox-form.shown', function (e, dialog) {
            $('button[data-bb-handler="confirm"]').on('click', function () {
                if ($('textarea[name="reason"]', dialog).length !== 0) {
                    if (isEmpty($('textarea[name="reason"]', dialog).val())) {
                        alert(lang.empty_reason);
                        return false;
                    }
                } else if ($('input[name="reason"]:checked', dialog).val() === 'other') {
                    if (isEmpty($('textarea[name="other_reason"]', dialog).val())) {
                        alert(lang.empty_reason);
                        return false;
                    }
                } else if ($('input[name="reason"]:checked', dialog).val() === undefined) {
                    alert(lang.empty_reason);
                    return false;
                }
            });
            var timepickers = $('.timepicker');
            var datepicker = $('.haspicker');
            datepicker.datePicker({
                startDate: startDate
            });
            timepickers.timepicker({
                timeFormat: 'H:i',
                showDuration: true
            }).eq(0).on('changeDate change', function(x) {
                timepickers.eq(1).timepicker('option', 'minTime', $(this).timepicker('getTime'))
            }).end().eq(1).on('changeDate change', function(x) {
                var end = $(this).timepicker('getTime'),
                    start = timepickers.eq(0).timepicker('getTime');
                if (end.getTime() - start.getTime() <= 0) {
                    var date = getFieldDate(datepicker.eq(1)),
                        date2 = getFieldDate(datepicker.eq(2)),
                        days = (date.getDate() + 1).toString(),
                        month = (date.getMonth() + 1).toString(),
                        format = Date.format;
                    if (!isNaN(date.getTime()) && (isNaN(date2.getTime()) || date.getTime() >= date2.getTime()))
                        datepicker.eq(2).val(
                            format.replace('d', days.length < 2 ? "0" + days : days)
                                .replace('m', month.length < 2 ? "0" + month : month)
                                .replace('Y', date.getFullYear())
                        );
                }
            });
            datepicker.eq(1).change(function() {
                datepicker.eq(2).dpSetStartDate($(this).val());
            });
            function getFieldDate(datepicker) {
                var value = datepicker.val(),
                    format = Date.format, delim = format.replace(/[^-\/\.]/g, '').charAt(0), parts = value.split(delim),
                    formatparts = format.split(delim);
                return new Date(parts[formatparts.indexOf('Y')], parts[formatparts.indexOf('m')] - 1, parts[formatparts.indexOf('d')])
            }
            $(dialog).find('.inp-controls a').on('click', function () {
                var self = $(this),
                    inp = self.parent().prev(),
                    time = inp.timepicker('getTime'),
                    mod = self.is('.plus') ? 30 : -30;
                time = new Date(time.getTime() + mod * 60000);
                inp.timepicker('setTime', time);
                return false;
            });
            $(dialog).find('select[name="type"]').on('init change', function () {
                var self = $(this),
                    ipa = $(dialog).find('input[name="process_automatically"]');
                if (self.val() === 'Admin submitted') {
                    ipa.closest('.form-group').show();
                } else {
                    ipa.closest('.form-group').hide();
                    ipa.prop('checked', false);
                    ipa.trigger('change');
                }
            }).trigger('init');
            $(dialog).find('input[name="process_automatically"]').on('init change', function () {
                var self = $(this);
                $(dialog).find('.request_at').closest('.form-group').toggle(self.is(':checked'));
            }).trigger('init');
        });

    var bootboxtpl = ['OverrideSuspension', 'SetCommitmentPeriod'];

    jQuery.each(bootboxtpl, function (i, item) {
        var suspovrtpl = $('#'+item);
        suspovrtpl.bootboxform()
            .on('bootbox-form.shown', function (e, dialog) {
                var dateinp = $('input[name=date]', dialog);
                $('select', dialog).on('init change', function () {
                    var val = this.value,
                        date = new Date();

                    if (val == 'c') {
                        dateinp.closest('.form-group').show();
                        return false;
                    }

                    dateinp.closest('.form-group').hide();
                    switch (val[val.length - 1]) {
                        case 'd':
                            date.setDate(date.getDate() + parseInt(val));
                            break;
                        case 'm':
                            date.setMonth(date.getMonth() + parseInt(val));
                    }
                    dateinp.val(date.asString()).trigger('change');
                    return false;
                }).trigger('init');
            });

        if (suspovrtpl.data('active'))
            suspovrtpl.data().bootboxform.buttons['del'] = {
                label: 'Disable',
                className: 'btn-warning',
                callback: function (e) {
                    $('input[name=date]', this).val('');
                    $('form', this).submit();
                    return false;
                }
            };
    });

    $(document).on('change', '.cf_item_description_selector', function () {
        var copy_of = $(this).attr('data-copy_of');
        var description = '';
        if (copy_of) {
            if ($(this).is('select')) {
                description = $(this).find('option:selected').attr('data-description');
            }
            $('.cf_'+copy_of+'_item_description_value').html(description);
        }
    });

    var confirm_invoice = $('#ConfirmNewInvoice');
    confirm_invoice.bootboxform().on('bootbox-form.shown', function(e, modal){

        $('input[name="prorata[enable]"]', modal).on('change', function () {
            $('.prorata-row', modal).toggle(this.checked);
        })
        $('input.prorata-date-toggle', modal).on('change', function () {
            $('.' + this.getAttribute('rel') , modal).prop('disabled', !this.checked);
        })

        var from = $('.date-from', modal),
            to = $('.date-to', modal);

        from.on('change', function(){
            var sd = Date.fromString(this.value),
                ed = Date.fromString(to.val());

            if(sd >= ed){
                ed.setDate(ed.getDate());
                from.val(ed.asString());
                sd = ed;
            }

            sd.setDate(sd.getDate())
            to.dpSetStartDate(sd.asString())
            from.dpSetSelected(from.val());
        }).trigger('change')

        to.on('change', function(){
            var sd = Date.fromString(this.value),
                ed = Date.fromString(from.val());

            if(sd <= ed){
                ed.setDate(ed.getDate());
                to.val(ed.asString());
                sd = ed;
            }

            sd.setDate(sd.getDate())
            from.dpSetEndDate(sd.asString())
        }).trigger('change')
    })

    //confirm_invoice.trigger('show');
    $(document).on('click', '.generate-invoice', function(e){
        e.preventDefault();
        var data = $(this).data(),
            query = {account_id: data.id};

        for(let item of data.items){
            if(!query.hasOwnProperty(item.what)){
                query[item.what] = [];
            }
            query[item.what].push(item.rel_id);
        }

        confirm_invoice.trigger('show', [{
            formaction: '?cmd=accounts&action=generateinvoice&' + $.param(query)
        }]);
    })
})

function autosus(el) {
    if ($(el).is(':checked')) {
        $('#autosuspend_date').show();
    } else {
        $('#autosuspend_date').hide();
    }
}

function confirm1() {
    $('#confirm_ord_delete').trigger('show');
    return false;
}

function confirmsubmit2() {
    var add = '';
    if ($('#cc_hard').is(':checked'))
        add = '&harddelete=true';
    window.location.href = '?cmd=accounts&make=delete&action=edit&id=' + $('#account_id').val() + add + '&security_token=' + $('input[name=security_token]').val();
    return false;
}

function cancelsubmit2() {
    $('#confirm_ord_delete').hide().parent().css('position', 'inherit');
    return false;
}

function new_gateway(elem) {
    if ($(elem).val() == 'new') {
        window.location = "?cmd=managemodules&action=payment";
        $(elem).val(($("select[name='" + $(elem).attr('name') + "'] option:first").val()));
    }
}

function checkup() {
    var product =  $('#product_id'),
        status = $('select[name=status]:first').val(),
        product_id = product.data('initialValue'),
        confirm = !$('.changeMode').eq(0).is(':checked')
        && product.val() !== product_id
        && status !== 'Pending'
        && status !== 'Terminated'

    if (confirm) {
        return confirm(lang.upgrconf);
    }

    return false;
}

function sh1xa(el, id) {
    $('#link_to_product').attr('href', '?cmd=services&action=product&id=' + id);
    if ($(el).eq(0).val() == id) {
        $('#upgrade_opt').hide();
    } else {
        $('#upgrade_opt').show();
    }
}