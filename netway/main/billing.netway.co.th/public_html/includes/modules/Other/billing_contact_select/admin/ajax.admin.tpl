<!-- Single button -->
<div class="btn-group">
    <button type="button" class="btn btn-sm btn-default" >
        Billing Contact
    </button>
    <button type="button" class="btn btn-sm btn-default  dropdown-toggle" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
        <b>{$ccontacts[$selected_contact].firstname} {$ccontacts[$selected_contact].lastname}</b> <span class="caret"></span>
    </button>

    <ul class="dropdown-menu">
 {foreach from=$ccontacts item=contact key=id}
     <li value="{$id}" {if $selected_contact == $id}selected="selected"{/if}><a href="?cmd=billing_contact_select&account_id={$details.id}&contact_id={$id}&action=changecontact&security_token={$security_token}">{$contact.firstname} {$contact.lastname}</a></li>
        {/foreach}

    </ul>
</div>