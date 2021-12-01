{php}
$templatePath   = $this->get_template_vars('template_path');
include($templatePath . 'ajax.tickets.tpl.php');
{/php}

{if $showlog}
    <div class="right"><strong><a href="javascript:void(0)" onclick="$('#ticket_log').hide();">{$lang.Hide}</a></strong></div>
    <div class="clear"></div>
    <table border="0" width="100%" class="tlog">
        {foreach from=$showlog item=log}
            <tr>
                <td class="light" align="right" width="140">{$log.date|dateformat:$date_format}</td>
                <td>{$log.action}</td>
            </tr>
        {/foreach}
    </table>
{/if}
{if $quote}
    {$quote}
{elseif $draftdate}
    {$lang.draftsavedat}{$draftdate|dateformat:$date_format}
{/if}
{if $action=='menubutton' && $make=='poll'}
    {include file="support/poll.tpl"}
{elseif $action=='view' && $ticket}
    {include file="support/ticket.tpl"}
{elseif $action=='new'}
    {include file="support/create.tpl"}
{elseif $action=='clientfilter'}
    {include file="support/ajax.clientfilter.tpl"}
{elseif $action=='default'}
    {include file="support/list.tpl"}
{elseif $action=='menubutton' && $make=='getrecent'}
    {if $reply}
        <div class="ticketmsg{if $reply.type!='Admin'} ticketmain{/if}" id="reply_{$reply.id}"><input type="hidden" name="viewtime" class="viewtime" value="{$reply.viewtime}"/>
            <div class="left">
                {if $reply.type!='Admin' && $ticket.client_id}
                    <a href="?cmd=clients&action=show&id={$ticket.client_id}" target="_blank">
                    {/if}
                    <strong {if $reply.type=='Admin'}class="adminmsg"{else}class="clientmsg reply_{$reply.type}"{/if}>
                        {$reply.name}</strong> 
                        {if $reply.type!='Admin' && $ticket.client_id}
                    </a>
                {/if}
                {if $reply.type=='Admin'}
                    {$lang.staff}
                {elseif $reply.replier_id!='0'}
                    {$lang.client}
                {/if}, {$lang.wrote}
            </div>

            <div class="right">{$lang.replied} {$reply.date|dateformat:$date_format}&nbsp;&nbsp;&nbsp;</div>
            <div class="clear"></div>
            <p> {$reply.body|httptohref|nl2br} </p>
        </div>
    {/if}
{elseif $action=='menubutton' && $make=='editreply'}
    <p id="msgbody{$reply.id}">{$reply.newbody|httptohref|regex_replace:"/[^\S\n]+\n/":"<br>"|nl2br}</p>
    <div class="editbytext fs11" style="color:#555; font-style: italic">{$lang.lastedited} {$reply.editby} at {$reply.lastedit|dateformat:$date_format}</div>
    <script>
        var body = $('#msgbody{$reply.id}'),
            status = body.parent().data('status');
        if (status === 'Scheduled')
            body.css('opacity', 0.7);
    </script>
{elseif $action=='menubutton' && $make=='loadnotes'}
    {if $adminnotes}
        {foreach from=$adminnotes item=entry name=adminnt}
            <tr class="admin-note {if $smarty.foreach.adminnt.index%2!=0}odd{/if}">
                <td class="first">{$entry.date|dateformat:$date_format}</td>
                {assign var='admincolor' value=$entry.color%17}
                <td>
                    <small class="right" ><a href="#{$entry.id}" class="ticketnotesremove">[{$lang.Remove}]</a></small>
                    <strong class="admincolor{$admincolor}" style="color:#{if $ucolors.$admincolor}{$ucolors.$admincolor}{else}000{/if}">{$entry.name} 
                        <a href="javascript:void(0);" onclick="{literal}$('html, body').animate({ scrollTop: $('#notesId{/literal}{$entry.id}{literal}').offset().top}, 500);return false;{/literal}" title="เลื่อนไปดูข้อมูลที่เกี่ยวข้อง">note</a> 
                    </strong>  
                    <div id="noteExpand{$entry.id}" class="admin-note-body">{$entry.note|escape:'html':'UTF-8'|httptohref:'html'}</div>
                    {if !empty($entry.attachments[0])}
                        <div class="admin-note-attach">
                            {foreach from=$entry.attachments item=attachment}
                                <div class="attachment"><a href="?cmd=root&action=download&type=downloads&id={$attachment.id}"  target="_blank" >{$attachment.name}</a></div>
                                {/foreach}
                        </div>
                    {/if}
                </td>  
            </tr>
        {/foreach}
        
        <tr>
            <td colspan="2">
                {literal}
                <script language="JavaScript">
                $(document).ready(function () {
                    $('#ticketnotes').find('div.attachment').each(function (i){
                        $(this).parent().parent().find('small a').hide();
                    });
                });
                </script>
                {/literal}
            </td>
        </tr>
        
    {/if}   
{elseif $action=='getclients'}
    {foreach from=$clients item=cl}
        <option {if $cl.id == $client_id}selected="selected"{/if} value="{$cl.id}">#{$cl.id} {if $cl.companyname!=''}{$lang.Company}: {$cl.companyname}{else}{$cl.firstname} {$cl.lastname}{/if}</option>
    {/foreach}
{elseif $action=='clienttickets'}
    <div class="blu clearfix" >

        <div class="pull-right">
            {include file='ajax.filterquicktool.tpl' client_id=$client_id loadid='ticketslist' href="?cmd=tickets&action=getadvanced"}
            <a href="?cmd=tickets&action=new&client_id={$client_id}" class="btn btn-primary btn-xs" target="_blank"><i class="fa fa-plus"></i> {$lang.opennewticket}</a>
        </div>


        <form action="" method="post" class="left">

            {$lang.status}
            <select id="client_ticket_status" name="status" onchange="$('.slide:visible').addLoader();
                    ajax_update('', $(this).parents('form').eq(0).serializeArray(), $(this).parents('.slide'));
                    return false;">
                <option value="" {if !$status}selected="selected"{/if}>{$lang.All}</option>
                {foreach from=$statuses item=sstatus}
                    <option value="{$sstatus}" {if $sstatus==$status}selected="selected"{/if}>{$lang.$sstatus}</option>
                {/foreach}
            </select>
            <input type="hidden" name="id" value="{$client_id}" />
            <input type="hidden" name="action" value="clienttickets" />
            <input type="hidden" name="cmd" value="tickets" />
            {securitytoken}
        </form>

        <div class="clear"></div>

    </div>
    
    <div class="blu" style="text-align:right">
        <form action="?cmd=supporthandle&action=createticket&redirect=1" method="post">
            <input type="hidden" name="client_id" value="{$client_id}" />
            <input type="submit" value="{$lang.opennewticket}" onclick="window.location='?cmd=supporthandle&action=createticket&redirect=1&client_id={$client_id}';return false;"/>{securitytoken}
        </form>
    </div>
    
    {if $tickets}
        <table cellspacing="0" cellpadding="3" border="0" width="100%" class="table glike hover">
            <tbody>
                <tr>

                    <th><a href="?cmd=tickets&action=clienttickets&id={$client_id}" class="sortorder" data-orderby="date">{$lang.datesubmitted}</a></th>
                    <th><a href="?cmd=tickets&action=clienttickets&id={$client_id}" class="sortorder" data-orderby="dept_id">{$lang.department}</a></th>
                    <th><a href="?cmd=tickets&action=clienttickets&id={$client_id}" class="sortorder" data-orderby="subject">{$lang.Subject}</a></th>
                    <th class="tagnotes" ></th>
                    <th><a href="?cmd=tickets&action=clienttickets&id={$client_id}" class="sortorder" data-orderby="status">{$lang.Status}</a></th>
                    <th class="lastelb"><a href="?cmd=tickets&action=clienttickets&id={$client_id}" class="sortorder" data-orderby="lastreply">{$lang.Lastreply}</a></th>

                </tr>
            </tbody>
            <tbody >
                {foreach from=$tickets item=ticket}
                    <tr>
                        <td>{$ticket.date|dateformat:$date_format}</td>
                        <td>{$ticket.deptname}</td>
                        <td>
                            <a href="?cmd=tickets&action=view&list={$currentlist}&num={$ticket.ticket_number}" 
                               class="{if $ticket.admin_read=='0'}unread{/if}" rel="{$ticket.ticket_number}"
                               >{$ticket.tsubject|wordwrap:80:"\n":true|escape}</a>

                        </td>
                        <td>

                            {if $ticket.flags & 1}
                                <strong class="fa fa-sticky-note-o right ticketflag" aria-hidden="true"  title="Ticket with admin notes" ></strong>
                            {/if}
                            {if $ticket.flags & 2}
                                <strong class="fa fa-dollar right ticketflag" aria-hidden="true"  title="Ticket with additional support fees" ></strong>
                            {/if}
                            {if $ticket.flags & 4}
                                <strong class="fa fa-pencil-square-o right ticketflag" aria-hidden="true"  title="Another staff member started to write a response to this ticket" ></strong>
                            {/if}
                            {if $ticket.flags & 16}
                                <strong class="fa fa-lock right ticketflag" aria-hidden="true"  title="This ticket is internal" ></strong>
                            {/if}
                            {if $ticket.parent_id}
                                <strong class="fa fa-code-fork right ticketflag" aria-hidden="true"  title="This ticket has a parent thread" ></strong>
                            {/if}
                            {if $ticket.tags}
                                <div class="right inlineTags">
                                    {foreach from=$ticket.tags item=tag name=tagloop}
                                        {if $smarty.foreach.tagloop.index < 3}
                                            <span style="background-color:{$tag.color}">{$tag.tag}</span>
                                        {/if}
                                    {/foreach}
                                </div>
                            {/if}

                        </td>
                        <td>
                            <span {if $ticket.status_color && $ticket.status_color != '000000'}style="color:#{$ticket.status_color}"{/if} class="{$ticket.status}">{if $ticket.status == 'Open'}{$lang.Open}{elseif $ticket.status == 'Answered'}{$lang.Answered}{elseif $ticket.status == 'Closed'}{$lang.Closed}{elseif $ticket.status == 'Client-Reply'}{$lang.Clientreply}{elseif $ticket.status == 'In-Progress'}{$lang.Inprogress}{else}{$ticket.status}{/if}</span>
                        </td>
                        <td class="border_{$ticket.priority}">{$ticket.lastreply}</td>
                    </tr>
                {/foreach}
            </tbody>
        </table>
        {if $totalpages}
            <div class="text-center" style="margin-top: 10px;">
                <div style="display:inline-block">
                    <strong>{$lang.records_per_page}</strong>
                    <select name="tickets_per_page" id="tickets_per_page">
                        <option value="10" {if $tickets_per_page == 10}selected{/if}>10</option>
                        <option value="20" {if $tickets_per_page == 20}selected{/if}>20</option>
                        <option value="50" {if $tickets_per_page == 50}selected{/if}>50</option>
                        <option value="100" {if $tickets_per_page == 100}selected{/if}>100</option>
                        <option value="100000" {if $tickets_per_page == 100000}selected{/if}>All</option>
                    </select>
                </div>
                <div style="display:inline-block">
                    <center class="blu paginercontainer" >
                        <strong>{$lang.Page} </strong>
                        {section name=foo loop=$totalpages}
                            <a href='?cmd=tickets&action=clienttickets&id={$client_id}&page={$smarty.section.foo.iteration-1}&status={$status}' class="npaginer
                               {if $smarty.section.foo.iteration-1==$currentpage}
                                   currentpage
                               {/if}"
                               >{$smarty.section.foo.iteration}</a>
                        {/section}
                    </center>
                </div>
            </div>
            <script>
                $('.paginercontainer', 'div.slide:visible').infinitepages();
                FilterModal.bindsorter('{$orderby.orderby}', '{$orderby.type}');
                {literal}
                $('#tickets_per_page').on('change', function () {
                    var form_client = {
                        tickets_per_page: $(this).val(),
                        status: $('#client_ticket_status').val()
                    };
                    ajax_update("?cmd=tickets&action=clienttickets&id={/literal}{$client_id}{literal}", form_client, $('div.slide:visible'), true);
                });
                {/literal}
            </script>

        {/if}
    {else}
        <strong>{$lang.nothingtodisplay}</strong>
    {/if}
{elseif $action=='getadvanced'}
    <div class="filter-actions">
        {if $tview}
            <a href="?cmd={$cmd}&tview={$tview.id}&resetfilter=1" {if $currentfilter}style="display:inline"{/if} class="freseter">{$lang.filterisactive}</a>
        {else}
            <a href="?cmd=ticketviews&action=fromfilter"  {if $currentfilter}style="display:inline"{/if} ><b>Create View</b></a>
            <a href="?cmd=tickets&resetfilter=1"  {if $currentfilter}style="display:inline"{/if}  class="freseter">{$lang.filterisactive}</a>
        {/if}
    </div>
    <form class="searchform filterform" action="?cmd=tickets" method="post" onsubmit="return filter(this)">
       {include file="_common/filters.tpl"}
        {securitytoken}
    </form>

    <script type="text/javascript">bindFreseter();</script>
{/if}

<script language="JavaScript">
{literal}
function deleteAttachmentFile(elm){
    $.get(elm.href, function(data) {
        parse_response(data);
        if (data.indexOf("<!-- {") == 0) {
            var codes = eval("(" + data.substr(data.indexOf("<!-- ") + 4, data.indexOf("-->") - 4) + ")");
            if (codes.ERROR.length == 0) {
                $(elm).parent().hide();
            }
        }
    });
}
function deleteTicketNote(elm){
    $.get(elm.href, function(data) {
        parse_response(data);
        if (data.indexOf("<!-- {") == 0) {
            var codes = eval("(" + data.substr(data.indexOf("<!-- ") + 4, data.indexOf("-->") - 4) + ")");
            if (codes.ERROR.length == 0) {
                window.location.reload(false);
            }
        }
    });
}
{/literal}
</script>