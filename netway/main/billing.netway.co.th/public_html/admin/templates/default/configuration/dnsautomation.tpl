<table border="0" cellspacing="0" cellpadding="0" width="100%" id="content_tb">
    <tr>
        <td colspan="2"><h3>DNS Settings</h3></td>
    </tr>
    <tr>
        <td class="leftNav">

            {include file='configuration/leftmenu.tpl'}


        </td>
        <td  valign="top"  class="bordered">
            <div id="bodycont">
                <div id="newshelfnav" class="newhorizontalnav">
                    <div class="list-1">
                        <ul>
                            <li class="list-1elem">
                                <a href="?cmd=dns_automation" data-action="dnsautomation"><span>Domain DNS automation</span></a>
                            </li>
                            <li class="list-1elem {if in_array($action, array( 'add', 'edit'))}active{/if}">
                                <a href="?cmd=dns_automation&picked_tab=1" data-action="dnsautomation"><span>Service DNS automation</span></a>
                            </li>
                            <li class="list-1elem">
                                <a href="?cmd=dns_automation&picked_tab=2" data-action="dnstemplate"><span>DNS Templates</span></a>
                            </li>
                        </ul>
                    </div>
                    <div class="list-2">
                        <div class="subm1 haveitems" style="">
                            <ul>
                                <li><a href="#" onclick="add_package();"><span>Add new DNS package</span></a></li>
                            </ul>
                        </div>
                    </div>

                </div>
                {if $action == 'add' || $action == 'edit'}
                    {include file='configuration/dnsautomation_add_edit.tpl'}
                {else }

                    <form action="?cmd=dns_automation&action=save_config" method="post">
                        <input type="hidden" name="picked_tab" id="picked_tab" value="{$picked_tab}"/>
                        {include file='configuration/dnsautomation_dnsautomation.tpl'}
                        {include file='configuration/dnsautomation_service_dnsautomation.tpl'}
                        {include file='configuration/dnsautomation_dnstemplate.tpl'}
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
                        function add_package() {
                            var count = $('.count_package:last').val();
                            ajax_update('?cmd=dns_automation&action=get_dns_package', {id:count}, '.next-dns-package:last');
                        }
                    </script>
                {/literal}

                {/if}

            </div>
        </td>
    </tr>
</table>
