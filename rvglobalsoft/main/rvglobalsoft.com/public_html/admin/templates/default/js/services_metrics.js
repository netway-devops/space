(function ($, window) {
    var hb, tpl_row, tpl_items, lists, metrics, available, forms;
    var newId = 1;

    function bindMetricsOptions(root) {
        root = root || $('.metrics');
        $('.vtip_description', root).vTip();

        $('.metric_choose', root).on('change', function () {
            var s = $(this),
                o = s.find('option:selected'),
                td = s.closest('td'),
                tr = s.closest('.metric-row');
            var unit = o.attr('data-unit');
            var name = o.attr('data-name');
            tr.find('.quota_unit').html(unit);
            td.find('.metric_unit').val(unit);
            td.find('.metric_name').val(name);
        }).trigger('change');

        $('.metric_enable_trigger', root).on('change', function () {
            var en = $(this).is(':checked'),
                inp = $(this).closest('td').find('.metric_input_trigger');
            if (en) {
                inp.prop('disabled', false);
            } else {
                inp.prop('disabled', true).val('0');
            }
        }).trigger('change');

        $('.metric_remove', root).on('click', function () {
            var self = $(this),
                list = self.closest('.metrics_body');

            self.closest('.metric-row').remove();
            list.find('.metrics_body_empty_row').toggle( list.children('.metric-row').length === 0);
            return false;
        });

        $('.metric_use_forms', root).on('change', function () {
            var row = $(this).closest('.metric-row');
            $('.metric_limit', row).toggle(!this.checked).prop('disabled', this.checked);
            $('.metric_forms', row).toggle(this.checked).prop('disabled', !this.checked);
        }).trigger('change');

        $('.hbinput', root).hbinput();
        return root;
    }

    function breakFlagBits(flag) {
        var bits = {};
        flag = parseInt(flag) || 0;
        flag.toString(2).split('').reverse().map(function (v, i) {
            bits[Math.pow(2, i)] = v === '1' ? 'checked' : '';
        });
        return bits;
    }

    function prepareMetricsData(data) {
        if (!available.hasOwnProperty(data.module_id) || !available[data.module_id]) {
            return null;
        }

        if (data.hasOwnProperty('metrics')) {
            return data;
        }

        var module = available[data.module_id];

        data.metrics = $.extend(true, {}, module.metrics);
        data.forms = $.extend(true, {}, forms);

        data.flags = breakFlagBits(data.flags);

        if (!data.metric) {
            data.metric = Object.keys(data.metrics)[0];
        }
        if (!data.config_cat) {
            data.config_cat = Object.keys(data.forms)[0];
        }

        $.each(data.metrics, function (i, value) {
            if (data.metric === i) {
                value.selected = 'selected';
                data.unit = value.unit;
            } else {
                value.selected = '';
            }

            value.data = {unit: value.unit, name: value.name};
            value.name = module.name + ': ' + value.name
        });

        $.each(data.forms, function (i, value) {
            value.selected = data.config_cat === i ? 'selected' : '';
        });

        return data;
    }


    function updateForms(value) {
        forms = {};

        $('.config-var').each(function () {
            forms[this.dataset['varId']] = {
                name: this.dataset['varName'],
                selected: ''
            }
        })
    }

    function renderMetrics() {
        updateForms();
        $.each(metrics, function (i, data) {
            if(!lists.hasOwnProperty(data.module_id) || !lists[data.module_id]){
                return;
            }

            var list = lists[data.module_id];
            list.find('.metrics_body_empty_row').hide();
            list.append(tpl_row(prepareMetricsData(data)));
        });
        bindMetricsOptions();
    }

    window.addMetricRow = function (module_id) {
        updateForms();

        var list = lists[module_id];
        var row = tpl_row(prepareMetricsData({
            id: 'new][' + newId++,
            module_id: module_id,
            trigger_period: 0
        }));

        list.find('.metrics_body_empty_row').hide();
        list.append(bindMetricsOptions($(row)));
    };

    window.initMetricsOptions = function (_available, _metrics) {
        available = _available || {};
        metrics = _metrics || {};

        hb = Handlebars.create();
        tpl_row = hb.compile(document.getElementById("metrics-row-template").innerHTML);
        tpl_items = hb.compile(document.getElementById("metrics-form-options").innerHTML);

        hb.registerPartial('select', tpl_items);

        lists = {};
        $('.metrics_body').each(function () {
            lists[this.dataset['module']] = $(this);
        });

        $(function () {
            renderMetrics();

            var copybox = $('#import-metrics').bootboxform({
                callback: function () {
                    $('input, select', this).each(function () {
                        this.style.display="none";
                        this.setAttribute('name', this.dataset['name']);
                        $('#productedit').append(this);
                    });
                    saveProductFull();
                }
            });

            $('.copy_metrics').on('click', function () {
                copybox.trigger('show');
                return false;
            });
        })
    }
})(jQuery, window);