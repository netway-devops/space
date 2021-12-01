<table border="0" cellspacing="0" cellpadding="0" width="100%" id="content_tb">
    <tr>
        <td colspan="2"><h3>Lookup Settings</h3></td>
    </tr>
    <tr>
        <td class="leftNav">

            {include file='configuration/leftmenu.tpl'}


        </td>
        <td  valign="top"  class="bordered"><div id="bodycont">
                <div id="newshelfnav" class="newhorizontalnav">
                    <div class="list-1">
                        <ul>
                            <li class="list-1elem {if $cmd == 'whoisservers' && in_array($action, array( 'add', 'edit'))}active{/if}">
                                <a href="?cmd=whoisservers"><span>{$lang.whoisservers}</span></a>
                            </li>
                            <li class="list-1elem ">
                                <a href="?cmd=whoisservers&picked_tab=1" data-action="premium"><span>Premium Domain Names</span></a>
                            </li>
                            <li class="list-1elem ">
                                <a href="?cmd=whoisservers&picked_tab=2" data-action="synchronization"><span>Synchronization</span></a>
                            </li>
                            <li class="list-1elem">
                                <a href="?cmd=whoisservers&picked_tab=3" data-action="suggestions"><span>Domain suggestions</span></a>
                            </li>
                            <li class="list-1elem">
                                <a href="?cmd=whoisservers&picked_tab=4" data-action="client_interface"><span>Other</span></a>
                            </li>
                        </ul>
                    </div>

                </div>
                {if $action == 'add' || $action == 'edit'}
                    {include file='configuration/whoisservers_add_edit.tpl'}
                {else }

                <form action="?cmd=whoisservers&action=save_config" method="post">
                    <input type="hidden" name="picked_tab" id="picked_tab" value="{$picked_tab}"/>
                    {include file='configuration/whoisservers_default.tpl'}
                    {include file='configuration/whoisservers_premium.tpl'}
                    {include file='configuration/whoisservers_synchronization.tpl'}
                    {include file='configuration/whoisservers_suggestions.tpl'}
                    {include file='configuration/whoisservers_client_interface.tpl'}
                    {securitytoken}
                </form>


                {literal}
                    <script>
                        $(function () {
                            $('#bodycont').TabbedMenu({
                                elem: '.tabs',
                                picker: '.list-1elem',
                                picker_id: 'picked_tab',
                                aclass: 'active',
                                picked: {/literal}{$picked_tab}{literal}
                            });

                        });
                    </script>
                {/literal}

                    {include file='configuration/whoisservers_bulk.tpl'}
                {/if}

            </div>
        </td>
    </tr>
</table>
