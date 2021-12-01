$('#paymentTypeForm-GIROPAY').submit(function (event) {
    if ($('#submitData-GIROPAY').prop('disabled')) {
        return true;
    }
    event.preventDefault();
    $('#warnings').empty();
    $('#submitData-GIROPAY').prop('disabled', true);

    var ds = new WirecardCEE_DataStorage();
    var paymentInformation = {};
    paymentInformation.bankAccountOwner = $('#bankAccountOwner-GIROPAY').val();
    paymentInformation.bankAccount = $('#bankAccount-GIROPAY').val();
    paymentInformation.bankNumber = $('#bankNumber-GIROPAY').val();
    ds.storeGiropayInformation(paymentInformation, function(oResponse) {
        if (oResponse.getStatus() == 0) {
            $('#bankAccountOwner-GIROPAY').val('');
            $('#bankAccount-GIROPAY').val('');
            $('#bankNumber-GIROPAY').val('');
            $.getJSON($('#paymentTypeForm-GIROPAY').attr('action'), function(html)
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
            $('#submitData-GIROPAY').prop('disabled', false);
        }
    });
})