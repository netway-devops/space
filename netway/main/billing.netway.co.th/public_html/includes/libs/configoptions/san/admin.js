(function ($, widnow) {
    "use strict";

    var pluginName = 'SanForm';

    if ($.fn.hasOwnProperty(pluginName)) {
        return;
    }

    var tpl = '<div class="san san-input form-group">\
        <input value="" type="text" class="san-form" /> \
        <a class="btn btn-danger btn-sm san-del"><i class="fa fa-minus"></i></a> \
        <div>';

    function SanForm(element) {
        this.root = $(element);
        this.inputList = this.root.find('.san-form-list');
        this.hiddenInput = this.root.find(".san-form-json");

        this.inputs = [];
        this.root.on('click','.san-del', this.handleDelClick());
        this.root.on('click','.san-add', this.handleAddClick());
        this.root.on('change','.san-form', this.handleChange());
        this.root.on('focusin','.san-form', this.handleFocus());

        this.updateTimeout = null;
        this.init();
    }

    SanForm.prototype = $.extend(SanForm.prototype, {
        init: function () {
            var json = this.hiddenInput.val(),
                names;

            if(json.indexOf('&quot;') > -1){
                json = $('<textarea />').html(json).text();
            }

            try {
                names = json ? JSON.parse(json) : [];
            }catch{
                names = [];
            }

            var self = this;
            $.each(names, function () {
                self.add(this.name);
            });
            this.updateValue();
        },
        handleFocus: function(cb){
            var self = this;
            return function () {
                self.stopChangeEvent();
            }
        },
        handleAddClick: function () {
            var self = this;
            return function () {
                self.add('');
                return false;
            }
        },
        handleDelClick: function () {
            var self = this;
            return function () {
                self.remove($(this).closest('.san-input').data('sanIndex'));
                self.updateValue(true);
                return false;
            }
        },
        handleChange: function(){
            var self = this;
            return function () {
                self.updateValue(true);
                return false;
            }
        },
        stopChangeEvent: function(){
            clearTimeout(this.updateTimeout);
        },
        startChangeEvent: function(event){
            this.stopChangeEvent();

            var self = this;
            this.updateTimeout = setTimeout(function () {
                self.hiddenInput.trigger('change');
            }, 200);
        },
        add: function (name) {
            var html = $(tpl);
            var input = html.find('input');

            html.data('sanIndex', this.inputs.length);

            this.inputs.push(input);
            this.inputList.append(html);

            input.val(name).focus();
            this.stopChangeEvent();
        },
        remove: function (index) {
            if (!this.inputs[index]) {
                return false;
            }

            this.inputs[index].parent().remove();
            delete this.inputs[index];
        },
        updateValue: function (events) {
            var names = [];
            this.inputs.map(function (input) {
                names.push({name: input.val()});
            });

            this.hiddenInput.val(JSON.stringify(names));
            if(events)
                this.startChangeEvent()
        }
    });

    $.fn[ pluginName ] = function (options) {
        return this.each(function () {
            if (!$.data(this, "plugin_" + pluginName)) {
                $.data(this, "plugin_" + pluginName, new SanForm(this));
            }
        });
    };

})(jQuery, window);