{include file="`$onappdir`header.cloud.tpl"}
<div class="header-bar">
    <h3>{$lang.cloudlabel1}</h3>
    <div class="clear"></div>
</div>
<div class="content-bar">

    <table cellspacing="0" cellpadding="0" border="0" width="100%" class="tonapp server-list">
        <thead>
        <tr>
            <th width="66" class="switch md-hide"></th>
            <th class="hostname">{$lang.hostname}</th>
            <th width="233" class="address">{$lang.ipadd}</th>
            <th width="70" class="spec">{$lang.diskspace}</th>
            <th width="70" class="spec">{$lang.memory}</th>
            <th width="60" class="actions md-hide"></th>
        </tr>
        </thead>
        <tbody id="updater">
        {if $MyVMs}
            {foreach from=$MyVMs item=vm name=foo}
                <tr class="vm-line">
                    <td class="switch md-hide">

                        {if $vm.status==1}
                            <a href="{$service_url}&vpsdo=shutdown&vpsid={$vm.vpsid}&security_token={$security_token}"
                               class="state_switch on"
                               onclick="return powerchange(this, '{$lang.sure_to_poweroff}?', '{$lang.Off}');">
                                {$lang.On}
                            </a>
                        {else}
                            <a href="{$service_url}&vpsdo=startup&vpsid={$vm.vpsid}&security_token={$security_token}"
                               class="state_switch off"
                               onclick="return powerchange(this, '{$lang.sure_to_power_on}?', '{$lang.On}');">
                                {$lang.Off}
                            </a>
                        {/if}
                  
                    </td>
                    <td class="hostname">
                        <a href="{$service_url}&vpsid={$vm.vpsid}&vpsdo=vmdetails">
                            <strong>{$vm.hostname}</strong>
                        </a>
                    </td>
                    <td class="address">
                        {foreach from=$vm.ips item=ipp name=ssff}
                            {$ipp}{if !$smarty.foreach.ssff.last},{/if}
                        {/foreach}
                    </td>
                    <td class="spec">{$vm.space} GB</td>
                    <td class="spec">{$vm.ram} {$vm.ram.unit}</td>
                    <td class="fs11 actions md-hide">
                        <a href="{$service_url}&vpsid={$vm.vpsid}&vpsdo=vmdetails" class="ico ico_wrench"
                           title="{$lang.edit}">{$lang.edit}</a>
                        <a href="{$service_url}&vpsdo=destroy&vpsid={$vm.vpsid}&security_token={$security_token}"
                           onclick="return  confirm('{$lang.sure_to_destroy}?')" class="ico ico_cross"
                           title="{$lang.delete}">{$lang.delete}</a>
                    </td>
                </tr>
            {/foreach}
        {else}
            <tr>
                <td colspan="6" align="center">{$lang.nomachinesnote}, <a
                            href="{$service_url}&vpsdo=createvm">{$lang.addservernote}</a>.
                </td>
            </tr>
        {/if}
        </tbody>
    </table>
    {literal}
    <script type="text/javascript">
        $('[id^="vmswitch_"]').each(function () {
            var that = this;
            $.post('{/literal}?cmd=clientarea&action=services&service={$service.id}&vpsid={$vm.vpsid}&vpsdo=vmdetails&status{literal}', {
                vpsid: $(this).attr('rel'),
                vpsdo: 'vmdetails'
            }, function (data) {
                $(that).html(data)
            });
        });
    </script>
    {/literal}
</div>
{include file="`$onappdir`footer.cloud.tpl"}