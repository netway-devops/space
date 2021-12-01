<a href="{if $backlink}{$backlink}{else}?cmd=tickets&list={$currentlist}{/if}&showall=true"  class="tload2"  id="backto">
    <strong>&laquo; {$lang.backto} {if $currentlist == 'open'}{$lang.Open}{elseif $currentlist == 'answered'}{$lang.Answered}{elseif $currentlist == 'closed'}{$lang.Closed}{elseif $currentlist == 'client-reply'}{$lang.Clientreply}{elseif $currentlist == 'in-progress'}{$lang.Inprogress}{elseif $currentlist == 'all'}{$lang.all}{else}{$currentlist}{/if} {$lang.tickets}</strong>
</a>
&nbsp;
{if !$forbidAccess.editTicket}
    <a class="setStatus menuitm menu-auto" href="#" id="hd1" onclick="return false;" >
        <span class="morbtn">{$lang.Setstatus}</span>
    </a>
    <a class="setStatus menuitm menu-auto" id="hd4" onclick="return false;" >
        <span class="morbtn">{$lang.setpriority}</span>
    </a>
    <a class="setStatus menuitm menu-auto"   href="#" id="hd3" onclick="return false;" >
        <span class="morbtn">{$lang.blocktickets}</span>
    </a>
{/if}
<span class="menu-auto-reset"></span>
{if !$forbidAccess.removeTicket}
    <a class="menuitm menu-auto deleteTicket menu-auto-reset" href="#" >
        <span style="color:red">{$lang.Delete}</span>
    </a>
{/if}
{if count($staff_members) > 1}
    {if !$forbidAccess.editTicket}
        <a class="menuitm setStatus menu-auto" id="hd6" onclick="return false;" href="#" >
            <span class="morbtn">
                {if $ticket.owner}
                    Assigned to {$ticket.owner.firstname} {$ticket.owner.lastname}
                {else}Assign to{/if}
            </span>
        </a>
    {/if}
    {if !$forbidAccess.editTicket || $admindata.id != $ticket.owner_id}
        <a class="menuitm setStatus menu-auto" id="hd7" onclick="return false;" href="#" >
            <span class="morbtn">Subscriptions</span>
        </a>
    {/if}
{/if}
<a class="menuitm setStatus menu-auto" id="hd2" onclick="return false;" href="#" >
    <span class="morbtn">{$lang.moreactions}</span>
</a>
{*
    LISTS 
*}
{if $bottom}
    <ul id="hd4_m"  class="ddmenu">
        <li class="opt_low {if $ticket.priority=='0'}disabled{/if}"><a href="Low">{$lang.Low}</a></li>
        <li  class="opt_medium {if $ticket.priority=='1'}disabled{/if}"><a href="Medium">{$lang.Medium}</a></li>
        <li  class="opt_high {if $ticket.priority=='2'}disabled{/if}"><a href="High">{$lang.High}</a></li>
        <li  class="opt_critical {if $ticket.priority=='3'}disabled{/if}"><a href="Critical">{$lang.Critical}</a></li>
    </ul>

    <ul id="hd1_m"  class="ddmenu">
        {foreach from=$statuses item=status}
            <li class="act_{$status.status|lower} {if $ticket.status==$status.status}disabled{/if}">
                <a href="status|{$status.status}" data-color="{$status.color}">{$lang[$status.status]}</a>
            </li>
            {/foreach}
    </ul>
    {if count($staff_members) > 1}
        <ul class="ddmenu" id="hd6_m">
            {if $ticket.owner_id}
                <li><a href="assign:0">Remove assignment</a></li>
                {/if}
                {foreach from=$staff_members item=stfmbr}
                <li><a href="assign:{$stfmbr.id}">{$stfmbr.firstname} {$stfmbr.lastname}</a></li>
                {/foreach}
        </ul>
        <ul class="ddmenu" id="hd7_m">
            {if !$forbidAccess.editTicket && $ticket.subscriptions}
                <li>
                    <a href="assign:0:1">Remove all</a>
                </li>
            {/if}
            {foreach from=$staff_members item=stfmbr}
                {if (!$forbidAccess.editTicket || $admindata.id == $stfmbr.id) && $stfmbr.id != $ticket.owner_id}
                    <li>
                        <a href="assign:{$stfmbr.id}:1{if in_array($stfmbr.id,$ticket.subscriptions)}:1{/if}">
                            {if in_array($stfmbr.id,$ticket.subscriptions)}Remove
                            {else}Add
                            {/if} 
                            {$stfmbr.firstname} {$stfmbr.lastname}</a>
                    </li>
                {/if}
            {/foreach}
        </ul>
    {/if}
    <ul id="hd2_m" class="ddmenu">
        <li>
            <a href="ShowLog">{$lang.viewticketlog}</a>
        </li>
        <li>
            <a href="ChangeParent">Change parent thread</a>
        </li>
        {if !$forbidAccess.editTicket}
            <li>
                <a href="Unread">{$lang.markunread}</a>
            </li>

        {/if}
    </ul>
    <ul id="hd3_m" class="ddmenu">
        <li><a href="blockEmail">{$lang.From} {$ticket.email}</a></li>
        <li><a href="blockSubject" onclick="return false;">{$lang.withsamesubj}</a></li>
        <li class="disabled highlighter"><a href="blockBody" onclick="return false;">{$lang.containinghightext}</a></li>
    </ul>
<!-- Modal -->
<div class="modal fade" id="changeparent-modal" tabindex="-1" role="dialog"  aria-hidden="true">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
                <h4 class="modal-title">Change parent thread</h4>

            </div>
            <div class="modal-body" ></div>

        </div>
        <!-- /.modal-content -->
    </div>
    <!-- /.modal-dialog -->
</div>
<!-- /.modal -->
{/if}
