<div class="wbox_content">
    {include file="`$smarty.const.APPDIR`types/widgets/widget_description.tpl"}
</div>
{if $cperror}
    <div style="border-radius: 6px 6px 6px 6px; background: url('icons/ico_warn.gif') no-repeat scroll 8px 8px #FFFBCC; border: 1px solid #E6DB55;color: #FF0000;font-weight: bold;margin-bottom: 8px;padding: 8px 8px 8px 30px;">
        {$lang.couldconectto} <strong>{$lang.cpanel_name}</strong>
        <br />
        {$lang.checkyourloginpassword}
    </di>
{else}
    <div style="margin: 10px 0; padding: 0 10px;">
        <h2>
            <span id="pageHeading">{$lang.cpanel_cron_jobs}</span>
        </h2>

        <div class="body-content">
            <p id="descCron" class="description">
                {$lang.cpanel_cron_jobs_desc}
            </p>
            <br />
            <div id="crontab_interface" class="section">
                <div class="section">
                    <h3 id="hdrCurrentCronJobs">
                        {$lang.cpanel_current_jobs}
                    </h3>
                    <div id="cron_jobs">
                        <table class="table table-striped" id="cron_jobs_table">
                            <thead>
                                <tr>
                                    <th>{$lang.cpanel_minute}</th>
                                    <th>{$lang.cpanel_hour}</th>
                                    <th>{$lang.cpanel_day}</th>
                                    <th>{$lang.cpanel_month}</th>
                                    <th>{$lang.cpanel_weekday}</th>
                                    <th>{$lang.cpanel_command}</th>
                                    <th>{$lang.cpanel_actions}</th>
                                </tr>
                            </thead>
                            <tbody>
                                {foreach from=$list item=entry}
                                    <tr>
                                        <td >{$entry.minute}</td>
                                        <td >{$entry.hour}</td>
                                        <td >{$entry.day}</td>
                                        <td >{$entry.month}</td>
                                        <td >{$entry.weekday}</td>
                                        <td ><code>{$entry.command|escape}</code></td>
                                        <td >
                                            <a href="{$widget_url}&act=del&line={$entry.commandnumber}&security_token={$security_token}"
                                               class="cp-btn" onclick="return confirm('{$lang.cpanel_delete_entry_q}')">
                                                <span class="fa fa-trash" title="{$lang.cpanel_remove}"></span>
                                            </a>
                                        </td>
                                    </tr>
                                {foreachelse}
                                    <tr>
                                        <td colspan="7">{$lang.cpanel_no_jobs}</td>
                                    </tr>
                                {/foreach}

                            </tbody>
                        </table>
                    </div>
                </div>

                <div class="section">
                    <h3 id="hdrAddCronJob">
                        {$lang.cpanel_add_job}
                    </h3>

                    <form id="domainform" action="{$widget_url}&act=add" method="POST">
                        <div class="form-group">
                            <label id="lblCommonSettings" for="common_options">
                                {$lang.cpanel_common_settings}
                            </label>
                            <div class="row-fluid">
                                <div class="span6">
                                    <select id="common_options" class="form-control">
                                        <option value="--">
                                            {$lang.cpanel_job_common_settings}
                                        </option>
                                        <option value="* * * * *">
                                            {$lang.cpanel_job_common_minute}
                                        </option>
                                        <option value="*/5 * * * *">
                                            {$lang.cpanel_job_common_5_minutes}
                                        </option>
                                        <option value="0,30 * * * *">
                                            {$lang.cpanel_job_common_twice_hour}
                                        </option>
                                        <option value="0 * * * *">
                                            {$lang.cpanel_job_common_hour}
                                        </option>
                                        <option value="0 0,12 * * *">
                                            {$lang.cpanel_job_common_twice_day}
                                        </option>
                                        <option value="0 0 * * *">
                                            {$lang.cpanel_job_common_day}
                                        </option>
                                        <option value="0 0 * * 0">
                                            {$lang.cpanel_job_common_week}
                                        </option>
                                        <option value="0 0 1,15 * *">
                                            {$lang.cpanel_job_common_1_15}
                                        </option>
                                        <option value="0 0 1 * *">
                                            {$lang.cpanel_job_common_month}
                                        </option>
                                        <option value="0 0 1 1 *">
                                            {$lang.cpanel_job_common_year}
                                        </option>
                                    </select>
                                </div>
                                <div class="span6">
                                </div>
                            </div>
                        </div>
                        <div class="form-group">
                            <label id="lblMinute" for="minute">
                                {$lang.cpanel_minute}
                            </label>
                            <div class="row-fluid">
                                <div class="span2">
                                    <input id="minute" class="form-control " name="minute" type="text">
                                </div>
                                <div class="span4">
                                    <select id="minute_options" class="form-control" >
                                        <option value="--">
                                            {$lang.cpanel_job_common_settings}
                                        </option>
                                        <option value="*">
                                            {$lang.cpanel_job_minute}
                                        </option>
                                        <option value="*/2">
                                            {$lang.cpanel_job_other_minute}
                                        </option>
                                        <option value="*/5">
                                            {$lang.cpanel_job_5_minutes}
                                        </option>
                                        <option value="*/10">
                                            {$lang.cpanel_job_10_minutes}
                                        </option>
                                        <option value="*/15">
                                            {$lang.cpanel_job_15_minutes}
                                        </option>
                                        <option value="0,30">
                                            {$lang.cpanel_job_30_minutes}
                                        </option>
                                        <option value="--">
                                            {$lang.cpanel_job_minutes}
                                        </option>
                                        <option value="0">
                                            {$lang.cpanel_job_00_hour}
                                        </option>
                                        <option value="1">
                                            :01 (1)
                                        </option>
                                        <option value="2">
                                            :02 (2)
                                        </option>
                                        <option value="3">
                                            :03 (3)
                                        </option>
                                        <option value="4">
                                            :04 (4)
                                        </option>
                                        <option value="5">
                                            :05 (5)
                                        </option>
                                        <option value="6">
                                            :06 (6)
                                        </option>
                                        <option value="7">
                                            :07 (7)
                                        </option>
                                        <option value="8">
                                            :08 (8)
                                        </option>
                                        <option value="9">
                                            :09 (9)
                                        </option>
                                        <option value="10">
                                            :10 (10)
                                        </option>
                                        <option value="11">
                                            :11 (11)
                                        </option>
                                        <option value="12">
                                            :12 (12)
                                        </option>
                                        <option value="13">
                                            :13 (13)
                                        </option>
                                        <option value="14">
                                            :14 (14)
                                        </option>
                                        <option value="15">
                                            {$lang.cpanel_job_15_quarter}
                                        </option>
                                        <option value="16">
                                            :16 (16)
                                        </option>
                                        <option value="17">
                                            :17 (17)
                                        </option>
                                        <option value="18">
                                            :18 (18)
                                        </option>
                                        <option value="19">
                                            :19 (19)
                                        </option>
                                        <option value="20">
                                            :20 (20)
                                        </option>
                                        <option value="21">
                                            :21 (21)
                                        </option>
                                        <option value="22">
                                            :22 (22)
                                        </option>
                                        <option value="23">
                                            :23 (23)
                                        </option>
                                        <option value="24">
                                            :24 (24)
                                        </option>
                                        <option value="25">
                                            :25 (25)
                                        </option>
                                        <option value="26">
                                            :26 (26)
                                        </option>
                                        <option value="27">
                                            :27 (27)
                                        </option>
                                        <option value="28">
                                            :28 (28)
                                        </option>
                                        <option value="29">
                                            :29 (29)
                                        </option>
                                        <option value="30">
                                            {$lang.cpanel_job_30_half}
                                        </option>
                                        <option value="31">
                                            :31 (31)
                                        </option>
                                        <option value="32">
                                            :32 (32)
                                        </option>
                                        <option value="33">
                                            :33 (33)
                                        </option>
                                        <option value="34">
                                            :34 (34)
                                        </option>
                                        <option value="35">
                                            :35 (35)
                                        </option>
                                        <option value="36">
                                            :36 (36)
                                        </option>
                                        <option value="37">
                                            :37 (37)
                                        </option>
                                        <option value="38">
                                            :38 (38)
                                        </option>
                                        <option value="39">
                                            :39 (39)
                                        </option>
                                        <option value="40">
                                            :40 (40)
                                        </option>
                                        <option value="41">
                                            :41 (41)
                                        </option>
                                        <option value="42">
                                            :42 (42)
                                        </option>
                                        <option value="43">
                                            :43 (43)
                                        </option>
                                        <option value="44">
                                            :44 (44)
                                        </option>
                                        <option value="45">
                                            {$lang.cpanel_job_45_quarter}
                                        </option>
                                        <option value="46">
                                            :46 (46)
                                        </option>
                                        <option value="47">
                                            :47 (47)
                                        </option>
                                        <option value="48">
                                            :48 (48)
                                        </option>
                                        <option value="49">
                                            :49 (49)
                                        </option>
                                        <option value="50">
                                            :50 (50)
                                        </option>
                                        <option value="51">
                                            :51 (51)
                                        </option>
                                        <option value="52">
                                            :52 (52)
                                        </option>
                                        <option value="53">
                                            :53 (53)
                                        </option>
                                        <option value="54">
                                            :54 (54)
                                        </option>
                                        <option value="55">
                                            :55 (55)
                                        </option>
                                        <option value="56">
                                            :56 (56)
                                        </option>
                                        <option value="57">
                                            :57 (57)
                                        </option>
                                        <option value="58">
                                            :58 (58)
                                        </option>
                                        <option value="59">
                                            :59 (59)
                                        </option>
                                    </select>
                                </div>
                                <div style="width: 16px; height: 16px;" id="minute_error" class="span6 cjt_validation_error">
                                </div>
                            </div>
                        </div>
                        <div class="form-group">
                            <label id="lblHour" for="hour">
                                {$lang.cpanel_hour}
                            </label>
                            <div class="row-fluid">
                                <div class="span2">
                                    <input id="hour" class="form-control " name="hour" type="text">
                                </div>
                                <div class="span4">
                                    <select id="hour_options" class="form-control" >
                                        <option value="--">
                                            {$lang.cpanel_job_common_settings}
                                        </option>
                                        <option value="*">
                                            {$lang.cpanel_job_hour}
                                        </option>
                                        <option value="*/2">
                                            {$lang.cpanel_job_other_hour}
                                        </option>
                                        <option value="*/3">
                                            {$lang.cpanel_job_3_hours}
                                        </option>
                                        <option value="*/4">
                                            {$lang.cpanel_job_4_hours}
                                        </option>
                                        <option value="*/6">
                                            {$lang.cpanel_job_6_hours}
                                        </option>
                                        <option value="0,12">
                                            {$lang.cpanel_job_12_hours}
                                        </option>
                                        <option value="--">
                                            {$lang.cpanel_job_hours}
                                        </option>
                                        <option value="0">
                                            {$lang.cpanel_job_hours_a12}
                                        </option>
                                        <option value="1">
                                            {$lang.cpanel_job_hours_a1}
                                        </option>
                                        <option value="2">
                                            {$lang.cpanel_job_hours_a2}
                                        </option>
                                        <option value="3">
                                            {$lang.cpanel_job_hours_a3}
                                        </option>
                                        <option value="4">
                                            {$lang.cpanel_job_hours_a4}
                                        </option>
                                        <option value="5">
                                            {$lang.cpanel_job_hours_a5}
                                        </option>
                                        <option value="6">
                                            {$lang.cpanel_job_hours_a6}
                                        </option>
                                        <option value="7">
                                            {$lang.cpanel_job_hours_a7}
                                        </option>
                                        <option value="8">
                                            {$lang.cpanel_job_hours_a8}
                                        </option>
                                        <option value="9">
                                            {$lang.cpanel_job_hours_a9}
                                        </option>
                                        <option value="10">
                                            {$lang.cpanel_job_hours_a10}
                                        </option>
                                        <option value="11">
                                            {$lang.cpanel_job_hours_a11}
                                        </option>
                                        <option value="12">
                                            {$lang.cpanel_job_hours_p12}
                                        </option>
                                        <option value="13">
                                            {$lang.cpanel_job_hours_p1}
                                        </option>
                                        <option value="14">
                                            {$lang.cpanel_job_hours_p2}
                                        </option>
                                        <option value="15">
                                            {$lang.cpanel_job_hours_p3}
                                        </option>
                                        <option value="16">
                                            {$lang.cpanel_job_hours_p4}
                                        </option>
                                        <option value="17">
                                            {$lang.cpanel_job_hours_p5}
                                        </option>
                                        <option value="18">
                                            {$lang.cpanel_job_hours_p6}
                                        </option>
                                        <option value="19">
                                            {$lang.cpanel_job_hours_p7}
                                        </option>
                                        <option value="20">
                                            {$lang.cpanel_job_hours_p8}
                                        </option>
                                        <option value="21">
                                            {$lang.cpanel_job_hours_p9}
                                        </option>
                                        <option value="22">
                                            {$lang.cpanel_job_hours_p10}
                                        </option>
                                        <option value="23">
                                            {$lang.cpanel_job_hours_p11}
                                        </option>
                                    </select>
                                </div>
                                <div style="width: 16px; height: 16px;" id="hour_error" class="span6 cjt_validation_error">
                                </div>
                            </div>
                        </div>
                        <div class="form-group">
                            <label id="lblDay" for="day">
                                {$lang.cpanel_day}
                            </label>
                            <div class="row-fluid">
                                <div class="span2">
                                    <input class="form-control " id="day"  name="day" type="text">
                                </div>
                                <div class="span4">
                                    <select id="day_options" class="form-control">
                                        <option value="--">
                                            {$lang.cpanel_job_common_settings}
                                        </option>
                                        <option value="*">
                                            {$lang.cpanel_job_day}
                                        </option>
                                        <option value="*/2">
                                            {$lang.cpanel_job_other_day}
                                        </option>
                                        <option value="1,15">
                                            {$lang.cpanel_job_1_and_15}
                                        </option>
                                        <option value="--">
                                            {$lang.cpanel_job_days}
                                        </option>
                                        <option value="1">
                                            1{$lang.cpanel_job_st} (1)
                                        </option>
                                        <option value="2">
                                            2{$lang.cpanel_job_nd} (2)
                                        </option>
                                        <option value="3">
                                            3{$lang.cpanel_job_rd} (3)
                                        </option>
                                        <option value="4">
                                            4{$lang.cpanel_job_th} (4)
                                        </option>
                                        <option value="5">
                                            5{$lang.cpanel_job_th} (5)
                                        </option>
                                        <option value="6">
                                            6{$lang.cpanel_job_th} (6)
                                        </option>
                                        <option value="7">
                                            7{$lang.cpanel_job_th} (7)
                                        </option>
                                        <option value="8">
                                            8{$lang.cpanel_job_th} (8)
                                        </option>
                                        <option value="9">
                                            9{$lang.cpanel_job_th} (9)
                                        </option>
                                        <option value="10">
                                            10{$lang.cpanel_job_th} (10)
                                        </option>
                                        <option value="11">
                                            11{$lang.cpanel_job_th} (11)
                                        </option>
                                        <option value="12">
                                            12{$lang.cpanel_job_th} (12)
                                        </option>
                                        <option value="13">
                                            13{$lang.cpanel_job_th} (13)
                                        </option>
                                        <option value="14">
                                            14{$lang.cpanel_job_th} (14)
                                        </option>
                                        <option value="15">
                                            15{$lang.cpanel_job_th} (15)
                                        </option>
                                        <option value="16">
                                            16{$lang.cpanel_job_th} (16)
                                        </option>
                                        <option value="17">
                                            17{$lang.cpanel_job_th} (17)
                                        </option>
                                        <option value="18">
                                            18{$lang.cpanel_job_th} (18)
                                        </option>
                                        <option value="19">
                                            19{$lang.cpanel_job_th} (19)
                                        </option>
                                        <option value="20">
                                            20{$lang.cpanel_job_th} (20)
                                        </option>
                                        <option value="21">
                                            21{$lang.cpanel_job_st} (21)
                                        </option>
                                        <option value="22">
                                            22{$lang.cpanel_job_nd} (22)
                                        </option>
                                        <option value="23">
                                            23{$lang.cpanel_job_rd} (23)
                                        </option>
                                        <option value="24">
                                            24{$lang.cpanel_job_th} (24)
                                        </option>
                                        <option value="25">
                                            25{$lang.cpanel_job_th} (25)
                                        </option>
                                        <option value="26">
                                            26{$lang.cpanel_job_th} (26)
                                        </option>
                                        <option value="27">
                                            27{$lang.cpanel_job_th} (27)
                                        </option>
                                        <option value="28">
                                            28{$lang.cpanel_job_th} (28)
                                        </option>
                                        <option value="29">
                                            29{$lang.cpanel_job_th} (29)
                                        </option>
                                        <option value="30">
                                            30{$lang.cpanel_job_th} (30)
                                        </option>
                                        <option value="31">
                                            31{$lang.cpanel_job_st} (31)
                                        </option>
                                    </select>
                                </div>
                                <div style="width: 16px; height: 16px;" id="day_error" class="span6 cjt_validation_error">
                                </div>
                            </div>
                        </div>
                        <div class="form-group">
                            <label id="lblMonth" for="month">
                                {$lang.cpanel_month}
                            </label>
                            <div class="row-fluid">
                                <div class="span2">
                                    <input class="form-control " id="month" name="month" type="text">
                                </div>
                                <div class="span4">
                                    <select id="month_options" class="form-control">
                                        <option value="--">
                                            {$lang.cpanel_job_common_settings}
                                        </option>
                                        <option value="*">
                                            {$lang.cpanel_job_month}
                                        </option>
                                        <option value="*/2">
                                            {$lang.cpanel_job_other_month}
                                        </option>
                                        <option value="*/4">
                                            {$lang.cpanel_job_3_months}
                                        </option>
                                        <option value="1,7">
                                            {$lang.cpanel_job_6_months}
                                        </option>
                                        <option value="--">
                                            {$lang.cpanel_job_months}
                                        </option>
                                        <option value="1">
                                            {$lang.cpanel_job_january}
                                        </option>
                                        <option value="2">
                                            {$lang.cpanel_job_february}
                                        </option>
                                        <option value="3">
                                            {$lang.cpanel_job_march}
                                        </option>
                                        <option value="4">
                                            {$lang.cpanel_job_april}
                                        </option>
                                        <option value="5">
                                            {$lang.cpanel_job_may}
                                        </option>
                                        <option value="6">
                                            {$lang.cpanel_job_june}
                                        </option>
                                        <option value="7">
                                            {$lang.cpanel_job_july}
                                        </option>
                                        <option value="8">
                                            {$lang.cpanel_job_august}
                                        </option>
                                        <option value="9">
                                            {$lang.cpanel_job_september}
                                        </option>
                                        <option value="10">
                                            {$lang.cpanel_job_october}
                                        </option>
                                        <option value="11">
                                            {$lang.cpanel_job_november}
                                        </option>
                                        <option value="12">
                                            {$lang.cpanel_job_december}
                                        </option>
                                    </select>
                                </div>
                                <div style="width: 16px; height: 16px;" id="month_error" class="span6 cjt_validation_error">
                                </div>
                            </div>
                        </div>
                        <div class="form-group">
                            <label id="lblWeekday" for="weekday">
                                {$lang.cpanel_weekday}
                            </label>
                            <div class="row-fluid">
                                <div class="span2">
                                    <input class="form-control " id="weekday" name="weekday" type="text">
                                </div>
                                <div class="span4">
                                    <select id="weekday_options" class="form-control" >
                                        <option value="--">
                                            {$lang.cpanel_job_common_settings}
                                        </option>
                                        <option value="*">
                                            {$lang.cpanel_job_weekday}
                                        </option>
                                        <option value="1-5">
                                            {$lang.cpanel_job_mon_fri}
                                        </option>
                                        <option value="0,6">
                                            {$lang.cpanel_job_sat_sun}
                                        </option>
                                        <option value="1,3,5">
                                            {$lang.cpanel_job_mon_wed_fri}
                                        </option>
                                        <option value="2,4">
                                            {$lang.cpanel_job_tues_thurs}
                                        </option>
                                        <option value="--">
                                            {$lang.cpanel_job_weekdays}
                                        </option>
                                        <option value="0">
                                            {$lang.cpanel_job_sunday}
                                        </option>
                                        <option value="1">
                                            {$lang.cpanel_job_monday}
                                        </option>
                                        <option value="2">
                                            {$lang.cpanel_job_tuesday}
                                        </option>
                                        <option value="3">
                                            {$lang.cpanel_job_wednesday}
                                        </option>
                                        <option value="4">
                                            {$lang.cpanel_job_thursday}
                                        </option>
                                        <option value="5">
                                            {$lang.cpanel_job_friday}
                                        </option>
                                        <option value="6">
                                            {$lang.cpanel_job_saturday}
                                        </option>
                                    </select>
                                </div>
                                <div style="width: 16px; height: 16px;" id="weekday_error" class="span6 cjt_validation_error">
                                </div>
                            </div>
                        </div>
                        <div class="form-group">
                            <label id="lblCommand" for="command">
                                {$lang.cpanel_command}
                            </label>
                            <div class="row-fluid">
                                <div class="span6">
                                    <input class="form-control" size="45" id="command" name="command" type="text">
                                </div>
                                <div style="width: 16px; height: 16px;" id="command_error" class="span6 cjt_validation_error">
                                </div>
                            </div>
                        </div>
                        <div class="form-group">
                            <input id="add_new_cron" class="btn btn-flat-primary btn-primary" value="{$lang.cpanel_add_job}" type="submit">
                            <span id="add_new_cron_status">
                            </span>
                        </div>
                        {securitytoken}
                    </form>                        
                </div>
            </div>
        </div>
    </div>
    <script src="{$widgetdir_url}script.js" type="text/javascript"></script>   
    <link media="all" type="text/css" rel="stylesheet" href="{$widgetdir_url}../css/font-awesome.min.css">
    <link media="all" type="text/css" rel="stylesheet" href="{$widgetdir_url}../css/cp.css">
{/if}