{if $vpsdo == 'getstatus'}
    {if $status}<span class="yes">Yes</span>{else}<span class="no">No</span>{/if}
{elseif $vpsdo == 'clientsvms'}
    <div class="data-table backups-list">
        {foreach from=$vms item=vm}
            <table width="100%" cellspacing="0" class="data-table backups-list left">
                <thead>
                <tr>
                    <td colspan="5">VPS Info</td>
                </tr>
                </thead>
                <tbody>
                <tr style="background-color: #eee;">
                    <td class="right-aligned" width="33%">
                        <b>State</b>
                    </td>
                    <td class="power-status">{if $vm.status == 1}
                            <span class="label label-success">On</span>

                        {else}
                            <span class="label label-danger">Off</span>

                        {/if}
                        <span>

                            <button class="btn btn-sm btn-info" onclick="load_clientvm();
                                    $('#lmach').addLoader();
                                    return false;">Refresh
                            </button>
                            {if $vm.status == 1}
                                <button  class="btn btn-sm btn-warning" onclick="reboot_clientvm();
                                    return false;">Reboot
                                </button>
                                <button  class="btn btn-sm btn-danger"  onclick="shutdown_clientvm();
                                    return false;">Shutdown
                                </button>
                            {else}
                                <button  class="btn btn-sm btn-success"  onclick="startup_clientvm();
                                    return false;">Power On
                                </button>
                            {/if}
                        </span>
                    </td>
                </tr>
                <tr style="background-color: #eee;">
                    <td class="right-aligned"><b>Hostname</b></td>
                    <td class="courier-font">
                        {$vm.hostname}
                    </td>
                </tr>
                <tr style="background-color: #eee;">
                    <td class="right-aligned"><b>IP&nbsp;Addresses</b></td>
                    <td class="courier-font">
                        {foreach from=$vm.ips item=ip}
                            <a style="display: block; width: 100px;" href="http://{$ip}">{$ip}</a>
                        {/foreach}

                        {foreach from=$vm.ips6 item=ip}
                            <a style="display: block; width: 100px;" href="http://{$ip}">{$ip}</a>
                        {/foreach}
                    </td>
                </tr>
                </tbody>
            </table>
        {/foreach}
        <div class="clear"></div>
    </div>
{literal}
    <style>
        table.data-table tbody tr td {
            height: 30px
        }

        span.infospan {
            border-bottom: 1px dashed #777777;
            cursor: help;
        }
    </style>
    <script type="text/javascript">
        $('.infospan').each(function () {
            $(this).attr('title', 'This value is not accessible, and cannot be obtained from server at this time');
        }).vTip();
    </script>
{/literal}

{/if}