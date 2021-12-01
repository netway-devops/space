{if !$do}
    <table class="data-table backups-list"  width="100%" cellspacing=0>
        <thead>
            <tr>
                <td>{$lang.size}</td>
                <td>{$lang.type}</td>
                <td>{$lang.Built}</td>
                {if !$vm.support_incremental_backups}  
                    <td>{$lang.Autobackup}</td>
                {/if}
                <td width="120"></td>
            </tr>
        </thead>
        {foreach item=disk from=$disks}
            <tr>
                <td align="right">{$disk->_disk_size} GB</td>
                <td>
                    {if $disk->_primary == "true"}
                        {$lang.standardpri}
                    {elseif $disk->_is_swap == "true"}
                        {$lang.swaplabel}
                    {else}
                        {$lang.standardd}
                    {/if}
                </td>
                <td>
                    {if $disk->_built == "true"}
                        {$lang.yes}
                    {else}
                        {$lang.no}
                    {/if}
                </td>
                {if !$vm.support_incremental_backups}  
                    <td>
                        {if $disk->_is_swap != "true" && $disk->_locked!="true"}
                            {if $disk->_has_autobackups == "true"}
                                <a href="?cmd=clientarea&action=services&service={$service.id}&vpsdo=disks&vpsid={$vpsid}&do=autobackupoff&diskid={$disk->_id}&security_token={$security_token}" 
                                   class="iphone_switch_container iphone_switch_container_on" 
                                   onclick="return powerchange(this, '{$lang.suretodisableautobackup}');">
                                    <img src="includes/types/onappcloud/images/iphone_switch_container_off.png" alt="{$lang.Off}" />
                                </a>
                            {else}
                                <a href="?cmd=clientarea&action=services&service={$service.id}&vpsdo=disks&vpsid={$vpsid}&do=autobackupon&diskid={$disk->_id}&security_token={$security_token}" 
                                   class="iphone_switch_container iphone_switch_container_off" onclick="return powerchange(this, '{$lang.suretoenableautobackup}');">
                                    <img src="includes/types/onappcloud/images/iphone_switch_container_off.png" alt="{$lang.On}" />
                                </a>
                            {/if}
                        {/if}
                    </td>
                {/if}
                <td>
                    {if $disk->_is_swap != "true"}
                        {if $disk->_locked=="true"}
                            {$lang.locked}
                        {else}
                            {if !$vm.support_incremental_backups}  
                                <a title="{$lang.backup}" href="?cmd=clientarea&action=services&service={$service.id}&vpsdo=backups&do=create&diskid={$disk->_id}&vpsid={$vpsid}&security_token={$security_token}" 
                                   onclick="return confirm('{$lang.suretocreatebkp}');" class="small_control small_backup fs11" >
                                    {$lang.backup}
                                </a>

                                {if $showschedules} <br/>
                                    <a title="{$lang.backupschedule}" href="?cmd=clientarea&action=services&service={$service.id}&vpsdo=backupschedule&diskid={$disk->_id}&vpsid={$vpsid}" 
                                       class="small_control small_backup_schedule fs11" >
                                        {$lang.backupschedule}
                                    </a>
                                {/if}
                            {/if}
                        {/if}
                    {/if}
                </td>
            </tr>
        {foreachelse}
            <tr>
                <td colspan="5">{$lang.nothing}</td>
            </tr>
        {/foreach}
    </table>
    <div style="padding:10px 0px;text-align:right">

        {if $vm.support_incremental_backups}
            <input type="button" class="blue" title="{$lang.backup}" 
                   onclick="if (confirm('{$lang.suretocreatebkp|escape:'javascript'}'))
                                   window.location = '?cmd=clientarea&action=services&service={$service.id}&vpsdo=backups&do=create&vpsid={$vpsid}&security_token={$security_token}'" 
                   value="{$lang.createvmbackup}"/>

        {/if}
    </div>
{/if}