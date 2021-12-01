
var HBServices = {
    showArcived: function () {
        $('#serializeit').toggleClass('show-archived');
    },
    countArchived: function () {
        var c = parseInt($('#serializeit').find('.archived.entry').length);
        $('#count_archived').html('(' + c + ')');
    },
    customize: function () {
        var op = $('input[name=otype]:checked').val();
        if (!op)
            return false;
        var cid = $('input[name=cat_id]').val();
        if (!cid) {
            alert('Please add your orderpage first');
            return false;
        }

        $.facebox({
            ajax: "?cmd=services&action=opconfig&tpl=" + op + "&id=" + cid,
            width: 600,
            nofooter: true,
            opacity: 0.5,
            addclass: 'modernfacebox'
        });
        return false;
    },
    customreminder: function () {
        var table = $('#reminder_table tbody');
        var cnt = $('tr', table).length - 1;
        var tpl = $('#reminder_template', table).clone().removeAttr('id').removeAttr('style').html().replace(/\+n\+/g, cnt).replace(/InvoiceCustomReminderr/g, 'InvoiceCustomReminder');


        table.append($('<tr>').attr('id', 'reminder_' + cnt).append(tpl));
        return false;
    },
    rmreminder: function (cnt) {
        $('#reminder_' + cnt).remove();
        return false;
    },
    editcat: function () {
        $('#cinfo1').toggle();
        $('#cinfo0').toggle();
        return false;
    },
    prswitch: function (id, el) {
        $('#subwiz_opt span').removeClass('active');
        $(el).parent().addClass('active');
        $('.pr_desc').hide();
        $('#pr_desc' + id).show();
    },
    editslug: function (el) {
        $(el).hide();
        $('#category_slug_edit').show();
        $('.changemeurl').hide();
        return false;
    },
};

$(function () {

    function rebindOnlick() {
        $('#serializeit a.ajax[onclick]').each(function () {
            var self = $(this),
                whenclick = self[0].onclick;
            self.data('whenclick', function () {
                return whenclick.call(self[0]);
            });
            self.removeAttr('onclick');
            try {
                HBServices.countArchived();
            } catch (e) { }
        })
    }

    function handleLink() {
        var self = $(this),
            entry = self.parents('.entry').eq(0),
            url = self.attr('href'),
            onclick = self.data('whenclick');

        if (onclick && onclick.call(this) === false) {
            return false;
        }

        entry.addClass('loading');
        $.get(url, function (resp) {
            resp = parse_response(resp);
            var form = $('#serializeit'),
                newentry = $(resp).filter('#' + entry.attr('id'))
            console.log(newentry, '#' + entry.attr('id'), entry)
            if (newentry.length)
                entry.replaceWith(newentry[0]);
            else
                entry.remove()
            rebindOnlick();
        });
        return false;
    }

    if ($('#addcategory').length) {
        $('.step1').css('opacity', 0.2);
        $('#categoryname').bind('keyup keydown change', function () {
            if ($(this).val() != '') {
                if ($('select[name=ptype]').val() != '0')
                    $('#submitbtn').removeAttr('disabled');
                $('.step1').css('opacity', 1);
                $('#hints').slideDown('fast');
                var w = $(this).val().replace(/[^a-zA-Z0-9-_\s]+/g, '-').replace(/[\s]+/g, '-').toLowerCase();
                if (!$('#category_slug_edit').is(':visible')) {
                    $('#category_slug_edit').val(w);
                }
                $('#hints .changemeurl').html(w);
            } else {
                $('.step1').css('opacity', 0.2);
                $('#hints').slideUp('fast');
                $('#submitbtn').attr('disabled', 'disabled');
            }
        });

        function saveOrder() {
            var sorts = $('#serializeit').serialize();
            ajax_update('?cmd=services&action=listcats&' + sorts, {});
        }

        $("#grab-sorter").dragsort({ dragSelector: "a.sorter-handle", dragBetween: true, dragEnd: saveOrder, placeHolderTemplate: "<li class='placeHolder'><div></div></li>" });
        $('#serializeit').on('click', 'a.ajax', handleLink)
    } else if ($('#category_id').length) {
        $('#categoryname').bind('keyup keydown change', function () {
            if ($(this).val() != '') {
                $('#hints').slideDown('fast');
                var w = $(this).val().replace(/[^a-zA-Z0-9-_\s]+/g, '-').replace(/[\s]+/g, '-').toLowerCase();
                if (!$('#category_slug_edit').is(':visible')) {
                    $('#category_slug_edit').val(w);
                }
                $('#hints .changemeurl').html(w);
            } else {
                $('#hints').slideUp('fast');
            }
        });

        function saveOrder() {
            var sorts = $('#serializeit').serialize();
            ajax_update('?cmd=services&action=listprods&' + sorts, {});
        }

        $("#grab-sorter").dragsort({ dragSelector: "a.sorter-handle", dragBetween: true, dragEnd: saveOrder, placeHolderTemplate: "<li class='placeHolder'><div></div></li>" });
        $('#serializeit').on('click', 'a.ajax', handleLink);
    }

    var $tpl = $('#template_descriptions');

    $tpl.on('click init', '.opage-list li', function () {
        $('#wiz_options li.activated').removeClass('activated');
        var self = $(this),
            inp = self.find('input')

        self.addClass('activated');
        inp.prop('checked', true);

        $('.gallery .gal_slide').hide();
        $('#o' + inp.attr('id')).show();
    });

    $(document).on('change init', 'select[name=contains]', function () {
        var self = $(this),
            val = $(this).val();
        $.post('?cmd=services&action=newpageextra', {
            ptype: val,
            selected: $('#wiz_options input:checked').val(),
            addcategory: true
        }, function (data) {
            $tpl.html(parse_response(data));
            $('.opage-list li.activated', $tpl).trigger('click');
            $('#submitbtn').removeAttr('disabled').prop('disabled', false);
            $('.category_contains').hide();
            $('.category_contains-' + val).show();
        });
    });

    $tpl.on('change init', 'select[name=ptype]', function () {
        var self = $(this),
            data = {
                ptype: self.val(),
                selected: $('#wiz_options input:checked').val(),
            };

        if (!$('#category_id').length)
            data.addcategory = true;

        $.post('?cmd=services&action=newpageextra', data, function (data) {

            $tpl.html(parse_response(data));
            $('.opage-list li.activated', $tpl).trigger('click');
            $('#submitbtn').removeAttr('disabled').prop('disabled', false);
        });
        return false;
    });

    $('.opage-list li.activated:first', $tpl).trigger('click');
    setTimeout( function () {
        rebindOnlick()
    },500);

    $(document).ready(function () {
        try {
            HBServices.countArchived();
        } catch (e) { }
    });


    var due = $('[name="config[InvoiceGeneration]"]'),
        pror = $('[name="config[ProRataDay]"]'),
        pron = $('[name="config[ProRataNextMonth]"]'),
        genddate = $('.pror-gendate'),
        duedate = $('.pror-duedate');

    function ord(d) {
        if (d > 3 && d < 21)
            return d + 'th'; // thanks kennebec
        switch (d % 10) {
            case 1:
                return d + "st";
            case 2:
                return d + "nd";
            case 3:
                return d + "rd";
            default:
                return d + "th";
        }
    }
    pror.add(pron[0]).on('change init', function () {
        var self = $(this),
            val = parseInt(self.val())
        if (isNaN(val) || !val || val < 1)
            self.val(1);
        else if (val > 28)
            self.val(28);

        var d = new Date(),
            proday = pror.val() % 31 || pror.val();

        if (proday > 28) {
            d.setDate(28)
        } else {
            d.setDate(pror.val())
        }
    }).eq(0).trigger('init')

    due.add([pror[0], pron[0]]).on('change init', function (e) {
        var d = new Date(),
            proday = pror.val() % 31 || pror.val(),
            dueday = due.val();

        if (proday > 28) {
            d.setDate(28)
        } else {
            d.setDate(pror.val())
        }
        duedate.text(ord(d.getDate()));

        var uni = [],
            sub = d.getDate() - dueday;

        for (var i = 0; i < 12; i++) {
            var d3 = new Date(d.getTime());
            d3.setMonth(i)
            d3.setDate(sub)
            if (uni.indexOf(d3.getDate()) < 0)
                uni.push(d3.getDate())
        }

        if (uni.length > 1) {
            genddate.text('beetween ' + ord(Math.min.apply(Math, uni))
                + ' and ' + ord(Math.max.apply(Math, uni)))
        } else {
            genddate.text('on ' + ord(uni[0]))
        }

    }).trigger('init');

    var prorataToggles = $('input[name="config[EnableProRata]"]');
    prorataToggles.on('change init', function (e) {
        var on = prorataToggles.filter(':checked').val() == 'on';
        $('.prorata').toggle(on);

        var gen = $('.gen-days-before'),
            mov = $('.move-due-date');

        if (on) {
            gen.insertAfter('#move-due-date')
            mov.insertAfter('#gen-days-before')
        } else {
            mov.insertAfter('#move-due-date')
            gen.insertAfter('#gen-days-before')
        }

        if (e.type == 'change') {
            if (on) {
                mov.find('input').val(gen.find('input').val())
                gen.find('input').val(0).trigger('change');
            } else {
                console.log(mov.find('input').val())
                gen.find('input').val(mov.find('input').val()).trigger('change')
                mov.find('input').val(0);
            }
        }
    }).eq(0).trigger('init');

    $('#serializeit').hbtagsFilter({
        items: '.entry',
        container: '.tag-filter-container',
        reset: '.tag-filter-reset'
    }).on('tagsfilter.filter', function (ev, items) {
        items.filter('.archived').css('display', '');
    });

    $('#tagsCont').hbtags({ autoSubmit: true })
        .on('tags.add', function (e, tag) {
            $.post('?cmd=tags&action=addtag&rel_type=Product', {
                tag: tag,
                id: $('#product_id').val()
            });
        })
        .on('tags.rem', function (e, tag) {
            $.post('?cmd=tags&action=removetag&rel_type=Product', {
                tag: tag,
                id: $('#product_id').val()
            });
        });


    var primport = $('#import-product');
    primport.bootboxform();

    $('.import-product').on('click', function () {
        primport.trigger('show');
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

    $('#productedit .chosen').chosenedge({ width: "100%", enable_split_word_search: true, search_contains: true })

});