$().ready(function() {
    $('.selection-payment-type').click(function(e) {
        e.preventDefault();
        var paymentType = $(this).attr('id');
        var selectedPaymentType = $('.selected-payment-method');
        if(selectedPaymentType.attr('id') !=  'div_' + paymentType)
        {
            $('.warnings').empty();
            selectedPaymentType.switchClass('span8', 'span4', {easing: 'easeInOutCirc'}).switchClass('span12', 'span6', {easing: 'easeInOutCirc'}).removeClass('selected-payment-method');
            $('.payment-form').slideUp({easing: 'easeInOutCirc'});
            var paymentTypeDiv = $('#div_' + paymentType);
            if(paymentTypeDiv.hasClass('form-based')) {
                paymentTypeDiv.addClass('selected-payment-method').switchClass('span4', 'span8', {easing: 'easeInOutCirc'}).switchClass('span6', 'span12', {easing: 'easeInOutCirc'});
            } else {
                paymentTypeDiv.find('.thumbnail').addLoader();
            }
            url = "?cmd=wirecardcheckout_seamless&action=loadform&type=" + paymentType+"&invoice_id="+$('#invoice_id').val();


            $('#payment-form-' + paymentType).load(url, function(html) {
                var processingPaymentType = $('#div_' + paymentType);
                if(processingPaymentType.hasClass('selected-payment-method') && typeof html !== 'object')
                {
                    $(this).slideDown( {easing: 'easeInOutCirc'});
                }
                else
                {
                    window.location = JSON.parse(html).redirectUrl;
                }

            });
        }

    });
});
