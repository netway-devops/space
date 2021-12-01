<table class="data-table backups-list"  width="100%" cellspacing=0>
    <thead>
        <tr>
            <td>{$lang.backupevery}</td>
            <td>{$lang.nextbackup}</td>
            <td>Rotation period</td>
            <td>{$lang.status}</td>
            <td width="120"></td>
        </tr>
    </thead>
    {foreach item=schedule from=$schedules}
        <tr>
            <td align="right">
                {$schedule.duration}
                {if $schedule.period=='weeks'}
                    {$lang.yweek}
                {elseif $schedule.period=='days'}
                    {$lang.yday}
                {elseif $schedule.period=='months'}
                    {$lang.ymonth}
                {elseif $schedule.period=='years'}
                    {$lang.yyear}
                {/if}

            </td>
            <td>
                {$schedule.start_at|dateformat:$date_format}
            </td>
            <td>
                {$schedule.rotation_period}
            </td>
            <td>
                {if $lang[$schedule.status]}{$lang[$schedule.status]}
                {else}{$schedule.status|capitalize}
                {/if}
            </td>
            <td>
                {if $schedule.status=='enabled'}
                    <a title="{$lang.disable}"
                       class="small_control small_backup_schedule fs11"
                       href="{$service_url}&vpsdo=backupschedule&diskid={$diskid}&vpsid={$vpsid}&schedule_id={$schedule.id}&make=toggle&enable=0&security_token={$security_token}" 
                       >
                       {$lang.disable}
                    </a>
                {else}
                     <a title="{$lang.delete}"
                       class="small_control small_backup_schedule fs11"
                       href="{$service_url}&vpsdo=backupschedule&diskid={$diskid}&vpsid={$vpsid}&schedule_id={$schedule.id}&make=toggle&enable=1&security_token={$security_token}" 
                       >
                       {$lang.enable}
                    </a>
                {/if}
                <br />
                <a title="{$lang.delete}" href="?cmd=clientarea&action=services&service={$service.id}&vpsdo=backupschedule&diskid={$diskid}&vpsid={$vpsid}&schedule_id={$schedule.id}&make=deleteschedule&security_token={$security_token}" onclick="return confirm('{$lang.suretodeleteschedule}');" class="small_control small_delete fs11" >
                    {$lang.delete}
                </a>
            </td>
        </tr>
    {foreachelse}
        <tr>
            <td colspan="5">{$lang.nothing}</td>
        </tr>
    {/foreach}
</table>
<div style="padding:10px 0px;text-align:right" class="right">
    <input type="button" value="{$lang.newschedule}" onclick="$('#addschedule').show();
            return false" class="blue">

</div>
<div id="addschedule" style="display:none;" >
    <form action="" method="post" id>
        <input type="hidden" name="make" value="addschedule"/>

        <br/><h3> {$lang.addschedule}: </h3>
        <table class="data-table backups-list"  cellspacing="0" style="border-top:solid 1px #DDDDDD; width: 100%;">
            <tr>
                <td>
                    <b>{$lang.backupevery}:</b><br/>
                    <input name="duration" value="1" size="2" class="styled span2"/> 
                </td>
                <td>
                    <br/>
                    <select name="period" class="span2">
                        <option value="days">{$lang.yday}</option>
                        <option  value="weeks">{$lang.yweek}</option>
                        <option value="months" >{$lang.ymonth}</option>
                        <option value="years" >{$lang.yyear}</option>
                    </select>
                </td>
                <td>
                    <b>Rotation period:</b><br/>
                    <input name="rotation" value="1" size="2" class="styled span2"/> 
                </td>
                <td colspan="2" align="center" valign="bottom">
                    <input type="submit" value="{$lang.submit}" style="font-weight:bold;padding:2px 3px;"  class="blue" />
                </td>
            </tr>
        </table>
        {securitytoken}
    </form>
</div>
<div class="clear"></div>