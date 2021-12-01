{php}
$templatePath   = $this->get_template_vars('template_path');
include($templatePath . 'ajax.logs.tpl.php');
{/php}

{if $action=='manage'}
    <div id="newshelfnav" class="newhorizontalnav">
        <div class="list-1" >
            <ul>
                <li class="active ">
                    <a href="?cmd=logs&action=manage">Clear logs</a>
                </li>
                <li class="last">
                    <a href="{$rotatelog_link}"><span>Rotate Logs</span></a>
                </li>

            </ul>
        </div>

    </div>
    <div class="lighterblue" style="padding:5px">

        <div class="well" role="alert">{$lang.clearloginfo}</div>
        <form method="post" action="">
            <input type="hidden" name="make" value="delete" />

            <table border="0" cellpadding="3" width="500" cellspacing="0">
                <tr><td colspan="3"><strong>{$lang.choosedeltype}:</strong></td></tr>

                <tr>
                    <td width="20"><input type="radio" name="from_date" checked="checked" value="0"/></td>
                    <td colspan="2">{$lang.deleteallent}</td>
                </tr>
                <tr>
                    <td width="20"><input type="radio" name="from_date"  value="1"/></td>
                    <td>{$lang.deleteolderthan}: </td>
                    <td><input class="haspicker" name="date" /></td>
                </tr>

                <tr><td colspan="3"><strong>{$lang.deletefrom}:</strong></td></tr>

                <tr>
                    <td width="20"><input type="checkbox" name="tickets_emails" value="1"/></td>
                    <td colspan="2">{$lang.ticketimplog}</td>
                </tr>
                <tr>
                    <td width="20"><input type="checkbox" name="gateway_log" value="1"/></td>
                    <td colspan="2">{$lang.Gatewaylog}</td>
                </tr>

                <tr>
                    <td width="20"><input type="checkbox" name="client_activity_log" value="1"/></td>
                    <td colspan="2">{$lang.clactivitylog}</td>
                </tr>
                <tr>
                    <td width="20"><input type="checkbox" name="client_credit_log" value="1"/></td>
                    <td colspan="2">{$lang.clientcreditlog}</td>
                </tr>
                <tr>
                    <td width="20"><input type="checkbox" name="ccard_log" value="1"/></td>
                    <td colspan="2">Card Changes Log</td>
                </tr>
                <tr>
                    <td width="20"><input type="checkbox" name="admin_log" value="1"/></td>
                    <td colspan="2">{$lang.adactivitylog}</td>
                </tr>

                <tr>
                    <td width="20"><input type="checkbox" name="configuration_log" value="1"/></td>
                    <td colspan="2">Configuration log</td>
                </tr>

                <tr>
                    <td width="20"><input type="checkbox" name="system_log" value="1"/></td>
                    <td colspan="2">{$lang.systemlog}</td>
                </tr>

                <tr>
                    <td width="20"><input type="checkbox" name="email_log" value="1"/></td>
                    <td colspan="2">{$lang.sentemailslog}</td>
                </tr>

                <tr>
                    <td width="20"><input type="checkbox" name="notifications_log" value="1"/></td>
                    <td colspan="2">{$lang.sentnotificationslog}</td>
                </tr>

                <tr>
                    <td width="20"><input type="checkbox" name="domain_log" value="1"/></td>
                    <td colspan="2">{$lang.domactivitylog}</td>
                </tr>

                <tr>
                    <td width="20"><input type="checkbox" name="product_log" value="1"/></td>
                    <td colspan="2">Product log</td>
                </tr>

                <tr>
                    <td width="20"><input type="checkbox" name="account_log" value="1"/></td>
                    <td colspan="2">{$lang.accactivitylog}</td>
                </tr>
                {*}
                <tr>
                    <td width="20"><input type="checkbox" name="coupons_log" value="1"/></td>
                    <td colspan="2">{$lang.discountcouponslog}</td>
                </tr>
                {*}
                <tr>
                    <td width="20"><input type="checkbox" name="chat_log" value="1"/></td>
                    <td colspan="2">{$lang.chatlog}</td>
                </tr>
                <tr>
                    <td width="20"><input type="checkbox" name="error_log" value="1"/></td>
                    <td colspan="2">{$lang.errorlog}</td>
                </tr>

                <tr>
                    <td width="20"><input type="checkbox" name="api_log" value="1"/></td>
                    <td colspan="2">{$lang.apilog}</td>
                </tr>
                <tr>
                    <td width="20"><input type="checkbox" name="client_changes_log" value="1"/></td>
                    <td colspan="2">{$lang.clientchangeslog}</td>
                </tr>
                <tr>
                    <td width="20"><input type="checkbox" name="queue_status" value="1"/></td>
                    <td colspan="2">Task queue log</td>
                </tr>


                <tr><td colspan="3" align="left"><input type="submit" value="{$lang.clearselectedlogs}" style="font-weight:bold" class="btn btn-warning btn-sm"/></td></tr>
            </table>{securitytoken}</form>
    </div>


{elseif $action=='clientactivity'}
    {if $logs}
        {if $showall}
            <form action="" method="post" id="testform" ><input type="hidden" value="{$totalpages}" name="totalpages2" id="totalpages"/>
                <div class="blu">
                    <div class="right">
                        <div class="pagination"></div>
                    </div>
                    <div class="clear"></div>
                </div>

                <a href="?cmd=logs&action=clientactivity" id="currentlist" style="display:none" updater="#updater"></a>
                <table cellspacing="0" cellpadding="3" border="0" width="100%" class="table glike hover">
                    <tbody>
                        <tr>
                            <th width="150"><a href="?cmd=logs&action=clientactivity&orderby=lastname|ASC" data-orderby="lastname"  class="sortorder">{$lang.Client}</a></th>
                            <th width="150"><a href="?cmd=logs&action=clientactivity&orderby=date|ASC" data-orderby="date"  class="sortorder">{$lang.Date}</a></th>
                            <th ><a href="?cmd=logs&action=clientactivity&orderby=description|ASC" data-orderby="description"  class="sortorder">{$lang.Action}</a></th>
                            <th width="150"><a href="?cmd=logs&action=clientactivity&orderby=ip|ASC" data-orderby="ip"  class="sortorder">IP</a></th>
                            <th width="150"><a href="?cmd=logs&action=clientactivity&orderby=admin_name|ASC" data-orderby="admin_name"  class="sortorder">Logged staff</a></th>
                        </tr>
                    </tbody>
                    <tbody id="updater">
                    {/if}
                    {foreach from=$logs item=email}
                        <tr>

                            <td><a href="?cmd=clients&action=show&id={$email.client_id}">{$email.firstname} {$email.lastname}</a></td>
                            <td>{$email.date|dateformat:$date_format}</td>
                            <td>{$email.description}</td>
                            <td>{$email.ip}</td>
                            <td>{$email.admin_name}</td>


                        </tr>
                    {/foreach}
                    {if $showall}
                    </tbody>
                    <tbody id="psummary">
                        <tr>
                            <th colspan="5">
                                {$lang.showing} <span id="sorterlow">{$sorterlow}</span> - <span id="sorterhigh">{$sorterhigh}</span> {$lang.of} <span id="sorterrecords">{$sorterrecords}</span>

                            </th>
                        </tr>
                    </tbody>
                </table>
                <div class="blu">
                    <div class="right">
                        <div class="pagination"></div>
                    </div>
                    <div class="clear"></div>
                </div>
                {securitytoken}
            </form>
        {/if}
    {else}
        {if $showall}
            <p class="blu"> {$lang.nothingtodisplay} </p>
        {else}
            <tr>
                <td colspan="3"><p align="center" > {$lang.nothingtodisplay} </p></td>
            </tr>
        {/if}
    {/if}
{elseif $action=='accountlogs'}
    {if $logs}
        {if $showall}
        <form action="" method="post" id="testform" ><input type="hidden" value="{$totalpages}" name="totalpages2" id="totalpages"/>
            <div class="blu">
                <div class="right">
                    <div class="pagination"></div>
                </div>
                <div class="clear"></div>
            </div>
            <a href="?cmd=logs&action=accountlogs" id="currentlist" style="display:none" updater="#updater"></a>
            <table cellspacing="0" cellpadding="3" border="0" width="100%" class="table glike hover">
                <tbody>
                    <tr>
                        <th width="7%"><a href="?cmd=logs&action=accountlogs&orderby=account_id|ASC"  class="sortorder">{$lang.Account}</a></th>
                        <th width="10%"><a href="?cmd=logs&action=accountlogs&orderby=date|ASC"  class="sortorder">{$lang.Date}</a></th>
                        <th width="5"><a href="?cmd=logs&action=accountlogs&orderby=admin_login|ASC"  class="sortorder">{$lang.Login}</a></th>
                        <th width="8"><a href="?cmd=logs&action=accountlogs&orderby=module|ASC"  class="sortorder">{$lang.Module}</a></th>
                        <th width="10%"><a href="?cmd=logs&action=accountlogs&orderby=action|ASC"  class="sortorder">{$lang.Action}</a></th>
                        <th width="10%"><a href="?cmd=logs&action=accountlogs&orderby=result|ASC"  class="sortorder">{$lang.Result}</a></th>
                        <th width="30%">{$lang.Change}</th>
                        <th width="20%">{$lang.Error}</th>
                    </tr>
                </tbody>
            <tbody id="updater">
        {/if}
        {foreach from=$logs item=log}
            <tr {if $log.manual=='1'}class="man"{/if}>
                <td><a href='?cmd=accounts&action=edit&id={$log.account_id}'>{$log.account_id}</a></td>
                <td>{$log.date}</td>
                <td>{$log.admin_login}</td>
                <td>{$log.module}</td>
                <td>{$log.action}</td>
                <td>{if $log.result == 1}
                        <span style="color:#006633">{$lang.Success}</span>
                    {else}
                        <span style="color:#990000">{$lang.Failure}</span>
                    {/if}
                </td>
                <td>
                    {if $log.change}
                        {if $log.change.serialized}
                            <ul class="log_list">
                                {foreach from=$log.change.data item=change}
                                    <li>
                                        {if $change.name}<span class="log_change">{$change.name} :</span>{/if}
                                        {$change.from}
                                        {if $change.to} -> {$change.to}{/if}
                                    </li>
                                {/foreach}
                            </ul>
                        {else}{$log.change.data}{/if}
                    {/if}
                </td>
                <td>{$log.error}</td>
            </tr>
        {/foreach}
        {if $showall}
            </tbody>
            <tbody id="psummary">
            <tr>
                <th colspan="8">
                    {$lang.showing} <span id="sorterlow">{$sorterlow}</span> - <span id="sorterhigh">{$sorterhigh}</span> {$lang.of} <span id="sorterrecords">{$sorterrecords}</span>
                </th>
            </tr>
            </tbody>
            </table>
            <div class="blu">
                <div class="right">
                    <div class="pagination"></div>
                </div>
                <div class="clear"></div>
            </div>
            {securitytoken}
        </form>
        {/if}
    {else}
        {if $showall}
            <p class="blu"> {$lang.nothingtodisplay} </p>
        {else}
            <tr>
                <td colspan="3"><p align="center" > {$lang.nothingtodisplay} </p></td>
            </tr>
        {/if}
    {/if}
{elseif $action=='domainlogs'}
    {if $logs}
        {if $showall}
            <form action="" method="post" id="testform" ><input type="hidden" value="{$totalpages}" name="totalpages2" id="totalpages"/>
            <div class="blu">
                <div class="right">
                    <div class="pagination"></div>
                </div>
                <div class="clear"></div>
            </div>
            <a href="?cmd=logs&action=domainlogs" id="currentlist" style="display:none" updater="#updater"></a>
            <table cellspacing="0" cellpadding="3" border="0" width="100%" class="table glike hover">
            <tbody>
            <tr>
                <th width="7%"><a href="?cmd=logs&action=domainlogs&orderby=domain_id|ASC"  class="sortorder">{$lang.Domain}</a></th>
                <th width="10%"><a href="?cmd=logs&action=domainlogs&orderby=date|ASC"  class="sortorder">{$lang.Date}</a></th>
                <th width="5"><a href="?cmd=logs&action=domainlogs&orderby=admin_login|ASC"  class="sortorder">{$lang.Login}</a></th>
                <th width="8"><a href="?cmd=logs&action=domainlogs&orderby=module|ASC"  class="sortorder">{$lang.Module}</a></th>
                <th width="10%"><a href="?cmd=logs&action=domainlogs&orderby=action|ASC"  class="sortorder">{$lang.Action}</a></th>
                <th width="10%"><a href="?cmd=logs&action=domainlogs&orderby=result|ASC"  class="sortorder">{$lang.Result}</a></th>
                <th width="30%">{$lang.Change}</th>
                <th width="20%">{$lang.Error}</th>
            </tr>
            </tbody>
            <tbody id="updater">
        {/if}
        {foreach from=$logs item=log}
            <tr {if $log.manual=='1'}class="man"{/if}>
                <td><a href='?cmd=domains&action=edit&id={$log.domain_id}'>{$log.domain_id}</a></td>
                <td>{$log.date}</td>
                <td>{$log.admin_login}</td>
                <td>{$log.module}</td>
                <td>{$log.action}</td>
                <td>{if $log.result == 1}
                        <span style="color:#006633">{$lang.Success}</span>
                    {else}
                        <span style="color:#990000">{$lang.Failure}</span>
                    {/if}
                </td>
                <td>
                    {if $log.change}
                        {if $log.change.serialized}
                            <ul class="log_list">
                                {foreach from=$log.change.data item=change}
                                    <li>
                                        {if $change.name}<span class="log_change">{$change.name} :</span>{/if}
                                        {$change.from}
                                        {if $change.to} -> {$change.to}{/if}
                                    </li>
                                {/foreach}
                            </ul>
                        {else}{$log.change.data}{/if}
                    {/if}
                </td>
                <td>{$log.error}</td>
            </tr>
        {/foreach}
        {if $showall}
            </tbody>
            <tbody id="psummary">
            <tr>
                <th colspan="8">
                    {$lang.showing} <span id="sorterlow">{$sorterlow}</span> - <span id="sorterhigh">{$sorterhigh}</span> {$lang.of} <span id="sorterrecords">{$sorterrecords}</span>
                </th>
            </tr>
            </tbody>
            </table>
            <div class="blu">
                <div class="right">
                    <div class="pagination"></div>
                </div>
                <div class="clear"></div>
            </div>
            {securitytoken}
            </form>
        {/if}
    {else}
        {if $showall}
            <p class="blu"> {$lang.nothingtodisplay} </p>
        {else}
            <tr>
                <td colspan="3"><p align="center" > {$lang.nothingtodisplay} </p></td>
            </tr>
        {/if}
    {/if}
{elseif $action=='productlogs'}
    {if $logs}
        {if $showall}
            <form action="" method="post" id="testform" >
            <input type="hidden" value="{$totalpages}" name="totalpages2" id="totalpages"/>
            <div class="blu">
                <div class="right">
                    <div class="pagination"></div>
                </div>
                <div class="clear"></div>
            </div>
            <a href="?cmd=logs&action=productlogs" id="currentlist" style="display:none" updater="#updater"></a>
            <table cellspacing="0" cellpadding="3" border="0" width="100%" class="table glike hover">
            <tbody>
            <tr>
                <th width="20%"><a href="?cmd=logs&action=productlogs&orderby=domain_id|ASC"  class="sortorder">{$lang.Product}</a></th>
                <th width="10%"><a href="?cmd=logs&action=productlogs&orderby=date|ASC"  class="sortorder">{$lang.Date}</a></th>
                <th width="10"><a href="?cmd=logs&action=productlogs&orderby=admin_login|ASC"  class="sortorder">{$lang.Login}</a></th>
                <th width="10%">Number of changes</th>
                <th width="30%">Changes</th>
                <th width="20%">Changes</th>
            </tr>
            </tbody>
            <tbody id="updater">
        {/if}
        {foreach from=$logs key=lk item=log}
            <tr>
                <td><a href='?cmd=services&action=product&id={$log.product_id}'>#{$log.product_id} {$log.category_name} - {$log.product_name}</a></td>
                <td>{$log.date}</td>
                <td>{$log.admin_login}</td>
                <td>{$log.change.actions|@count}</td>
                <td>
                    {foreach from=$log.change.actions item=change}
                        <i>{$change},</i>
                    {/foreach}
                </td>
                <td>
                    <a href="#" class="btn btn-default btn-sm" data-toggle="modal" data-target="#productlog-modal-{$lk}">Show all changes</a>


                    <div class="modal fade" tabindex="-1" role="dialog" id="productlog-modal-{$lk}">
                        <div class="modal-dialog modal-lg" role="document">
                            <div class="modal-content">
                                <div class="modal-header">
                                    <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                                        <span aria-hidden="true">&times;</span>
                                    </button>
                                    <h4 class="modal-title">Log Details</h4>
                                </div>
                                <div class="modal-body">
                                    <b>Product:</b> <a href='?cmd=services&action=product&id={$log.product_id}'>#{$log.product_id} {$log.category_name} - {$log.product_name}</a><br>
                                    <b>Date:</b> {$log.date} <br>
                                    <b>By:</b> {$log.admin_login} <br>
                                    <hr> <br>
                                    {foreach from=$log.change key=group item=changes}
                                        {if $group !== 'actions' && $group !== 'extra' && $changes}
                                            <table class="table table-striped" style="width: 100%;overflow: hidden;text-wrap: normal">
                                                <thead>
                                                <tr>
                                                    <th colspan="3"><b>{if $lang[$group]}{$lang[$group]}{else}{$group|ucfirst}{/if}</b></th>
                                                </tr>
                                                <tr>
                                                    <th>Name</th>
                                                    <th>From</th>
                                                    <th>To</th>
                                                </tr>
                                                </thead>
                                                <tbody>
                                                {foreach from=$changes item=change}
                                                    <tr>
                                                        <td width="30%">{if $lang[$change.name]}{$lang[$change.name]}{else}{$change.name}{/if}:</td>
                                                        <td width="35%">{if $change.from==='__added__'}<i style="color: darkgrey">added</i>{else}{$change.from|nl2br}{/if}</td>
                                                        <td width="35%">{if $change.to==='__removed__'}<i style="color: darkgrey">removed</i>{else}{$change.to|nl2br}{/if}</td>
                                                    </tr>
                                                {/foreach}
                                                </tbody>
                                            </table>
                                            <hr>
                                        {/if}
                                    {/foreach}

                                    {if $log.change.extra}
                                        <b>Extra details</b>
                                        <pre>{$log.change.extra}</pre>
                                    {/if}
                                </div>
                                <div class="modal-footer">
                                    <button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
                                </div>
                            </div>
                        </div>
                    </div>

                </td>
            </tr>
        {/foreach}
        {if $showall}
            </tbody>
            <tbody id="psummary">
            <tr>
                <th colspan="8">
                    {$lang.showing} <span id="sorterlow">{$sorterlow}</span> - <span id="sorterhigh">{$sorterhigh}</span> {$lang.of} <span id="sorterrecords">{$sorterrecords}</span>
                </th>
            </tr>
            </tbody>
            </table>
            <div class="blu">
                <div class="right">
                    <div class="pagination"></div>
                </div>
                <div class="clear"></div>
            </div>
            {securitytoken}
            </form>
        {/if}
    {else}
        {if $showall}
            <p class="blu"> {$lang.nothingtodisplay} </p>
        {else}
            <tr>
                <td colspan="3"><p align="center" > {$lang.nothingtodisplay} </p></td>
            </tr>
        {/if}
    {/if}
{elseif $action=='gdprrequests'}
    {if $logs}

        {if $showall}
            <form action="" method="post" id="testform" ><input type="hidden" value="{$totalpages}" name="totalpages2" id="totalpages"/>
            <div class="blu">

                <div class="right">
                    <div class="pagination"></div>
                </div>
                <div class="clear"></div>
            </div>

            <a href="?cmd=logs&action=gdprrequests" id="currentlist" style="display:none" updater="#updater"></a>
            <table cellspacing="0" cellpadding="3" border="0" width="100%" class="table glike hover">
            <tbody>
                <tr>
                    <th width="150"><a href="?cmd=logs&action=gdprrequests&orderby=date|ASC"  class="sortorder">{$lang.Date}</a></th>
                    <th width="150"><a href="?cmd=logs&action=gdprrequests&orderby=lastname|ASC"  class="sortorder">{$lang.Client}</a></th>
                    <th width="150"><a href="?cmd=logs&action=gdprrequests&orderby=name|ASC"  class="sortorder">Requested By</a></th>
                    <th >Purpose</th>
                    <th width="150"><a href="?cmd=logs&action=gdprrequests&orderby=username|ASC"  class="sortorder">Staff</a></th>

                </tr>
            </tbody>
            <tbody id="updater">

        {/if}

        {foreach from=$logs item=email}
            <tr>
                <td>{$email.date|dateformat:$date_format}</td>
                <td><a href="?cmd=clients&action=show&id={$email.client_id}">{$email.firstname} {$email.lastname}</a></td>
                <td>{$email.name|escape}</td>
                <td>{$email.purpose|escape}</td>
                <td>{$email.username}</td>
            </tr>
        {/foreach}

        {if $showall}
            </tbody>
            <tbody id="psummary">
                <tr>
                    <th colspan="5">
                        {$lang.showing} <span id="sorterlow">{$sorterlow}</span> - <span id="sorterhigh">{$sorterhigh}</span> {$lang.of} <span id="sorterrecords">{$sorterrecords}</span>

                    </th>
                </tr>
            </tbody>

            </table>
            <div class="blu">

                <div class="right">
                    <div class="pagination"></div>
                </div>
                <div class="clear"></div>
            </div>

            {securitytoken}</form>

        {/if}

    {else}
        {if $showall}
            <p class="blu"> {$lang.nothingtodisplay} </p>
        {else}
            <tr>
                <td colspan="3"><p align="center" > {$lang.nothingtodisplay} </p></td>
            </tr>
        {/if}
    {/if}
{elseif $action=='declinedcards'}
    {if $logs}

        {if $showall}
            <form action="" method="post" id="testform" >
            <input type="hidden" value="{$totalpages}" name="totalpages2" id="totalpages"/>
            <div class="blu">

                <div class="right">
                    <div class="pagination"></div>
                </div>
                <div class="clear"></div>
            </div>

            <a href="?cmd=logs&action=declinedcards" id="currentlist" style="display:none" updater="#updater"></a>
            <table cellspacing="0" cellpadding="3" border="0" width="100%" class="table glike hover">
            <tbody>
            <tr>
                <th width="150">
                    <a href="?cmd=logs&action=declinedcards&orderby=date|ASC" class="sortorder">{$lang.Date}</a>
                </th>
                <th>
                    <a href="?cmd=logs&action=declinedcards&orderby=lastname|ASC" class="sortorder">{$lang.Client}</a>
                </th>
                <th>
                    <a href="?cmd=logs&action=declinedcards&orderby=username|ASC"  class="sortorder">Card</a>
                </th>
                <th>
                    <a href="?cmd=logs&action=declinedcards&orderby=name|ASC"  class="sortorder">Reason</a>
                </th>
                <th width="150">

                </th>
            </tr>
            </tbody>
            <tbody id="updater">

        {/if}

        {foreach from=$logs item=email}
            <tr>
                <td>{$email.date|dateformat:$date_format}</td>
                <td><a href="?cmd=clients&action=show&id={$email.client_id}">{$email|@client}</a></td>
                <td>{$email.card}</td>
                <td>{$email.reason}</td>
                <td>
                    <div class="text-right">
                        <a class="btn btn-xs btn-default show-log"
                           href="?cmd=logs&action=declinedcardlog&id={$email.id}"
                           title="Show related gateway log">Log</a>
                    </div>
                </td>
            </tr>
        {/foreach}

        {if $showall}
            </tbody>
            <tbody id="psummary">
            <tr>
                <th colspan="5">
                    {$lang.showing} <span id="sorterlow">{$sorterlow}</span> - <span id="sorterhigh">{$sorterhigh}</span> {$lang.of} <span id="sorterrecords">{$sorterrecords}</span>

                </th>
            </tr>
            </tbody>

            </table>
            <div class="blu">

                <div class="right">
                    <div class="pagination"></div>
                </div>
                <div class="clear"></div>
            </div>

            {securitytoken}
            </form>
            {literal}
            <script>
                $(function(){
                    $('#updater').on('click', '.show-log', function(){
                        var dialog = bootbox.dialog({
                            title: 'Gateway Logs',
                            onEscape: true,
                            size: 'large',
                            message: 'Loading..',
                        });

                        $.get(this.getAttribute('href'), function (data) {
                            $('.modal-body', dialog).html(data).find('pre').css('maxHeight', '300px');
                        })
                        return false;
                    });
                })
            </script>
            {/literal}
        {/if}

    {else}
        {if $showall}
            <p class="blu"> {$lang.nothingtodisplay} </p>
        {else}
            <tr>
                <td colspan="3"><p align="center" > {$lang.nothingtodisplay} </p></td>
            </tr>
        {/if}
    {/if}
{elseif $action=='declinedcardlog'}
    {if $showall}
        <div style="padding: 20px">
    {/if}
    {if $log}
        <p>Found {$log|@count} record(s)</p>
    {else}
        <p>Nothing found</p>
    {/if}
    {foreach from=$log item=record}
       <div class="row">
           <div class="form-group col-md-6">
               <label>Module</label>
               <div class="form-control">{$record.modname}</div>
           </div>
           <div class="form-group col-md-6">
               <label>Date</label>
               <div class="form-control">{$record.date}</div>
           </div>
       </div>
        <pre>{$record.output}</pre>
    {/foreach}
        {if $showall}
        </div>
    {/if}
{elseif $action=='adminactivity'}

    {if $logs}

        {if $showall}
            <form action="" method="post" id="testform" >
                <input type="hidden" value="{$totalpages}" name="totalpages2" id="totalpages"/>
                <div class="blu">




                    <div class="right">
                        <div class="pagination"></div>
                    </div>
                    <div class="clear"></div>
                </div>

                <a href="?cmd=logs&action=adminactivity" id="currentlist" style="display:none" updater="#updater"></a>
                <table cellspacing="0" cellpadding="3" border="0" width="100%" class="table glike hover">
                    <tbody>
                        <tr>
                            <th width="22%"><a href="?cmd=logs&action=adminactivity&orderby=lastname|ASC"  class="sortorder">{$lang.logintime}</a></th>
                            <th width="21%"><a href="?cmd=logs&action=adminactivity&orderby=lastvisit|ASC"  class="sortorder">{$lang.lastaccess}</a></th>
                            <th width="21%"><a href="?cmd=logs&action=adminactivity&orderby=logout|ASC"  class="sortorder">{$lang.logouttime}</a></th>
                            <th width="21%"><a href="?cmd=logs&action=adminactivity&orderby=username|ASC"  class="sortorder">{$lang.Username}</a></th>
                            <th width="15%"><a href="?cmd=logs&action=adminactivity&orderby=ip|ASC"  class="sortorder">{$lang.IPaddress}</a></th>




                        </tr>
                    </tbody>
                    <tbody id="updater">

                    {/if}

                    {foreach from=$logs item=email}
                        <tr>

                            <td>{$email.login|dateformat:$date_format}</td>
                            <td>{$email.lastvisit|dateformat:$date_format}</td>
                            <td>{if $email.logout=='0000-00-00 00:00:00'}-{else}{$email.logout|dateformat:$date_format}{/if}</td>
                            <td><a href="?cmd=editadmins&action=administrator&id={$email.admin_id}">{$email.username|capitalize}</a></td>
                            <td>{$email.ip}</td>

                        </tr>
                    {/foreach}

                    {if $showall}
                    </tbody>
                    <tbody id="psummary">
                        <tr>
                            <th colspan="5">
                                {$lang.showing} <span id="sorterlow">{$sorterlow}</span> - <span id="sorterhigh">{$sorterhigh}</span> {$lang.of} <span id="sorterrecords">{$sorterrecords}</span>

                            </th>
                        </tr>
                    </tbody>
                </table>
                <div class="blu">

                    <div class="right">
                        <div class="pagination"></div>
                    </div>
                    <div class="clear"></div>
                </div>

                {securitytoken}</form>

        {/if}

    {else}
        {if $showall}
            <p class="blu"> {$lang.nothingtodisplay} </p>
        {else}
            <tr>
                <td colspan="5"><p align="center" > {$lang.nothingtodisplay} </p></td>
            </tr>
        {/if}
    {/if}


{elseif $action=='logfiles'}



            <form action="" method="post" id="testform" >
            <div class="blu">
                {if $log_files}
                    <strong>Log file: </strong>
                    <select onchange="window.location.href='?cmd=logs&action=logfiles&logfile=' + this.value; return false">
                        {foreach from=$log_files item=file}
                            <option {if $logfile == $file}selected{/if}>{$file}</option>
                        {/foreach}
                    </select>
                {/if}
                <div class="right">

                    <a class="btn btn-default btn-sm" href="?cmd=logs&action=logfiles&offset={$next_offset}&logfile={$logfile}">Next page</a>
                </div>
                <div class="clear"></div>
            </div>
            <table cellspacing="0" cellpadding="3" border="0" width="100%" class="table glike hover">
            <tbody>
            <tr>
                <th>Date</th>
                <th>Module</th>
                <th>Level</th>
                <th>Message</th>
                <th>Metadata</th>

            </tr>
            </tbody>
            <tbody id="updater">


        {foreach from=$logs item=email key=r}
            <tr>

                <td>{$email.date|dateformat:$date_format}</td>
                <td>{$email.module}</td>
                <td><label class="label label-{if $email.level=='DEBUG'}default{elseif $email.level=='INFO'}primary{elseif $email.level=='WARNING'}warning{else}danger{/if}">{$email.level}</label></td>
                <td>{$email.body}</td>

                <td>{if $email.data!='null'}
                        <a href="#" class="btn btn-xs btn-default"
                           onclick="return showDebug('{$email.body|escape:'javascript'}','#metadata-{$r}')" >View</a>
                    <div id="metadata-{$r}" style="display: none" ><pre>{$email.data|escape}</pre></div>{/if}</td>

            </tr>
            {foreachelse}
            <tr><td colspan="5">{$lang.nothingtodisplay} </td></tr>
        {/foreach}

            </tbody>

            </table>
            <div class="blu">

                <div class="right">
                    <a class="btn btn-default btn-sm" href="?cmd=logs&action=logfiles&offset={$next_offset}&logfile={$logfile}">Next page</a>
                </div>
                <div class="clear"></div>
            </div>
            {securitytoken}
            </form>

{literal}
<script>
    function showDebug(msg,el) {
        bootbox.dialog({
            title: msg,
            onEscape: true,
            size: 'large',
            message: $(el).clone().show(),
        });
        return false;
    }
</script>{/literal}
{elseif $action=='importlog'}

    {if $logs}

        {if $showall}
            <form action="" method="post" id="testform" ><input type="hidden" value="{$totalpages}" name="totalpages2" id="totalpages"/>
                <div class="blu">

                    <div class="right">
                        <div class="pagination"></div>
                    </div>
                    <div class="clear"></div>
                </div>

                <a href="?cmd=logs&action=importlog" id="currentlist" style="display:none" updater="#updater"></a>
                <table cellspacing="0" cellpadding="3" border="0" width="100%" class="table glike hover">
                    <tbody>
                        <tr>
                            <th><a href="?cmd=logs&action=importlog&orderby=date|ASC"  class="sortorder">{$lang.Date}</a></th>
                            <th><a href="?cmd=logs&action=importlog&orderby=to|ASC"  class="sortorder">{$lang.To}</a></th>
                            <th><a href="?cmd=logs&action=importlog&orderby=subject|ASC"  class="sortorder">{$lang.Subject}</a></th>
                            <th><a href="?cmd=logs&action=importlog&orderby=status|ASC"  class="sortorder">{$lang.Status}</a></th>
                        </tr>
                    </tbody>
                    <tbody id="updater">

                    {/if}

                    {foreach from=$logs item=email}
                        <tr>

                            <td>{$email.date|dateformat:$date_format}</td>
                            <td>{$email.to}</td>
                            <td><a href="?cmd=logs&action=getimportlog&id={$email.id}">{$email.subject}</a></td>
                            <td>
                                {if $email.status == 0}<a class="vtip_description" title="Email was matched by one of your import filters"></a>&nbsp;Filtered&nbsp;Out
                                {elseif $email.status == 1}<a class="vtip_description" title="Department does not allow unregistered clients"></a>&nbsp;Unregistered
                                {elseif $email.status == 2}Sucessful
                                {elseif $email.status == 3}<a class="vtip_description" title="None of receiver emails matches any of your support department"></a>&nbsp;Not&nbsp;Found
                                {elseif $email.status == 4}<a class="vtip_description" title="Sender email is the same as receiver"></a>&nbsp;Skipping
                                {elseif $email.status == 5}<a class="vtip_description" title="Error ocurred, could not create this ticket"></a>&nbsp;Error
                                {elseif $email.status == 6}<a class="vtip_description" title="This message refers to a different department than related ticket"></a>&nbsp;Mismatch
                                {elseif $email.status == 7}<a class="vtip_description" title="Sender email exists on Hostbill system email list"></a>&nbsp;System
                                {elseif $email.status == 8}<a class="vtip_description" title="Email was identified as auto-submitted"></a>&nbsp;Auto-Submitted
                                {elseif $email.status == 9}<a class="vtip_description" title="Time limit has been reached for ticket import task"></a>&nbsp;Time-Limit
                                {elseif $email.status == 10}<a class="vtip_description" title="Ticket has been already closed and reply cannot be accepted"></a>&nbsp;Ticket Closed
                                {elseif $email.status == 11}<a class="vtip_description" title="This ticket is the same as ticket imported few minutes ago"></a>&nbsp;Duplicate
                                {elseif $email.status == 12}<a class="vtip_description" title="This ticket is Public and does not accept responses from clients"></a>&nbsp;Admin Only
                                {elseif $email.status == 13}<a class="vtip_description" title="Department does not allow admin responses by email"></a>&nbsp;Disallowed
                                {elseif $email.status == 14}<a class="vtip_description" title="Admin is not assigned to related department"></a>&nbsp;Not Assigned
                                {elseif $email.status == 15}<a class="vtip_description" title="System wasn't able to parse email headers"></a>&nbsp;Error
                                {else}<a class="vtip_description" title="Unexpeted error ocurred, could not create this ticket"></a>&nbsp;Unknown
                                {/if}
                            </td>

                        </tr>
                    {/foreach}

                    {if $showall}
                    </tbody>
                    <tbody id="psummary">
                        <tr>
                            <th colspan="4">
                                {$lang.showing} <span id="sorterlow">{$sorterlow}</span> - <span id="sorterhigh">{$sorterhigh}</span> {$lang.of} <span id="sorterrecords">{$sorterrecords}</span>

                            </th>
                        </tr>
                    </tbody>
                </table>
                <div class="blu">

                    <div class="right">
                        <div class="pagination"></div>
                    </div>
                    <div class="clear"></div>
                </div>
                {securitytoken}</form>

        {/if}

    {else}
        {if $showall}
            <p class="blu"> {$lang.nothingtodisplay} </p>
        {else}
            <tr>
                <td colspan="4"><p align="center" > {$lang.nothingtodisplay} </p></td>
            </tr>
        {/if}
    {/if}

{elseif $action=='default'}

    {if $logs}

        {if $showall}
            <form action="" method="post" id="testform" ><input type="hidden" value="{$totalpages}" name="totalpages2" id="totalpages"/>
                <div class="blu">

                    <div class="right">
                        <div class="pagination"></div>
                    </div>
                    <div class="clear"></div>
                </div>

                <a href="?cmd=logs" id="currentlist" style="display:none" updater="#updater"></a>
                <table cellspacing="0" cellpadding="3" border="0" width="100%" class="table glike hover">
                    <tbody>
                        <tr>
                            <th width="15%"><a href="?cmd=logs&orderby=date|ASC"  class="sortorder">{$lang.Date}</a></th>
                            <th ><a href="?cmd=logs&orderby=what|ASC"  class="sortorder">{$lang.Description}</a></th>
                            <th width="10%"><a href="?cmd=logs&orderby=who|ASC"  class="sortorder">{$lang.Username}</a></th>
                            <th width="15%"><a href="?cmd=logs&orderby=ip|ASC"  class="sortorder">{$lang.IPaddress}</a></th>


                        </tr>
                    </tbody>
                    <tbody id="updater">

                    {/if}

                    {foreach from=$logs item=email}
                        <tr>

                            <td>{$email.date|dateformat:$date_format}</td>
                            <td>{$email.what}
                                {if $email.type && $email.item_id}
                                    {if $email.type=='client'}<a href="?cmd=clients&action=show&id={$email.item_id}">(ID: {$email.item_id})</a>
                                    {elseif $email.type=='account'}<a href="?cmd=accounts&action=edit&id={$email.item_id}">(ID: {$email.item_id})</a>
                                    {elseif $email.type=='order'}<a href="?cmd=orders&action=edit&id={$email.item_id}">(ID: {$email.item_id})</a>
                                    {elseif $email.type=='domain'}<a href="?cmd=domains&action=edit&id={$email.item_id}">(ID: {$email.item_id})</a>
                                    {elseif $email.type=='invoice'}<a href="?cmd=invoices&action=edit&id={$email.item_id}">(ID: {$email.item_id})</a>
                                    {elseif $email.type=='transaction'}<a href="?cmd=transactions&action=edit&id={$email.item_id}">(ID: {$email.item_id})</a>
                                    {elseif $email.type=='cron_prof'}<a href="?cmd=configuration&action=profile&id={$email.item_id}">(ID: {$email.item_id})</a>
                                    {elseif $email.type=='admin'}<a href="?cmd=editadmins&action=administrator&id={$email.item_id}">(ID: {$email.item_id})</a>
                                    {elseif $email.type=='admin_group'}<a href="?cmd=configuration&action=group&id={$email.item_id}">(ID: {$email.item_id})</a>
                                    {elseif $email.type=='product'}<a href="?cmd=services&action=product&id={$email.item_id}">(ID: {$email.item_id})</a>
                                    {elseif $email.type=='product_cat'}<a href="?cmd=services&action=category&cat_id={$email.item_id}">(ID: {$email.item_id})</a>
                                    {elseif $email.type=='product_add'}<a href="?cmd=productaddons&action=addon&id={$email.item_id}">(ID: {$email.item_id})</a>
                                    {elseif $email.type=='server'}<a href="?cmd=servers&action=edit&id={$email.item_id}">(ID: {$email.item_id})</a>
                                    {elseif $email.type=='email_tpl'}<a href="?cmd=emailtemplates&action=edit&id={$email.item_id}">(ID: {$email.item_id})</a>
                                    {elseif $email.type=='form_group'}<a href="?cmd=formgroups&action=form_group&id={$email.item_id}">(ID: {$email.item_id})</a>
                                    {elseif $email.type=='form_item_group'}<a href="?cmd=formgroups&action=form_item_group&id={$email.item_id}">(ID: {$email.item_id})</a>
                                    {/if}
                                {/if}
                            </td>
                            <td>{$email.who|capitalize}</a></td>
                            <td>{$email.ip}</td>


                        </tr>
                    {/foreach}

                    {if $showall}
                    </tbody>
                    <tbody id="psummary">
                        <tr>
                            <th colspan="4">
                                {$lang.showing} <span id="sorterlow">{$sorterlow}</span> - <span id="sorterhigh">{$sorterhigh}</span> {$lang.of} <span id="sorterrecords">{$sorterrecords}</span>

                            </th>
                        </tr>
                    </tbody>
                </table>
                <div class="blu">

                    <div class="right">
                        <div class="pagination"></div>
                    </div>
                    <div class="clear"></div>
                </div>

                {securitytoken}</form>

        {/if}

    {else}
        {if $showall}
            <p class="blu"> {$lang.nothingtodisplay} </p>
        {else}
            <tr>
                <td colspan="3"><p align="center" > {$lang.nothingtodisplay} </p></td>
            </tr>
        {/if}
    {/if}


{elseif $action=='getimportlog'}

    <div class="blu">
        <a href="?cmd=logs&action=importlog"><strong>&laquo; Back to all imported emails</strong></a></div>
    <div class="lighterblue" style="padding:5px">
        <strong>{$lang.From}</strong> {$email.from}<br />
        <strong>{$lang.To}</strong> {$email.to}<br />
        <strong>{$lang.Subject}</strong> {$email.subject}<br />
        <strong>{$lang.Status}</strong> {$email.status}<br />
        <strong>{$lang.Received}</strong> {$email.date|dateformat:$date_format}<br /><br />
        {if $email.headers}
            <a href="#" class="editbtn" onclick="$(this).hide().next().show();
                    return false;">Show email headers</a>

            <table class="whitetable" width="99%" cellspacing="0" cellpading="0" style="table-layout:fixed; word-wrap: break-word; display:none">
                {if $email.headers|@is_array}
                    {foreach from=$email.headers item=header key=name name=headers}
                        <tr {if $smarty.foreach.headers.index%2==0}class="even"{/if}>
                            <td style="width:10%; vertical-align: top; text-align: right">{$name}:</td>
                            <td>{$header|escape}</td>
                        </tr>
                    {/foreach}
                {else}
                    <pre style="display:none; background: #eee; padding: 5px; margin: 0"><code>{$email.headers|htmlspecialchars}</code></pre>
                {/if}
            </table>
        {/if}
        <pre style="font-family: monospace,Lucida Console; padding: 0px 0px 0px 15px; white-space: pre-wrap;">
            {$email.message}
        </pre>
    </div>




{elseif $action=='coupons'}

    {if $logs}

        {if $showall}
            <form action="" method="post" id="testform" ><input type="hidden" value="{$totalpages}" name="totalpages2" id="totalpages"/>
                <div class="blu">

                    <div class="right">
                        <div class="pagination"></div>
                    </div>
                    <div class="clear"></div>
                </div>

                <a href="?cmd=logs&action=coupons" id="currentlist" style="display:none" updater="#updater"></a>
                <table cellspacing="0" cellpadding="3" border="0" width="100%" class="table glike hover">
                    <tbody>
                        <tr>
                            <th><a href="?cmd=logs&action=coupons&orderby=date|ASC"  class="sortorder">{$lang.Date}</a></th>
                            <th><a href="?cmd=logs&action=coupons&orderby=lastname|ASC"  class="sortorder">{$lang.Client}</a></th>
                            <th><a href="?cmd=logs&action=coupons&orderby=order_id|ASC"  class="sortorder">{$lang.Order}</a></th>
                            <th><a href="?cmd=logs&action=coupons&orderby=invoice_id|ASC"  class="sortorder">{$lang.Invoice}</a></th>
                            <th><a href="?cmd=logs&action=coupons&orderby=coupon_id|ASC"  class="sortorder">{$lang.couponhash}</a></th>
                            <th><a href="?cmd=logs&action=coupons&orderby=discount|ASC"  class="sortorder">{$lang.Discount}</a></th>


                        </tr>
                    </tbody>
                    <tbody id="updater">
                    {/if}
                    {foreach from=$logs item=email}
                        <tr>
                            <td>{$email.date|dateformat:$date_format}</td>
                            <td><a href="?cmd=clients&action=show&id={$email.client_id}">#{$email.client_id} {$email.firstname} {$email.lastname}</a></td>
                            <td>{if $email.order_id}<a href="?cmd=orders&action=edit&id={$email.order_id}&list=all">#{$email.order_id}</a>{else}-{/if}</td>
                            <td>{if $email.invoice_id}<a href="?cmd=invoices&action=edit&id={$email.invoice_id}&list=all">#{$email.invoice_id}</a>{else}-{/if}</td>
                            <td><a href="?cmd=coupons&action=edit&id={$email.coupon_id}">#{$email.coupon_id} - {$email.code}</a></td>
                            <td>{$email.discount|price:$email.currency_id}</td>
                        </tr>
                    {/foreach}

                    {if $showall}
                    </tbody>
                    <tbody id="psummary">
                        <tr>
                            <th colspan="6">
                                {$lang.showing} <span id="sorterlow">{$sorterlow}</span> - <span id="sorterhigh">{$sorterhigh}</span> {$lang.of} <span id="sorterrecords">{$sorterrecords}</span>
                            </th>
                        </tr>
                    </tbody>
                </table>
                <div class="blu">

                    <div class="right">
                        <div class="pagination"></div>
                    </div>
                    <div class="clear"></div>
                </div>
                {securitytoken}</form>

        {/if}

    {else}
        {if $showall}
            <p class="blu"> {$lang.nothingtodisplay} </p>
        {else}
            <tr>
                <td colspan="4"><p align="center" > {$lang.nothingtodisplay} </p></td>
            </tr>
        {/if}
    {/if}

{elseif $action=='configlog'}

    {if $logs}

        {if $showall}
            <form action="" method="post" id="testform" ><input type="hidden" value="{$totalpages}" name="totalpages2" id="totalpages"/>
            <div class="blu">

                <div class="right">
                    <div class="pagination"></div>
                </div>
                <div class="clear"></div>
            </div>

            <a href="?cmd=logs&action=configlog" id="currentlist" style="display:none" updater="#updater"></a>
            <table cellspacing="0" cellpadding="3" border="0" width="100%" class="table glike hover">
            <tbody>
            <tr>
                <th width="200"><a href="?cmd=logs&action=configlog&orderby=id|ASC"  class="sortorder">Date</a></th>
                <th width="150"><a href="?cmd=logs&action=configlog&orderby=admin_login|ASC"  class="sortorder">Admin</a></th>
                <th width="250"><a href="?cmd=logs&action=configlog&orderby=setting|ASC"  class="sortorder">Setting</a></th>
                <th ><a href="?cmd=logs&action=configlog&orderby=from|ASC"  class="sortorder">Before change</a></th>
                <th ><a href="?cmd=logs&action=configlog&orderby=result|ASC"  class="sortorder">After change</a></th>
            </tr>
            </tbody>
            <tbody id="updater">

        {/if}

        {foreach from=$logs item=request}
            <tr>
                <td>{$request.created_at|dateformat:$date_format}</td>
                <td>{$request.admin_login}</td>
                <td>{$request.setting}</td>
                <td>{$request.from|truncate:250}</td>
                <td>{$request.to|truncate:250}</td>
            </tr>
        {/foreach}

        {if $showall}
            </tbody>
            <tbody id="psummary">
            <tr>
                <th colspan="5">
                    {$lang.showing} <span id="sorterlow">{$sorterlow}</span> - <span id="sorterhigh">{$sorterhigh}</span> {$lang.of} <span id="sorterrecords">{$sorterrecords}</span>

                </th>
            </tr>
            </tbody>
            </table>
            <div class="blu">

                <div class="right">
                    <div class="pagination"></div>
                </div>
                <div class="clear"></div>
            </div>
            {securitytoken}</form>

        {/if}

    {else}
        {if $showall}
            <p class="blu"> {$lang.nothingtodisplay} </p>
        {else}
            <tr>
                <td colspan="4"><p align="center" > {$lang.nothingtodisplay} </p></td>
            </tr>
        {/if}
    {/if}
{elseif $action=='ccardlog'}

    {if $logs}
        {if $showall}
            <form action="" method="post" id="testform" ><input type="hidden" value="{$totalpages}" name="totalpages2" id="totalpages"/>
            <div class="blu">
                <div class="right">
                    <div class="pagination"></div>
                </div>
                <div class="clear"></div>
            </div>

            <a href="?cmd=logs&action=ccardlog" id="currentlist" style="display:none" updater="#updater"></a>
            <table cellspacing="0" cellpadding="3" border="0" width="100%" class="table glike hover">
            <tbody>
            <tr>
                <th width="150"><a href="?cmd=logs&action=ccardlog&orderby=date|ASC"  class="sortorder">Date</a></th>
                <th width="150"><a href="?cmd=logs&action=ccardlog&orderby=admin_id|ASC"  class="sortorder">Admin</a></th>
                <th width="200"><a href="?cmd=logs&action=ccardlog&orderby=client_id|ASC"  class="sortorder">Client</a></th>
                <th width="150"><a href="?cmd=logs&action=ccardlog&orderby=ip|ASC"  class="sortorder">IP address</a></th>
                <th width="150"><a href="?cmd=logs&action=ccardlog&orderby=last4|ASC"  class="sortorder">Last 4 digits</a></th>
                <th width="50"><a href="?cmd=logs&action=ccardlog&orderby=tokenized|ASC"  class="sortorder">Tokenized</a></th>
                <th><a href="?cmd=logs&action=ccardlog&orderby=change|ASC"  class="sortorder">Change</a></th>
            </tr>
            </tbody>
            <tbody id="updater">
        {/if}

        {foreach from=$logs item=clog}
            <tr>
                <td>{$clog.date|dateformat:$date_format}</td>
                <td>{if $clog.admin_login}<a href="?cmd=editadmins&action=administrator&id={$clog.admin_id}">{$clog.admin_login}</a>{else}-{/if}</td>
                <td>{if $clog.client_id}
                        <a href="?cmd=clients&action=show&id={$clog.client_id}">#{$clog.client_id} {$clog.client_firstname} {$clog.client_lastname}</a>
                    {else}-{/if}
                </td>
                <td>{$clog.ip}</td>
                <td>{$clog.last4}</td>
                <td>{if $clog.tokenized}Yes {if $clog.gateway_id}(#{$clog.gateway_id} {$clog.payment_gateway}){/if}{else}No{/if}</td>
                <td>{$clog.change}</td>
            </tr>
        {/foreach}

        {if $showall}
            </tbody>
            <tbody id="psummary">
            <tr>
                <th colspan="8">
                    {$lang.showing} <span id="sorterlow">{$sorterlow}</span> - <span id="sorterhigh">{$sorterhigh}</span> {$lang.of} <span id="sorterrecords">{$sorterrecords}</span>
                </th>
            </tr>
            </tbody>
            </table>
            <div class="blu">
                <div class="right">
                    <div class="pagination"></div>
                </div>
                <div class="clear"></div>
            </div>
            {securitytoken}
            </form>
        {/if}
    {else}
        {if $showall}
            <p class="blu"> {$lang.nothingtodisplay} </p>
        {else}
            <tr>
                <td colspan="8"><p align="center" > {$lang.nothingtodisplay} </p></td>
            </tr>
        {/if}
    {/if}

{elseif $action=='apilog'}

    {if $logs}

        {if $showall}
            <form action="" method="post" id="testform" ><input type="hidden" value="{$totalpages}" name="totalpages2" id="totalpages"/>
                <div class="blu">

                    <div class="right">
                        <div class="pagination"></div>
                    </div>
                    <div class="clear"></div>
                </div>

                <a href="?cmd=logs&action=apilog" id="currentlist" style="display:none" updater="#updater"></a>
                <table cellspacing="0" cellpadding="3" border="0" width="100%" class="table glike hover">
                    <tbody>
                        <tr>
                            <th width="200"><a href="?cmd=logs&action=apilog&orderby=date|ASC"  class="sortorder">Date</a></th>
                            <th width="150"><a href="?cmd=logs&action=apilog&orderby=ip|ASC"  class="sortorder">IP address</a></th>
                            <th width="150"><a href="?cmd=logs&action=apilog&orderby=api_id|ASC"  class="sortorder">API ID</a></th>
                            <th width="150"><a href="?cmd=logs&action=apilog&orderby=action|ASC"  class="sortorder">Called function</a></th>
                            <th ><a href="?cmd=logs&action=apilog&orderby=result|ASC"  class="sortorder">Result</a></th>
                        </tr>
                    </tbody>
                    <tbody id="updater">

                    {/if}

                    {foreach from=$logs item=request}
                        <tr>
                            <td>{$request.date|dateformat:$date_format}</td>
                            <td>{$request.ip}</td>
                            <td>{$request.api_id}</td>
                            <td>{$request.action}</td>
                            <td>{$request.result}</td>
                        </tr>
                    {/foreach}

                    {if $showall}
                    </tbody>
                    <tbody id="psummary">
                        <tr>
                            <th colspan="5">
                                {$lang.showing} <span id="sorterlow">{$sorterlow}</span> - <span id="sorterhigh">{$sorterhigh}</span> {$lang.of} <span id="sorterrecords">{$sorterrecords}</span>

                            </th>
                        </tr>
                    </tbody>
                </table>
                <div class="blu">

                    <div class="right">
                        <div class="pagination"></div>
                    </div>
                    <div class="clear"></div>
                </div>
                {securitytoken}</form>

        {/if}

    {else}
        {if $showall}
            <p class="blu"> {$lang.nothingtodisplay} </p>
        {else}
            <tr>
                <td colspan="4"><p align="center" > {$lang.nothingtodisplay} </p></td>
            </tr>
        {/if}
    {/if}

{elseif $action=='fraudlog'}

    {if $logs}

        {if $showall}
            <form action="" method="post" id="testform" ><input type="hidden" value="{$totalpages}" name="totalpages2" id="totalpages"/>
            <div class="blu">

                <div class="right">
                    <div class="pagination"></div>
                </div>
                <div class="clear"></div>
            </div>

            <a href="?cmd=logs&action=fraudlog" id="currentlist" style="display:none" updater="#updater"></a>
            <table cellspacing="0" cellpadding="3" border="0" width="100%" class="table glike hover">
            <tbody>
            <tr>
                <th width="200"><a href="?cmd=logs&action=fraudlog&orderby=date|ASC"  class="sortorder">Date</a></th>
                <th width="150"><a href="?cmd=logs&action=fraudlog&orderby=type|ASC"  class="sortorder">Type / ID</a></th>
                <th width="150"><a href="?cmd=logs&action=fraudlog&orderby=client_id|ASC"  class="sortorder">Client</a></th>
                <th width="150"><a href="?cmd=logs&action=fraudlog&orderby=module|ASC"  class="sortorder">Module</a></th>
                <th ><a href="?cmd=logs&action=fraudlog&orderby=output|ASC"  class="sortorder">Output</a></th>
            </tr>
            </tbody>
            <tbody id="updater">
        {/if}

        {foreach from=$logs item=request}
            <tr>
                <td>{$request.date|dateformat:$date_format}</td>
                <td>{$request.type}:
                    {if $request.type=='Order'}
                        <a href="?cmd=orders&action=edit&id={$request.rel_id}"># {$request.rel_id}</a>
                    {else}
                        <a href="?cmd=clients&action=show&id={$request.rel_id}"># {$request.rel_id}</a>
                    {/if}
                </td>
                <td><a href="?cmd=clients&action=show&id={$request.client_id}">{$request.firstname} {$request.lastname}</a></td>

                <td>{$request.modulename}</td>
                <td>
                    <div style="max-height:100px; overflow:auto">
                        <div style=" white-space: pre; font-size:8pt;">{foreach from=$request.output item=m key=k}{$k}: {$m}
                            {/foreach}
                        </div>
                    </div>
                </td>
            </tr>
        {/foreach}

        {if $showall}
            </tbody>
            <tbody id="psummary">
            <tr>
                <th colspan="5">
                    {$lang.showing} <span id="sorterlow">{$sorterlow}</span> - <span id="sorterhigh">{$sorterhigh}</span> {$lang.of} <span id="sorterrecords">{$sorterrecords}</span>

                </th>
            </tr>
            </tbody>
            </table>
            <div class="blu">

                <div class="right">
                    <div class="pagination"></div>
                </div>
                <div class="clear"></div>
            </div>
            {securitytoken}</form>

        {/if}

    {else}
        {if $showall}
            <p class="blu"> {$lang.nothingtodisplay} </p>
        {else}
            <tr>
                <td colspan="4"><p align="center" > {$lang.nothingtodisplay} </p></td>
            </tr>
        {/if}
    {/if}

{elseif $action=='errorlog'}

    {if $logs}

        {if $showall}
            <form action="" method="post" id="testform" ><input type="hidden" value="{$totalpages}" name="totalpages2" id="totalpages"/>
                <div class="blu">

                    <div class="right">
                        <div class="pagination"></div>
                    </div>
                    <div class="clear"></div>
                </div>

                <a href="?cmd=logs&action=errorlog" id="currentlist" style="display:none" updater="#updater"></a>
                <table cellspacing="0" cellpadding="3" border="0" width="100%" class="table glike hover">
                    <tbody>
                        <tr>
                            <th width="200"><a href="?cmd=logs&action=errorlog&orderby=date|ASC"  class="sortorder">Date</a></th>
                            <th width="150"><a href="?cmd=logs&action=errorlog&orderby=type|ASC"  class="sortorder">Type</a></th>
                            <th ><a href="?cmd=logs&action=errorlog&orderby=entry|ASC"  class="sortorder">Error</a></th>
                        </tr>
                    </tbody>
                    <tbody id="updater">
                    {/if}

                    {foreach from=$logs item=request}
                        <tr>
                            <td>{$request.date|dateformat:$date_format}</td>
                            <td>{$request.type}</td>
                            <td><div class="errorless fs11">{$request.entry|escape|nl2br}</div></td>
                        </tr>
                    {/foreach}

                    {if $showall}
                    </tbody>
                    <tbody id="psummary">
                        <tr>
                            <th colspan="5">
                                {$lang.showing} <span id="sorterlow">{$sorterlow}</span> - <span id="sorterhigh">{$sorterhigh}</span> {$lang.of} <span id="sorterrecords">{$sorterrecords}</span>

                            </th>
                        </tr>
                    </tbody>
                </table>
                <div class="blu">

                    <div class="right">
                        <div class="pagination"></div>
                    </div>
                    <div class="clear"></div>
                </div>
                {securitytoken}</form>

        {/if}

    {else}
        {if $showall}
            <p class="blu"> {$lang.nothingtodisplay} </p>
        {else}
            <tr>
                <td colspan="4"><p align="center" > {$lang.nothingtodisplay} </p></td>
            </tr>
        {/if}
    {/if}

{elseif $action=='cancelations'}


    {if $logs}

        {if $showall}
            <form action="" method="post" id="testform" ><input type="hidden" value="{$totalpages}" name="totalpages2" id="totalpages"/>
                <div class="blu">
                    <div class="right">
                        <div class="pagination"></div>
                    </div>
                    <div class="left menubar">
                        {$lang.withselected}
                        <a class="submiter menuitm menu-auto" name="cancellacc" queue="push" href="#">
                            <span>{$lang.CancelAccount}</span>
                        </a>
                        <a class="submiter menuitm menu-auto" name="delreq" queue="push" href="#">
                            <span>{$lang.DeleteRequest}</span>
                        </a>
                    </div>
                    <div class="clear"></div>
                </div>

                <a href="?cmd=logs&action=cancelations" id="currentlist" style="display:none" updater="#updater"></a>
                <table cellspacing="0" cellpadding="3" border="0" width="100%" class="table glike hover">
                    <tbody>
                        <tr>
                            <th style="width:20px"><input type="checkbox" id="checkall"/></th>
                            <th style="width:140px"><a href="?cmd=logs&action=cancelations&orderby=date|ASC"  class="sortorder">{$lang.Date}</a></th>
                            <th><a href="?cmd=logs&action=cancelations&orderby=client_id|ASC"  class="sortorder">{$lang.Client}</a></th>
                            <th><a href="?cmd=logs&action=cancelations&orderby=item_id|ASC"  class="sortorder">{$lang.Service}</a></th>
                            <th style="width: 40%;"><a href="?cmd=logs&action=cancelations&orderby=reason|ASC"  class="sortorder">{$lang.Reason}</a></th>
                            <th><a href="?cmd=logs&action=cancelations&orderby=who|ASC"  class="sortorder">{$lang.who}</a></th>
                            <th><a href="?cmd=logs&action=cancelations&orderby=type|ASC"  class="sortorder">{$lang.Type}</a></th>
                            <th><a href="?cmd=logs&action=cancelations&orderby=next_due|ASC"  class="sortorder">Billing period ends</a></th>
                            <th><a href="?cmd=logs&action=cancelations&orderby=status|ASC"  class="sortorder">{$lang.Status}</a></th>
                        </tr>
                    </tbody>
                    <tbody id="updater">

                    {/if}

                    {foreach from=$logs item=request}
                        <tr>
                            <td><input type="checkbox" name="selected[]" {if $request.status == 'Cancelled' || $request.status == 'Terminated' || $request.status == 'Fraud'}disabled="disabled"{else} class="check"{/if} value="{$request.id}" /></td>
                            <td>{$request.date|dateformat:$date_format}</td>
                            <td>{if $request.client_id}<a href="?cmd=clients&action=show&id={$request.client_id}">{$request.firstname} {$request.lastname}</a>{else}-{/if}</td>
                            <td>
                                <a href="?cmd={if $request.item_type=='Account'}accounts{else}domains{/if}&action=edit&id={$request.item_id}">{if $request.name}#{$request.item_id} {$request.category} - {$request.name}{elseif $request.item_type=='Account'}Account #{$request.item_id}{else}Domain: #{$request.item_id} {$request.domain}{/if}</a>
                            </td>
                            <td><div class="fs11" style="max-height: 40px; overflow: auto;">{$request.reason}</div></td>
                            <td>{$request.who}</td>
                            <td>{$request.type}</td>
                            <td>{if $request.next_due}{$request.next_due|dateformat:$date_format}{else}-{/if}</td>
                            <td>{if $request.status == 'Cancelled' || $request.status == 'Terminated' || $request.status == 'Fraud'}<span class="Active">{$lang.Cancelled}</span>{else}<span class="Pending">{$lang.Pending}</span>{/if}</td>
                        </tr>
                    {/foreach}

                    {if $showall}
                    </tbody>
                    <tbody id="psummary">
                        <tr>
                            <th colspan="10">
                                {$lang.showing} <span id="sorterlow">{$sorterlow}</span> - <span id="sorterhigh">{$sorterhigh}</span> {$lang.of} <span id="sorterrecords">{$sorterrecords}</span>

                            </th>
                        </tr>
                    </tbody>
                </table>
                <div class="blu">

                    <div class="right">
                        <div class="pagination"></div>
                    </div>
                    <div class="clear"></div>
                </div>
                {securitytoken}</form>

        {/if}

    {else}
        {if $showall}
            <p class="blu"> {$lang.nothingtodisplay} </p>
        {else}
            <tr>
                <td colspan="15"><p align="center" > {$lang.nothingtodisplay} </p></td>
            </tr>
        {/if}
    {/if}


{/if}