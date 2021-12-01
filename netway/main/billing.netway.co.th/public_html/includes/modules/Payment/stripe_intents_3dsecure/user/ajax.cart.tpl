<link href="{$base_url}includes/modules/Payment/stripe_intents_3dsecure/user/ccard.css" rel="stylesheet" type="text/css" />
<div class="wbox card">
    <div class="wbox_header card-header">
        <strong>{$lang.ccard}</strong>
    </div>
    <div class="wbox_content card-body ccform">
        {if $stripe_ccard}
            <div class="stripe-credit-card {$stripe_ccard.cardtype|strtolower}">
                <div class="stripe-credit-card-last4">
                    {$stripe_ccard.last4}
                </div>
                <div class="stripe-credit-card-expiry">
                    {$stripe_ccard.expirymonth}/{$stripe_ccard.expiryyear}
                </div>
            </div>
            <button class="btn btn-default mt-3 btnStripeOtherCard">{$lang.strp_other_card}</button>
            {literal}
                <script type="text/javascript">
                    (function () {
                        $('.btnStripeOtherCard').on('click', function (e) {
                            e.preventDefault('');
                            $(this).addClass('btn-disabled').prop('disabled', true);
                            $.ajax({
                                type: 'GET',
                                url: '?cmd=stripe_intents_3dsecure&action=cart&new=true',
                                success: function (data) {
                                    var resp = parse_response(data);
                                    $('.stripe_cart').html(resp);
                                }
                            });
                        });
                    })();
                </script>
            {/literal}
        {else}
            <div class="wrapper stripe-box">
                <div id="payform_card-element"></div>
                <div class="stripe-error" role="alert"><svg xmlns="http://www.w3.org/2000/svg" width="17" height="17" viewBox="0 0 17 17">
                        <path class="base" fill="#000" d="M8.5,17 C3.80557963,17 0,13.1944204 0,8.5 C0,3.80557963 3.80557963,0 8.5,0 C13.1944204,0 17,3.80557963 17,8.5 C17,13.1944204 13.1944204,17 8.5,17 Z"></path>
                        <path class="glyph" fill="#FFF" d="M8.5,7.29791847 L6.12604076,4.92395924 C5.79409512,4.59201359 5.25590488,4.59201359 4.92395924,4.92395924 C4.59201359,5.25590488 4.59201359,5.79409512 4.92395924,6.12604076 L7.29791847,8.5 L4.92395924,10.8739592 C4.59201359,11.2059049 4.59201359,11.7440951 4.92395924,12.0760408 C5.25590488,12.4079864 5.79409512,12.4079864 6.12604076,12.0760408 L8.5,9.70208153 L10.8739592,12.0760408 C11.2059049,12.4079864 11.7440951,12.4079864 12.0760408,12.0760408 C12.4079864,11.7440951 12.4079864,11.2059049 12.0760408,10.8739592 L9.70208153,8.5 L12.0760408,6.12604076 C12.4079864,5.79409512 12.4079864,5.25590488 12.0760408,4.92395924 C11.7440951,4.59201359 11.2059049,4.59201359 10.8739592,4.92395924 L8.5,7.29791847 L8.5,7.29791847 Z"></path>
                    </svg>
                    <span class="stripe-error-message"></span>
                </div>
                {if $old_ccard}
                    <div class="form-check mt-3 mr-3">
                        <input type="checkbox" name="store_cc" value="1">
                        <label class="form-check-label">{$lang.strp_replace_card} (<b>{$old_ccard.cardtype|ucfirst}:</b> {$old_ccard.cardnum})</label>
                    </div>
                {/if}
            </div>
            {literal}
                <script type="text/javascript">
                    (function () {
                        var country =  $("#field_country").val();
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
                        var form = $('.stripe-box').closest('form');
                        var stripeprocessed = false;

                        $(form).on('change', '[name="gateway"]', function(event){
                            $(form).find('[type="submit"]').removeClass('disabled').prop('disabled', false);
                        });

                        $(form).on('click', '[type="submit"]', function(event){
                            if (country !== $('#field_country').val()) //singup.js:24 prevent
                                return true;

                            if (form.find('[name="cust_method"]:checked').val() === 'login')
                                return true;

                            if (form.find('[name="gateway"]:checked').val() != '{/literal}{$stripemodid}{literal}')
                                return true;

                            var btn = $(this);
                            if (stripeprocessed) {
                                stripeprocessed = false;
                                return;
                            }

                            event.preventDefault();
                            btn.addClass('disabled').prop('disabled', true);
                            stripe.handleCardSetup(
                                    "{/literal}{$intent_secret}{literal}",
                                    card
                            ).then(function (result) {
                                if (result.error) {
                                    $('.stripe-error').addClass('visible');
                                    $('.stripe-error-message').html(result.error.message);
                                    btn.removeClass('disabled').prop('disabled', false);
                                } else {
                                    $('.stripe-error').removeClass('visible');
                                    $.ajax({
                                        type: 'POST',
                                        url: '?cmd=stripe_intents_3dsecure&action=cart',
                                        data: {
                                            store: $('[name="store_cc"]').is(':checked') ? 1 : 0,
                                            stripeToken: result.setupIntent.payment_method
                                        },
                                        success: function (data) {
                                            stripeprocessed = true;
                                            btn.removeClass('disabled').prop('disabled', false);
                                            $(btn).trigger('click');
                                        }
                                    });
                                }
                            });
                        });
                    })();
                </script>
            {/literal}
        {/if}
    </div>
</div>
