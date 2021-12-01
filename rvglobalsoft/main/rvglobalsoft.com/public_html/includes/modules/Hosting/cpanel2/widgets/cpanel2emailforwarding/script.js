$(function() {
    var domain = $('#domain'),
        user = $('#user'),
        dir = $('#dir'),
        pass1 = $('#password1'),
        pass2 = $('#password2');

    domain.bind('input keyup, change', function() {
        var val = domain.val();
        user.val(val.split(/\./i).slice(0, -1).join('.') || val);
        dir.val('public_html/' + val);
    })
    pass1.add(pass2).bind('input focus keyup change', function() {

        if (pass1.val() != pass2.val()) {
            pass2.parents('.control-group').eq(0).addClass('error');
            return false;
        } else {
            pass2.parents('.control-group').eq(0).removeClass('error');
        }
    })
    $('#mainform').submit(function() {
        if (pass1.val() != pass2.val())
            return false;
    });
    $('[data-action]').click(function(e) {
        e.preventDefault();
        var self = $(this),
            edit = $('#action-' + self.data('action')).clone(true);

        edit.find('.hide-modal').click(function() {
            edit.modal('hide');
        });
        edit.on('hidden', function() {
            edit.remove();
        });
        edit.find(".vtip_description").data('tooltip','');

        edit.on('shown', function() {
            edit.find(".vtip_description").tooltip();
        });
        edit.modal({
            show: true,
        })
    })
})