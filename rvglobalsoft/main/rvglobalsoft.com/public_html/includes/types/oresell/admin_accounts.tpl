{if $layer && $customfile}

<table class="data-table backups-list"  width="100%" cellspacing=0>
    <thead>
        <tr>
            <td></td>
            <td>Label</td>
            <td>Hostname</td>
            <td>IP Address</td>
            <td>Disk Space</td>
            <td>Memory</td>
            <td></td>
            <td></td>
        </tr>
    </thead>
    <tbody>
        {if $MyVMs}
        {foreach from=$MyVMs item=vm name=foo}
        <tr >
            <td class="power-status">{if $vm.power=='true'}<span class="yes">Yes</span>{else}<span class="no">No</span>{/if}</td>
            <td ><a href="{$onappurl}/virtual_machines/{$vm.id}/" target="_blank" class="external"><strong>{$vm.label}</strong></a></td>
            <td>{$vm.hostname}</td>
            <td>{foreach from=$vm.ip item=ipp name=ssff}{$ipp}{if !$smarty.foreach.ssff.last},{/if} {/foreach}</td>

            <td>{$vm.disk} GB</td>
            <td>{$vm.memory} MB</td>
            <td >{if $vm.built=='true'}{if $vm.power=='true'}

                <a  onclick="return power_onp($(this).attr('href'),'off')"  href="?cmd=accounts&action=edit&id={$details.id}&service={$details.id}&vpsdo=clientsvms&security_token={$security_token}&machine_id={$vm.id}&do=power" class="power off-inactive" >OFF</a>
                <a class="power on-active">ON</a>

                {else}
                <a class="power off-active">OFF</a>
                <a  class="power on-inactive" onclick="return power_onp($(this).attr('href'),'on')"  href="?cmd=accounts&action=edit&id={$details.id}&service={$details.id}&security_token={$security_token}&vpsdo=clientsvms&machine_id={$vm.id}&do=power">ON</a>

                {/if}{else}<a class="power pending">{$lang.Pending}</a>{/if}

            </td>
            <td class="fs11">
                <a  href="?cmd=accounts&action=edit&id={$details.id}&service={$details.id}&security_token={$security_token}&vpsdo=clientsvms&machine_id={$vm.id}&do=destroy" onclick="return  destroyVM_onp($(this).attr('href'))" class="delbtn">{$lang.delete}</a>

            </td>
        </tr>
        {/foreach}
        {else}
        <tr>
            <td style="text-align: center; font-size: 100%; width: 100%;" colspan="8">
                This client dont have any machines created yet
            </td>
        </tr>
        {/if}
    </tbody>
</table>
{/if}