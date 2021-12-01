<table cellspacing="0" cellpadding="3" border="0" width="100%" class="table whitetable" style="">
<tbody>
<tr>
    <th>เครดิต (วัน)</th>
    <th>สถานที่วางบิล</th>
    <th>เอกสารประกอบการวางบิล</th>
    <th>ผู้ติดต่อและเบอร์ในการวางบิล</th>
    <th>สถานที่รับเช็ค</th>
    <th>เอกสารประกอบการรับเช็ค</th>
    <th>ผู้ติดต่อและเบอร์ในการรับเช็ค</th>
    <th>หมายเหตุ</th>
    <th>&nbsp;</th>
</tr>
<tr>
    <td>{$aBillingContact.creditterm}</td>
    <td>{$aBillingContact.billinglocation}</td>
    <td>{$aBillingContact.billingdocument}</td>
    <td>{$aBillingContact.billingcontact}</td>
    <td>{$aBillingContact.chequelocation}</td>
    <td>{$aBillingContact.chequedocument}</td>
    <td>{$aBillingContact.chequecontact}</td>
    <td>{$aBillingContact.billingnote}</td>
    <td>
    <a href="javascript:void(0);" onclick="$('.billigChequeForm').toggleClass('hidden');" {if ! isset($admindata.access.editInvoices)} disabled="disabled" {/if} >edit</a></td>
</tr>
<tr class="billigChequeForm hidden">
    <td>
        <select name="billigCheque[creditterm]" class="billigCheque">
            {foreach from=$aCreditTerm item="creditTerm"}
            <option value="{$creditTerm}" {if $aBillingContact.creditterm == $creditTerm} selected="selected" {/if} >{$creditTerm}</option>
            {/foreach}
        </select>
    </td>
    <td>
        <textarea name="billigCheque[billinglocation]" class="billigCheque" style="width: 100%" cols="2">{$aBillingContact.billinglocation}</textarea>
    </td>
    <td>
        <textarea name="billigCheque[billingdocument]" class="billigCheque" style="width: 100%" cols="2">{$aBillingContact.billingdocument}</textarea>
    </td>
    <td>
        <textarea name="billigCheque[billingcontact]" class="billigCheque" style="width: 100%" cols="2">{$aBillingContact.billingcontact}</textarea>
    </td>
    <td>
        <textarea name="billigCheque[chequelocation]" class="billigCheque" style="width: 100%" cols="2">{$aBillingContact.chequelocation}</textarea>
    </td>
    <td>
        <textarea name="billigCheque[chequedocument]" class="billigCheque" style="width: 100%" cols="2">{$aBillingContact.chequedocument}</textarea>
    </td>
    <td>
        <textarea name="billigCheque[chequecontact]" class="billigCheque" style="width: 100%" cols="2">{$aBillingContact.chequecontact}</textarea>
    </td>
    <td>
        <textarea name="billigCheque[billingnote]" class="billigCheque" style="width: 100%" cols="2">{$aBillingContact.billingnote}</textarea>
    </td>
    <td><a href="javascript:void(0);" id="billigChequeFormSave" class="btn btn-success btn-sm">save</a></td>
</tr>
<tr class="billigChequeForm hidden">
    <td align="center" colspan="9">
        <span style="color:red;"> {$lang.billingChequeNotification}<br /><br /></span>
    </td>
</tr>
</tbody>
</table>


{if $invalidItemUpgradeId}
<div class="imp_msg">
    <h3><u>พบข้อผิดพลาด</u> การ upgrade service จะต้องมี หรือทำ order upgrade เสมอ</h3>
    มีการ Upgrade service โดยไม่มีการทำ order จะทำให้ระบบ gen invoice ใหม่ขึ้นมาซ้ำอยู่เรื่อยๆ 
    <select onchange="{literal} if (confirm('ยืนยันการเชื่อมต่อ invoice item นี้กับ account ที่เลือก')) { document.location=$(this).val(); } {/literal}">
        <option value="">เลือก account ที่ต้องการจับคู่กับ invoice upgrade นี้เพื่อให้ระบบแก้ปัญหาให้</option>
        {foreach from=$aUpgrades item=aUpgrade}
        <option value="?cmd=invoicehandle&action=fixupgrade&invoiceId={$invoice.id}&itemId={$invalidItemUpgradeId}&accountId={$aUpgrade.id}"> #{$aUpgrade.id} {$aUpgrade.domain} {$aUpgrade.product} </option>
        {/foreach}
    </select>
    
    <div style="color:gray;">
    #{$aInvalidItem.id} {$aInvalidItem.description}<br />
    </div>
    
</div>
{/if}

{if !$estimate}
<div>
    <div class="ticketmsg ticketmain" style="width: 250px; display: block; float: left;">
        {foreach from=$aStaffOwners name=staffIndex item=aStaffOwner}
        <div>
            <div><b>Invocie {$aStaffOwner.id} <br />Type: {$aStaffOwner.type}</b></div>
            <div style="background-color: #FFFFFF; padding: 5px;">
                Staff owner: <strong>{$aStaffOwner.owner}</strong>
                {if $admindata.email == 'siripen@netway.co.th' || $admindata.email == 'prasit@netway.co.th' || $admindata.email || ! $admindata.email}
                <br />
                <a href="javascript:void(0);" onclick="$('#assignStaff{$smarty.foreach.staffIndex.index}').show();">change</a>
                {/if}
            </div>
            {if $admindata.email == 'siripen@netway.co.th' || $admindata.email == 'prasit@netway.co.th' || $admindata.email || ! $admindata.email}
            <div id="assignStaff{$smarty.foreach.staffIndex.index}" style="background-color: #FFFFFF; padding: 5px; display:none;">
                <select id="assignStaffId{$smarty.foreach.staffIndex.index}" name="staff_owner_id" data-chosenedge >
                    <option value="0" >{$lang.none}</option>
                    {foreach from=$aStaffs2 item=aStaff}
                        <option value="{$aStaff.id}" {if $invoice.staff_owner_id==$aStaff.id}selected="selected"{/if} >{$aStaff.firstname} {$aStaff.lastname}</option>
                    {/foreach}
                </select>
                <br />
                <a onclick="{literal}$.get('?cmd=invoicehandle&action=changeStaffOwner&invoiceId={/literal}{$aStaffOwner.id}{literal}&staffOwnerId='+ $('#assignStaffId{/literal}{$smarty.foreach.staffIndex.index}{literal}').val(), function (data) { location.reload(); });{/literal}" class="btn btn-success btn-sm" name="change_staff_owner" href="javascript:void(0);"> save </a>
            </div>
            {/if}
        </div>
        {/foreach}
         {if $invoice.deal_id == ''}
        <div id="createDeal" style="background-color: #FFFFFF; padding: 5px;">
            <b>Deal ID: </b>
            <span style="color:red;">
                {$lang.deal_running}
            </span>
            <button onclick="createDealManualAfterInvoiceCreate({$invoice.id}); return false;" class="btn btn-primary btn-sm newline-add" {if $block_invoice}disabled style="cursor: default;"{/if} style="display: none;">Create Deal</button>
        </div>
        {elseif $invoice.deal_id != 'skip' && $invoice.deal_id != ''}
        <span class="editbtn_flash"><b>Deal ID:</b> <br>
            <a href="https://app.clickup.com/t/{$invoice.deal_id}" target="_blank">{if $invoice.deal_id}https://app.clickup.com/t/{$invoice.deal_id}{else}none{/if}</a>
        </span>
        {else}
        <span class="editbtn_flash"> Deal ID <br>
           <button onclick="createDealManualAfterInvoiceCreate({$invoice.id}); return false;" class="btn btn-primary btn-sm newline-add" {if $block_invoice}disabled style="cursor: default;"{/if}>Create Deal</button>
        </span>
        {/if}
        <br />
        
    </div>
    <div class="ticketmsg ticketmain" style="width: 350px; display: block; float: left; margin-left: 10px;">   
        <div><b>Billing Address:</b></div>
        <div style="background-color: #FFFFFF; padding: 5px;">
            {$billingAddress|nl2br}
            <br />
            <div align="right" style="{if !isset($admindata.access.editInvoices)}display: none;{/if}"><a href="?cmd=addresshandle&action=listInvoice&type=billing&invoiceId={$invoice.id}" class="manageContactAddress">แก้ไข</a></div>
        </div>
        <div>
            <span style="color:red;">การแก้ไขข้อมูลที่อยู่ตรงนี้มีผลเฉพาะ Invoice นี้เท่านั้น ถ้าต้องการให้การออกบิลครั้งต่อไปใช้ที่อยู่นี้ด้วย จะต้องไปแก้ไขที่ Service นั้นๆ</span>
        </div>
        
        <div><b>Mailing Address:</b></div>
        <div style="background-color: #FFFFFF; padding: 5px;">
            {$mailingAddress|nl2br}
        </div>
    
    </div>
    
    <div class="ticketmsg ticketmain" style="width: 300px; display: block; float: left; margin-left: 10px;">
        {if $isWithHoldingTax}
        <div>
            {if isset($admindata.access.editInvoices)}
            <input type="checkbox" name="isWhTaxReceived" id="isWhTaxReceived" value="1" {if $invoice.is_wh_tax_receipt} checked="checked" disabled="disabled" {/if}  />
            {/if}
            <b>ได้รับใบกำกับภาษีหัก ณ ที่จ่ายจากลูกค้าแล้ว</b>
        </div>
        {/if}
        <div>
            {if isset($admindata.access.editInvoices)}
            <input type="checkbox" name="invoiceSend" id="invoiceSend" value="1" {if $aInvoiceMail.id} checked="checked" disabled="disabled" {/if}  />
            {/if}
            <b>ดำเนินการจัดส่งเอกสารไปยังลูกค้า</b>
        </div>
        <div style="background-color: #FFFFFF; padding: 5px; {if ! $aInvoiceMail.id} display: none; {/if}">
            <span><label style="float:left;">วันที่: </label> <input id="invoiceSendDate" name="invoiceSendDate" type="text" value="{$aInvoiceMail.delivery|dateformat:$date_format}" {if ! isset($admindata.access.editInvoices)} disabled="disabled" {/if} class="haspicker dp-applied" style="border:1px dotted gray; color: red; padding-left:10px; width:80px;" readonly="readonly" /></span><br />
            <br />
            ประเภทจดหมาย:
            <input type="radio" name="invoiceSendBy" value="Stamp" {if $aInvoiceMail.sendby == 'Stamp'} checked="checked" {/if} {if ! isset($admindata.access.editInvoices)} disabled="disabled" {/if}  /> แสตมป์ 
            <input type="radio" name="invoiceSendBy" value="Register" {if $aInvoiceMail.sendby == 'Register'} checked="checked" {/if} {if ! isset($admindata.access.editInvoices)} disabled="disabled" {/if}  /> ลงทะเบียน 
            <input type="radio" name="invoiceSendBy" value="Ems" {if $aInvoiceMail.sendby == 'Ems'} checked="checked" {/if} {if ! isset($admindata.access.editInvoices)} disabled="disabled" {/if}  /> Ems 
            <br />
            Note:
            <textarea name="invoiceSendNotes" id="invoiceSendNotes" style="width: 100%" cols="2" {if ! isset($admindata.access.editInvoices)} disabled="disabled" {/if}  >{$aInvoiceMail.notes}</textarea>
        </div>
    </div>
    
    <div class="ticketmsg ticketmain" style="width: 200px; display: block; float: left; margin-left: 10px;">
        <div>
            <div><b>ตั้งหัว Invoice</b></div>
            <div style="background-color: #FFFFFF; padding: 5px;">
                {if isset($admindata.access.editInvoices)}
                <input type="checkbox" name="isQuotation" id="isQuotation" value="1" {if $invoice.is_quotation == 1} checked="checked" {/if}  />
                ตั้งหัว Invoice เป็นใบเสนอราคา <br />
                <input type="checkbox" name="isBillissue" id="isBillissue" value="2" {if $invoice.is_quotation == 2} checked="checked" {/if}  />
                ตั้งหัว Invoice เป็นใบวางบิล <br />
                <input type="checkbox" name="isDeliverybill" id="isDeliverybill" value="3" {if $invoice.is_quotation == 3} checked="checked" {/if}  />
                ตั้งหัว Invoice เป็นใบส่งของ <br />
                {/if}
                เลขที่ PO:<input type="text" name="po_number" id="poNumber" value="{$invoice.po_number}" size="10" placeholder="ระบุเลขที่ PO" />
                <br />
                <input type="checkbox" name="isStatement" id="isStatement" value="4" {if $invoice.is_quotation == 4} checked="checked" {/if}  />
                ตั้งหัว Invoice เป็นใบแจ้งหนี้/Statement <br />
            </div>
        </div>
    </div>
    <div style="clear: both;"></div>
            
</div>
{if $invoice.id == 75951 || $invoice.id == 75958}
<hr>
{include file='invoices/dbc_sale_invoice.tpl'}
<hr>
{/if}
<script type="text/javascript">
{literal}
$(document).ready(function () {
    $('.manageContactAddress').click(function () {
        var fbUrl   = $(this).prop('href');
        $.facebox({ ajax: fbUrl,width:900,nofooter:true,opacity:0.8,addclass:'modernfacebox' });
        return false;
    });

    $('#invoiceSend').click(function () {
        if ($(this).is(':checked')) {
            $.post('?cmd=addresshandle&action=updateMailDelivery', {invoiceId:{/literal}{$invoice.id}{literal},invoiceSendDate:$('#invoiceSendDate').val()}, function(a){
                parse_response(a);
            });
            $(this).parent().next().show();
        } else {
            $(this).parent().next().hide();
        }
        $('#invoiceSend').prop('disabled', true);
        $('input[name="invoiceSendBy"]').eq(0).prop('checked', true);
    });
    
    $('#invoiceSendDate').change(function () {
        $.post('?cmd=addresshandle&action=updateMailDelivery', {invoiceId:{/literal}{$invoice.id}{literal},invoiceSendDate:$(this).val()}, function(a){
            parse_response(a);
        });
    });
    
    $('input[name="invoiceSendBy"]').each(function () {
        $(this).click( function () {
            $.post('?cmd=addresshandle&action=updateMailDelivery', {invoiceId:{/literal}{$invoice.id}{literal},invoiceSendBy:$(this).val()}, function(a){
                parse_response(a);
            });
        });
    });
    
    $('#invoiceSendNotes').change(function () {
        $.post('?cmd=addresshandle&action=updateMailDelivery', {invoiceId:{/literal}{$invoice.id}{literal},invoiceSendNotes:$(this).val()}, function(a){
            parse_response(a);
        });
    });
    
    $('#poNumber').change(function () {
        $.post('?cmd=invoicehandle&action=updatePONumber', {invoiceId:{/literal}{$invoice.id}{literal},value:$(this).val()}, function(a){
            parse_response(a);
        });
    });
    
    $('#isWhTaxReceived').change(function () {
        var v   = $(this).is(':checked') ? 1 : 0;
        $.post('?cmd=addresshandle&action=updateWithholdingTax', {invoiceId:{/literal}{$invoice.id}{literal},value:v}, function(a){
            parse_response(a);
        });
    });
    
    $('#isQuotation').change(function () {
        $('#isStatement').prop('checked', false);
        $('#isBillissue').prop('checked', false);
        $('#isDeliverybill').prop('checked', false);
        var v   = $(this).is(':checked') ? 1 : 0;
        $.post('?cmd=invoicehandle&action=updateIsQuotation', {invoiceId:{/literal}{$invoice.id}{literal},value:v}, function(a){
            parse_response(a);
        });
    });
    
    $('#isBillissue').change(function () {
        $('#isStatement').prop('checked', false);
        $('#isQuotation').prop('checked', false);
        $('#isDeliverybill').prop('checked', false);
        var v   = $(this).is(':checked') ? 2 : 0;
        $.post('?cmd=invoicehandle&action=updateIsQuotation', {invoiceId:{/literal}{$invoice.id}{literal},value:v}, function(a){
            parse_response(a);
        });
    });
    
    $('#isDeliverybill').change(function () {
        $('#isStatement').prop('checked', false);
        $('#isQuotation').prop('checked', false);
        $('#isBillissue').prop('checked', false);
        var v   = $(this).is(':checked') ? 3 : 0;
        $.post('?cmd=invoicehandle&action=updateIsQuotation', {invoiceId:{/literal}{$invoice.id}{literal},value:v}, function(a){
            parse_response(a);
        });
    });
    
    $('#isStatement').change(function () {
        $('#isDeliverybill').prop('checked', false);
        $('#isQuotation').prop('checked', false);
        $('#isBillissue').prop('checked', false);
        var v   = $(this).is(':checked') ? 4 : 0;
        $.post('?cmd=invoicehandle&action=updateIsStatement', {invoiceId:{/literal}{$invoice.id}{literal},value:v}, function(a){
            parse_response(a);
        });
    });
    
    $('#billigChequeFormSave').click( function () {
        $('.billigChequeForm').addLoader();
        $.post('?cmd=invoicehandle&action=updateBillingCheque', {invoiceId:{/literal}{$invoice.id}{literal},data:$('.billigCheque').serialize()}, function(a){
            parse_response_json(a);
            document.location = '?cmd=invoices&action=edit&id={/literal}{$invoice.id}{literal}';
        });
    });

});
{/literal}
</script>

{/if}