<table class="data-table backups-list"  width="100%" cellspacing=0>
    <thead>
        <tr>
            <td>{$lang.date}</td>
            <td>{$lang.Disk}</td>
            <td>{$lang.status}</td>
            <td>{$lang.type}</td>
            <td>&nbsp;</td> <td>&nbsp;</td>
        </tr>
    </thead>
    {foreach item=backup from=$backups}
        <tr>
            <td>{$backup.created|regex_replace:"/[T]/":' '}</td>
            <td>#{$backup.volumename}</td>
            <td>
                {if $backup.state == "BackedUp" }
                    {$lang.Built}
                {else}
                    {$lang.Pending}
                {/if}
            </td>

            <td>{$backup.snapshottype} </td>
            <td>
                {if $backup.state != "BackedUp"}
                    &nbsp;
                {elseif $provisioning_type!='single'}
                    <a href="#" onclick="$('.backup_labels').hide();
                            $('#backup_label_{$backup.id}').show(); $('.convert-to').hide().filter('.to-template').show(); $('#convert').val('convert');
                            return false;" class="small_control small_backup_convert fs11">{$lang.convert2template}</a><br />
                    <a href="#" onclick="$('.backup_labels').hide();
                            $('#backup_label_{$backup.id}').show(); $('.convert-to').hide().filter('.to-volume').show(); $('#convert').val('volume');
                            return false;" class="small_control small_backup_convert fs11">{$lang.convertvolume}</a><br />
                    {*}<a href="?cmd=clientarea&action=services&service={$service.id}&vpsdo=backups&vpsid={$vpsid}&do=restore&backupid={$backup.id}&security_token={$security_token}" onclick="return confirm('{$lang.suretorestorebkp}');" class="small_control small_backup_restore fs11">{$lang.restore}</a>{*}
                {/if}
            </td>
            <td width="60" style="text-align: right">
                <a href="?cmd=clientarea&action=services&service={$service.id}&vpsid={$vpsid}&vpsdo=backups&do=delete&backupid={$backup.id}&security_token={$security_token}" onclick="return confirm('{$lang.suretodeletebkp}')" class="small_control small_delete fs11">{$lang.delete}</a>
            </td>
        </tr>
    {foreachelse}
        <tr>
            <td colspan="7">{$lang.nothing}</td>
        </tr>
    {/foreach}
</table>




{foreach item=backup from=$backups}
    <div id="backup_label_{$backup.id}" style="display:none" class="backup_labels">
        <form method="post" action="">
            <table width="100%" cellspacing="0" cellpadding="0" border="0" class="data-table backups-list" style="margin-top:10px;">
                <tr>
                    <td colspan="2">
                        <span class="convert-to to-template">
                            {$lang.snapshotconversiondesc} 
                            {$lang.convertyoursnapsho} 
                        </span>
                        <span class="convert-to to-volume">
                            {$lang.snapshotconversionvolume} 
                            {$lang.convertyoursnapsho} 
                        </span>
                        <input type="hidden" name="do" value="convert" id="convert"/>
                        <input type="hidden" name="backupid" value="{$backup.id}" />
                    </td>
                </tr>
                <tr class="lastone">
                    <td colspan="2">
                        <span class="slabel">{$lang.label}</span>
                        <input type="text" size="30"  name="label"  class="styled" />
                        <input type="submit" value="{$lang.convert2template}" class="blue convert-to to-template" />
                        <input type="submit" value="{$lang.convertvolume}" class="blue convert-to to-volume" />
                    </td>
                </tr>


            </table>  {securitytoken}
        </form>
    </div>
{/foreach}
