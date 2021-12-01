<div style="padding-top: 20px;">
    <a href="javascript:void(0);" onclick="{literal}$('#listMainSubCategoryIncidentKB').toggle(); return false;{/literal}"  class="menuitm" style="line-height: 20px;">แสดง / ซ่อน Incident KB Category</a> &nbsp;
    <span id="requestForIncidentKBButton"><a href="javascript:void(0);" onclick="requestForIncidentKB({$ticketId}); return false;" class="menuitm" style="line-height: 20px;"><span class="addsth">Request for Incident KB</span></a> <span style="color:gray;">(กรณีหา Incident KB ไม่เจอ)</span></span>
</div>

<table id="listMainSubCategoryIncidentKB" cellpadding="0" cellspacing="0" width="100%" border="0">
<tbody>
<tr>
    <td width="260">
        <div id="listMainCategoryIncidentKB"></div>
    </td>
    <td>
        <div id="listSubCategoryIncidentKB" class="listSubCategoryIncidentKB"></div>
        {foreach from=$mainCat item=mCat key=k}
        <div id="listSubCategoryIncidentKB{$k}" class="listSubCategoryIncidentKB"></div>
        {/foreach}
    </td>
</tr>
</tbody>
</table>
<div class="clearBoth"></div>

<div>&nbsp;</div>

<div id="listIncidentKB"></div>
<div class="clearBoth"></div>

<script language="JavaScript">

// var ticketId   = {$ticketId}; // already defined
var scSelectedIdIncidentKB      = '{$selectedId}';
var isServiceRequestIncidentKB  = {$isServiceRequest};

{literal}

$(document).ready(function () {
    
    var sourceMainIncidentKB  = [{/literal}{$mainCategory}{literal}];
    var sourceSubIncidentKB   = [{/literal}{$categoryList}{literal}];
    {/literal}{foreach from=$mainCat item=mCat key=k}
    var sourceSubIncidentKB{$k}   = [{$mCat}];
    {/foreach}{literal}
    
    $('#replyTemplateArea').html('');
    
    $('#listMainCategoryIncidentKB').on('select', function (event) {
        var args    = event.args;
        
        if (args) {
            var item    = args.item;
            var value   = item.value;
           
            $('.listSubCategoryIncidentKB').hide();
            $('#listSubCategoryIncidentKB'+ ((value == '0') ? '': value)).show();
            
        }
    });
    $('#listMainCategoryIncidentKB').jqxListBox({ source: sourceMainIncidentKB, width: '200px', height: '180px', searchMode: 'containsignorecase', filterable:true, filterPlaceHolder: 'Filter' });
    
    $('#listSubCategoryIncidentKB').on('bindingComplete', function (event) {
        setTimeout(function () {
            
            $.each( sourceSubIncidentKB, function( i, item ) {
                if (item.value.indexOf('.') < 0) {
                    $('#listSubCategoryIncidentKB').jqxListBox('disableItem', item.value );
                }
            });
            
            {/literal}{foreach from=$mainCat item=mCat key=k}{literal}
            $.each( sourceSubIncidentKB{/literal}{$k}{literal}, function( i, item ) {
                if (item.value.indexOf('.') < 0) {
                    $('#listSubCategoryIncidentKB{/literal}{$k}{literal}').jqxListBox('disableItem', item.value );
                }
            });
            {/literal}{/foreach}{literal}
            
        }, 800);
    });
    
    $('.listSubCategoryIncidentKB').on('select', function (event) {
        var args    = event.args;
        if (args) {
            var item    = args.item;
            var value   = item.value;
            loadIncidentKB(value);
        }
    });
    $('#listSubCategoryIncidentKB').jqxListBox({ source: sourceSubIncidentKB, width: '500px', height: '180px', searchMode: 'containsignorecase', filterable:true, filterPlaceHolder: 'Filter' });
    
    {/literal}{foreach from=$mainCat item=mCat key=k}{literal}
    $('#listSubCategoryIncidentKB{/literal}{$k}{literal}').on('bindingComplete', function (event) {
        $('#filterlistSubCategoryIncidentKB{/literal}{$k}{literal} input').click( function () {
            $('.listSubCategoryIncidentKB').hide();
            $('#listSubCategoryIncidentKB').show();
            $('#filterlistSubCategoryIncidentKB input').focus();
            $('#listMainCategoryIncidentKB').jqxListBox('selectIndex', 0 ); 
            $('#listMainCategoryIncidentKB').jqxListBox('ensureVisible', 0 ); 
        });
    });
    $('#listSubCategoryIncidentKB{/literal}{$k}{literal}').jqxListBox({ source: sourceSubIncidentKB{/literal}{$k}{literal}, width: '500px', height: '180px', searchMode: 'contains', filterable:true, filterPlaceHolder: 'Filter' });
    {/literal}{/foreach}{literal}
    
    if (scSelectedIdIncidentKB && scSelectedIdIncidentKB != '0') {
        
        $.each( sourceSubIncidentKB, function( i, item ) {
            if (scSelectedIdIncidentKB == item.value) {
                $('#listSubCategoryIncidentKB').jqxListBox('selectIndex', i ); 
                $('#listSubCategoryIncidentKB').jqxListBox('ensureVisible', i ); 
            }
        });
        
        $('#listMainSubCategoryIncidentKB').toggle();
        $('#requestForIncidentKBButton').hide();
    }
    
    $('.listSubCategoryIncidentKB').hide();
    $('#listSubCategoryIncidentKB').show();
    
});

function loadIncidentKB (id)
{
    $('#listIncidentKB').parent().addLoader();
    $('#listIncidentKB').load( '?cmd=supportcataloghandle&action=listIncidentKB&ticketId='+ ticketId 
        +'&catId='+ id, function() {
        $('#preloader').remove();
    });
}

function requestForIncidentKB (ticketId)
{
    $('#listIncidentKB').parent().addLoader();
    $.post('?cmd=supportcataloghandle&action=requestForIncidentKB', {ticketId: ticketId}, function (a) {
        parse_response(a);
        $('#preloader').remove();
        $('#replytable').unblock();
        $('#requestForIncidentKBButton').hide();
        displayServiceCatalogArea ('incidentDisplay');
        displayServiceCatalog();
        displayReplyTicketIfAssignedClient();
    });
    
    return false;
}

{/literal}
</script>
