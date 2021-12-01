(function ($) {
    "use strict";

    function StateSelect(element, states){

        var body = $('body'),
            is2019 = body.hasClass('template_2019'),
            self = this,
            state_input = $(element),
            country_select = $("select[name='country']");

        if(!country_select.length){
            return;
        }

        self.state_select = $('<select class="form-control"></select>');
        self.state_select.addClass((country_select.attr('class') || '') + '__state_select');
        self.status = false;
        self.last_country = null;

        state_input.addClass("__state_input");

        self.state_select.on('init change', function () {
            state_input.val(self.state_select.val());
        });

        country_select.on("init change", function () {
            var country_value = country_select.val(),
                state_parent = state_input.parent(),
                state_value = state_input.val(),
                html = "";

            if (is2019) {
                var label = $(state_input).closest('.form-label-group').find('label');
            }

            if(self.last_country === country_value){
                return;
            }

            self.last_country = country_value;
            if (country_value && states.hasOwnProperty(country_value) ) {
                if(Array.isArray(states[country_value])) {
                    var key, length = states[country_value].length;

                    for (key=0; key < length; key++) {
                        if (states[country_value][key] === state_value) {
                            html += '<option selected="selected">'
                                + states[country_value][key]
                                + "</option>";
                        } else{
                            html += "<option>" + states[country_value][key] + "</option>"
                        }
                    }
                } else {
                    for (var key of Object.keys(states[country_value])) {
                        if (key === state_value) {
                            html += '<option selected="selected" value="'
                                + key
                                +'">'
                                + states[country_value][key]
                                + "</option>";
                        } else{
                            html += '<option value="'
                                + key
                                +'">'+ states[country_value][key] + '</option>'
                        }
                    }
                }


                self.state_select.html(html);
                self.state_select.css({
                    'minWidth': Math.min(country_select.outerWidth(), state_input.outerWidth())
                });
                state_parent.append(self.state_select);
                self.state_select.trigger('init');

                state_input.hide();
                state_input.trigger('showSelect', [self]);
                self.status = true;
                if (is2019) {
                    label.insertAfter(self.state_select).show();
                }
            } else if(self.status) {
                self.status = false;
                state_input.show();
                self.state_select.detach();
                state_input.trigger('hideSelect', [self]);
                if (is2019) {
                    label.insertAfter(state_input).show();
                }
            }
        }).trigger('init');
        state_input.trigger('initSelect', [self]);
    }

    $.fn.stateProvinceSelect = function (states){
        states = $.extend({}, $.fn.stateProvinceSelect.states || {}, states);

        return this.each(function () {
            if (!$.data(this, "stateprovinceselect")) {
                $.data(this, "stateprovinceselect" , new StateSelect(this, states));
            }
        });

    };
})(jQuery);
