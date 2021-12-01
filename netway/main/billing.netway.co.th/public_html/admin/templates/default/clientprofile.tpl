{php}
$templatePath   = $this->get_template_vars('template_path');
include($templatePath . 'clientprofile.tpl.php');
{/php}

<div class="blu">
    <div class="menubar">
        <a href="?cmd=clients&action=show&id={$parent.id}">
            <strong>&laquo; {$lang.backtoclient}</strong>
        </a>
        &nbsp;
        {if $action=='showprofile'}
            <a class=" menuitm menu-auto" href="{$system_url2}?action=adminlogin&id={$client.client_id}"
               target="_blank">
                <span><strong>{$lang.loginascontact}</strong></span>
            </a>
            <a class="menuitm clDropdown menu-auto" id="hd1" onclick="return false" href="#">
                <span class="morbtn">{$lang.moreactions}</span>
            </a>
            <ul id="hd1_m" class="ddmenu">
                <li><a href="SendNewPass">{$lang.SendNewPass}</a></li>
                <li><a href="ConvertToClient">{$lang.converttoclient}</a></li>
                <li>
                    <a href="?cmd=clients&action=showprofile&id={$client.id}&make=close&security_token={$security_token}"
                       class="directly">{$lang.CloseAccount}</a></li>
                <li><a href="DeleteContact" style="color:#ff0000">{$lang.deletecontact}</a></li>
            </ul>
            {if $client.crmcontactid != ''}
                <a class=" menuitm menu-auto" href="{$smarty.const.CRM_URL}/tab/Contacts/{$client.crmcontactid}"
                       target="_blank">
                    <span><strong>Go to CRM</strong></span>
                </a>
            {/if}

            {if $client.crispcontactid != ''}
                <a class=" menuitm menu-auto" href="{$smarty.const.CRISP_URL}/contacts/profile/{$client.crispcontactid}"
                       target="_blank">
                    <span><strong>Go to Crisp</strong></span>
                </a>
            {/if}
            {adminwidget module="contacts" section="profileheader"}
        {/if}
    </div>
</div>

<form action='' method='post'>
    <input type="hidden" value="{$client.client_id}" name="id" id="client_id"/>
    <input type="hidden" value="{$parent.id}" name="parent_id" id="parent_id"/>
    <input type="hidden" value="main" name="section_submit">
    <div id="ticketbody">
        {if $action=='showprofile'}
            <h1>#{$parent.id} <a
                        href="?cmd=clients&action=show&id={$parent.id}">{if $parent.companyname}{$parent.companyname}{else}{$parent.firstname} {$parent.lastname}{/if}</a> {$lang.contact}
                : {$client.firstname} {$client.lastname}</h1>
            <div id="client_nav">
                <!--navigation-->
                <a class="nav_el nav_sel left" href="#">Contact profile</a>
                <div class="clear"></div>
            </div>
            <div class="ticketmsg ticketmain" id="client_tab">
                <div class="slide" style="display:block">
                    <div class="" id="tdetail" style="display: none"><a href="#"><!-- legacy --></a></div>
                    <div id="detcont">

                        <div>
                            <div id="dbcCustomerDetail"></div>

                            <script type="text/javascript">
                            {literal}
                            $(document).ready( function () {
                                $('#dbcCustomerDetail').load('?cmd=dbccustomerhandle&action=detail&clientId={/literal}{$client.client_id}{literal}');
                            });
                            {/literal}
                            </script>
                        </div>

                        {include file='clients/tax_address.tpl'}

                        <div class="tdetails">
                            {include file='clients/_drawprofile.tpl'}
                            <div class="row">
                                <div class="col-md-12" style="text-align: center;">
                                    <a href="#" onclick="$('#tdetail a').click(); return false;" class="btn btn-primary">Edit contact details</a>
                                </div>
                            </div>
                        </div>
                        <div class="secondtd" style="display:none">
                            {include file='clients/_editprofile.tpl'}
                            <div class="row">
                                <div class="col-md-12" style="text-align: center;">
                                    <input type="submit"  id="clientsavechanges" class="btn btn-success" value="{$lang.savechanges}"></input>
                                    <input type="hidden" value="1" name="save"/>
                                    <span class="orspace fs11">{$lang.Or}</span>
                                    <a href="#" class="editbtn" onclick="$('#tdetail a').click(); return false;">{$lang.Cancel}</a>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
            <div class="row" style="color: #777">
                <div class="col-md-4"><label>{$lang.signupdate}:</label> {$client.datecreated|dateformat:$date_format}</div>
                <div class="col-md-6"><label>{$lang.clientlastlogin}:</label> {if $client.lastlogin == '0000-00-00 00:00:00'}{$lang.never}{else}{$client.lastlogin|dateformat:$date_format}{/if} {$lang.From} {$client.ip} {$lang.Host}: {$client.host}</div>

            </div>
        {elseif $action=='newprofile'}
            <h1>#{$parent.id} <a
                        href="?cmd=clients&action=show&id={$parent.id}">{if $parent.companyname}{$parent.companyname}{else}{$parent.firstname} {$parent.lastname}{/if}</a>
                &raquo; {$lang.addcontact}</h1>
            <input type="hidden" name="id" value="{$parent.id}"/>
            <div id="client_tab" class="ticketmsg ticketmain">
                <div class="container-fluid clear lighterblue" style="padding-top:14px">
                    <div class="row">
                        <div class="col-lg-8">
                            {foreach from=$fields key=gk item=group}
                                <div class="box box-primary">
                                    {if $group.id}
                                        {if $group.id}
                                            <div class="box-header collapsed" style="padding: 5px 15px;border-bottom: 1px solid #ddd;" href="#collapseGroupEdit-{$group.id}" role="button" data-toggle="collapse" aria-expanded="true" aria-controls="collapseGroupEdit-{$group.id}" onclick="$(this).find('.arrow_icon').attr('class', $(this).attr('aria-expanded') == 'true' ? 'arrow_icon fa fa-chevron-down' : 'arrow_icon fa fa-chevron-up')">
                                                <div style="display:flex;flex-direction:row;align-items:center;justify-content:space-between;">
                                                    <h2 style="margin: 5px 0">
                                                        {$group.name}
                                                        {if $group.description}
                                                            <span class="vtip_description" title="{$group.description}"></span>
                                                        {/if}
                                                    </h2>
                                                    <i class="fa fa-chevron-up arrow_icon" style="font-size: 16px"></i>
                                                </div>
                                            </div>
                                        {/if}
                                    {/if}
                                    <div class="{if $group.id}collapse in{/if}" {if $group.id}id="collapseGroupEdit-{$group.id}"{/if}>
                                        <div class="panel-body">
                                            <div class="row">
                                                {foreach from=$group.fields item=field name=floop key=k}
                                                    <div class="col-md-6">
                                                        {include file="clients/signup_input.tpl" fields=$group.fields}
                                                    </div>
                                                {/foreach}
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            {/foreach}
                        </div>

                        <div class="col-lg-4">
                            <div class="box box-primary">
                                <div class="panel-body">
                                    <div class="form-group">
                                        <label>Optional: </label>
                                        <div class="checkbox">
                                            <label>
                                                <input name="notifyclient" value="yes" type="checkbox"/> {$lang.notifyclient}
                                            </label>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
            <div class="blu">
                <div class="menubar" style="text-align: center">
                    <button type="submit" name="save" value="1" class="btn btn-success">
                        {$lang.addcontact}
                    </button>
                    <hr>
                    <p>Managing the permissions of this contact will be available after creation</p>
                </div>
            </div>
        {/if}
        {literal}
            <style type="text/css">
                .pgroup {
                    padding: 0 0 20px 15px
                }
            </style>
        {/literal}
    </div>


    {securitytoken}
</form>
{if $action=='showprofile'}
    <form action='' method='post'>
        <input type="hidden" value="{$client.client_id}" name="id" id="client_id"/>
        <input type="hidden" value="{$parent.id}" name="parent_id" id="parent_id"/>
        <input type="hidden" value="permissions" name="section_submit">
            <input type="hidden" value="{$privilages_pages}" name="totalpages2" id="totalpages"/>
            <div class="blu">
                <div class="left">
                    <h1>Contact Permissions:</h1>
                </div>
                <div class="right">
                    <div class="pagination"></div>
                </div>
                <div class="clear"></div>
            </div>
            <a href="?cmd=clients&action=showprofile_priviliages&id={$client.id}" id="currentlist" style="display:none" updater="#updater"></a>
            <table cellspacing="0" cellpadding="3" border="0" width="100%" class="table">
                <tbody>
                <tr>
                    <td id="updater">
                        {include file="ajax.clientprofile_priviliages.tpl"}
                    </td>
                </tr>
                </tbody>
            </table>
            <div class="blu">
                <div class="right">
                    <div class="pagination"></div>
                </div>
                <div class="clear"></div>
            </div>
        <div class="blu">
            <div class="menubar" style="text-align: center">
                <button type="submit" name="save" value="1" class="btn btn-success">
                    Save Contact Permissions
                </button>
            </div>
        </div>
        {securitytoken}
    </form>
{/if}