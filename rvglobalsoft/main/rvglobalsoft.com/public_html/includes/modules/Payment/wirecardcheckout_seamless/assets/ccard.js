$('#paymentTypeForm-CCARD').submit(function (event) {
    if ($('#submitData-CCARD').prop('disabled')) {
        return true;
    }
    event.preventDefault();
    $('#warnings').empty();
    $('#submitData-CCARD').prop('disabled', true);

    var ds = new WirecardCEE_DataStorage();
    var paymentInformation = {};
    paymentInformation.cardverifycode = $('#cardVerificationCode-CCARD').val();
    $('#cardVerificationCode-CCARD').val('');
    paymentInformation.pan = $('#pan-CCARD').val();
    paymentInformation.cardholderName = $('#cardholderName-CCARD').val();
    paymentInformation.expirationMonth = $('select[name=month]').val();
    paymentInformation.expirationYear = $('select[name=year]').val();
    ds.storeCreditCardInformation(paymentInformation, function (oResponse) {
        if (oResponse.getStatus() == 0) {
            $('#pan-CCARD').val('');
            $('#cardholderName-CCARD').val('');
            $('select[name=month]').val('');
            $('select[name=year]').val('');
            //$('#paymentTypeForm-CCARD').submit();
            $.getJSON($('#paymentTypeForm-CCARD').attr('action'), function(html)
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
            $('#submitData-CCARD').prop('disabled', false);
        }
    });
})