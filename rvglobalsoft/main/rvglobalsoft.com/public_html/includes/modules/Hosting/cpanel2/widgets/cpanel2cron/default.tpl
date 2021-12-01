{if $cperror}
    <div style="border-radius: 6px 6px 6px 6px; background: url('icons/ico_warn.gif') no-repeat scroll 8px 8px #FFFBCC; border: 1px solid #E6DB55;color: #FF0000;font-weight: bold;margin-bottom: 8px;padding: 8px 8px 8px 30px;">
        {$lang.couldconectto} <strong>CPanel</strong>
        <br />
        {$lang.checkyourloginpassword}
    </di>
{else}
    <div style="margin: 10px 0; padding: 0 10px;">
        <h2>
            <span id="pageHeading">Cron Jobs</span>
        </h2>

        <div class="body-content">
            <p id="descCron" class="description">
                Cron jobs allow you to automate certain commands or scripts on your site. 
                You can set a command or script to run at a specific time every day, week, etc. 
                For example, you could set a cron job to delete temporary files every week to free up disk space.
            </p>
            <br />
            <div id="crontab_interface" class="section">
                <div class="section">
                    <h3 id="hdrCurrentCronJobs">
                        Current Cron Jobs
                    </h3>
                    <div id="cron_jobs">
                        <table class="table table-striped" id="cron_jobs_table">
                            <thead>
                                <tr>
                                    <th>Minute</th>
                                    <th>Hour</th>
                                    <th>Day</th>
                                    <th>Month</th>
                                    <th>Weekday</th>
                                    <th>Command</th>
                                    <th>Actions</th>
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
                                               class="cp-btn" onclick="return confirm('Do You really want to delete this entry?')">
                                                <span class="fa fa-trash" title="Remove"></span>
                                            </a>
                                        </td>
                                    </tr>
                                {foreachelse}
                                    <tr>
                                        <td colspan="7">No Cron Jobs</td>
                                    </tr>
                                {/foreach}

                            </tbody>
                        </table>
                    </div>
                </div>

                <div class="section">
                    <h3 id="hdrAddCronJob">
                        Add New Cron Job
                    </h3>

                    <form id="domainform" action="{$widget_url}&act=add" method="POST">
                        <div class="form-group">
                            <label id="lblCommonSettings" for="common_options">
                                Common Settings
                            </label>
                            <div class="row-fluid">
                                <div class="span6">
                                    <select id="common_options" class="form-control">
                                        <option value="--">
                                            -- Common Settings --
                                        </option>
                                        <option value="* * * * *">
                                            Every minute(* * * * *)
                                        </option>
                                        <option value="*/5 * * * *">
                                            Every 5 minutes(*/5 * * * *)
                                        </option>
                                        <option value="0,30 * * * *">
                                            Twice an hour(0,30 * * * *)
                                        </option>
                                        <option value="0 * * * *">
                                            Once an hour(0 * * * *)
                                        </option>
                                        <option value="0 0,12 * * *">
                                            Twice a day(0 0,12 * * *)
                                        </option>
                                        <option value="0 0 * * *">
                                            Once a day(0 0 * * *)
                                        </option>
                                        <option value="0 0 * * 0">
                                            Once a week(0 0 * * 0)
                                        </option>
                                        <option value="0 0 1,15 * *">
                                            1st and 15th(0 0 1,15 * *)
                                        </option>
                                        <option value="0 0 1 * *">
                                            Once a month(0 0 1 * *)
                                        </option>
                                        <option value="0 0 1 1 *">
                                            Once a year(0 0 1 1 *)
                                        </option>
                                    </select>
                                </div>
                                <div class="span6">
                                </div>
                            </div>
                        </div>
                        <div class="form-group">
                            <label id="lblMinute" for="minute">
                                Minute
                            </label>
                            <div class="row-fluid">
                                <div class="span2">
                                    <input id="minute" class="form-control " name="minute" type="text">
                                </div>
                                <div class="span4">
                                    <select id="minute_options" class="form-control" >
                                        <option value="--">
                                            -- Common Settings --
                                        </option>
                                        <option value="*">
                                            Every minute(*)
                                        </option>
                                        <option value="*/2">
                                            Every other minute(*/2)
                                        </option>
                                        <option value="*/5">
                                            Every 5 minutes(*/5)
                                        </option>
                                        <option value="*/10">
                                            Every 10 minutes(*/10)
                                        </option>
                                        <option value="*/15">
                                            Every 15 minutes(*/15)
                                        </option>
                                        <option value="0,30">
                                            Every 30 minutes(0,30)
                                        </option>
                                        <option value="--">
                                            -- Minutes --
                                        </option>
                                        <option value="0">
                                            :00 top of the hour (0)
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
                                            :15 quarter past (15)
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
                                            :30 half past (30)
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
                                            :45 quarter til (45)
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
                                Hour
                            </label>
                            <div class="row-fluid">
                                <div class="span2">
                                    <input id="hour" class="form-control " name="hour" type="text">
                                </div>
                                <div class="span4">
                                    <select id="hour_options" class="form-control" >
                                        <option value="--">
                                            --
                                            Common Settings
                                            --
                                        </option>
                                        <option value="*">
                                            Every hour
                                            (*)
                                        </option>
                                        <option value="*/2">
                                            Every other hour
                                            (*/2)
                                        </option>
                                        <option value="*/3">
                                            Every 3 hours
                                            (*/3)
                                        </option>
                                        <option value="*/4">
                                            Every 4 hours
                                            (*/4)
                                        </option>
                                        <option value="*/6">
                                            Every 6 hours
                                            (*/6)
                                        </option>
                                        <option value="0,12">
                                            Every 12 hours
                                            (0,12)
                                        </option>
                                        <option value="--">
                                            --
                                            Hours
                                            --
                                        </option>
                                        <option value="0">
                                            12:00 a.m.
                                            midnight
                                            (0)
                                        </option>
                                        <option value="1">
                                            1:00 a.m. (1)
                                        </option>
                                        <option value="2">
                                            2:00 a.m. (2)
                                        </option>
                                        <option value="3">
                                            3:00 a.m. (3)
                                        </option>
                                        <option value="4">
                                            4:00 a.m. (4)
                                        </option>
                                        <option value="5">
                                            5:00 a.m. (5)
                                        </option>
                                        <option value="6">
                                            6:00 a.m. (6)
                                        </option>
                                        <option value="7">
                                            7:00 a.m. (7)
                                        </option>
                                        <option value="8">
                                            8:00 a.m. (8)
                                        </option>
                                        <option value="9">
                                            9:00 a.m. (9)
                                        </option>
                                        <option value="10">
                                            10:00 a.m. (10)
                                        </option>
                                        <option value="11">
                                            11:00 a.m. (11)
                                        </option>
                                        <option value="12">
                                            12:00 p.m.
                                            noon
                                            (12)
                                        </option>
                                        <option value="13">
                                            1:00 p.m. (13)
                                        </option>
                                        <option value="14">
                                            2:00 p.m. (14)
                                        </option>
                                        <option value="15">
                                            3:00 p.m. (15)
                                        </option>
                                        <option value="16">
                                            4:00 p.m. (16)
                                        </option>
                                        <option value="17">
                                            5:00 p.m. (17)
                                        </option>
                                        <option value="18">
                                            6:00 p.m. (18)
                                        </option>
                                        <option value="19">
                                            7:00 p.m. (19)
                                        </option>
                                        <option value="20">
                                            8:00 p.m. (20)
                                        </option>
                                        <option value="21">
                                            9:00 p.m. (21)
                                        </option>
                                        <option value="22">
                                            10:00 p.m. (22)
                                        </option>
                                        <option value="23">
                                            11:00 p.m. (23)
                                        </option>
                                    </select>
                                </div>
                                <div style="width: 16px; height: 16px;" id="hour_error" class="span6 cjt_validation_error">
                                </div>
                            </div>
                        </div>
                        <div class="form-group">
                            <label id="lblDay" for="day">
                                Day
                            </label>
                            <div class="row-fluid">
                                <div class="span2">
                                    <input class="form-control " id="day"  name="day" type="text">
                                </div>
                                <div class="span4">
                                    <select id="day_options" class="form-control">
                                        <option value="--">
                                            --
                                            Common Settings
                                            --
                                        </option>
                                        <option value="*">
                                            Every day
                                            (*)
                                        </option>
                                        <option value="*/2">
                                            Every other day
                                            (*/2)
                                        </option>
                                        <option value="1,15">
                                            1st and 15th
                                            (1,15)
                                        </option>
                                        <option value="--">
                                            -- Days --
                                        </option>
                                        <option value="1">
                                            1st (1)
                                        </option>
                                        <option value="2">
                                            2nd (2)
                                        </option>
                                        <option value="3">
                                            3rd (3)
                                        </option>
                                        <option value="4">
                                            4th (4)
                                        </option>
                                        <option value="5">
                                            5th (5)
                                        </option>
                                        <option value="6">
                                            6th (6)
                                        </option>
                                        <option value="7">
                                            7th (7)
                                        </option>
                                        <option value="8">
                                            8th (8)
                                        </option>
                                        <option value="9">
                                            9th (9)
                                        </option>
                                        <option value="10">
                                            10th (10)
                                        </option>
                                        <option value="11">
                                            11th (11)
                                        </option>
                                        <option value="12">
                                            12th (12)
                                        </option>
                                        <option value="13">
                                            13th (13)
                                        </option>
                                        <option value="14">
                                            14th (14)
                                        </option>
                                        <option value="15">
                                            15th (15)
                                        </option>
                                        <option value="16">
                                            16th (16)
                                        </option>
                                        <option value="17">
                                            17th (17)
                                        </option>
                                        <option value="18">
                                            18th (18)
                                        </option>
                                        <option value="19">
                                            19th (19)
                                        </option>
                                        <option value="20">
                                            20th (20)
                                        </option>
                                        <option value="21">
                                            21st (21)
                                        </option>
                                        <option value="22">
                                            22nd (22)
                                        </option>
                                        <option value="23">
                                            23rd (23)
                                        </option>
                                        <option value="24">
                                            24th (24)
                                        </option>
                                        <option value="25">
                                            25th (25)
                                        </option>
                                        <option value="26">
                                            26th (26)
                                        </option>
                                        <option value="27">
                                            27th (27)
                                        </option>
                                        <option value="28">
                                            28th (28)
                                        </option>
                                        <option value="29">
                                            29th (29)
                                        </option>
                                        <option value="30">
                                            30th (30)
                                        </option>
                                        <option value="31">
                                            31st (31)
                                        </option>
                                    </select>
                                </div>
                                <div style="width: 16px; height: 16px;" id="day_error" class="span6 cjt_validation_error">
                                </div>
                            </div>
                        </div>
                        <div class="form-group">
                            <label id="lblMonth" for="month">
                                Month
                            </label>
                            <div class="row-fluid">
                                <div class="span2">
                                    <input class="form-control " id="month" name="month" type="text">
                                </div>
                                <div class="span4">
                                    <select id="month_options" class="form-control">
                                        <option value="--">
                                            -- Common Settings --
                                        </option>
                                        <option value="*">
                                            Every month
                                            (*)
                                        </option>
                                        <option value="*/2">
                                            Every other month
                                            (*/2)
                                        </option>
                                        <option value="*/4">
                                            Every 3 months
                                            (*/4)
                                        </option>
                                        <option value="1,7">
                                            Every 6 months
                                            (1,7)
                                        </option>
                                        <option value="--">
                                            -- Months --
                                        </option>
                                        <option value="1">
                                            January
                                            (1)
                                        </option>
                                        <option value="2">
                                            February
                                            (2)
                                        </option>
                                        <option value="3">
                                            March
                                            (3)
                                        </option>
                                        <option value="4">
                                            April
                                            (4)
                                        </option>
                                        <option value="5">
                                            May
                                            (5)
                                        </option>
                                        <option value="6">
                                            June
                                            (6)
                                        </option>
                                        <option value="7">
                                            July
                                            (7)
                                        </option>
                                        <option value="8">
                                            August
                                            (8)
                                        </option>
                                        <option value="9">
                                            September
                                            (9)
                                        </option>
                                        <option value="10">
                                            October
                                            (10)
                                        </option>
                                        <option value="11">
                                            November
                                            (11)
                                        </option>
                                        <option value="12">
                                            December
                                            (12)
                                        </option>
                                    </select>
                                </div>
                                <div style="width: 16px; height: 16px;" id="month_error" class="span6 cjt_validation_error">
                                </div>
                            </div>
                        </div>
                        <div class="form-group">
                            <label id="lblWeekday" for="weekday">
                                Weekday
                            </label>
                            <div class="row-fluid">
                                <div class="span2">
                                    <input class="form-control " id="weekday" name="weekday" type="text">
                                </div>
                                <div class="span4">
                                    <select id="weekday_options" class="form-control" >
                                        <option value="--">
                                            -- Common Settings --
                                        </option>
                                        <option value="*">
                                            Every weekday
                                            (*)
                                        </option>
                                        <option value="1-5">
                                            Mon thru Fri
                                            (1-5)
                                        </option>
                                        <option value="0,6">
                                            Sat and Sun
                                            (6,0)
                                        </option>
                                        <option value="1,3,5">
                                            Mon, Wed, Fri
                                            (1,3,5)
                                        </option>
                                        <option value="2,4">
                                            Tues, Thurs
                                            (2,4)
                                        </option>
                                        <option value="--">
                                            --
                                            Weekdays
                                            --
                                        </option>
                                        <option value="0">
                                            Sunday
                                            (0)
                                        </option>
                                        <option value="1">
                                            Monday
                                            (1)
                                        </option>
                                        <option value="2">
                                            Tuesday
                                            (2)
                                        </option>
                                        <option value="3">
                                            Wednesday
                                            (3)
                                        </option>
                                        <option value="4">
                                            Thursday
                                            (4)
                                        </option>
                                        <option value="5">
                                            Friday
                                            (5)
                                        </option>
                                        <option value="6">
                                            Saturday
                                            (6)
                                        </option>
                                    </select>
                                </div>
                                <div style="width: 16px; height: 16px;" id="weekday_error" class="span6 cjt_validation_error">
                                </div>
                            </div>
                        </div>
                        <div class="form-group">
                            <label id="lblCommand" for="command">
                                Command
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
                            <input id="add_new_cron" class="btn btn-flat-primary btn-primary" value="Add New Cron Job" type="submit">
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