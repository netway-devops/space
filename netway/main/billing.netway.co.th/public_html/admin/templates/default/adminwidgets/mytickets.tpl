
        <table cellspacing="0" cellpadding="3" border="0" width="100%" class="table whitetable"  style="">
            <tbody>
            <tr>
                <th >{$lang.Subject}</th>
                <th width="130">{$lang.Submitter}</th>
                <th width="90">{$lang.Status}</th>
                <th width="90">Last Reply</th>
            </tr>
            {foreach from=$mytickets item=ticket name=loop}
                <tr  class="{if $ticket.admin_read=='0'}unread{/if}" >
                    <td>
                        <a class="subject" href="?cmd=tickets&action=view&list=all&num={$ticket.ticket_number}" >{$ticket.tsubject|escape}</a>
                            {if $ticket.owner_id}<div style="font-size:80%;padding-left:10px;">&#8594; Assigned To: {$ticket.firstname} {$ticket.lastname}</div>
                            {else}<div style="font-size:80%;padding-left:10px;opacity:0.6" >&#8594; Not Assigned</div>{/if}
                    </td>
                    <td>
                        {if $ticket.client}
                            {$ticket.client|@profilelink:true:true}
                        {else}
                            {$ticket.name}
                        {/if}
                    </td>
                    <td>
                        <span class="{$ticket.status}">{if $lang[$ticket.status]}{$lang[$ticket.status]}{else}{$ticket.status}{/if}</span>
                    </td>
                    <td>{$ticket.lastreply}</td>
                </tr>
            {/foreach}
            </tbody>
        </table>