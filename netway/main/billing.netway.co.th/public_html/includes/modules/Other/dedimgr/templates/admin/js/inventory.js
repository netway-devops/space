function change_css(select) {
    var p = $(select).parent().find('div.preview').find('.rackitem'),
        form = p.parents('form').eq(0),
        u = parseInt(form.find('.u-size').val()) || 1,
        sidemount = form.find('.mount_type').val() == 'Side';
    p.attr('class', "")
        .addClass('rackitem')
        .css('background-image', 'url(' + hardwareurl + $(select).val() + ')');
    if (!sidemount)
        p.addClass('server' + u + 'u').height(20 * u).width('')
    else
        p.width(20 * u).height('')
    return false;
}

function assignnew(target) {
    var container = $(target),
        select = $(target + '_select'),
        value = select.val();


    function insert(id) {
        console.log(id)
        if (!id || id.length < 1)
            return false;
        
        if ($('input[value="' + id + '"]', container).length) {
            return false;
        }
        var option = $(target + '_group option[value="' + id + '"]');
        container.append("<div class='additional-field'><span ><a href='#' class=\"menuitm menu-auto sort-handle\" ><span class=\"movesth\"></span></a><!--\n\
        --><a href='#' class=\"menuitm menu-auto\" onclick='return remaddopt(this);'><span class=\"delsth\"></span>\n\
        </a></span><input type='hidden' name='fields[]' value='" + option.attr('value') + "'/>" + option.text() + " </div>");
        
        option.prop('disabled', true);
    }
console.log(value)
    if (value.match(';')) {
        
        $.each(value.split(';'), function() {
            insert(this.toString());
        })
    } else {
        insert(value);
    }



    return false;
}

function assignnew_current(it) {

}

function toggleTypeEdit(id, btn) {
    if (!$('#fform_' + id).is(':visible')) {
        $('#fname_' + id).hide();
        $('#fform_' + id).show();
        if (btn)
            $(btn).addClass('activated');
    } else {
        $('#fname_' + id).show();
        $('#fform_' + id).hide();
        $('.activated').removeClass('activated');
    }

    return false
}

function remaddopt(el) {
    $(el).parents('div').eq(0).remove();
    return false;
}

$(function() {
    $('.fileupload').each(function() {
        var that = $(this),
            target = that.prev();
        that.fileupload({
            dataType: 'json',
            url: '?cmd=dedimgr&do=uploadicon',
            done: function(e, data) {
                var lists = $('.hardwareicon');

                $.each(data.result, function(x) {
                    console.log('<option>' + this.name + '</option>', lists, target);
                    lists.append('<option>' + this.name + '</option>');
                    target.val(this.name).change();
                });
            },
            fail: function(e, data) {

            },
        });
    });
    $('.u-size').bind('keyup change', function(e) {
        recalculateIconSize($(this));
        change_css($(this).parents('table').eq(0).find('.hardwareicon')[0]);
        change_css($(this).parents('table').eq(0).find('.hardwareicon')[1]);
    });
    $('.mount_type').change(function() {
        var select = $(this),
            form = select.parents('form').eq(0);
        $('.mount_', form).hide().filter('.mount_' + select.val()).show();
        change_css($(this).parents('table').eq(0).find('.hardwareicon')[0]);
    });
    $('.additional-fields').each(function() {
        var self = $(this);
        self.dragsort({
            dragSelector: "a.sort-handle",
            itemSelector: '.additional-field',
            dragBetween: true,
            placeHolderTemplate: "<div class='additional-field'>&nbsp;</div>"
        });
    });
    $('.hardwareicon').change();
    recalculateIconSize($('.u-size'));
});

function recalculateIconSize(el) {
    var val = parseInt($(el).val());
    if (!val)
        val = 1;
    val = val * 20;
    val = Math.abs(val);
    $('.vtip_height').html(val + 'px');
}