$(function () {

    $('#copysecret').on('click', function () {
        $('#secret')[0].select();
        try {
            document.execCommand('copy');
        } catch (err) {
            console.log('Unable to copy');
        }
    })

    $('#select-events').chosenedge({
        enable_split_word_search: true,
        search_contains: true,
    }).on('change', function (e, data) {
        var select = $(this),
            values = select.val();

        if (values.indexOf('all') >= 0) {
            if (data.selected == 'all')
                select.val(['all']).trigger('chosen:updated')
            else {
                values.splice(values.indexOf('all'), 1);
                select.val(values).trigger('chosen:updated');
            }
        }
    });

    var doctpl = $('#hook-doc'),
        validatecode = $('#validation-code'),
        validatedoc = $("#validation-doc");

    $('#secretdoc').on('click', function () {
        var doc = validatedoc.clone().show();
        doc.find('.validate-code').html(validatecode.html());

        bootbox.dialog({
            title: 'Request validation',
            onEscape: true,
            size: 'large',
            message: doc,
        });
    })

    $('#events').on('click', '.list-group-item .doc', function () {
        var parent = $(this).parent(),
            tpl = doctpl.clone().show();

        tpl.find('.validate-code').html(validatecode.html())
        tpl.find('.event-doc').html(parent.find('pre').html())
        tpl.find('.event-name').text(parent.data().event)
        bootbox.dialog({
            title: 'Event: ' + parent.find('strong').text(),
            onEscape: true,
            size: 'large',
            message: tpl,
        });
        return false;
    });
})