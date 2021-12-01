{if $type=='CCARD'}
    <div class="">
        <form action="?cmd=wirecardcheckout_seamless&action=loadform&invoice_id={$invoice_id}&paynow=true&security_token={$security_token}&type=CCARD" method="post" name="paymentTypeForm-CCARD" class="form-horizontal" id="paymentTypeForm-CCARD">                        <div class="form-group">
                <label class="col-sm-5 control-label" for="cardholderName-CCARD">Card holder</label>        <div class="col-sm-5">
                    <input type="text" name="cardholderName" id="cardholderName-CCARD" class="form-control" value="">        </div>
            </div>
            <div class="form-group">
                <label class="col-sm-5 control-label" for="pan-CCARD">Credit card number</label>        <div class="col-sm-5">
                    <input type="number" name="pan" id="pan-CCARD" class="form-control" value="">        </div>
            </div>
            <div class="form-group">
                <label class="col-sm-5 control-label" for="cardVerificationCode-CCARD">Card security code</label>
                <div class="col-sm-5">
                    <input type="number" name="cardVerificationCode" id="cardVerificationCode-CCARD" class="form-control" value="">        </div>
            </div>
            <div class="form-group">
                <label class="col-sm-5 control-label" for="expirationDate-CCARD">Expiration date</label>        <div class="col-sm-5">
                    <div class="input-group" style="width: 100%"><select name="month" class="form-control"><option value="01">January</option>
                            <option value="02">February</option>
                            <option value="03">March</option>
                            <option value="04" >April</option>
                            <option value="05">May</option>
                            <option value="06">June</option>
                            <option value="07">July</option>
                            <option value="08">August</option>
                            <option value="09">September</option>
                            <option value="10">October</option>
                            <option value="11">November</option>
                            <option value="12">December</option></select><span class="input-group-btn" style="width:0px;"></span><select name="year" class="form-control"><option value="2016" >2016</option>
                            <option value="2017">2017</option>
                            <option value="2018">2018</option>
                            <option value="2019">2019</option>
                            <option value="2020">2020</option>
                            <option value="2021">2021</option>
                            <option value="2022">2022</option>
                            <option value="2023">2023</option>
                            <option value="2024">2024</option>
                            <option value="2025">2025</option>
                            <option value="2026">2026</option>
                            <option value="2027">2027</option>
                            <option value="2028">2028</option>
                            <option value="2029">2029</option>
                            <option value="2030">2030</option>
                            <option value="2031">2031</option>
                            <option value="2032">2032</option>
                            <option value="2033">2033</option>
                            <option value="2034">2034</option>
                            <option value="2035">2035</option>
                            <option value="2036">2036</option></select></div>        </div>
            </div>
            <input type="hidden" name="orderIdent" id="invoice_id" value="{$invoice_id}">
            <input type="hidden" name="storageId" id="storageId" value="{$storage.storage_id}">
            <input type="hidden" name="paymentType" id="paymentType" value="CCARD">
            <div class="col-sm-5 control-label "></div>
            <div class="span5">
                <input type="submit" class="btn btn-primary pull-right submitData" value="Continue »" id="submitData-CCARD">
            </div>
        </form>
    </div>
{elseif $type=='SEPA-DD'}
    <div class="">
        <form action="?cmd=wirecardcheckout_seamless&action=loadform&invoice_id={$invoice_id}&paynow=true&security_token={$security_token}&type=SEPA-DD" method="post" name="paymentTypeForm-SEPA-DD" class="form-horizontal" id="paymentTypeForm-SEPA-DD">                        <div class="form-group">
                <label class="span3 control-label " for="bankAccountOwner-SEPA-DD">Account owner</label>        <div class="col-sm-5">
                    <input type="text" name="bankAccountOwner" id="bankAccountOwner-SEPA-DD" class="form-control" value="">        </div>
            </div>
            <div class="form-group">
                <label class="span3 control-label " for="bankAccountIban-SEPA-DD">IBAN</label>        <div class="col-sm-5">
                    <input type="text" name="bankAccountIban" id="bankAccountIban-SEPA-DD" class="form-control" value="">        </div>
            </div>
            <div class="form-group">
                <label class="span3 control-label " for="bankBic-SEPA-DD">BIC</label>        <div class="col-sm-5">
                    <input type="text" name="bankBic" id="bankBic-SEPA-DD" class="form-control" value="">        </div>
            </div>

            <input type="hidden" name="orderIdent" id="invoice_id" value="{$invoice_id}">
            <input type="hidden" name="storageId" id="storageId" value="{$storage.storage_id}">
            <input type="hidden" name="paymentType" id="paymentType" value="SEPA-DD">
            <div class="span5 control-label "></div>
            <div class="span5">
                <input type="submit" class="btn btn-primary pull-right submitData" value="Continue »" id="submitData-SEPA-DD">
            </div>
        </form>
    </div>
{elseif $type=='PBX'}
    <div class="">
        <form action="?cmd=wirecardcheckout_seamless&action=loadform&invoice_id={$invoice_id}&paynow=true&security_token={$security_token}&type=PBX" method="post" name="paymentTypeForm-PBX" class="form-horizontal" id="paymentTypeForm-PBX">                        <div class="form-group">
                <label class="span3 control-label " for="payerPayboxNumber-PBX">paybox number</label>        <div class="col-sm-5">
                    <input type="text" name="payerPayboxNumber" id="payerPayboxNumber-PBX" class="form-control" value="">        </div>
            </div>

            <input type="hidden" name="orderIdent" id="invoice_id" value="{$invoice_id}">
            <input type="hidden" name="storageId" id="storageId" value="{$storage.storage_id}">
            <input type="hidden" name="paymentType" id="paymentType" value="PBX">                                    <div class="span5 control-label "></div>
            <div class="span5">
                <input type="submit" class="btn btn-primary pull-right submitData" value="Continue »" id="submitData-PBX">
            </div>
        </form>
    </div>
{elseif $type=='GIROPAY'}
    <div class="">
        <form action="?cmd=wirecardcheckout_seamless&action=loadform&invoice_id={$invoice_id}&paynow=true&security_token={$security_token}&type=GIROPAY" method="post" name="paymentTypeForm-GIROPAY" class="form-horizontal" id="paymentTypeForm-GIROPAY">                        <div class="form-group">
                <label class="span3 control-label " for="bankAccountOwner-GIROPAY">Account owner</label>        <div class="col-sm-5">
                    <input type="text" name="bankAccountOwner" id="bankAccountOwner-GIROPAY" class="form-control" value="">        </div>
            </div>
            <div class="form-group">
                <label class="span3 control-label " for="bankAccount-GIROPAY">Bank account number</label>        <div class="col-sm-5">
                    <input type="text" name="bankAccount" id="bankAccount-GIROPAY" class="form-control" value="">        </div>
            </div>
            <div class="form-group">
                <label class="span3 control-label " for="bankNumber-GIROPAY">Bank number</label>        <div class="col-sm-5">
                    <input type="text" name="bankNumber" id="bankNumber-GIROPAY" class="form-control" value="">        </div>
            </div>

            <input type="hidden" name="orderIdent" id="invoice_id" value="{$invoice_id}">
            <input type="hidden" name="storageId" id="storageId" value="{$storage.storage_id}">
            <input type="hidden" name="paymentType" id="paymentType" value="GIROPAY">
            <div class="span5 control-label "></div>
            <div class="span5">
                <input type="submit" class="btn btn-primary pull-right submitData" value="Continue »" id="submitData-GIROPAY">
            </div>
        </form>
    </div>
{elseif $type=='VOUCHER'}
    <div class="">
        <form action="?cmd=wirecardcheckout_seamless&action=loadform&invoice_id={$invoice_id}&paynow=true&security_token={$security_token}&type=VOUCHER" method="post" name="paymentTypeForm-VOUCHER" class="form-horizontal" id="paymentTypeForm-VOUCHER">                        <div class="form-group">
                <label class="span5 control-label " for="voucherId-VOUCHER">My Voucher Id</label>        <div class="col-sm-5">
                    <input type="text" name="voucherId" id="voucherId-VOUCHER" class="form-control" value="">        </div>
            </div>
            <input type="hidden" name="orderIdent" id="invoice_id" value="{$invoice_id}">
            <input type="hidden" name="storageId" id="storageId" value="{$storage.storage_id}">
            <input type="hidden" name="paymentType" id="paymentType" value="VOUCHER">
            <div class="span5 control-label "></div>
            <div class="span5">
                <input type="submit" class="btn btn-primary pull-right submitData" value="Continue »" id="submitData-VOUCHER">
            </div>
        </form>
    </div>
{/if}
{literal}
<script type="text/javascript">
    $().ready(function() {
        var submitButton = $('#submitData-' + '{/literal}{$type}{literal}');
        submitButton.prop('disabled', true);
        $.getScript('{/literal}{$storage.javascript_url}{literal}').done(function(script, textStatus) {
            $('#submitData-' + '{/literal}{$type}{literal}').prop('disabled', false);
        }).fail(function() {
            var msg = $('<span>' +
                    'Communication Error with DataStorage' +
                    '</span>');
            $('#errors .alert').append(msg);
        });
    });
</script>{/literal}


{if $type=='CCARD'}
        <script type="text/javascript" src="includes/modules/Payment/wirecardcheckout_seamless/assets/ccard.js"></script>
{elseif $type=='SEPA-DD'}
        <script type="text/javascript" src="includes/modules/Payment/wirecardcheckout_seamless/assets/sepadd.js"></script>
{elseif $type=='PBX'}
        <script type="text/javascript" src="includes/modules/Payment/wirecardcheckout_seamless/assets/paybox.js"></script>
{elseif $type=='GIROPAY'}
        <script type="text/javascript" src="includes/modules/Payment/wirecardcheckout_seamless/assets/giropay.js"></script>
{elseif $type=='VOUCHER'}
    <script type="text/javascript" src="includes/modules/Payment/wirecardcheckout_seamless/assets/voucher.js"></script>
{/if}