{if $childrens}
    This ticket is a parent for:
    <ul>{foreach from=$childrens item=child}
        <li><a href="?cmd=tickets&action=view&num={$child.ticket_number}" target="_blank">#{$child.ticket_number}</a> - {$child.subject}</li>
{/foreach}
    </ul>


    <br/>
    <strong>It cannot be set as child of another ticket.</strong>
{else}
{if $ticket.parent_id}
    Current parent:
    <h3><a href="?cmd=tickets&action=view&num={$parent.ticket_number}" target="_blank">{$parent.ticket_number} - {$parent.subject}</a></h3> <br/>
{/if}

<form action="?cmd=tickets&action=menubutton&make=save_ticketparent&id={$ticket.ticket_number}" method="post">
    <div class="form-group" id="filter-parent_ticket_id">

<label>Search for a new parent below: </label>
        <select class="form-control" name="parent_id" id="parent_id" default="{$ticket.parent_id}" >
            <option value="0">{$lang.None}</option>
        </select>


    </div>
    <div class="form-group" >

        <center>

           <input type="submit" class="btn btn-primary" value="Submit" />
            <button type="button" class="btn btn-default" data-dismiss="modal" aria-hidden="true">Cancel</button>
        </center>
    </div>
{securitytoken}
</form>
{/if}