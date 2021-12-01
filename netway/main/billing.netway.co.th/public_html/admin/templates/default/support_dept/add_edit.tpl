<script type="text/javascript" src="{$template_dir}js/tinymce/tiny_mce.js?v={$hb_version}"></script>
<script type="text/javascript" src="{$template_dir}js/tinymce/jquery.tinymce.js?v={$hb_version}"></script>
{literal}
    <style type="text/css">
        .labels {
        }

        .inputs {
            padding: 2px 20px 2px 0;
        }

        .labels label, .inputs input {
            display: block;
            margin: 5px
        }

        .inputs label input {
            display: inline;
            margin: 0 4px 2px 8px;
            vertical-align: middle;
        }

        .inputs input {
            color: black;
        }

        .labels label, .inputs div {
            padding: 4px;
        }


        .staff-list {
            columns: 6 180px
        }

        .staff-list .list-group-item {
            break-inside: avoid;
        }

        .staff-list .list-group-item label {
            display: inline;
            margin: 0;
        }

        .staff-list .list-group-item .fa {
            font-size: 120%;
            min-width: 20px;
            text-align: center;
            opacity: 0.6;
            cursor: pointer;
        }

        .staff-list .list-group-item .fa:hover {
            opacity: 0.8 !important;
        }

        .staff-list .list-group-item.new {
            border-style: dashed;
        }

        .staff-list .list-group-item.deleted {
            text-decoration: line-through;
            color: rgba(123, 0, 0, 0.6);
        }

        input[type=checkbox]:checked + .fa {
            opacity: 1;
        }

        input[type=checkbox]:checked + .fa-eye-slash::before {
            content: "\f06e"
        }

        input[type=checkbox]:checked + .fa-star-o::before {
            content: "\f005"
        }
        input[type=checkbox]:checked + .fa-envelope-o::before {
            content: "\f0e0"
        }


        .form-group label + .radio{
            margin-top: 0;
        }

    </style>
{/literal}
<form method="post">
    <div class="newhorizontalnav" id="newshelfnav">
        <div class="list-1">
            <ul>
                <li>
                    <a href="#"><span class="ico money">{$lang.General}</span></a>
                </li>
                <li>
                    <a href="#"><span class="ico plug">{$lang.import_msg_tab}</span></a>
                </li>
                <li>
                    <a href="#"><span class="ico gear">{$lang.send_msg_tab}</span></a>
                </li>
                <li>
                    <a href="#"><span class="ico gear">{$lang.slaescalate}</span></a>
                </li>
                <li>
                    <a href="#"><span class="ico gear">{$lang.othersettings}</span></a>
                </li>
            </ul>
        </div>
    </div>
    <div class="nicerblu" style="padding-top:20px;">
        <div class="container-fluid sectioncontent">
            <div class="form-group">
                <label>{$lang.departmentname}</label>
                {hbinput value=$submit._name style="font-weight:bold;" class="form-control" size="50" name="name"}
            </div>
            <div class="form-group">
                <label>{$lang.Description}</label>
                {if !$submit.description}
                    <a href="#" onclick="$(this).hide();
                                        $(this).next().show();
                                        return false;"><strong>{$lang.adddescription}</strong></a>
                {/if}
                <div {if !$submit.description} style="display:none"{/if} >
                    {*}<input type="text" value="{$submit.description}" size="50" name="description" {if !$submit.description} style="display:none"{/if} class="inp"/>{*}
                    {hbwysiwyg value=$submit._description wrapper="div" class="form-control" cols="100" rows="6" name="description"}
                </div>
            </div>

            <div class="form-group">
                <label>Aassignment Options</label>

                <div style="margin-top: -10px">
                    <div class="checkbox">
                        <label>
                            <input id="replyassignment" type="checkbox"
                                   {if $submit.replyassignment==1}checked="checked"{/if}
                                   name="replyassignment" value="1"/>
                            Auto-assign first admin to reply
                        </label>
                        - ticket will be assigned to staff members as soon as they reply to a ticket.
                    </div>
                    <div class="checkbox">
                        <label>
                            <input type="checkbox"
                                   {if $submit.replyreassign==1}checked="checked"{/if}
                                   name="replyreassign" value="1"/>
                            Re-assign ticket after staff reply
                        </label>
                        - assignment will be changed to staff member that added last reply. Only for auto-assignment
                        enabled staff members
                    </div>
                </div>
            </div>

            {if $teams}
                <div class="form-group">
                    <label>Assigned Teams</label>
                    <select class="form-control" id="team-assign" data-rel="#team-assign-list" multiple>
                        {foreach from=$teams item=team}
                            <option value="{$team.id}">{$team.name} </option>
                        {/foreach}
                    </select>
                </div>
                <ul class="staff-list list-group" id="team-assign-list"
                    data-name="teams" data-autoname="teams_auto"  data-notifyname="teams_notify"
                    data-staff="{$submit.teams|@json_encode|escape}"></ul>
            {/if}

            <div class="form-group">
                <label>{$lang.assignedadmins}</label>
                <select class="form-control" id="admin-assign" data-rel="#admin-assign-list" multiple>
                    {foreach from=$admins item=admin}
                        <option value="{$admin.id}">{$admin.username}
                            <!-- {$admin.id} {$admin.firstname} {$admin.lastname} {$admin.email} -->
                        </option>
                    {/foreach}
                </select>
            </div>
            <div>
                <ul class="staff-list list-group" id="admin-assign-list"
                    data-name="admins" data-autoname="auto_assignment" data-notifyname="auto_notify"
                    data-staff="{$submit.admins|@json_encode|escape}"></ul>
                <p>
                    <strong>Legend:</strong><br/>
                    <i class="fa fa-eye"></i> - Staff or team members can view tickets in this department.
                    <br/>
                    <i class="fa fa-envelope"></i> - Staff or team members will receive email notifications in this department.
                    <br/>
                    <span id="legend-autoassign">
                        <i class="fa fa-star"></i> - New tickets will be automatically distributed and assigned to
                        staff
                        or team members.
                    </span>
                </p>

            </div>

        </div>
        <div class="container-fluid sectioncontent">
            {include file="support_dept/settings/import.tpl"}
        </div>
        <div class="container-fluid sectioncontent">
            {include file="support_dept/settings/mail.tpl"}
        </div>

        <div class="container-fluid sectioncontent">
            {if $submit.id}
                {include file="support_dept/settings/sla.tpl"}
            {else}
                <div class="alert alert-info" role="alert">Please add department first to manage SLA settings</div>
            {/if}
        </div>

        <table width="100%" cellspacing="0" cellpadding="10" border="0">


            <tbody class="sectioncontent" style="display:none">
                {include file="support_dept/settings/other.tpl"}
            </tbody>
            <tbody>
                <tr>
                    <td colspan="2" align="center">
                        {if $action=='edit'}
                            <input type="submit" value="{$lang.savechanges}" style="font-weight:bold"
                                   class="btn btn-primary"/>
                            <span class="orspace">{$lang.Or}
                                <a href="?cmd=ticketdepts" class="editbtn">{$lang.Cancel}</a></span>
                            <input type="hidden" name="make" value="edit"/>
                            <input type="hidden" name="id" value="{$submit.id}" id="dept_id"/>
                        {else}
                            <input type="submit" value="{$lang.adddepartment}" style="font-weight:bold"
                                   class="btn btn-primary"/>
                            <span class="orspace">{$lang.Or}
                                <a href="?cmd=ticketdepts" class="editbtn">{$lang.Cancel}</a></span>
                            <input type="hidden" name="make" value="add"/>
                            <input type="hidden" name="id" value="" id="dept_id"/>
                        {/if}
                    </td>
                </tr>
            </tbody>
        </table>
    </div>
    {securitytoken}
</form>
{literal}
    <script type="text/x-handlebars-template" id="assign-tpl">
        {{#each staff}}
        <li class="list-group-item {{class}}">
            <div class="pull-right">
                <label>
                    <input type="checkbox" name="{{../name}}[{{id}}]" value="{{id}}" hidden
                           data-prop="deleted"
                           {{#unless deleted}}checked{{/unless}} />
                    <i class="fa fa-eye-slash"></i>
                </label>
                {{#unless ../deisableauto}}
                <label>
                    <input type="checkbox" name="{{../autoname}}[{{id}}]" value="{{id}}" hidden
                           data-prop="auto_assignment"
                           {{#unless deleted}}{{#if auto_assignment}}checked{{/if}}{{/unless}} />
                    <i class="fa fa-star-o"></i>
                </label>

                {{/unless}}
                <label>
                    <input type="checkbox" name="{{../notifyname}}[{{id}}]" value="{{id}}" hidden
                           data-prop="auto_notify"
                           {{#unless deleted}}{{#if auto_notify}}checked{{/if}}{{/unless}} />
                    <i class="fa fa-envelope-o"></i>
                </label>
            </div>
            {{name}}
        </li>
        {{/each}}
    </script>
<script type="text/javascript">
    $(function () {

        var picked = {/literal}'{$pickedtab}'{literal};
        $('#newshelfnav').TabbedMenu({
            elem: '.sectioncontent',
            picker: '.list-1 li',
            aclass: 'active',
            picked: picked
        });

        $('.from-name').on('change', function () {
            var self = $(this),
                val = self.val() == '1',
                input =  $('input[name=sendername]');

            input.prop('disabled', val);
            if(val) {
                input.val('');
            }

        });


        $('#replyassignment').on('init change', function (e) {
            if (e.type == 'change')
                $('#team-assign, #admin-assign').trigger('change');
            $("#legend-autoassign").toggle(!this.checked)
        }).trigger('init');

        var assign = Handlebars.compile($('#assign-tpl').html());

        $('#team-assign, #admin-assign').chosenedge({
            width: "100%",
            enable_split_word_search: true,
            search_contains: true,
        }).on('init change', function (e, change) {
            var self = $(this),
                box = $(self.data('rel')),
                data = box.data('staff') || [];

            if (change && !data.filter(function (x) {
                return x.id == change.selected;
            }).length) {
                data.push({
                    id: change.selected,
                    name: self.find(':selected').text(),
                    isnew: true,
                    class: 'new'
                })
            }

            data.map(function (x) {
                self.find('[value="' + x.id + '"]').prop('disabled', true);
            });

            box.data('staff', data);
            box.data('rel', this);

            box.html(assign({
                staff: data,
                name: box.data('name'),
                autoname: box.data('autoname'),
                notifyname: box.data('notifyname'),
                deisableauto: $('#replyassignment').is(":checked")
            }));
            self.val([]).trigger('chosen:updated');

            return false;
        }).trigger('init');

        $('#team-assign-list, #admin-assign-list').on('change', 'input', function () {
            var self = this,
                prop = this.dataset.prop,
                box = $(this).closest('.staff-list'),
                select = $(box.data('rel')),
                data = box.data('staff') || [];

            data.forEach(function (x, i) {
                if (x.id !== self.value)
                    return;

                if (prop === 'deleted' && x.class === 'new') {
                    select.find('[value="' + self.value + '"]').prop('disabled', false);
                    data.splice(i, 1)
                    return false;
                }

                x[prop] = prop === 'deleted' ? !self.checked : self.checked;
                x.class = x.deleted ? 'deleted' : '';
            });

            box.data('staff', data);
            box.html(assign({
                staff: data,
                name: box.data('name'),
                autoname: box.data('autoname'),
                notifyname: box.data('notifyname'),
                deisableauto: $('#replyassignment').is(":checked")
            }));
            select.trigger('chosen:updated');
        })
    });


    function check_i(element) {
        var td = $(element).parent();
        if ($(element).is(':checked'))
            $(td).find('.config_val').removeAttr('disabled');
        else
            $(td).find('.config_val').attr('disabled', 'disabled').val(0);
    }


</script>
{/literal}