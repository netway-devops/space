<div class="snapshot" style="padding:15px;">
    <div class="box box-primary no-padding" >
        <div class="box-header">
            <h3 class="box-title">Snapshot details</h3>
        </div>
        <form method="post"  action="?cmd=reports&action=editsnapshot&id={$snapshot.id}">
            <div class="box-body">
                <table class="" style="max-width: 100%:">
                    <tr>
                        <td width="300" align="right" style="padding: 5px 20px 5px 0;">
                            <b>Related report:</b>
                        </td>
                        <td style="padding: 5px 0;">
                            <a href="?cmd=reports&action=get&id={$report.id}">{$report.name}</a>
                        </td>
                    </tr>
                    <tr>
                        <td width="300" align="right" style="padding: 5px 20px 5px 0;">
                            <b>Name:</b>
                        </td>
                        <td style="padding: 5px 0;">
                            <input class="form-control" style="max-width:500px;"  type="text" name="name" value="{$snapshot.name}">
                        </td>
                    </tr>
                    <tr>
                        <td width="300" align="right" valign="top" style="padding: 5px 20px 5px 0;"><b>Frequency: </b></td>
                        <td style="padding: 5px 0;">
                            <div>
                                <input type="radio" name="frequency" value="Demand" {if $snapshot.frequency === 'Demand'}checked="checked"{/if} onclick="HBReportSnapshots.check_i(this)" required="required">
                                <span>On demand</span>
                            </div>
                            <div>
                                <input type="radio" name="frequency" value="Daily" {if $snapshot.frequency === 'Daily'}checked="checked"{/if} onclick="HBReportSnapshots.check_i(this)" required="required">
                                <span>Daily at</span>
                                <input {if $snapshot.frequency === 'Daily'}value="{$snapshot.time}"{else}disabled="disabled"{/if} type="text" name="time" class="config_val timepicker inp" placeholder="eg. 06:00" style="width:60px" autocomplete="off" required="required">
                                <div class="inp-controls">
                                    <a {if $snapshot.frequency === 'Daily'}{else}disabled="disabled"{/if} class="config_val btn btn-default btn-xs plus" onclick="HBReportSnapshots.time_change(this)"><i class="fa fa-plus"></i></a>
                                    <a {if $snapshot.frequency === 'Daily'}{else}disabled="disabled"{/if} class="config_val btn btn-default btn-xs minus" onclick="HBReportSnapshots.time_change(this)"><i class="fa fa-minus"></i></a>
                                </div>
                            </div>
                            <div>
                                <input type="radio" name="frequency" value="Weekly" {if $snapshot.frequency === 'Weekly'}checked="checked"{/if} onclick="HBReportSnapshots.check_i(this)" required="required">
                                <span>Weekly on</span>
                                <select {if $snapshot.frequency === 'Weekly'}{else}disabled="disabled"{/if} name="day" class="config_val inp" id="" required="required">
                                    <option value="7" {if $snapshot.frequency === 'Weekly' && $snapshot.day == 7}selected="selected"{/if}>Sunday</option>
                                    <option value="1" {if $snapshot.frequency === 'Weekly' && $snapshot.day == 1}selected="selected"{/if}>Monday</option>
                                    <option value="2" {if $snapshot.frequency === 'Weekly' && $snapshot.day == 2}selected="selected"{/if}>Tuesday</option>
                                    <option value="3" {if $snapshot.frequency === 'Weekly' && $snapshot.day == 3}selected="selected"{/if}>Wednesday</option>
                                    <option value="4" {if $snapshot.frequency === 'Weekly' && $snapshot.day == 4}selected="selected"{/if}>Thursday</option>
                                    <option value="5" {if $snapshot.frequency === 'Weekly' && $snapshot.day == 5}selected="selected"{/if}>Friday</option>
                                    <option value="6" {if $snapshot.frequency === 'Weekly' && $snapshot.day == 6}selected="selected"{/if}>Saturday</option>
                                </select>
                                <span>at</span>
                                <input {if $snapshot.frequency === 'Weekly'}value="{$snapshot.time}"{else}disabled="disabled"{/if} type="text" name="time" class="config_val timepicker inp" placeholder="eg. 06:00" style="width:60px" autocomplete="off" required="required">
                                <div class="inp-controls">
                                    <a {if $snapshot.frequency === 'Weekly'}{else}disabled="disabled"{/if} class="config_val btn btn-default btn-xs plus" onclick="HBReportSnapshots.time_change(this)"><i class="fa fa-plus"></i></a>
                                    <a {if $snapshot.frequency === 'Weekly'}{else}disabled="disabled"{/if} class="config_val btn btn-default btn-xs minus" onclick="HBReportSnapshots.time_change(this)"><i class="fa fa-minus"></i></a>
                                </div>
                            </div>
                            <div>
                                <input type="radio" name="frequency" value="Monthly" {if $snapshot.frequency === 'Monthly'}checked="checked"{/if} onclick="HBReportSnapshots.check_i(this)" required="required">
                                <span>Monthly every</span>
                                <select {if $snapshot.frequency === 'Monthly'}{else}disabled="disabled"{/if} name="day" class="config_val inp" id="" required="required">
                                    {section name=foo loop=31}
                                        <option {if $snapshot.frequency === 'Monthly' && $snapshot.day == $smarty.section.foo.iteration}selected="selected"{/if} value="{$smarty.section.foo.iteration}">{$smarty.section.foo.iteration}</option>
                                    {/section}
                                </select>
                                <span>day at</span>
                                <input {if $snapshot.frequency === 'Monthly'}value="{$snapshot.time}"{else}disabled="disabled"{/if} type="text" name="time" class="config_val timepicker inp" placeholder="eg. 06:00" style="width:60px" autocomplete="off" required="required">
                                <div class="inp-controls">
                                    <a {if $snapshot.frequency === 'Monthly'}{else}disabled="disabled"{/if} class="config_val btn btn-default btn-xs plus" onclick="HBReportSnapshots.time_change(this)"><i class="fa fa-plus"></i></a>
                                    <a {if $snapshot.frequency === 'Monthly'}{else}disabled="disabled"{/if} class="config_val btn btn-default btn-xs minus" onclick="HBReportSnapshots.time_change(this)"><i class="fa fa-minus"></i></a>
                                </div>
                            </div>
                        </td>
                    </tr>
                    <tr>
                        <td width="300" align="right" valign="top" style="padding: 5px 20px 5px 0;">
                            <b>Target: </b>
                        </td>
                        <td style="padding: 5px 0;">
                            <div>
                                <input type="radio" name="target" value="None" required="required" {if $snapshot.target === 'None'}checked="checked"{/if} onclick="HBReportSnapshots.target_change(this)">
                                <span>None - just save report data to db</span>
                            </div>
                            <div>
                                <input type="radio" name="target" value="Filesystem" required="required" {if $snapshot.target === 'Filesystem'}checked="checked"{/if} onclick="HBReportSnapshots.target_change(this)">
                                <span>Save to filesystem for later download</span>
                            </div>
                            <div>
                                <input type="radio" name="target" value="Email" required="required" {if $snapshot.target === 'Email'}checked="checked"{/if} onclick="HBReportSnapshots.target_change(this)">
                                <span>Email to staff members</span>
                            </div>
                            <div class="target_email" {if $snapshot.target !== 'Email'}style="display:none"{/if}>
                                <select name="target_ids[]" multiple="multiple" class="chosen">
                                    {foreach from=$staff_members item=st}
                                        <option value="{$st.id}" {if $st.id|in_array:$snapshot.target_ids}selected="selected"{/if}>{$st.firstname} {$st.lastname} ({$st.email})</option>
                                    {/foreach}
                                </select>
                            </div>
                        </td>
                    </tr>
                    <tr>
                        <td width="300" align="right" style="padding: 5px 20px 5px 0;">
                            <b>Data to retain:</b>
                            <a class="vtip_description" title="Set to 0 for unlimited"></a>
                        </td>
                        <td style="padding: 5px 0;">
                            <input class="form-control" name="data_to_retain" value="{$snapshot.data_to_retain}" type="number" placeholder="0" style="width:100px">
                        </td>
                    </tr>
                    <tr>
                        <td colspan="2">
                            <hr>
                        </td>
                    </tr>
                    <tr>
                        <td width="300" align="right" style="padding: 5px 20px 5px 0;">
                            <b>Exproter: </b>
                        </td>
                        <td style="padding: 5px 0;">
                            {$snapshot.state.output|strtoupper}
                        </td>
                    </tr>
                    <tr>
                        <td colspan="2">
                            <hr>
                        </td>
                    </tr>
                    <tr>
                        <td width="300" align="right" style="padding: 5px 20px 5px 0;">
                            <b>Total exports: </b>
                        </td>
                        <td style="padding: 5px 0;">
                            {$snapshot.generated_count}
                        </td>
                    </tr>
                    <tr>
                        <td width="300" align="right" style="padding: 5px 20px 5px 0;">
                            <b>Last exported: </b>
                        </td>
                        <td style="padding: 5px 0;">
                            {$snapshot.generated_at|dateformat:$date_format|default:'n/d'}
                        </td>
                    </tr>
                    <tr>
                        <td width="300" align="right" style="padding: 5px 20px 5px 0;">
                            <b>Created: </b>
                        </td>
                        <td style="padding: 5px 0;">
                            {$snapshot.created_at|dateformat:$date_format}
                        </td>
                    </tr>
                </table>
            </div>

            <div class="box-footer no-border " style="margin-top: 20px;">
                <div class="pull-left">
                    {securitytoken}
                    <input type="hidden" name="make" value="save">
                    <button type="submit" class="btn btn-success btn-sm">Save changes</button>
                </div>
                <div class="pull-right">
                    {if 'acl:generateReportSnapshots'|checkcondition}
                        <a class="btn btn-primary btn-sm" href="?cmd=reports&action=generatesnapshot&id={$snapshot.id}&security_token={$security_token}"><i class="fa fa-check"></i> Generate</a>
                    {/if}
                    {if 'acl:removeReportSnapshots'|checkcondition}
                        <a class="btn btn-danger btn-sm " href="?cmd=reports&action=removesnapshot&snapshot_id={$snapshot.id}&security_token={$security_token}" onclick="return confirm('Are you sure?');"><i class="fa fa-trash"></i> Remove snapshot</a>
                    {/if}
                </div>
            </div>
        </form>
    </div>

    <div class="box box-primary no-padding" >
        <div class="box-header">
            <h3 class="box-title">Snapshot auto-exports</h3>
        </div>
        <div class="box-body">
            {if $exports}
                <table width="100%" cellspacing="0" cellpadding="3" border="0" class="whitetable" style="border:solid 1px #ddd;">
                    <tbody>
                    {foreach from=$exports key=type item=data name=dtloop}
                        <tr class="havecontrols {if $smarty.foreach.dtloop.index%2==0}even{/if}">
                            <td>
                                <b>Created: </b>
                                <span>
                                    {$data.created_at|dateformat:$date_format|default:'n/d'}
                                </span>
                            </td>
                            <td>
                                <b>Email sent to staff: </b>
                                <span>
                                {if $data.email_sent}Yes{else}No{/if}
                            </span>
                            </td>
                            <td>
                                <b>Attachment: </b>
                                <span>
                                    {$data.attachment|default:"-"}
                                </span>
                            </td>
                            <td width="220" align="right">
                                {if $data.attachment}
                                    <a class="btn btn-sm btn-primary" href="?cmd=reports&action=downloadsnapshotdata&id={$data.id}&snapshot={$snapshot.id}&security_token={$security_token}">
                                        <i class="fa fa-eye"></i>
                                        Download attachment
                                    </a>
                                {/if}
                                <a class="btn btn-sm btn-default" style="color: red;" href="?cmd=reports&action=removesnapshotdata&id={$data.id}&snapshot={$snapshot.id}&security_token={$security_token}" onclick="return confirm('Are you sure you wish to remove this snapshot data?');">
                                    <i class="fa fa-trash"></i>
                                    Delete
                                </a>
                            </td>
                        </tr>
                    {/foreach}
                    </tbody>
                </table>
            {else}
                <strong>{$lang.nothing}</strong>
            {/if}
        </div>
    </div>
</div>
