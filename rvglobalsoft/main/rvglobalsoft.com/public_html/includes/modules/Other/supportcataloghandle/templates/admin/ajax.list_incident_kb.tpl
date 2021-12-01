
<div id="incidentKBDisplay">
    <ul style="display: none;">
        <li><a href="#" onclick="select_listIncidentKBDisplay(); return false;">Lists</a></li>
        <li style="border-right: 1px solid #CCCCCC;"><a href="#" onclick="select_viewIncidentKBDisplay(); return false;">Detail</a></li>
    </ul>
    <div>
        <div id="listIncidentKBDisplay">
            
            <p>&nbsp;</p>
            
            <h3>Incident KB ในหมวด &nbsp;&nbsp;&nbsp; {$catName} &nbsp;&nbsp;&nbsp; พบ {$aLists|@count} รายการ</h3>
            
            <ul style="width: 700px; display: block;">
                {foreach from=$aLists item="aList"}
                <li style="border-bottom: 1px dotted #CCCCCC; line-height: 28px; width: 100%; position: relative;">
                    <label style="display:block; padding:2px; position: absolute; top: 0px; right: 0px; margin-right: 120px;">Owner: {$aList.firstname}</label>
                    <label style="background-color: {if $aList.is_publish}#E0ECFF{else}#CCCCCC{/if}; display:block; padding:2px; position: absolute; top: 0px; right: 0px;">{if ! $aList.is_publish} Un {/if} Publish</label>
                    <a href="?cmd=servicecataloghandle&action=viewIncidentKB&id=5" onclick="viewIncidentKB({$aList.id}, {$aList.is_publish}); return false;"><h4 style="margin: 0px; color: #428CB0; text-decoration: underline; ">{$aList.title}</h4></a>
                    {if $aList.staff_id == $aAdmin.id}<a href="?cmd=servicecataloghandle&action=viewIncidentKB&id=5" target="_blank" style="float: right; color: red;" >Edit</a>{/if}
                    <p style="margin: 3px; color:gray;">{if $aList.description}{$aList.description}{else}--- ไม่ได้ระบุรายละเอียดคร่าวๆไว้ ---{/if}</p>
                    
                </li>
                {/foreach}
            </ul>
            <div class="clearBoth"></div>
            
        </div>
        <div id="viewIncidentKBDisplay"></div>
    </div>
</div>
<div class="clearBoth"></div>


<script language="JavaScript">

// var ticketId   = {$ticketId}; // already defined
var catIdIncidentKB = {$catId};
var scIdIncidentKB  = {$scId};

{literal}

$(document).ready(function () {
    
    select_listIncidentKBDisplay ();
    if (scIdIncidentKB) {
        viewIncidentKB (scIdIncidentKB, 1);
    }
    
});

function select_listIncidentKBDisplay ()
{
    $('#incidentKBDisplay > ul li').addClass('selectTypeNo');
    $('#incidentKBDisplay > ul li:eq(0)').removeClass('selectTypeNo').addClass('selectTypeYes');
    $('#listIncidentKBDisplay').show();
    $('#viewIncidentKBDisplay').hide();
    
}

function select_viewIncidentKBDisplay ()
{
    $('#incidentKBDisplay > ul li').addClass('selectTypeNo');
    $('#incidentKBDisplay > ul li:eq(1)').removeClass('selectTypeNo').addClass('selectTypeYes');
    $('#listIncidentKBDisplay').hide();
    $('#viewIncidentKBDisplay').show();
    $('#viewIncidentKBDisplay').css('display', 'block');
    $('#viewIncidentKBDisplay').css('width', '100%');
}

function viewIncidentKB (scId, isPublish)
{
    if (isPublish == '0') {
        alert('เนื่องจาก Staff เจ้าของข้อมูลนี้ตั้งสถานะว่ารายการนี้ยังไม่พร้อมใช้งาน กรุณาติดต่อ Staff เจ้าของข้อมูล');
        return false;
    }
    
    select_viewIncidentKBDisplay();
    $('#viewIncidentKBDisplay').parent().addLoader();
    
    $('#viewIncidentKBDisplay').load( '?cmd=supportcataloghandle&action=viewIncidentKB&ticketId='+ ticketId
        +'&catId='+ catIdIncidentKB +'&scId='+ scIdIncidentKB, function() {
        $('#preloader').remove();
    });
    
}

{/literal}
</script>
