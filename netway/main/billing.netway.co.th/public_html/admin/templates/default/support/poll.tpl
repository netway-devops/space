{foreach from=$tickets item=ticket}
    <tr {if $ticket.escalated > 0}class="sla_level_{$ticket.escalated}"{/if}>
        {if $tview}
            {include file="ajax.ticketviews.tpl" display=trow}
        {else}
            <td width="20"><input type="checkbox" class="check" value="{$ticket.id}" name="selected[]"/></td>
            <td class="col_name">
                {if $ticket.client_id!='0'}
                    {$ticket|@profilelink:true:true}
                {else}
                    {$ticket.name}
                {/if}
            </td>
            <td class="subjectline">
                <div class="df1">
                    <div class="df2">
                        <div class="df3">
                            <a href="?cmd=tickets&action=view{if $backredirect}&brc={$backredirect}{/if}{if $currentdept && $currentdept!='all'}&dept={$currentdept}{/if}{if $currentlist && $currentlist!='all'}&list={$currentlist}{/if}&num={$ticket.ticket_number}" 
                               data-pjax class="{if $ticket.admin_read=='0'}unread{/if}" rel="{$ticket.ticket_number}">{$ticket.tsubject|wordwrap:80:"\n":true|escape}</a>
                        </div>
                    </div>
                </div>
            </td>
            <td class="tagnotes">
                <div class="right " style="min-width: 27px;">
                    &nbsp;
                    {if $ticket.flags & 64}
                        <i class="fa fa-exclamation-triangle right" style="padding: 5px 2px;"></i>
                    {/if}
                    {if $ticket.flags & 32}
                        <i class="fa fa-exclamation right" style="padding: 5px 2px;"></i>
                    {/if}
                </div>
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
                {if $ticket.flags & 512}
                    <strong class="fa fa-pencil-square right ticketflag" aria-hidden="true"  title="The reply to the ticket is locked" ></strong>
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
            <td class="col_status"><span {if $ticket.status_color && $ticket.status_color != '000000'}style="color:#{$ticket.status_color}"{/if} class="{$ticket.status}">{if $ticket.status == 'Open'}{$lang.Open}{elseif $ticket.status == 'Answered'}{$lang.Answered}{elseif $ticket.status == 'Closed'}{$lang.Closed}{elseif $ticket.status == 'Client-Reply'}{$lang.Clientreply}{elseif $ticket.status == 'In-Progress'}{$lang.Inprogress}{else}{$ticket.status}{/if} </span></td>
            <td class="subjectline col_rp_name">{$ticket.rpname}</td>
            <td class="border_{$ticket.priority} col_lastreply" title="{$ticket.lastreply_date|dateformat:$date_format}">{$ticket.lastreply}</td>
        {/if}
    </tr>
{/foreach}