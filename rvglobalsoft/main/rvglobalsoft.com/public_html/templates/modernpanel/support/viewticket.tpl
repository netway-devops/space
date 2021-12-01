<link media="all" type="text/css" rel="stylesheet" href="{$template_dir}js/fileupload/styles.css" />
<link type="text/css" rel="stylesheet" href="{$template_dir}css/jRating.jquery.css" /> 
<article>
    <h2><i class="icon-main-mail"></i> {$ticket.subject|wordwrap:40:"\n":true}</h2>
    <p>{$lang.Ticket} #{$ticket.ticket_number} </p>

    <div class="invoices-box clearfix">
        <ul id="support-tab" class="nav nav-tabs table-nav">
            <li class="active"><a href="#support1" data-toggle="tab"><div class="tab-left"></div> {$lang[$ticket.status]} <div class="tab-right"></div></a></li>
        </ul>
        <div class="tab-content no-p">
            <div class="tab-pane active" id="support1">

                <div class="support-wrapper">
                    <div class="switcher" id="kbhint_toggle">
                        <div class="slider-handle"></div>
                        <span class="off">{$lang.Off}</span>
                        <span class="on">{$lang.On}</span>
                    </div>

                    <div class="ticket-list">
                        <div class="header kbhints">
                            <p>
                                <i class="icon-qm-logs"></i>
                                {$lang.knowledgebase}
                            </p>
                        </div>
                        <div class="tab-content tab-auto no-p">
                            <!-- Ticket #1 -->
                            <div class="tab-pane active">
                                <div class="wrapper-list">
                                    <ul class="nav" id="hintarea">
                                        <li>
                                            <div class="bg-fix"></div>
                                            <a href='#' onclick="return false;">
                                                <p>{$lang.nothing}</p>
                                            </a>
                                        </li>
                                    </ul>
                                </div>
                            </div>
                        </div>
                    </div>

                    <div class="ticket-details">
                        <div class="padding">
                            <div class="ticket-info">
                                <span><i class="icon-department"></i> {$lang.department} <strong>{$ticket.deptname}</strong></span>
                                <span><i class="icon-large-date"></i> {$lang.added} <strong>{$ticket.date|dateformat:$date_format}</strong></span>
                            </div>
                            {if $ticket.status!='Closed'}
                                <div class="separator-line"></div>
                                <form enctype="multipart/form-data" action="" method="post" id="replyform">

                                    <fieldset>
                                        <label>{$lang.reply}</label>
                                        <input type="hidden" value="addreply" name="make" />
                                        <input name="client_name" type="hidden" value="{$ticket.name}"/>
                                        <input name="client_email" value="{$ticket.email}" type="hidden"/>
                                        <textarea name="body" id="ticketmessage">{$submit.body}</textarea>
                                    </fieldset>

                                    <div id="fileupload" data-url="?cmd=tickets&action=handleupload">
                                        <div class="upload-box" id="dropzonecontainer">
                                            <div id="dropzone"><h2>{$lang.droptoattach}</h2></div>
                                            <div class="pad5">
                                                <div class="pull-left">
                                                    <a href="#" class="btn c-white-btn fileinput-button">
                                                        <input type="file" name="attachments[]" multiple  />
                                                        <i class="icon-add-file"></i>{$lang.attachfile}
                                                    </a>
                                                    <div class="info">
                                                        <span>{$lang.allowedext}</span>
                                                        <p>{$extensions}</p>
                                                    </div>
                                                </div>

                                                <div class="pull-right">
                                                    <button id="submitbutton" class="btn c-green-btn">{$lang.submit}</a>
                                                </div>
                                                <div class="clear"></div>

                                                <!-- The table listing the files available for upload/download -->
                                                <table role="presentation" class="table table-striped fileupload-progress-table"><tbody class="files"></tbody></table>

                                                <div class="clear fileupload-progress fade" style="display: none;">
                                                    <!-- The global progress bar -->
                                                    <div class="progress progress-success progress-striped active" role="progressbar" aria-valuemin="0" aria-valuemax="100">
                                                        <div class="bar" style="width:0%;float:left"></div>
                                                    </div>
                                                    <!-- The extended global progress information -->
                                                    <div class="progress-extended">&nbsp;</div>
                                                </div>
                                                <!--EOF: FILEUPLOAD -->
                                            </div>
                                        </div>
                                    </div>
                                    {securitytoken}
                                </form>
                            {/if}
                            <div class="separator-line"></div>

                            <div class="ticket-answers">

                                <div class="vert-line"></div>
                                {if $replies && !empty($replies) }
                                    {foreach from=$replies_rev item=reply}
                                        <div class="answer clearfix">
                                            <div class="avatar">
                                                <img src="http://{if $is_https}secure{else}www{/if}.gravatar.com/avatar/{$reply.email|trim|md5}.jpg?d=mm&s=65" />
                                                <p {if $reply.type!='Admin'}class="user"{/if}>{$reply.name}</p>
                                            </div>
                                            <div class="text-msg">
                                                <div class="bg-fix"></div>
                                                <div class="padding">
                                                    <div class="quote-btn">
                                                        <a href="#" class="btn c-grey-btn" onclick="return quoteTicket('r{$reply.id}');"><i class="icon-quote"></i></a>
                                                    </div>
                                                    <div class="width-fix">
                                                        <p id="r{$reply.id}">{$reply.body|httptohref|nl2br}</p>
                                                    </div>
                                                    {if !empty($attachments[$reply.id])}
                                                        <p class="attachments">
                                                            {$lang.attachments}:
                                                            {foreach from=$attachments[$reply.id] item=attachment}
                                                                <a href="?action=download&amp;id={$attachment.id} "  class="label label-info">{$attachment.org_filename}</a>
                                                            {/foreach}
                                                        </p>
                                                    {/if}
                                                    {if $reply.type=='Admin' && $ratingscale}
                                                        <div class="rate-answer" >

                                                            <div class="rating-box {if $reply.rate_date}jDisabled{/if}" id="{$reply.rating}_{$reply.id}{if $ticket.client_id==0}_{$ticket.acc_hash}{/if}"></div>
                                                            {if !$reply.rate_date}
                                                                <span class="right byline" >{$lang.ratemyresponse}</span>
                                                            {/if}
                                                        </div>
                                                    {/if}
                                                    <div class="pull-left">
                                                        <span><i class="icon-date"></i> {$reply.date|dateformat:$date_format}</span>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                    {/foreach}
                                {/if}
                                <div class="answer clearfix">
                                    <div class="avatar">
                                        <img src="http://{if $is_https}secure{else}www{/if}.gravatar.com/avatar/{$ticket.email|trim|md5}.jpg?d=mm&s=65" />
                                        <p {if $ticket.type!='Admin'}class="user"{/if}>{$ticket.name}</p>
                                    </div>
                                    <div class="text-msg">
                                        <div class="bg-fix"></div>
                                        <div class="padding">
                                            <div class="quote-btn">
                                                <a href="#" class="btn c-grey-btn" onclick="return quoteTicket('r{$ticket.id}');"><i class="icon-quote"></i></a>
                                            </div>
                                            <div class="width-fix">
                                                <p id="r{$ticket.id}">{$ticket.body|httptohref|nl2br}</p>
                                            </div>
                                            {if !empty($attachments[0])}
                                                <p  class="attachments">{$lang.attachments}:
                                                    {foreach from=$attachments[0] item=attachment}
                                                        <a href="?action=download&amp;id={$attachment.id} "  class="label label-info">{$attachment.org_filename}</a>
                                                    {/foreach}
                                                </p>
                                            {/if}

                                            <div class="pull-left">
                                                <span><i class="icon-date"></i> {$ticket.date|dateformat:$date_format}</span>
                                            </div>
                                        </div>
                                    </div>
                                </div>

                            </div>

                            <div class="separator-line"></div>
                            <form  action="" method="post">
                                {if $ticket.status!='Closed'}

                                    <input type="hidden" value="closeticket" name="make" />
                                    <div class="close-issue">
                                        <div class="pull-right">
                                            <button type="submit" class="btn c-white-btn"><i class="icon-close-issue"></i> {$lang.resolved}</button>
                                        </div>
                                        <p>{$lang.resolvedticket}</p>
                                    </div>
                                {else}
                                    <input type="hidden" value="reopen" name="make" />
                                    <div class="close-issue">
                                        <div class="pull-right">
                                            <button type="submit" class="btn c-white-btn"><i class="icon-close-issue"></i> {$lang.reopen}</button>
                                        </div>
                                        <p>{$lang.notresolvedticket}</p>
                                    </div>
                                {/if}
                                {securitytoken}
                            </form>
                        </div>
                        <!-- End of Right Content -->
                    </div>
                </div>
            </div>

        </div>
    </div>
</article>

<script type="text/javascript" src="{$template_dir}js/jRating.jquery.js"></script>
<script type="text/javascript">
    var jRating_rateMax = parseInt('{$ratingscale}');
    {literal}
        $(".rating-box").jRating({rateMax: jRating_rateMax, starHeight: 10, starWidth: 20});
    {/literal}
</script>
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
    </script>
{/literal}
{include file="support/attachments.tpl"}
