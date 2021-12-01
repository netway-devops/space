function taxConfigInit(data, lang, countries, tax_groups) {
    var dropdown_tpl = Handlebars.compile($('#tax-rate-select-tpl').html());

    var tax_toggle = $('input[name="EnableTax"]'),
        tax_type = $('select[name="TaxType"]'),
        tax_ex_rate = $('#TaxInclusiveRate'),
        tax_negative = $('input[name="AllowNegativeTax"]');

    tax_toggle.on('change init', function () {
        $('.rest').toggle(this.checked === (this.value === 'on'));
        tax_type.trigger('init')
    }).trigger('init');

    tax_type.on('change init', function () {
        $('.tax_type').hide().filter('.' + tax_type.val()).show();
    }).trigger('init');

    tax_negative.on('change init', function () {
        $('.tax_negative').toggle(this.checked === (this.value === 'on'));
    }).trigger('init');

    var sctoken = $('input[name=security_token]').val(),
        href = '?cmd=taxconfig&security_token=' + sctoken;

    var update_tax_rtes = (function () {

        var tx_table = $('#tax-table');
        var datatable = tx_table.DataTable({
            data: data,
            columns: [
                {"data": "name", title: lang.taxname},
                {"data": "group_name", title: lang.Group},
                {
                    "data": "country", title: lang.country, render: function (data, type, full, meta) {
                        return data === '0' ? lang.Allcountries : (countries[data] ? countries[data] : data);
                    }
                },
                {
                    "data": "state", title: lang.State, render: function (data, type, full, meta) {
                        return data === '0' ? lang.Allstates : data;
                    }
                },
                {"data": "type", title: lang.Level},
                {
                    "data": "rate", title: lang.Rate, type: 'num-fmt',
                    render: function (data, type, full, meta) {
                        return data + '%';
                    }
                },
                {
                    render: function (data, type, full, meta) {
                        var action = href + '&action=deletetax&id=' + full.id;
                        return '<a class="btn btn-xs btn-default rm-tax-btn" href="' + action + '" title="' + lang.Delete + '">' +
                            '<i class="fa fa-trash-o"></i></a>';
                    },
                    type: 'html', width: 20, orderable: false
                }
            ]
        });

        tax_ex_rate.html(dropdown_tpl({
            rates: data
        }))
        tax_ex_rate.val(tax_ex_rate.data('val'))

        var box = $('#box-tax-rates'),
            blank = box.find('.empty-state'),
            full = box.find('.non-empty-state');

        function updateFn(data) {
            box.hideLoader();

            if (!data.hasOwnProperty('data') || data.data.length < 1) {
                blank.show();
                full.hide();
                return;
            }

            blank.hide();
            full.show();

            datatable.clear();
            datatable.rows.add(data.data);
            datatable.columns.adjust().draw();

            var value = tax_ex_rate.val();
            tax_ex_rate.html(dropdown_tpl({
                rates: data
            }))
            tax_ex_rate.val(value);
        }

        tx_table.on('click', '.rm-tax-btn', function () {
            if (!confirm(lang.removetaxconfirm)) {
                return false;
            }

            box.addLoaders();
            $.get(this.getAttribute('href'), updateFn);

            return false;
        });

        var add_tax_box = $('#add-new-tax'),
            add_premade_box = $('#add-premade-tax');

        add_tax_box.bootboxform({
            callback: function (e, d) {
                box.addLoaders();
                $.post(href, this.find('form').serializeArray(), updateFn);
                return true;
            }
        }).on('bootbox-form.shown', function (e, dialog) {
            dialog.on('click', '.option-pick input', function () {
                $(this).closest('.option-pick').siblings('input, select')
                    .prop('disabled', this.checked === (this.value === '0'));
            })
        });

        add_premade_box.bootboxform({
            callback: function () {
                box.addLoaders();
                $.post(href, this.find('form').serializeArray(), updateFn);
                return true;
            }
        });


        $('.add-tax-btn').on('click', function () {
            add_tax_box.trigger('show');
            return false;
        });

        $('.add-premade-btn').on('click', function () {
            add_premade_box.trigger('show');
            return false;
        });

        $('.del-all-btn').on('click', function () {
            if (!confirm(lang.confirmtaxremove)) {
                return false;
            }
            box.addLoaders();
            $.get(this.getAttribute('href'), updateFn);
            return false;
        });

        return function () {
            box.addLoaders();
            $.get('?cmd=taxconfig', updateFn);
        }
    })();

   (function () {
        var box = $('#box-tax-groups'),
            list_tpl = Handlebars.compile($('#tax-groups-tpl').html()),
            dropdown_tpl = Handlebars.compile($('#tax-groups-select-tpl').html()),
            tbody = $('#tax-group-table-body'),
            add_group_box = $('#edit-tax-group'),
            group_data = null;

        function updateFn(data) {
            data.lang = lang;
            data.sctoken = sctoken;

            data.groups.map(function (group) {
                group.editable = group.id > 1;
            });

            box.hideLoader();
            tbody.html(list_tpl(data));
            $('.tax-group-select').html(dropdown_tpl(data));

            tax_groups = data.groups;
        }

        add_group_box.bootboxform().on('bootbox-form.shown', function (e, dialog) {
            dialog.find('[name]').each(function () {
                var self = $(this),
                    name = self.attr('name');
                if(group_data.hasOwnProperty(name)){
                    self.val(group_data[name]);
                }
            })
        });

        box.on('click', '.add-group-btn, .edit-group-btn', function () {
            var self = $(this),
                title = 'Add tax group';

            group_data = {};
            if (self.is('.edit-group-btn')) {
                group_data = tax_groups[self.closest('tr').index()];
                title = 'Edit tax group';
            }

            add_group_box.trigger('show', {
                title: title,
                callback: function () {
                    box.addLoaders();
                    var form = this.find('form');
                    $.post(form.attr('action'), form.serializeArray(), function (data) {
                        updateFn(data);
                        update_tax_rtes();
                    });
                    return true;
                }
            });
            return false;
        });

        box.on('click', '.rm-group-btn', function () {
            if (!confirm('Are you sure want to remove this group? It will remove related tax rules')) {
                return false;
            }

            box.addLoaders();
            $.get(this.getAttribute('href'), function (data) {
                updateFn(data);
                update_tax_rtes();
            });

            return false;
        });

        updateFn({groups: tax_groups})
    })();
}
