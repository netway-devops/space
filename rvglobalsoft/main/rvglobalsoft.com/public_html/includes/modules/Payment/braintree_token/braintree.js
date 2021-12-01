
$(function() {
    var client = new braintree.api.Client({clientToken: braintree.module.token});

    var invoice = $('input[name=invoice_id]'),
        ccform = invoice.parents('form').eq(0);

    var  ccpcontent  = $('#ccpcontent').length ? $('#ccpcontent') : ccform.find('table').eq(0);

    if (!braintree.module.isTokenized) {
        console.log('not tokenized');
        $('input[name=cc_details]').each(function() {
            $(this).parents('tr').eq(0).remove();
        });
        $('#newcard').show();
        ccpcontent.append('<input name="cc_details" value="new" type="checkbox" checked="checked" style="display:none" />');
    }

    function aaadError(message) {

        message = message.split("\n");

        var ob = {};
        ob.ERROR = [];
        ob.INFO = [];
        ob.STACK = 0;

        for (var i = 0; i < message.length; i++) {
            if (!message[i].match('_'))
                ob.ERROR.push(message[i]);
        }

        ob = JSON.stringify(ob)
        parse_response('<!-- ' + ob + ' -->');
    }


    ccform.attr('onsubmit', '');
    ccform.on('submit', function() {

        var type = $('input[name=cc_details]:checked').val();
        console.log(type);
        if (type != 'new' || ccform.data('verified')) {
            ccpcontent.addLoader();
            return true;
        }

        var number = $('input[name="cc[cardnum]"]'),
            expm = $('input[name="cc[expirymonth]"]'),
            expy = $('input[name="cc[expiryyear]"]');
            
        console.log(number, expm, expy);
        if (braintree.module.tdsecure) {

            try {
                var card = {
                    number: number.val(),
                    expirationMonth: expm.val(),
                    expirationYear: "20" + expy.val()
                };

                client.verify3DS({
                    amount: braintree.module.amount,
                    creditCard: card
                }, function(error, response) {
                    console.log(error, response);
                    console.log('braintree 3');
                    if (!error) {
                        ccpcontent.append('<input name="verify3DS[nonce]" value="' + response.nonce + '" type="hidden" />')
                            .append('<input name="verify3DS[liabilityShifted]" value="' + (response.verificationDetails.liabilityShifted ? '1' : '0') + '" type="hidden" />')
                            .append('<input name="verify3DS[liabilityShiftPossible]" value="' + (response.verificationDetails.liabilityShifted ? '1' : '0') + '" type="hidden" />')
                            .append('<input name="continue" value="1" type="hidden" />');

                        ccform.data('verified', true);
                        ccform.submit();
                    }
                    console.log(error)
                    aaadError(error.message);
                    $('#preloader').remove();
                    return false;
                });
            } catch (err) {
                console.log(err)
                $('#preloader').remove();
                aaadError(err);
            }
            console.log('block')
            return false;
        }
        ccpcontent.addLoader();
        return true;
    });
})