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
                            <div class="credit-card-box-logo"></div>
                            <div class="credit-card-box-number"></div>
                            <div class="credit-card-box-holder">
                                <label>{$lang.ccholder}</label>
                                <div>{$login.firstname} {$login.lastname}</div>
                            </div>
                            <div class="credit-card-box-expiration-date">
                                <label>{$lang.ccexpiry}</label>
                                <div></div>
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
            <div class="row">
                <table width="100%" cellpadding="2" class="col-12 col-lg-8 m-0-auto">
                    <tr>
                        <td >{$lang.ccnum}</td>
                        <td>
                            <input type="num"  class="form-control card-number_js" name="cc[cardnum]" required="required"  maxlength="16" onblur="verifyCardNumber()" onkeyup="verifyCardNumber()" />
                        </td>
                    </tr>
                    <tr>
                        <td >{$lang.ccexpiry}</td>
                        <td>
                            <div class="d-flex flex-row align-items-center">
                                <select class="form-control w-50 card-expiration-month_js"  name="cc[expirymonth]" required="required">
                                    <option>MM</option>
                                    <option value="01">01</option>
                                    <option value="02">02</option>
                                    <option value="03">03</option>
                                    <option value="04">04</option>
                                    <option value="05">05</option>
                                    <option value="06">06</option>
                                    <option value="07">07</option>
                                    <option value="08">08</option>
                                    <option value="09">09</option>
                                    <option value="10">10</option>
                                    <option value="11">11</option>
                                    <option value="12">12</option>
                                </select>
                                <select class="form-control w-50 card-expiration-year_js"  name="cc[expiryyear]" required="required">
                                    <option>YYYY</option>
                                    {section name=bar start=$curyear loop=$curyear+10}
                                        <option value="{$smarty.section.bar.index}">20{$smarty.section.bar.index}</option>
                                    {/section}
                                </select>
                            </div>
                        </td>
                    </tr>
                    <tr>
                        <td >CVV2</td>
                        <td>
                            <input type="hidden" id="field_credit_type"  name="cc[cardtype]"  value="" />
                            <input type="password"  class="form-control w-25 card-ccv_js" name="cc[cvv]" required="required"  maxlength="5" />
                        </td>
                    </tr>
                </table>
            </div>
        </div>
    </div>
</div>
{literal}
    <script type="text/javascript">
        initCCard();
        function verifyCardNumber() {
            var num = $('.card-number_js').val();
            var type = getCreditCardType(num);
            if(type != 'unknown') {
                var clss = getCreditCardTypeClass(type);
                $(this).closest('.checkout').find('.credit-card-box-logo').attr('class', 'credit-card-box-logo').addClass(clss);
            }
            $('#field_credit_type').val(type);
        }
    </script>
{/literal}