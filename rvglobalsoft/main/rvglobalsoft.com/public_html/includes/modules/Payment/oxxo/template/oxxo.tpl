<html>
<head>
    <link href="{$base_url}includes/modules/Payment/oxxo/template/src/styles.css" media="all" rel="stylesheet" type="text/css" />
    <link href="https://fonts.googleapis.com/css?family=Open+Sans:400,600,700" rel="stylesheet">
</head>
<body>
{if $error}
    <h1>Connection error, please contact administrator</h1>
{else}
    <div class="opps">
        <div class="opps-header">
            <div class="opps-reminder">Digital Stub. Printing is not necessary.</div>
            <div class="opps-info">
                <div class="opps-brand"><img src="{$base_url}includes/modules/Payment/oxxo/template/src/oxxopay_brand.png" alt="OXXOPay"></div>
                <div class="opps-ammount">
                    <h3>Amount due</h3>
                    <h2>$ {$amount} <sup>{$currency_code}</sup></h2>
                    <p>OXXO will charge an additional fee at the time of payment.</p>
                </div>
            </div>
            <div class="opps-reference">
                <h3>Reference</h3>
                <h1>{$reference}</h1>
            </div>
        </div>
        <div class="opps-instructions">
            <h3>Instructions</h3>
            <ol>
                <li>Go to the nearest OXXO store. <a href="https://www.google.com.mx/maps/search/oxxo/" target="_blank">Find it here</a>.</li>
                <li>Tell the cashier that you want to make an <strong>OXXOPay</strong> payment.</li>
                <li>Dictate the cashier the reference number on this stub.</li>
                <li>Make the payment with cash.</li>
                <li>To confirm your payment, the cashier will hand you a printed receipt. <strong>Check on it that it was performed correctly.</strong> </li>
            </ol>
            <div class="opps-footnote">When completing these steps you will receive confirmation email from <strong>Business name</strong>.</div>
        </div>
    </div>
{/if}
</body>
</html>