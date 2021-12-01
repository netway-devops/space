{php}
$templatePath   = $this->get_template_vars('template_path');
include($templatePath . 'orders/step_Authorize.tpl.php');
{/php}

{literal}
<style type="text/css">
.bgWhite { background-color: #FFFFFF; }
.bgHead { background-color: #E9E9E9; font-weight: bold; }
.bgGray1 { background-color: #F4F4F4; }
.bgGray2 { background-color: #FEFEFE; }
.linkRed { color: #FF0000; }
.width250 { width: 250px; }
.width100 { width: 100px; }
.width400 { width: 400px; }
.space10 { height: 10px;}
.spanBlock100 { display: block; float: left; width: 100px; }
</style>
{/literal}

{if $step.status=='Completed'}
    <span class="info-success">Authorization succeeded.</span>
    {if $step.output}
    <br/><br/><b>Authorization return:</b> {$step.output}
    {/if}

    {if $steps[4].status != 'Completed'}
    <div class="p5"><b>เจ้าหน้าที่สามารถดำเนินการทำ Provision โดยการกด Accept Order ได้เลย</b></div>
    {/if}

{elseif $steps[3].status == 'Completed'}
    <div class="p5">
        <p>
        เจ้าหน้าที่สามารถ 
        <a class="menuitm " href="?cmd=orders&action=executestep&step=Authorize&order_id={$details.id}&security_token={$security_token}&skip=true" ><span>Mark as completed</span></a>
        ได้เลย เพราะ Capture Payment Completed แล้ว
        </p>
    </div>

{else}

    {if $step.status=='Pending'}
        Authorization is pending, please review order
    {else}

        <span class="info-failed">Payment authorization failed.</span>
        {if $step.output}
        <br/><br/><b>Authorization return:</b> {$step.output}
        {/if}
    {/if}

    {if $details.invoice_id!='0' && $details.module}<br/><br/>
    <a class="menuitm greenbtn" href="?cmd=orders&action=executestep&step=Authorize&order_id={$details.id}&security_token={$security_token}" ><span>{$details.module}: Authorize</span></a>
    {/if}
    <a class="menuitm " href="?cmd=orders&action=executestep&step=Authorize&order_id={$details.id}&security_token={$security_token}&skip=true" ><span>Mark as completed</span></a>

{/if}


{if $aAuthorize|@count}

<div><p>&nbsp;</p></div>

<div id="authArea" class="ticketmsg ticketmain">
    <div><p><b>รายละเอียดการชำระเงิน</b></p></div>
    <div>
        
        <table border="0" cellpadding="2" cellspacing="1">
        <tr valign="top" class="bgHead">
            <td width="200">วันที่ชำระเงิน</td>
            <td width="300">ชำระผ่าน</td>
            <td width="400">จำนวนเงิน</td>
        </tr>
        {foreach from=$aAuthorize key="i" item="arr"}
        <tr valign="top" class="{if $i}bgGray2{else}bgGray1{/if}">
            <td>{$arr.paid_date|dateformat:$date_format}</td>
            <td>
                {if isset($aBankTransfer[$arr.payment])}
                    Banktransfer: {$aBankTransfer[$arr.payment]}
                {else}
                    {$arr.payment}
                {/if}
            </td>
            <td>
                {$arr.amount|price:$currency} &nbsp;&nbsp;&nbsp; 
                {if $arr.total_wh == 'total_wh_3'}
                (หัก ณ ที่จ่าย 3 %)
                {elseif $arr.total_wh == 'total_wh_3'}
                (หัก ณ ที่จ่าย 1 %)
                {/if}
            </td>
        </tr>
        <tr valign="top" class="{if $i}bgGray2{else}bgGray1{/if}">
            <td colspan="3">
                <b>
                {if $arr.type == 'Slip'}มีหลักฐาน Slip โอนเงิน (ATM, Internet, Counter) {/if}
                {if $arr.type == 'PO'}มีหลักฐาน สำเนา PO {/if}
                {if $arr.type == 'Cheque'}มีหลักฐาน สำเนาหน้า Cheque {/if}
                {if $arr.type == ''}ไม่มีหลักฐาน (โทรแจ้ง อีเมล์) {/if}
                </b>
            </td>
        </tr>
        <tr valign="top" class="{if $i}bgGray2{else}bgGray1{/if}">
            <td>ข้อมูลอ้างอิง</td>
            <td colspan="2">
                <p>Ticket url: <a href="{$arr.reference_url}" target="_blank">{$arr.reference_url}</a></p>
                <p>หลักฐาน: <a href="../attachments/{$arr.reference_file|escape}" target="_blank">{$arr.reference_file}</a></p>
                <p>Note: {$arr.reference_note|nl2br}</p>
                <hr noshade="noshade" size="1" />
                @{$arr.date|dateformat:$date_format} by {$arr.username}
                <br /><br />
            </td>
        </tr>
        
        {if !$i}
        <tr>
            <td colspan="3" align="right">
            <p>
                {if $step.status=='Completed'}
                <a href="?cmd=fulfillmenthandle&action=pendingAuthorize&orderId={$details.id}" onclick="return confirm('ยืนยันการลบ?');" class="menuitm menul"><span class="linkRed">มีข้อมูลผิดพลาด ขอเปลี่ยนสถาณะ Authorize เป็น Pending อีกครั้ง ? (ข้อมูล Authorize Payment จะถูกลบทิ้ง)</span></a>
                {/if}
            </p>
            </td>
        </tr>
        {/if}
        
        {/foreach}
        </table>
        
    </div>
</div>


{literal}
<script language="JavaScript">
$(document).ready( function () {
    
});
</script>
{/literal}

{/if}

{if $step.status!='Completed'}

<div><p>&nbsp;</p></div>

<div id="authArea" class="ticketmsg ticketmain">
    <div><p><b>{if $aAuthorize|@count}เจ้าหน้าที่แก้ไขข้อมูลยืนยันการชำระเงิน{else}เจ้าหน้าที่บันทึกยืนยันการชำระเงิน{/if}</b></p></div>
    <div>
        
        <input type="hidden" name="orderId" value="{$details.id}" />
        <table border="0" cellpadding="2" cellspacing="2" class="bgWhite">
        <tr valign="top">
            <td width="300">
                โอนเข้าธนาคาร<br />
                <select id="authBanktransfer" name="authBanktransfer" class="width250">
                <option value="">--- เลือก ---</option>
                {foreach from=$aBankTransfer key=k item=v}
                <option value="{$k}"> {$v} </option>
                {/foreach}
                </select>
            </td>
            <td width="300">
                <input type="checkbox" id="authPaypal" name="authPaypal" value="Paypal" />
                Paypal <br />&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; (ถ้า capture payment ไม่ทำงานอัตโนมัติ)
            </td>
            <td width="300">
                <input type="checkbox" id="authCreditCard" name="authCreditCard" value="CreditCard" />
                Credit Card <br />&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; (ถ้า capture payment ไม่ทำงานอัตโนมัติ)
            </td>
        </tr>
        <tr><td colspan="3" class="space10"><hr size="1" noshade="noshade" /></td></tr>
        <tr valign="top">
            <td>
                <span class="spanBlock100">วันที่ชำระเงิน</span>
                <input type="text" id="authDate" name="authDate" class="width100 haspicker" placeholder="เลือกจากปฏิทิน" />
                <br />
                <span class="spanBlock100">เวลา</span>
                <input type="text" id="authTime" name="authTime" class="width100" placeholder="เช่น 15.30" />
            </td>
            <td>
                จำนวนเงิน<br />
                <input type="text" id="authAmount" name="authAmount" class="width100" placeholder="เช่น 1280.30" />
                บาท
            </td>
            <td>
                เป็นยอด<br />
                <select id="authWithHolding" name="authWithHolding" class="width250">
                <option value="total">ปกติ {$aTotal.total|price:$currency}</option>
                <option value="total_wh_3">หัก ณ ที่จ่าย 3 % {$aTotal.total_wh_3|price:$currency}</option>
                <option value="total_wh_1">หัก ณ ที่จ่าย 1 % {$aTotal.total_wh_1|price:$currency}</option>
                </select>
            </td>
        </tr>
        </table>
        <br />
        
        <table border="0" cellpadding="2" cellspacing="2" class="bgWhite">
        <tr>
            <td width="20"><input type="radio" name="authType" value="Slip" /></td>
            <td width="880">มีหลักฐาน Slip โอนเงิน (ATM, Internet, Counter) </td>
        </tr>
        <tr>
            <td width="20"><input type="radio" name="authType" value="PO" /></td>
            <td>มีหลักฐาน สำเนา PO </td>
        </tr>
        <tr>
            <td width="20"><input type="radio" name="authType" value="Cheque" /></td>
            <td>มีหลักฐาน สำเนาหน้า Cheque </td>
        </tr>
        <tr><td class="space10"></td></tr>
        <tr>
            <td width="20"><input type="radio" name="authType" value="" checked="checked" /></td>
            <td>ไม่มีหลักฐาน (โทรแจ้ง อีเมล์) </td>
        </tr>
        </table>
        <br />
        
        <table border="0" cellpadding="2" cellspacing="2" class="bgWhite">
        <tr>
            <td width="100">อ้างอิง</td>
            <td width="200">Ticket url</td>
            <td width="600">
                <input type="text" id="authTicketUrl" name="authTicketUrl" class="width400" placeholder="คัดลอก url มาวางได้เลย" /><br />
                <span>ถ้ามีรูปหลักฐานใน ticket ที่ระบุอยู่แล้ว ไม่ต้อง upload รูปซ้ำ</span>
            </td>
        </tr>
        <tr>
            <td></td>
            <td>หลักฐาน</td>
            <td>
                <input type="text" id="authFile" name="authFile" readonly="readonly" class="width400" />
                <div id="fileUploaderAuthorize"></div>
            </td>
        </tr>
        <tr>
            <td></td>
            <td>อื่นๆ</td>
            <td>
                <textarea id="authNote" name="authNote" class="width400"></textarea>
            </td>
        </tr>
        </table>
        <br />
        <a id="addAuthorize" href="javascript:authFormSubmit();void(0);" class="menuitm greenbtn">{if $aAuthorize|@count} แก้ไขข้อมูล {else} บันทึกข้อมูล {/if}</a>
        <br />
        
        
    </div>
</div>

{literal}
<script language="JavaScript">
$(document).ready( function () {
    
    $('#authDate, #authTime, #authAmount, #authTicketUrl, #authFile').keydown( function (event) {
        if (event.keyCode == 13) {
            event.preventDefault();
            return false;
        }
    });
    
    var uploaderAuthorize       = new qq.FileUploader({
        element: document.getElementById('fileUploaderAuthorize'),
        action: '?cmd=fulfillmenthandle&action=upload',
        params: {},
        uploadButtonText: 'Upload',
        onComplete: function(id, fileName, responseJSON){
            $('#authFile').val(responseJSON.filename);
        }
    });
    
    $('#authBanktransfer').change( function () {
        $('#authPaypal').prop('checked', false).parent().css('background-color','');
        $('#authCreditCard').prop('checked', false).parent().css('background-color','');
        $(this).parent().css('background-color','#ECECEC');
    });
    $('#authPaypal').click( function () {
        $('#authBanktransfer option:eq(0)').prop('selected', true).parent().parent().css('background-color','');
        $('#authCreditCard').prop('checked', false).parent().css('background-color','');
        $(this).parent().css('background-color','#ECECEC');
    });
    $('#authCreditCard').click( function () {
        $('#authBanktransfer option:eq(0)').prop('selected', true).parent().parent().css('background-color','');
        $('#authPaypal').prop('checked', false).parent().css('background-color','');
        $(this).parent().css('background-color','#ECECEC');
    });
    
    $('#authTime, #authAmount').keypress(function(event) {
        if ((event.which != 46 || $(this).val().indexOf('.') != -1) && (event.which < 48 || event.which > 57)) {
            event.preventDefault();
        }
    });
    
});

function authFormSubmit ()
{
    $('div#authArea').addLoader();
    if($('#authDate').val() == '' || $('#authTime').val() == '' || $('#authAmount').val() == ''){
        alert('ระบุข้อมูล วันที่ จำนวนเงิน ให้ครบถ้วน');
        $('#preloader').remove();
        return;
    }
    $.post('?cmd=fulfillmenthandle&action=addAuthorize',
        $('input, textarea, select').serialize(),
        function (result) {
        $('#preloader').remove();
        document.location = '?cmd=orders&action=edit&id={/literal}{$details.id}{literal}';
    });
    
}
</script>
{/literal}

{/if}