$('#paymentTypeForm-PBX').submit(function (event) {
    if ($('#submitData-PBX').prop('disabled')) {
        return true;
    }
    event.preventDefault();
    $('#warnings').empty();
    $('#submitData-PBX').prop('disabled', true);

    var ds = new WirecardCEE_DataStorage();
    var paymentInformation = {};
    paymentInformation.payerPayboxNumber = $('#payerPayboxNumber-PBX').val();
    ds.storePayboxInformation(paymentInformation, function(oResponse) {
        if (oResponse.getStatus() == 0) {
            $('#payerPayboxNumber-PBX').val('');
            $.getJSON($('#paymentTypeForm-PBX').attr('action'), function(html)
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
            $('#submitData-PBX').prop('disabled', false);
        }
    });
})