<div id="newshelfnav" class="newhorizontalnav">
    <div class="list-1" style="">
        <ul>
            <li class="active">
                <a href="?cmd=configuration&action=cron">{$lang.cronprofiles}</a>
            </li>
            <li class="last">
                <a href="?cmd=configuration&action=cronprofiles"><span>Task Profiles</span></a>
            </li>

        </ul>
    </div>
    <div class="list-2">
        <div class="subm1 haveitems">
            <ul>
                <li><a href="#"   onclick="return addNewTask();" >{$lang.addnewtask}</a></li>
            </ul>
        </div>
    </div>

</div>


<div style="padding:10px">
    <div class="row">
        <div class="col-md-12">

<a name="aaddtask"></a>

            <form method="post" action=""><input type="hidden" name="make" value="addtask" />
                <div class="box box-primary " id="addtask" style="{if !$viewaddform}display:none;{/if}">
                    <div class="box-header">
                        <h3 class="box-title">Add new task</h3>

                    </div>
                    <div class="box-body">

                        <table border="0" cellpadding="6" cellspacing="0">
                            <tr>

                                <td align="right" class="light" style="min-width: 200px">{$lang.taskname}: <a class="vtip_description" title="Select from available but disabled tasks"></a></td>
                                <td><select name="task" class="form-control" id="addtasklist">
                                        {foreach from=$available item=cls }
                                            <option value="{$cls.task}">{$cls.name}</option>
                                        {/foreach}
                                    </select></td>
                            </tr>

                            <tr>

                                <td align="right" class="light" >Profile: <a class="vtip_description" title="Choose which cron profile should run this task"></a></td>
                                <td><select name="profile" class="form-control" >
                                        {foreach from=$profiles item=cls }
                                            <option value="{$cls.id}">{$cls.name}</option>
                                        {/foreach}
                                    </select></td>
                            </tr>
                        </table>
                    </div>

                    <div class="box-footer clearfix no-border">

                        <button type="submit" class="btn btn-success btn-xs" ><span style="">{$lang.addnewtask}</span></button>
            <span class="orspace">{$lang.Or} <a href="#" class="editbtn" onclick="$('#addtask').slideUp();
                                return false;">{$lang.Cancel}</a></span>


                    </div>
                </div>


                <script type="text/javascript">{literal}

                    function addNewTask() {
                        $('#addtask').ShowNicely();
                        return false;
                    }{/literal}
                </script>
                {securitytoken}</form>

            {if !$running}
                <div class="box box-primary" style="background: #FFFBCC">
                    <div class="box-header">
                        <h3 class="box-title">Cron is not working</h3>

                    </div>
                    <div class="box-body">
                        <strong>{$lang.cronnotwork}</strong>
                        <p>{$lang.toenableauto}</p>
                        <center>
                            {$lang.createcronusing}<br/><input type="text" value="*/5 * * * * php -q {$cronpath} profile=default" readonly="readonly" size="100"/><br/>
                        </center>
                    </div>
                </div>
            {/if}






{if $tasks}
    <script type="text/javascript">
        {literal}
        function showcron(string) {
            string = "<h3>Make sure you've added crontab entry:</h3><br><input type='text' class='form-control' value='*/5 * * * * php -q {/literal}{$cronpath}{literal} profile="+string+"'/>" ;
            bootbox.alert({ message: string,backdrop: true});
            return false;
        }
            function execute_task(name, nicename, dbg) {
                $('#taskname span').text(nicename);
                $('#output').hide();
                $('#taskindicator').show();
                var d = 0;
                if (dbg)
                    d = 1;
                $.facebox({div: '#taskexec'});
                $.get("?cmd=configuration&action=executetask&task=" + name, {debug: d}, function (data) {
                    $('#facebox #output pre').text(data);
                    $('#facebox #output').show();
                    $('#facebox #taskindicator').hide();
                    $('#taskindicator').hide()
                });
                return false;
            }
            function checkRunning(refresh){
                refresh = refresh || 30000
                setTimeout(function(){
                    $.get('?cmd=configuration&action=getrunningtasks', function(data){
                        $('.cron-tasks .running').removeClass('running');
                        if(data.tasks){
                            $.each(data.tasks, function(){
                                $('#task-' + this.toString().replace(/:/g,'_')).addClass('running');
                            });
                            checkRunning(2000);
                        }else
                            checkRunning();
                    })
                }, refresh);
            }
            
            $(function(){
                checkRunning($('.cron-tasks .running').length ? 2000 : 30000);
            })
            
        {/literal}
    </script>
    <div id="taskexec" style="display:none">
        <h2 style="margin-bottom: 5px;" id="taskname">{$lang.taskrunning} <span></span></h2>
        <div id="taskindicator" style="display:none;padding:5px;text-align: center">
            <img src="ajax-loading.gif" alt="" />
        </div>
        <div id="output" style="display:none;">
            {$lang.taskoutput}
            <div class="consoleout">
                <pre>

                </pre>
            </div>
        </div>
    </div>

        {foreach from=$tasks item=profile key=profile_id name=frr}
            <div class="box box-primary no-padding" >
                <div class="box-header">
                    <h3 class="box-title">Cron profile: {$profiles[$profile_id].name}</h3>
                    <div class="box-tools pull-right">
                        <button type="button" class="btn btn-sm btn-default" onclick='return showcron("{$profiles[$profile_id].name}")'><i class="fa fa-info"></i></button>
                    </div>
                </div>
                <div class="box-body">
                    <table cellpadding="3" cellspacing="0" width="100%" class="whitetable cron-tasks" >
                    <tr>
                        <th>{$lang.taskname}</th>
                        <th>{$lang.calledevery}</th>
                        <th>{$lang.lastrunned}</th>

                        <th width="20"></th><th width="20"></th>
                        <th width="20"></th>
                    </tr>
                        {foreach from=$profile item=task name=fr}


                    {if $lang[$task.taskname]}
                        {assign value=$lang[$task.taskname] var=taskname}
                    {else}
                        {assign value=$task.taskname var=taskname}
                    {/if}
                    <tr id="task-{$task.task|replace:':':'_'}" class="{if $smarty.foreach.fr.index%2==0}even{/if} havecontrols {if $task.status==0}running{elseif $task.count>2}failed{/if}">
                        <td>
                            {$taskname}
                            {if $task.count>2}
                                <span class="fs11 editgray">
                                    <em>Recent task executions failed, task has been disabled
                                        <a href="?cmd=configuration&action=cron&make=enabletask&task={$task.task}&security_token={$security_token}" class="editbtn"
                                           onclick="return confirm('Are you sure? If task is still broken it may block your other tasks')">enable</a>
                                        <a href="#" class="editbtn" onclick="return execute_task('{$task.task}', '{$taskname}', true);">debug</a>
                                    </em>
                                </span>
                            {/if}
                        </td>
                        <td>
                            {if $task.run_every=='Run'}{$lang.every5min}
                            {elseif $task.run_every=='Time'}{$lang.everyday} {$task.run_every_time_hrs}:{$task.run_every_time_min}
                            {elseif $task.run_every=='Week'}{$lang.evw} {$lang[$task.day]}
                            {elseif $task.run_every=='Month'}{$lang.evm} {$task.run_every_time}
                            {elseif $task.run_every=='Hour'}{$lang.evh}
                            {/if}
                        </td>
                        <td>{$task.lastrun|dateformat:$date_format}</td>
                        <td><a href="" class="editbtn editgray"
                               onclick="return execute_task('{$task.task}', '{$taskname}');"> {$lang.invoketask}</a>
                        </td>
                        <td>
                            <a href="?cmd=configuration&action=gettask&task={$task.task}"
                               class="editbtn" onclick="{literal}$.facebox({ajax: '{/literal}?cmd=configuration&action=gettask&task={$task.task}{literal}'});{/literal}
                                       return false;">{$lang.Edit}</a>
                        </td>
                        <td class="lastitm">
                            <a href="?cmd=configuration&action=cron&make=deletetask&task={$task.task}&security_token={$security_token}"
                               class="delbtn" onclick="return confirm('{$lang.delprofile}');">{$lang.Delete}</a>
                        </td>
                    </tr>
                        {/foreach}

                 </table>
                </div>
                <div class="box-footer clearfix no-border">

                    <button   onclick="addNewTask();$('body').slideToElement('aaddtask'); " class="pull-left btn btn-success btn-xs" ><span style="">{$lang.addnewtask}</span></button>
                    <span class="pull-right">Ran by: */5 * * * * php -q {$cronpath} profile={$profiles[$profile_id].name}</span>
                </div>
            </div>
        {/foreach}

{else}
    <div class="blank_state blank_news">
        <div class="blank_info">
            <h1>{$lang.notasksyet}</h1>
            <div class="clear"></div>

            <a class="new_add new_menu" href="#" style="margin-top:10px"  onclick="return addNewTask();">
                <span>{$lang.addnewtask}</span></a>
            <div class="clear"></div>

        </div>
    </div>

{/if}

        </div>
    </div>
</div>


