(function ($, window) {
    var hb, tpl_row, tpl_items, tpl_statuses, tpl_macros, tpl_tags, macros, tickettags, lists, slas, available, forms, statuses, triggers;
    var newId = 1;

    function bindSLAsOptions(root) {
        root = root || $('.slas');
        $('.vtip_description', root).vTip();

        $('.sla-chosen',root).chosenedge({width:'100%'});


        $('.sla_trigger', root).on('change', function () {

            var s = $(this),
                o = s.find('option:selected'),
                td = s.closest('td'),
                tr = s.closest('.metric-row'),
                unit = tr.find('.sla_trigger_unit'),
                unitval = unit.val();

            var units = o.attr('data-units').split(',');
            var h = tpl_items({ options: prepareunits(units,unitval)});

            unit.html(h);
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
                list = self.closest('.slas_body');

            self.closest('.metric-row').remove();
            list.find('.slas_body_empty_row').toggle( list.children('.metric-row').length === 0);
            return false;
        });

        $('.metric_use_forms', root).on('change', function () {
            var row = $(this).closest('.metric-row');
            $('.metric_limit', row).toggle(!this.checked).prop('disabled', this.checked);
            $('.metric_forms', row).toggle(this.checked).prop('disabled', !this.checked);
        }).trigger('change');

        return root;
    }

    function prepareunits(arr,val) {
        var ret = {};
        for(var b=0;b<arr.length;b++) {
            ret[arr[b]]={
                name: arr[b],
                selected: val && val == arr[b] ? 'selected':''
            };
        }
        return ret;
    }


    function prepareSLAsData(data) {


        if (data.hasOwnProperty('slas')) {
            return data;
        }


        data.statuses = $.extend(true, {}, statuses);

        $.each(data.statuses,function(i,d){
            if(data.trigger_status.includes(d.status) || !data.trigger_status.length) {
                d.selected = 'selected';
            }
        });

        data.macros = $.extend(true, {}, macros);
        $.each(data.macros, function (i, d) {
            if(d.id == data.macro_id) {
               d.selected = 'selected';
            }
        });

        data.levels = {};
        for(var i=1;i<11;i++) {
            data.levels[i]={
                name: i,
                selected: data.level == i ? 'selected':''
            }
        }

        data.triggers = $.extend(true, {}, triggers);
        data._units = {};

        if (data.de_escalate === "1") {
            data.de_escalate = 'checked';
        }
        $.each(data.triggers, function (i, d) {


            d.data = {units: d.units};

            d._units = prepareunits(d.units,data.trigger_unit)
            // for(var b=0;b<d.units.length;b++) {
            //     d._units[b]={
            //         name: d.units[b],
            //         selected: data.trigger_unit == d.units[b] ? 'selected':''
            //     };
            // }

            if(i == data.trigger) {
                d.selected = 'selected';
                data._units = d._units;
            }

        });

        return data;
    }




    function renderSLAs() {
        $.each(slas, function (i, data) {

            lists.find('.slas_body_empty_row').hide();
            lists.append(tpl_row(prepareSLAsData(data)));
        });
        bindSLAsOptions();
    }

    window.addSLARow = function (module_id) {

        var list = lists;
        var row = tpl_row(prepareSLAsData({
            id: 'new][' + newId++,
            level: 1,
            trigger: 'time',
            trigger_unit: 'minutes',
            trigger_value: 30,
            color: '',
            macro_id: 0,
            trigger_status: [],
            de_escalate: 0
        }));

        list.find('.slas_body_empty_row').hide();
        list.append(bindSLAsOptions($(row)));
    };

    window.initSLAsOptions = function (_slas,_statuses,_triggers,_macros, _tickettags) {
        slas = _slas || {};
        statuses = _statuses || {};
        triggers = _triggers || {};
        macros = _macros || {};
        tickettags = _tickettags || {};

        hb = Handlebars.create();
        tpl_row = hb.compile(document.getElementById("slas-row-template").innerHTML);
        tpl_items = hb.compile(document.getElementById("slas-form-options").innerHTML);
        tpl_statuses = hb.compile(document.getElementById("slas-form-statusoptions").innerHTML);
        tpl_macros = hb.compile(document.getElementById("slas-form-macrooptions").innerHTML);
        tpl_tags = hb.compile(document.getElementById("slas-form-tagoptions").innerHTML);

        hb.registerPartial('select', tpl_items);
        hb.registerPartial('statusselect', tpl_statuses);
        hb.registerPartial('macroselect', tpl_macros);
        hb.registerPartial('tagselect', tpl_tags);

        lists = {};
        $('.slas_body').each(function () {
            lists = $(this);
        });

        $(function () {
            renderSLAs();



        })
    }
})(jQuery, window);