<link href="{$base_url}includes/modules/Payment/stripe_intents_3dsecure/user/styles.css" rel="stylesheet" type="text/css" />
{literal}
    <script type="text/javascript">
        (function () {
            $('.btn-paynow').remove();
            var stripe = Stripe('{/literal}{$pk}{literal}');
            var elements = stripe.elements({
                locale: 'auto'
            });
            var elementStyles = {
                base: {
                    color: '#424770',
                    fontSize: '14px',
                    ':focus': {
                        color: '#424770',
                    },
                    '::placeholder': {
                        color: '#9BACC8',
                    },
                    ':focus::placeholder': {
                        color: '#CFD7DF',
                    },
                },
                invalid: {
                    color: '#FA755A',
                    ':focus': {
                        color: '#FFCCA5',
                    },
                    '::placeholder': {
                        color: '#FFCCA5',
                    },
                },
            };

            var elementClasses = {
                focus: 'focus',
                empty: 'empty',
                invalid: 'invalid',
            };
            var cardNumber = elements.create('cardNumber', {
                style: elementStyles,
                classes: elementClasses,
            });
            cardNumber.mount('#payform_card-number');
            var cardExpiry = elements.create('cardExpiry', {
                style: elementStyles,
                classes: elementClasses,
            });
            cardExpiry.mount('#payform_card-expiry');
            var cardCvc = elements.create('cardCvc', {
                style: elementStyles,
                classes: elementClasses,
            });
            cardCvc.mount('#payform_card-cvc');
            $('.btn-paynow2').on('click', function (event) {
                event.preventDefault();
                var btn = $(this);
                var form = $('#payment-form');
                var inputT = form.find('input[name=\"stripePaymethod\"]');
                var inputI = form.find('input[name=\"stripeIntent\"]');
                var strBox = $('.stripe-box');
                strBox.addClass('submitting');
                btn.prop('disabled', true);
                stripe.handleCardPayment("{/literal}{$intent_secret}{literal}", cardNumber, {
                    payment_method_data: {
                    billing_details: {/literal}{$owner_json}{literal}
                    }}).then(function (result) {
                    strBox.removeClass('submitting');
                    if (result.error) {
                        strBox.removeClass('submitted');
                        btn.prop('disabled', false);
                        $('.stripe-error').addClass('visible');
                        $('.stripe-error-message').html(result.error.message);
                    } else {
                        strBox.addClass('submitted');
                        inputT.val(result.paymentIntent.payment_method);
                        inputI.val(result.paymentIntent.id);
                        form.submit();
                    }
                });
            });
        })();
    </script>
{/literal}
<div class="wrapper stripe-box">
    <div class="fieldset" id="payform_card">
        <div id="payform_card-number" class="payform_card-element"></div>
        <div id="payform_card-expiry" class="payform_card-element"></div>
        <div id="payform_card-cvc" class="payform_card-element"></div>
{*        <input id="payform_card-zip" data-tid="elements_examples.form.postal_code_placeholder" class="payform_card-element" placeholder="Postal code">*}
    </div>
    <div class="stripe-error" role="alert"><svg xmlns="http://www.w3.org/2000/svg" width="17" height="17" viewBox="0 0 17 17">
            <path class="base" fill="#000" d="M8.5,17 C3.80557963,17 0,13.1944204 0,8.5 C0,3.80557963 3.80557963,0 8.5,0 C13.1944204,0 17,3.80557963 17,8.5 C17,13.1944204 13.1944204,17 8.5,17 Z"></path>
            <path class="glyph" fill="#FFF" d="M8.5,7.29791847 L6.12604076,4.92395924 C5.79409512,4.59201359 5.25590488,4.59201359 4.92395924,4.92395924 C4.59201359,5.25590488 4.59201359,5.79409512 4.92395924,6.12604076 L7.29791847,8.5 L4.92395924,10.8739592 C4.59201359,11.2059049 4.59201359,11.7440951 4.92395924,12.0760408 C5.25590488,12.4079864 5.79409512,12.4079864 6.12604076,12.0760408 L8.5,9.70208153 L10.8739592,12.0760408 C11.2059049,12.4079864 11.7440951,12.4079864 12.0760408,12.0760408 C12.4079864,11.7440951 12.4079864,11.2059049 12.0760408,10.8739592 L9.70208153,8.5 L12.0760408,6.12604076 C12.4079864,5.79409512 12.4079864,5.25590488 12.0760408,4.92395924 C11.7440951,4.59201359 11.2059049,4.59201359 10.8739592,4.92395924 L8.5,7.29791847 L8.5,7.29791847 Z"></path>
        </svg>
        <span class="stripe-error-message"></span>
    </div>
    <div class="stripe-success">
        <div class="icon">
            <svg width="84px" height="84px" viewBox="0 0 84 84" version="1.1" xmlns="http://www.w3.org/2000/svg" xmlns:xlink="http://www.w3.org/1999/xlink">
                <circle class="border" cx="42" cy="42" r="40" stroke-linecap="round" stroke-width="4" stroke="#000" fill="none"></circle>
                <path class="checkmark" stroke-linecap="round" stroke-linejoin="round" d="M23.375 42.5488281 36.8840688 56.0578969 64.891932 28.0500338" stroke-width="4" stroke="#000" fill="none"></path>
            </svg>
        </div>
        <h3 class="title" data-tid="elements_examples.success.title">Card verfied</h3>
        <p class="message"><span data-tid="elements_examples.success.message">Your payment will now be submitted</span></p>
    </div>
    <form action="?cmd=stripe_intents_3dsecure&action=success" method="post" id="payment-form" target="_top">
        <input type='hidden' name='stripePaymethod'>
        <input type='hidden' name='stripeIntent'>
        <input type='hidden' name='invoice_id' value="{$invoice_id}">
    </form>
    <button class='btn-paynow2'>{$paynow_text}</button>
</div>





