$(document).ready(function () {
    var change = 0;
    $('.management_links [data-manage]').on('click', function (i) {
        var self = $(this),
            tr = self.parents('tr').next(),
            index = self.data('manage');

        if (tr.data('status') == index) {
            tr.hide().data('status', 0);
        } else {
            tr.show().data('status', index);
            tr.find('.manage-cnt').hide().eq(index - 1).show();
        }
        return false;
    });

    //db
    $('#widget-section').on('change', '.db-permissions', function () {
        var self = $(this),
            //status was recently changed, unchecked forms are now checked
            command = self.is(':checked') ? 'grantacces' : 'removeacces';

        self.parents('tr:first').addClass('loading');

        $.ajax({
            type: 'POST',
            url: window.location.url,
            dataType: 'json',
            data: {
                dbname: self.val(),
                username: self.data('user'),
                updateprivs: command
            },
            success: function (data) {
                var status = !data || !data.event ? false : !!data.event.result;

                self.parents('tr:first').removeClass('loading');
                if (command == 'removeacces')
                    self.prop('checked', !status)
                else
                    self.prop('checked', status)
            },
            error: function (data) {
                self.parents('tr:first').removeClass('loading');
            },
        });
    })
    
    //email
    $('.email_quota').change(function () {
        if ($(this).children("option:selected").val() == 'custom') {
            var name = $(this).attr('name');
            $(this).replaceWith('<input name="' + name + '" size="8" class="">MB');
        }
    });
});