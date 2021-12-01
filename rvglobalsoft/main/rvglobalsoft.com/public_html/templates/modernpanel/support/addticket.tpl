<!--BOF: FILEUPLOAD -->
<link media="all" type="text/css" rel="stylesheet" href="{$template_dir}js/fileupload/styles.css" />
<!--EOF: FILEUPLOAD -->

<article>
    <h2><i class="icon-main-mail"></i> {$lang.openticket}</h2>
    <p>{$lang.mytickets_desc}</p>
    <div class="invoices-box clearfix">
        <ul id="support-tab" class="nav nav-tabs table-nav">
            <li class="active"><a href="#support1" data-toggle="tab"><div class="tab-left"></div> {$lang.newticket} <div class="tab-right"></div></a></li>
        </ul>
        <div class="tab-content support-tickets-tab no-p">
            <div class="tab-pane active" id="support1">
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
                <div class="support-new-ticket-box">
                    <form  enctype="multipart/form-data" method="post" action="" id="ticketsform" style="margin: 0">
                        <div class="padding overflow-hidden">

                            <input name="make" type="hidden" value="addticket" />
                            <fieldset>

                                <label>{$lang.department}</label>
                                <select name="dept_id" class="span3" onchange="switchdeptdesc(this.value)">
                                    {foreach from=$depts item=dept}
                                        <option value="{$dept.id}" {if $submit.dept_id==$dept.id}selected="selected"{/if}>{$dept.name}</option>
                                    {/foreach}
                                </select>
                                {foreach from=$depts item=dept name=fff}
                                    <span class="department-description dept_{$dept.id}" {if $submit.dept_id && $submit.dept_id==$dept.id} style="display:block" {elseif $smarty.foreach.fff.first}  style="display:block"  {else} style="display:none"{/if}>
                                        {$dept.description}
                                    </span>
                                {/foreach}
                                {foreach from=$depts item=dept name=fff}
                                    {if $depts_avg[$dept.id]}
                                        <div class="date-box" class="dept_{$dept.id}" {if $submit.dept_id && $submit.dept_id==$dept.id} style="display:block" {elseif $smarty.foreach.fff.first}  style="display:block" {else} style="display:none" {/if}>
                                            <i class="icon-large-date"></i>
                                            <span class="t-date">
                                                {$lang.deptavgresponsetime}
                                            </span> 
                                            <p class="t-date bold">{$depts_avg[$dept.id]|convert:'second'}</p>
                                        </div>
                                    {/if}
                                {/foreach}
                            </fieldset>

                            {if !$clientdata.firstname}
                                <fieldset>
                                    <label>{$lang.name}</label>
                                    <input type="text" name="client_name" value="{$submit.client_name}"/>

                                    <label>{$lang.email}</label>
                                    <input type="text" name="client_email" value="{$submit.client_email}"/>
                                </fieldset>
                            {else}
                                {foreach from=$depts item=dept name=loop}
                                    {if $dept.options & 64}
                                        <fieldset id="p{$dept.id}" class="dptpriority" {if ($submit && $submit.dept_id!=$dept.id) || ( !$submit && !$smarty.foreach.loop.first)}style="display: none"{/if}>
                                            <label>{$lang.priority}</label>
                                            <select {if ($submit && $submit.dept_id!=$dept.id) || ( !$submit && !$smarty.foreach.loop.first)}disabled="disabled"{/if} 									name="priority" style="float:left; margin-right:10px;">
                                                <option {if $submit.priority==0}selected="selected"{/if} value="0" >{$lang.low}</option>
                                                <option {if $submit.priority==1}selected="selected"{/if} value="1" >{$lang.medium}</option>
                                                <option {if $submit.priority==2}selected="selected"{/if} value="2" >{$lang.high}</option>
                                            </select>
                                        </fieldset>
                                    {/if}
                                {/foreach}

                            {/if}
                            <fieldset>
                                <label>{$lang.subject}</label>
                                <input class="t-subject" type="text" value="{$submit.subject}"  name="subject"/>
                            </fieldset>

                            <fieldset>
                                <label>{$lang.message}</label>
                                <textarea name="body" id="ticketmessage">{$submit.body}</textarea>
                            </fieldset>
                            {if $captcha}
                                <fieldset>
                                    <label>{$lang.typethecharacters}</label>
                                    <input type="text" value="" size="15" name="image_verification"   style="width:100px"/>
                                    <img src="?cmd=root&amp;action=captcha" alt="captcha" />
                                </fieldset>
                            {/if}
                        </div>

                        <!--BOF: FILEUPLOAD Provide url to file upload handler in data-url -->
                        <div class="upload-box" id="fileupload" data-url="?cmd=tickets&action=handleupload">
                            <div class="pattern" id="dropzonecontainer">
                                <div id="dropzone"><h2>{$lang.droptoattach}</h2></div>
                                <div class="padding clearfix">
                                    <div class="pull-left">
                                        <span class="btn c-white-btn fileinput-button">
                                            <i class="icon-add-file"></i> {$lang.attachfile}
                                            <input type="file" name="attachments[]" multiple  />
                                        </span>
                                        <div class="info">
                                            <span>{$lang.allowedext}</span>
                                            <p>{$extensions}</p>
                                        </div>

                                    </div>
                                    <div class="pull-right">
                                        &nbsp;<button id="submitbutton" type="submit" class="btn c-orange-btn"><i class="icon-pay-due"></i> {$lang.submit}</button>
                                    </div>
                                    <div class="pull-right">
                                        &nbsp;<a href="{$ca_url}tickets/" class="btn c-white-btn"><i class="icon-back"></i> {$lang.back}</a>
                                    </div>

                                    <table role="presentation" class="table table-striped fixed-table fileupload-progress-table">
                                        <tbody class="files"></tbody>
                                    </table>
                                    <!-- The global progress information -->
                                    <div class="clear fileupload-progress fade" style="display: none;">
                                        <!-- The global progress bar -->
                                        <div class="progress progress-success progress-striped active" role="progressbar" aria-valuemin="0" aria-valuemax="100">
                                            <div class="bar" style="width:0%;"></div>
                                        </div>
                                        <!-- The extended global progress information -->
                                        <div class="progress-extended"></div>
                                    </div>

                                    <div class="clear"></div>
                                </div>
                            </div>
                        </div>
                    </form>       
                </div>
            </div>
        </div>
    </div>
</article>
{literal}
    <script type="text/javascript">
                                            function switchdeptdesc(items) {
                                                $('.deptsdesc').find('div').hide();
                                                $('.dept_' + items).show();
                                                $('.dptpriority').hide().find('select').attr('disabled', 'disabled');
                                                $('#p' + items).show().find('select').removeAttr('disabled');
                                            }
    </script>
{/literal}
{include file="support/attachments.tpl"}