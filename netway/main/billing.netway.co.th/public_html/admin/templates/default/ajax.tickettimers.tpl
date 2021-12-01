{if ($action=='add' && 'acl:createTicketTimers'|checkcondition) || ($action=='edit' && 'acl:editTicketTimers'|checkcondition)}
    <script src="{$template_dir}/js/chosen/chosen.min.js" type="text/javascript"></script>
    <script type="text/javascript" src="{$template_dir}js/timepicker/jquery.timepicker.min.js?v={$hb_version}" ></script>
    <script type="text/javascript" src="{$template_dir}js/tickettimetracking.js?v={$hb_version}" ></script>

    <link media="all" rel="stylesheet" href="{$template_dir}/js/chosen/chosen.css">
    <link media="all" rel="stylesheet" href="{$template_dir}js/timepicker/jquery.timepicker.css" />
    <div class="content" style="display: block;">
        <form method="post" action="?cmd={$cmd}&action={$action}" method="post" id="saveform" onsubmit="timer.save();return false;">
            <input type="hidden" name="save" value="1" />
            <input type="hidden" name="ticket_id" value="{$ticket_id}" />
            {if $entry.id}
                <input type="hidden" name="id" value="{$entry.id}" />
            {/if}
            <table width="100%" cellspacing="0" cellpadding="0" border="0">
                <tbody>
                <tr>
                    <td width="140" id="s_menu" style="" valign="top">
                        <div id="lefthandmenu">
                            <a class="tchoice" href="#Basic">Basic settings</a>
                            <a class="tchoice" href="#Actions">Actions</a>
                        </div>
                    </td>
                    <td class="conv_content faceform" style="vertical-align: top">
                        <div class="tabb">
                            <h3 style="margin-bottom:0;"><b>Timer details</b></h3>
                            <hr>
                            <div style="margin-bottom: 20px;">
                                <label>Name</label>
                                <input class="form-control" type="text" name="name" value="{$entry.name}">
                            </div>
                            <div style="margin-bottom: 20px;">
                                <label>Execute at</label>
                                <div class="clear"></div>
                                <div class="no-wrap">
                                    <input type="text" name="startdate" value="{$entry.startdate|default:$initial.date|dateformat:$date_format}" class="inp haspicker" placeholder="eg. {$initial.date|dateformat:$date_format}" style="width:90px">
                                    <input type="text" name="startime" value="{$entry.starttime|default:$initial.starttime}" class="timepicker inp" placeholder="eg. {$initial.starttime}" style="width:45px">
                                    <div class="inp-controls">
                                        <a class="btn btn-default btn-xs plus"><i class="fa fa-plus"></i></a>
                                        <a class="btn btn-default btn-xs minus"><i class="fa fa-minus"></i></a>
                                    </div>
                                </div>
                            </div>
                            <div style="margin-bottom: 20px;">
                                <label>Timezone</label>
                                <select class="form-control chosen" name="timezone">
                                    {if $entry.id}
                                        {foreach from=$timezones item=zone key=code}
                                            <option value="{$code}" {if $code==$entry.timezone}selected="selected"{/if}>{$zone}</option>
                                        {/foreach}
                                    {else}
                                        {foreach from=$timezones item=zone key=code}
                                            <option value="{$code}" {if $code==$default_timezone}selected="selected"{/if}>{$zone}</option>
                                        {/foreach}
                                    {/if}
                                </select>
                                <br>
                                <br>
                                <b>Client timezone:</b>
                                {$client_timezone}
                            </div>
                            <hr>
                            <div style="margin-bottom: 20px;">
                                <label>Auto-reset</label>
                                <div class="form-group">
                                    <div class="checkbox">
                                        <label>
                                            <input type="checkbox" value="1" name="auto_reset" {if $entry.auto_reset}checked="checked"{/if}>
                                            {$lang.Yes}
                                        </label>
                                    </div>
                                    <small>Timer will be canceled when client adds a new reply to the ticket</small>
                                </div>
                            </div>
                        </div>
                        <div class="tabb" style="display:none">
                            <h3 style="margin-bottom:0;"><b>Configure actions</b></h3>
                            <hr>
                            <div style="margin-bottom: 20px;">
                                <label>Reply</label>
                                <div class="form-group">
                                    <div class="checkbox">
                                        <label>
                                            <input type="checkbox" id="add-reply" {if $entry.macro.reply}checked="checked"{/if}>
                                            Add a reply to ticket
                                        </label>
                                    </div>
                                </div>
                                <div class="form-group">
                                    <label>Reply</label>
                                    <textarea class="form-control" rows="12" id="reply"  name="macro[reply]">{$entry.macro.reply}</textarea>
                                </div>
                            </div>
                            <hr>
                            <div style="margin-bottom: 20px;">
                                <label>Note</label>
                                <div class="form-group">
                                    <div class="checkbox">
                                        <label>
                                            <input type="checkbox" id="add-admin_note" {if $entry.macro.admin_note}checked="checked"{/if}>
                                            Add a note to ticket
                                        </label>
                                    </div>
                                </div>
                                <div class="form-group">
                                    <label>Note</label>
                                    <textarea class="form-control" rows="12" id="admin_note"  name="macro[admin_note]">{$entry.macro.admin_note}</textarea>
                                </div>
                            </div>
                            <hr>
                            <div style="margin-bottom: 20px;">
                                <label>Notifications</label>
                                <div class="form-group">
                                    <div class="checkbox">
                                        <label>
                                            <input type="checkbox" name="macro[notify]" value="1" {if $entry.macro.notify}checked="checked"{/if}>
                                            Send email notifications about Ticket reply
                                        </label>
                                    </div>
                                    <div class="checkbox">
                                        <label>
                                            <input type="checkbox" id="sub_notify" name="macro[sub_notify]" value="1" {if $entry.macro.sub_email != 0}checked="checked"{/if}>
                                            Send email to subscribed staff members
                                        </label>
                                    </div>
                                    <div id="select-template">
                                        <select name="macro[sub_email]" class="form-control chosen">
                                            {foreach from=$email_templates item=template key=group}
                                                <optgroup label="{$group}">
                                                    {foreach from=$template item=tpl}
                                                        <option value="{$tpl.id}" {if $entry.macro.sub_email == $tpl.id}selected{/if}>{$tpl.tplname}</option>
                                                    {/foreach}
                                                </optgroup>
                                            {/foreach}
                                        </select>
                                    </div>
                                </div>
                            </div>
                            <hr>
                            <div style="margin-bottom: 20px;">
                                <label>{$lang.changestatus}</label>
                                <div class="form-group">
                                    <select name="macro[status]" class="form-control">
                                        <option value="">{$lang.nochange}</option>
                                        {foreach from=$statuses item=status}
                                            <option value="{$status}" {if $status==$entry.macro.status}selected="selected"{/if}>{$lang.$status}</option>
                                        {/foreach}
                                    </select>
                                </div>
                            </div>
                            <hr>
                            <div style="margin-bottom: 20px;">
                                <label>{$lang.changepriority}</label>
                                <div class="form-group">
                                    <select name="macro[priority]" class="form-control">
                                        <option value="">{$lang.nochange}</option>
                                        <option {if $entry.macro.priority == '0'}selected="selected"{/if} value="0">{$lang.Low}</option>
                                        <option {if $entry.macro.priority == '1'}selected="selected"{/if} value="1">{$lang.Medium}</option>
                                        <option {if $entry.macro.priority == '2'}selected="selected"{/if} value="2">{$lang.High}</option>
                                    </select>
                                </div>
                            </div>
                            <hr>
                            <div style="margin-bottom: 20px;">
                                <label>{$lang.assignto}</label>
                                <div class="form-group">
                                    <select name="macro[owner]" class="form-control chosen">
                                        <option value="">{$lang.nochange}</option>
                                        {foreach from=$staff_members item=stfmbr}
                                            <option {if $entry.macro.owner == $stfmbr.id}selected="selected"{/if}
                                                    value="{$stfmbr.id}">{$stfmbr.firstname} {$stfmbr.lastname}</option>
                                        {/foreach}
                                    </select>
                                </div>
                            </div>
                            <hr>
                            <div style="margin-bottom: 20px;">
                                <label>Add to subscriber list</label>
                                <div class="form-group">
                                    <select name="macro[subscribers][]" class="form-control chosen" multiple>
                                        {foreach from=$staff_members item=stfmbr}
                                            <option {if in_array($stfmbr.id, $entry.macro.subscribers)}selected="selected"{/if}value="{$stfmbr.id}">{$stfmbr.firstname} {$stfmbr.lastname}</option>
                                        {/foreach}
                                    </select>
                                </div>
                            </div>
                            <hr>
                            <div style="margin-bottom: 20px;">
                                <label>Tags to add</label>
                                <div class="form-group">
                                    <div class="clearfix">
                                        <div id="tagsInput" class="tag-form" data-name="macro[tags]" data-tags="{$entry.macro.tags|@json_encode|escape}"></div>
                                        <div id="tags" style="display: none"></div>
                                    </div>
                                </div>
                            </div>
                            <div style="margin-bottom: 20px;">
                                <label>Tags to remove</label>
                                <div class="form-group">
                                    <div class="clearfix">
                                        <div id="tagsInput2" class="tag-form" data-name="macro[tags_rem]" data-tags="{$entry.macro.tags_rem|@json_encode|escape}"></div>
                                        <div id="tags2" style="display: none"></div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </td>
                </tr>
                </tbody>
            </table>
            <div class="dark_shelf dbottom clear">
                <div class="left spinner">
                    <img src="ajax-loading2.gif">
                </div>
                <div class="right">
                    <span class="bcontainer ">
                        <button type="submit" href="#" onclick="$('.spinner').show();" class="new_control greenbtn">
                            <span>Save Changes</span>
                        </button>
                    </span>
                    <span>&nbsp;</span>
                    <span class="bcontainer">
                        <a href="#" onclick="$(document).trigger('close.facebox');return false;" class="submiter menuitm">
                            <span>Close</span>
                        </a>
                    </span>
                </div>
                <div class="clear"></div>
                {securitytoken}
            </div>
        </form>
    </div>
    {literal}
        <script>
            $('#lefthandmenu').TabbedMenu({elem: '.tabb', picked: 0});
        </script>
    {/literal}
{literal}
    <script type="text/javascript">
        $(function () {
            $('.tag-form').hbtags().on('tags.add', function (e,tag) {
                var name = $(this).attr('data-name');
                $(this).next().append('<input type="hidden" name="'+name+'[]" value="' + tag + '" />')
            }).on('tags.rem', function (e,tag) {
                $(this).next().find('input[value="' + tag + '"]').remove();
            });
            $('#tagsBox').on('tag.update', function (ev, tags) {
                $('.tag-form').each(function () {
                    $(this).data('hbtags').suggestions = tags.map(function (x) {
                        return x.tag;
                    })
                })
            });
            add_textarea('reply',true);
            add_textarea('admin_note',true);
            add_sub_email(true);
        });
        function add_textarea(type = 'reply', ready) {
            var add = $('#add-'+type).prop('checked'),
                    textarea = $('textarea#'+type),
                    reply = textarea.parents('div .form-group');
            if (add === true) {
                reply.slideDown();
                var value = textarea.data('value');
                if (value)
                    textarea.val(textarea.data('value'));
            } else {
                if (ready)
                    reply.hide();
                reply.slideUp();
                textarea.data('value', textarea.val());
                textarea.val('');
            }
        }
        function add_sub_email(ready) {
            var checkbox = $('input#sub_notify').prop('checked'),
                    select = $('#select-template');
            if (checkbox === true) {
                select.slideDown("fast");
            } else {
                if (ready)
                    select.hide();
                select.slideUp("fast");
            }
        }
        $('#add-reply').on('change', function () {
            add_textarea('reply', false);
        });
        $('#add-admin_note').on('change', function () {
            add_textarea('admin_note', false);
        });
        $('input#sub_notify').on('change', function () {
            add_sub_email(false);
        });

        var timepickers = $('.timepicker');
        var datepicker = $('.haspicker');
        datepicker.datePicker({
            startDate: startDate
        });
        timepickers.timepicker({
            timeFormat: 'H:i',
            showDuration: true
        }).end().eq(1).on('changeDate change', function(x) {
            var end = $(this).timepicker('getTime'),
                    start = timepickers.eq(0).timepicker('getTime');
            if (end.getTime() - start.getTime() <= 0) {
                var date = getFieldDate(datepicker.eq(1)),
                        date2 = getFieldDate(datepicker.eq(2)),
                        days = (date.getDate() + 1).toString(),
                        month = (date.getMonth() + 1).toString(),
                        format = Date.format;
                if (!isNaN(date.getTime()) && (isNaN(date2.getTime()) || date.getTime() >= date2.getTime()))
                    datepicker.eq(2).val(
                            format.replace('d', days.length < 2 ? "0" + days : days)
                                    .replace('m', month.length < 2 ? "0" + month : month)
                                    .replace('Y', date.getFullYear())
                    );
            }
        });
        datepicker.eq(1).change(function() {
            datepicker.eq(2).dpSetStartDate($(this).val());
        });
        function getFieldDate(datepicker) {
            var value = datepicker.val(),
                    format = Date.format, delim = format.replace(/[^-\/\.]/g, '').charAt(0), parts = value.split(delim),
                    formatparts = format.split(delim);
            return new Date(parts[formatparts.indexOf('Y')], parts[formatparts.indexOf('m')] - 1, parts[formatparts.indexOf('d')])
        }
        $('#saveform').find('.inp-controls a').on('click', function () {
            var self = $(this),
                    inp = self.parent().prev(),
                    time = inp.timepicker('getTime'),
                    mod = self.is('.plus') ? 30 : -30;
            time = new Date(time.getTime() + mod * 60000);
            inp.timepicker('setTime', time);
            return false;
        });
        $('select.chosen').chosenedge({
            width: '100%',
            enable_split_word_search: true,
            search_contains: true,
        }).on('change', function (e, data) {
            var select = $(this),
                values = select.val();
            select.val(values).trigger('chosen:updated');
        });
    </script>
{/literal}
{literal}
    <style>
        #saveform .inp-controls {
            display: inline-block;
            vertical-align: top;
            border: 1px solid #ccc;
            border-left: none;
            margin-left: -5px;
            border-radius: 0 2px 2px 0;
        }
        #saveform .inp-controls .btn + .btn {
            margin-top: 0;
        }
        #saveform .inp-controls .btn {
            display: block;
            line-height: 1em;
            height: 1em;
            border: none;
            padding: 1px 4px;
            border-radius: 0 2px 2px 0;
        }
    </style>
{/literal}
{elseif $action=='ticket'}
    {if $timers}
        <div class="table-responsive">
            <table class="table" border="0" cellpadding="0" cellspacing="0" width="100%" style="text-align: left">
                <tbody>
                <tr>
                    <th>Name</th>
                    <th>Execute at</th>
                    <th>Status</th>
                    <th>Executed</th>
                    <th>Created</th>
                    <th width="300">Actions</th>
                    <th>Auto-reset</th>
                    <th align="right" style=" width: 150px; text-align: right"></th>
                </tr>
                {foreach from=$timers item=entry}
                    <tr>
                        <td>#{$entry.id} <b>{$entry.name}</b></td>
                        <td>
                            {$entry.start_date|dateformat:$date_format}
                            <br>
                            <small style="color: #bbb">
                                {foreach from=$timezones item=zone key=code}
                                    {if $code==$entry.timezone}{$zone}{/if}
                                {/foreach}
                            </small>
                        </td>
                        <td>
                            {if $entry.status == 'Executed'}
                                <span class="Active">Executed</span>
                            {elseif $entry.status == 'Pending'}
                                <span style="color: #ffbb18">Pending</span>
                            {elseif $entry.status == 'Canceled manually'}
                                <span style="color: #999">Canceled manually</span>
                            {elseif $entry.status == 'Canceled by reply'}
                                <span style="color: #999">Canceled by reply</span>
                            {/if}
                        </td>
                        <td>
                            {if $entry.executed_at}
                                {$entry.executed_at|dateformat:$date_format}
                                <br>
                                <small style="color: #bbb">
                                    {$entry.executed_by}
                                </small>
                            {else}
                                -
                            {/if}
                        </td>
                        <td>
                            {$entry.created_at|dateformat:$date_format}
                            <br>
                            <small style="color: #bbb">
                                {$entry.created_by}
                            </small>
                        </td>
                        <td>
                            <i>
                                {if $entry.macro.reply}{if $entry.macro.note}Add note{else}Add reply{/if}{if $entry.macro.tags || $entry.macro.Owner || $entry.macro.priority || $entry.macro.status},{/if}{/if}
                                {if $entry.macro.tags}Add/Remove tags{if $entry.macro.Owner || $entry.macro.priority || $entry.macro.status}, {/if}{/if}
                                {if $entry.macro.owner}Change owner{if $entry.macro.priority || $entry.macro.status}, {/if}{/if}
                                {if $entry.macro.priority}Change priority{if $entry.macro.status}, {/if}{/if}
                                {if $entry.macro.status}Change status{/if}
                            </i>
                        </td>
                        <td>
                            {if $entry.auto_reset}Yes{else}No{/if}
                        </td>
                        <td align="right" style=" width: 150px; text-align: right">
                            {if 'acl:executeTicketTimers'|checkcondition && $entry.status == 'Pending'}
                                <a href="#{$entry.id}" class="btn btn-default btn-xs" onclick="if (confirm('Are you sure you want execute this entry?'))timer.execute('{$entry.id}');return false;">
                                    <i class="fa fa-play"></i>
                                </a>
                            {/if}
                            {if 'acl:editTicketTimers'|checkcondition && $entry.status == 'Pending'}
                                <a href="#{$entry.id}" class="btn btn-default btn-xs" onclick="timer.edit('{$entry.id}');return false;">
                                    <i class="fa fa-pencil"></i>
                                </a>
                            {/if}
                            {if 'acl:cancelTicketTimers'|checkcondition && $entry.status == 'Pending'}
                                <a href="#{$entry.id}" class="btn btn-default btn-xs" onclick="if (confirm('Are you sure you want to cancel future execution of this entry?'))timer.cancel('{$entry.id}');return false;">
                                    <i class="fa fa-ban"></i>
                                </a>
                            {/if}
                            {if 'acl:removeTicketTimers'|checkcondition}
                                <a href="#{$entry.id}" class="btn btn-default btn-xs" onclick="if (confirm('Are you sure you want to remove this entry?'))timer.delete('{$entry.id}');return false;">
                                    <i class="fa fa-trash"></i>
                                </a>
                            {/if}
                        </td>
                    </tr>
                {/foreach}
                </tbody>
            </table>
        </div>
        <hr>
        {if 'acl:createTicketTimers'|checkcondition}
            <a style="margin-top:10px" href="#" class="btn btn-primary btn-sm" onclick="timer.new({$ticket_id}); return false;">
                <span>Add new timer</span>
            </a>
        {/if}
    {else}
        <div class="blank_services">
            <div class="blank_info" style="padding: 10px;">
                <h1>Ticket Timers</h1>
                Use Ticket Timers feature to schedule ticket actions in future: reply, change status, tags etc.
                <div class="clear"></div>
                {if 'acl:createTicketTimers'|checkcondition}
                    <a style="margin-top:10px" href="#" class="new_add new_menu" onclick="timer.new({$ticket_id}); return false;">
                        <span>Add new timer</span>
                    </a>
                {/if}
                <div class="clear"></div>
            </div>
        </div>
    {/if}
{/if}

{literal}
    <script type="text/javascript">
        var timer = {
            new: function (tid) {
                $.facebox({
                    ajax: "?cmd=tickettimers&action=add&ticket_id=" + tid,
                    width: 900,
                    nofooter: true,
                    opacity: 0.5,
                    addclass: 'modernfacebox'
                });
            },
            edit: function (id) {
                $.facebox({
                    ajax: "?cmd=tickettimers&action=edit&id=" + id,
                    width: 900,
                    nofooter: true,
                    opacity: 0.5,
                    addclass: 'modernfacebox'
                });
            },
            save: function () {
                $(document).trigger('close.facebox');
                var url = $('#saveform').attr('action');
                var data = $('#saveform').serialize();
                $.post(url, data, function (data) {
                    parse_response(data);
                    ticket.getTimers();
                });
                return false;
            },
            execute: function (id) {
                var url = "?cmd=tickettimers&action=execute&id=" + id;
                $.post(url, {}, function (data) {
                    parse_response(data);
                    location.reload();
                });
            },
            cancel: function (id) {
                var url = "?cmd=tickettimers&action=cancel&id=" + id;
                $.post(url, {}, function (data) {
                    parse_response(data);
                    ticket.getTimers();
                });
            },
            delete: function (id) {
                var url = "?cmd=tickettimers&action=delete&id=" + id;
                $.post(url, {}, function (data) {
                    parse_response(data);
                    ticket.getTimers();
                });
            },
        }
    </script>
{/literal}