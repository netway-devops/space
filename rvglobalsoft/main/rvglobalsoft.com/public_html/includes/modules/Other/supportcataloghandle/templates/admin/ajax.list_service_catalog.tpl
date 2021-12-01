
<div id="serviceCatalogDisplay">
    <ul style="display: none;">
        <li><a href="#" onclick="select_listServiceCatalogDisplay(); return false;">Lists</a></li>
        <li style="border-right: 1px solid #CCCCCC;"><a href="#" onclick="select_viewServiceCatalogDisplay(); return false;">Detail</a></li>
    </ul>
    <div>
        <div id="listServiceCatalogDisplay">
            
            <p>&nbsp;</p>
            
            <h3>Service Catalog ในหมวด &nbsp;&nbsp;&nbsp; {$catName} &nbsp;&nbsp;&nbsp; พบ {$aLists|@count} รายการ</h3>
            
            <ul style="width: 700px; display: block;">
                {foreach from=$aLists item="aList"}
                <li style="border-bottom: 1px dotted #CCCCCC; line-height: 28px; width: 100%; position: relative;">
                    <label style="display:block; padding:2px; position: absolute; top: 0px; right: 0px; margin-right: 120px;">Owner: {$aList.firstname}</label>
                    <label style="background-color: {if $aList.is_publish}#E0ECFF{else}#CCCCCC{/if}; display:block; padding:2px; position: absolute; top: 0px; right: 0px;">{if ! $aList.is_publish} Un {/if} Publish</label>
                    <a href="?cmd=servicecataloghandle&action=view&id=5" onclick="viewServiceCatalog({$aList.id}, {$aList.is_publish}); return false;"><h4 style="margin: 0px; color: #428CB0; text-decoration: underline; ">{$aList.title}</h4></a>
                    {if $aList.staff_id == $aAdmin.id}<a href="?cmd=servicecataloghandle&action=view&id=5" target="_blank" style="float: right; color: red;" >Edit</a>{/if}
                    <p style="margin: 3px; color:gray;">{if $aList.description}{$aList.description}{else}--- ไม่ได้ระบุรายละเอียดคร่าวๆไว้ ---{/if}</p>
                    
                </li>
                {/foreach}
            </ul>
            <div class="clearBoth"></div>
            
        </div>
        <div id="viewServiceCatalogDisplay"></div>
    </div>
</div>
<div class="clearBoth"></div>


<script language="JavaScript">

var ticketId        = {$ticketId};
var catId           = {$catId};
var scId            = {$scId};

{literal}

$(document).ready(function () {
    select_listServiceCatalogDisplay ();
    if (scId) {
        viewServiceCatalog (scId, 1);
    }
});

function select_listServiceCatalogDisplay ()
{
    $('#serviceCatalogDisplay > ul li').addClass('selectTypeNo');
    $('#serviceCatalogDisplay > ul li:eq(0)').removeClass('selectTypeNo').addClass('selectTypeYes');
    $('#listServiceCatalogDisplay').show();
    $('#viewServiceCatalogDisplay').hide();
    
}

function select_viewServiceCatalogDisplay ()
{
    $('#serviceCatalogDisplay > ul li').addClass('selectTypeNo');
    $('#serviceCatalogDisplay > ul li:eq(1)').removeClass('selectTypeNo').addClass('selectTypeYes');
    $('#listServiceCatalogDisplay').hide();
    $('#viewServiceCatalogDisplay').show();
    $('#viewServiceCatalogDisplay').css('display', 'block');
    $('#viewServiceCatalogDisplay').css('width', '100%');
}

function viewServiceCatalog (scId, isPublish)
{
    if (isPublish == '0') {
        alert('เนื่องจาก Staff เจ้าของข้อมูลนี้ตั้งสถานะว่ารายการนี้ยังไม่พร้อมใช้งาน กรุณาติดต่อ Staff เจ้าของข้อมูล');
        return false;
    }
    
    select_viewServiceCatalogDisplay();
    $('#viewServiceCatalogDisplay').parent().addLoader();
    $('#viewServiceCatalogDisplay').load( '?cmd=supportcataloghandle&action=viewServiceCatalog&ticketId='+ ticketId 
        +'&catId='+ catId +'&scId='+ scId, function() {
        $('#preloader').remove();
        $('#tocMainDropdown').show();
    });
    
}

{/literal}
</script>
