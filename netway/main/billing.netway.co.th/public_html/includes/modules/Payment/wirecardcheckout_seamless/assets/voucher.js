$('#paymentTypeForm-VOUCHER').submit(function (event) {
    if ($('#submitData-VOUCHER').prop('disabled')) {
        return true;
    }
    event.preventDefault();
    $('#warnings').empty();
    $('#submitData-VOUCHER').prop('disabled', true);

    var ds = new WirecardCEE_DataStorage();
    var paymentInformation = {};
    paymentInformation.voucherId = $('#voucherId-VOUCHER').val();
    ds.storeVoucherInformation(paymentInformation, function(oResponse) {
        if (oResponse.getStatus() == 0) {
            $('#voucherId-VOUCHER').val('');
            $.getJSON($('#paymentTypeForm-VOUCHER').attr('action'), function(html)
            {
                window.location = html.redirectUrl;
            });
        }
        else {
            $.each(oResponse.getErrors(), function (index, value) {
                var msg = $('<div class="alert alert-error">' +
                    '<button type="button" class="close" data-dismiss="alert">&times;</button>' +
                    value.consumerMessage + '</div>'
                );
                $('#errors_container').append(msg);
            });
            $('#submitData-VOUCHER').prop('disabled', false);
        }
    });
})