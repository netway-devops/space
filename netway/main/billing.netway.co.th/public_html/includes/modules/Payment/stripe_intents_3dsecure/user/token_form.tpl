<script src="https://js.stripe.com/v3/"></script>
<div class="wrapper stripe-box">
    <div id="payform_card-element"></div>
    <div class="stripe-error" role="alert"><svg xmlns="http://www.w3.org/2000/svg" width="17" height="17" viewBox="0 0 17 17">
            <path class="base" fill="#000" d="M8.5,17 C3.80557963,17 0,13.1944204 0,8.5 C0,3.80557963 3.80557963,0 8.5,0 C13.1944204,0 17,3.80557963 17,8.5 C17,13.1944204 13.1944204,17 8.5,17 Z"></path>
            <path class="glyph" fill="#FFF" d="M8.5,7.29791847 L6.12604076,4.92395924 C5.79409512,4.59201359 5.25590488,4.59201359 4.92395924,4.92395924 C4.59201359,5.25590488 4.59201359,5.79409512 4.92395924,6.12604076 L7.29791847,8.5 L4.92395924,10.8739592 C4.59201359,11.2059049 4.59201359,11.7440951 4.92395924,12.0760408 C5.25590488,12.4079864 5.79409512,12.4079864 6.12604076,12.0760408 L8.5,9.70208153 L10.8739592,12.0760408 C11.2059049,12.4079864 11.7440951,12.4079864 12.0760408,12.0760408 C12.4079864,11.7440951 12.4079864,11.2059049 12.0760408,10.8739592 L9.70208153,8.5 L12.0760408,6.12604076 C12.4079864,5.79409512 12.4079864,5.25590488 12.0760408,4.92395924 C11.7440951,4.59201359 11.2059049,4.59201359 10.8739592,4.92395924 L8.5,7.29791847 L8.5,7.29791847 Z"></path>
        </svg>
        <span class="stripe-error-message"></span>
    </div>
    <form action="?cmd=stripe_intents_3dsecure&action=obtain_token" method="post" id="payment-form" target="_top">
        <input type='hidden' name='stripeToken'>
    </form>
    <button class='btn btn-primary w-100 btn-paynow2'>{$lang.continue}</button>
</div>
{literal}
    <style>
        #payform_card-element {
            margin-bottom: 30px;
            box-sizing: border-box;
            height: 40px;
            max-width: 600px;
            padding: 10px 12px;
            border: 1px solid transparent;
            border-radius: 4px;
            background-color: white;
            box-shadow: 0 1px 3px 0 #babec3;
        }

        .stripe-box {
            margin: 0 auto;
            width: 100%;
            max-width: 600px;
        }

        .stripe-box .stripe-error {
            display: none;
            margin: 20px 0;
        }

        .stripe-box .stripe-error.visible {
            display: block;
        }

        .stripe-box .stripe-error svg {
            margin-right: 10px;
        }

        .stripe-box .stripe-error svg .base {
            fill: #e25950;
        }

        .stripe-box .stripe-error svg .glyph {
            fill: #f6f9fc;
        }

        .stripe-box .stripe-error .stripe-error-message {
            color: #e25950;
        }
    </style>

<script type="text/javascript">
    (function () {
        $('.btn-paynow').remove();
        var stripe = Stripe('{/literal}{$pk}{literal}');
        var elements = stripe.elements({
            locale: 'auto'
        });
        var card = elements.create('card', {
            iconStyle: 'solid',
            style: {
                base: {
                    color: "#32325D",
                    fontSize: '15px'
                },
                invalid: {
                    iconColor: '#e85746',
                    color: '#e85746',
                }
            },
        });
        card.mount('#payform_card-element');
        var form = $('.stripe-box #payment-form');
        $('.btn-paynow2').on('click', function (event) {
            event.preventDefault();
            var btn = $(this);
            var form = $('#payment-form');
            var input = form.find('input[name=\"stripeToken\"]');
            btn.prop('disabled', true);
            stripe.handleCardSetup(
                "{/literal}{$intent_secret}{literal}",
                card
            ).then(function (result) {
                if (result.error) {
                    btn.prop('disabled', false);
                    $('.stripe-error').addClass('visible');
                    $('.stripe-error-message').html(result.error.message);
                } else {
                    input.val(result.setupIntent.payment_method);
                    form.submit();
                }
            });
        });
    })();
</script>
{/literal}





