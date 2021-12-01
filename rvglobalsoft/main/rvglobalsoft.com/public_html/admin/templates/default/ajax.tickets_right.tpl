<style type="text/css">
{literal}

#scTicketSummary {
    display: block;
    width: 100%;
    height: 150px;
    overflow: hidden;
    overflow-y: scroll;
    padding-right: 2px;
}

#scTicketAction {
    display: block;
    width: 100%;
    height: 150px;
    overflow: hidden;
    overflow-y: scroll;
    padding-right: 2px;
    resize: vertical;
}

#scTicketServiceCatalog {
    display: block;
    width: 100%;
    height: 350px;
    overflow: hidden;
    overflow-y: scroll;
    resize: vertical;
}

.navServiceCatalogFulfillment { list-style: none; margin:0px; padding:0px; text-align: left; }
.navServiceCatalogFulfillment li { 
    display:block; float: left; padding: 2px 10px 0 10px; font-size: 1.2em; margin-top: 5px; line-height: 1.6em;
    border-left: 1px dotted #428CB0; border-top: 1px dotted #428CB0;
    }
.navServiceCatalogFulfillment li a { text-decoration:none; color: #FFFFFF;}

.mmfeatured-c h2{font-size:19px;font-weight:400;margin:2px 0 10px}
.mmfeatured-c {-moz-border-radius:5px;background-color:#428CB0;border:4px solid #428CB0;border-radius:5px;clear:both;margin-bottom:10px}
.mmfeatured-d {-moz-border-radius:5px;background-color:#C0D9E5;border:4px solid #C0D9E5;border-radius:5px;clear:both;margin-bottom:10px}
.mmfeatured-e {-moz-border-radius:5px;background-color:#F7F7F7;border:4px solid #F7F7F7;border-radius:5px;clear:both;margin-bottom:10px}
.mmfeatured-f {-moz-border-radius:5px;background-color:#FFFBCC;border:4px solid #FFFBCC;border-radius:5px;clear:both;margin-bottom:10px}

#scTicketStaffLists { padding: 5px; }
#scTicketStaffLists ul { list-style: none; margin:0px; padding:0px; text-align: left; }
#scTicketStaffLists ul li { float: left; display: block; width: 100px; overflow: hidden; white-space: nowrap; }

#scTagsCont{
    position:relative;
    border: 1px solid #dfdfdf;
    margin: 10px 0 13px;
    padding: 4px 4px 2px;
    font: 11px/15px Arial,Helvetica,sans-serif;
    min-height:20px;
    cursor: text;
    background:#fff;
}

#scTagsCont .tag {
    background: url(img/bg_tag.png) repeat-x scroll left top #86AD09;
    border: 1px solid #5B831F;
    padding-left: 7px;
    margin:1px;
    display:block;
    float:left;
    color: white;
    border-radius: 8px 8px 8px 8px;
}
#scTagsCont .tag:hover {
    background-position: left bottom ;
}
#scTagsCont .tag a{
    white-space: nowrap;
    color: white;
    cursor: pointer;
}
#scTagsCont .tag a.cls{
    padding:3px 4px;
}
#scTicketFilterClientLists tr td { border-top: 1px dotted #AAAAAA; }

{/literal}
</style>

<div>
    <table width="100%" border="0" cellpadding="2" cellspacing="2">
    <tr valign="top">
        <td width="50%">
            
            <div id="scTicketSummary">
                <div class="mmfeatured-d">
                    <table width="100%" cellpadding="1" cellspacing="2">
                    <tr>
                        <td width="40%">{$lang.submitter}:</td>
                        <td>{$ticket.name|escape}</td>
                    </tr>
                    {if $ticket.email != $aClient.email}
                    <tr>
                        <td>{$lang.emaill|capitalize}:</td>
                        <td>{$ticket.email}</td>
                    </tr>
                    {/if}
                    <tr>
                        <td>CC:</td>
                        <td><span id="editCCEmailText">{if $ticket.cc}{$ticket.cc}{else}{$lang.none}{/if}</span> <a href="javascript:void(0);" onclick="$('#editCCEmail').parent().parent().show();">แก้ไข</a></td>
                    </tr>
                    <tr style="display: none;">
                        <td colspan="2">
                            <input type="text" id="editCCEmail" name="editCCEmail" value="{$ticket.cc}" style="width: 98%; line-height: 1.4em;" />
                            <div>
                                <a class="greenbtn menuitm menul" onclick="updateCCEmail();"><span> Apply </span></a>
                                <a class="menuitm menul" onclick="$('#editCCEmail').parent().parent().hide(); return false;"><span> Cancel </span></a>
                                ระบุหลายๆอีเมล์ได้ด้วยการใช้ , คั่น
                           </div>
                        </td>
                    </tr>
                    </table>
                </div>
                
                <div class="mmfeatured-d">
                    <table width="100%" cellpadding="1" cellspacing="2">
                    <tr>
                        <td width="40%">{$lang.asignedclient}:</td>
                        <td>
                            {if $aClient.id}
                            {$aClient.firstname|escape} {$aClient.lastname|escape}
                            {else}
                            none 
                            &nbsp; <a href="javascript:void(0);" onclick="$('#scTicketAssignClient').toggle();">เปลี่ยน</a>
                            &nbsp; <a href="?cmd=newclient" target="_blank">New</a>
                            {/if}
                            <span style="float: right; {if ! $aClient.id} display: none; {/if}">
                                <a href="javascript:void(0);" class="editTicket" onclick="{literal}$(this).hide().next().show(); scTicketEditDetail(); buildSelectboxChosen('#ticketOwnerId'); return false;{/literal}">Edit details</a>
                                <a href="javascript:void(0);" class="none" onclick="scTicketEditDetail(); return false;">Edit details</a>
                           </span>
                        </td>
                    </tr>
                    {if $aClient.id}
                    <tr>
                        <td>{$lang.emaill|capitalize}:</td>
                        <td>{$aClient.email}</td>
                    </tr>
                    <tr>
                        <td>Phone:</td>
                        <td>{$aClient.phonenumber}</td>
                    </tr>
                    <tr>
                        <td colspan="2">
                            {if $aClient.company} {$aClient.companyname} {/if}
                            <div>{$aClient.address1} {$aClient.city} {$aClient.state}</div>
                        </td>
                    </tr>
                    {else}
                    <tr id="scTicketAssignClient" class="none">
                        <td colspan="2">
                            <div class="mmfeatured-f">
                                <input type="text" id="scFilterClient" placeholder="ค้นจาก ชือลูกค้า โดเมน" style="width: 96%; border: 1px solid #CCCCCC;" />
                                <table id="scTicketFilterClientLists" width="100%" cellpadding="2" cellspacing="2" border="0"></table>
                            </div>
                        </td>
                    </tr>
                    {/if}
                    </table>
                </div>
                
            </div>
            
        </td>
        <td width="50%">
            
            <div id="scTicketAction">
                <div class="mmfeatured">
                    <p>
                        <a class="menuitm menul" onclick="scShowStaffLists(); return false;"><span> Assign To </span></a>
                        <a class="scTakeTicket greenbtn menuitm menul"><span class="addsth"> Take Ticket </span></a>
                        <a class="menuitm menul" id="staffMarkAsSpam" ><span style="color:red;"> Mark as SPAM </span></a>
                    </p>
                    
                    <div id="scTicketStaffLists" class="mmfeatured-f">
                        <input type="text" id="scFilterStaff" placeholder="ค้นหา staff" style="width: 96%; border: 1px solid #CCCCCC;" />
                        <div class="clearBoth">&nbsp;</div>
                        <ul>
                            {foreach from=$staff_members item=arr}
                            <li>
                                <label>
                                    <input type="checkbox" value="{$arr.id}" class="scticket_also_assign_to" {if in_array($arr.id, $aTagStaff)} checked="checked" {/if} title="{$arr.firstname}" />
                                    <img src="{if $arr.profile_picture_url != ''}{$arr.profile_picture_url}{else}{$template_dir}/img/sblock.png{/if}" width="14" />
                                    {$arr.firstname}
                                </label>
                            </li>
                            {/foreach}
                        </ul>
                        <div class="clearBoth">&nbsp;</div>
                        <a class="greenbtn menuitm menul" onclick="scTicketAssignToStaff();"><span> Apply </span></a>
                        <a class="menuitm menul" onclick="scHideStaffLists(); return false;"><span> Cancel </span></a>
                    </div>
                    
                    <div id="scTicketDisplayStaffLists">
                        <span>Assigned staff:</span>
                        <div id="scTagsCont">
                            {foreach from=$staff_members item=arr}
                            {if in_array($arr.id, $aTagStaff)}
                            <span class="tag">
                                <a>{$arr.firstname}</a> 
                                |<a class="cls" onclick="scTicketUnAssignTo({$arr.id}); $(this).parent().remove(); return false;">x</a>
                            </span>
                            {/if}
                            {/foreach}
                        </div>
                    </div>
                    
                </div>
                
                <div class="mmfeatured-e">
                    <table width="100%" cellpadding="1" cellspacing="2">
                    <tr>
                        <td width="40%">{$lang.department}:</td>
                        <td>
                            <strong id="deptName">{$ticket.deptname}</strong>
                            {if $ticket.dept_id != 16}
                            <a href="javascript:void(0);" onclick="$('#changeDepartment').toggle();">เปลี่ยน</a>
                            {/if}
                            <div id="changeDepartment" style="display: none;">
                                <select onchange="changeDept();">
                                {foreach from=$departments item=dept}
                                    <option value="{$dept.id}"  {if $ticket.deptname==$dept.name}selected="selected"{/if}>{$dept.name}</option>
                                {/foreach}
                                </select>
                            </div>
                        </td>
                    </tr>
                    <tr>
                        <td>{$lang.lastreply|capitalize}:</td>
                        <td>{$ticket.lastreply|date_format:'%d %b %Y'}</td>
                    </tr>
                    {if $ticket.senderip}
                    <tr>
                        <td>{$lang.IPaddress}:</td>
                        <td>{$ticket.senderip}</td>
                    </tr>
                    {/if}
                    </table>
                </div>
                
            </div>
            
        </td>
    </tr>
    </table>
</div>

    <div>
        <div style="background-color: #E0ECFF;">
            <ul class="navServiceCatalogFulfillment">
                
                <li style="background-color: #C0D9E5;"><a href="javascript:displayServiceCatalogArea('serviceRequestDisplay');">Service Request</a></li>
                <li style="background-color: #C0D9E5;"><a href="javascript:displayServiceCatalogArea('incidentDisplay');">Incident</a></li>
                <li class="change-management-tab" style="display: none; background-color: #C0D9E5;"><a href="javascript:displayServiceCatalogArea('changeManagementDisplay');">Change Management</a></li>
                <li style="background-color: #C0D9E5; display: none;"><a href="javascript:displayServiceCatalogArea('searchResultDisplay');">Search Result</a></li>
                <li style="background-color: #C0D9E5; display: none;">
                    <input type="text" id="searchKeyword"  name="searchKeyword" onclick="return searchServiceCatalog();" placeholder="ค้นหา service catalog, incident kb" class="styled inp" style="width:200px; height: 16px; margin-top: -3px;">
                </li>
            </ul>
            <a class="menuitm menul" onclick="expandServiceCatalog();" style="background-color: #E5E5E5; float: right; margin-top: 5px;"> <span style="color:red"> - ย่อ / + ขยาย </span> </a>
        </div>
    </div>
    
    <div style="background-color: #E0ECFF;">
        <div class="mmfeatured-c" style="margin-bottom: 0px;">
            <div id="scTicketServiceCatalog">
                <div id="seviceCatalogArea" class="mmfeatured-inner"></div>
            </div>
        </div>
    </div>
    
</div>




<script language="JavaScript">

{literal}
$(document).ready( function () {
    
    setTimeout(function () {
        $('#scTicketStart div[class="slide"] div[class*="tdetails"]').detach().appendTo('#scTicketSummary');
        //$('#scTicketSummary').append();
        setTimeout(function () {
            $('#scTicketSummary div[class*="tdetails"]').hide();
        }, 100);
    }, 500);
    
    $.getJSON('?cmd=supportcataloghandle&action=isEnableSupportCatalog', function (a) {
        var data        = a.data;
        var oDatas      = $.parseJSON(data);
        
        if (oDatas.isEnable == '1') {
            $('#seviceCatalogArea').parent().show();
            displayServiceCatalog();
        } else {
            $('#seviceCatalogArea').parent().hide();
        }
        
    });
    
    $('#scTicketStaffLists').hide();
    
    $('#scFilterStaff').keypress(function( event ) {
        if ( event.which == 13 ) {
            $(this).val('');
            $('#scTicketStaffLists ul li').show();
        }
    });
    
    $('#scFilterClient').keypress(function( event ) {
        if ( event.which == 13 ) {
            var query   = $(this).val();
            $('#scTicketAssignClient').parent().addLoader();
            $.get('?cmd=clienthandle&action=search', {keyword:query, extend:1}, function (data) {
                $('#preloader').remove();
                var codes   = {};
                if (data.indexOf("<!-- {") == 0) {
                    codes   = eval("(" + data.substr(data.indexOf("<!-- ") + 4, data.indexOf("-->") - 4) + ")");
                }
                $('#scTicketFilterClientLists tr').remove('');
                var numdata = 0;
                if (Object.keys(codes.DATA).length > 0) {
                    $.each(codes.DATA, function(key, value) {$.each(value, function(key2, value2) {
                        $('#scTicketFilterClientLists').append('<tr><td>'
                            +'<a href="javascript:void(0);" onclick="scTicketAssignClientApply('+ key2 
                            +')" class="greenbtn menuitm menul">Assign</a>' 
                            +'</td><td>'+ value2  +'</td></tr>');
                            numdata++;
                    });});
                }
                if (! numdata) {
                    $('#scTicketFilterClientLists').append('<tr><td colspan="2">--- ไม่พบข้อมูล ---</td></tr>');
                }
            });
            
        }
    });
    
    $('#scFilterStaff').keyup(function( event ) {
        var str         = $(this).val();
        if (str == '') {
            $('#scTicketStaffLists ul li').show();
            return;
        }
        $('#scTicketStaffLists ul li').hide();
        $('#scTicketStaffLists ul li:containsIN("'+ str +'")').show();
    });
    
    var isAssignLength      = $('#scTagsCont span').length;
    if (isAssignLength) {
        $('#autoUnassignArea').show();
    } else {
        $('#scTagsCont').parent().hide();
    }
    

    /* --- Take Ticket --- */
    $('.scTakeTicket').click(function () {
        var isTag       = $('#scTagsCont span a:containsIN("{/literal}{$admindata.firstname}{literal}")').length;
        if (isTag > 0) {
            return false;
        }
        $.post('?cmd=tickets&action=menubutton&make=assign', {tnum:{/literal}{$ticket.ticket_number}{literal}, id:{/literal}{$admindata.id}{literal}}, function (a) {
            parse_response(a);
            $('#autoUnassignArea').show();
            $('#autoUnassign').prop('checked', true);
            $('#scTagsCont').append('<span class="tag"><a>{/literal}{$admindata.firstname}{literal}</a>|<a onclick="scTicketUnAssignMe(); $(this).parent().remove(); return false;" class="cls">x</a></span>');
            scHideStaffLists();
            $('.scticket_also_assign_to[title="{/literal}{$admindata.firstname}{literal}"]').prop('checked', 'checked');
        })
        return false;
    })
    
    // --- ไม่ไส่ space ให้จะทำให้ UI เพี้ยน ---
    $('#editCCEmailText').html($('#editCCEmailText').text().replace(/,/g, ', '));
    
});

$.extend($.expr[":"], { "containsIN": function(elem, i, match, array) {
    return (elem.textContent || elem.innerText || "").toLowerCase().indexOf((match[3] || "").toLowerCase()) >= 0;
}});

function updateCCEmail ()
{
    $('#editCCEmail').parent().parent().hide();
    var query   = $('#editCCEmail').val();
    
    $('#scTicketSummary').parent().addLoader();
    $.post('?cmd=supporthandle&action=updateccemail', {
        ticketId    : {/literal}{$ticket.id}{literal},
        ccemail     : query
    }, function (a) {
        parse_response(a);
        $('#preloader').remove();
        $('#editCCEmailText').html(query.replace(/,/g, ', '));
    });
    
    return false;
}

function displayServiceCatalog ()
{
    $('#seviceCatalogArea').addLoader();
    $('.navServiceCatalogFulfillment').hide();
    $('#seviceCatalogArea').load( '?cmd=supportcataloghandle&action=displayServiceCatalog&ticketId={/literal}{$ticket.id}{literal}', function() {
        $('#preloader').remove();
        $('.navServiceCatalogFulfillment').show();
    });
}

function displayServiceCatalogArea (displayName)
{
    $('#serviceRequestDisplay, #incidentDisplay, #searchResultDisplay, #changeManagementDisplay').hide();
    $('#'+ displayName +'').show();
    $('.navServiceCatalogFulfillment li:lt(3)').css('background-color', '#C0D9E5');
    
    if (displayName == 'serviceRequestDisplay') {
        $('.navServiceCatalogFulfillment li:eq(0)').css('background-color', '#428CB0');
    }
    if (displayName == 'incidentDisplay') {
        $('.navServiceCatalogFulfillment li:eq(1)').css('background-color', '#428CB0');
    }
    if (displayName == 'changeManagementDisplay') {
        $('.navServiceCatalogFulfillment li').hide();
        $('.navServiceCatalogFulfillment li:eq(2)').show().css('background-color', '#428CB0');
    }
    if (displayName == 'searchResultDisplay') {
        $('.navServiceCatalogFulfillment li:eq(2)').css('background-color', '#428CB0');
    }
    
}

function tocNavigateToInside (obj)
{
    var selectedValue   = obj.options[obj.selectedIndex].value;
    if (selectedValue == '') {
        return false;
    }
    $('#scTicketServiceCatalog').animate({
        scrollTop:  $('#scTicketServiceCatalog').scrollTop() - $('#scTicketServiceCatalog').offset().top + $(''+ selectedValue +'').offset().top 
    }, 500);
    return false;
}

function scTicketAssignToStaff () {
    var to      = '0';
    $('.scticket_also_assign_to').each( function () {
        
        var str         = $(this).prop('title');
        var isTag       = $('#scTagsCont span a:containsIN("'+ str +'")').length;
        
        if ($(this).is(':checked')) {
            to  += ',' + $(this).val();
            if (! isTag) {
                $('#scTagsCont').append('<span class="tag"><a>'+ str +'</a>|<a onclick="scTicketUnAssignMe(); $(this).parent().remove(); return false;" class="cls">x</a></span>');
            }
            
        } else {
            if (isTag) {
                $('#scTagsCont span a:containsIN("'+ str +'")').parent().remove();
            }
            
        }
    });
    
    $('#scTicketAction').parent().addLoader();
    $.post('?cmd=supporthandle&action=alsoAssignTo', {
        ticketId    : {/literal}{$ticket.id}{literal},
        assignTo    : to,
        force       : 1
    },
    function (a) {
        parse_response(a);
        $('#preloader').remove();
        scHideStaffLists();
        if (to == '0') {
            $('#autoUnassignArea').hide();
        } else {
            $('#autoUnassignArea').show();
        }
    });
    
    return false;
}

function scShowStaffLists ()
{
    $('#scTicketStaffLists').show();
    $('#scTicketDisplayStaffLists').hide();
    
    $('#scTicketAction').css('height', '460px');
    $('#scTicketSummary').parent().css('width', '10%');
    $('#scTicketAction').parent().css('width', '90%');
    
    return false;
}

function scHideStaffLists ()
{
    $('#scTicketStaffLists').hide();
    $('#scTicketDisplayStaffLists').show();
    
    $('#scTicketAction').css('height', '150px');
    $('#scFilterStaff').val('');
    $('#scTicketStaffLists ul li').show();
    $('#scTicketSummary').parent().css('width', '50%');
    $('#scTicketAction').parent().css('width', '50%');
    
    return false;
}

function scTicketUnAssignTo (staffId)
{
    $('.scticket_also_assign_to[value="'+staffId+'"]').prop('checked', false);
    scTicketAssignToStaff();
    return false;
}

function scTicketUnAssignMe ()
{
    $('#scTicketAction').parent().addLoader();
    $.post('?cmd=supporthandle&action=unassign', {
        ticketId    : {/literal}{$ticket.id}{literal}
    }, function (a) {
        parse_response(a);
        $('#preloader').remove();
    });
    
    return false;
}

function scTicketEditDetail ()
{
    $('#scTicketSummary div.mmfeatured-d').hide();
    $('#scTicketSummary div.tdetails').show();
}

function scHideEditDetail ()
{
    $('#scTicketSummary div.mmfeatured-d').show();
    $('#scTicketSummary div.tdetails').hide();
}

function scUpdateEditDetail ()
{
    $('#scTicketSummary').parent().addLoader();
}

var iAssignClient;
function scTicketAssignClientApply (clientId)
{
    $('#scTicketSummary').parent().addLoader();
    buildTicketOwnerEmail(clientId);
    
    iAssignClient       = setInterval(function(){
        if (isBuildTicketOwnerEmail) {
            scTicketAssignClientApplySend(clientId);
        }
    }, 1000);
    
    return false;
}

function scTicketAssignClientApplySend (clientId)
{
    clearInterval(iAssignClient);
    
    //$('#submitterTicketEmail').val(oClient.email);
    //$('#ccTicketEmail').val
    $('#ticketOwnerId').html('<option value="'+ clientId +'">Processing...</option>');
    
    // From /admin/templates/default/js/packed.js.unpack.js
    ajax_update('?cmd=tickets&action=menubutton&make=edit_ticket&' + $('input, select, textarea, button', '.tdetails').serialize(), {ticket_number: $('#ticket_number').val()}, function(data) {
        ajax_update('?cmd=tickets&action=view&list=all&num=' + $('#ticket_number').val(), {brc:$('#backredirect').val()}, '#bodycont');
    });
    
}

function changeDept ()
{
    var deptId      = $('#changeDepartment select option:selected').val();
    var deptName    = $('#changeDepartment select option:selected').text();
    $('#deptName').text(deptName);
    
    $('#scTicketAction').parent().addLoader();
    $.post('?cmd=supporthandle&action=updatedept', {
        ticketId    : {/literal}{$ticket.id}{literal},
        deptId      : deptId
    }, function (a) {
        parse_response(a);
        $('#preloader').remove();
        $('#changeDepartment').toggle();
        $('select[name="deptid"] option[value="'+ deptId +'"]').prop('selected', true);
    });
    
}

function expandServiceCatalog_ext (status)
{
    if (status) {
        $('#scTicketServiceCatalog').css('height', '600px');
        $('#scTicketSummary, #scTicketAction').hide();
    } else {
        $('#scTicketServiceCatalog').css('height', '400px');
        $('#scTicketSummary, #scTicketAction').show();
    }
}

function searchServiceCatalog ()
{
    
}

{/literal}
</script>

