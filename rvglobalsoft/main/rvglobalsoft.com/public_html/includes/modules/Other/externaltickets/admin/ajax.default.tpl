{if $listTickets}
<div id="etTicketList" class="newhorizontalnav">
    {if $assignedTickets}
    <div class="list-1"><h3 style="padding: 10px">Your Tickets Assigned</h3></div>
    <table cellspacing="0" cellpadding="3" border="0" width="100%" class="glike hover">
    <tbody>
      <tr>
        <th width="20"></th>
        <th>{$lang.datesubmitted}</th>
        <th>{$lang.department}</th>
        <th>{$lang.Subject}</th>
        <th>{$lang.Submitter}</th>
        <th>{$lang.Status}</th>
        <th class="lastelb">{$lang.Lastreply}</th>

      </tr>
    </tbody>
    <tbody>
    {foreach from=$assignedTickets item=ticket}
    <tr >
      <td width="20"></td>
      <td>{$ticket.date|dateformat:$date_format}</td>
      <td>{$ticket.deptname}</td>
      <td><a href="?cmd=tickets&action=view&list={$currentlist}&num={$ticket.ticket_number}" class="tload2 {if $ticket.admin_read=='0'}unread{/if}" rel="{$ticket.ticket_number}">{$ticket.tsubject|wordwrap:80:"\n":true}</a></td>
      <td>{$ticket.name}</td>
      <td><span class="{$ticket.status}">{if $ticket.status == 'Open'}{$lang.Open}{elseif $ticket.status == 'Answered'}{$lang.Answered}{elseif $ticket.status == 'Closed'}{$lang.Closed}{elseif $ticket.status == 'Client-Reply'}{$lang.Clientreply}{elseif $ticket.status == 'In-Progress'}{$lang.Inprogress}{else}{$ticket.status}{/if} </span></td>
      <td class="border_{$ticket.priority}">{$ticket.lastreply}</td>
    </tr>
    {/foreach}
    </tbody>

  </table>
  {elseif $retnothing}<p class="blu"> Nothing to display</p>{/if}
</div>
{else}
{if $etResult}
<h3>Ticket Assigned</h3>
    <div style="text-align:center; padding:10px">
        Ticket has been assigned successfully.
    </div>
<div style="padding:10px;"><a href="#" onclick="etCloseForm(); return false;" style="border-radius: 4px;" class="menuitm"><span style="font-weight:bold">Close</span></a></div>
{else}
<h3>Action failed</h3>
<div style="padding:10px">
    <div style="text-align:center; padding:10px">
        <strong style="color: #cc0000">{if $etError != ''}{$etError}{else}Unknown error{/if}</strong>
    </div>
</div>
<div style="padding: 0 0 10px;"><a href="#" onclick="etCloseForm(); return false;" style="border-radius: 4px;" class="menuitm"><span style="font-weight:bold">Close</span></a></div>
{/if}
<script type="text/javascript">{literal}
    function etCloseForm() {
        $('#confirm_ord_delete').remove();
        etDisplayForm();
    }
{/literal}</script>
{/if}