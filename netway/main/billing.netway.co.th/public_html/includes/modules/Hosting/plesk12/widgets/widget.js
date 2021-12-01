$(function() {
    $('.management_links').each(function(i) {
        $(this).children().eq(0).click(function() {
            $(this).parents('tr').next().toggle();
            return false;
        });
    });
    $('.db_management_links').each(function(i) {
        $(this).children().eq(0).click(function() {
            $(this).parents('tr').next().toggle().next().hide();
            return false;
        });
        $(this).children().eq(1).click(function() {
            $(this).parents('tr').next().next().toggle().prev().hide();
            return false;
        });
        $(this).parent().next().find('img[title]').click(updateprivs);
    });
    var change = 0;
    $('.eml_management_links').each(function(i) {
        $(this).children().eq(0).click(function() {
            if ($(this).parents('tr').next().data('status') == 1) {
                $(this).parents('tr').next().hide().data('status', 0);
            } else {
                $(this).parents('tr').next().show().data('status', 1);
                $(this).parents('tr').next().find('.change_div').hide().eq(1).show();
            }
            return false;
        });
        $(this).children().eq(1).click(function() {
            if ($(this).parents('tr').next().data('status') == 2) {
                $(this).parents('tr').next().hide().data('status', 0);
                change = 0;
            } else {
                $(this).parents('tr').next().show().data('status', 2);
                $(this).parents('tr').next().find('.change_div').hide().eq(0).show();
            }
            return false;
        });
        $(this).children().eq(2).click(function() {
            if ($(this).parents('tr').next().data('status') == 3) {
                $(this).parents('tr').next().hide().data('status', 0);
                change = 0;
            } else {
                $(this).parents('tr').next().show().data('status', 3);
                $(this).parents('tr').next().find('.change_div').hide().eq(2).show();
            }
            return false;
        });
        $(this).children().eq(3).click(function() {
            if ($(this).parents('tr').next().data('status') == 4) {
                $(this).parents('tr').next().hide().data('status', 0);
                change = 0;
            } else {
                $(this).parents('tr').next().show().data('status', 4);
                $(this).parents('tr').next().find('.change_div').hide().eq(3).show();
            }
            return false;
        });
        $(this).children().eq(4).click(function() {
            if ($(this).parents('tr').next().data('status') == 5) {
                $(this).parents('tr').next().hide().data('status', 0);
                change = 0;
            } else {
                $(this).parents('tr').next().show().data('status', 5);
                $(this).parents('tr').next().find('.change_div').hide().eq(4).show();
            }
            return false;
        });
        // $(this).children().eq(5).click(function() {
        //     if ($(this).parents('tr').next().data('status') == 6) {
        //         $(this).parents('tr').next().hide().data('status', 0);
        //         change = 0;
        //     } else {
        //         $(this).parents('tr').next().show().data('status', 6);
        //         $(this).parents('tr').next().find('.change_div').hide().eq(5).show();
        //     }
        //     return false;
        // });
    });
    $('.email_quota').change(function() {
        if ($(this).children("option:selected").val() == 'custom') {
            var name = $(this).attr('name');
            $(this).replaceWith('<input name="' + name + '" size="8" class="span1">MB');
        }
    });
    $('.disab').find('input, select').prop('disabled', true).attr('disabled', 'disabled');
    $('input[type=submit]').bind('click', function(e) {
        //e.preventDefault();
        var self = $(this),
            form = self.parents('form').eq(0),
            sub = self.parents('#updater tr, tfoot').eq(0).find('input, select, textarea');

        //$.post(form.attr('action'), sub.serializeArray(), function(){

        //})
        form.find('input, select, textarea').not(sub).not('[name=security_token]').prop('disabled', true);
    })



    $('#add_alias').click(function () {
        var domain = $(this).data('domain');
        var index = $(this).data('index');
        var key = $(this).data('key');
        var alias_content = '<label class="alias_label"><input type="text" name="change['+index+'][newalias]['+key+']" value="">@'+domain+' <a class="alias_remove" onclick="$(this).parent().remove();" data-key="'+key+'">Remove</a></label>';
        $('#alias_content').append(alias_content);
        $(this).data('key', key+1);
    });

    $('.alias_remove').on('click', function () {
        $(this).parent().remove();
    });

    var charset = $('#a_charset').val();
    if (charset != ''){
        $("#autoreply_charset").val(charset);
    }

    var cf = $('#check_forwarding').is(":checked");
    if (cf == false){
        $('#text_forwarding').prop('disabled', true);
    }

    $('#check_forwarding').click(function () {
        if ($(this).is(":checked") == false){
            $('#text_forwarding').prop('disabled', true);
        }else{
            $('#text_forwarding').prop('disabled', false);
        }
    });

    if ($('#check_autoreply').is(":checked") == false){
        $('.content_autoreply').prop('disabled', true);
    }

    $('#check_autoreply').click(function () {
        if ($('#check_autoreply').is(":checked") == false){
            $('.content_autoreply').prop('disabled', true);
        }else{
            $('.content_autoreply').prop('disabled', false);
        }
    });
});
$(window).on('load resize', function(){

    $window = $('#reseller-frame').parent().parent();


    var geth=function(){
        return $window.height();
    };
    $('#reseller-frame').parent().height(geth);
    $('#reseller-frame').height(geth);
});