
<div id="changeManagementDetail">

    <table width="98%" cellpadding="2" cellspacing="2">
    <tr bgcolor="#B5D9E5">
        <td width="180">ประเภท:</td>
        <td>
            <strong>
            {if $aAccountInfo.confirm == 'confirm'} รอให้ลูกค้ายืนยันให้ดำเนินการ {/if}
            {if $aAccountInfo.confirm == 'notify'} บังคับเปลี่ยน แต่มีการแจ้งผู้ได้รับผลกระทบ {/if}
            {if $aAccountInfo.confirm == 'force'} บังคับการเปลี่ยนแปลง ไม่แจ้งผู้ได้รับผลกระทบ {/if}
            </strong>
        </td>
    </tr>
    <tr>
        <td>Service ของลูกค้า:</td>
        <td>#{$aAccountInfo.account_id} {$aAccountInfo.domain}</td>
    </tr>
    <tr valign="top">
        <td>ข้อมูลลูกค้า:</td>
        <td>
            {$aAccountInfo.firstname} {$aAccountInfo.lastname} ({$aAccountInfo.email})<br />
            {$aAccountInfo.companyname}
        </td>
    </tr>
    </table>
    
    {if $aAccountInfo.confirm != 'force'}
    <div class="mmfeatured-e">
        <p>
            <input type="checkbox" name="change_client_confirm" onclick="changeManagementUpdate('client_confirm', 1);" value="1" {if $aAccountInfo.is_client_confirm} checked="checked" {/if} />
            ลูกค้า ยืนยัน ให้ดำเนินการได้ <span id="changeClientConfirmDate">{if $aAccountInfo.is_client_confirm} เมื่อ {$aAccountInfo.client_confirm_date} {/if}</span>
        </p>
    </div>
    {/if}
    
    <div>
    <table width="98%" cellpadding="2" cellspacing="2">
    <tr valign="top">
        <td width="180">กำหนดการให้ดำเนินการ:</td>
        <td>
            <div>
            <input id="changeStartDate" name="change_start_date" type="text" value="{$aAccountInfo.start_date|dateformat:$date_format}" style="border:1px dotted gray; color: red; padding-left:10px; width:100px; line-height: 16px;" readonly="readonly" />
            <input type="text" name="change_start_date_time" onchange="changeManagementUpdate('start_date_time', $('input[name=change_start_date_time]').val());" value="{$aAccountInfo.start_date_time}" size="3" /> น.
            &nbsp; ถึง &nbsp; 
            </div>
            <div>
            <input id="changeEndDate" name="change_end_date" type="text" value="{$aAccountInfo.end_date|dateformat:$date_format}" style="border:1px dotted gray; color: red; padding-left:10px; width:100px; line-height: 16px;" readonly="readonly" />
            <input type="text" name="change_end_date_time" onchange="changeManagementUpdate('end_date_time', $('input[name=change_end_date_time]').val());" value="{$aAccountInfo.end_date_time}" size="3" /> น.
            </div>
        </td>
    </tr>
    <tr>
        <td>ประมาณการเวลา downtime:</td>
        <td>
            <input type="text" name="change_operation_time_hour" onchange="changeManagementUpdate('operation_time', $('input[name=change_operation_time_hour]').val()+':'+$('input[name=change_operation_time_minute]').val());" value="{$aAccountInfo.operation_time_hour}" size="3" /> ชั่วโมง 
            <input type="text" name="change_operation_time_minute" onchange="changeManagementUpdate('operation_time', $('input[name=change_operation_time_hour]').val()+':'+$('input[name=change_operation_time_minute]').val());" value="{$aAccountInfo.operation_time_minute}" size="3" /> นาที 
        </td>
    </tr>
    </table>
    </div>
    
    <div>
        <br >
        Pending change ฝั่ง staff<br >
        <textarea id="changeNoteForStaff" name="change_note_for_staff" onchange="changeManagementUpdate('note_for_staff', $('#changeNoteForStaff').val());" style="width: 90%; border: 1px dotted #C97626">{$aAccountInfo.note_for_staff}</textarea>
    </div>
    <div>
        <br >
        Pending change ฝั่ง clients<br >
        <textarea id="changeNoteForClient" name="change_note_for_client" onchange="changeManagementUpdate('note_for_client', $('#changeNoteForClient').val());" style="width: 90%; border: 1px dotted #D5D59D">{$aAccountInfo.note_for_client}</textarea>
    </div>
    
    <div><p>&nbsp;</p></div>
    
    {if $aAccountInfo.confirm != 'force'}
    <div class="mmfeatured-e">
        <p>
            <input type="checkbox" name="change_edm_send" onclick="changeManagementUpdate('edm_send', 1);" value="1" {if $aAccountInfo.is_edm_send} checked="checked" {/if} />
            ส่ง EDM ถึงลูกค้าแล้ว <span id="changeEdnSendDate">{if $aAccountInfo.is_edm_send} เมื่อ {$aAccountInfo.edm_send_date} {/if}</span>
            <span style="color: red;">(ข้อปฏิบัติ ต้องส่ง email แจ้งก่อนดำเนินการ)</span>
        </p>
    </div>
    {/if}
    
    <div>
        บริการย่อยที่จะมีผลกระทบตามไปด้วย &nbsp; 
        {if $aAccountInfo.confirm != 'force'}
        <a href="?cmd=supportcataloghandle&action=exportChangeManagementClient&hostname={$aAccountInfo.domain}" target="_blank">Export client email สำหรับส่ง EDM</a>
        {/if}
        <hr noshade="noshade" />
        
        <div style="display: block; width: 600px; height: 180px; overflow: scroll;">
        <table cellpadding="2" cellspacing="2" border="0" width="90%">
        <thead>
        <tr bgcolor="#EFEFEF">
            <th>#</th>
            <th>Email</th>
            {if $aAccountInfo.confirm == 'confirm'}
            <th>ยืนยัน</th>
            {/if}
            <th>Service</th>
            <th>Client</th>
        </tr>
        </thead>
        <tbody>
        {if $aClient|@count}
        {foreach from=$aClient item=arr}
        <tr>
            <td nowrap="nowrap"><a href="?cmd=accounts&action=edit&id={$arr.id}" target="_blank">#{$arr.id} {$arr.domain}</a></td>
            <td nowrap="nowrap">{$arr.email}</td>
            {if $aAccountInfo.confirm == 'confirm'}
            <td nowrap="nowrap">
                <input type="checkbox" name="change_client_confirm_{$arr.id}" onclick="changeManagementUpdate('client_confirm_account', {$arr.id});" value="1" {if $arr.is_confirm} checked="checked" {/if} />
                <span>{if $arr.is_confirm} {$arr.confirm_date} {/if}</span>
            </td>
            {/if}
            <td nowrap="nowrap">{$arr.name}</td>
            <td nowrap="nowrap">{if $arr.companyname}{$arr.companyname}{else}{$arr.firstname} {$arr.lastname}{/if}</td>
        </tr>
        {/foreach}
        {else}
        <tr>
            <td colspan="5">
                <p>--- ไม่มีข้อมูล ---</p>
            </td>
        </tr>
        {/if}
        </tbody>
        </table>
        </div>
        
    </div>
    
</div>

<script language="JavaScript">

{literal}

$(document).ready( function () {
    
    $('#changeStartDate').datePicker({
        startDate:'01/01/2000'
    }).change( function () {
        changeManagementUpdate('start_date', $('#changeStartDate').val());
    });
    $('#changeEndDate').datePicker({
        startDate:'01/01/2000'
    }).change( function () {
        changeManagementUpdate('end_date', $('#changeEndDate').val());
    });
    
});

function changeManagementUpdate (field, value)
{
    if (field == 'client_confirm') {
        if(! $('input[name="change_client_confirm"]').is(':checked')){
            $('input[name="change_client_confirm"]').prop('checked', true);
            return false;
        }
    }
    if (field == 'edm_send') {
        if(! $('input[name="change_edm_send"]').is(':checked')){
            $('input[name="change_edm_send"]').prop('checked', true);
            return false;
        }
    }
    if (field == 'client_confirm_account') {
        if(! $('input[name="change_client_confirm_'+ value +'"]').is(':checked')){
            $('input[name="change_client_confirm_'+ value +'"]').prop('checked', true);
            return false;
        }
    }
    $('#changeManagementDetail').addLoader();
    $.post('?cmd=supportcataloghandle&action=updateChangeManagement', {
        change_id: {/literal}{$aAccountInfo.id}{literal}, 
        field: field, 
        value: value
        }, function (data) {
        $('#preloader').remove();
    });
}

{/literal}
</script>
