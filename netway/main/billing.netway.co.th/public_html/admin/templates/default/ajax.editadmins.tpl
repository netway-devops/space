{php}
$templatePath   = $this->get_template_vars('template_path');
include($templatePath . 'ajax.editadmins.tpl.php');
{/php}

<div id="newshelfnav" class="newhorizontalnav">
    <div class="list-1">
        <ul>
            <li class="{if $action == 'default' || $action == 'addadministrator' || $action == 'administrator' || $action == 'myaccount'}active{/if}">
                <a href="?cmd=editadmins"><span>{$lang.Administrators}</span></a>
            </li>
            <li class="{if $action == 'teams' || $action == 'team' || $action == 'addteam'}active{/if}">
                <a href="?cmd=editadmins&action=teams"><span>Teams</span></a>
            </li>
        </ul>
    </div>

    {if $breadcrumbs}
    <div class="list-2">
        <div class="haveitems">
            {if $breadcrumbs == 'admin'}
                <a href="?cmd=editadmins"><span>Staff members list</span></a>
                &raquo;
                {if $action=='addadministrator'}
                    <a>{$lang.addadmin}</a>
                {else}
                    <a>{$details.firstname} {$details.lastname} - {$details.username}</a>
                {/if}
            {/if}
            {if $breadcrumbs == 'team'}
                <a href="?cmd=editadmins&action=teams"><span>Teams list</span></a>
                &raquo;
                {if $action=='addteam'}
                    <a>Create Team</a>
                {else}
                    <a>{$details.name}</a>
                {/if}
            {/if}
        </div>
    </div>
    {else}
    <div class="list-2">
        <div class="navsubmenu haveitems" ">
        <ul>
            {if $action == 'default'}
                <li class="list-2elem"><a href="?cmd=editadmins&action=addadministrator"><span>{$lang.addadmin}</span></a></li>
            {else}
                <li class="list-2elem"><a href="?cmd=editadmins&action=addteam"><span>Create new team</span></a></li>
            {/if}
        </ul>
    </div>



</div>
{/if}
</div>

{if $action=='addadministrator'}
    {include file="staff/staff_edit.tpl"}
{elseif ($action=='administrator' || $action=='myaccount') AND $details}
    {include file="staff/staff_edit.tpl"}
{elseif $action=='addteam' || $action=='team'}
    {include file="staff/team_edit.tpl"}
{elseif $action=='teams'}
    {include file="staff/team_list.tpl"}
{elseif $action=='default'}
    {include file="staff/staff_list.tpl"}
{/if}

{if $action=='addadministrator' || $action=='administrator' || $action=='addteam' || $action=='team'}
    <script src="{$template_dir}/js/editadmins.js?v={$hb_version}" type="text/javascript"></script>
{/if}