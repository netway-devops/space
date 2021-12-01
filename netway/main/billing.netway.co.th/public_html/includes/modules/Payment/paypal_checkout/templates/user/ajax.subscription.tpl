<div id="paypal-button-subscription"></div>
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
                createSubscription: function (data, actions) {
                    return actions.subscription.create({
                        plan_id: "{/literal}{$subscription.pp_plan.id}{literal}",
                        custom_id: "{/literal}{$subscription.hb_subscription.subscr_id}{literal}",
                        invoice_id: "{/literal}{$invoice.id}{literal}",
                    });
                },
                onApprove: function (data, actions) {
                    $.post("?cmd=paypal_checkout&action=pay&do=success&invoice_id={/literal}{$invoice.id}{literal}", {data: data}, function() {
                        window.location.replace("{/literal}{$success_url}{literal}");
                    });
                }
            }).render("#paypal-button-subscription");
        };

        script.src = "https://www.paypal.com/sdk/js?client-id={/literal}{$pp.api_client_id}{literal}&vault=true&intent=subscription&locale={/literal}{$pp.btn.locale}{literal}";
        document.getElementsByTagName("head")[0].appendChild(script);
    });
    {/literal}
</script>