$(function() {
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
        edit.find(".vtip_description").data('tooltip', '');

        edit.on('shown', function() {
            edit.find(".vtip_description").tooltip();
        });
        edit.modal({
            show: true,
        })

        edit.find('.presetcert').click(function(ev) {
            ev.preventDefault();
            
            var host = $('input[name=sslcert]:checked', edit).val() || '';
            $.post(window.location.href, {
                gethost: host
            }, function(data) {
                $('#preloader').remove();
                if (!data)
                    return false;
                if (data.domain)
                    $('#ssldomain').val(data.domain);
                if (data.crt)
                    $('#sslcrt').val(data.crt);
                if (data.key)
                    $('#sslkey').val(data.key);
            })
            
            $('#mainform').addLoader();
            edit.modal('hide');
        });
    })
})