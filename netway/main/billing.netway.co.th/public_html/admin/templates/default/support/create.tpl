<div class="blu">
    <h1>{$lang.opennewticket}</h1>
</div>
<div id="ticketbody" class="lighterblue">
    <form action="?cmd=tickets&action=new" method="post"
          id="newticketform" enctype="multipart/form-data"
          data-url="?cmd=tickets&action=handleupload">
        <input type="hidden" name="make" value="createticket"/>
        <input type="hidden" value="new" id="ticket_number"/>
        <input type="hidden" name="useclientname" value="1"/>
        <div class="container-fluid clear lighterblue" style="padding-top:14px">
            <div class="row">
                <div class="col-lg-8 col-sm-12 col-md-12">
                    <div class="form-group">
                        <label>{$lang.Client}</label>
                        <select name="client" id="client_picker" class="form-control">
                            <option value="-1"
                                    {if $submit.client=='-1' && !$client_id}selected="selected"{/if}>{$lang.nonregistered}</option>
                            <option value="-2" {if $submit.client=='-2' && !$client_id}selected="selected"{/if}>Public
                                Ticket (Multiple clients)
                            </option>

                            <option value="0"
                                    {if ($submit.client=='0' && !$client_id) || !isset($submit.client)}selected="selected"{/if}>{$lang.chooseone}</option>
                            {foreach from=$clients item=client}
                                {if $submit.client==$client.id || $client_id==$client.id}
                                    <option value="{$client.id}" selected="selected">
                                        #{$client.id} {if $client.companyname!=''}{$client.companyname}{else}{$client.firstname} {$client.lastname}{/if}</option>
                                {/if}
                            {/foreach}
                        </select>
                    </div>
                    <div class="form-group" id="emailrow3"
                         {if !isset($submit.client) || $submit.client!='-2'  || $client_id }style="display:none"{/if}>
                        <label>Client IDs <a href="#" class="vtip_description"
                                             title="Clients will be notified about this ticket, can see it, but are not allowed to reply it. <br/>Use client filter or comma separated list"></a></label>

                        <div class="input-group">
                            <input type="text" value="{$submit.client_ids}" name="client_ids" id="client_ids"
                                   class="form-control"/>
                            <span class="input-group-btn">
                                <a href="#" class="btn btn-info" id="clientfilter">Select clients</a>
                            </span>
                        </div>
                    </div>
                    <div class="form-group" id="emailrow2"
                         {if !isset($submit.client) || $submit.client!='-1'  || $client_id }style="display:none"{/if}>
                        <label>{$lang.Name}</label>
                        <input type="text" value="{$submit.name}" size="50" name="name" class="form-control"/>
                    </div>

                    <div class="form-group" id="emailrow"
                         {if !isset($submit.client) || $submit.client!='-1' || $client_id }style="display:none"{/if}>
                        <label>{$lang.email}</label>
                        <input type="text" value="{$submit.email}" size="50" name="email" class="form-control"/>
                    </div>

                    <div class="form-group" id="assignloader"></div>

                    <div class="form-group">
                        <label>Additional Email Recipients (CC)</label>
                        <div id="cc_tag" class="tag-form import-headers"
                             data-tags="{$submit.cc|@json_encode|escape}" data-placeholder="Type in email address, confirm with &crarr; key" data-sortable></div>
                        <input id="cc_value" type="hidden" name="cc" />
                    </div>

                    <div class="form-group">
                        <label>{$lang.Subject}</label>
                        <input type="text" value="{$submit.subject|escape}" name="subject" required="required"
                               class="form-control"/>
                    </div>
                    <div class="form-group">
                        <label>{$lang.department}</label>
                        <select name="dept_id" class="form-control chosenedge">
                            {foreach from=$departments item=dept}
                                <option value="{$dept.id}"
                                        {if $submit.dept_id==$dept.id}selected="selected"{/if}>{$dept.name}</option>
                            {/foreach}
                        </select>
                    </div>
                    <div class="form-group">
                        <label>{$lang.tags}</label>
                        <div id="tagsCont" class="tag-form tag-form-main" data-tags="{$submit.tags|@json_encode|escape}"
                             data-tags_colors="{$tags_colors|@json_encode|escape}"></div>
                        <input id="ticket-create-tags" name="tags" value="" type="hidden" />
                    </div>
                </div>
            </div>

            <div class="row">
                <div class="col-md-8">
                    <label>Message</label>
                    <textarea rows="14" id="replyarea" name="body">{$submit.body}</textarea>
                    <div id="draftinfo">
                        <span class="draftdate"
                              {if $submit.date}style="display:inline"{/if}>{$lang.draftsavedat}{$submit.date|dateformat:$date_format}</span>
                        <span class="controls" style="display:inline">
                            <a href="#" onclick="return savedraft()">{$lang.savedraft}</a>
                            <a href="#" onclick="return removedraft()">{$lang.removedraft}</a>
                        </span>
                    </div>
                </div>
                <div class="col-md-4">
                    {adminwidget module="tickets" section="reply"}
                </div>
                <div class="col-md-8" id="noteadder" {if !$submit.notes}style="display:none"{/if} >
                    <div class="form-group">
                        <label>Note</label>
                        <textarea class="notes_field notes_changed form-control" id="ticketnotesarea"
                                  name="notes">{$submit.notes}</textarea>
                    </div>
                </div>

                <div class="col-md-8">
                    {adminwidget module="tickets" section="newticket"}
                </div>

            </div>

            <div class="row" style="margin-top: 10px">
                <div class="col-md-4">
                    <div class="form-group">
                        <div class="btn btn-success btn-sm fileinput-button">
                            {$lang.addattachment}
                            <input type="file" name="asyncattachment[]" multiple/>
                        </div>&nbsp;&nbsp;
                        ({$lang.allowedextensions} {$extensions})
                    </div>
                </div>

                {if !$forbidAccess.encryptTicketMsg}
                    <div class="col-md-4 text-md-right">
                        <div class="form-check">
                            <input class="form-check-input" type="checkbox" name="encrypt" value="1" id="encryptReplyCheckbox">
                            <label class="form-check-label" for="encryptReplyCheckbox">{$lang.encryptmessage}</label>
                        </div>
                    </div>
                {/if}
            </div>

            <div class="row">
                <div class="col-md-8">
                    <ul id="attachments" class="files"></ul>
                </div>
            </div>
        </div>


        <div class="container-fluid lighterblue" style="overflow:visible;padding-top:14px;">
            <div class="row">
                <div class="col-lg-1 col-md-2 col-sm-3 ticket-submit-col">
                    <button type="submit" class="btn btn-success" id="ticketsubmitter" style="line-height: 67px;">
                        Create
                    </button>
                </div>
                <div class="col-lg-11 col-md-10 col-sm-9  ticket-widgets">
                    <div class="well" id="ticketwidgetarea">

                        <div>
                            <div class="ticket-widget-form col-xs-12 col-sm-5  col-md-4 col-lg-2">
                                <div class="input-group">
                                    <span class="input-group-addon">{$lang.status}</span>
                                    <select class="form-control" name="status">
                                        {foreach from=$statuses item=status}
                                            <option value="{$status}"
                                                    {if $submit.status==$status}selected="selected"{/if}>{$status}</option>
                                        {/foreach}
                                    </select>
                                </div>
                            </div>
                            <div class="ticket-widget-form col-xs-12 col-sm-5  col-md-4 col-lg-2">
                                <div class="input-group">
                                    <span class="input-group-addon">Assign to</span>
                                    <select name="owner_id" class="form-control">
                                        <option value="0">{$lang.none}</option>
                                        {foreach from=$staff_members item=stfmbr}
                                            <option {if $stfmbr.id==$submit.owner_id}selected="selected"{/if}
                                                    value="{$stfmbr.id}">{$stfmbr.firstname} {$stfmbr.lastname}</option>
                                        {/foreach}
                                    </select>

                                </div>
                            </div>
                            <div class="ticket-widget-form col-xs-12 col-sm-5  col-md-4 col-lg-2">
                                <div class="input-group">
                                    <span class="input-group-addon">{$lang.setpriority}</span>
                                    <select name="priority" class="form-control">
                                        <option value="0">{$lang.Low}</option>
                                        <option value="1">{$lang.Medium}</option>
                                        <option value="2">{$lang.High}</option>
                                        <option value="3">{$lang.Critical}</option>
                                    </select>

                                </div>
                            </div>

                            <div class="ticket-widget-form col-xs-12 col-sm-5  col-md-4 col-lg-2">
                                <div class="input-group">
                                    <span class="input-group-addon">{$lang.request_type}</span>
                                    <select name="request_type" class="form-control">
                                        <option value="General">{$lang.General}</option>
                                        <option value="Incident">{$lang.Incident}</option>
                                        <option value="Problem">{$lang.Problem}</option>
                                        <option value="Question">{$lang.Question}</option>
                                        <option value="Task">{$lang.Task}</option>
                                    </select>

                                </div>
                            </div>
                        </div>

                        <div>
                            <div class="ticket-widget-form">

                                <a href="#" onclick="$(this).toggleClass('btn-default').toggleClass('btn-success');
                                $('#noteadder').show();
                                return false;" class="btn {if $submit.notes}btn-success{else}btn-default{/if}">Add
                                    note</a>


                            </div>

                            <div class="ticket-widget-btn" id="carboncopy">
                                <a class="btn btn-default" href="#carboncopy">BCC</a>

                                <div class="modal-forms" style="display: none">
                                    <p>Provide comma separated list of emails you wish to BCC to</p>

                                    <div class="form-group">
                                        <label for="forawrd_bcc">BCC address</label>
                                        <textarea type="text" value="{$submit.bcc}" name="bcc" class="form-control"
                                                  id="forawrd_bcc"
                                                  placeholder="joe@example.com, mike@example.com"></textarea>
                                    </div>
                                </div>
                            </div>
                            {include file='support/ajax.makeinternal.tpl' isinternal=$submit.isinternal ajax=false}

                            <div class="ticket-widget-form col-xs-12 col-sm-5  col-md-4 col-lg-2">
                                <a href="#" onclick="$(this).hide().next().show();
                                return false;" {if $submit.parent_id}style="display:none"{/if} class="btn btn-default">Parent
                                    thread</a>
                                <div class="input-group" {if !$submit.parent_id}style="display:none"{/if}>
                                    <span class="input-group-addon">Parent thread</span>
                                    <select class="form-control" name="parent_id" id="parent_id"
                                            default="{$submit.parent_id}">
                                        <option value="0">{$lang.None}</option>
                                    </select>

                                </div>


                            </div>

                        </div>


                    </div>
                </div>
            </div>


        </div>
        {securitytoken}

    </form>
    {if $ajax}
    {literal}
        <script type="text/javascript">
            bindEvents();
            bindTicketEvents();
        </script>
    {/literal}
    {/if}
    {literal}
        <script type="text/javascript">
            $(function () {
                var client_id = $('#client_picker').val();
                if (client_id !== '0' && client_id !== undefined) {
                    $('#assignloader').html('');
                    ajax_update('?cmd=tickets&action=clientcontacts', {
                        id: client_id,
                        tpl: 'assign',
                        privilages: 1,
                        status: 'Active',
                        sec: '{/literal}{$submit.secondary|@serialize}{literal}',
                        contact_id: '{/literal}{$submit.contact_id}{literal}'
                    }, '#assignloader');
                }
            });

            function savedraft() {
                ajax_update('?cmd=tickets', {
                    make: 'savedraft',
                    action: 'menubutton',
                    id: $('#ticket_number').val(),
                    body: $('#replyarea').val()
                }, '#draftinfo .draftdate');
                $('#draftinfo .draftdate').show();
                return false;
            }

            function removedraft() {
                ajax_update('?cmd=tickets', {make: 'removedraft', action: 'menubutton', id: 'new'});
                $('#draftinfo .draftdate').html('').hide();
                $('#draftinfo .controls').hide();
                $('#replyarea').val("");
                return false;
            }

            $(document).trigger('HostBill.newticketform');

            window.setTimeout(function () {
                $('#client_picker').chosensearch({width: '100%'});
                $('select[name=parent_id]').chosensearch(
                    {
                        width: "100%",
                        placeholder_text: "Search for ticket number of subject",
                        enable_split_word_search: true,
                        search_contains: true,
                        type: 'Tickets',
                        args: {type: 'Tickets'},
                        none_option: {
                            name: "None",
                            value: 0,
                            query: ''
                        }
                    });
            }, 1000);

            $('#tagsBox').on('tag.update', function (ev, tags) {
                $('#tagsCont').data('hbtags').suggestions = tags.map(function (x) {
                    return x.tag;
                })
            });

            $('#tagsCont').hbtags({colors: false})
                .on('tags.refresh', function (e, hbtags) {
                    $('#ticket-create-tags').val(JSON.stringify(hbtags.tags))
                });

            $('#carboncopy a').on('click', function () {
                var self = $(this),
                    modalBody = $('#carboncopy .modal-forms');

                function handle(result) {
                    self.find('span').remove();
                    if (!result) {
                        self.removeClass('btn-success')
                        return modalBody.find('input, textarea').val('');
                    }
                    var list = [];
                    result.find('input, textarea, select').each(function () {
                        var self = $(this);
                        if (self.is(':disabled'))
                            return;

                        var val = self.val().split(/[, ;]/).map(function (e) {
                            var l = e.replace(/^\s+|\s+$/g, '');
                            if (l.length && list.indexOf(l) == -1)
                                list.push(l)
                        });
                    })

                    if (!list.length) {
                        return handle(false);
                    }

                    list = list.join(', ');
                    var slist = list;
                    if (list.length > 40)
                        slist = list.substr(0, 38) + '...';

                    modalBody.replaceWith(result.hide())
                    console.log(result.find('select')[0])
                    self.addClass('btn-success')
                        .append('<span> to <em title="' + list + '">' + slist + '</em></span>');
                }

                bootbox.dialog({
                    title: 'BCC',
                    message: modalBody.clone().show(),
                    buttons: {
                        cancel: {
                            label: 'Cancel',
                            className: 'btn-default',
                            callback: function (e) {
                                handle(false)
                            }
                        },
                        confirm: {
                            label: 'OK',
                            className: 'btn-primary',
                            callback: function (e) {
                                handle($(this).find('.modal-body'))
                            }
                        },
                    },
                })
            });

            $('#client_picker').on('change', function () {
                $('#assignloader').html('');
                ajax_update('?cmd=tickets&action=clientcontacts', {
                    id:$(this).val(),
                    tpl:'assign',
                    privilages: 1,
                    status: 'Active'
                }, '#assignloader');
            });
            $('.tag-form').hbtags({sortable: true, autoSubmit: true});
            $('#cc_tag').on('tags.before.add', function (e, tags) {
                for(var i = 0; i < tags.length; i++){
                    if(tags[i]){
                        if (!isValidEmailAddress(tags[i]))
                            tags[i] = '';
                    }
                }
            }).on('tags.refresh', function (e, hbtags) {
                $('#cc_value').val(hbtags.tags.join(','));
            });

            function isValidEmailAddress(emailAddress) {
                var pattern = new RegExp(/^(("[\w-+\s]+")|([\w-+]+(?:\.[\w-+]+)*)|("[\w-+\s]+")([\w-+]+(?:\.[\w-+]+)*))(@((?:[\w-+]+\.)*\w[\w-+]{0,66})\.([a-z]{2,6}(?:\.[a-z]{2})?)$)|(@\[?((25[0-5]\.|2[0-4][\d]\.|1[\d]{2}\.|[\d]{1,2}\.))((25[0-5]|2[0-4][\d]|1[\d]{2}|[\d]{1,2})\.){2}(25[0-5]|2[0-4][\d]|1[\d]{2}|[\d]{1,2})\]?$)/i);
                return pattern.test(emailAddress);
            }
        </script>
    {/literal}

</div>