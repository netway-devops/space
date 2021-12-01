<link href="{$base_url}includes/modules/Payment/stripe_intents_acss/user/styles.css" rel="stylesheet" type="text/css" />
{literal}
    <script type="text/javascript">
        (function () {
            $('.btn-paynow').remove();
            var stripe = Stripe('{/literal}{$pk}{literal}');
            var btn = $(this);
            var form = $('#payment-form');
            var strBox = $('.stripe-box');
            strBox.addClass('submitting');
            btn.prop('disabled', true);

            stripe.confirmAcssDebitSetup("{/literal}{$setup_intent_secret}{literal}", {
                payment_method: {
                    billing_details: {/literal}{$owner_json}{literal},
                },
            }).then(function(result) {
                strBox.removeClass('submitting');
                if (result.error) {
                    strBox.removeClass('submitted');
                    btn.prop('disabled', false);
                    $('.stripe-error').addClass('visible');
                    $('.stripe-error-message').html(result.error.message);
                    return false;
                } else {
                    strBox.addClass('submitted');
                    form.find('input[name=\"sintent\"]').val(result.setupIntent.id);
                    form.submit();
                }
            });
        })();
    </script>
{/literal}
<div class="wrapper stripe-box">
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
        <h3 class="title" data-tid="elements_examples.success.title">{$lang.success}</h3>
    </div>
    <form action="?cmd=stripe_intents_acss&action=pay&do=new" method="post" id="payment-form" target="_top">
        <input type='hidden' name='sintent'>
        <input type='hidden' name='invoice_id' value="{$invoice_id}">
    </form>
</div>





