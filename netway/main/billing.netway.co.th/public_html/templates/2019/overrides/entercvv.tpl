{literal}
    <script>
        if ($('.credit-card-box').length) {
            initCCard();
        }
    </script>
{/literal}
<div class="card">
    <div class="card-header">
        <strong>{$lang.ccarddetails}</strong>
    </div>
    <div class="card-body ccform">
        <div class="checkout">
            <div class="credit-card">
                <div class="credit-card-box">
                    <div class="flip">
                        <div class="front">
                            <div class="credit-card-box-chip"></div>
                            <div class="credit-card-box-logo {$creditcard.cardtype}"></div>
                            <div class="credit-card-box-number">{$creditcard.cardnum}</div>
                            <div class="credit-card-box-holder">
                                <label>{$lang.ccholder}</label>
                                <div>{$login.firstname} {$login.lastname}</div>
                            </div>
                            <div class="credit-card-box-expiration-date">
                                <label>{$lang.ccexpiry}</label>
                                <div>{$creditcard.expdate}</div>
                            </div>
                        </div>
                        <div class="back">
                            <div class="credit-card-box-strip"></div>
                            <div class="credit-card-box-logo">
                            </div>
                            <div class="credit-card-box-ccv">
                                <label>CCV</label>
                                <div></div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
            <div class="d-flex flex-column justify-content-center align-items-center">
                <div class="form-group" style="max-width: 300px;">
                    <div class="input-group">
                        <div class="input-group-prepend">
                            <div class="input-group-text">CVV2</div>
                        </div>
                        <input type="password"  class="form-control card-ccv_js" name="cc[cvv]" required="required" maxlength="5"/>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>



