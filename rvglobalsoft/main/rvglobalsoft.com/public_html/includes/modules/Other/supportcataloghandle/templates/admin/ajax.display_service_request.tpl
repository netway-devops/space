<div class="stickyChild" style="z-index: 999;">
    <div class="mmfeatured-e" align="right">
        
        <select id="tocMainDropdown" onchange="tocNavigateToInside(this);" style="display: none;">
            <option value="">&#9660; ทางลัด </option>
            <!--
            <option onclick="tocNavigateTo('#replyarea');">Reply </option>
            <option onclick="tocNavigateTo('#tocFulfillment');">Request Fullfilment Process </option>
            <option onclick="tocNavigateTo('#tocServiceCatalog');">Service Catalog </option>
            -->
            <option value="#listMainSubCategory">0. หมวด Service Catalog ทั้งหมด</option>
            <option value="#tocFAQ">1.FAQs </option>
            <option value="#tocPerm">2.สิทธิในการร้องขอ </option>
            <option value="#tocOrder">3.ขั้นตอนการสั่งซื้อ </option>
            <option value="#tocTime">4.เงื่อนไขในการเริ่มดำเนินการส่งมอบ </option>
            <option value="#tocSend">5.ระยะเวลาในการส่งมอบ </option>
            <option value="#tocPrice">6.ราคา </option>
            <option value="#tocRelate">7.บริการอื่น ๆ </option>
            <option value="#tocReserv">8.ข้อห้ามในการใช้บริการ </option>
            <option value="#tocSale">9.เจ้าหน้าที่ขาย </option>
            <option value="#tocVarant">10.การรับประกัน </option>
            <option value="#tocRecovery">11.Fallback </option>
            <option value="#tocEmer">12.ข้อมูลกรณีฉุกเฉิน </option>
        </select>
    
    </div>
</div>

<div>
    <a href="javascript:void(0);" onclick="{literal}$('#listMainSubCategory').toggle(); return false;{/literal}"  class="menuitm" style="line-height: 20px;">แสดง / ซ่อน Service Catalog Category</a> &nbsp;
    <span id="requestForServiceCatalogButton"><a href="javascript:void(0);" onclick="requestForServiceCatalog({$ticketId}); return false;" class="menuitm" style="line-height: 20px;"><span class="addsth">Request for Service Catalog</span></a> <span style="color:gray;">(กรณีหา service catalog ไม่เจอ)</span></span>
</div>

<table id="listMainSubCategory" cellpadding="0" cellspacing="0" width="100%" border="0">
<tbody>
<tr>
    <td width="260">
        <div id="listMainCategory"></div>
    </td>
    <td>
        <div id="listSubCategory" class="listSubCategory"></div>
        {foreach from=$mainCat item=mCat key=k}
        <div id="listSubCategory{$k}" class="listSubCategory"></div>
        {/foreach}
    </td>
</tr>
</tbody>
</table>
<div class="clearBoth"></div>

<div>&nbsp;</div>

<div id="listServiceCatalog"></div>
<div class="clearBoth"></div>

<script language="JavaScript">

var ticketId        = {$ticketId};
var scSelectedId    = {$selectedId};
var isServiceRequest        = {$isServiceRequest};

{literal}

$(document).ready(function () {
    
    var sourceMain  = [{/literal}{$mainCategory}{literal}];
    var sourceSub   = [{/literal}{$categoryList}{literal}];
    {/literal}{foreach from=$mainCat item=mCat key=k}
    var sourceSub{$k}   = [{$mCat}];
    {/foreach}{literal}
    
    $('#replyTemplateArea').html('');
    
    $('#listMainCategory').on('select', function (event) {
        var args    = event.args;
        
        if (args) {
            var item    = args.item;
            var value   = item.value;
           
            $('.listSubCategory').hide();
            $('#listSubCategory'+ ((value == '0') ? '': value)).show();
            
        }
    });
    $('#listMainCategory').jqxListBox({ source: sourceMain, width: '200px', height: '180px', searchMode: 'containsignorecase', filterable:true, filterPlaceHolder: 'Filter' });
    
    $('#listSubCategory').on('bindingComplete', function (event) {
        setTimeout(function () {
            
            $.each( sourceSub, function( i, item ) {
                if (item.value.indexOf('.') < 0) {
                    $('#listSubCategory').jqxListBox('disableItem', item.value );
                }
            });
            
            {/literal}{foreach from=$mainCat item=mCat key=k}{literal}
            $.each( sourceSub{/literal}{$k}{literal}, function( i, item ) {
                if (item.value.indexOf('.') < 0) {
                    $('#listSubCategory{/literal}{$k}{literal}').jqxListBox('disableItem', item.value );
                }
            });
            {/literal}{/foreach}{literal}
            
        }, 800);
    });
    
    $('.listSubCategory').on('select', function (event) {
        var args    = event.args;
        if (args) {
            var item    = args.item;
            var value   = item.value;
            loadServiceCatalog(value);
        }
    });
    $('#listSubCategory').jqxListBox({ source: sourceSub, width: '500px', height: '180px', searchMode: 'containsignorecase', filterable:true, filterPlaceHolder: 'Filter' });
    
    {/literal}{foreach from=$mainCat item=mCat key=k}{literal}
    $('#listSubCategory{/literal}{$k}{literal}').on('bindingComplete', function (event) {
        $('#filterlistSubCategory{/literal}{$k}{literal} input').click( function () {
            $('.listSubCategory').hide();
            $('#listSubCategory').show();
            $('#filterlistSubCategory input').focus();
            $('#listMainCategory').jqxListBox('selectIndex', 0 ); 
            $('#listMainCategory').jqxListBox('ensureVisible', 0 ); 
        });
    });
    $('#listSubCategory{/literal}{$k}{literal}').jqxListBox({ source: sourceSub{/literal}{$k}{literal}, width: '500px', height: '180px', searchMode: 'contains', filterable:true, filterPlaceHolder: 'Filter' });
    {/literal}{/foreach}{literal}
    
    if (scSelectedId) {
        
        $.each( sourceSub, function( i, item ) {
            if (scSelectedId == item.value) {
                $('#listSubCategory').jqxListBox('selectIndex', i ); 
                $('#listSubCategory').jqxListBox('ensureVisible', i ); 
            }
        });
        
        $('#listMainSubCategory').toggle();
        $('#requestForServiceCatalogButton').hide();
        //$('#tocMainDropdown').show();
    }
    
    $('.listSubCategory').hide();
    $('#listSubCategory').show();
    
});

function loadServiceCatalog (id)
{
    $('#listServiceCatalog').parent().addLoader();
    $('#listServiceCatalog').load( '?cmd=supportcataloghandle&action=listServiceCatalog&ticketId='+ ticketId 
        +'&catId='+ id, function() {
        $('#preloader').remove();
    });
}

function requestForServiceCatalog (ticketId)
{
    $('#listServiceCatalog').parent().addLoader();
    $.post('?cmd=supportcataloghandle&action=requestForServiceCatalog', {ticketId: ticketId}, function (a) {
        parse_response(a);
        $('#preloader').remove();
        $('#replytable').unblock();
        $('#requestForServiceCatalogButton').hide();
        displayServiceCatalogArea ('serviceRequestDisplay');
        displayServiceCatalog();
        displayReplyTicketIfAssignedClient();
    });
    
    return false;
}

{/literal}
</script>
