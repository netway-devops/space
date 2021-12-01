<script type="text/javascript">loadelements.emails = true;</script>
<table border="0" cellspacing="0" cellpadding="0" width="100%" id="content_tb" {if $currentfilter}class="searchon"{/if}>
    <tr>
        <td ><h3>{$lang.emailtemplates}</h3></td>
        <td></td>
    </tr>
    <tr>
        <td class="leftNav">
            <a href="?cmd=emailtemplates" class="tstyled selected">{$lang.emailtemplates}</a>
            <a href="?cmd=notifications" class="tstyled ">Mobile/SMS templates</a>
        </td>
        <td  valign="top"  class="bordered" rowspan="2"><div id="bodycont">
                {if $action=='add' ||  $action=='edit'}
                    <div class="blu">
                        {if $email.group=='Mobile'}
                            <a href="?cmd=notifications"
                               class="tload2"><strong>&laquo; {$lang.backto} {$lang.Notifications}</strong></a>
                            &nbsp;
                        {else}
                            <a href="?cmd=emailtemplates" class="tload2"><strong>&laquo; {$lang.backtoemailtpl}</strong></a>
                            &nbsp;
                        {/if}
                        <a class="btn btn-primary btn-sm btn-save">
                            {if $action=='add'}{$lang.addtemplate}{else}{$lang.savechanges}{/if}
                        </a>
                        <a href="?cmd=emailtemplates" class="btn btn-default btn-sm">{$lang.Cancel}</a>
                        {if $email.system=='0'}
                            <a class="btn btn-danger btn-sm"
                               href="?cmd=emailtemplates&security_token={$security_token}&make=delete&id={$email.id}"
                               onclick="return confirm('{$lang.deletetemplateconfirm}');">
                                {$lang.Delete}
                            </a>
                        {/if}
                    </div>
                    {include file='ajax.emailtemplates.tpl'}
                    <div class="blu">

                        {if $email.group=='Mobile'}
                            <a href="?cmd=notifications"
                               class="tload2"><strong>&laquo; {$lang.backto} {$lang.Notifications}</strong></a>
                            &nbsp;
                        {else}
                            <a href="?cmd=emailtemplates" class="tload2"><strong>&laquo; {$lang.backtoemailtpl}</strong></a>
                            &nbsp;
                        {/if}

                        <a class="btn btn-primary btn-sm btn-save">
                            {if $action=='add'}{$lang.addtemplate}{else}{$lang.savechanges}{/if}
                        </a>
                        <a href="?cmd=emailtemplates" class="btn btn-default btn-sm">{$lang.Cancel}</a>

                        {if $email.system=='0'}
                            <a class="btn btn-danger btn-sm"
                               href="?cmd=emailtemplates&security_token={$security_token}&make=delete&id={$email.id}"
                               onclick="return confirm('{$lang.deletetemplateconfirm}');">
                                {$lang.Delete}
                            </a>
                        {/if}

                    </div>
                    {literal}
                        <script>
                            $(function(){
                                $('.btn-save').on('click', function () {
                                    $('.template-form').submit();
                                    return false;
                                })
                            })
                        </script>
                    {/literal}

                {elseif $action=='preview'}
                    <div class="blu"> 
                        <a href="?cmd=emailtemplates" class="tload2"><strong>&laquo; {$lang.backtoemailtpl}</strong>
                        </a>&nbsp;
                    </div>
                    {literal}
                        <script language="javascript" type="text/javascript">
                            function resizeIframe(obj, content) {
                                if (content) {
                                    obj.contentWindow.document.write(content);
                                    obj.style.height = $(obj.contentWindow.document.body).height() + 'px';
                                    if ($(obj).data('type') === 'text'){
                                        $(obj).parent().removeClass('active');
                                    }
                                } else {
                                    obj.contentWindow.document.write('<body style="padding: 0; margin-left: 0"><em style="color:silver">Empty message</em></body>')
                                    obj.style.height = '30px'
                                }
                                //fix for big images without preset height
                                $('img', obj.contentWindow.document).on('load', function () {
                                    //console.log(obj.contentWindow.document.body.scrollHeight)
                                    obj.style.height = obj.contentWindow.document.body.scrollHeight + 'px';
                                })
                            }
                        </script>
                        <style>
                            .et-preview .nav-pills{
                                margin: -5px 0 0 -5px;
                            }
                            .et-preview .nav-pills a{
                                text-decoration: none;
                                padding: 3px 10px;
                                color: #888888;
                            }
                        </style> 
                    {/literal}
                    <div class="lighterblue" style="padding:5px;">

                        {if !$emails}
                            <div class="panel panel-danger et-preview">
                                <div class="panel-heading">
                                    <h3 class="panel-title">Preview was not generated</h3>
                                </div>
                                <div class="panel-body">
                                    <div class="tab-content">
                                        <div role="tabpanel" class="tab-pane active">
                                            Could not create email preview for this notification. Try with different parameters.
                                        </div>
                                    </div>
                                </div>
                            </div>
                        {else}
                            <div class="alert alert-danger">
                                This is just a preview to help with template development, actual email can be loaded with different data set. 
                                Before using this template in production please test it with real notifications.
                            </div>
                            {foreach from=$emails key=key item=email}
                                <div class="panel panel-default et-preview">
                                    <div class="panel-heading">
                                        <h3 class="panel-title"><strong>Subject</strong>: {$email.subject} <span class="label label-info">{$email.language}</span></h3>
                                    </div>
                                    <div class="panel-body">

                                        {if $email.sendas == 'both'}
                                            <!-- Nav tabs -->
                                            <ul class="nav nav-pills" role="tablist">
                                                <li role="presentation" class="active"><a href="#HTML{$key}" aria-controls="HTML" role="tab" data-toggle="tab">HTML</a></li>
                                                <li role="presentation"><a href="#PlainText{$key}" aria-controls="Plain Text" role="tab" data-toggle="tab">Plain Text</a></li>
                                            </ul>
                                        {/if}
                                        <!-- Tab panes -->
                                        <div class="tab-content">
                                            <div role="tabpanel" class="tab-pane active" id="HTML{$key}">
                                                <iframe style="width: 100%" frameborder="0" scrolling="no" data-type="html" onload="resizeIframe(this, {$email.message|@json_encode|escape})"></iframe>
                                            </div>
                                            {if $email.altmessage}
                                                <div role="tabpanel" class="tab-pane active" id="PlainText{$key}">
                                                    <iframe style="width: 100%" frameborder="0" scrolling="no" data-type="text" onload="resizeIframe(this, {$email.altmessage|@json_encode|escape})"></iframe>
                                                </div>
                                            {/if}
                                        </div>

                                    </div>
                                </div>
                            {/foreach}
                        {/if}
                    </div>


                {elseif $action=='default' || $action=='admins'}
                    {literal}
                        <script>
                            $(document).ready(function () {
                                $('#newshelfnav').TabbedMenu({
                                    elem: '.sectioncontent',
                                    picker: '.list-1 li',
                                    aclass: 'active'
                                });

                                $('#newshelfnav').TabbedMenu({
                                    elem: '.subm1',
                                    picker: '.list-1 li'
                                });
                            });
                        </script>
                    {/literal}



                    <div id="newshelfnav" class="newhorizontalnav">
                        <div class="list-1">
                            <ul>
                                <li class="active picked">
                                    <a href="#"><span class="ico money">Client Emails</span></a>
                                </li>
                                <li class="last">
                                    <a href="#"><span class="ico plug">Admin Emails</span></a>
                                </li>

                            </ul>
                        </div>
                        <div class="list-2">
                            <div class="subm1 haveitems" style="">
                                <ul>
                                    <li class=""><a href="?cmd=emailtemplates&action=add&for=Client"><span>Add custom client template</span></a></li>
                                </ul>
                            </div>
                            <div class="subm1 haveitems" style="">
                                <ul>
                                    <li class=""><a href="?cmd=emailtemplates&action=add&for=Admin"><span>Add custom admin template</span></a></li>
                                </ul>
                            </div>

                        </div>
                    </div>
                    <div style="padding:15px;">
                        <div class="sectioncontent">
                            {if $emails}

                                <table width="100%" cellspacing="0" cellpadding="3" border="0" class="whitetable" style="border:solid 1px #ddd;">
                                    <tbody>

                                        {if $emails.Custom}
                                            <tr >
                                                <th colspan="1" align="left">{$lang.MyMessages}</th>
                                                <th colspan="1" align="right">{$lang.Group}</th>
                                                <th colspan="4" align="right"></th>
                                            </tr>
                                            {foreach from=$emails.Custom item=email  name=fr}
                                                {if $email.for == 'Admin'}{continue}{/if}
                                                <tr class="havecontrols {if $email.system=='0'}man{/if} {if $smarty.foreach.fr.index%2==0}even{/if}">

                                                    <td style="padding-left:10px"><a href="?cmd=emailtemplates&action=edit&id={$email.id}" >{$email.tplname}</a></td>
                                                    <td width="100">{if $email.group == 'Invoice'}Billing{else}{$email.group}{/if}</td>
                                                    <td width="40"><a href="?cmd=emailtemplates&id={$email.id}&action=duplicate&security_token={$security_token}" class="editbtn editgray">{$lang.Duplicate}</a></td>
                                                    <td width="40"><a href="?cmd=emailtemplates&id={$email.id}&make={if $email.send=='1'}disable{else}enable{/if}&security_token={$security_token}" class="editbtn {if $email.send=='1'}editgray{/if}">{if $email.send=='1'}{$lang.Disable}{else}{$lang.Enable}{/if}</a></td>
                                                    <td width="23" align="center" ><a href="?cmd=emailtemplates&action=edit&id={$email.id}" class="editbtn">{$lang.Edit}</a></td>
                                                    <td width="17" class="lastitm">{if $email.system=='0'}<a href="?cmd=emailtemplates&make=delete&id={$email.id}&security_token={$security_token}" class="delbtn" onclick="return confirm('{$lang.deletetemplateconfirm}')">{$lang.Delete}</a>{/if}</td>
                                                </tr>
                                            {/foreach}
                                        {/if}
                                        <tr >
                                            <th colspan="1" align="left">{$lang.SystemMessages}</th>
                                            <th colspan="1">{$lang.Group}</th>
                                            <th colspan="4" align="right"></th>
                                        </tr>
                                        {foreach from=$emails.All item=email  name=fr}
                                            {if $email.for!='Admin'}

                                                <tr class="havecontrols {if $smarty.foreach.fr.index%2==0}even{/if} ">

                                                    <td style="padding-left:10px"><strong>{$lang.Client}: </strong><a href="?cmd=emailtemplates&action=edit&id={$email.id}" >{$email.tplname}</a></td>
                                                    <td width="100">{if $email.group == 'Invoice'}Billing{else}{$email.group}{/if}</td>
                                                    <td width="40"><a href="?cmd=emailtemplates&id={$email.id}&action=duplicate&security_token={$security_token}" class="editbtn editgray">{$lang.Duplicate}</a></td>
                                                    <td width="40"><a href="?cmd=emailtemplates&id={$email.id}&make={if $email.send=='1'}disable{else}enable{/if}&security_token={$security_token}" class="editbtn {if $email.send=='1'}editgray{/if}">{if $email.send=='1'}{$lang.Disable}{else}{$lang.Enable}{/if}</a></td>
                                                    <td width="23" align="center" ><a href="?cmd=emailtemplates&action=edit&id={$email.id}" class="editbtn">{$lang.Edit}</a></td>
                                                    <td width="17" class="lastitm">{if $email.system=='0'}<a href="?cmd=emailtemplates&make=delete&id={$email.id}&security_token={$security_token}" class="delbtn" onclick="return confirm('{$lang.deletetemplateconfirm}')">{$lang.Delete}</a>{/if}</td>
                                                </tr>
                                            {/if} 
                                        {/foreach}


                                    </tbody>
                                </table>
                            {else}
                                <strong>{$lang.noemailstodisplay}</strong>

                            {/if}




                        </div>
                        <div class="sectioncontent" style="display:none">
                            {if $emails}

                                <table width="100%" cellspacing="0" cellpadding="3" border="0" class="whitetable" style="border:solid 1px #ddd;">
                                    <tbody>
                                        {if $emails.Custom}
                                            <tr >
                                                <th colspan="1" align="left">{$lang.MyMessages}</th>
                                                <th colspan="1" align="right">{$lang.Group}</th>
                                                <th colspan="4" align="right"></th>
                                            </tr>
                                            {foreach from=$emails.Custom item=email  name=fr}
                                                {if $email.for != 'Admin'}{continue}{/if}
                                                <tr class="havecontrols {if $email.system=='0'}man{/if} {if $smarty.foreach.fr.index%2==0}even{/if}">

                                                    <td style="padding-left:10px"><a href="?cmd=emailtemplates&action=edit&id={$email.id}" >{$email.tplname}</a></td>
                                                    <td width="100">{if $email.group == 'Invoice'}Billing{else}{$email.group}{/if}</td>
                                                    <td width="40"><a href="?cmd=emailtemplates&id={$email.id}&action=duplicate&security_token={$security_token}" class="editbtn editgray">{$lang.Duplicate}</a></td>
                                                    <td width="40"><a href="?cmd=emailtemplates&id={$email.id}&make={if $email.send=='1'}disable{else}enable{/if}&security_token={$security_token}" class="editbtn {if $email.send=='1'}editgray{/if}">{if $email.send=='1'}{$lang.Disable}{else}{$lang.Enable}{/if}</a></td>
                                                    <td width="23" align="center" ><a href="?cmd=emailtemplates&action=edit&id={$email.id}" class="editbtn">{$lang.Edit}</a></td>
                                                    <td width="17" class="lastitm">{if $email.system=='0'}<a href="?cmd=emailtemplates&make=delete&id={$email.id}&security_token={$security_token}" class="delbtn" onclick="return confirm('{$lang.deletetemplateconfirm}')">{$lang.Delete}</a>{/if}</td>
                                                </tr>
                                            {/foreach}
                                        {/if}

                                        <tr >
                                            <th colspan="1" align="left">{$lang.SystemMessages}</th>
                                            <th colspan="1">{$lang.Group}</th>
                                            <th colspan="3"></th>
                                        </tr>
                                        {foreach from=$emails.All item=email  name=fr}
                                            {if $email.for=='Admin'}

                                                <tr class="havecontrols {if $smarty.foreach.fr.index%2==0}even{/if} ">

                                                    <td style="padding-left:10px"><strong>{$lang.Admin}: </strong><a href="?cmd=emailtemplates&action=edit&id={$email.id}" >{$email.tplname}</a></td>
                                                    <td width="100">{$email.group}</td>
                                                    <td width="40"><a href="?cmd=emailtemplates&id={$email.id}&make={if $email.send=='1'}disable{else}enable{/if}&security_token={$security_token}" class="editbtn {if $email.send=='1'}editgray{/if}">{if $email.send=='1'}{$lang.Disable}{else}{$lang.Enable}{/if}</a></td>
                                                    <td width="23" align="center" ><a href="?cmd=emailtemplates&action=edit&id={$email.id}" class="editbtn">{$lang.Edit}</a></td>
                                                    <td width="17" class="lastitm">{if $email.system=='0'}<a href="?cmd=emailtemplates&make=delete&id={$email.id}&security_token={$security_token}" class="delbtn" onclick="return confirm('{$lang.deletetemplateconfirm}')">{$lang.Delete}</a>{/if}</td>
                                                </tr>
                                            {/if} 
                                        {/foreach}


                                    </tbody></table>
                                {else}
                                <strong>{$lang.noemailstodisplay}</strong>

                            {/if}



                        </div>
                    </div>
                {/if}

            </div>
        </td>
    </tr>
</table>