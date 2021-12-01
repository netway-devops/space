<h1>{$lang.openticket}</h1>

<h5 class="my-5">{$lang.reportproblem}</h5>

<section class="section-tickets">
    <div class="d-flex flex-column justify-content-between">
        <form  enctype="multipart/form-data" method="post" action="" id="ticketsform">
            <input name="make" type="hidden" value="addticket" />
            <div class="form-group">
                <label for="addTicketDepartment">{$lang.department}</label>
                <select class="form-control" id="addTicketDepartment" name="dept_id" onchange="switchdeptdesc(this.value)">
                    {foreach from=$depts item=dept}
                        <option value="{$dept.id}" {if $submit.dept_id==$dept.id}selected="selected"{/if}>{$dept.name}</option>
                    {/foreach}
                </select>
                <div class="deptsdesc">
                    {foreach from=$depts item=dept name=fff}
                        <small class="form-text text-muted dept_{$dept.id}" {if $submit.dept_id && $submit.dept_id==$dept.id} style="display:block" {elseif $smarty.foreach.fff.first}  style="display:block" {else} style="display:none" {/if}>{$dept.description}</small>
                    {/foreach}
                    {foreach from=$depts item=dept name=fff}
                        {if $depts_avg[$dept.id]}
                            <small class="form-text text-muted dept_{$dept.id}" {if $submit.dept_id && $submit.dept_id==$dept.id} style="display:block" {elseif $smarty.foreach.fff.first}  style="display:block" {else} style="display:none" {/if}>{$lang.deptavgresponsetime} {$depts_avg[$dept.id]|convert:'second'}</small>
                        {/if}
                    {/foreach}
                </div>
            </div>
            {if !$clientdata.firstname}
                <div class="form-group">
                    <label for="addTicketName"></label>
                    <input type="text" class="form-control" id="addTicketName" name="client_name" value="{$submit.client_name}" placeholder="{$lang.name}">
                </div>

                <div class="form-group">
                    <label for="addTicketEmail"></label>
                    <input class="form-control" id="addTicketEmail" name="client_email" value="{$submit.client_email}" placeholder="{$lang.email}">
                </div>
            {else}
                <tr>
                    {foreach from=$depts item=dept name=loop}
                        {if $dept.options & 64}
                            <div class="form-group dptpriority" id="p{$dept.id}" {if ($submit && $submit.dept_id!=$dept.id) || ( !$submit && !$smarty.foreach.loop.first)}style="display: none"{/if}>
                                <label for="addTicketPriority">{$lang.priority}</label>
                                <select class="form-control" id="addTicketPriority" {if ($submit && $submit.dept_id!=$dept.id) || ( !$submit && !$smarty.foreach.loop.first)}disabled="disabled"{/if} name="priority">
                                    <option {if $submit.priority==0}selected="selected"{/if} value="0" >{$lang.low}</option>
                                    <option {if $submit.priority==1}selected="selected"{/if} value="1" >{$lang.medium}</option>
                                    <option {if $submit.priority==2}selected="selected"{/if} value="2" >{$lang.high}</option>
                                </select>
                            </div>
                        {/if}
                    {/foreach}
                </tr>
            {/if}

            <div class="form-group">
                <label for="addTicketSubject">{$lang.subject}</label>
                <input type="text" value="{$submit.subject}" class="form-control" name="subject" id="addTicketSubject" placeholder="{$lang.subject}">
            </div>

            <div class="form-group">
                <label for="ticketmessage">{$lang.message}</label>
                <textarea class="form-control textarea-autoresize" cols="60" rows="12" name="body" id="ticketmessage">{$submit.body}</textarea>
                <div id="hintarea" style="display:none">
            </div>

            <div class="d-flex flex-column ticketwidget_newticket">
                {clientwidget module="tickets" section="newticket"}
            </div>

            <div class="my-4 fileupload" id="fileupload" data-url="?cmd=tickets&action=handleupload">
                <div id="dropzonecontainer">
                    <div id="dropzone"><h1>{$lang.droptoattach}</h1></div>
                    <div class="fileupload-buttonbar">
                        <div class="fileinput-button w-100">
                            <label for="file-upload" class="w-100 m-0 py-2 px-1 cursor-pointer d-flex flex-column flex-md-row align-items-center">
                                <i class="material-icons">attach_file</i>
                                <small class="text-muted">{$extensions|string_format:$lang.allowedext}</small>
                            </label>
                        </div>
                        <input id="file-upload" type="file" name="attachments[]" multiple class="d-none"/>
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
                <input type="checkbox" name="encrypt" value="1" id="encryptCheckbox">
                <label for="encryptCheckbox">{$lang.encryptmessage}</label>
            </div>

            {if $contacts}
                <div class="mb-2">
                    {* flag 256 =  Ticket::FLAG_OVERWRITE_CC *}
                    <input type="checkbox" name="flag" value="256" {if $submit.flag == 256}checked="checked"{/if} onchange="if(!$(this).is(':checked'))$('.contact_secondary').prop('checked', false);$('.contact_secondary').prop('disabled', !$(this).is(':checked'));$('.overrideContactsTable').toggle($(this).is(':checked'))">
                    {$lang.override_contacts_notification|default:"Override notifications to contacts"}
                </div>
                <div class="table-responsive table-borders table-radius overrideContactsTable" style="display: none;">
                    <table class="table table-bordered stackable">
                        <thead>
                            <tr>
                                <th width="100"></th>
                                <th>{$lang.firstname}</th>
                                <th>{$lang.lastname}</th>
                                <th>{$lang.email}</th>
                            </tr>
                        </thead>
                        <tbody>
                        {foreach from=$contacts item=p name=ff}
                            <tr>
                                <td data-label="{$lang.notify|default:"Notify"}"><input class="contact_secondary" type="checkbox" name="secondary[]" value="{$p.id}" {if in_array($p.id, $submit.secondary)}checked="checked"{/if} {if $submit.flag == 256}{else}disabled="disabled"{/if}></td>
                                <td data-label="{$lang.firstname}">{$p.firstname}</td>
                                <td data-label="{$lang.lastname}">{$p.lastname}</td>
                                <td data-label="{$lang.email}">{$p.email}</td>
                            </tr>
                        {/foreach}
                        </tbody>
                    </table>
                </div>
            {/if}

            {if $captcha}
                <div class="d-flex flex-column align-items-start ticketwidget_newticket newticket-captcha">
                    <small class="form-text text-muted">{$lang.typethecharacters}</small>
                    <img src="?cmd=root&amp;action=captcha" alt="captcha" />
                    <input type="text" class="form-control" name="image_verification"/>
                </div>
            {/if}

            <div class="row my-4">
                <div class="col-12 col-sm-6 offset-sm-3 col-md-4 offset-md-4">
                    <button type="submit" id="submitbutton" class="btn btn-lg btn-success w-100 d-flex flex-row align-items-center justify-content-center">
                        <i class="material-icons size-md mr-2">done</i>
                        {$lang.submit}
                    </button>
                </div>
            </div>

            {securitytoken}
        </form>
    </div>
</section>
{literal}
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
        <button class="btn btn-danger btn-sm" data-type="{%=file.delete_type%}" data-url="{%=file.delete_url%}">
        <span>{/literal}{$lang.delete}{literal}</span>
        </button>
        </td>
        </tr>
        {% } %}
    </script>
{/literal}
