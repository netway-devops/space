"use strict";

var HBReportSnapshots = function () {
    var _initChosen = function () {
        $('.chosen').chosenedge({
            width: '100%',
            enable_split_word_search: true,
            search_contains: true
        })
    }

    var _initDateTimePickers = function () {
        var timepickers = $('.timepicker');
        var datepicker = $('.haspicker');

        datepicker.datePicker();
        timepickers.timepicker({
            timeFormat: 'H:i',
            showDuration: true
        });
    }

    return {
        // public functions
        init: function () {
            _initChosen();
            _initDateTimePickers();
        },
        check_i: function (element) {
            var td = $(element).parent();
            $(td).find('.config_val').removeAttr('disabled').removeClass('disabled');

            var name = $(element).attr('name');
            $('input[name="' + name + '"]').not(element).parent().find('.config_val').prop('disabled', true).addClass('disabled');
        },
        time_change: function (element) {
            var self = $(element),
                inp = self.parent().prev(),
                time = inp.timepicker('getTime'),
                mod = self.is('.plus') ? 30 : -30;

            if (self[0].hasAttribute('disabled'))
                return false;

            time = new Date(time.getTime() + mod * 60000);
            inp.timepicker('setTime', time);
            return false;
        },
        target_change: function (element) {
            var self = $(element),
                is_email = self.attr('value') === 'Email';
            $('.snapshot .target_email').toggle(is_email);
            return false;
        },
        handle_output_selector: function (element) {
            var self = $(element);
            if (self.val() == 'sql' || self.val() == 'googlechart') {
                $('.section-snapshots').hide();
                $('.btn_generate_store').hide();
            } else {
                $('.section-snapshots').show();
                $('.btn_generate_store').show();
            }
        }
    };
}();

jQuery(document).ready(function () {
    HBReportSnapshots.init();
});

