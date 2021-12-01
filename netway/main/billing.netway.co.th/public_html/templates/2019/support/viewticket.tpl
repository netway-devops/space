{assign var="showgravatars_var" value="gravatars-tickets"}

<section class="section-tickets">

    <h1 class="mb-0">#{$ticket.ticket_number} {$ticket.subject|escape|wordwrap:40:"\n":true}</h1>

    <div class="mb-4">
        <a href="{$ca_url}tickets/" class="btn-link"><small>{$lang.backtotickets}</small></a>
    </div>

    <div class="content-view-details d-flex flex-row justify-content-between align-items-center">
        <div class="">
            <span class="badge badge-{$ticket.status}">{$lang[$ticket.status]}</span>
            <span class="badges-group">
                <span class="badge badge-details">{$ticket.date|dateformat:$date_format}</span>
                <span class="badge badge-details">{$ticket.deptname}</span>
            </span>
        </div>
        <div class="d-flex flex-row">
            {if $ticket.status!='Closed'}
                {if $department.options & 262144 && !($ticket.flags & 64)}
                    <a class="btn btn-warning btn-sm" style="height: 28px;" href="?cmd=tickets&action=report_ticket&num={$ticket.ticket_number}">{$lang.report_ticket}</a>
                {/if}
                <form action="" method="post">
                    <input type="hidden" value="closeticket" name="make" />
                    <button class="btn btn-sm btn-primary mr-2"><i class="material-icons icon-btn-color size-sm">done_all</i> {$lang.close}</button>
                    {securitytoken}
                </form>
            {else}
                <form action="" method="post">
                    <input type="hidden" value="reopen" name="make" />
                    <button class="btn btn-sm btn-info mr-2"><i class="material-icons icon-btn-color size-sm">cached</i> {$lang.reopen}</button>
                    {securitytoken}
                </form>
            {/if}
            <a class="btn btn-sm btn-secondary" href="{$ca_url}tickets/"><i class="material-icons icon-btn-color size-sm md-right">style</i> {$lang.alltickets}</a>
        </div>
    </div>

    <div class="comments">
        <div class="comment {if $ticket.type!='Admin' && $ticket.type!='System'}comment-client{else}comment-admin{/if} media">
            <div class="comment-sender d-flex flex-row align-items-center align-self-start">
                {if $tpl_config.$showgravatars_var && $ticket.gravatar}
                    <img class="align-self-start image size-ss mg-left mg-right" src="https://www.gravatar.com/avatar/{$ticket.gravatar}?s=32&d=mm" alt="{$lang.Ticket} #{$ticket.ticket_number}">
                {else}
                    <img class="align-self-start image size-ss mg-left mg-right" src="{$template_dir}dist/images/user.svg" alt="{$lang.Ticket} #{$ticket.ticket_number}">
                {/if}
                <strong>{$ticket.name}</strong>
            </div>
            <div class="comment-body media-body d-flex flex-row justify-content-between">
                <div class="d-flex flex-column justify-content-start">
                    <div class="d-flex flex-column justify-content-start align-items-baseline">
                        <p id="r{$ticket.id}">{$ticket.body|httptohref|nl2br}</p>
                        {if !empty($attachments[0])}
                            {foreach from=$attachments[0] item=attachment}
                                <a href="?action=download&amp;id={$attachment.id}" target="_blank">
                                    <strong><i class="icon-paper-clip "></i> {$attachment.org_filename}</strong>
                                </a><br />
                            {/foreach}
                        {/if}
                        {clientwidget module="tickets" section="body"}
                    </div>
                    <div class="d-flex flex-row justify-content-start align-items-center mt-3"">
                        <small class="comment-date text-muted ">
                            <span class="date">{$ticket.date|regex_replace:"/ \d\d:\d\d:\d\d/":""|dateformat:$date_format}</span>
                            <span class="time">{$ticket.date|regex_replace:"/.* (\d\d:\d\d).*/":"\\1"}</span>
                        </small>
                        {if $ticket.flags & 1024}
                            <small class="ml-4 text-warning">{$lang.messageencryptedinfo}</small>
                        {/if}
                    </div>
                </div>
                <a href="#quote" class="pull-right" title="Quote" onclick="return quoteTicket('r{$ticket.id}');"><i class="material-icons icon-info-color">format_quote</i></a>
            </div>
        </div>
        {foreach from=$replies item=reply}
            {if !$reply.status}{continue}{/if}
            <div class="comment {if $reply.type!='Admin' && $reply.type!='System'} comment-client {else} comment-admin {/if} media">
                <div class="comment-sender d-flex flex-row align-items-center align-self-start">
                    {if $tpl_config.$showgravatars_var && $reply.gravatar}
                        <img class="align-self-start image size-ss mg-left mg-right" src="https://www.gravatar.com/avatar/{$reply.gravatar}?s=32&d=mm" alt="{$lang.Ticket} #{$ticket.ticket_number}">
                    {else}
                        <img class="align-self-start image size-ss mg-left mg-right" src="{$template_dir}dist/images/user.svg" alt="{$lang.Ticket} #{$ticket.ticket_number}">
                    {/if}
                    <b class="">{$reply.name}</b>
                </div>
                <div class="comment-body media-body d-flex flex-row justify-content-between">
                    <div class="d-flex flex-column justify-content-start">
                        <div class="d-flex flex-column justify-content-start align-items-baseline">
                            <p class="text-break" id="r{$reply.id}">{$reply.body|httptohref|nl2br}</p>
                            {if !empty($attachments[$reply.id])}
                                {foreach from=$attachments[$reply.id] item=attachment}
                                    <a href="?action=download&amp;id={$attachment.id}" target="_blank">
                                        <strong><i class="material-icons size-sm">attach_file</i> {$attachment.org_filename}</strong>
                                    </a>
                                    <br />
                                {/foreach}
                            {/if}
                        </div>
                        <div class="d-flex flex-row flex-wrap justify-content-start align-items-center mt-3">
                            <small class="mr-4 comment-date text-muted ">
                                <span class="date">{$reply.date|regex_replace:"/ \d\d:\d\d:\d\d/":""|dateformat:$date_format}</span>
                                <span class="time">{$reply.date|regex_replace:"/.* (\d\d:\d\d).*/":"\\1"}</span>
                            </small>
                            {if $reply.flags & 16}
                                <small class="mr-4 text-warning">{$lang.replyencryptedinfo}</small>
                            {/if}
                            {if $reply.type=='Admin'}
                                {if $department.supportrating}
                                    <div class="mr-4 d-flex flex-row align-items-center">
                                        <div class="rating-box mr-2">
                                            <input type="number" data-id="{$reply.id}" {if $ticket.client_id==0}data-hash="{$ticket.acc_hash}"{/if} {if $reply.rate_date}readonly="readonly"{/if} value="{$reply.rating}"/>
                                        </div>
                                        {if !$reply.rate_date}
                                            <small class="text-muted" >{$lang.ratemyresponse}</small>
                                        {/if}
                                    </div>
                                {/if}
                                {if $department.options & 131072 && !($reply.flags & 1)}
                                    <div class="mr-4">
                                        <a class="right btn btn-warning btn-sm" href="?cmd=tickets&action=report_reply&rid={$reply.id}&tnum={$ticket.ticket_number}">{$lang.report_reply}</a>
                                    </div>
                                {/if}
                            {/if}
                        </div>
                    </div>
                    <a href="#quote" class="" title="Quote" onclick="return quoteTicket('r{$reply.id}');"><i class="material-icons icon-info-color">format_quote</i></a>
                </div>
            </div>
        {/foreach}


    </div>

    {if $ticket.status!='Closed'}

        <div class="d-block my-2" id="hintarea"></div>

        <div class="message-box message-box-file card">
            <div class="card-header">{$lang.reply}</div>
            <div class="card-body">
                <form enctype="multipart/form-data" action="" method="post" id="replyform">
                    <input type="hidden" name="make" value="addreply"/>
                    <input type="hidden" name="client_name" value="{$ticket.name}"/>
                    <input type="hidden" name="client_email" value="{$ticket.email}"/>
                    <div class="d-block mb-4 form-group">
                        <textarea class="form-control form-control-noborders textarea-autoresize" cols="60" rows="6"  name="body" id="ticketmessage" placeholder="{$lang.writemessage}">{$submit.body}</textarea>
                    </div>
                    <div class="d-block my-4 fileupload" id="fileupload" data-url="?cmd=tickets&action=handleupload">
                        <div id="dropzonecontainer">
                            <div id="dropzone"><h1>{$lang.droptoattach}</h1></div>
                            <div class="fileupload-buttonbar d-flex flex-row align-items-center">
                                    <span class="fileinput-button">
                                        <i class="material-icons">attach_file</i>
                                        <input class="btn" type="file" name="attachments[]" multiple />
                                    </span>
                                <small class="form-text text-muted">{$extensions|string_format:$lang.allowedext}</small>
                            </div>
                            <div class="fileupload-progress my-3" style="display:none;">
                                <div class="progress progress-success progress-striped active" role="progressbar" aria-valuemin="0" aria-valuemax="100">
                                    <div class="bar"></div>
                                </div>
                                <div class="progress-extended">&nbsp;</div>
                            </div>
                            <div class="bordered-section my-3" style="display:none;">
                                <table role="presentation" class="table table-striped table-files"><tbody class="files"></tbody></table>
                            </div>
                        </div>
                    </div>
                    <div class="form-check my-3">
                        <input type="checkbox" name="encrypt" value="1" id="encryptReplyCheckbox">
                        <label for="encryptReplyCheckbox">{$lang.encryptreply}</label>
                    </div>
                    <button type="submit" class="btn btn-success">{$lang.submit} <i class="material-icons md-left size-md">send</i> </button>
                    {securitytoken}
                </form>
            </div>
        </div>
    {/if}
</section>
<script type="text/javascript">
    {literal}
        $(function () {
            $(".rating-box input").rating({/literal}{if $ratingscale > 5}true{/if}{literal});
        });
    {/literal}
</script>
{literal}
    <script>
        function quoteTicket(target) {
            var resp = $('#' + target).text();
            var reply = $('#ticketmessage').val();
            $('#ticketmessage').val(reply + "\r\n>" + resp.replace(/\n/g, "\n>") + "\r\n").change().focus();
            return false;
        }

        $(function() {
            $('a[rel=tooltip], div[rel=tooltip]').tooltip();
            if (!$('#ticketmessage').length) {
                $('.quoter').hide();
            }
        });
    </script>
    <script id="template-upload" type="text/x-tmpl">
        {% for (var i=0, file; file=o.files[i]; i++) { %}
        <tr class="template-upload">
        <td class="name w-50""><span>{%=file.name%}</span></td>
        <td class="size" width="150"><span>{%=o.formatFileSize(file.size)%}</span></td>
        {% if (file.error) { %}
        <td class="error" colspan="2"><span class="badge badge-styled badge-danger">Error</span> {%=file.error%}</td>
        {% } else if (o.files.valid && !i) { %}
        <td><div class="progress progress-success progress-striped active" role="progressbar" aria-valuemin="0" aria-valuemax="100" aria-valuenow="0"><div class="bar" style="width:0%;"></div></div></td>
        <td class="start" width="90">{% if (!o.options.autoUpload) { %}
        <button class="btn btn-primary btn-sm">
        <i class="material-icons">send</i>
        <span>Start</span>
        </button>
        {% } %}</td>
        {% } else { %}
        <td colspan="2"></td>
        {% } %}
        <td class="cancel" width="90" align="right">{% if (!i) { %}
        <button class="btn btn-warning btn-sm">
        <span>{/literal}{$lang.cancel}{literal}</span>
        </button>
        {% } %}</td>
        </tr>
        {% } %}
    </script>
    <script id="template-download" type="text/x-tmpl">
        {% for (var i=0, file; file=o.files[i]; i++) { %}
        <tr class="template-download">
        {% if (file.error) { %}
        <td class="name w-50"><span>{%=file.name%}</span></td>
        <td class="size" width="150"><span>{%=o.formatFileSize(file.size)%}</span></td>
        <td class="error" colspan="2"><span class="badge badge-styled badge-danger">Error</span> {%=file.error%}</td>
        {% } else { %}
        <td class="name w-50">{%=file.name%} <input type="hidden" name="asyncattachment[]" value="{%=file.hash%}" /></td>
        <td class="size" width="150"><span>{%=o.formatFileSize(file.size)%}</span></td>
        <td colspan="2"></td>
        {% } %}
        <td class="delete" width="90" align="right">
        <button class="btn btn-default btn-sm" data-type="{%=file.delete_type%}" data-url="{%=file.delete_url%}">
        <span>{/literal}<i class="material-icons icon-info-color">delete</i>{literal}</span>
        </button>
        </td>
        </tr>
        {% } %}
    </script>
{/literal}