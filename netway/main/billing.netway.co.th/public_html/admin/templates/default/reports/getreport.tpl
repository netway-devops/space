<div class="blu">
    <table width="100%" cellspacing="0" cellpadding="0" border="0">
        <tbody>
        <tr>
            <td>
                <a href="?cmd=reports">
                    <strong>&laquo; Back to all reports</strong>
                </a>
            </td>
            <td align="right"></td>
        </tr>
        </tbody>
    </table>
</div>
<div style="padding:15px;">
    {if $report.custom}
        {include file='reports/editor.tpl'}
    {/if}
    <form action="?cmd=reports&action=show&report={$report.id}" method="post" id="reportform" target="_blank">
        <div class="sectioncontent">
            {if !$report.custom}
                <h2>{$report.name}</h2>
            {/if}
            {if !$exception}
                <table border="0" cellspacing="0" cellpadding="6" width="100%">
                    <tr>
                        <td class="enum"><h1>1.</h1></td>
                        <td>
                            {include file='reports/report.columns.tpl'}
                        </td>
                    </tr>
                    <tr>
                        <td class="enum"><h1>2.</h1></td>
                        <td>
                            {include file='reports/report.params.tpl'}
                        </td>
                    </tr>
                    <tr>
                        <td class="enum"><h1>3.</h1></td>
                        <td><strong>Export as:</strong>
                            <div id="subwiz_opt" class="p5">
                                {foreach from=$outputs item=out name=fr key=k}
                                    <span {if (!$report.state.output && $smarty.foreach.fr.first) || $report.state.output==$out.name}class="active"{/if}>
                                        <input type="radio" onclick="$('.opt_settings').hide();$('#premade{$k}_html').show();prswitch(this);HBReportSnapshots.handle_output_selector(this)" id="premade{$k}" value="{$out.name}" name="output" {if (!$report.state.output && $smarty.foreach.fr.first) || $report.state.output==$out.name}checked="checked"{/if}>
                                           <label>{$out.name}</label>
                                    </span>
                                {/foreach}
                            </div>
                            <div id="settingshtml">
                                {foreach from=$outputs item=out name=fr key=k}
                                    <div {if !$smarty.foreach.fr.first}style="display:none"{/if} id="premade{$k}_html" class="opt_settings">
                                        {$out.config}
                                    </div>
                                {/foreach}
                            </div>
                            <div style="margin:30px 0px;height:30px;">
                                <a href="#" class="new_dsave new_menu" onclick="$('#reportform').attr('action','?cmd=reports&action=save&report={$report.id}').removeAttr('target').submit();return false;">
                                    <span>Save parameters</span>
                                </a>
                                <a href="#" class="new_ddown new_menu" onclick="$('#reportform').attr('action','?cmd=reports&action=show&report={$report.id}').attr('target','_blank').submit();return false;">
                                    <span>Generate report</span>
                                </a>
                                <a href="#" class="new_ddown new_menu btn_generate_store" onclick="$('#reportform').attr('action','?cmd=reports&action=show&report={$report.id}&store=true').attr('target','_blank').submit();return false;">
                                    <span>Generate report & store results</span>
                                </a>
                            </div>
                        </td>
                    </tr>
                    <tr>
                        <td class="enum"><h1>4.</h1></td>
                        <td>
                            <strong>Optionally: Create widget to be added to Admin dashboard</strong>
                            <div class="clear"></div>
                            <div class="p5 pull-left" style="margin-right:20px">
                                <table border="0" cellspacing="0" cellpadding="3" id="trtable">
                                    <tr>
                                        <td width="120">Widget name:</td>
                                        <td width="350" colspan="2">
                                            <input type="text" name="widget_name" class="col-lg-12 form-control" value="{$report.name}"/>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td width="120">Widget type:</td>
                                        <td width="350" colspan="2">
                                            <select name="widget_type" class="form-control">
                                                <option value="table">Data table</option>
                                                <option value="pie-chart">Pie chart</option>
                                                <option value="bar-chart">Bar graph</option>
                                                <option value="line-chart">Line graph</option>
                                                <option value="metric">Data metric</option>
                                            </select>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td width="120">Widget cache:</td>
                                        <td width="175">
                                            <input class="form-control" type="number" min="1" value="1" name="widget_cache">
                                        </td>
                                        <td width="175">
                                            <select name="widget_cache_unit" class="form-control">
                                                <option value="minutes">Minutes</option>
                                                <option value="hours" selected>Hours</option>
                                                <option value="days">Days</option>
                                            </select>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td colspan="2">
                                            <input type="submit" class="btn btn-sm btn-primary" value="Add Widget" onclick="$('#reportform').attr('action','?cmd=reports&action=savewidget&report={$report.id}').removeAttr('target').submit();return false;"/>
                                        </td>
                                    </tr>
                                </table>
                            </div>
                            <div class="" style="margin-left:20px">
                                <b>Note:</b><br/>
                                -
                                When creating widget currently selected columns/params/conditions will be used. <br/>Changing
                                them after widget is created will not affect previously generated widgets.
                                <br/><br/>
                                - To use <strong>Pie/line/bar charts</strong> your report should have only two columns
                                exported:<br>
                                first one holding labels, second holding values
                                <br/><br/>
                                - When using <strong>Data metric</strong> type, your report should only return one row
                                of data, each column will be sparate metric
                            </div>
                            <div class="clear"></div>
                            {if $widgets}
                                <strong>Previous widgets:</strong>
                                <div class="p5">
                                    <table class="table table-stripped table-condensed">
                                        {foreach from=$widgets item=w}
                                            <tr>
                                                <td width="30">
                                                    <a href="?cmd=reports&action=removewidget&widget_id={$w.id}&report={$report.id}&security_token={$security_token}" class="btn btn-xs btn-danger" onclick="return confirm('Are you sure?');"><i class="fa fa-trash"></i></a>
                                                </td>
                                                <td width="20">
                                                    <span class="fa fa-{$w.type}"></span>
                                                </td>
                                                <td>
                                                    {$w.name}
                                                </td>
                                            </tr>
                                        {/foreach}
                                    </table>
                                    <div class="clear"></div>
                                </div>
                            {/if}
                        </td>
                    </tr>
                    {if !$exception && 'acl:createReportSnapshots'|checkcondition}

                    <tr class="section-snapshots">
                        <td class="enum" style="padding: 5px"><h1>5.</h1></td>
                        <td style="padding: 5px">
                            <strong>Optionally: Create auto-snapshot report data</strong>
                            <div class="clear"></div>
                            <div class="p5 pull-left snapshot" style="margin-right:20px;">
                                <table border="0" cellspacing="0" cellpadding="3" id="trtable">
                                    <tr>
                                        <td width="120">Snapshot name:</td>
                                        <td width="350" colspan="2">
                                            <input type="text" name="snapshot[name]" class="col-lg-12 form-control" value="{$report.name}" required="required"/>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td valign="top" width="120">Frequency:</td>
                                        <td>
                                            <div>
                                                <input type="radio" name="snapshot[frequency]" value="Demand" checked="checked" onclick="HBReportSnapshots.check_i(this)" required="required">
                                                <span>On demand</span>
                                            </div>
                                            <div>
                                                <input type="radio" name="snapshot[frequency]" value="Daily" onclick="HBReportSnapshots.check_i(this)" required="required">
                                                <span>Daily at</span>
                                                <input disabled="disabled" type="text" name="snapshot[time]" class="config_val timepicker inp" placeholder="eg. 06:00" style="width:60px" autocomplete="off" required="required">
                                                <div class="inp-controls">
                                                    <a disabled="disabled" class="config_val btn btn-default btn-xs plus" onclick="HBReportSnapshots.time_change(this)"><i class="fa fa-plus"></i></a>
                                                    <a disabled="disabled" class="config_val btn btn-default btn-xs minus" onclick="HBReportSnapshots.time_change(this)"><i class="fa fa-minus"></i></a>
                                                </div>
                                            </div>
                                            <div>
                                                <input type="radio" name="snapshot[frequency]" value="Weekly" onclick="HBReportSnapshots.check_i(this)" required="required">
                                                <span>Weekly on</span>
                                                <select disabled="disabled" name="snapshot[day]" class="config_val inp" id="" required="required">
                                                    <option value="7">Sunday</option>
                                                    <option value="1">Monday</option>
                                                    <option value="2">Tuesday</option>
                                                    <option value="3">Wednesday</option>
                                                    <option value="4">Thursday</option>
                                                    <option value="5">Friday</option>
                                                    <option value="6">Saturday</option>
                                                </select>
                                                <span>at</span>
                                                <input disabled="disabled" type="text" name="snapshot[time]" class="config_val timepicker inp" placeholder="eg. 06:00" style="width:60px" autocomplete="off" required="required">
                                                <div class="inp-controls">
                                                    <a disabled="disabled" class="config_val btn btn-default btn-xs plus" onclick="HBReportSnapshots.time_change(this)"><i class="fa fa-plus"></i></a>
                                                    <a disabled="disabled" class="config_val btn btn-default btn-xs minus" onclick="HBReportSnapshots.time_change(this)"><i class="fa fa-minus"></i></a>
                                                </div>
                                            </div>
                                            <div>
                                                <input type="radio" name="snapshot[frequency]" value="Monthly" onclick="HBReportSnapshots.check_i(this)" required="required">
                                                <span>Monthly every</span>
                                                <select disabled="disabled" name="snapshot[day]" class="config_val inp" id="" required="required">
                                                    {section name=foo loop=31}
                                                        <option {if $smarty.section.foo.iteration==$task.run_every_time}selected="selected"{/if}>{$smarty.section.foo.iteration}</option>
                                                    {/section}
                                                </select>
                                                <span>day at</span>
                                                <input disabled="disabled" type="text" name="snapshot[time]" class="config_val timepicker inp" placeholder="eg. 06:00" style="width:60px" autocomplete="off" required="required">
                                                <div class="inp-controls">
                                                    <a disabled="disabled" class="config_val btn btn-default btn-xs plus" onclick="HBReportSnapshots.time_change(this)"><i class="fa fa-plus"></i></a>
                                                    <a disabled="disabled" class="config_val btn btn-default btn-xs minus" onclick="HBReportSnapshots.time_change(this)"><i class="fa fa-minus"></i></a>
                                                </div>
                                            </div>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td valign="top" width="120">Target:</td>
                                        <td>
                                            <div>
                                                <input type="radio" name="snapshot[target]" value="None" checked="checked" required="required" onclick="HBReportSnapshots.target_change(this)">
                                                <span>None - just save report data to db</span>
                                            </div>
                                            <div>
                                                <input type="radio" name="snapshot[target]" value="Filesystem" required="required" onclick="HBReportSnapshots.target_change(this)">
                                                <span>Save to filesystem for later download</span>
                                            </div>
                                            <div>
                                                <input type="radio" name="snapshot[target]" value="Email" required="required" onclick="HBReportSnapshots.target_change(this)">
                                                <span>Email to staff members</span>
                                            </div>
                                            <div class="target_email" style="display:none;">
                                                <select name="snapshot[target_ids][]" multiple="multiple" class="chosen">
                                                    {foreach from=$staff_members item=st}
                                                        <option value="{$st.id}">{$st.firstname} {$st.lastname} ({$st.email})</option>
                                                    {/foreach}
                                                </select>
                                            </div>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td width="120">
                                            Data to retain:
                                            <a class="vtip_description" title="Set to 0 for unlimited"></a>
                                        </td>
                                        <td>
                                            <input class="form-control" name="snapshot[data_to_retain]" type="number" placeholder="0" style="width:100px">
                                        </td>
                                    </tr>
                                </table>
                                <button type="submit" class="btn btn-sm btn-primary" onclick="$('#reportform').attr('action','?cmd=reports&action=createsnapshot&report={$report.id}').removeAttr('target').submit();return false;">Add Snapshot </button>
                            </div>
                            <div class="" style="margin-left:20px">
                                <b>Note:</b><br/>
                                -
                                When creating snapshot currently selected columns/params/conditions will be used. <br/>Changing
                                them after snapshot is created will not affect previously generated snapshots.
                                <br/><br/>
                            </div>
                            <div class="clear"></div>
                            {if $snapshots && 'acl:viewReportSnapshots'|checkcondition}
                                <strong>Snapshots:</strong>
                                <div class="p5">
                                    <table class="table table-stripped table-condensed">
                                        {foreach from=$snapshots item=s}
                                            <tr>
                                                <td width="60">
                                                    {if 'acl:removeReportSnapshots'|checkcondition}<a href="?cmd=reports&action=removesnapshot&snapshot_id={$s.id}&report={$report.id}&security_token={$security_token}&report_page=true" class="btn btn-xs btn-danger" onclick="return confirm('Are you sure?');"><i class="fa fa-trash"></i></a>{/if}
                                                    {if 'acl:viewReportSnapshots'|checkcondition}<a href="?cmd=reports&action=editsnapshot&id={$s.id}" class="btn btn-xs btn-default"><i class="fa fa-edit"></i></a>{/if}
                                                </td>
                                                <td width="20">
                                                    <span class="fa fa-{$s.type}"></span>
                                                </td>
                                                <td width="300">
                                                    <a href="?cmd=reports&action=editsnapshot&id={$s.id}">{$s.name}</a>
                                                </td>
                                                <td width="350">
                                                    <b>Frequency: </b>
                                                    {if $s.frequency === 'Demand'}
                                                        <span>On Demand</span>
                                                    {elseif $s.frequency === 'Daily'}
                                                        <span>Daily at </span>
                                                        <b>{$s.time}</b>
                                                    {elseif $s.frequency === 'Weekly'}
                                                        <span>Weekly on </span>
                                                        <b>
                                                            {if $s.day == 1} Monday
                                                            {elseif $s.day == 2} Tuesday
                                                            {elseif $s.day == 3} Wednesday
                                                            {elseif $s.day == 4} Thursday
                                                            {elseif $s.day == 5} Friday
                                                            {elseif $s.day == 6} Saturday
                                                            {elseif $s.day == 7} Sunday
                                                            {/if}
                                                        </b>
                                                        <span> at </span>
                                                        <b>{$s.time}</b>
                                                    {elseif $s.frequency === 'Monthly'}
                                                        <span>Monthly every </span>
                                                        <b>{$s.day}</b>
                                                        <span> day at </span>
                                                        <b>{$s.time}</b>
                                                    {/if}
                                                </td>
                                                <td>
                                                    <b>Target: </b>
                                                    <span>
                                                    {if $s.target === 'None'}
                                                        Just save report data to db
                                                    {elseif $s.target === 'Filesystem'}
                                                        Save to filesystem
                                                    {elseif $s.target === 'Email'}
                                                        Email to staff members
                                                    {/if}
                                                </span>
                                                </td>
                                                <td>
                                                    <b>Total exports: </b>
                                                    <span>
                                                        {$s.generated_count|default:"-"}
                                                    </span>
                                                </td>
                                                <td>
                                                    <b>Last export: </b>
                                                    <span>
                                                        {$s.generated_at|dateformat:$date_format|default:"-"}
                                                    </span>
                                                </td>
                                                <td>
                                                    <b>Created: </b>
                                                    <span>
                                                        {$s.created_at|dateformat:$date_format}
                                                    </span>
                                                </td>
                                            </tr>
                                        {/foreach}
                                    </table>
                                    <div class="clear"></div>
                                </div>
                            {/if}
                        </td>
                    </tr>

                    {/if}
                </table>
            {else}
                <h2>Query contains errors: {$exception}</h2>
                Please correct your SQL and save changes to get full options
            {/if}
            {securitytoken}
        </div>
    </form>
    <div class="clear"></div>
</div>