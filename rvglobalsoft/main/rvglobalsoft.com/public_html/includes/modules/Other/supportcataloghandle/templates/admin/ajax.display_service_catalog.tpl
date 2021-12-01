<link href="../includes/modules/Other/supportcataloghandle/templates/css/style.css?v={$unixTime}" rel="stylesheet" media="all" />
<link href="../7944web/templates/default/js/jqwidgets/styles/jqx.base.css" rel="stylesheet" media="all" />
<script type="text/javascript" src="../7944web/templates/default/js/jqwidgets/jqxcore.js"></script>
<script type="text/javascript" src="../7944web/templates/default/js/jqwidgets/jqxbuttons.js"></script>
<script type="text/javascript" src="../7944web/templates/default/js/jqwidgets/jqxscrollbar.js"></script>
<script type="text/javascript" src="../7944web/templates/default/js/jqwidgets/jqxlistbox.js"></script>
<script type="text/javascript" src="../7944web/templates/default/js/jquery.scrollTo.min.js"></script>
<script type="text/javascript" src="../7944web/templates/default/js/jquery.countdown.min.js"></script>



<div id="serviceTypeDisplay">
    <div id="serviceRequestDisplay"></div>
    <div id="incidentDisplay"></div>
    <div id="changeManagementDisplay"></div>
    <div id="searchResultDisplay"></div>
</div>
<div class="clearBoth"></div>

<script language="JavaScript">

var ticketId        = {$ticketId};
var requestType     = '{$requestType}';

{literal}

$(document).ready(function () {
    $('#serviceRequestDisplay, #incidentDisplay, #changeManagementDisplay, #searchResultDisplay').hide();
    
    displayReplyTicketByRequestType(requestType);
    displayRequestType();
    
    if (requestType == 'Service Request') {
        displayServiceCatalogArea ('serviceRequestDisplay');
    } else if (requestType == 'Incident') {
        displayServiceCatalogArea ('incidentDisplay');
    }else if (requestType == 'Change') {
        displayServiceCatalogArea ('changeManagementDisplay');
    }
    
});

function displayReplyTicketByRequestType (requestType)
{
    if (requestType == '') {
        $('#replytable').block({ message: '<p>เลือก Request type ว่าเป็น Service Request หรือ Incident ก่อนถึงจะสามารถตอบ ticket ได้</p>' }); 
    } else {
        displayReplyTicketIfAssignedClient();
    }
}

function selectRequest (requestType)
{
    $.post('?cmd=supportcataloghandle&action=selectRequest', {
        ticketId    : ticketId,
        requestType : requestType
        }, function (a) {
            parse_response(a);
            $('#replytable').unblock();
            var displayName = 'serviceRequestDisplay';
            if (requestType == 'Incident') {
                displayName = 'incidentDisplay';
            }
            displayServiceCatalogArea (displayName);
            displayReplyTicketIfAssignedClient();
        });
}

function displayRequestType ()
{
    $('#serviceRequestDisplay').block({ message: '<p>Loading service catalog ...</p>' }); 
    $('#serviceRequestDisplay').load( '?cmd=supportcataloghandle&action=displayServiceRequest&ticketId='+ ticketId, function() {
        $('#serviceRequestDisplay').unblock();
    });
    
    $('#incidentDisplay').block({ message: '<p>Loading incident ...</p>' }); 
    $('#incidentDisplay').load( '?cmd=supportcataloghandle&action=displayIncidentKB&ticketId='+ ticketId, function() {
        $('#incidentDisplay').unblock();
    });
    
    $('#changeManagementDisplay').block({ message: '<p>Loading change management ...</p>' }); 
    $('#changeManagementDisplay').load( '?cmd=supportcataloghandle&action=displayChangeManagement&ticketId='+ ticketId, function() {
        $('#changeManagementDisplay').unblock();
    });
    
    $('#searchResultDisplay').block({ message: '<p>Loading search result ...</p>' }); 
    $('#searchResultDisplay').load( '?cmd=supportcataloghandle&action=displaySearchResult&ticketId='+ ticketId, function() {
        //$('#searchResultDisplay').unblock();
    });
    
}

function displayReplyTicketIfAssignedClient ()
{
    $.getJSON('?cmd=supportcataloghandle&action=isAssignClient&ticketId='+ ticketId, function (a) {
        var data        = a.data;
        var oDatas      = $.parseJSON(data);
        
        if (typeof oDatas.client_id != 'undefined' && oDatas.client_id > 0) {
            $('#ticketReplyForm').unblock();
        } else {
            $('#ticketReplyForm').block({ message: '<p>เลือก Client หรือสร้าง Client Profile ใหม่ กรณีที่ยังไม่มีข้อมูล ก่อนถึงจะสามารถตอบ ticket ได้</p>' 
                + '<p>หากยังไม่สามารถระบุ client ได้ <a href="javascript: $(\'#ticketReplyForm\').unblock();;void(0);"><span style="color: #FF0000;">คลิกที่นี่เพื่อขอตอบ ticket ลูกค้าก่อน</span></a></p>' });
        }
        
    });
}

{/literal}
</script>