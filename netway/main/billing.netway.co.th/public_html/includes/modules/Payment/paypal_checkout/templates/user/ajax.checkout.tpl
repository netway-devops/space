<div id="paypal-button-paynow"></div>
<script>
    {literal}
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
                        purchase_units: [{
                            amount: {
                                currency_code: "{/literal}{$currency_code}{literal}",
                                value: '{/literal}{$amount}{literal}',
                            },
                            description: "{/literal}{$subject}{literal}",
                            custom_id: "{/literal}{$invoice.id}{literal}",
                        }]
                    });
                },
                onApprove: function(data, actions) {
                    $('#paypal-button-paynow').addLoader();
                    return actions.order.capture().then(function(details) {
                        console.log("Transaction completed by " + details.payer.name.given_name);
                        $.post("?cmd=paypal_checkout&action=pay&do=success&invoice_id={/literal}{$invoice.id}{literal}", {data: data, details: details}, function() {
                            window.location.replace("{/literal}{$success_url}{literal}");
                        });
                    });
                }
            }).render("#paypal-button-paynow");
        };

        script.src = "https://www.paypal.com/sdk/js?client-id={/literal}{$pp.api_client_id}{literal}&locale={/literal}{$pp.btn.locale}{literal}&currency={/literal}{$currency_code}{literal}";
        document.getElementsByTagName("head")[0].appendChild(script);
    });
    {/literal}
</script>