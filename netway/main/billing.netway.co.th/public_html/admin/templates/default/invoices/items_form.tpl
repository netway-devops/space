{php}
$templatePath   = $this->get_template_vars('template_path');
include($templatePath . 'invoices/items_form.tpl.php');
{/php}

{if !$estimate}
{include file='_common/invoice_address_notification.tpl'}
{/if}
{if $estimate}
    {if $estimate.deal_id != ''}
        <span class="editbtn_flash"><b> Deal ID: </b>
            <a href="https://app.clickup.com/t/{$estimate.deal_id}" target="_blank">{if $estimate.deal_id}https://app.clickup.com/t/{$estimate.deal_id}{else}none{/if}</a>
        </span>
    {else}
        <span class="editbtn_flash">
            <b> Deal ID:</b>
            <span style="color:red;font-size:14px;">
            {$lang.deal_running}
            </span>
        </span>
        <div id="createDeal" style="background-color: #FFFFFF; padding: 5px;display:none;">
            <button onclick="createDealManualAfterEstimateCreate({$estimate.id}); return false;" class="btn btn-primary btn-sm newline-add" {if $block_invoice}disabled style="cursor: default;"{/if}>Create Deal</button>
        </div>
    {/if}
{/if}
<br />

<form action="" method="post" id="itemsform">
<input type="hidden" name="invoiceId" value="{$invoice.id}" />
<input type="hidden" name="isEstimate" value="{if $estimate}1{else}0{/if}" />
    {if $itemqueue && $invoice.status != 'Draft'}
        <div  id="invoice-queue"  class="p6 secondtd" style="text-align:center;margin-bottom:7px;padding:15px 0px;">
            This customer have some items in invoice queue, would you like to add them here?<br/>
            <a class="new_control greenbtn" href="#itemqueue" ><span>Add items from queue</span></a>
        </div>
    {/if}
    <table class="invoice-table text-center" width="100%" border="0" cellpadding="0" cellspacing="0">
        <thead >
            <tr>
                <th width="16" ></th>
                <th class="text-center">รายการ<br>(Description)</th>
                <th width="8%" class="aright">จำนวน(Quantity)</th>
                <th width="8%" class="aright">หน่วยนับ(Unit)</th>
                <th width="8%" class="acenter">ราคาต่อหน่วย(Unit Price)</th>
                <th width="8%" class="acenter" style="display:none">{$lang.qty}</th>
                <th width="7%" class="acenter">{$lang.taxpercent}</th>
                <th width="9%" class="acenter" style="display:none">{$lang.Price}</th>
                <th width="8%" class="acenter">ส่วนลด(Discount)</th>
                <th width="13%" class="aright">จำนวนเงิน(Amount)</th>
                <th width="1%" class="acenter">&nbsp;</th>
            </tr>
            <tr style="border:1px solid #CCCCCC">
                <th >&nbsp;</th>
                <th class="text-left"><div style=" font-size: 8px; color:#999999; font-weight:lighter;">สำหรับ item ที่มีระยะสัญญาให้ตรวจสอบว่ารูปแบบจะต้องเป็น (dd/mm/yyyy - dd/mm/yyyy)</div></th>
                <th class="aright"></th>
                <th class="acenter"></th>
                <th class="acenter"></th>
                <th class="acenter"style="display:none"></th>
                <th class="acenter" ></th>
                <th class="acenter" style="display:none"></th>
                <th class="acenter"></th>
                <th class="aright"></th>
                <th class="acenter"></th>
                
            </tr>
        </thead>
        <tbody id="main-invoice">
            {include file="invoices/items.tpl"}
        </tbody>
        {if !$invoice.readonly}
            <tbody id="new-item-invoice">
                <tr id="addliners">
                    <td class="summary blu acenter" style="padding-right:0px;padding-left:5px">

                        <a id="lineaction" class="setStatus menuitm {if $block_invoice}disabled{/if}">
                            <span class="gear_small" style="padding-left:16px;">
                                <span class="morbtn" style="padding-right:10px;">&nbsp;</span>
                            </span>
                        </a>
                        <ul id="lineaction_m" class="ddmenu">
                            <li>
                                <a href="NewLine" data-line="getproduct">New line from product</a>
                            </li>
                            {*<li><a href="NewLine" data-line="services">New line from client service</a></li>*}
                            {if $invoice.status!='Draft' && $invoice.status!='Recurring'}
                                <li>
                                    <a href="SplitItems">Split selected into new invoice</a>
                                </li>
                            {/if}
                            {adminwidget module="invoice" section="lineaction"}
                        </ul>

                    </td>
                    <td class="summary blu">
                        <div class="newline-basic clearfix">
                            <input name="item[n][description]" id="nline"
                                   class="foc invdescription" style="width:80%"
                                   placeholder="{$lang.newline}" {if $block_invoice}disabled{/if}/>
                        </div>
                        <div class="newline-adv newline-adv-body clearfix">

                        </div>
                    </td>
                    <td class="summary blu acenter">
                        <input type="text" type="text" name="item[n][qty]" id="nline_qty"
                               size="8" class="foc invqty" value="1.00"
                               style="text-align:center" {if $block_invoice}disabled{/if}/>
                    </td>
                    <td class="summary blu" ></td>
                    <td class="summary blu acenter">
                        <input type="text" name="item[n][amount]" id="nline_price"
                               class="foc invamount _search" size="16" value="0"
                               class="text-right" {if $block_invoice}disabled{/if}/>
                    </td>
                    <td class="summary blu acenter">
                        <div class="input-group input-combo">
                            <input type="hidden" name="item[n][taxed]" value="{if $invoice.taxexemp}0{else}1{/if}"
                                   id="nline_taxed" />
                            <input name="item[n][tax_rate]" {if $invoice.taxexempt || $block_invoice}disabled{/if}
                                   value="{if $invoice.taxexemp}{$lang.nontax}{else}{$invoice.taxrate}{/if}"
                                   type="text" size="3" id="nline_tax" class="text-right" data-toggle="dropdown" />
                            <span class="caret"></span>
                            <ul class="tax-rates dropdown-menu dropdown-menu-right" role="menu">
                                <li><a data-value="{$lang.nontax}" data-notax>{$lang.nontax}</a></li>
                                {foreach from=$tax_rates item=taxr}
                                    <li><a data-value="{$taxr}">{$taxr}%</a></li>
                                {/foreach}
                            </ul>
                        </div>
                    </td>
                    <td class="summary blu" style="display:none;"></td>
                    <td class="summary blu" style="display:none;"></td>
                    <td class="summary blu" colspan="2">
                        <div class="pull-right">
                            <button onclick="invoiceAddItemManual(); return false;" class="btn btn-primary btn-sm newline-add" {if $block_invoice}disabled style="cursor: default;"{/if}>{$lang.Add}</button>
                            <a class="btn btn-default btn-sm newline-adv newline-cancel">{$lang.Cancel}</a>
                        </div>
                    </td>
                    <td class="summary blu"></td>
                </tr>

            </tbody>
        {/if}

        {if $invoice.promotion_code}
        <tr>
            <td colspan="7">
                Promotion code: {$invoice.promotion_code}
            </td>
            <td style="display:none;">&nbsp;</td>
            <td>&nbsp;</td>
            <td style="display:none;">&nbsp;</td>
            <td>&nbsp;</td>
        </tr>
        {/if}
            
        {if isset($isProformaInvoice) && $isProformaInvoice}
        <tr>
            <td colspan="7" align="center">
                สำหรับ Pro forma invoice: 
                <a id="recalculateProforma" class="menuitm {if ! isset($admindata.access.editInvoices)}disabled{/if}" href="{if ! isset($admindata.access.editInvoices)}#{/if}{$admin_url}?cmd=invoicehandle&action=recalculateProforma&invoiceId={$invoice.id}" onclick="return confirm('ยืนยันการคำณวนราคา Unit pirce ใหม่');"><span class="disk"><strong style="color: #FF0000;">คำนวนยอดรวมใหม่</strong></span></a>
                 คลิกเพื่อเอายอดรวมก่อน vat ของ invoice ย่อยมาตั้งเป็น Unit price
            </td>
            <td style="display:none;">&nbsp;</td>
            <td >&nbsp;</td>
            <td style="display:none;">&nbsp;</td>
            <td>&nbsp;</td>
        </tr>
        {/if}
        {if isset($isInvoice) && $isInvoice}
        <tr> 
            <td colspan="9" align="center">
                <a id="recalculateInvoice" class="menuitm {if ! isset($admindata.access.editInvoices)}disabled{/if}" href="{if ! isset($admindata.access.editInvoices)}#{/if}" onclick="$('.discountPrice').trigger('change');return false;">
                    <span class="disk">
                        <strong style="color: #FF0000;">คำนวนยอดรวมใหม่</strong>
                    </span>
                </a>
                 คลิกเพื่อคำนวณยอดรวม
            </td>
            <td style="display:none;">&nbsp;</td>
            <td style="display:none;">&nbsp;</td>
            <td style="display:none;">&nbsp;</td>
            <td>&nbsp;</td>
        </tr>
        {/if}
        <tr>
            <td colspan="7" align="center">
                {if $invoice.metadata.client.isgovernment == 'Yes'}
                <b>กรณีราชการหักภาษี ณ ที่จ่าย</b> 1% คือ <b><span id="tax_wh_1">{$invoice.tax_wh_1}</span></b> บาท 
                รวมค่าบริการทีต้องชําระ คือ <b><span id="total_wh_1">{$invoice.total_wh_1}</span></b> บาท
                {elseif $invoice.is_tax_wh_15}
                <b>กรณีนิติบุคคลหักภาษี ณ ที่จ่าย</b> 1.5% คือ <b><span id="tax_wh_15">{$invoice.tax_wh_15}</span></b> บาท 
                รวมค่าบริการทีต้องชําระ คือ <b><span id="total_wh_15">{$invoice.total_wh_15}</span></b> บาท
                <a href="#" onclick="changeInvoiceWHTaxTo({$invoice.id},3);" class="btn btn-success btn-sm">เปลี่ยนเป็น 3%</a>
                {else}
                <b>กรณีนิติบุคคลหักภาษี ณ ที่จ่าย</b> 3% คือ <b><span id="tax_wh_3">{$invoice.tax_wh_3}</span></b> บาท 
                รวมค่าบริการทีต้องชําระ คือ <b><span id="total_wh_3">{$invoice.total_wh_3}</span></b> บาท
                <a href="#" onclick="changeInvoiceWHTaxTo({$invoice.id},1.5);" class="btn btn-success btn-sm">เปลี่ยนเป็น 1.5%</a>
                {/if}
            </td>
            <td style="display:none;">&nbsp;</td>
            <td >&nbsp;</td>
            <td style="display:none;">&nbsp;</td>
            <td>&nbsp;</td>
        </tr>

        <tr>
            <td valign="top" colspan="3" >
                <div class="invoice-notes">
                    <strong>Public Notes</strong>
                    <div>
                        <textarea class="notes_field invitem" style="width:90%;height:60px;"
                                  name="{if $estimate}estimate{else}invoice{/if}[notes]" id="inv_notes"
                                  {if $invoice.readonly}readonly{/if}>{$invoice.notes}</textarea>
                    </div>
                </div>
            </td>
            <td style="display:none;">&nbsp;</td>
            <td >&nbsp;</td>
            <td style="display:none;">&nbsp;</td>
            <td colspan="5" valign="top" >
                <div id="updatetotals">
                    <table width="100%" class="invoice-summary">
                        <tr>
                            <td class="summary aright"  colspan="2"><strong data-invoice-total>{$lang.Subtotal}</strong></td>
                            <td class="summary aright" colspan="2"><strong data-invoice-subtotal>{$invoice.subtotal|price:$currency}</strong></td>
                            <td class="summary" width="2%"></td>
                        </tr>
                        {if $cmd=='invoices' && $invoice.status!='Creditnote' && $invoice.status!='CreditnoteDraft' && $invoice.status!='Receiptpaid' && $invoice.status!='Receiptunpaid'}
                            <tr>
                                <td class="summary aright"  colspan="2"><strong>{$lang.Credit}</strong></td>
                                <td class="summary aright" colspan="2"><strong>{$invoice.credit|price:$currency}</strong></td>
                                <td class="summary"></td>
                            </tr>
                        {/if}
                        {foreach from=$invoice.taxes item=tax}
                            {if $tax.tax != 0}
                            <tr>
                                <td class="summary aright"  colspan="2"><strong>{$lang.Tax} ({$tax.name})</strong></td>
                                <td class="summary aright" colspan="2"><strong>{$tax.tax|price:$currency}</strong></td>
                                <td class="summary"></td>
                            </tr>
                            {/if}
                        {/foreach}
                        <tr>
                            <td class="summary aright" colspan="2" ><strong class="bigger">{$lang.Total}</strong> {if ($invoice.taxrate!=0 || $invoice.taxrate2!=0) && $invoice.taxexempt}<a href="#" class="vtip_description" title="Tax exemption is enabled for this invoice"></a>{/if}</td>
                            <td class="summary aright" colspan="2" ><strong class="bigger">{$invoice.grandtotal|price:$currency}</strong></td>
                            <td class="summary"></td>
                        </tr>
                    </table>
                    <input type="hidden" class="invoice-update-field"
                           id="invoice-total" value="{$invoice.grandtotal}"
                           data-formated="{$invoice.grandtotal|price:$currency}">
                    <input type="hidden" class="invoice-update-field"
                           id="invoice-balance" value="{$balance}"
                           data-formated="{$balance|price:$currency}">
                    <input type="hidden" class="invoice-update-field"
                           id="invoice-appcredit" value="{$credit_available}"
                           data-formated="{$credit_available|price:$currency}">
                </div>
            </td>
        </tr>
    </table>
    {securitytoken}
</form>


<script language="JavaScript">
{literal}

$(document).ready(function(){
    $(".input-combo").eq(0).trigger('click');
});

{/literal}
</script>


<script language="JavaScript">
{literal}

    var isAddedInvoiceItem = 0;
    var longPreLoading     = 0;
    var isEstimate         = {/literal}{if $estimate}1{else}0{/if}{literal};
    $(document).ready(function(){

        /*
        $('.invoiceQty, .invoiceAmount').blur(function() {
            $('#updatetotals').addLoader();
            var currentItemId           = parseInt($(this).prop('alt'));
            if (currentItemId) {
                var newDiscountPrice    = (parseFloat($('#unitPrice'+currentItemId).val()) - parseFloat($('#invoiceAmount'+currentItemId).val())) * parseInt($('#invoiceQty'+currentItemId).val());
                $('#discountPrice'+currentItemId).val(newDiscountPrice.toFixed(2));
            }
        });
        */
        $('.discountPrice').change(function() {
            $('#updatetotals').addLoader();
            var currentItemId           = parseInt($(this).prop('alt'));
            var discountPrice           = parseFloat($(this).val());
            
            $.post('?cmd=invoicehandle&action=changeInvoiceItemDiscount', {
                invoiceId       : {/literal}{$invoice.id}{literal},
                invoiceItemId   : currentItemId,
                discountPrice   : discountPrice,
                isEstimate : {/literal}{if $estimate}1{else}0{/if}{literal}
            }, function (data) {
                parse_response_json(data);
                $('#preloader').remove();
              if (isEstimate ){
                     document.location = '?cmd=estimates&action=edit&id={/literal}{$invoice.id}{literal}&reload=1&isEstimate=1';      
              }
              else{
                document.location = '?cmd=invoices&action=edit&id={/literal}{$invoice.id}{literal}&reload=1&isEstimate=0';               
              }
                   
            });
            

        });
        
        $('.unitPrice').change(function() {
            $('#updatetotals').addLoader();
            var currentItemId           = parseInt($(this).prop('alt'));
            var unitPrice               = parseFloat($(this).val());
            $.post('?cmd=invoicehandle&action=changeInvoiceItemUnitPrice', {
                invoiceId       : {/literal}{$invoice.id}{literal},
                invoiceItemId   : currentItemId,
                unitPrice   : unitPrice,
                isEstimate : {/literal}{if $estimate}1{else}0{/if}{literal}
            }, function (data) {
                $('#preloader').remove();
                if (isEstimate ){
                    document.location = '?cmd=estimates&action=edit&id={/literal}{$invoice.id}{literal}&reload=1&isEstimate=1';      
                }
                else{
                
                document.location = '?cmd=invoices&action=edit&id={/literal}{$invoice.id}{literal}&reload=1&isEstimate=0';
                }
            });
        });
        
         $('.quantityText').change(function() {
            $('#updatetotals').addLoader();
            var currentItemId           = parseInt($(this).prop('alt'));
            var quantityText            = $('#invoiceQuantityText'+currentItemId).val();
            console.log(quantityText+currentItemId);

           $.post('?cmd=invoicehandle&action=changeQuantityUnit', {
                invoiceId       : {/literal}{$invoice.id}{literal},
                invoiceItemId   : currentItemId,
                quantityText    : quantityText,
                isEstimate : {/literal}{if $estimate}1{else}0{/if}{literal}
            }, function (data) {
                $('#preloader').remove();
                if (isEstimate ){
                    document.location = '?cmd=estimates&action=edit&id={/literal}{$invoice.id}{literal}&reload=1&isEstimate=1';      
                }
                else{
                
                document.location = '?cmd=invoices&action=edit&id={/literal}{$invoice.id}{literal}&reload=1&isEstimate=0';
                }
            });
        });

        $('.quantityVal').change(function() {
            $('#updatetotals').addLoader();
            var currentItemId           = parseInt($(this).prop('alt'));
            var quantityVal             = parseInt($('#invoiceQuantity'+currentItemId).val());
            $.post('?cmd=invoicehandle&action=changeQuantity', {
                invoiceId       : {/literal}{$invoice.id}{literal},
                invoiceItemId   : currentItemId,
                quantityValue   : quantityVal,
                isEstimate : {/literal}{if $estimate}1{else}0{/if}{literal}
            }, function (data) {
                $('#preloader').remove();
                if (isEstimate ){
                    document.location = '?cmd=estimates&action=edit&id={/literal}{$invoice.id}{literal}&reload=1&isEstimate=1';      
                }
                else{
                
                document.location = '?cmd=invoices&action=edit&id={/literal}{$invoice.id}{literal}&reload=1&isEstimate=0';
                }
            });
        });
        
        
        /* --- ตรวจสอบการเพิ่ม item --- */
       isAddedInvoiceItem       = $('#main-invoice tr').length;
       
    });
    
    function editInvoiceSave ()
    {
        $('#invoice-actions a[href="#save"]').trigger('click');
        
    }

    function invoiceAddItemManual ()
    {
        $.post('?cmd=invoicehandle&action=addItemManual', $('#itemsform').serialize(), function (data) {
            $('#preloader').remove();
            document.location = '?cmd=invoices&action=edit&id={/literal}{$invoice.id}{literal}&reload=1';
        });
    }

    /*
    function invoiceIsAdded ()
    {
       var isAddedInvoiceItem_int   = setInterval(function(){
           if ($('#main-invoice tr').length != isAddedInvoiceItem) {
               window.location.reload(false);
           }
       }, 2500);
    }
    */

    function changeInvoiceWHTaxTo (invoiceId, rate)
    {
        $.post('?cmd=invoicehandle&action=changeTaxWithholding', {
            invoiceId : invoiceId,
            rate : rate,
            isEstimate : {/literal}{if $estimate}1{else}0{/if}{literal}
        }, function (data) {
            window.location.reload(false);
        });

        return false;
    }
   function createDealManualAfterInvoiceCreate (invoiceId)
    {
         $('#createDeal').addLoader();
        $.post('?cmd=invoicehandle&action=createDealManualAfterInvoiceCreate', {
            invoiceId : invoiceId,
            method    : 'POST'
        }, function (data) {
            setInterval(function(){
                if (data) {
                    $('#preloader').remove();
                    console.log(data.data)
                    
                    window.location.reload(false);
                }
            }, 3000);

      
        });

        return false;
    
    } 
     function createDealManualAfterEstimateCreate (estimateId)
    {
         $('#createDeal').addLoader();
        $.post('?cmd=invoicehandle&action=createDealManualAfterEstimateCreate', {
            estimateId : estimateId,
            method     : 'POST'
        }, function (data) {
            setInterval(function(){
                if (data) {
                    $('#preloader').remove();
                    console.log(data.data)
                    window.location.reload(false);
                }
            }, 3000);

      
        });
    
        return false;
    } 
{/literal}
</script>
