<script type="text/javascript">{literal}
    function pickadmin(id, elem) {
        $('.tchoice.picked').removeClass('picked');
        $(elem).addClass('picked');
        $('.tblshown').hide().removeClass('tblshown');
        $('#etTickets'+id).show().addClass('tblshown');
    }
{/literal}</script>
<div id="newshelf" style="padding: 10px;">
    {if is_array($adminlist)}
    {foreach from=$adminlist item=adm name=adminfoo}
    <div style="float: left; padding: 10px 5px"><a href="#" onclick="pickadmin('{$adm.id}',this); return false" class="tchoice {if ($picked && $picked==$adm.id) || (!$picked && $smarty.foreach.adminfoo.first)}picked{/if}" style="width: 100px">#{$adm.id} {if $adm.firstname == '' && $adm.lastname == ''}<em>(empty name)</em>{else}{$adm.firstname} {$adm.lastname}{/if} {$adm.email}</a></div>
    {/foreach}
    {/if}
    <div class="clear"></div>
</div>
    {if $assignedTickets}
    <table cellspacing="0" cellpadding="3" border="0" width="100%" class="glike hover">
    <tbody>
      <tr>
        <th width="20"></th>
        <th>Date Submitted</th>
        <th>Department</th>
        <th>{$lang.Subject}</th>
        <th>{$lang.Submitter}</th>
        <th>{$lang.Status}</th>
        <th class="lastelb">Last Reply</th>

      </tr>
    </tbody>
    {foreach from=$assignedTickets key=adminid item=ticketpack name=ticketfoo}
    <tbody id="etTickets{$adminid}" {if ($picked && $picked==$adminid) || (!$picked && $smarty.foreach.ticketfoo.first)}class="tblshown"{else}style="display: none"{/if}>
        {if !empty($ticketpack)}
            {foreach from=$ticketpack item=ticket}
                <tr >
                  <td width="20"><a href="?cmd=module&module={$moduleid}&action=removeEntry&adminid={$adminid}&ticketid={$ticket.ticket_number}" style="font-weight: bold; color: #cc0000; padding-right: 10px;" onclick="if(confirm('Do you really want to unassign this ticket?'))return true; else return false;">Unassign</a></td>
                  <td>{$ticket.date|dateformat:$date_format}</td>
                  <td>{$ticket.deptname}</td>
                  <td><a href="?cmd=tickets&action=view&list={$currentlist}&num={$ticket.ticket_number}" class="tload2 {if $ticket.admin_read=='0'}unread{/if}" rel="{$ticket.ticket_number}">{$ticket.tsubject|wordwrap:80:"\n":true}</a></td>
                  <td>{$ticket.name}</td>
                  <td><span class="{$ticket.status}">{if $ticket.status == 'Open'}{$lang.Open}{elseif $ticket.status == 'Answered'}{$lang.Answered}{elseif $ticket.status == 'Closed'}{$lang.Closed}{elseif $ticket.status == 'Client-Reply'}{$lang.Clientreply}{elseif $ticket.status == 'In-Progress'}{$lang.Inprogress}{else}{$ticket.status}{/if} </span></td>
                  <td class="border_{$ticket.priority}">{$ticket.lastreply}</td>
                </tr>
            {/foreach}
        {else}
            <tr><td colspan="7">Nothing to display</td></tr>
        {/if}
    </tbody>
    {/foreach}

  </table>
  {elseif $retnothing}<p class="blu"> Nothing to display</p>{/if}
    