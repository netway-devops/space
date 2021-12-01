function check_i(element) {
    var td = $(element).parent();
    if ($(element).is(':checked'))
        $(td).find('.config_val').removeAttr('disabled');
    else
        $(td).find('.config_val').attr('disabled', 'disabled');
}

$(function () {

    $('#newshelfnav').TabbedMenu({
        elem: '.sectioncontent',
        picker: '.list-1 li',
        aclass: 'active',
        picked: $('#picked_tab').val()
    });

    $('#colorSelector').ColorPicker({
        onSubmit: function (hsb, hex, rgb, el) {
            $(el).val(hex);
            $(el).ColorPickerHide();
        },
        onChange: function (hsb, hex, rgb) {
            $('#colorSelector').css('backgroundColor', '#' + hex);
            $('#colorSelector_i').val(hex);
        },
        livePreview: true,
        color: $('#colorSelector_i').val()
    });

    $('select[data-chosen]').chosenedge({
        width: "100%",
        search_contains: true,
    });

    $('input[data-toggle]').on('change init', function (e) {
        var self = $(this),
            target = $(self.data('toggle'));

        if (self.is(':checked')) {
            $('input[name="' + self.attr('name') + '"]').not(self).change();
            e.type === 'init' ? target.show() : target.ShowNicely();
        } else if (e.type !== 'init') {
            //console.log('hide',self.data('toggle'));
            target.hide();
        }
    }).trigger('init');

    $('select[data-toggle]').on('change int', function(e){
        var targets = {};
        $(this).children().each(function(){
            if(!this.dataset['toggle']){
                return;
            }

            var list = JSON.parse(this.dataset['toggle']);
            if(!list || !list.length){
                return;
            }
            for(let opt of list){
                if(!targets.hasOwnProperty(opt) || !targets[opt]){
                    targets[opt] = this.selected;
                }
            }
        })

        for(var key of Object.keys(targets)){
            let querykey = '.opt_' + key;
            if(e.type === 'init'){
                $(querykey).toggle(targets[key]);
            } else if(targets[key]){
                $(querykey).ShowNicely();
            } else{
                $(querykey).hide();
            }
        }
        console.log(targets);
    }).trigger('init');

    var changeBadge = function(from,type) {
        var index = $('.sectioncontent').index($(from).parents('.sectioncontent'))  ;
        var badge = $('#newshelfnav .list-1 a').eq(index).find('.label');
        var current = parseInt(badge.text());
        if(type == '+') {
            current+=1;
        } else {
            current-=1;
        }
        if(current <= 0) {
            current =0;
            badge.hide();
        }  else
            badge.show();
        badge.text(current);
    }

    $('.overridedefault').on('change init',function(e) {

        var self = $(this);
        var _def = self.data('default');

        if(_def === undefined)
            return;


        if(self.val() != _def ) {
            if(self.data('overriden')!=1) {
                changeBadge(self,'+');
            }
            self.data('overriden',1);
        } else  {
            if(self.data('overriden')==1) {
                changeBadge(self,'-');
            }
            self.data('overriden',0);
        }

    }).trigger('change');

    //toggle override options
    $('.toc').on('click init', function (e) {
        var self = $(this);
        self.parent().find('.contener')
            .toggle(self.is(':checked'));

        if(self.is(':checked')) {
            changeBadge(self,'+');
        } else if(event.type == 'click') {
            changeBadge(self,'-');
        }

    }).trigger('init');


    $("#DiscountFormsToggle").on('change', function () {
        var select = $('#DiscountForms');
        select.prop('disabled', !this.checked).trigger('chosen:updated');
        select.closest('.form-group').toggleClass('disabled', !this.checked)
    }).trigger('change');

    var discounttpl = Handlebars.compile(document.getElementById('product-discount').innerHTML),
        ratetpl = Handlebars.compile(document.getElementById('suport-rate').innerHTML);

    $('.add-product-dicount').on('click', function () {
        var list = $('#product-discounts');
        if (!list.data('lastIndex')) {
            list.data('lastIndex', list.children().length);
        }

        var tr, html, data = {
            product_id: $('#product_id').val(),
            discount: $('#discount_value').val(),
            type: $('#discount_type').val(),
            typeunit: ($('#discount_type').val() == 'percent') ? '%' : '',
            name: $('#product_id option:selected').text(),
            id: list.data('lastIndex')
        };

        list.data('lastIndex', list.data('lastIndex') + 1);
        tr = $('#' + data.product_id, list);
        html = discounttpl(data);

        if (tr.length) {
            tr.replaceWith(html);
        } else {
            list.append(html);
        }
    });

    $('.add-support-rate').on('click', function () {
        var list = $('#support-rates');
        if (!list.data('lastIndex')) {
            list.data('lastIndex', list.children().length);
        }

        var opt = $('#rate_id option:selected'),
            data = {
                rate_id: opt.val(),
                price: $('#rate_value').val(),
                type: $('#currency-iso').text() + ' ' + opt.data('type'),
                name: opt.text(),
                id: $('#support-rates tr').length
            };
        list.append(ratetpl(data));
    });

    $('#rate_id').change(function () {
        $('#rate_value').val($('option:selected', this).data('price'));
    }).trigger('change');

    $('#support-rates, #product-discounts').on('click', '.remove-entry', function () {
        $(this).closest('tr').remove();
        return false;
    });



    (function () {
        var input = $('#add-cc-form'),
            btn = $('#add-cc-btn'),
            body = $('#add-cc-body'),
            setting = $('#cc-form');

        btn.on('click', function () {
            var valid = input[0].reportValidity && input[0].reportValidity() || input[0].checkValidity(),
                email = input.val();

            if (!valid || email == '') {
                return false;
            }

            input.val('');
            setting.data('emails').push(email);
            setting.trigger('change');
            return false;
        })

        setting.on('change init', function (e) {
            if (e.type == 'init') {
                setting.data('emails', setting.val() == '' ? [] : setting.val().split(','))
            } else {
                setting.val(setting.data('emails').join(','))
            }
            var html = [];
            $.each(setting.data('emails'), function (i, email) {
                html.push('<span class="btn-group"><span class="btn btn-default btn-static">' + email + '</span><span class="btn btn-default del"><i class="fa fa-times"></i></span></span>');
            })
            body.html(html.join(' ') || '<em>No email added yet.</em>')

            if(html.length ) {
                if(setting.data('overriden')!=1) {
                    changeBadge(setting,'+');
                }
                setting.data('overriden',1);
            } else  {
                if(setting.data('overriden')==1) {
                    changeBadge(setting,'-');
                }
                setting.data('overriden',0);
            }
        }).trigger('init')

        body.on('click', '.del', function () {
            var email = $(this).prev().text(),
                emails = setting.data('emails');

            emails.splice(emails.indexOf(email), 1)
            setting.data('emails', emails)
            setting.trigger('change');
        })

    })()
})