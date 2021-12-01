<table width="100%" cellspacing="0" cellpadding="3" border="0" class="table glike">
    <tr>
        <th width="60">Id</th>
        <th width="160">{$lang.Name}</th>
        <th>Staff members</th>
        <th width="20">&nbsp;</th>
    </tr>
    {foreach from=$teams item=gr key=i}
        <tr>
            <td><a href="?cmd=editadmins&action=team&id={$gr.id}">#{$gr.id}</a></td>
            <td><a href="?cmd=editadmins&action=team&id={$gr.id}">{$gr.name}</a></td>
            <td>{$gr.members}</td>
            <td>
                <a href="?cmd=editadmins&action=teams&make=deleteteam&id={$gr.id}&security_token={$security_token}"
                   onclick="return confirm('Are you sure that you want to remove this team? Assigned staff members will loose privileges granted to this team.');" class="delbtn">Delete</a></td>
        </tr>
        {foreachelse}
        <tr>
            <td colspan="4">No teams added yet</td>
        </tr>
    {/foreach}

</table>