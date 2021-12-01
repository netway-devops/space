{literal}
    <script type="text/javascript">

        function new_gateway(elem) {
            if ($(elem).val() == 'new') {
                window.location = "?cmd=managemodules&action=payment";
                $(elem).val(($("select[name='" + $(elem).attr('name') + "'] option:first").val()));
            }
        }

    </script>
{/literal}

{include file='invoices/invoice_actions.tpl'}

<div class="modal-content" id="add-credit" hidden bootbox data-title="{$lang.clientcreditavailable}">
    <form action="?cmd=invoices&action=edit&id={$invoice.id}&list={$currentlist}" method="post"  onsubmit="$('#bodycont').addLoader();">
        <div class="form-group">
            <p>Provided amount will be automatically deducted from client credit balance</p>
            <label>{$lang.clientcreditavailable}</label>
            <input type="text" name="apply_credit" class="invoice-appcredit form-control" 
                   size="7" value="{$credit_available}" />
        </div>
        {securitytoken}
    </form>
</div>


{if $pdfstored}
    <div  style="padding:5px;" class="lighterblue fs11">
        Note: PDF for this invoice is already stored locally, changes made here 
        wont take effect on PDF, unless its deleted first. 
        <a href="?cmd=invoices&action=deletepdf&id={$invoice.id}&security_token={$security_token}" class="editbtn">Delete PDF</a>
    </div>
{/if}


{if count($currencies)>1}
    <div id="change-currency" hidden bootbox data-title="Change currency">
        <form action="?cmd=invoices&action=edit&id={$invoice.id}&list={$currentlist}" method="post"  onsubmit="$('#bodycont').addLoader();">
            <div class="form-group">
                <label>{$lang.newcurrency}</label>
                <select name="new_currency_id" id="new_currency_id" class="form-control">
                    {foreach from=$currencies item=curr}
                        {if $curr.id!=$invoice.currency_id}
                            <option value="{$curr.id}">{if $curr.code}{$curr.code}{else}{$curr.iso}{/if}</option>
                        {/if}	
                    {/foreach}
                </select>
            </div>
            <div class="checkbox">
                <label>
                    <input type="checkbox" name="exchange" value="1" id="calcex"/>
                    {$lang.calcexchange}
                </label>
            </div>
            <div class="form-group" hidden id="exrates">
                <label>{$lang.excurrency}</label>
                {foreach from=$currencies item=curr}
                    {if $curr.id!=$invoice.currency_id}
                        <input value="{$curr.rate}" name="cur_rate[{$curr.id}]" 
                               style="display:none" class="form-control" size="3"/>
                    {/if}	
                {/foreach}
            </div>

            {securitytoken}
        </form>
    </div>

{/if}
<div id="add-payment" hidden bootbox data-title="Add new Payment">

{literal}
<script type="text/javascript">
$(document).ready( function() {
    
    forbidAccessBlock();
    
    {/literal}{if ! isset($admindata.access.editInvoices)}$('.livemode').removeClass('livemode');{/if}{literal}
    
    $('#payByCheque').hide();
    $('#payByChequeSelect').hide();
    $('#payFeeOccur').hide();
    
    
    $('#formSubmittedAddPayment').submit( function() {
        return formSubmittedAddPayment();
    });
    
    $('#isCheque').click( function() {
        if ($(this).is(':checked')) {
            $('#payByChequeSelect').show();
        } else {
            $('#payByChequeSelect').hide();
        }
    });
    
    $('#newpaymentPaymentmodule').change( function () {
        var matches    = $('#newpaymentPaymentmodule option:selected').text().match(/BankTransfer/i);
        if (matches.length) {
            $('#payByCheque').show();
        }
    });
    
    $('#payFee').bind('blur change', function() {
        var feeVal    = parseFloat($(this).val());
        if (feeVal > 0) {
            $('#payFeeOccur').show();
            $('#newpaymentFeeType').prop('selectedIndex', 3);
        } else {
            $('#payFeeOccur').hide();
            $('#newpaymentFeeType').prop('selectedIndex', 0);
        }
    });
    
    /* --- คำนวนยอดเงินจริง --- */
    $('#newpaymentAmount').bind('blur change', function() { calculateRealAmount(); });
    $('#newpaymentFeeType').bind('blur change', function() { calculateRealAmount(); });
    $('#payFee').bind('blur change', function() { calculateRealAmount(); });
    
});

function formSubmittedAddPayment () {
    var paymentMethodText     = $('#newpaymentPaymentmodule option:selected').text();
    if ( paymentMethodText != '' && paymentMethodText == 'BankTransfer') {
        alert('สำหรับ Payment method: BankTransfer กรุณาระบุ BankTransfer อะไรด้วย ');
        return false;
    }

    return true;
}

function calculateRealAmount()
{
    var amountVal  = parseFloat($('#newpaymentAmount').val());
    var feeVal     = parseFloat($('#payFee').val());
    var singVal    = '-';
    var typeVal    = $('#newpaymentFeeType').val();
    if (typeVal == '') {
        feeVal     = 0;
    } else if (typeVal.match(/^B01/)) {
        singVal    = '+';
    }
    eval('var realVal    = '+amountVal+' '+singVal+' '+feeVal+';');
    $('#newpaymentReal').html(realVal.toFixed(2));
}
</script>
{/literal}

    <form id="formSubmitAddPayment" action="?cmd=invoices&action=edit&id={$invoice.id}&addpayment=1&list={$currentlist}" method="post" 
        onsubmit="{literal}if (formSubmittedAddPayment()){$('#bodycont').addLoader();}else{return false;}{/literal}">
        <div class="row">
            <div class="col-md-12">
                Import or create new transaction for invoice.
                This method does not charge selected payment gateway.
                <hr/>
            </div>
            <div class="col-sm-6">
                <div class="form-group">
                    <label>{$lang.Date}</label>
                    <div class="datepicker">
                        <input name="newpayment[date]" value="{''|dateformat:$date_format}"  
                               readonly="readonly"
                               class="form-control haspicker" type="text"/>
                    </div>
                </div>
                <div class="form-group">
                    <label>{$lang.paymethod}</label>
                    <select name="newpayment[paymentmodule]" id="newpaymentPaymentmodule" onclick="new_gateway(this)" class="form-control">
                        {foreach from=$gateways key=gatewayid item=paymethod}
                            <option value="{$gatewayid}" {if $invoice.payment_module == $gatewayid} selected="selected"{/if} >{$paymethod}</option>
                        {/foreach}
                        <option value="new" style="font-weight: bold">{$lang.newgateway}</option>
                    </select>
                </div>
                
                <div class="form-group">
                    <table>
                        <tr id="payByCheque">
                            <td>&nbsp;</td>
                            <td>
                                <input type="checkbox" name="newpayment[is_cheque]" id="isCheque" value="is_cheque" /> จ่ายด้วยเช็ค
                                <div id="payByChequeSelect" style="background-color:#E0ECFF; border:1px solid #E5E5E5;">
                                <label style="display:block;"><span style="display:block; width:120px; float:left;">เช็คของธนาคาร: </span>
                                <select name="newpayment[cheque_bank]" id="chequeBank">
                                    <option value="">--- กรุณาเลือก ---</option>
                                    <option value="ธนาคาร กรุงเทพ">ธนาคาร กรุงเทพ</option>
                                    <option value="ธนาคาร ไทยพาณิชย์">ธนาคาร ไทยพาณิชย์</option>
                                    <option value="ธนาคาร กสิกรไทย">ธนาคาร กสิกรไทย</option>
                                    <option value="ธนาคาร ทหารไทย">ธนาคาร ทหารไทย</option>
                                    <option value="ธนาคาร กรุงไทย">ธนาคาร กรุงไทย</option>
                                    <option value="ธนาคาร กรุงศรีอยุธยา">ธนาคาร กรุงศรีอยุธยา</option>
                                </select>
                                </label>
                                
                                <label style="display:block;"><span style="display:block; width:120px; float:left;">หมายเลขเช็ค: </span>
                                <input type="text" name="newpayment[cheque_no]" id="chequeNo" value="" />
                                </label>
                                
                                </div>
                            </td>
                        </tr>
                    </table>
                </div>
                
                <div class="form-group">
                    <label>{$lang.Transactionid}</label>
                    <input name="newpayment[transnumber]" class="form-control" type="text"/>
                </div>
            </div>
            <div class="col-sm-6">
                <div class="form-group">
                    <label>{$lang.Amount}</label>
                    <input size="6" name="newpayment[amount]" id="newpaymentAmount" value="{$balance}" class="invoice-balance form-control" type="text"  />
                </div>
                <div class="form-group">
                    <label>{$lang.transactionfees}</label>
                    <input size="6" name="newpayment[fee]" id="payFee" value="0.00" class="form-control" type="text" />
                </div>
                
                <div class="form-group">
                    <table>
                        <tr>
                            <td>&nbsp;</td>
                            <td>
                                <span id="payFeeOccur" style="background-color:#E0ECFF; border:1px solid #E5E5E5;">
                                <select id="newpaymentFeeType" name="newpayment[feeType]">
                                    <option value="">--- โปรดระบุประเภทค่าธรรมเนียม ---</option>
                                    <option value="C01:ค่าธรรมเนียมบัตรเครดิต"> C01:ค่าธรรมเนียมบัตรเครดิต </option>
                                    <option value="V01:หักภาษี ณ ที่จ่าย 1%"> V01:หักภาษี ณ ที่จ่าย 1% </option>
                                    <option value="V03:หักภาษี ณ ที่จ่าย 3%"> V03:หักภาษี ณ ที่จ่าย 3% </option>
                                    <option value="B01:ยอดลูกค้าปัดเศษขึ้น"> B01:ยอดลูกค้าปัดเศษขึ้น </option>
                                    <option value="B02:ยอดลูกค้าปัดเศษลง"> B02:ยอดลูกค้าปัดเศษลง </option>
                                </select>
                                </span>
                            </td>
                        </tr>
                        <tr>
                            <td align="right"><strong>ยอดเงินเป็นจริง:</strong></td>
                            <td><strong><span id="newpaymentReal">{$balance}</span></strong></td>
                        </tr>
                    </table>
                </div>
                
                <div class="checkbox">
                    <label>
                        <input type="checkbox" value="1" name="newpayment[send_email]" />
                        {$lang.sendemail}
                    </label>
                </div>
            </div>
        </div>
        {securitytoken}
    </form>
</div>
<div id="refunds" class="lighterblue"></div>
{include file='invoices/ajax.creditnoteinfo.tpl'}

<div id="ticketbody">
    {if $action == 'viewlog'}
        <h1 class="invoice-history pull-right">Version from {$changedate|dateformat:$date_format}</h1>
    {/if}
    <table border="0" cellpadding="0" cellspacing="0" class="left">
        <tr>
            <td>
                <h1>
                    {if $proforma && !$invoice.paid_id && $invoice.status!='Draft' && $invoice.status!='Recurring' && $invoice.status != 'Creditnote'}
                        {$lang.proforma} #
                    {elseif $invoice.status=='Draft'}
                        {$lang.createinvoice}
                    {elseif $invoice.status=='Recurring'}
                        {$lang.recinvoice} #
                    {elseif $invoice.status=='Creditnote'}
                        {$lang.creditnote} #
                    {elseif $invoice.status=='Receiptpaid' || $invoice.status=='Receiptunpaid'}
                        {$lang.creditreceipt} #
                    {else}
                        {$lang.invoicehash}
                    {/if}
                </h1>
            </td>
            <td>
                {if $proforma && $invoice.paid_id!=''}
                    <div class="editor-line" id="paid_invoice_line">
                        <h1 id="invoice_number" class="line_descr" style="display:inline">{$invoice.paid_id}</h1>
                    </div>
                {elseif $invoice.status=='Recurring'}
                    <h1>{$invoice.recurring_id}</h1>
                {else}
                    <h1>{$invoice|@invoice}</h1>
                {/if}
            </td>
            {if $invoice.status!='Recurring' && $invoice.status!='Creditnote'}
                <td>
                    <h1>
                        <span class="{$invoice.status}" id="invoice_status" data-status="{$invoice.status}">
                            {if $lang[$invoice.status]}
                                {$lang[$invoice.status]}
                            {else}{$invoice.status}
                            {/if}
                        </span>
                    </h1>
                </td>
            {/if}
            {if $invoice.status!='Draft' && $invoice.status!='Recurring'}
            <td style=" padding-left:50px;">
                 {include file='ajax.taxnumber.tpl' view='invoicenumber'}
            </td>
            {/if}
            {if $invoice.locked}
                <td>
                    <a href="?cmd=invoices&action=menubutton&make=unlock&id={$invoice.id}"
                       title="This invoice is currently hidden in client area, click to unlock" class="invoiceUnlock padlock" style="margin: -4px 0 0 5px;"></a>
                </td>
            {/if}
        </tr>
    </table>
    <div class="print-status print-status-notprinted label-brand label label-danger pull-right" style="{if !($invoice.flags & 4)}display: none;{/if} font-size: 14px; margin: 5px;">{$lang.NotPrinted}</div>
    <div class="print-status print-status-printed label-brand label label-success pull-right" style="{if !($invoice.flags & 8)}display: none;{/if} font-size: 14px; margin: 5px;">{$lang.Printed}</div>
    <div class="clear"></div>

    <input type="hidden" id="invoice_id" name="invoice_id" value="{$invoice.id}" />
    <input type="hidden" id="currency_id" name="inv_currency_id" value="{$invoice.currency_id}" />
    <input type="hidden" id="old_client_id" name="old_client_id" value="{$invoice.client_id}" />

    <div id="client_nav">
        <!--navigation-->
        <a class="nav_el nav_sel left" href="#">{$lang.invoicedetails}</a>
        <a class="nav_el left" href="?cmd=invoices&action=log&id={$invoice.id}" onclick="return false">
            Invoice Log
        </a>
        {if $invoice.client_id} 
            {include file="_common/quicklists.tpl" _client=$invoice.client_id}
        {/if}
        <div class="clear"></div>
    </div>

    <div class="ticketmsg ticketmain" id="client_tab">
        <div class="slide" style="display:block" id="detcont">
            {include file="invoices/invoice_details.tpl" _placeholder=true}
        </div>
        <div id="history-tab" class="slide">Loading</div>
        {include file="_common/quicklists.tpl" _placeholder=true}
    </div>

    {include file='invoices/items_form.tpl'}
    {if !$invoice.readonly}
        <div id="invoice-actions" class="{$invoice.status}">

            <a href="#save" class="btn btn-success btn-sm" data-confirm="yes">{$lang.savechanges}</a>
            <a href="?cmd=invoices&action=edit&id={$invoice.id}" class="btn btn-default btn-sm" data-confirm="no">{$lang.Cancel}</a>

            {if $invoice.status != 'Draft'}
                <span class="invoice-edit alert alert-danger" style="padding: 0px;" >Unsaved changes will be lost if you leave this page</span>
           
            {/if}

        </div>
    {/if}
    {if $action == 'viewlog'}
        <h1 class="invoice-history">Version from {$changedate|dateformat:$date_format}</h1>
    {/if}
    {include file='invoices/related_transactions.tpl'}
    {include file='_common/noteseditor.tpl'}
</div>

{include file='invoices/invoice_actions.tpl' type='bottom'}

{if $ajax}
    <script type="text/javascript">
        bindEvents();
        bindInvoiceEvents();
    </script>
{/if}

