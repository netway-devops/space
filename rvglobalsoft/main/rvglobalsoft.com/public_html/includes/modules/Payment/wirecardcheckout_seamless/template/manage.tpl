<div id="errors_container">

</div>
<link href="includes/modules/Payment/wirecardcheckout_seamless/assets/style.css" rel="stylesheet" media="all" />

<script src="{$storage.javascript_url}" type="text/javascript"></script>
<script src="includes/modules/Payment/wirecardcheckout_seamless/assets/payment-selector.js" type="text/javascript"></script>
<input type="hidden" name="invoice_id" value="{$invoice_id}" id="invoice_id" />

<div  id="payment-selection">

    {if $methods.CCARD}
    <div class="span4 form-based" id="div_CCARD">
        <div class="thumbnail">
            <a href="#" class="selection-payment-type" id="CCARD">
                <img src="includes/modules/Payment/wirecardcheckout_seamless/assets/ccard.png" alt="Credit Card" class="img-responsive text-center" style="max-height: 28px;">
                <div class="caption">
                    <div class="text-center">
                        <b>Credit Card</b>
                    </div>
                </div>
            </a>
            <div id="payment-form-CCARD" class="row payment-form">
            </div>
        </div>
    </div>{/if}

    {if $methods.SOFORTUEBERWEISUNG}
    <div class="span4 " id="div_SOFORTUEBERWEISUNG">
        <div class="thumbnail">
            <a href="#" class="selection-payment-type" id="SOFORTUEBERWEISUNG">
                <img src="includes/modules/Payment/wirecardcheckout_seamless/assets/sue.jpg" alt="SOFORT Banking" class="img-responsive text-center" style="max-height: 28px;">
                <div class="caption">
                    <div class="text-center">
                        <b>SOFORT Banking</b>
                    </div>
                </div>
            </a>
            <div id="payment-form-SOFORTUEBERWEISUNG" class="row payment-form">
            </div>
        </div>
    </div>{/if}

    {if $methods.PAYPAL}
    <div class="span4" id="div_PAYPAL">
        <div class="thumbnail">
            <a href="#" class="selection-payment-type" id="PAYPAL">
                <img src="includes/modules/Payment/wirecardcheckout_seamless/assets/paypal.png" alt="PayPal" class="img-responsive text-center" style="max-height: 28px;">
                <div class="caption">
                    <div class="text-center">
                        <b>PayPal</b>
                    </div>
                </div>
            </a>
            <div id="payment-form-PAYPAL" class="row payment-form">
            </div>
        </div>
    </div>{/if}

    {if $methods.INVOICE}
    <div class="span4" id="div_INVOICE">
        <div class="thumbnail">
            <a href="#" class="selection-payment-type" id="INVOICE">
                <img src="includes/modules/Payment/wirecardcheckout_seamless/assets/wirecard_payolution_ratepay.png" alt="Invoice" class="img-responsive text-center" style="max-height: 28px;">
                <div class="caption">
                    <div class="text-center">
                        <b>Invoice</b>
                    </div>
                </div>
            </a>
            <div id="payment-form-INVOICE" class="row payment-form">
            </div>
        </div>
    </div>{/if}

    {if $methods.EPS}
    <div class="span4  form-based" id="div_EPS">
        <div class="thumbnail">
            <a href="#" class="selection-payment-type" id="EPS">
                <img src="includes/modules/Payment/wirecardcheckout_seamless/assets/eps.jpg" alt="eps Online Bank Transfer" class="img-responsive text-center" style="max-height: 28px;">
                <div class="caption">
                    <div class="text-center">
                        <b>eps Online Bank Transfer</b>
                    </div>
                </div>
            </a>
            <div id="payment-form-EPS" class="row payment-form">
            </div>
        </div>
    </div>{/if}

    {if $methods.INSTALLMENT}
    <div class="span4" id="div_INSTALLMENT">
        <div class="thumbnail">
            <a href="#" class="selection-payment-type" id="INSTALLMENT">
                <img src="includes/modules/Payment/wirecardcheckout_seamless/assets/payolution_ratepay.png" alt="Installment" class="img-responsive text-center" style="max-height: 28px;">
                <div class="caption">
                    <div class="text-center">
                        <b>Installment</b>
                    </div>
                </div>
            </a>
            <div id="payment-form-INSTALLMENT" class="row payment-form">
            </div>
        </div>
    </div>{/if}

    {if $methods.SEPA}<div class="span4 form-based" id="div_SEPA-DD">
        <div class="thumbnail">
            <a href="#" class="selection-payment-type" id="SEPA-DD">
                <img src="includes/modules/Payment/wirecardcheckout_seamless/assets/sepa-dd.jpg" alt="SEPA Direct Debit" class="img-responsive text-center" style="max-height: 28px;">
                <div class="caption">
                    <div class="text-center">
                        <b>SEPA Direct Debit</b>
                    </div>
                </div>
            </a>
            <div id="payment-form-SEPA-DD" class="row payment-form">
            </div>
        </div>
    </div>{/if}

    {if $methods.TATRAPAY}<div class="span4 " id="div_TATRAPAY">
        <div class="thumbnail">
            <a href="#" class="selection-payment-type" id="TATRAPAY">
                <img src="includes/modules/Payment/wirecardcheckout_seamless/assets/tatrapay.png" alt="TatraPay" class="img-responsive text-center" style="max-height: 28px;">
                <div class="caption">
                    <div class="text-center">
                        <b>TatraPay</b>
                    </div>
                </div>
            </a>
            <div id="payment-form-TATRAPAY" class="row payment-form">
            </div>
        </div>
    </div>{/if}

    {if $methods.PSC}<div class="span4" id="div_PSC">
        <div class="thumbnail">
            <a href="#" class="selection-payment-type" id="PSC">
                <img src="includes/modules/Payment/wirecardcheckout_seamless/assets/paysafecard.png" alt="paysafecard" class="img-responsive text-center" style="max-height: 28px;">
                <div class="caption">
                    <div class="text-center">
                        <b>paysafecard</b>
                    </div>
                </div>
            </a>
            <div id="payment-form-PSC" class="row payment-form">
            </div>
        </div>
    </div>{/if}

    {if $methods.SKRILLDIRECT}<div class="span4" id="div_SKRILLDIRECT">
        <div class="thumbnail">
            <a href="#" class="selection-payment-type" id="SKRILLDIRECT">
                <img src="includes/modules/Payment/wirecardcheckout_seamless/assets/skrill_direct.jpg" alt=" Skrill Direct" class="img-responsive text-center" style="max-height: 28px;">
                <div class="caption">
                    <div class="text-center">
                        <b> Skrill Direct</b>
                    </div>
                </div>
            </a>
            <div id="payment-form-SKRILLDIRECT" class="row payment-form">
            </div>
        </div>
    </div>{/if}

    {if $methods.PBX}<div class="span4  form-based" id="div_PBX">
        <div class="thumbnail">
            <a href="#" class="selection-payment-type" id="PBX">
                <img src="includes/modules/Payment/wirecardcheckout_seamless/assets/paybox.jpg" alt="paybox" class="img-responsive text-center" style="max-height: 28px;">
                <div class="caption">
                    <div class="text-center">
                        <b>paybox</b>
                    </div>
                </div>
            </a>
            <div id="payment-form-PBX" class="row payment-form">
            </div>
        </div>
    </div>{/if}

    {if $methods.SKRILLWALLET}<div class="span4" id="div_SKRILLWALLET">
        <div class="thumbnail">
            <a href="#" class="selection-payment-type" id="SKRILLWALLET">
                <img src="includes/modules/Payment/wirecardcheckout_seamless/assets/skrill.jpg" alt="Skrill Digital Wallet" class="img-responsive text-center" style="max-height: 28px;">
                <div class="caption">
                    <div class="text-center">
                        <b>Skrill Digital Wallet</b>
                    </div>
                </div>
            </a>
            <div id="payment-form-SKRILLWALLET" class="row payment-form">
            </div>
        </div>
    </div>{/if}

    {if $methods.GIROPAY}<div class="span4 form-based" id="div_GIROPAY">
        <div class="thumbnail">
            <a href="#" class="selection-payment-type" id="GIROPAY">
                <img src="includes/modules/Payment/wirecardcheckout_seamless/assets/giropay.jpg" alt="giropay" class="img-responsive text-center" style="max-height: 28px;">
                <div class="caption">
                    <div class="text-center">
                        <b>giropay</b>
                    </div>
                </div>
            </a>
            <div id="payment-form-GIROPAY" class="row payment-form">
            </div>
        </div>
    </div>{/if}

    {if $methods.EKONTO}<div class="span4 " id="div_EKONTO">
        <div class="thumbnail">
            <a href="#" class="selection-payment-type" id="EKONTO">
                <img src="includes/modules/Payment/wirecardcheckout_seamless/assets/ekonto.jpg" alt="eKonto" class="img-responsive text-center" style="max-height: 28px;">
                <div class="caption">
                    <div class="text-center">
                        <b>eKonto</b>
                    </div>
                </div>
            </a>
            <div id="payment-form-EKONTO" class="row payment-form">
            </div>
        </div>
    </div>{/if}

    {if $methods.POLI}<div class="span4" id="div_POLI">
        <div class="thumbnail">
            <a href="#" class="selection-payment-type" id="POLI">
                <img src="includes/modules/Payment/wirecardcheckout_seamless/assets/poli.jpg" alt="POLi" class="img-responsive text-center" style="max-height: 28px;">
                <div class="caption">
                    <div class="text-center">
                        <b>POLi</b>
                    </div>
                </div>
            </a>
            <div id="payment-form-POLI" class="row payment-form">
            </div>
        </div>
    </div>{/if}

    {if $methods.MONETA}<div class="span4" id="div_MONETA">
        <div class="thumbnail">
            <a href="#" class="selection-payment-type" id="MONETA">
                <img src="includes/modules/Payment/wirecardcheckout_seamless/assets/moneta-ru.jpg" alt="moneta.ru" class="img-responsive text-center" style="max-height: 28px;">
                <div class="caption">
                    <div class="text-center">
                        <b>moneta.ru</b>
                    </div>
                </div>
            </a>
            <div id="payment-form-MONETA" class="row payment-form">
            </div>
        </div>
    </div>{/if}

    {if $methods.IDL}<div class="span4  form-based" id="div_IDL">
        <div class="thumbnail">
            <a href="#" class="selection-payment-type" id="IDL">
                <img src="includes/modules/Payment/wirecardcheckout_seamless/assets/ideal.jpg" alt=" iDEAL" class="img-responsive text-center" style="max-height: 28px;">
                <div class="caption">
                    <div class="text-center">
                        <b> iDEAL</b>
                    </div>
                </div>
            </a>
            <div id="payment-form-IDL" class="row payment-form">
            </div>
        </div>
    </div>{/if}

    {if $methods.EPAY_BG}<div class="span4" id="div_EPAY_BG">
        <div class="thumbnail">
            <a href="#" class="selection-payment-type" id="EPAY_BG">
                <img src="includes/modules/Payment/wirecardcheckout_seamless/assets/epaybg.gif" alt="ePay.bg" class="img-responsive text-center" style="max-height: 28px;">
                <div class="caption">
                    <div class="text-center">
                        <b>ePay.bg</b>
                    </div>
                </div>
            </a>
            <div id="payment-form-EPAY_BG" class="row payment-form">
            </div>
        </div>
    </div>{/if}

    {if $methods.VOUCHER}<div class="span4 form-based" id="div_VOUCHER">
        <div class="thumbnail">
            <a href="#" class="selection-payment-type" id="VOUCHER">
                <img src="includes/modules/Payment/wirecardcheckout_seamless/assets/voucher.png" alt="My Voucher" class="img-responsive text-center" style="max-height: 28px;">
                <div class="caption">
                    <div class="text-center">
                        <b>My Voucher</b>
                    </div>
                </div>
            </a>
            <div id="payment-form-VOUCHER" class="row payment-form">
            </div>
        </div>
    </div>{/if}

    {if $methods.TRUSTPAY}<div class="span4  form-based" id="div_TRUSTPAY">
        <div class="thumbnail">
            <a href="#" class="selection-payment-type" id="TRUSTPAY">
                <img src="includes/modules/Payment/wirecardcheckout_seamless/assets/trustpay.gif" alt="TrustPay" class="img-responsive text-center" style="max-height: 28px;">
                <div class="caption">
                    <div class="text-center">
                        <b>TrustPay</b>
                    </div>
                </div>
            </a>
            <div id="payment-form-TRUSTPAY" class="row payment-form">
            </div>
        </div>
    </div>{/if}
</div>