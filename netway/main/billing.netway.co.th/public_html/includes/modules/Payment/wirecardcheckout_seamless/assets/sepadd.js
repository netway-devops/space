$('#paymentTypeForm-SEPA-DD').submit(function (event) {
    if ($('#submitData-SEPA-DD').prop('disabled')) {
        return true;
    }
    event.preventDefault();
    $('#warnings').empty();
    $('#submitData-SEPA-DD').prop('disabled', true);

    var ds = new WirecardCEE_DataStorage();
    var paymentInformation = {};
    paymentInformation.accountOwner = $('#bankAccountOwner-SEPA-DD').val();
    paymentInformation.bankBic = $('#bankBic-SEPA-DD').val();
    paymentInformation.bankAccountIban = $('#bankAccountIban-SEPA-DD').val();
    ds.storeSepaDdInformation(paymentInformation, function (oResponse) {
        if (oResponse.getStatus() == 0) {
            $('#bankAccountOwner-SEPA-DD').val('');
            $('#bankBic-SEPA-DD').val('');
            $('#bankAccountIban-SEPA-DD').val('');
            $.getJSON($('#paymentTypeForm-SEPA-DD').attr('action'), function(html)
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
            $('#submitData-SEPA-DD').prop('disabled', false);
        }
    });
})