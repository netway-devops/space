$(function () {

    if ($('#newshelfnav').find('.list-2 li').hasClass('submenuu')) {
        $('#newshelfnav').TabbedMenu({
            elem: '.sectioncontent',
            picker: '.list-2 li',
        });
    }

    $(".chosenproducts").chosenedge({
        width: '100%',
        search_contains: true,
        display_selected_options: false,
        display_disabled_options: false,
        hide_results_on_select: false,
    }).on('change', function (e, data) {
        var sel = $(e.target);
        sel.find('option.optcategory').each(function () {
            var cat = $(this),
                selected = cat.is(':selected'),
                val = cat.attr('data-category'),
                opts = sel.find("option.optproduct[data-parent="+val+"]");
            if (selected) {
                opts.prop('selected', false).prop('disabled', true);
            } else {
                opts.prop('disabled', false);
            }
        });
        sel.trigger('chosen:updated');
    }).trigger('change');

    $(".chosenwithall").chosenedge({
        search_contains: true,
        display_selected_options: false,
        display_disabled_options: false,
        hide_results_on_select: false,
    }).on('change', function (e, data) {
        var sel = $(e.target);
        var cat = sel.find('option[value="all"]'),
            selected = cat.is(':selected'),
            opts = sel.find("option").not(cat);
        if (selected) {
            opts.prop('selected', false).prop('disabled', true);
        } else {
            opts.prop('disabled', false);
        }
        sel.trigger('chosen:updated');
    }).trigger('change');

    $('.available-products').off('click').on('click', 'input', function () {
        var self = $(this),
            li = self.parents('.li-cat').eq(0);
        if (self.is('.all')) {
            $('input', li).prop('checked', self.is(':checked'));
        } else {
            var all = true;
            $('input.in-prod', li).each(function () {
                if (!$(this).is(':checked')) {
                    all = false;
                    return false;
                }
            });
            $('input.all', li).prop('checked', all)
        }
    });
    $('#tos, #gturl').on('click update', function () {
        var self = $(this);
        if (self.is(':checked'))
            self.next().prop('disabled', false);
        else
            self.next().prop('disabled', true);
    }).trigger('update');
    $('input[name="config[InvCompanyLogoY]"]').on('click update', function () {
        var self = $(this),
            upload = $('#logouploaders'),
            old = $('#logouprev');
        if (self.val() === '1') {
            upload.show();
            old.prop('disabled', false)
        } else {
            upload.hide();
            old.prop('disabled', true)
        }
    }).filter(':checked').trigger('update');

    $('#brandform').on('submit', function () {
        var gateOveride = $('.gate-conf > input, .alt-conf > input');
        gateOveride.each(function () {
            var self = $(this),
                table = self.siblings('table, .row'),
                conf = table.find('input[type=text], input[type=checkbox]:checked, input[type=radio]:checked, input[type=password], textarea, select');

            if (self.is(':checked') || self.is('[type=hidden]')) {
                self.val(conf.serialize())
            }
            conf.prop('disabled', true);
        })
    });

    $('.custom_format').each(function () {
        var td = $(this),
            select = td.children('select'),
            btn = td.children('a'),
            custom = td.children('div'),
            form = custom.find('input'),
            initval = form.val();

        custom.hide();
        if (select.children('[value="' + initval + '"]').length)
            select.val(initval);
        else
            select.val('0');

        function show() {
            custom.show();
            select.val('0');
            return false;
        }

        btn.on('click', show);
        select.on('change', function () {
            var value = select.val();
            if (value === '0')
                return show();
            if (value === '')
                custom.hide();
            form.val(value);
        }).trigger('change')
    });

    $('.disable-opts').each(function () {
        var self = $(this),
            controll = self.find('input'),
            output = $('.' + self.data('opts')).find('input, select');

        controll.change(function () {
            var val = controll.filter(':checked').val()
            output.prop('disabled', val !== 1)
        }).filter(':checked').trigger('change');
    })
});

var aceInit = HBInputTranslate.aceOn;
HBInputTranslate.aceOn = function (el, target) {
    var textarea = $('#' + target);
    aceInit(el, target);
    if (textarea.data('ace') === true) {
        var ace = textarea.data('aceeditor');
        ace.setOptions({
            minLines: 15,
            maxLines: 15,
        });
    }
};

