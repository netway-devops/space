    {if $depts}
        <div class="newhorizontalnav" id="newshelfnav">
            <div class="list-1">
                <ul>
                    <li class="active last">
                        <a href="#"><span class="ico money">{$lang.ticketdepts}</span></a>
                    </li>
                </ul>
            </div>
            <div class="list-2">
                <div class="navsubmenu haveitems" ">
                    <ul>
                        <li class="list-2elem"><a href="?cmd=ticketdepts&action=add"><span>{$lang.addnewdepartment}</span></a></li>
                    </ul>
                </div>

            </div>
        </div>
        <form id="serializeit" method="post">
            <table width="100%" cellspacing="0" cellpadding="3" border="0" class="table glike">
                <tbody>
                    <tr>
                        <th width="20"></th>
                        <th width="28%">{$lang.departmentname}</th>
                        <th width="30%">{$lang.Description}</th>
                        <th width="30%">{$lang.email}</th>
                        <th width="10%">Visible</th>
                        <th width="20"></th>
                    </tr>
                </tbody>
            </table>
            <ul id="grab-sorter" style="width:100%">
                {foreach from=$depts item=dept name=cat}
                    <li>
                        <div>
                            <input type="hidden" name="sort[]" value="{$dept.id}"/>
                            <table width="100%" cellspacing="0" cellpadding="3" border="0" class="table glike">
                                <tr class="nobordera">
                                    <td valign="top">
                                        <a class="sorter-handle">{$lang.move}</a>
                                    </td>
                                    <td width="28%" valign="top">
                                        <a href="?cmd=ticketdepts&action=edit&id={$dept.id}"><strong>{$dept.name}</strong></a>
                                        <div>
                                            {if !$dept.staff}
                                                No staff member assigned
                                            {else}
                                                Assigned:
                                                {if $dept.teamscnt > 0}
                                                    <span class="staff staff-team" title="{$dept.teams_title|escape}">
                                                        <i class="fa fa-users"></i> {$dept.teamscnt}
                                                        Team(s){if $dept.adminscnt > 0}, {/if}
                                                    </span>
                                                {/if}
                                                {if $dept.adminscnt > 0}
                                                    <span class="staff staff-admin" title="{$dept.admins_title|escape}">
                                                        <i class="fa fa-user"></i> {$dept.adminscnt} Staff member(s)
                                                    </span>
                                                {/if}
                                            {/if}
                                        </div>
                                    </td>
                                    <td width="30%" valign="top">
                                        <a href="?cmd=ticketdepts&action=edit&id={$dept.id}">{$dept.description}</a>
                                    </td>
                                    <td width="30%" valign="top">
                                        {foreach from=$dept.importmails item=mail}{$mail.email}
                                            <br/>
                                            {foreachelse}{$dept.email}
                                        {/foreach}
                                    </td>
                                    <td width="10%" valign="top">
                                        {if $dept.options & 1048576}
                                            <span style="color: orange">{$lang.Yes}, for explicit client groups</span>
                                        {elseif $dept.options & 1}
                                            <span style="color: green">{$lang.Yes}, for all</span>
                                        {else}
                                            <span style="color: #aaa">{$lang.No}</span>
                                        {/if}
                                    </td>
                                    <td width="20" valign="top">
                                        <a href="?cmd=ticketdepts&make=delete&id={$dept.id}&security_token={$security_token}"
                                           class="delbtn" onclick="return confirm('{$lang.deletedeptconfirm}');">
                                            Delete
                                        </a>
                                    </td>
                                </tr>
                            </table>
                        </div>
                    </li>
                {/foreach}
            </ul>
            {securitytoken}
        </form>
        <script type="text/javascript" src="{$template_dir}js/jquery.dragsort-0.3.10.min.js?v={$hb_version}"></script>
    {literal}
        <script type="text/javascript">

            $("#grab-sorter").dragsort({
                dragSelector: "a.sorter-handle",
                dragBetween: true,
                dragEnd: saveOrder,
                placeHolderTemplate: "<li class='placeHolder'><div></div></li>"
            });

            function saveOrder() {
                var sorts = $('#serializeit').serialize();
                ajax_update('?cmd=ticketdepts&action=listdepts&' + sorts, {});
            }

        </script>
        <style>
            .staff {
                cursor: help
            }
        </style>
    {/literal}
    {else}
        <div class="blank_state blank_news">
            <div class="blank_info">
                <h1>{$lang.tdbs_h}</h1>
                {$lang.tdbs_d}
                <div class="clear"></div>

                <a class="new_add new_menu" href="?cmd=ticketdepts&action=add" style="margin-top:10px">
                    <span>{$lang.addnewdepartment}</span></a>
                <div class="clear"></div>

            </div>
        </div>
    {/if}
    {if $ajax}
        <script type="text/javascript">bindTicketEvents();</script>
    {/if}