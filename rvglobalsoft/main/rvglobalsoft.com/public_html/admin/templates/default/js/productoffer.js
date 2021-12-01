(function ($, window, undefined) {
    "use strict";

    var chosen_options = {
        width: '100%',
        search_contains: true,
        enable_split_word_search: true,
        include_group_label_in_selected: true
    };

    $.fn.queryBuilder.define('chosenedge', function () {
        var self = this;

        this.on('afterCreateRuleFilters.queryBuilder', function (e, rule) {
            rule.$el.find('.rule-filter-container')
                .css('minWidth', '40%')
                .find('select').chosenedge(chosen_options);
        });

        this.on('afterUpdateRuleFilter.queryBuilder', function (e, rule) {
            var select = rule.$el.find('.rule-filter-container select');

            select.trigger('chosen:updated');
            if (self.plugins && self.plugins['unique-filter']) {
                self.$el.find('.rule-filter-container select').not(select).trigger('chosen:updated');
            }
        });

        this.on('afterUpdateRuleOperator.queryBuilder afterUpdateRuleFilter.queryBuilder', function (e, rule) {
            if (!(rule.filter !== null && rule.filter.input === 'select')) {
                return;
            }

            var container = rule.$el.find('.rule-value-container'),
                select = container.find('select');

            if (select.data('chosen') && rule.operator.multiple === select.prop('multiple')) {
                return;
            }

            container.css('min-width', '240px');
            select.prop('multiple', rule.operator.multiple);
            select.chosenedge('destroy')
                .chosenedge(chosen_options);
        });


        this.on('afterUpdateRuleValue.queryBuilder', function (e, rule) {
            rule.$el.find('.rule-value-container select').trigger('chosen:updated');
        });

        this.on('beforeDeleteRule.queryBuilder', function (e, rule) {
            rule.$el.find('.rule-filter-container select, .rule-value-container select')
                .chosenedge('destroy');
        });

    });

    function HBQueryBuilder(node, settings) {
        settings = settings || {};
        if (!node.length) {
            return;
        }

        this.builder = null;
        this.input = null;

        settings = $.extend({
            //plugins: ['sortable'],
            filters: null,
            rules: null,
            //default_filter: 'cart.product_id',
            display_empty_filter: false,
            plugins: [
                'chosenedge'
            ],
            datetime_format: {
                date: Date.format.toUpperCase(),
                datetime: Date.format.toUpperCase() + ' HH:mm',
                time: 'HH:mm'
            }
        }, node.data(), settings);

        if (settings.name !== undefined) {
            this.input = $('[name="' + settings.name + '"]');
            var rules;
            if (this.input.length && (rules = JSON.parse(this.input.val()))) {
                settings.rules = rules;
            }
        }

        if (!settings.hasOwnProperty('rules')
            || settings.rules === null
            || typeof settings.rules !== 'object'
            || !settings.rules.hasOwnProperty('condition')) {
            settings.rules = null;
        }

        this.node = node;
        this.settings = settings;
        //console.log('init with ', settings);

        this.init();
    }

    HBQueryBuilder.prototype = {
        setupFilterHidden: function (filter) {
            var input = null;
            filter.input = function (rule, input_name) {
                console.log('hidden');
                return '<input type="hidden" name="' + input_name + '" />';
            };
        },

        pruneData: function (rulegroup) {
            var self = this;
            $.each(rulegroup.rules, function () {
                if (this.hasOwnProperty('data')) {
                    delete this.data;
                }
                if (this.hasOwnProperty('rules')) {
                    self.pruneData(this);
                }
            });
            return rulegroup;
        },
        validate: function () {
            return this.builder.validate();
        },
        getJson: function () {
            return JSON.stringify(
                this.pruneData(
                    this.builder.getRules()
                )
            );
        },
        init: function () {
            var self = this;
            $.each(this.settings.filters, function () {
                if (this.input === 'hidden') {
                    self.setupFilterHidden(this);
                }
            });

            try {
                this.node.queryBuilder(this.settings);
            }catch (e) {
                console.warn(e);
                this.settings.rules = null;
                this.node.queryBuilder(this.settings);
            }
            this.builder = this.node[0].queryBuilder;
        }
    };

    var i18n = $.fn.queryBuilder.regional;

    i18n['en-conditons'] = $.extend(true, {}, $.fn.queryBuilder.regional['en']);
    $.extend(i18n['en-conditons'].operators,{
        in: "at least one of selected",
        not_in: "none of selected"
    });

    i18n['en-offer'] = $.extend(true, {}, $.fn.queryBuilder.regional['en']);
    i18n['en-offer']['add_rule'] = 'Add product';
    $.extend(i18n['en-offer'].operators,{
        less_not_empty: 'max per order',
    });


    $(function () {
        $('.chosen').chosenedge(chosen_options);
        $('.datepicker').datetimepicker({
            format: Date.format.toUpperCase(),
        });

        var conditions = new HBQueryBuilder($('#conditions-query-builder'),{
            lang_code: 'en-conditons'
        });

        var offer = new HBQueryBuilder($('#offer-query-builder'), {
            lang_code: 'en-offer',
            allow_empty: true,
            default_group_flags: {
                condition_readonly: false,
                no_add_group: true
            },
            plugins: [
                'unique-filter', 'chosenedge'
            ],
            operators: [
                {type: 'less_not_empty', nb_inputs: 1, apply_to: ['number']}
            ]
        });

        $('form').on('submit', function () {
            if (!conditions.validate() || !offer.validate()) {
                return false;
            }

            $('#conditions').val(conditions.getJson());
            $('#offer').val(offer.getJson());
            return true;
        });
    })

})(jQuery, window);