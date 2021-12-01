<div class="checkout">
    <div class="credit-card">
        <div class="credit-card-box">
            <div class="flip">
                <div class="front">
                    <div class="credit-card-box-chip"></div>
                    <div class="credit-card-box-logo visa"></div>
                    <div class="credit-card-box-number"></div>
                    <div class="credit-card-box-holder">
                        <label>{$lang.ccholder}</label>
                        <div>{$cadetails.firstname} {$cadetails.lastname}</div>
                    </div>
                    <div class="credit-card-box-expiration-date">
                        <label>{$lang.ccexpiry}</label>
                        <div></div>
                    </div>
                </div>
                {if $need_cvv}
                    <div class="back">
                        <div class="credit-card-box-strip"></div>
                        <div class="credit-card-box-logo">
                        </div>
                        <div class="credit-card-box-ccv">
                            <label>CVV</label>
                            <div></div>
                        </div>
                    </div>
                {/if}
            </div>
        </div>
    </div>

    <table width="100%" cellpadding="2">
        <tr>
            <td width="150" >{$lang.cctype}</td>
            <td>
                <select class="form-control card-type_js"  name="cardtype" required="required">
                    {foreach from=$supportedcc item=cc}
                        <option>{$cc}</option>
                    {/foreach}
                </select>
            </td>
        </tr>
        <tr>
            <td >{$lang.ccnum}</td>
            <td><input type="num"  class="form-control card-number_js" name="cardnum" required="required"  maxlength="16" /></td>
        </tr>
        <tr>
            <td >{$lang.ccexpiry}</td>
            <td>
                <div class="d-flex flex-row align-items-center">
                    <select class="form-control w-50 card-expiration-month_js"  name="expirymonth" required="required">
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
                    <select class="form-control w-50 card-expiration-year_js"  name="expiryyear" required="required">
                        <option>YYYY</option>
                        {section name=bar start=21 loop=29}
                            <option value="{$smarty.section.bar.index}">20{$smarty.section.bar.index}</option>
                        {/section}
                    </select>
                </div>
            </td>
        </tr>
        {if $need_cvv}
            <tr>
                <td>CVV</td>
                <td><input type="password"  class="form-control w-25 card-ccv_js" name="cvv" required="required"  maxlength="5" /></td>
            </tr>
        {/if}
    </table>
</div>