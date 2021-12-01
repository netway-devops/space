<table width="100%" cellspacing="0" cellpadding="3" border="0" class="table glike">
    <tr>

        <th width="15">#</th>
        <th width="30%">{$lang.Name}</th>
        <th width="20%">{$lang.Username}</th>
        <th width="30%">{$lang.Email}</th>
        <th>{$lang.Status}</th>
        <th width="20">&nbsp;</th>
    </tr>
    {foreach from=$admins item=ad}
        <tr class="product">
            <td>{$ad.id}</td>
            <td><a href="?cmd=editadmins&action=administrator&id={$ad.id}">{$ad.firstname} {$ad.lastname}</a></td>
            <td>{$ad.username}</td>
            <td><a href="mailto:{$ad.email}">{$ad.email}</a></td>
            <td>{$lang[$ad.status]}</td>
            <td><a href="?cmd=editadmins&make=deleteadmin&id={$ad.id}&security_token={$security_token}"
                   onclick="return confirm('{$lang.deleteadminconfirm}');" class="delbtn">Delete</a></td>
        </tr>
    {/foreach}

</table>