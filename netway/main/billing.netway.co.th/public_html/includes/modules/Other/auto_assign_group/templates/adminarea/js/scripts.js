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
                opts = sel.find("option.optproduct[data-parent=" + val + "]");
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

