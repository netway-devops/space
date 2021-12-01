<table class="data-table backups-list"  width="100%" cellspacing=0>
    <thead>
        <tr>
            <td>{$lang.backupevery}</td>
            <td>{$lang.timezone}</td>
            <td>{$lang.nextbackup}</td>
            <td>{$lang.maxsnapshots}</td>
            <td width="120"></td>
        </tr>
    </thead>
    {foreach item=schedule from=$schedules}
        <tr>
            <td align="right">{$schedule.duration}
                {if $schedule.intervaltype=='2'}
                    {$lang.yweek|capitalize}
                {elseif $schedule.intervaltype=='1'}
                    {$lang.yday|capitalize}
                {elseif $schedule.intervaltype=='3'}
                    {$lang.ymonth|capitalize}
                {elseif $schedule.intervaltype=='0'}
                    {$lang.yhour}
                {/if}
            </td>
            <td>
                {$schedule.timezone}
            </td>
            <td>
                {$schedule.start_at|dateformat:$date_format}
            </td>
            <td>
                {$schedule.maxsnaps}
            </td>
            <td>
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
<div id='addschedule' style="display:none;">
    <form action="" method="post" id>
        <input type="hidden" name="make" value="addschedule"/>

        <br/><h3> {$lang.addschedule}: </h3>
        <table class="data-table backups-list"  cellspacing="0" style="border-top:solid 1px #DDDDDD; width: 100%">

            <tr>
                <td colspan="6">
                    <b>{$lang.backupevery}:</b>
                </td>
            </tr>
            <tr>
                <td>
                    <b>{$lang.time}</b><br />
                    <select id="hour" name="hour" class="styled period monthly weekly daily" style="width: 50px"></select>
                    <select id="min" name="min" class="styled" style="width: 50px"></select>
                </td>
                <td>
                    <span class="period monthly weekly">
                        <b>
                            <span class="period monthly">{$lang.daymonth}</span>
                            <span class="period weekly">{$lang.dayweek}</span>
                        </b><br />
                        <select id="day" name="day" class="styled period monthly weekly" style="width: 50px"></select>
                    </span>
                </td>
                <td><br />
                    <select name="period" id="period" class="styled span2">
                        <option value="HOURLY" >{$lang.yhour}</option>
                        <option value="DAILY">{$lang.yday|capitalize}</option>
                        <option value="WEEKLY">{$lang.yweek|capitalize}</option>
                        <option value="MONTHLY" >{$lang.ymonth|capitalize}</option>
                    </select>
                </td>
                <td>
                    <b>{$lang.timezone}</b><br />
                    <select name="timezone" class="styled span3"><option value="Etc/GMT+12">[UTC-12:00] GMT-12:00</option><option value="Etc/GMT+11">[UTC-11:00] GMT-11:00</option><option value="Pacific/Samoa">[UTC-11:00] Samoa Standard Time</option><option value="Pacific/Honolulu">[UTC-10:00] Hawaii Standard Time</option><option value="US/Alaska">[UTC-09:00] Alaska Standard Time</option><option value="America/Los_Angeles">[UTC-08:00] Pacific Standard Time</option><option value="Mexico/BajaNorte">[UTC-08:00] Baja California</option><option value="US/Arizona">[UTC-07:00] Arizona</option><option value="US/Mountain">[UTC-07:00] Mountain Standard Time</option><option value="America/Chihuahua">[UTC-07:00] Chihuahua, La Paz</option><option value="America/Chicago">[UTC-06:00] Central Standard Time</option><option value="America/Costa_Rica">[UTC-06:00] Central America</option><option value="America/Mexico_City">[UTC-06:00] Mexico City, Monterrey</option><option value="Canada/Saskatchewan">[UTC-06:00] Saskatchewan</option><option value="America/Bogota">[UTC-05:00] Bogota, Lima</option><option value="America/New_York">[UTC-05:00] Eastern Standard Time</option><option value="America/Caracas">[UTC-04:00] Venezuela Time</option><option value="America/Asuncion">[UTC-04:00] Paraguay Time</option><option value="America/Cuiaba">[UTC-04:00] Amazon Time</option><option value="America/Halifax">[UTC-04:00] Atlantic Standard Time</option><option value="America/La_Paz">[UTC-04:00] Bolivia Time</option><option value="America/Santiago">[UTC-04:00] Chile Time</option><option value="America/St_Johns">[UTC-03:30] Newfoundland Standard Time</option><option value="America/Araguaina">[UTC-03:00] Brasilia Time</option><option value="America/Argentina/Buenos_Aires">[UTC-03:00] Argentine Time</option><option value="America/Cayenne">[UTC-03:00] French Guiana Time</option><option value="America/Godthab">[UTC-03:00] Greenland Time</option><option value="America/Montevideo">[UTC-03:00] Uruguay Time]</option><option value="Etc/GMT+2">[UTC-02:00] GMT-02:00</option><option value="Atlantic/Azores">[UTC-01:00] Azores Time</option><option value="Atlantic/Cape_Verde">[UTC-01:00] Cape Verde Time</option><option value="Africa/Casablanca">[UTC] Casablanca</option><option value="Etc/UTC">[UTC] Coordinated Universal Time</option><option value="Atlantic/Reykjavik">[UTC] Reykjavik</option><option value="Europe/London">[UTC] Western European Time</option><option value="CET">[UTC+01:00] Central European Time</option><option value="Europe/Bucharest">[UTC+02:00] Eastern European Time</option><option value="Africa/Johannesburg">[UTC+02:00] South Africa Standard Time</option><option value="Asia/Beirut">[UTC+02:00] Beirut</option><option value="Africa/Cairo">[UTC+02:00] Cairo</option><option value="Asia/Jerusalem">[UTC+02:00] Israel Standard Time</option><option value="Europe/Minsk">[UTC+02:00] Minsk</option><option value="Europe/Moscow">[UTC+03:00] Moscow Standard Time</option><option value="Africa/Nairobi">[UTC+03:00] Eastern African Time</option><option value="Asia/Karachi">[UTC+05:00] Pakistan Time</option><option value="Asia/Kolkata">[UTC+05:30] India Standard Time</option><option value="Asia/Bangkok">[UTC+05:30] Indochina Time</option><option value="Asia/Shanghai">[UTC+08:00] China Standard Time</option><option value="Asia/Kuala_Lumpur">[UTC+08:00] Malaysia Time</option><option value="Australia/Perth">[UTC+08:00] Western Standard Time (Australia)</option><option value="Asia/Taipei">[UTC+08:00] Taiwan</option><option value="Asia/Tokyo">[UTC+09:00] Japan Standard Time</option><option value="Asia/Seoul">[UTC+09:00] Korea Standard Time</option><option value="Australia/Adelaide">[UTC+09:30] Central Standard Time (South Australia)</option><option value="Australia/Darwin">[UTC+09:30] Central Standard Time (Northern Territory)</option><option value="Australia/Brisbane">[UTC+10:00] Eastern Standard Time (Queensland)</option><option value="Australia/Canberra">[UTC+10:00] Eastern Standard Time (New South Wales)</option><option value="Pacific/Guam">[UTC+10:00] Chamorro Standard Time</option><option value="Pacific/Auckland">[UTC+12:00] New Zealand Standard Time</option></select>
                </td>
                <td>
                    <b>{$lang.snapshotkeep}</b><br />
                    <select id="maxsnap" name="maxsnapshots" class="styled" style="width: 50px"></select>
                    
                </td>
                <td align="center" valign="bottom">
                    <input type="submit" value="{$lang.submit}" style="font-weight:bold;padding:2px 3px;"  class="blue" />
                </td>
            </tr>
        </table>
        {securitytoken}
    </form>
</div>
<div class="clear"></div>
{literal}
    <script type="text/javascript">
                    String.prototype.lpad = function(padString, length) {
                        var str = this;
                        while (str.length < length)
                            str = padString + str;
                        return str;
                    }
                    function _insertOptions(el, from, to, nopad) {
                        el.children().remove();
                        while (from <= to) {
                            
                            var pv = from;
                            if(!nopad)
                                pv = pv.toString().lpad('0', 2);
                            el.append('<option value="' + pv + '">' + pv + '</option>');
                            from++;
                        }
                    }
                    _insertOptions($('#hour'), 0, 24);
                    _insertOptions($('#min'), 0, 58);
                    _insertOptions($('#maxsnap'), 1, {/literal}{$maxsnapshots}{literal}, true);
                    
                    $('#period').change(function() {
                        var that = $(this),
                                val = that.val();
                        $('.period').hide().prop('disabled',true).attr('disabled','disabled').filter('.' + val.toLowerCase()).show().prop('disabled',false).removeAttr('disabled');
                        if (val == 'WEEKLY')
                            _insertOptions($('#day'), 1, 7);
                        if (val == 'MONTHLY')
                            _insertOptions($('#day'), 1, 31);
                    }).change();
    </script>
{/literal}