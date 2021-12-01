<!DOCTYPE html>
<html><head>
    <script src="https://js.stripe.com/v3/"></script>
    <link href="{$system_url}includes/modules/Payment/stripe_source_3dsecure/user/base.css" type="text/css" rel="stylesheet">{literal}
    <style media="screen">
        body, html {
            height: 100%;
            background-color: #f7f8f9;
            color: #6b7c93;
        }

        .example.example4 {
            background-color: #f6f9fc;
            margin: 20px auto;
            width: 600px;
        }

        .example.example4 * {
            font-family: Interface, Open Sans, Segoe UI, sans-serif;
            font-size: 15px;
            font-weight: 500;
        }

        .example.example4 form {

            padding: 0 15px;
        }

        .example.example4 form > * + * {
            margin-top: 20px;
        }

        .example.example4 .container {
            background-color: #fff;
            box-shadow: 0 4px 6px rgba(50, 50, 93, 0.11), 0 1px 3px rgba(0, 0, 0, 0.08);
            border-radius: 4px;
            padding: 3px;
        }

        .example.example4 fieldset {
            border-style: none;
            padding: 5px;
            margin-left: -5px;
            margin-right: -5px;
            background: rgba(18, 91, 152, 0.05);
            border-radius: 8px;
        }

        .example.example4 fieldset legend {
            float: left;
            width: 100%;
            text-align: center;
            font-size: 13px;
            color: #8898aa;
            padding: 3px 10px 7px;
        }

        .example.example4 .card-only {
            display: block;
        }
        .example.example4 .payment-request-available {
            display: none;
        }

        .example.example4 fieldset legend + * {
            clear: both;
        }

        .example.example4 input, .example.example4 button {
            -webkit-appearance: none;
            -moz-appearance: none;
            appearance: none;
            outline: none;
            border-style: none;
            color: #fff;
        }

        .example.example4 input:-webkit-autofill {
            transition: background-color 100000000s;
            -webkit-animation: 1ms void-animation-out;
        }

        .example.example4 #card-element {
            padding: 10px;
            margin-bottom: 2px;
        }

        .example.example4 input {
            -webkit-animation: 1ms void-animation-out;
        }

        .example.example4 input::-webkit-input-placeholder {
            color: #9bacc8;
        }

        .example.example4 input::-moz-placeholder {
            color: #9bacc8;
        }

        .example.example4 input:-ms-input-placeholder {
            color: #9bacc8;
        }

        .example.example4 button {
            display: block;
            width: 100%;
            height: 37px;
            background-color: #2ECC71;
            border-radius: 2px;
            color: #fff;
            cursor: pointer;
        }

        .example.example4 button:active {
            background-color: #2ECC71;
        }

        .example.example4 .error svg .base {
            fill: #e25950;
        }

        .example.example4 .error svg .glyph {
            fill: #f6f9fc;
        }

        .example.example4 .error .message {
            color: #e25950;
        }

        .example.example4 .success .icon .border {
            stroke: #3397dc;
        }

        .example.example4 .success .icon .checkmark {
            stroke: #0073b1;
        }

        .example.example4 .success .title {
            color: #32325d;
        }

        .example.example4 .success .message {
            color: #8898aa;
        }

        .example.example4 .success .reset path {
            fill: #d782d9;
        }
    </style>{/literal}
</head>

<body>
<div class="wrapper  example example4">

    <form action="?cmd=stripe_source_3dsecure&action=pay&invoice_id={$invoice_id}" method="post" id="payment-form" target="_top">

        <fieldset>
            <legend class="card-only" data-tid="elements_examples.form.pay_with_card">Pay with card</legend>
            <legend class="payment-request-available" data-tid="elements_examples.form.enter_card_manually">Or enter card details</legend>
            <div class="container">
                <div id="card-element"></div>
                <button type="submit" data-tid="elements_examples.form.donate_button">{$lang.paynow}</button>
            </div>
        </fieldset>
        <div class="error" role="alert"><svg xmlns="http://www.w3.org/2000/svg" width="17" height="17" viewBox="0 0 17 17">
                <path class="base" fill="#000" d="M8.5,17 C3.80557963,17 0,13.1944204 0,8.5 C0,3.80557963 3.80557963,0 8.5,0 C13.1944204,0 17,3.80557963 17,8.5 C17,13.1944204 13.1944204,17 8.5,17 Z"></path>
                <path class="glyph" fill="#FFF" d="M8.5,7.29791847 L6.12604076,4.92395924 C5.79409512,4.59201359 5.25590488,4.59201359 4.92395924,4.92395924 C4.59201359,5.25590488 4.59201359,5.79409512 4.92395924,6.12604076 L7.29791847,8.5 L4.92395924,10.8739592 C4.59201359,11.2059049 4.59201359,11.7440951 4.92395924,12.0760408 C5.25590488,12.4079864 5.79409512,12.4079864 6.12604076,12.0760408 L8.5,9.70208153 L10.8739592,12.0760408 C11.2059049,12.4079864 11.7440951,12.4079864 12.0760408,12.0760408 C12.4079864,11.7440951 12.4079864,11.2059049 12.0760408,10.8739592 L9.70208153,8.5 L12.0760408,6.12604076 C12.4079864,5.79409512 12.4079864,5.25590488 12.0760408,4.92395924 C11.7440951,4.59201359 11.2059049,4.59201359 10.8739592,4.92395924 L8.5,7.29791847 L8.5,7.29791847 Z"></path>
            </svg>
            <span class="message"></span></div>






        {securitytoken}
        <input type="hidden" name="invoice_id" value="{$invoice_id}"/>
    </form>
    <div class="success">
        <div class="icon">
            <svg width="84px" height="84px" viewBox="0 0 84 84" version="1.1" xmlns="http://www.w3.org/2000/svg" xmlns:xlink="http://www.w3.org/1999/xlink">
                <circle class="border" cx="42" cy="42" r="40" stroke-linecap="round" stroke-width="4" stroke="#000" fill="none"></circle>
                <path class="checkmark" stroke-linecap="round" stroke-linejoin="round" d="M23.375 42.5488281 36.8840688 56.0578969 64.891932 28.0500338" stroke-width="4" stroke="#000" fill="none"></path>
            </svg>
        </div>
        <h3 class="title" data-tid="elements_examples.success.title">Card verfied</h3>
        <p class="message"><span data-tid="elements_examples.success.message">Your payment will now be submitted</span></p>

    </div>
</div>

{literal}
<script type="text/javascript">
    (function() {
        "use strict";
    // Create a Stripe client
    var stripe = Stripe('{/literal}{$pk}{literal}');

    // Create an instance of Elements
    var elements = stripe.elements({
        fonts: [
            {
                cssSrc: "https://rsms.me/inter/inter-ui.css"
            }
        ],

        locale: 'auto'
    });

    // Custom styling can be passed to options when creating an Element.
    // (Note that this demo uses a wider set of styles than the guide below.)
    var style = {
        style: {
            base: {
                color: "#32325D",
                fontWeight: 500,
                fontFamily: "Inter UI, Open Sans, Segoe UI, sans-serif",
                fontSize: "15px",
                fontSmoothing: "antialiased",

                "::placeholder": {
                    color: "#CFD7DF"
                }
            },
            invalid: {
                color: "#E25950"
            }
        }
    };

    // Create an instance of the card Element
    var card = elements.create('card', {style: style});

    // Add an instance of the card Element into the `card-element` <div>
    card.mount('#card-element');


    // Handle form submission
     var form = document.getElementById('payment-form');
        var example = document.querySelector(".example");
        var error = form.querySelector('.error');
        var errorMessage = error.querySelector('.message');

        [card].forEach(function(element) {
            element.on('change', function(event) {
                if (event.error) {
                    error.classList.add('visible');
                    errorMessage.innerText = event.error.message;
                } else {
                    error.classList.remove('visible');
                }
            });
        });

    form.addEventListener('submit', function(event) {


        event.preventDefault();

        example.classList.add('submitting');

        stripe.createSource(card,{
            owner: {
                email: "{/literal}{$owner.email}{literal}",
                name: "{/literal}{$owner.firstname} {$owner.lastname} {literal}",
                {/literal}{if $owner.phonenumber}phone: "{$owner.phonenumber}",{/if}{literal}
                address: {
                    city: {/literal}{$owner.city|json_encode}{literal},
                    country: {/literal}{$owner.country|json_encode}{literal},
                    line1: {/literal}{$owner.address1|json_encode}{literal},
                    line2: {/literal}{$owner.address2|json_encode}{literal},
                    postal_code: {/literal}{$owner.postcode|json_encode}{literal},
                    state : {/literal}{$owner.state|json_encode}{literal}
                }
            },
            statement_descriptor: {/literal}{$statement_descriptor|json_encode}{literal},
            metadata:{
            original_invoice_id: '{/literal}{$invoice_id}{literal}'
        }}).then(function(result) {

            example.classList.remove('submitting');

            if (result.error) {
                // Inform the user if there was an error

                error.classList.add('visible');
                errorMessage.innerText =  result.error.message;
            } else {

                error.classList.remove('visible');
                example.classList.add('submitted');
                // Send the token to your server
                stripeTokenHandler(result.source);
            }
        });
    });

    function stripeTokenHandler(token) {

        var form = document.getElementById('payment-form');
        var hiddenInput = document.createElement('input');
        hiddenInput.setAttribute('type', 'hidden');
        hiddenInput.setAttribute('name', 'stripeSource');
        hiddenInput.setAttribute('value',JSON.stringify(token));
        form.appendChild(hiddenInput);


        // Submit the form
        form.submit();

    }

    })();
</script>{/literal}