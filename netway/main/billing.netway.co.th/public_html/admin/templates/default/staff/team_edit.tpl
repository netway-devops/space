<form name="" action="" method="post" style="padding: 10px">
    <input name="make" value="{$action}" type="hidden"/>

    <div class="panel panel-default">
        <div class="panel-heading">
            <strong>{$lang.generalsettings}</strong>
        </div>
        <div class="panel-body">
            <div class="form-group">
                <label>Team name</label>
                <input type="text" name="name" value="{$details.name}" class="form-control"/>
            </div>

            <div class="form-group">
                <label>Assigned Staff</label>
                <input name="staff[]" value="-1" type="hidden"/>
                <select name="staff[]" multiple class="form-control group-assign">
                    {foreach from=$admins item=admin}
                        <option value="{$admin.id}"
                                {if in_array($admin.id, $details.staff)}selected{/if} >{$admin.username}</option>
                    {/foreach}
                </select>
            </div>

        </div>
        <div class="panel-footer">
            <button type="submit" value="1" name="save"
                    class="btn btn-primary">{$lang.savechanges}</button>
            <span
                    class="orspace">{$lang.Or} <a href="?cmd=editadmins" class="editbtn">{$lang.Cancel}</a></span>
        </div>
    </div>
    <div class="staff-options">
        {include file="staff/acl.tpl"}
    </div>
    {securitytoken}
</form>