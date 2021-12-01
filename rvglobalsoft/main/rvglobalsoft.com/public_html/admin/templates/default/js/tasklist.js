var HBTasklist = HBTasklist || (function ($, window) {

    var dataset = document.getElementById("tasklist-js").dataset,
        _default = {
            place: dataset.place || 'services',
            pid: dataset.pid || '',
        };

    function FormSetup() {

        var root = $('#facebox'),
            form = $('#saveform', root),
            savebtn = $('#savechanges', root),
            predefined = $('#usepredefined', root),
            msgcomposer = $('#msgcomposer', root),
            spiner = $('.spinner', root),
            details = $('#taskoptions', root),
            saving = {};

        var chosen_options = {
            width: '250px',
            search_contains: true,
            enable_split_word_search: true,
            include_group_label_in_selected: true
        };

        function SetupDetails() {
            var interval = $('#interval_type', root),
                whens = $('#what_before, #what_after', root);

            $('.tasklist-task-when', root).on('change', function () {
                whens.hide();
                whens.filter('#what_' + this.value).show();

                if (this.value === 'before') {
                    if (interval.val() === 'MINUTE')
                        interval.val('HOUR');
                    $('option:eq(2)', interval).hide();
                } else {
                    $('option:eq(2)', interval).show();
                }
            });

            $('.btn-compose-msg', root).on('click', function () {
                msgcomposer.html('').show();
                ajax_update(this.getAttribute('href'), false, '#msgcomposer');
                return false;
            });

            QueryBuilder();
        }

        function QueryBuilder() {
            var node = $('#query-builder', root);
            if (!node.length) {
                return;
            }

            var toggle_btn = $('.tasklist-contitions', root),
                node_data = node.data(),
                builder = null,
                staff_list = $('#staff_list', root);

            if (staff_list.length > 0) {
                staff_list.chosenedge();
            }
            $.each(node_data.filters, function () {
                if (this.input === 'select') {
                    this.plugin = 'chosenedge';
                    this.plugin_config = chosen_options;
                    this.valueSetter = function (rule, value) {
                        return rule.$el.find('.rule-value-container select').val(value).trigger('chosen:updated');
                    }
                }
                if (this.type === 'date' || this.type === 'datetime' || this.type === 'time') {
                    var format = {
                        date: Date.format.toUpperCase(),
                        datetime: Date.format.toUpperCase() + ' HH:mm',
                        time: 'HH:mm'
                    };
                    this.size =  this.type === 'datetime' ? 16 : 8;
                    this.plugin = 'datetimepicker';
                    this.input_event = 'change dp.change';
                    this.plugin_config = {
                        format: format[this.type]
                    };

                    this.valueSetter = function (rule, value) {
                        return rule.$el.find('.rule-value-container input').each(function (i) {
                            var date = $(this).data('DateTimePicker');
                            return date && date.date(moment(value[i]));
                        }).get();
                    };

                    this.valueGetter = function (rule) {
                        return rule.$el.find('.rule-value-container  input').map(function () {
                            var date = $(this).data('DateTimePicker');
                            return date.date() && date.date().format() || '';
                        }).get();
                    };
                }
            });

            node.on('afterUpdateRuleOperator.queryBuilder afterUpdateRuleFilter.queryBuilder', function (e, rule) {
                if (rule.filter !== null && rule.filter.input === 'select') {
                    var select = rule.$el.find('.rule-value-container select');
                    if (rule.operator.multiple === select.prop('multiple')) {
                        return;
                    }

                    select.prop('multiple', rule.operator.multiple);
                    select.chosenedge('destroy')
                        .chosenedge(chosen_options);
                }
            });

            node.on('afterCreateRuleFilters.queryBuilder afterUpdateRuleFilter.queryBuilder', function (e, rule) {
                var select = rule.$el.find('.rule-filter-container select');
                if (select.data('chosen')) {
                    select.trigger('chosen:updated');
                } else {
                    select.chosenedge(chosen_options);
                }
            });

            var prunedata = function (rulegroup) {
                $.each(rulegroup.rules, function () {
                    if (this.hasOwnProperty('data')) {
                        delete this.data;
                    }
                    if (this.hasOwnProperty('rules')) {
                        prunedata(this);
                    }
                })
                return rulegroup;
            };

            if (!node_data.hasOwnProperty('rules')
                || node_data.rules === null
                || typeof node_data.rules !== 'object'
                || !node_data.rules.hasOwnProperty('condition')) {
                node_data.rules = null;
            }

            toggle_btn.on('click', function () {
                if (builder !== null) {
                    builder.destroy();
                    delete saving.querybuilder;
                    builder = null;
                    toggle_btn.toggleClass('active', false);
                    return false;
                }

                node.queryBuilder({
                    //plugins: ['sortable'],
                    filters: node_data.filters,
                    rules: node_data.rules
                });
                builder = node[0].queryBuilder;

                saving.querybuilder = function (data) {
                    if (!builder.validate()) {
                        return false;
                    }
                    data.conditions = prunedata(builder.getRules());
                };

                toggle_btn.toggleClass('active', true);
                return false;
            });

            if (node_data.rules !== null) {
                toggle_btn.trigger('click');
            }
        }

        $('#premade_val', root).on('change', function () {
            savebtn.toggle(this.value !== '0');
        });

        $('#tasklist-type', root).on('change', function () {
            msgcomposer.html('').show();
            if (this.value === '0') {
                details.hide();
                predefined.show();
                savebtn.hide();
                return false;
            }

            savebtn.show();
            predefined.hide();
            details.html('<img src="ajax-loading.gif">')

            $.post('?cmd=tasklist&action=taskdetails', {
                task: this.value,
                place: form[0].place.value,
                product_id: form[0].product_id.value
            }, function (data) {
                spiner.hide();
                details.html(parse_response(data)).show();
                SetupDetails();
            });
        });

        $('.btn-close', root).on('click', function () {
            close();
            saving.reject();
            return false;
        });

        $('.btn', savebtn).on('click', function () {
            var data = form.serializeForm(),
                errors = $('#task-errors', root),
                save = true;

            $.each(saving, function (i, cb) {
                if (cb(data) === false) {
                    save = false;
                    return false;
                }
            });

            if (!save) {
                root[0].scrollIntoView()
                return false;
            }

            errors.hide().empty();
            spiner.show();

            $.post('index.php?cmd=tasklist&x=' + Math.random(), data, function (resp) {
                var ok = true;
                parse_response(resp, {
                    error: function (error) {
                        errors.append('<p>' + error + '</p>');
                        ok = false;
                    }
                });

                spiner.hide();
                if (ok) {
                    refresh();
                    close();
                } else {
                    errors.show();
                    root[0].scrollIntoView()
                }
            });
            return false;
        });

        if (form[0].id.value) {
            savebtn.show();
        }
        SetupDetails();
    }


    function refresh(pid) {
        ajax_update('?cmd=tasklist&action=getproducttasks', {
            product_id: pid || _default.pid,
            place: _default.place
        }, "#tasklistloader");
    }

    function close() {
        $(document).trigger('close.facebox');
    }


    return {
        assignNew: function (pid, place) {
            place = place || _default.place;
            pid = pid || _default.pid;

            $.facebox({
                ajax: "?cmd=tasklist&action=assigntask&product_id=" + pid + "&place=" + place,
                width: 900,
                nofooter: true,
                opacity: 0.5,
                addclass: 'modernfacebox'
            });
            $(document).one('reveal.facebox', FormSetup);
            return false;
        },

        edit: function (id, pid, place) {
            pid = pid || _default.pid;

            $.facebox({
                ajax: "?cmd=tasklist&action=taskdetails&id=" + id + '&product_id=' + pid + "&place=" + place,
                width: 900,
                nofooter: true,
                opacity: 0.5,
                addclass: 'modernfacebox'
            });
            $(document).one('reveal.facebox', FormSetup);
            return false;
        },

        remove: function (id, pid) {
            pid = pid || _default.pid;
            if (confirm("{$lang.task_remove_confirm}"))
                ajax_update('index.php?cmd=tasklist&action=getproducttasks', {
                    product_id: pid,
                    make: 'removetask',
                    task: id,
                    place: _default.place
                }, "#tasklistloader");
            return false;
        },

        refresh: refresh,
        close: close
    }

})(jQuery, window);