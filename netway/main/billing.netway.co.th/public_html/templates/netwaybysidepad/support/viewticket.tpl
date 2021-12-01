<!--BOF: FILEUPLOAD -->
<script src="{$template_dir}js/fileupload/vendor/jquery.ui.widget.js"></script>
<script src="{$template_dir}js/fileupload/vendor/tmpl.min.js"></script>
<script src="{$template_dir}js/fileupload/jquery.iframe-transport.js"></script>
<script src="{$template_dir}js/fileupload/jquery.fileupload.js"></script>
<script src="{$template_dir}js/fileupload/jquery.fileupload-ui.js"></script>
<link media="all" type="text/css" rel="stylesheet" href="{$template_dir}js/fileupload/styles.css" />
<!--EOF: FILEUPLOAD -->

<div class="wrapper-bg">
    <!-- Left Navigation -->
    <div class="tickets-box">
        <ul class="nav nav-list support-info-list">
            <li><i class="icon icon-tags"></i> {$lang.Ticket} <strong>#{$ticket.ticket_number}</strong></li>
            <li><i class="icon {if $ticket.status != 'Closed'}icon-comment{else}icon-lock{/if}"></i> {$lang.status} <strong>{$lang[$ticket.status]}</strong></li>
            <li><i class="icon icon-folder-open"></i> {$lang.department}: <strong>{$ticket.deptname}</strong></li>
            <li><i class="icon icon-time"></i> {$lang.added}: <strong>{$ticket.date|date_format:'%d %b %Y'}</strong></li>
        </ul>
        <div class="support-nav-separator"></div>
        <div class="padding-space">
        {if $ticket.status!='Closed'}
          <form  action="" method="post">
          <input type="hidden" value="closeticket" name="make" />
            <p>{$lang.resolvedticket}
            </p>
            <button  class="clearstyle btn green-custom-btn"><i class="icon-success"></i> {$lang.resolved}</button>
            </form>
        {else}
            <p>{$lang.notresolvedticket}</p>
			<form  action="" method="post">
            <input type="hidden" value="reopen" name="make" />
			<button class="clearstyle btn green-custom-btn" ><i class="icon-refresh icon-white"></i> {$lang.reopen}</button>
	{securitytoken}</form>
        {/if}
        </div>
    </div>
    <!-- End of Left Navigation -->

    <!-- Right Content --> 
    
    <div class="services-content">
        <h5 class="service-header blue-h">{$ticket.subject|wordwrap:40:"\n":true}</h5>
        <div>
            <div class="right-btns-l">
                <a href="index.php?/tickets/" class="pull-right clearstyle btn grey-custom-btn"><i class="icon-back"></i> {$lang.alltickets}</a>
            </div>
        </div>
        {if $ticket.status!='Closed'}
        <div class="ticket-reply">
            <form enctype="multipart/form-data" action="" method="post" id="replyform">
            <p>{$lang.reply}</p>
            <input type="hidden" value="addreply" name="make" />
            <input name="client_name" type="hidden" value="{$ticket.name}"/>
            <input name="client_email" value="{$ticket.email}" type="hidden"/>
			<textarea name="body" id="ticketmessage">{$submit.body}</textarea>
            <div id="hintarea" style="display:none"></div>
            <table style="width: 100%" >
            <tr>
            	<td width="100" valign="top"><button class="clearstyle btn green-custom-btn l-btn" id="submitbutton"><i class="icon-comment icon-white"></i> {$lang.submit}</button></td>
            </tr>
            <tr>
                <td id="fileupload" data-url="?cmd=tickets&action=handleupload">
                        <div id="dropzonecontainer" >
                        <div id="dropzone"><h2>{$lang.droptoattach}</h2></div>
                        <div class="fileupload-buttonbar" class="clearfix">
                            <div class="span5 fileupload-progress fade right" >
                                <!-- The global progress bar -->
                                <div class="progress progress-success progress-striped active" role="progressbar" aria-valuemin="0" aria-valuemax="100">
                                    <div class="bar" style="width:0%;float:left"></div>
                                </div>
                                <!-- The extended global progress information -->
                                <div class="progress-extended">&nbsp;</div>
                            </div>
                            <div>
                                <!-- The fileinput-button span is used to style the file input field as button -->
                                <span class="clearstyle btn grey-custom-btn fileinput-button">
                                    <i class="icon-attach"></i>
                                    <span>{$lang.attachfile}</span>
                                    <input type="file" name="attachments[]" multiple  />
                                </span>
                                <div class="fs11">{$extensions|string_format:$lang.allowedext}</div>
                            </div>
                            <!-- The global progress information -->
                            <div class="clear"></div>
                        </div>
                        <!-- The table listing the files available for upload/download -->
                        <table role="presentation" class="table table-striped" style="width: 100%"><tbody class="files"></tbody></table>
                        <!--EOF: FILEUPLOAD -->
                       
                         </div>
                        </td>
                    </tr>
                                        
                    </tbody>
                </table></td>
                <td></td>
                </tr>
                </tbody>
                </table>
                {securitytoken}</form>
            </div>   
            {/if}
        <div class="ticket-replies">
        {if $replies && !empty($replies) }
            <link type="text/css" rel="stylesheet" href="{$template_dir}css/jRating.jquery.css" /> 
            
            <p>{$lang.replies}</p>
            {foreach from=$replies_rev item=reply}
            <div class="user-reply">
                <button class="clearstyle btn grey-custom-btn quote-btn" onclick="return quoteTicket('r{$reply.id}');"><i class="icon-quote"></i></button>
                {if $reply.type=='Admin'}
                	<div class="right rating-box {if $reply.rate_date}jDisabled{/if}" id="{$reply.rating}_{$reply.id}{if $ticket.client_id==0}_{$ticket.acc_hash}{/if}" style="margin-right:35px"></div>
                    {if !$reply.rate_date}<span class="right byline" >{$lang.ratemyresponse}</span>{/if}
                {/if}
                <p class="reply-info"><strong {if $reply.type=='Admin'} class="admin-c"{/if}>
                <i {if $reply.type=='Admin'} class="icon-ticket-admin" {else}  class="icon-ticket-user" {/if}></i> 
                {$reply.name}</strong> <span>{$reply.date|date_format:'%d %b %Y'}</span></p>
                <p id="r{$reply.id}">{$reply.body|httptohref|nl2br}</p>
                {if !empty($attachments[$reply.id])}
                      <br /><strong>		{$lang.attachments}:</strong><br />
                     {foreach from=$attachments[$reply.id] item=attachment}
		                   {if $attachment.is_staff_only}
		                       {continue}
		                   {/if}
                            <a href="?action=download&amp;id={$attachment.id} "  class="attach3">{$attachment.org_filename}</a><br />
                     {/foreach}
                 {/if}
            </div>
            {/foreach}
            
            <script type="text/javascript" src="{$template_dir}js/jRating.jquery.js"></script>
            <script type="text/javascript">$(".rating-box").jRating({literal}{{/literal}rateMax:{$ratingscale}{literal}}{/literal});</script>
        {/if}
         <div class="user-reply">
            <button class="clearstyle btn grey-custom-btn quote-btn" onclick="return quoteTicket('r{$reply.id}');"><i class="icon-quote"></i></button>
            <p class="reply-info"><strong><i class="icon-ticket-user"></i> {$ticket.name}</strong> <span>{$ticket.date|date_format:'%d %b %Y'}</span></p>
            <p id="r{$reply.id}">{$ticket.body|httptohref|nl2br}</p>
              {if !empty($attachments[0])}
                    <br /><strong>		{$lang.attachments}:</strong><br />
                   {foreach from=$attachments[0] item=attachment}
				   {if $attachment.is_staff_only}
				       {continue}
				   {/if}
                          <a href="?action=download&amp;id={$attachment.id}" class="attach3">{$attachment.org_filename}</a><br />
                   {/foreach}
               {/if}
        </div>
        
        </div>
        
    </div>
    <!-- End of Right Content -->
</div>











 <script type="text/javascript" src="{$template_dir}js/jquery.elastic.min.js"></script>
    {literal}
    <script>

    function quoteTicket(target) {
        var resp = $('#'+target).text();
        var reply = $('#ticketmessage').val();
        $('#ticketmessage').val(reply + "\r\n>" + resp.replace(/\n/g,"\n>")+"\r\n").change().focus();
        return false;
    }
    $(document).ready(function(){
        $('a[rel=tooltip], div[rel=tooltip]').tooltip();
        if(!$('#ticketmessage').length) {
            $('.quoter').hide();
        } else {
            $('#ticketmessage').elastic();
        }
    });
    </script>{/literal}
<!--BOF: FILEUPLOAD -->{literal}
<script type="text/javascript">
    $(function () {

        function enablesubmit() {
            $('#submitbutton').addClass('btn-success').removeClass('disabled').removeClass('btn-inverse').removeAttr('disabled');
        }
        function disablesubmit() {
            $('#submitbutton').removeClass('btn-success').addClass('disabled').addClass('btn-inverse').attr('disabled','disabled');
        }
        function showdropzone(e) {
          var dropZone = $('#dropzone').not('.hidden');
            dropZone.show();
                 setTimeout(function () {
                    hidedropzone()
                }, 6000);
        }
        function hidedropzone() {
            $('#dropzone').hide().addClass('hidden');
        }
        $('#fileupload').fileupload();
        $('#fileupload').bind('fileuploadsend', disablesubmit)
        .bind('fileuploadalways', enablesubmit)
        .bind('fileuploaddragover', showdropzone)
         .bind('fileuploaddrop', hidedropzone);

    });

</script>
<script id="template-upload" type="text/x-tmpl">
    {% for (var i=0, file; file=o.files[i]; i++) { %}
    <tr class="template-upload fade">
        <td class="name" width="40%"><span>{%=file.name%}</span></td>
        <td class="size" width="90"><span>{%=o.formatFileSize(file.size)%}</span></td>
        {% if (file.error) { %}
        <td class="error" colspan="2"><span class="label label-important">Error</span> {%=file.error%}</td>
        {% } else if (o.files.valid && !i) { %}
        <td>
        </td>
        <td class="start" width="90">{% if (!o.options.autoUpload) { %}
            <button class="btn btn-primary btn-mini">
                <i class="icon-upload icon-white"></i>
                <span>Start</span>
            </button>
            {% } %}</td>
        {% } else { %}
        <td colspan="2"></td>
        {% } %}
        <td class="cancel" width="90" align="right">{% if (!i) { %}
            <button class="btn btn-warning  btn-mini">
                <i class="icon-ban-circle icon-white"></i>
                <span>{/literal}{$lang.cancel}{literal}</span>
            </button>
            {% } %}</td>
    </tr>
    {% } %}
</script><!-- The template to display files available for download -->
<script id="template-download" type="text/x-tmpl">
{% for (var i=0, file; file=o.files[i]; i++) { %}
    <tr class="template-download fade">
        {% if (file.error) { %}
            <td class="name" width="40%"><span>{%=file.name%}</span></td>
            <td class="size" width="90"><span>{%=o.formatFileSize(file.size)%}</span></td>
            <td class="error" colspan="2"><span class="label label-important">Error</span> {%=file.error%}</td>
        {% } else { %}
            <td class="name" width="40%">{%=file.name%} <input type="hidden" name="asyncattachment[]" value="{%=file.hash%}" /></td>
            <td class="size"><span>{%=o.formatFileSize(file.size)%}</span></td>
            <td colspan="2"></td>
        {% } %}
        <td class="delete" width="90"  align="right">
            <button class="btn btn-danger btn-mini" data-type="{%=file.delete_type%}" data-url="{%=file.delete_url%}">
                <i class="icon-trash icon-white"></i>
                <span>{/literal}{$lang.delete}{literal}</span>
            </button>
        </td>
    </tr>
{% } %}
</script>
{/literal}
<!--EOF: FILEUPLOAD -->