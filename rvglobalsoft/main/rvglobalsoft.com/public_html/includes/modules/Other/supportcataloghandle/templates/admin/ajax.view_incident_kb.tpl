
{if $scId != $aSelected.sc_id && $aSelected.sc_id}
<div align="center" class="imp_msg_error" style="margin-top:10px;">
    {if $aSelected.request_type == 'Service Request'}
    <strong>Ticket#{$ticketId}: ผูกกับ Service Catalog <a href="javascript:void(0);" onclick="displayServiceCatalog(); return false;">#{$aSelected.sc_id} {$aSelected.title}</a></strong> ให้ระวังการเปลี่ยน Service Catalog มีผลกับ SLA 
    {else}
    <strong>Ticket#{$ticketId}: ผูกกับ Incident KB <a href="javascript:void(0);" onclick="displayServiceCatalog(); return false;">#{$aSelected.sc_id} {$aSelected.title}</a></strong> ให้ระวังการเปลี่ยน Incident KB มีผลกับ SLA 
    {/if}
</div>
<br />
{/if}

<div>
    <ul class="incidentKBTab">
        <li><a href="javascript:void(0);" onclick="selectIncidentKBTab('info');">ข้อมูล</a></li>
        <li><a href="javascript:void(0);" onclick="selectIncidentKBTab('policy');">Escalation</a></li>
        <li style="{if $aSelected.sc_id == $aData.id} display: none; {/if}" style="text-align: center;">
            {if $aSelected.sc_id != $aData.id}
            <a href="javascript:void(0);" onclick="useThisIncidentKB({$ticketId}, {$aData.id})"
                class="menuitm greenbtn" style="line-height: 20px; width: 70px; text-align: center; font-size: 16px; position: relative; margin-top: -10px; display: block;"
                title="ใช้ Incident KB นี้">+ ใช้งาน</a>
            {/if}
        </li>
    </ul>
    <div id="incidentKBPolicy">
        <h3>Escalation Policy</h3>
        <p><strong>Staff Owner:</strong> {$aData.firstname}</p>
        <hr noshade="noshade" />
        <p>กรณีที่ไม่สามารถดำเนินการเองได้ให้ ทำการ escalate ticket (ส่งต่อ) ด้วยวิธีการต่อไปนี้ <b>ตามลำดับ</b> จนกว่า จะ <b>ตอบคำถามลูกค้าได้</b> หรือ ticket ถูก <b>assign ไปยังผู้รับผิดชอบคนใหม่</b> </p>
        <p><br />{$aData.escalationPolicy|nl2br}<br /><br /></p>
    </div>
    <div id="incidentKBInfo">
        
        {if ! $aData.is_publish}
        <div align="center" class="imp_msg" style="margin-top:10px;">
            <strong>เอกสารยังไม่เผยแพร่:</strong> หากต้องการข้อมูลเพิ่มเติมให้ติดต่อ Incident KB Owner
        </div>
        <br />
        {/if}
        
        <div>
            
            <h2><span style="color: gray; font-size: 0.8em; ">{$aData.catName}</span> &nbsp;&nbsp;&nbsp; {$aData.title} &nbsp; [<a href="?cmd=servicecataloghandle&action=viewIncidentKB&id={$aData.id}" style="color:red;" target="_blank">แก้ไข</a>]</h2>
            
            <table width="100%" cellpadding="2" cellspacing="2" border="0">
            <tbody>
            <tr>
                <td width="70%"><strong>SLA เหลือเวลา:</strong> <span {if $aSelected.is_pause != '1' && $aSelected.endDate != '0'} data-countdown="{$aData.endingSLA}" {/if}>{if $aSelected.is_pause == '1' || $aSelected.endDate == '0'} ใช้เวลา {$aSelected.time_in_minute} นาที จากที่กำหนดไว้ {$aSelected.sla_in_minute} นาที {/if}</span></td>
            </tr>
            </tbody>
            </table>
            
            <p><br />{$aData.description}<br /><br /></p>
            
        </div>
        
        <div><p>&nbsp;</p></div>
        
        <table cellpadding="2" cellspacing="2" border="0" width="100%">
        <tr valign="top">
            <td>
                
                <div style="width: 100%; position: relative;">
                    <label style="display:block; padding:2px; position: absolute; top: 0px; right: 0px;"><a href="">Suggestion (0)</a></label>
                </div>
                
                <h2 style="border-bottom: 1px solid #AAAAAA;">วิธีแก้ปัญหา Level 1</h2>
                <p>{$aData.detail_helpdesk}</p>
                <div><p>&nbsp;</p></div>
                
                <h2 style="border-bottom: 1px solid #AAAAAA;">วิธีแก้ปัญหา Level 2</h2>
                <p>{$aData.detail_support}</p>
                <div><p>&nbsp;</p></div>
                
            </td>
        </tr>
        <tr>
            <td>
                {include file="$tplPath/admin/view_reply.tpl"}
            </td>
        </tr>
        </table>
        <div class="clearBoth"></div>
        
        <div><p>&nbsp;</p></div>

    </div>
</div>
<div class="clearBoth"><p>&nbsp;</p></div>

<script language="JavaScript">

// var ticketId   = {$ticketId}; // already defined
var catIdIncidentKB         = {$catId};
var scIdIncidentKB          = {$scId};

{literal}

$(document).ready(function () {
    selectIncidentKBTab('info');
});

function useThisIncidentKB (ticketId, id)
{
    $('#incidentDisplay').parent().addLoader();
    $.post('?cmd=supportcataloghandle&action=useThisIncidentKB', {
        ticketId    : ticketId,
        kbId        : id
        }, function (a) {
        parse_response(a);
        $('#preloader').remove();
        $('#replytable').unblock();
        loadIncidentKB( catIdIncidentKB +'.'+ id );
        displayReplyTicketIfAssignedClient();
    });
    
    return false;
}

function gotoSelectedIncidentKB (id)
{
    
    var n       = $('#listBoxContentlistSubCategoryIncidentKB').find('div').find('div').length;
    
    for (var i = 0; i < n; i++) {
        var item    = $('#listSubCategoryIncidentKB').jqxListBox('getItem', i );
        if (id == item.value) {
            $('#listSubCategoryIncidentKB').jqxListBox('selectIndex', i ); 
            $('#listSubCategoryIncidentKB').jqxListBox('ensureVisible', i ); 
            loadIncidentKB(id); 
        }
    }
    
    return false;
}

function selectIncidentKBTab (tab)
{
    $('.incidentKBTab li').css('background-color', '#FFFFFF');
    
    $('#incidentKBInfo').hide();
    $('#incidentKBPolicy').hide();
    
    if (tab == 'info') {
        $('.incidentKBTab li:eq(0)').css('background-color', '#CCCCCC');
        $('#incidentKBInfo').show();
    } else if (tab == 'policy') {
        $('.incidentKBTab li:eq(1)').css('background-color', '#CCCCCC');
        $('#incidentKBPolicy').show();
    }
    
}

{/literal}
</script>


