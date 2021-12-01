function testConnectionList(data, el) {
    var alert = bootbox.dialog({
        message: '<div class="text-center"><i class="fa fa-spin fa-spinner"></i> Loading...</div>',
        size: 'large',
        backdrop: true,
        onEscape: true
    });
    $('.modal-body',alert).css("font-family", 'monospace');

    var generalmsg = 'Test finished with error. Check HostBill error logs for more information. ',
        throwError = function(msg) {
            $('.bootbox-body', alert).html($('<span></span>').css({fontWeight: 'bold', color: ' #990000'}).text(msg))
        }

    data = typeof data == 'object' ? data : {'server_id': data};

    $.ajax('?cmd=joker_money_balance&action=test_connection', {
        data: data,
        type: 'post',
        error: function(xhr, status, error) {
            console.log('e');
            console.log(error);
            throwError(xhr.status + ' ' + error + '. ' + generalmsg);
        },
        success: function(data) {
            console.log(data);
            console.log('s');
            if (!data || !data.length)
                throwError(generalmsg);
            else
                $('.bootbox-body', alert).html(parse_response(data));
        },
    });
    return false;
}

function testConfiguration(self) {
    var config = $('#connection_form').serializeObject(),
        id = $(self).data('id');
    if (Number.isInteger(id)) {
        config = {
            "connect[api_key]": $(self).data('api_key'),
            "connect[ote]": $(self).data('ote')
        };
    }
    var data = $.extend({}, config, {
        'module_id': ($('#default_module').length) ? $('#default_module').val() : $('#modulepicker').val(),
        'hash': $('textarea[name="hash"]').val(),
    });

    return testConnectionList(data, null)
}