    {if $tickets}
        {if $showall}
        
        <style type="text/css">
        {literal}
        #testform a { font-size: 13px;}
        {/literal}
        </style>
        
            <form action="" method="post" id="testform">
                <div class="bottom-fixed" style="display:none">
                    <div style="position: relative;  {if ! isset($admindata.access.closeSupportTicket) && ! isset($admindata.access.deleteSupportTicket)} display:none; {/if}">
                    <a href="#" class="menuitm hasMenu" id="bulk_macro" onclick="{literal}setTimeout(function(){var a = -$('#bulk_macro_m').height();$('#bulk_macro_m').css('top',a);},300){/literal}">{$lang.applymacro}: <span class="morbtn">{$lang.none}</span><input type="hidden" name="bulk_macro"/></a>
                    <a href="#" class="menuitm hasMenu" id="bulk_dept" onclick="{literal}setTimeout(function(){var a = -$('#bulk_dept_m').height();$('#bulk_dept_m').css('top',a);},300){/literal}">{$lang.department}: <span class="morbtn">{$lang.nochange}</span><input type="hidden" name="bulk_dept"/></a>
                    <a href="#" class="menuitm hasMenu" id="bulk_priority" onclick="{literal}setTimeout(function(){var a = -$('#bulk_priority_m').height();$('#bulk_priority_m').css('top',a);},300){/literal}">{$lang.setpriority}: <span class="morbtn">{$lang.nochange}</span><input type="hidden" name="bulk_prio"/></a>
                    <a href="#" class="menuitm hasMenu" id="bulk_status"  onclick="{literal}setTimeout(function(){var a = -$('#bulk_status_m').height();$('#bulk_status_m').css('top',a);},300){/literal}" >{$lang.status}: <span class="morbtn">{$lang.nochange}</span><input type="hidden" name="bulk_status"/></a>
                    <a href="#" class="menuitm hasMenu" id="bulk_owner" onclick="{literal}setTimeout(function(){var a = -$('#bulk_owner_m').height();$('#bulk_owner_m').css('top',a);},300){/literal}">{$lang.assignto}: <span class="morbtn" >{$lang.nochange}</span><input type="hidden" name="bulk_owner"/></a>
                    
                    {if $agreements}
                    <a href="#" class="menuitm hasMenu" id="bulk_share" onclick="{literal}setTimeout(function(){var a = -$('#bulk_share_m').height();$('#bulk_share_m').css('top',a);},300){/literal}">{$lang.sharewith}: <span class="morbtn">{$lang.nochange}</span><input type="hidden" name="bulk_share"/></a>
                    {/if}
                    <br />
                    <div class="left ticketsTags" style="position:relative; width:400px;line-height: 14px; padding: 1px 0 0 5px; border: 1px solid #ddd; background: #fff; margin-right: 3px; overflow: visible">
                        <label style="position:relative" for="tagsin" class="input">
                            <em style="position:absolute">{$lang.tags}</em>
                            <input id="tagsin" autocomplete="off" style="width: 80px">
                            <ul style="overflow-y:scroll; max-height: 100px; bottom: 21px; left: -7px"></ul>
                        </label>
                    </div>
                    <div id="bulk_tags" style="display: none"></div>
                    
                    
                    <input type="checkbox" onchange="$(this).next().slideToggle(); if(!$('#bulk_status input').val().length) dropdown_handler('Answered', $('#bulk_status'), null, $('#bulk_status_m').find('a[href=Answered]').html());" name="bulk_reply"/> {$lang.addreply} 
                    <textarea style="width: 99%; display: none" name="bulk_message"></textarea>
                    <a name="bulk_actions" rel=".bottom-fixed form" href="#" class="submiter menuitm greenbtn" onclick="$(this).parents('.bottom-fixed').slideUp('fast');">Apply to selected</a>
                    
                    <ul id="bulk_macro_m" class="ddmenu" load="?cmd=predefinied&action=getmacros">
                        <li><a href="0">{$lang.none}</a></li>
                        {foreach from=$macros item=macro}
                            <li><a href="{$macro.id}">{$macro.name}</a></li>
                        {/foreach}
                    </ul>
                    <ul id="bulk_dept_m" class="ddmenu">
                        <li><a href="0">{$lang.nochange}</a></li>
                        {foreach from=$myDepartments item=dept}
                            {if $dept.id}
                            <li><a href="{$dept.id}">{$dept.name}</a></li>
                            {/if}
                        {/foreach}
                    </ul>
                    <ul id="bulk_priority_m" class="ddmenu">
                        <li><a href="">{$lang.nochange}</a></li>
                        <li class="opt_low" ><a href="0">{$lang.Low}</a></li>
                        <li class="opt_medium" ><a href="1">{$lang.Medium}</a></li>
                        <li class="opt_high"><a href="2">{$lang.High}</a></li>
                    </ul>
                    <ul id="bulk_status_m" class="ddmenu">
                        <li><a href="">{$lang.nochange}</a></li>
                        {foreach from=$statuses item=status}
                        <li><a href="{$status}">{$lang.$status}</a></li>
                        {/foreach}
                    </ul>
                    <ul id="bulk_owner_m" class="ddmenu" >
                        <li><a href="0">{$lang.nochange}</a></li>
                        {foreach from=$staff_members item=stfmbr}
                            <li><a href="{$stfmbr.id}">{$stfmbr.firstname} {$stfmbr.lastname}</a></li>
                        {/foreach}
                    </ul>
                    <ul id="bulk_share_m" class="ddmenu">
                        <li><a href="0">{$lang.nochange}</a></li>
                        {foreach from=$agreements item=agreement}
                            <li><a href="{$agreement.uuid}">{$lang.sharewith} #{$agreement.tag}</a></li>
                        {/foreach}
                    </ul>
                    </div>
                {literal}
                    <script type="text/javascript">
                    $(function () {
                        $('.bottom-fixed .hasMenu').dropdownMenu({}, function (a, o, p, h) {
                            dropdown_handler(a, o, p, h)
                        });
                    });
                    ticket.bindTagsActions('.bottom-fixed .ticketsTags', 0,
                        function (tag) {
                            $('#bulk_tags').append('<input type="hidden" name="bulk_tags[]" value="' + tag.replace(/"/g,'&quote;') + '" />');
                            repozition();
                        },
                        function (tag) {
                            repozition();
                            $('#bulk_tags input[value="' + tag + '"]').remove();
                        }
                    );

                    $('#testform').undelegate('input.check, #checkall', 'change').delegate('input.check, #checkall', 'change', showhide_bulk);
                    if(!$('.bottom-fixed').data('check')){
                        $(document).ajaxStop(showhide_bulk);
                        $('.bottom-fixed').data('check', true);
                    }
                    </script>
                {/literal}
            </div>
                <input type="hidden" value="{$totalpages}" name="totalpages2" id="totalpages"/>
                <div class="blu">
                    <div class="left menubar">
                        {$lang.withselected}
                        <a   class="submiter menuitm menuf confirm" name="markmerged"   href="#" ><span >{$lang.Merge}</span></a><a   class="submiter menuitm menuc" name="markasread"  href="#" ><span >{$lang.markasread}</span></a>{if isset($admindata.access.closeSupportTicket)}<a   class="menuitm menuc" name="markasspam"  href="#" ><span >Mark as spam</span></a><a   class="submiter menuitm menuc" name="markclosed"  href="#" ><span >{$lang.Close}</span></a>{/if}{if isset($admindata.access.deleteSupportTicket)}<a   class="submiter menuitm confirm menul" name="markdeleted" href="#" ><span style="color:#FF0000">{$lang.Delete}</span></a>{/if}

                    </div>
                    <div class="right">
                        <div class="pagination"></div>
                    </div>
                    <div class="clear"></div>

                </div>
                {if $tview}
                    <a href="?cmd={$cmd}&tview={$tview.id}" id="currentlist" style="display:none" updater="#updater"></a>
                {else}
                    <a href="?cmd=tickets&list={$currentlist}{if $currentdept}&dept={$currentdept}{/if}{$assigned}" id="currentlist" style="display:none" updater="#updater"></a>
                {/if}
                <table cellspacing="0" cellpadding="3" border="0" width="100%" class="glike hover" style="table-layout: fixed;">
                    <tbody>
                        <tr>
                            {if $tview}
                                {include file="ajax.ticketviews.tpl" display=theaders}
                            {else}
                            <th width="20"><input type="checkbox" id="checkall"/></th>
                                <th width="190"><a href="?cmd=tickets&list={$currentlist}{if $currentdept}&dept={$currentdept}{/if}{$assigned}&orderby=name|ASC"  class="sortorder">{$lang.Client}</a></th>
                                <th class="subjectlineth"><a href="?cmd=tickets&list={$currentlist}{if $currentdept}&dept={$currentdept}{/if}{$assigned}&orderby=subject|ASC"  class="sortorder">{$lang.Subject}</a></th>
                            <th class="tagnotes"></th>
                                <th width="100"><a href="?cmd=tickets&list={$currentlist}{if $currentdept}&dept={$currentdept}{/if}{$assigned}&orderby=status|ASC"  class="sortorder">{$lang.Status}</a></th>
                                <th width="120"><a href="?cmd=tickets&list={$currentlist}{if $currentdept}&dept={$currentdept}{/if}{$assigned}&orderby=rp_name|ASC"  class="sortorder">{$lang.lastreplier}</a></th>
                                <th  width="110" class="lastelb"><a href="?cmd=tickets&list={$currentlist}{if $currentdept}&dept={$currentdept}{/if}{$assigned}&orderby=priority DESC,t.lastreply|ASC"  class="sortorder">{$lang.Lastreply}</a></th>
                            {/if}
                        </tr>
                    </tbody>
                
                {if $isAssignedView && $howToList == 'all'}
                <tr>
                    <td colspan="7" style="background-color: #E9E9E9;"><h1  style="font-size: 1em; margin: 1px; padding: 1px;" title="My Open and Client-reply Tickets (รวมที่ assign โดยตรง หรือ ให้รับผิดชอบร่วม แต่ไม่เอา spam*)">My Open and Client-reply Tickets</h1></td>
                </tr>
                {/if}
                
                    <tbody id="updater">

                    {/if}
                    {include file="support/poll.tpl"}
                    {literal}
                    <script type="text/javascript"> 
                            var tdwidth=notew=0;$(".hasnotes").length&&(notew=$(".hasnotes").outerWidth(!0)),$(".tagnotes").each(function(){var a=0;$(this).children().each(function(){a+=$(this).outerWidth(!0)}),a>tdwidth&&(tdwidth=a)}),$(".tagnotes").width(tdwidth+notew)
                    </script> 
                    {/literal}
                    {if $showall}
                    </tbody>
                    <tbody id="psummary" {if !$tview} style="display: none;" {/if}>
                        <tr>
                            <th></th>
                            <th {if $tview}colspan="{$columns_count+1}"{else}colspan="6"{/if}>
                                {$lang.showing} <span id="sorterlow">{$sorterlow}</span> - <span id="sorterhigh">{$sorterhigh}</span> {$lang.of} <span id="sorterrecords">{$sorterrecords}</span>
                            </th>
                        </tr>
                    </tbody>
                </table>
                
            
            {if $isAssignedView && $howToList == 'all'}
            <table cellspacing="0" cellpadding="3" border="0" width="100%" class="glike hover" style="table-layout: fixed;">
            <tr>
                <td colspan="7" style="background-color: #EDF4F8;">
                    <br /><br />
                    <div id="createNewTicketLink" align="center" onmouseover="$('#createChangeTicketLink').show();" style="margin-left:10px; float:left; display: block; width: 80px; margin-right: 10px; background-color: #FBB450; position:relative; border:1px solid #ddd; padding:2px;">
                        <a href="javascript:void(0);" onclick="{literal}createNewTicket();return false;{/literal}" style="color: #FFFFFF;"><strong>สร้าง Ticket</strong></a>
                    </div>
                    <div id="createChangeTicketLink" align="center" style="margin-left:5px; float:left; display: block; width: 120px; margin-right: 10px; background-color: #F9371D; position:relative; border:1px solid #ddd; padding:2px;">
                        <a href="javascript:void(0);" onclick="{literal}createChangeTicket();return false;{/literal}" style="color: #FFFFFF;"><strong>สร้าง Change Ticket</strong></a>
                    </div>
                    <div id="myFulfillmentTicketTotal" style="float:right; display: block; width: 100px; margin-right: 5px; background-color: #3A87AD; position:relative; border:1px solid #ddd; padding:2px;">
                        <a href="?cmd=tickets&list=Fulfillment&showall=true" style="color: #FFFFFF;"><strong>All Fulfillment ({$allFulfillmentTicketTotal})</strong></a>
                    </div>
                    <div id="myScheduleTicketTotal" style="float:right; display: block; width: 100px; margin-right: 5px; background-color: #3A87AD; position:relative; border:1px solid #ddd; padding:2px;">
                        <a href="?cmd=tickets&list=Scheduled&showall=true&assigned=true" style="color: #FFFFFF;"><strong>My Scheduled ({$myScheduleTicketTotal})</strong></a>
                    </div>
                    <div id="totalChangeManagement" style="float:right; display: block; width: 100px; margin-right: 5px; background-color: #3A87AD; position:relative; border:1px solid #ddd; padding:2px;">
                        <a href="?cmd=tickets&dept=16&list=all&showall=true" style="color: #FFFFFF;"><strong>All Change ({$totalChangeManagement})</strong></a>
                    </div>
                    <div class="right" style="display: block; margin-right: 10px; position:relative; ">
                        <table width="550" border="0" cellspacing="1" cellpadding="2">
                        <tr>
                            <td><strong>Performance</strong></td>
                            <td style="text-align: center;"><strong>3.1.1</strong></td>
                            <td style="text-align: center;"><strong>3.2.1</strong></td>
                            <td style="text-align: center;"><strong>3.3.1</strong></td>
                            <td style="text-align: center;"><strong>3.4.1</strong></td>
                        </tr>
                        <tr>
                            <td><strong>My</strong></td>
                            <td id="perform_1_1" align="right"></td>
                            <td id="perform_2_1" align="right"></td>
                            <td id="perform_3_1" align="right"></td>
                            <td id="perform_4_1" align="right"></td>
                        </tr>
                        <tr>
                            <td><strong>Team</strong></td>
                            <td id="perform_1_2" align="right"></td>
                            <td id="perform_2_2" align="right"></td>
                            <td id="perform_3_2" align="right"></td>
                            <td id="perform_4_2" align="right"></td>
                        </tr>
                        <tr>
                            <td><strong>Organize</strong></td>
                            <td id="perform_1_3" align="right"></td>
                            <td id="perform_2_3" align="right"></td>
                            <td id="perform_3_3" align="right"></td>
                            <td id="perform_4_3" align="right"></td>
                        </tr>
                        </table>
                        <div style="background-color: #F7F2D8; padding: 5px;">
                             จำนวนนาที (เทียบกับเดือนที่แล้ว <span style="color:green;">-ลดลง</span> <span style="color:red;">+เพิ่มขึ้น</span> เท่าไร, เดือนก่อนหน้า) / จำนวน record เดือนปัจจุบัน<br />
                             3.1.1 - Average service request response time<br />
                             3.2.1 - Average service request resolve time<br />
                             3.3.1 - Average incident response time<br />
                             3.4.1 - Average incident resolve time<br />
                        </div>
                    </div>
                    <div class="styled-select" style="display: none;">
                        <select id="addDashboardView">
                            <option value="">เพิ่ม view หน้านี้</option>
                        </select>
                    </div>
                    
                    <script type="text/javascript">
                    {literal}
                    $(document).ready(function() {
                        
                        $.get('?cmd=matrixslahandle&action=getPerformance', function (data) {
                            var codes   = {};
                            if (data.indexOf("<!-- {") == 0) {
                                codes   = eval("(" + data.substr(data.indexOf("<!-- ") + 4, data.indexOf("-->") - 4) + ")");
                            }
                            $.each(codes.DATA[0], function (k, v) {
                                $.each(v, function (k1, v1) {
                                    $('#perform_'+k+'_'+k1).html(v1);
                                });
                            });
                            
                        });
                        
                        //$('#myScheduleTicketTotal').badger('{/literal}{$myScheduleTicketTotal}{literal}');
                        //$('#myFulfillmentTicketTotal').badger('{/literal}{$myFulfillmentTicketTotal}{literal}');
                        
                        $('a[href^="?cmd=ticketviews&tview="]').each( function () {
                            $('#addDashboardView').append(new Option($(this).text(), $(this).attr('href')));
                        });
                        
                        $('#addDashboardView').change( function () {
                            $.post('?cmd=supporthandle&action=addViewToDashboard', {
                                view   : $(this).val()
                            },
                            function (a) {
                                parse_response(a);
                            });
                        });
                        
                        $('.loadViewId').each( function () {
                            var loadUrlId     = $(this).attr('title');
                            $.get('?cmd=ticketviews&tview=' + loadUrlId, function (data) {
                                var resHtml         = $('<table>'+ data +'</table>');
                                var resRows         = resHtml.find('tr');
                                
                                if (resRows.length > 0) {
                                    resRows.each( function (i) {
                                        if (i > 14) {
                                            $('<tr><td colspan="7"><div align="center"><a href="?cmd=ticketviews&tview='+ loadUrlId +'" style="color:red;">View นี้มี ticket ที่ไม่ได้แสดงหน้านี้อยู่อีก คลิกเพื่อดูเพิ่ม</a></div></td></tr>').insertAfter('.loadViewId[title="'+ loadUrlId +'"]');
                                            return false;
                                        }
                                        $(this).find('td:gt(6)').hide();
                                        $('<tr>'+ $(this).html() +'</tr>').insertBefore('.loadViewIdEnd[title="'+ loadUrlId +'"]');
                                    })
                                }
                                
                            });
                        });
                        
                        /* --- แสดงจำนวนที่ฝั่งซ้ายมือ --- */
                       {/literal}
                       {if isset($totalOpenAndClientReply) && $totalOpenAndClientReply > 0}
                       $('#ticketsn_my').html('('+{$totalOpenAndClientReply}+')').show();
                       {/if}
                       {literal}
                        
                        // --- ย้าย badge summary ---
                        setTimeout( function () {
                            $('#createNewTicketLink').appendTo($('#badgeSummary'));
                            $('#createChangeTicketLink').appendTo($('#badgeSummary'));
                            $('#myFulfillmentTicketTotal').appendTo($('#badgeSummary'));
                            $('#myScheduleTicketTotal').appendTo($('#badgeSummary'));
                            $('#totalChangeManagement').appendTo($('#badgeSummary'));
                        }, 1000);
                        
                    });
                    {/literal}
                    </script>
                </td>
            </tr>
            </table>
            {/if}
            
                
                <div class="blu">
                    <div class="right">
                        <div class="pagination"></div>
                    </div>
                    <div class="left menubar">

                        {$lang.withselected}
                        <a   class="submiter menuitm menuf" name="markmerged"   href="#" ><span >{$lang.Merge}</span></a><a   class="submiter menuitm menuc" name="markasread"  href="#" ><span >{$lang.markasread}</span></a>{if isset($admindata.access.closeSupportTicket)}<a   class="menuitm menuc" name="markasspam"  href="#" ><span >Mark as spam</span></a><a   class="submiter menuitm menuc" name="markclosed"  href="#" ><span >{$lang.Close}</span></a>{/if}{if isset($admindata.access.deleteSupportTicket)}<a   class="submiter menuitm confirm menul" name="markdeleted" href="#" ><span style="color:#FF0000">{$lang.Delete}</span></a>{/if}

                    </div>
                    <div class="clear"></div>
                </div>
                {securitytoken}
            </form>
            {if $ajax}
                <script type="text/javascript">bindEvents();</script>
            {/if}
        {/if}
        {if $ajax}
            <script type="text/javascript">bindTicketEvents();</script>
            

                <script type="text/javascript">
                {literal}
                $(document).ready(function() {
                    sorterUpdate({/literal}{$sorterlow},{$sorterhigh},{$sorterrecords}{literal});
                    
                    $('a[name="markasspam"]').unbind('click').click( function () {
                
                        var macroId = $('#bulk_macro_m li a').filter(':contains("spam")').attr('href');
                        
                        if (macroId) {
                            $('#bulk_tags').append('<input type="hidden" name="bulk_tags[]" value="spam" />');
                            $('input[name="bulk_status"]').val('Closed');
                            $('input[name="bulk_macro"]').val(''+ macroId +'');
                            
                            var pageNo  = '&page=' + (parseInt($('.pagination span.current').eq(0).html()) - 1);
                            var pUrl    = $('#currentlist').attr('href') + pageNo + '&' + $('#testform').serialize()+ '&bulk_actions';
                            
                            // bulk_actions is important
                            $.post(pUrl, {stack: ''}, function (data) {
                                var result  = parse_response(data);
                                if (result) {
                                    $("#updater").html(result);
                                }
                                $('.check').unbind('click').click(checkEl);
                            });
                            
                        } else {
                            alert('Invalid spam macro id.');
                        }
                
                        return false;
                    });
                    
                });
                {/literal}
                </script>

            
        {/if}
    {else}
        {if $showall}
            <div id="blank_state" class="blank_state blank_news" style="padding:0 15px ">
                <div class="blank_info">
                        {if !$enableFeatures.support}
                            <h1>Feature not enabled on your system</h1>
                        {elseif $assigned}
                        <h1>{$lang.nothingtodisplay}</h1>
                        {$lang.nothing_assigned}
                    {elseif $currentdept=='all'}
                        <h1>{$lang.nothingtodisplay}</h1>
                        {$lang.nothing_here}  
                        <div class="clear"></div>
                        <a style="margin-top:10px" href="?cmd=supporthandle&action=createticket&redirect=1" class="new_add new_menu"><span>{$lang.opensupticket}</span></a>
                        <!-- <a style="margin-top:10px" href="?cmd=tickets&action=new" class="new_add new_menu"><span>{$lang.opensupticket}</span></a> -->
                    {else}
                        <h1>{$lang.nothingtodisplay}</h1>
                        {$lang.nothing_indept}
                    {/if}
                </div>
                <script type="text/javascript">var he = $('#blank_state').height()/ 2; $('#blank_state').css('padding-top', ($('#blank_state').parent().parent().height()/2) - he).css('padding-bottom', ($('#blank_state').parent().parent().height()/2) - he)</script>
            </div>
        {else}
            <tr>
                <td colspan="7"><p align="center" >{$lang.nothingtodisplay}</p></td>
            </tr>
        {/if}
    {/if}
