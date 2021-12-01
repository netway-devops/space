<div class="wbox card">
    <div class="wbox_header card-header">
        {$lang.payment}
    </div>
    <div class="wbox_content card-body paypal-button-wrap">
        <div id="paypal-button-paynow"></div>
        <div class="alert alert-success alert-paypal" style="display: none;">{$lang.paypal_cart_success}</div>
        <div class="alert alert-danger alert-paypal" style="display: none;">
            <p>{$lang.paypal_cart_error}</p>
            <p class="alert-paypal-danger-msg"></p>
        </div>
        {literal}
            <script>
                $(function () {
                    var script = document.createElement("script")
                    script.type = "text/javascript";
                    script.onload = function () {
                        paypal.Buttons({
                            style: {
                                size: '{/literal}{$pp.btn.size}{literal}',
                                layout: '{/literal}{$pp.btn.layout}{literal}',
                                color: '{/literal}{$pp.btn.color}{literal}',
                                shape: '{/literal}{$pp.btn.shape}{literal}',
                                label: '{/literal}{$pp.btn.label}{literal}',
                            },
                            createOrder: function(data, actions) {
                                return actions.order.create({
                                    intent: "CAPTURE",
                                    purchase_units: [{
                                        amount: {
                                            currency_code: "{/literal}{$currency_code}{literal}",
                                            value: '{/literal}{$amount}{literal}',
                                        },
                                    }]
                                });
                            },
                            onApprove: function(data, actions) {
                                $('#paypal-button-paynow').addLoader();
                                $.post("?cmd=paypal_checkout&action=cart", {order: data}, function(response) {
                                    if (response.success) {
                                        $('.alert-paypal.alert-success').show();
                                    } else {
                                        $('.alert-paypal.alert-danger').show();
                                    }
                                    $('#paypal-button-paynow').remove();
                                });
                            },
                            onError: function (err) {
                                $('.alert-paypal.alert-success').remove();
                                $('.alert-paypal.alert-danger').show().find('.alert-paypal-danger-msg').html(err);
                            }
                        }).render("#paypal-button-paynow");
                    };

                    script.src = "https://www.paypal.com/sdk/js?client-id={/literal}{$pp.api_client_id}{literal}&intent=capture&currency={/literal}{$currency_code}{literal}&locale={/literal}{$pp.btn.locale}{literal}";
                    document.getElementsByTagName("head")[0].appendChild(script);
                });
            </script>
        {/literal}
    </div>
</div>