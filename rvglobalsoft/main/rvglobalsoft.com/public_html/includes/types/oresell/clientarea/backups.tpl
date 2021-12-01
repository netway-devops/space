    <table class="data-table backups-list"  width="100%" cellspacing=0>
        <thead>
            <tr>
                <td>{$lang.date}</td>
                <td>{$lang.Disk}</td>
                <td>{$lang.status}</td>
                <td>{$lang.size}</td>
                <td>{$lang.type}</td>
                <td>&nbsp;</td> <td>&nbsp;</td>
            </tr>
        </thead>
        {foreach item=backup from=$backups}
            <tr>
                <td>{$backup->_created_at|regex_replace:"/[TZ]/":' '}</td>
                <td>#{$backup->_disk_id}</td>
                <td>
                    {if $backup->_built == "true" }
                        {$lang.Built}
                    {else}
                        {$lang.Pending}
                    {/if}
                </td>
                <td>
                    {if $backup->_built != "true"}
                        {$lang.notbuilt}
                    {elseif $backup->_backup_size gt 1024}
                        { $backup->_backup_size/1024|round } MB
                    {else}
                        { $backup->_backup_size} K
                    {/if}
                </td>
                <td>
                    {if $backup->_built != "true"}
                        &nbsp;
                    {else}
                {if $backup->_backup_type == 'incremental'}{$lang.vmbackup}{else}{$lang.diskbackup}{/if}
            {/if}
        </td>
        <td>
            {if $backup->_built != "true"}
                &nbsp;
            {else}
                <a href="#" onclick="$('.backup_labels').hide();
                        $('#backup_label_{$backup->_id}').show();
                        return false;" class="small_control small_backup_convert fs11">{$lang.convert2template}</a><br />
                <a href="?cmd=clientarea&action=services&service={$service.id}&vpsdo=backups&vpsid={$vpsid}&do=restore&backupid={$backup->_id}&security_token={$security_token}" onclick="return confirm('{$lang.suretorestorebkp}');" class="small_control small_backup_restore fs11">{$lang.restore}</a>
            {/if}
        </td>
        <td width="60" style="text-align: right">
            <a href="?cmd=clientarea&action=services&service={$service.id}&vpsid={$vpsid}&vpsdo=backups&do=delete&backupid={$backup->_id}&security_token={$security_token}" onclick="return confirm('{$lang.suretodeletebkp}')" class="small_control small_delete fs11">{$lang.delete}</a>
        </td>
    </tr>
{foreachelse}
    <tr>
        <td colspan="7">{$lang.nothing}</td>
    </tr>
{/foreach}
</table>

<div class="btn-group-cloud pull-right">    
    {if $vm.support_incremental_backups}  
        {if $showschedules} 
            <input type="button" class="blue" title="{$lang.backup}" 
                   onclick="window.location = '?cmd=clientarea&action=services&service={$service.id}&vpsdo=backupschedule&vpsid={$vpsid}'" 
                   value="{$lang.backupschedule}"/>
        {elseif $o_sections.o_backup_auto}
            {if $autobackup}
                <a href="?cmd=clientarea&action=services&service={$service.id}&vpsdo=disks&vpsid={$vpsid}&do=autobackupoff&security_token={$security_token}" 
                   onclick="return confirm('{$lang.suretodisableautobackup}');" class="btn btn-warning">Disable autobackup
                </a>
            {else}
                <a href="?cmd=clientarea&action=services&service={$service.id}&vpsdo=disks&vpsid={$vpsid}&do=autobackupon&security_token={$security_token}" 
                   onclick="return confirm('{$lang.suretoenableautobackup}');" class="btn btn-info">{$lang.enableautobackup}
                </a>
            {/if}
        {/if}
    {/if}
</div>
<div class=" clear"></div>



{foreach item=backup from=$backups}
    <div id="backup_label_{$backup->_id}" style="display:none" class="backup_labels">
        <form method="post" action="">
            <table width="100%" cellspacing="0" cellpadding="0" border="0" class="data-table backups-list" style="margin-top:10px;">
                <tr>
                    <td colspan="2">
                        <span class="wrap-text">
                            {$lang.backupconversion_desc}
                        </span>
                        <input type="hidden" name="do" value="convert" />
                        <input type="hidden" name="backupid" value="{$backup->_id}" />
                    </td>
                </tr>
                <tr class="lastone">
                    <td colspan="2"><span class="slabel">{$lang.label}</span><input type="text" size="30"  name="label"  class="styled" />
                        <input type="submit" value="{$lang.convertbackup}" class="blue" /></td>
                </tr>


            </table>  {securitytoken}</form>
    </div>
{/foreach}
