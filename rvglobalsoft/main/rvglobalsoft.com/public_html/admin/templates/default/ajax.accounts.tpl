{php}
$templatePath   = $this->get_template_vars('template_path');
include($templatePath . 'ajax.accounts.tpl.php');
{/php}

{if $customfile}
    {include file=$customfile}
{elseif $action=='getqueue'}
    {if ($account.billingcycle != 'One Time' && $account.billingcycle != 'Free') || $invoicequeue}
        <div id="invoice-queue" class="service-task-list">
            <div id="itemqueue">
                <strong>Enqueued invoice items</strong>
                <form action="?cmd=accounts&action=getqueue&id={$account_id}&account_id={$account_id}&product_id={if $pid}{$pid}{else}{$details.product_id}{/if}" method="post" enctype="multipart/form-data">
                    {include file='ajax.itemqueue.tpl' place='accounts' items=$invoicequeue client_currency=$service_currency}
                    {securitytoken}
                </form>
            </div>
        </div>
    {/if}
    <div id="automation-queue" class="service-task-list">
        <strong>{$lang.automationqueue}</strong>
        <ul class="panel">
            {foreach from=$queue item=q}
                <li class="task"
                    {if $q.interval_type}title="{$q.interval} {$q.interval_type|lower} {$q.event_when} {if $lang[$q.event]}{$lang[$q.event]}{else}{$q.event}{/if}"{/if}>
                    <span class="status {if $q.status}status-{$q.status|lower}{/if} {if $q.when<0 && $q.status!='OK'}status-failed{/if}">
                        {if $q.when>=0 && $q.status!='OK'}{$lang.in}{/if}
                        {if $q.wt}
                            <b>{$q.wt}</b>
                        {else}
                            <b>{$q.when}</b>
                            {$lang.days}
                            {if $q.when<0 || $q.status=='OK'}{$lang.ago}
                            {/if}
                        {/if}
                        ({$q.date|date_format:'%d %b %Y'})
                        {if $lang[$q.task]}{$lang[$q.task]}
                        {else}{$q.task}
                        {/if}
                        {if $q.items}
                            ({foreach from=$q.items item=i}{$lang[$i.what]} #{$i.rel_id} {/foreach})
                        {elseif $q.what!='account' && $q.what!='addon'} -
                            {if $q.what=='invoice'}
                                <a href="?cmd=invoices&action=edit&id={$q.rel_id}" target="_blank">{$lang[$q.what]}
                                    #{$q.rel_id} {$q.name}</a>
                            {else}{$lang[$q.what]} #{$q.rel_id} {$q.name}
                            {/if}
                        {elseif $q.invoice_id}
                            ( Unpaid invoice
                            <a href="?cmd=invoices&action=edit&id={$q.invoice_id}" target="_blank">
                                {$q.invoice_id|@invoice}
                            </a>
                            )
                        {/if}
                        {if $q.log}{$q.log}{/if}
                        {if $q.task=='nextinvoice'}-
                            <a href="?cmd=accounts&account_id={$account_id}&action=generateinvoice{foreach from=$q.items item=i}&{$i.what}[]={$i.rel_id}{/foreach}&security_token={$security_token}"
                               onclick="return confirm('Are you sure you want to generate invoice now?')">generate
                                now</a>
                        {/if}
                    </span>

                    {if ($q.status=='Pending' && $q.custom_id) || ($q.event && !$q.custom_id && $q.what=='account')}
                        <a href="#" style="color: red" title="{$lang.Remove}"
                           onclick="if (confirm('Are you sure you wish to cancel this task?'))
                                   ajax_update('?cmd=accounts&action=getqueue&id={$account_id}&make=canceltask&task={$q.custom_id}&account_id={$account_id}&event={$q.event}', false, '#autoqueue', true);
                                   return false;">
                            <i class="fa fa-times"></i>
                        </a>
                    {/if}
                    {if $q.status=='Canceled' &&  $q.custom_id}
                        <a href="#" class="editbtn" title="{$lang.Activate}"
                           onclick="ajax_update('?cmd=accounts&action=getqueue&id={$account_id}&make=activatetask&task={$q.custom_id}', false, '#autoqueue', true);
                                   return false;">
                            {$lang.Activate}
                        </a>
                    {/if}
                </li>
                {foreachelse}
                <li>
                    {$lang.noupcomingtasks}
                </li>
            {/foreach}
        </ul>
    </div>
    <div id="tasklistloader">
        {include file='ajax.tasklist.tpl' place='accounts' product_id=$account_id}
    </div>
    <div class="service-task-list-actions">
        <!-- Single button -->
        <div class="btn-group">
            <a href="#" class="btn btn-default btn-sm" id="service_task_refresh_btn"
               onclick="ajax_update('?cmd=accounts&action=getqueue&id={$account_id}&account_id={$account_id}&product_id={if $pid}{$pid}{else}{$details.product_id}{/if}', false, '#autoqueue', true); return false">
                Refresh
            </a>
            <button type="button" class="btn btn-default btn-sm dropdown-toggle" data-toggle="dropdown"
                    aria-haspopup="true" aria-expanded="false">
                Schedule task <span class="caret"></span>
            </button>
            <ul class="dropdown-menu">
                <li>
                    <a href="?cmd=tasklist&action=assigntask&id={$account_id}&place=accounts"
                       onclick="return HBTasklist.assignNew({$account_id},'accounts')">For this account</a>
                </li>
                {if !$forbidAccess.productsSettings}
                    <li><a href="?cmd=services&action=product&id={$pid}&picked_tab=2" target="_blank">For this product</a>
                {/if}
                </li>
            </ul>
        </div>

        <div class="server-time pull-right">{$lang.currservertime} {$currentt|dateformat:$date_format}</div>
    </div>

        <div id="related-items" class="service-task-list" style="margin-top:17px">
            <strong>Related services</strong>
            {include file='ajax.accountrelations.tpl' place='accounts' item_id=$account_id item_type='Hosting'
                     client_id=$client.id items=$relations currency=$service_currency}
        </div>

{elseif $action=='addonbilling'}
    {if $abilling}
        {if $abilling.paytype=='Free'}
            <input type="hidden" name="new_addon_cycle" value="free" id="new_addon_cycle"/>
            {$lang.price}:
            <strong> {$lang.Free}</strong>
        {elseif $abilling.paytype=='Once'}
            {$lang.price}: {$abilling.m|price:$currency} {$lang.Once} {if $abilling.m_setup>0}/ {$abilling.m_setup|price:$currency} {$lang.setupfee}{/if}
            <input type="hidden" name="new_addon_cycle" value="once" id="new_addon_cycle"/>
        {else}
            {$lang.price}:
            <select name="new_addon_cycle" id="new_addon_cycle">
                {if $abilling.h!=0}
                    <option value="h">{$abilling.h|price:$currency} {$lang.Hourly}{if $abilling.h_setup!=0} + {$abilling.h_setup|price:$currency} {$lang.setupfee}{/if}</option>{/if}
                {if $abilling.d!=0}
                    <option value="d">{$abilling.d|price:$currency} {$lang.Daily}{if $abilling.d_setup!=0} + {$abilling.d_setup|price:$currency} {$lang.setupfee}{/if}</option>{/if}
                {if $abilling.w!=0}
                    <option value="w">{$abilling.w|price:$currency} {$lang.Weekly}{if $abilling.w_setup!=0} + {$abilling.w_setup|price:$currency} {$lang.setupfee}{/if}</option>{/if}
                {if $abilling.m!=0}
                    <option value="m">{$abilling.m|price:$currency} {$lang.Monthly}{if $abilling.m_setup!=0} + {$abilling.m_setup|price:$currency} {$lang.setupfee}{/if}</option>{/if}
                {if $abilling.q!=0}
                    <option value="q">{$abilling.q|price:$currency} {$lang.Quarterly}{if $abilling.q_setup!=0} + {$abilling.q_setup|price:$currency} {$lang.setupfee}{/if}</option>{/if}
                {if $abilling.s!=0}
                    <option value="s">{$abilling.s|price:$currency} {$lang.SemiAnnually}{if $abilling.s_setup!=0} + {$abilling.s_setup|price:$currency} {$lang.setupfee}{/if}</option>{/if}
                {if $abilling.a!=0}
                    <option value="a">{$abilling.a|price:$currency} {$lang.Annually}{if $abilling.a_setup!=0} + {$abilling.a_setup|price:$currency} {$lang.setupfee}{/if}</option>{/if}
                {if $abilling.b!=0}
                    <option value="b">{$abilling.b|price:$currency} {$lang.Biennially}{if $abilling.b_setup!=0} + {$abilling.b_setup|price:$currency} {$lang.setupfee}{/if}</option>{/if}
                {if $abilling.t!=0}
                    <option value="t">{$abilling.t|price:$currency} {$lang.Triennially}{if $abilling.t_setup!=0} + {$abilling.t_setup|price:$currency} {$lang.setupfee}{/if}</option>{/if}

            </select>
        {/if}
        {if $abilling.paytype!='Free'}
            <input type="checkbox" name="addon_invoice" id="new_addon_invoice" value="1" checked="checked"/>
            <strong>{$lang.CreateInvoice}</strong>
        {else}
            <input type="hidden" name="addon_invoice" id="new_addon_invoice" value="0"/>
        {/if}

    {/if}

{elseif $action=='getacctaddons'}
    <script type="text/javascript">
        {literal}
        function submitAddon(id) {
            $('#account_form').append('<input type="hidden" name="addon_id" value="' + id + '"/>');
            return true;
        }

        function loadTemplate(addon_id, fn) {
            $('#dommanager').show();
            $('#man_content').addLoader();
            $('#man_title').html(fn);
            ajax_update('?cmd=accounts&action=addonmodule', {addon_id: addon_id, call: fn}, '#man_content');
            return false;
        }

        function addAddon() {
            $.post('?cmd=accounts&action=addon_add', {
                account_id: $('#account_id').val(),
                addon_id: $('#new_addon_id').val(),
                gateway: $('#new_addon_gtw').val(),
                cycle: $('#new_addon_cycle').val(),
                invoice: $('#new_addon_invoice').is(':checked')
            }, function (data) {
                var resp = parse_response(data);
                if (resp) {

                    $('#AddAddon').hide();
                    $('#areaddons').show();

                    $('#noaddons').hide();
                    $('#addontbl').show();
                    $('#addontbl').append(resp);

                }
            });
            return false;

        }

        function editaddon(id) {
            ajax_update('?cmd=accounts&action=addon_details&addon_id=' + id, {}, '#addonedit_' + id);
            return false;
        }

        function saveChanges(id) {
            ajax_update('?cmd=accounts&action=addon_save&addon_id=' + id + '&' + $('#innerform_' + id).serialize(), {}, '#addonedit_' + id);
            $('#AddAddonT').show();
            return false;
        }

        function cancelChanges(id) {
            ajax_update('?cmd=accounts&action=addonrow&addon_id=' + id, {}, '#addonedit_' + id);
            $('#AddAddonT').show();
            return false;
        }

        function deleteaddon(id) {
            var answer = confirm('{/literal}{$lang.addondeleteconfirm}{literal}');
            if (answer) {
                ajax_update('?cmd=accounts&action=addon_remove&addon_id=' + id);
                $('#addonedit_' + id).remove();
                if ($('#addontbl tr').length < 2) {
                    $('#addontbl').hide();
                    $('#areaddons').hide();
                    $('#noaddons').show();
                }
            }
            return false;
        }

        function cnbilling(sel) {
            ajax_update('?cmd=accounts&action=addonbilling', {addon_id: $(sel).val()}, '#addon_billing');
        }
        
        $(document).ready(function() { 
            $('.ui-tooltips-i').tipTip({delay:100});
        });
        
        {/literal}
    </script>
    <table border="0" cellpadding="2" cellspacing="0" width="100%" class="table glike" id="addontbl"
           {if !$account_addons}style="display:none"{/if}>


        <tr>
            <th>{$lang.Name}</th>
            <th>{$lang.Billing}</th>
            <th><span class="ui-tooltips-i" title="ถ้าเปลี่ยน status เป็น Active ระบบจะทำการบันทึก invoice item ที่เกี่ยวข้องเป็น is_shipped (ส่งของแล้ว) ด้วย" style="border-bottom:1px dotted red; cursor:pointer;">{$lang.Status}</span></th>
            <th></th>

            <th width="20"></th>
            <th width="20"></th>
        </tr>


        {if $account_addons}

            {foreach from=$account_addons item=addon}
                <tr id="addonedit_{$addon.id}">
                    <td>{$addon.name}</td>
                    <td>{if $addon.billingcycle=='Free'} {$lang.Free} {else}{$addon.recurring_amount|price:$client.currency_id} {$lang[$addon.billingcycle]} {if $addon.setup_fee>0}+ {$addon.setup_fee|price:$client.currency_id} {$lang.setupfee}{/if}{/if}</td>
                    <td><span class="{$addon.status}">{$lang[$addon.status]}</span></td>
                    <td>{if $addon.methods}
                            {foreach from=$addon.methods item=met}<input type="submit" value="{$met}" name="addonmethod"

                                                                         class="btn {if $met=='Terminate'}btn-danger{else}btn-default{/if} btn-xs"
                                                                         onclick="return submitAddon({$addon.id});"/>{/foreach}
                            {if $addon.templated} {foreach from=$addon.templated item=met}<input type="submit"
                                                                                                 value="{$met}"
                                                                                                 name="addontemplated"
                                                                                                 onclick="return loadTemplate({$addon.id},'{$met}');"/>{/foreach}{/if}
                        {/if}</td>
                    <td><a href="javascript:void(0);" class="editbtn" onclick="editaddon({$addon.id})">{$lang.Edit}</a>
                    </td>
                    <td><a href="javascript:void(0);" class="delbtn"
                           onclick="deleteaddon({$addon.id})">{$lang.Remove}</a></td>
                </tr>
            {/foreach}

        {/if}
    </table>
    <div class="lighterblue" id="AddAddon" style="padding:5px;display:none;">

        {if $addons}
            <form id="addonform">
                <table border="0" cellpadding="3" cellspacing="0" width="100%" border="0">
                    <tr>
                        <td>{$lang.addoncolon} <select name="addon" id="new_addon_id" onchange="cnbilling(this)">

                                {foreach from=$addons  item=a}
                                    <option value="{$a.id}">{$a.name}</option>
                                {/foreach}
                            </select>
                        </td>
                        <td id="addon_billing">
                            {if $abilling}
                                {if $abilling.paytype=='Free'}
                                    <input type="hidden" name="new_addon_cycle" value="free" id="new_addon_cycle"/>
                                    {$lang.price}:
                                    <strong> {$lang.Free}</strong>
                                {elseif $abilling.paytype=='Once'}
                                    {$lang.price}: {$abilling.m|price:$client.currency_id:true:true} {$lang.Once} {if $abilling.m_setup>0}/ {$abilling.m_setup|price:$client.currency_id:true:true} {$lang.setupfee}{/if}
                                    <input type="hidden" name="new_addon_cycle" value="once" id="new_addon_cycle"/>
                                {else}
                                    {$lang.price}:
                                    <select name="new_addon_cycle" id="new_addon_cycle">
                                        {if $abilling.h!=0}
                                            <option value="h">{$abilling.h|price:$client.currency_id:true:true} {$lang.Hourly}{if $abilling.h_setup!=0} + {$abilling.h_setup|price:$client.currency_id:true:true} {$lang.setupfee}{/if}</option>{/if}
                                        {if $abilling.d!=0}
                                            <option value="d">{$abilling.d|price:$client.currency_id:true:true} {$lang.Daily}{if $abilling.d_setup!=0} + {$abilling.d_setup|price:$client.currency_id:true:true} {$lang.setupfee}{/if}</option>{/if}
                                        {if $abilling.w!=0}
                                            <option value="w">{$abilling.w|price:$client.currency_id:true:true} {$lang.Weekly}{if $abilling.w_setup!=0} + {$abilling.w_setup|price:$client.currency_id:true:true} {$lang.setupfee}{/if}</option>{/if}
                                        {if $abilling.m!=0}
                                            <option value="m">{$abilling.m|price:$client.currency_id:true:true} {$lang.Monthly}{if $abilling.m_setup!=0} + {$abilling.m_setup|price:$client.currency_id:true:true} {$lang.setupfee}{/if}</option>{/if}
                                        {if $abilling.q!=0}
                                            <option value="q">{$abilling.q|price:$client.currency_id:true:true} {$lang.Quarterly}{if $abilling.q_setup!=0} + {$abilling.q_setup|price:$client.currency_id:true:true} {$lang.setupfee}{/if}</option>{/if}
                                        {if $abilling.s!=0}
                                            <option value="s">{$abilling.s|price:$client.currency_id:true:true} {$lang.SemiAnnually}{if $abilling.s_setup!=0} + {$abilling.s_setup|price:$client.currency_id:true:true} {$lang.setupfee}{/if}</option>{/if}
                                        {if $abilling.a!=0}
                                            <option value="a">{$abilling.a|price:$client.currency_id:true:true} {$lang.Annually}{if $abilling.a_setup!=0} + {$abilling.a_setup|price:$client.currency_id:true:true} {$lang.setupfee}{/if}</option>{/if}
                                        {if $abilling.b!=0}
                                            <option value="b">{$abilling.b|price:$client.currency_id:true:true} {$lang.Biennially}{if $abilling.b_setup!=0} + {$abilling.b_setup|price:$client.currency_id:true:true} {$lang.setupfee}{/if}</option>{/if}
                                        {if $abilling.t!=0}
                                            <option value="t">{$abilling.t|price:$client.currency_id:true:true} {$lang.Triennially}{if $abilling.t_setup!=0} + {$abilling.t_setup|price:$client.currency_id:true:true} {$lang.setupfee}{/if}</option>{/if}
                                    </select>
                                {/if}
                                {if $abilling.paytype!='Free'}
                                    <input type="checkbox" name="addon_invoice" id="new_addon_invoice" value="1"
                                           checked="checked"/>
                                    <strong>{$lang.CreateInvoice}</strong>
                                {else}
                                    <input type="hidden" name="addon_invoice" id="new_addon_invoice" value="0"/>
                                {/if}

                            {/if}

                        </td>
                        <td>
                            {$lang.Gateway}:<select name="new_addon_gateway" id="new_addon_gtw">
                                {foreach from=$gateways item=module key=id}
                                    <option value="{$id}">{$module}</option>
                                {/foreach}
                            </select>
                        </td>
                        <td>
                            <input type="button" value="{$lang.addaddon}" id="addonSubmit" style="font-weight:bold"
                                   onclick="addAddon();"/> <span class="orspace">{$lang.Or} <a href="#"
                                                                                               onclick="$('#AddAddon').hide();$('#AddAddonT').show();return false;"
                                                                                               class="editbtn">{$lang.Cancel}</a></span>
                        </td>

                    </tr>

                </table> {securitytoken}</form>
        {else}
            {$lang.noaddons}
            <a href="?cmd=productaddons&action=addaddon">{$lang.createaddon}</a>
        {/if}
    </div>
    <table border="0" cellpadding="3" cellspacing="0" width="100%" class="table glike" id="AddAddonT">
        <tr>
            <th align="left">
                <a href="#" onclick="$('#AddAddon').toggle();$('#AddAddonT').toggle();return false;"
                   class="editbtn">{$lang.addaddon}</a>
            </th>
        </tr>
    </table>
{elseif $action=='getowners'}
    <div class="row">
        <div class="col-md-6 form-inline col-md-offset-3">
            <div class="form-group">
                <label>{$lang.newowner}</label>
                <select name="new_owner_id" class="form-control" load="clients" style="min-width:180px">

                </select>


            </div>
            <input type="submit" name="changeowner" value="{$lang.changeowner}" style="font-weight:bold"
                   class="btn btn-primary btn"/>

            <input type="button" value="{$lang.Cancel}" onclick="$('#ChangeOwner').hide();return false;"
                   class="btn btn-default btn"/>

        </div>
    </div>
    <script>Chosen.find()</script>
{elseif $action=='cancelrequests'}
    {if $requests}
        <div class="box box-primary  no-padding" style="margin-top:20px;">
            <div class="box-header" style="padding:5px 10px;">
                <h3 class="box-title" style="font-size:12px">{$lang.canceltitle}</h3>
            </div>
            <div class="box-body">
                <table border="0" class="table whitetable">
                    {foreach from=$requests item=req}
                        <tr>
                            <td>
                                <a href="?cmd=accounts&action=edit&id={$req.account_id}">
                                    #{$req.account_id} {$req.firstname} {$req.lastname}
                                </a>
                            </td>
                        </tr>
                    {/foreach}
                </table>

            </div>
        </div>
    {/if}

{elseif $action=='getstatus'}
    <strong>{if $status}{$status}{else}Unknown{/if}</strong>
    <a href=""
       onclick="getStatus({$service_id}, this); return false;"><img
                src="{$template_dir}img/arrow_refresh_small.gif" alt="refresh"/></a>
{elseif $action == 'log'}
    <table width="100%" cellspacing="0" cellpadding="3" border="0" class="table glike hover">
        <tbody>
            <tr>
                <th width="8%">{$lang.Date}</th>
                <th>{$lang.Login}</th>
                <th>{$lang.Module}</a></th>
                <th width="12%">{$lang.Action}</th>
                <th width="8%">{$lang.Result}</th>
                <th width="35%">{$lang.Change}</th>
                <th width="16%">{$lang.Error}</th>
            </tr>
        </tbody>
        <tbody>

            {if $logdata}
                {foreach from=$logdata  item=log}
                    <tr {if $log.manual=='1'}class="man"{/if}>
                        <td>{$log.date}</td>
                        <td>{$log.admin_login}</td>
                        <td>{$log.module}</td>
                        <td>{$log.action}</td>
                        <td>{if $log.result == 1}<font style="color:#006633">{$lang.Success}</font>{else}<font
                                    style="color:#990000">{$lang.Failure}</font>{/if}</td>
                        <td>
                            {if $log.change}
                                {if $log.change.serialized}
                                    <ul class="log_list">
                                        {foreach from=$log.change.data item=change}
                                            <li>
                                                {if $change.name}<span class="log_change">{$change.name} :</span>{/if}
                                                {if $change.from}
                                                    <samp>{$change.from}</samp>
                                                {else}
                                                    <em>(empty)</em>
                                                {/if}
                                                {if isset($change.to)} ->
                                                    {if $change.to}
                                                        <samp>{$change.to}</samp>
                                                    {else}
                                                        <em>(empty)</em>
                                                    {/if}
                                                {/if}
                                            </li>
                                        {/foreach}
                                    </ul>
                                {else}{$log.change.data}{/if}
                            {/if}
                        </td>
                        <td>{$log.error}</td>
                    </tr>
                {/foreach}
            {else}
                <tr>
                    <td colspan="7"><strong>{$lang.nothingtodisplay}</strong></td>
                </tr>
            {/if}
        </tbody>

    </table>
    {if $totalpages}
        <center class="blu paginercontainer">
            <strong>{$lang.Page} </strong>
            {section name=foo loop=$totalpages}
                <a href='?cmd=accounts&action=log&id={$acc_id}&page={$smarty.section.foo.iteration-1}' class="npaginer
                    {if $smarty.section.foo.iteration-1==$currentpage}
                    currentpage
                    {/if}"
                >{$smarty.section.foo.iteration}</a>
            {/section}
        </center>
        <script> $('.paginercontainer', 'div.slide:visible').infinitepages(); </script>
    {/if}



{elseif $action == 'getadvanced'}
    <a href="?cmd=accounts&resetfilter=1" {if $currentfilter}style="display:inline"{/if}
       class="freseter">{$lang.filterisactive}</a>
    <form class="searchform filterform" action="?cmd=accounts" method="post" onsubmit="return filter(this)">
        {include file="_common/filters.tpl"}

        {if $custom_filters}
            <table width="100%" cellspacing="2" cellpadding="3" border="0">
                <tbody>
                    {include file=$custom_filters}
                    <tr>
                        <td>{$lang.Server}</td>
                        <td colspan="5">
                            <select name="filter[server_id]">
                                <option value=''>{$lang.Any}</option>
                                {foreach from=$advanced.servers item=o}
                                    <option {if $currentfilter.server_id==$o.id}selected="selected"{/if}
                                            value='{$o.id}'>{$o.groupname} - {$o.name}</option>
                                {/foreach}
                            </select>
                        </td>
                    </tr>
                    <tr>
                        <td colspan="6">
                            <center>
                                <input type="submit" value="{$lang.Search}" class="btn btn-primary btn-sm"/>
                                &nbsp;&nbsp;&nbsp;
                                <input type="submit" value="{$lang.Cancel}"
                                       onclick="$('#hider2').show();$('#hider').hide();return false;"
                                       class="btn btn-default btn-sm"/>
                            </center>
                        </td>
                    </tr>
                </tbody>
            </table>
        {/if}
        {securitytoken}
    </form>
    <script type="text/javascript">bindFreseter();</script>
{elseif $action=='clientaccounts'}
    <div class="blu clearfix">

        <div class="pull-right">
            {include file='ajax.filterquicktool.tpl' client_id=$client_id loadid='accountslist' href="?cmd=accounts&action=getadvanced"}
            <a href="?cmd=orders&action=add&related_client_id={$client_id}" class="btn btn-primary pull-right btn-xs"
               target="_blank"><i class="fa fa-plus"></i> {$lang.newaccount}</a>
        </div>

        <form action="" method="post" class="pull-left account_methods">
            {$lang.withselected}
            <a class="submiter menuitm menu-auto" name="create" {if $enablequeue}queue='push'{/if}
               href="#"><span><strong>{$lang.Activate}</strong></span></a>
            <a class="submiter menuitm menu-auto" name="suspend" {if $enablequeue}queue='push'{/if}
               href="#"><span>{$lang.Suspend}</span></a>
            <a class="submiter menuitm menu-auto" {if $enablequeue}queue='push'{/if}
               name="unsuspend" href="#"><span>{$lang.Unsuspend}</span></a>
            <a class="submiter menuitm confirm menu-auto" name="delete"
               {if $enablequeue}queue='push'{/if} href="#"><span
                        style="color:#FF0000">{$lang.Terminate}</span></a>
            {if !$forbidAccess.deleteServices}
                <a class="fulldelete menuitm confirm menu-auto" name="fulldelete"
                   {if $enablequeue}queue='push'{/if} href="#" onclick="confirm1();"><span
                            style="color:#FF0000">{$lang.delete|ucfirst}</span></a>
            {/if}
            <span class="menu-auto-reset" style="margin-right: 7px;"></span>

            Category:
            <select id="client_service_cat" name="category_id" style="width:250px;"
                    onchange="$('.slide:visible').addLoader();ajax_update('',$(this).parents('form').eq(0).serializeArray(),$(this).parents('.slide'));return false;">
                {foreach from=$categories item=c}
                    <option value="{$c.id}" {if $category_id==$c.id}selected="selected"{/if}>{$c.name} ({$c.total})
                    </option>
                {/foreach}
            </select>
            {$lang.status}
            <select id="client_service_status" name="status"
                    onchange="$('.slide:visible').addLoader();ajax_update('',$(this).parents('form').eq(0).serializeArray(),$(this).parents('.slide'));return false;">
                <option value="" {if !$status}selected="selected"{/if}>{$lang.All}</option>
                <option value="Active" {if $status=="Active"}selected="selected"{/if}>{$lang.Active}</option>
                <option value="Pending" {if $status=="Pending"}selected="selected"{/if}>{$lang.Pending}</option>
                <option value="Suspended" {if $status=="Suspended"}selected="selected"{/if}>{$lang.Suspended}</option>
                <option value="Terminated"
                        {if $status=="Terminated"}selected="selected"{/if}>{$lang.Terminated}</option>
                <option value="Cancelled" {if $status=="Cancelled"}selected="selected"{/if}>{$lang.Cancelled}</option>
                <option value="Fraud" {if $status=="Fraud"}selected="selected"{/if}>{$lang.Fraud}</option>
            </select>
            <input type="hidden" name="id" value="{$client_id}"/>
            <input type="hidden" name="action" value="clientaccounts"/>
            <input type="hidden" name="cmd" value="accounts"/>
            {securitytoken}
        </form>
    </div>
    {if $accounts}
        <form method="post" action="?cmd=accounts" id="form_accounts">
        <table cellspacing="0" cellpadding="3" border="0" width="100%" class="table glike hover">
            <thead>
                <tr>
                    <th width="20"><input type="checkbox" id="checkall"></th>
                    <th class="text-nowrap"><a href="?cmd=accounts&action=clientaccounts&id={$client_id}"
                                               class="sortorder" data-orderby="id">{$lang.accounthash}</a></th>
                    <th><a href="?cmd=accounts&action=clientaccounts&id={$client_id}" class="sortorder"
                           data-orderby="domain">IP Address<!--{$lang.Domain}--></a></th>
                    <th><a href="?cmd=accounts&action=clientaccounts&id={$client_id}" class="sortorder"
                           data-orderby="name">{$lang.Service}</a></th>
                    {if $admindata.access.viewAccountsPrices}
                        <th><a href="?cmd=accounts&action=clientaccounts&id={$client_id}" class="sortorder"
                           data-orderby="total">{$lang.Price}</a></th>
                    {/if}
                    <th><a href="?cmd=accounts&action=clientaccounts&id={$client_id}" class="sortorder"
                           data-orderby="billingcycle">{$lang.billingcycle}</a></th>
                    <th><a href="?cmd=accounts&action=clientaccounts&id={$client_id}" class="sortorder"
                           data-orderby="status">{$lang.Status}</a></th>
                    <th><span class="sortorder" title="ดึงจากวัน duedate ของ invoice ที่ paid ล่าสุด">Expiry Date</span></th>
                    <th><a href="?cmd=accounts&action=clientaccounts&id={$client_id}" class="sortorder"
                           data-orderby="next_due">{$lang.nextdue}</a></th>
                    <th width="20"/>
                </tr>
            </thead>

            <tbody>
                {foreach from=$accounts key=k item=account}
                    <tr>
                        <td><input type="checkbox" class="check-account" value="{$account.id}" name="selected[]"></td>
                        <td><a href="?cmd=accounts&action=edit&id={$account.id}">{$account.id}</a></td>
                        <td>{if isset($aAccounts[$k].ip)}{$aAccounts[$k].ip}{else}{$account.domain}{/if}</td>
                        <td>{if isset($aAccounts[$k].whmcs_order) && $aAccounts[$k].whmcs_order}WHMCS - {/if}{$account.name}</td>
                        {if $admindata.access.viewAccountsPrices}
                            <td>{$account.total|price:$account.currency_id}</td>
                        {/if}
                        <td>{$lang[$account.billingcycle]}</td>
                        <td><span class="{$account.status}">{$lang[$account.status]}</span></td>
                        <td>{if $account.next_due|dateformat:$date_format != ''}{if isset($aAccounts[$k].expire)}<span style="color:{$aAccounts[$k].color};">{$aAccounts[$k].expire}</span>{elseif isset($aAccounts[$k].error)}{$aAccounts[$k].error}{else}-{/if}{/if}</td>
                        <td>{$account.next_due|dateformat2:$date_format}</td>
                        <td><a href="?cmd=accounts&action=edit&id={$account.id}" class="editbtn">{$lang.Edit}</a></td>

                    </tr>
                {/foreach}
            </tbody>
        </table>
        {securitytoken}
            <div id="confirm_ord_delete" hidden bootbox data-title="{$lang.accdelheading}"
                 data-callback="confirmsubmit2" data-btnclass="btn-danger">

                <form action="?cmd=accounts&make=fulldelete" method="post">
                    <p><strong>{$lang.accdeldescr}</strong></p>

                    <input type="radio" checked="checked" name="harddelete" value="true"
                           class="cc_hard"/> <span>{$lang.delete_account_opt1}</span><br/>
                    <input type="radio" name="harddelete" value="false" id="cc_soft"/> <span>{$lang.delete_account_opt2}</span><br/>

                    {securitytoken}
                </form>

            </div>
        </form>
        <script>
            {literal}
            function confirm1() {
                $('#confirm_ord_delete').trigger('show');
                return false;
            }
            function confirmsubmit2() {
                var add = '';
                if ($('.bootbox-body input.cc_hard').is(':checked'))
                    add = '&harddelete=true';

                update_account($('.fulldelete'), add);
                bootbox.hideAll();
                return false;
            }

            function cancelsubmit2() {
                $('#confirm_ord_delete').hide().parent().css('position', 'inherit');
                return false;
            }

            function update_account(button, add) {
                const form = $('#form_accounts').serialize(),
                    name = $(button).attr('name'),
                    page = $('.currentpage').data('page'),
                    form_clientaccounts = $('.account_methods').serializeArray();
                form_clientaccounts.push({name:'page', value:page});
                form_clientaccounts.push({name:'stack', value:'push'});
                if (name == 'delete'){
                    var conf = confirm({/literal}'{$lang.perform_action}'{literal});
                    if (conf == false){
                        return false;
                    }
                }
                $('.slide:visible').addLoader();
                var pushs='';
                if ($(button).attr('queue'))
                    pushs='push';
                ajax_update('?cmd=accounts'+'&'+form+'&'+$(button).attr('name'),{
                    layer:'ajax',
                    stack:pushs,
                    page:page
                }, function () {
                    update_data(form_clientaccounts, button);
                });
                return false;
            }
            function update_data(form, button) {
                ajax_update('',form,$(button).parents('.slide'));
                return false;
            }
            var check_account = $('.check-account');
                $('#checkall').on('change', function () {
                    if ($(this).attr('checked')){
                        check_account.attr('checked', true);
                        check_account.closest('tr').addClass('checkedRow');
                    }else{
                        check_account.attr('checked', false);
                        check_account.closest('tr').removeClass('checkedRow');
                    }
                });
                check_account.on('change', function () {
                    if ($(this).attr('checked')){
                        $(this).closest('tr').addClass('checkedRow');
                    }else{
                        $(this).closest('tr').removeClass('checkedRow');
                    }
                });

                $('.submiter').on('click', function () {
                    update_account(this, '');
                });

                $('#per_page').on('change', function () {
                    const form_clientaccounts = $('.account_methods').serializeArray();
                    form_clientaccounts.push({name:'accounts_per_page', value:$(this).val()});
                    $('.slide:visible').addLoader();
                    ajax_update('',form_clientaccounts,$('.submiter').parents('.slide'));
                });

            {/literal}
        </script>
        {if $totalpages}
            <div class="text-center" style="margin-top: 10px;">
                <div style="display:inline-block">
                    <strong>{$lang.records_per_page}</strong>
                    <select name="accounts_per_page" id="per_page">
                        <option value="10" {if $accounts_per_page == 10}selected{/if}>10</option>
                        <option value="20" {if $accounts_per_page == 20}selected{/if}>20</option>
                        <option value="50" {if $accounts_per_page == 50}selected{/if}>50</option>
                        <option value="100" {if $accounts_per_page == 100}selected{/if}>100</option>
                        <option value="100000" {if $accounts_per_page == 100000}selected{/if}>All</option>
                    </select>
                </div>
                <div style="display:inline-block">
                    <center class="blu paginercontainer">
                        <strong>{$lang.Page} </strong>
                        {section name=foo loop=$totalpages}
                            <a href='?cmd=accounts&action=clientaccounts&id={$client_id}&page={$smarty.section.foo.iteration-1}&category_id={$category_id}&status={$status}'
                               data-page="{$smarty.section.foo.iteration-1}" class="npaginer
                                {if $smarty.section.foo.iteration-1==$currentpage}
                                currentpage
                                {/if}"
                            >{$smarty.section.foo.iteration}</a>
                        {/section}
                    </center>
                </div>
            </div>
            <script> $('.paginercontainer', 'div.slide:visible').infinitepages();
                FilterModal.bindsorter('{$orderby.orderby}', '{$orderby.type}');</script>
        {/if}
    {else}
        <p style="text-align: center">{$lang.nothingtodisplay}</p>
    {/if}

{elseif $action=='getservers'}
    <select name="server_id" id="server_id"
            {if $manumode}class="manumode"{/if} {if $manumode && !$show}style="display:none"{/if}>

        {foreach from=$servers item=server name=foo}
            <option value="{$server.id}"
                    {if $s_id==$server.id || (!$s_id && $smarty.foreach.foo.first)}selected="selected"
                    def="def"{/if}>{$server.name} ({$server.accounts}/{$server.max_accounts} Accounts)
            </option>
        {/foreach}


    </select>
{elseif $action=='customfn' && $customfn=='AttachToServer'}
    <select name="AttachToServer[serverid]">
        {foreach from=$AttachToServer item=plan}
            <option value="{$plan.id}">{$plan.hostname}</option>
        {/foreach}
    </select>
    <input type="hidden" name="customfn" value="AttachToServer"/>
    <input type="submit" value="Attach to this server"/>
{elseif $action=='customfn' && $customfn=='GetOsTemplates'}
    <select name="os">
        {foreach from=$GetOsTemplates item=plan}
            {if $plan|is_array}
                <option {if $plan[0]}selected="selected" {/if} value="{$plan[0]}">{$plan[1]}</option>
            {else}
                <option {if $plan}selected="selected" {/if}>{$plan}</option>
            {/if}

        {/foreach}
    </select>
{elseif $action=='customfn' && $customfn=='GetNodes'}
    <select name="node">
        {foreach from=$GetNodes item=plan}
            {if $plan|is_array}
                <option {if $plan[0]}selected="selected" {/if} value="{$plan[0]}">{$plan[1]}</option>
            {else}
                <option {if $plan}selected="selected" {/if}>{$plan}</option>
            {/if}

        {/foreach}
    </select>
{elseif $action=='customfn' && $customfn=='RebuildOS'}
    <table cellspacing="0" cellpadding="10" border="0" width="100%">
        <tbody>
            <tr>
                <td width="30%" valign="top">
                    {if $RebuildOS && $RebuildOS|is_array}{$lang.choosenewos}{else}{$lang.enternewos}{/if}
                </td>

                <td valign="top">
                    {if $RebuildOS && $RebuildOS|is_array}
                        <select name="RebuildOS[os]">
                            {foreach from=$RebuildOS item=plan}
                                {if !($plan|is_array)}
                                    <option>{$plan}</option>
                                {elseif !$plan.ignore}
                                    <option value="{$plan[0]}">{$plan[1]}</option>
                                {/if}
                            {/foreach}
                        </select>
                    {else}
                        <input type="text" name="RebuildOS[os]"/>
                    {/if}
                </td>
                <td width="30%" valign="top">
                    <input type="hidden" name="customfn" value="RebuildOS"/>
                    <input type="submit" value="{$lang.rebuildos}"/>
                </td>
            </tr>
        </tbody>
    </table>
{elseif $action=='customfn' && $customfn=='Backups'}
    <input type="hidden" name="customfn" value="restoreBackup" id="bkp_fn"/>
    <div style="padding:10px 10px 15px 10px">
        <button onclick="{literal}if($('#createBackup').hasClass('shown')) {$('#createBackup').hide(); $('#createBackup').removeClass('shown'); } else {$('#createBackup').show(); $('#createBackup').addClass('shown');} return false;{/literal}"
                style="font-weight: bold">{$lang.createBackup}</button>
        <span id="createBackup" style="display:none; margin-left:20px;">
            {$lang.backupName}: <input name="createBackup[backup_name]" id="backupName"/>
            <button type="submit" onclick="if(!create_backup(this)) return false;">{$lang.Create}</button>
            <button onclick="{literal}$('#createBackup').hide(); $('#createBackup').removeClass('shown'); return false;{/literal}">{$lang.Cancel}</button>
        </span>
    </div>
    <table width="60%" cellspacing="0" cellpadding="3" border="0" class="table glike hover">
        <tr>
            <th>{$lang.Type}</th>
            <th>{$lang.State}</th>
            <th>{$lang.Date}</th>
            <th>{$lang.Size}</th>
            <th></th>
            <th></th>
        </tr>
        {if $Backups && $Backups|is_array}
            {foreach from=$Backups item=bkp}
                <tr>
                    <td><strong>{if $bkp.type != 'autobackup'}Manual{else}{$bkp.type|ucfirst}{/if}</strong></td>
                    <td><strong>{if $bkp.available}{$lang.Available}{else}{$lang.Pending}{/if}</strong></td>
                    <td>{$bkp.date}</td>
                    <td>{if $bkp.size}{$bkp.size}{else}Not build yet{/if}</td>
                    <td>{if $bkp.available}
                            <button type="submit" value="{$backup.id}" style="font-weight: bold"
                                    onclick="if(!restore_backup(this)) return false;" >{$lang.Restore}</button>{else}{$lang.Notavailable}{/if}
                    </td>
                    <td>{if $bkp.type != 'autobackup'}<a href="" onclick="delete_backup(this,{$bkp.id}); return false;"
                                                         class="delbtn">{$lang.Delete}</a>{/if}</td>
                </tr>
            {/foreach}
        {else}
            <tr>
                <td colspan="6">{$lang.noBackupsToDisp}</td>
            </tr>
        {/if}
    </table>
    <script type="text/javascript">
        {literal}
        function restore_backup(elem) {
            if (confirm('{/literal}{$lang.confirmRestoreBkp}{literal}')) {
                $(elem).parent().append('<input type="hidden" value="' + $(elem).val() + '" name="restoreBackup[backup_id]" />');
                return true;
            }
        }

        function create_backup() {
            if (confirm('{/literal}{$lang.confirmCreateBkp}{literal}')) {
                $('#bkp_fn').val('createBackup');
                return true;
            }
        }

        function delete_backup(elem, id) {
            if (confirm('{/literal}{$lang.confirmDeleteBkp}{literal}')) {
                $('#bkp_fn').val('deleteBackup');
                $(elem).parent().append('<input type="hidden" value="' + id + '" name="deleteBackup[backup_id]" />');
                $("input[name='submit']").remove();
                $('#account_form').attr('action', '?cmd=accounts&action=edit&id={/literal}{$service_id}{literal}&list=all&submit=1').submit();
                return true;
            }
        }
        {/literal}
    </script>
{elseif $action=='customfn' && $customfn=='ConfigureBackup'}
    <table cellspacing="0" cellpadding="10" border="0" width="100%">
        <tbody>
            <tr>
                <td width="30%" valign="top">
                    {$lang.Enablebackups}:
                </td>

                <td valign="top">
                    <input type="checkbox" value="1" name="ConfigureBackup[enablebackup]"
                           {if $ConfigureBackup}checked="checked"{/if}/>


                </td>
                <td width="30%" valign="top">
                    <input type="hidden" name="customfn" value="ConfigureBackup"/>
                    <input type="submit" value="{$lang.submit}"/>
                </td>
            </tr>
        </tbody>
    </table>
{elseif $action=='addonmodule' && $customfile}
    {include file=$customfile}
{elseif $action=='customfn' && $customfn=='ChangePlan'}
    <table cellspacing="0" cellpadding="10" border="0" width="100%">
        <tbody>
            <tr>
                <td width="30%" valign="top">
                    {$lang.chooseplan}
                </td>

                <td valign="top">
                    <select name="ChangePlan[plan]">
                        {foreach from=$ChangePlan item=plan}
                            <option>{$plan}</option>
                        {/foreach}
                    </select>

                </td>
                <td width="30%" valign="top">
                    <input type="hidden" name="customfn" value="ChangePlan"/>
                    <input type="submit" value="{$lang.changeplan}"/>
                </td>
            </tr>
        </tbody>
    </table>
{elseif $action=='default'}
    {if $accounts}
        {foreach from=$aAccounts item=account}
            <tr>
                <td><input type="checkbox" class="check" value="{$account.id}" name="selected[]"/></td>
                <td><a href="?cmd=accounts&action=edit&id={$account.id}&list={$currentlist}">{$account.id}</a></td>
                <td>
                    {$account|@profilelink:true:true}
                </td>
                <td>{if isset($account.ip)}{$account.ip}{else}{$account.domain}{/if}</td>
                <td>{$account.name}</td>
                {if $admindata.access.viewAccountsPrices}
                    <td>{$account.total|price:$account.currency_id}</td>
                {/if}
                <td>{$lang[$account.billingcycle]}</td>
                <td><span class="{$account.status}">{$lang[$account.status]}</span></td>
                <td>{if $account.next_due == '0000-00-00'}-{else}{$account.next_due|dateformat2:$date_format}{/if}</td>
                <td><a href="?cmd=accounts&action=edit&id={$account.id}&list={$currentlist}"
                       class="editbtn">{$lang.Edit}</a></td>

            </tr>
        {/foreach}
    {else}
        <tr>
            <td colspan="10">
                <p align="center">{$lang.Click} <a href="?cmd=orders&action=add">{$lang.here}</a> {$lang.tocreateacc}
                </p>
            </td>
        </tr>
    {/if}

    {if $addons}
        <table border="0" cellspacing="0" cellpadding="0" width="100%" bgcolor="#cccccc">
            <script type="text/javascript">
                {literal}
                function addAddon(id) {
                    ajax_update('?cmd=accounts&action=addon_add&account_id={/literal}{$account_id}{literal}&addon_id=' + id + '&gateway=' + $('#addon_gateway_' + id).val(), {}, '#addonmanagertable', false, true);
                }
                {/literal}

            </script>
            {foreach from=$addons  item=a}
                <tr>

                    <td>{$a.name}</td>
                    <td>{if $a.billingcycle=='Free'}( {$lang.Free} )  {else}({$a.recurring_amount|price:$currency} {$lang[$a.billingcycle]} + {$a.setup_fee|price:$currency} {$lang.setupfee}){/if}</td>
                    <td>{$lang.Gateway}:
                        <select name="addon_gateway_{$a.id}" id="addon_gateway_{$a.id}">
                            {foreach from=$gateways item=module key=id}
                                <option value="{$id}"
                                        {if $details.payment_module==$id}selected="selected"{/if}>{$module}</option>
                            {/foreach}
                        </select>
                    </td>
                    <td><a href="javascript:void(0)" onclick="addAddon({$a.id})">{$lang.Add}</a></td>
                </tr>
            {/foreach}
        </table>
    {/if}



{/if}

{if $addonedit }
    {if $newaddon}<tr id="addonedit_{$addonedit.id}">{/if}
    <td colspan="6" width="100%" style="padding:15px;background:#F5F9FF">
        <form action="" name="" id="innerform_{$addonedit.id}" method="post">
            <input type="hidden" value="{$addonedit.id}" name="addon_id"/>
            <input type="hidden" value="true" name="submit"/>
            <table border="0" cellpadding="2" cellspacing="0" width="100%" class="nostyle">
                <tr>
                    <td><strong>{$lang.addonname}</strong></td>
                    <td><input name="addon_name" value="{$addonedit.name}"/></td>
                    <td><strong>{$lang.Status}</strong></td>
                    <td><select name="addon_status">
                            <option {if $addonedit.status=='Pending'}selected="selected"{/if}
                                    value="Pending">{$lang.Pending}</option>
                            <option {if $addonedit.status=='Active'}selected="selected"{/if}
                                    value="Active">{$lang.Active}</option>
                            <option {if $addonedit.status=='Suspended'}selected="selected"{/if}
                                    value="Suspended">{$lang.Suspended}</option>
                            <option {if $addonedit.status=='Cancelled'}selected="selected"{/if}
                                    value="Cancelled">{$lang.Cancelled}</option>
                            <option {if $addonedit.status=='Terminated'}selected="selected"{/if}
                                    value="Terminated">{$lang.Terminated}</option>
                        </select></td>
                    <td>{$lang.paymethod}</td>
                    <td><select name="addon_payment_module">
                            {foreach from=$gateways item=module key=pid}
                                <option value="{$pid}"
                                        {if $addonedit.payment_module==$pid}selected="selected"{/if}>{$module}</option>
                            {/foreach}

                        </select></td>

                </tr>
                <tr>
                    <td>
                        <strong>    {$lang.setupfee}</strong>
                    </td>
                    <td><input name="addon_setup_fee" value="{$addonedit.setup_fee}" size="5"/></td>
                    <td><strong>{$lang.recurring}</strong></td>
                    <td><input name="addon_recurring_amount" value="{$addonedit.recurring_amount}" size="5"/></td>
                    <td><strong>{$lang.billingcycle}</strong></td>
                    <td><select name="addon_billingcycle">
                            <option value="Free"
                                    {if $addonedit.billingcycle=='Free'}selected='selected'{/if}>{$lang.Free}</option>
                            <option value="One Time"
                                    {if $addonedit.billingcycle=='One Time'}selected='selected'{/if}>{$lang.OneTime}</option>
                            <option value="Hourly"
                                    {if $addonedit.billingcycle=='Hourly'}selected='selected'{/if}>{$lang.Hourly}</option>
                            <option value="Daily"
                                    {if $addonedit.billingcycle=='Daily'}selected='selected'{/if}>{$lang.Daily}</option>
                            <option value="Weekly"
                                    {if $addonedit.billingcycle=='Weekly'}selected='selected'{/if}>{$lang.Weekly}</option>
                            <option value="Monthly"
                                    {if $addonedit.billingcycle=='Monthly'}selected='selected'{/if}>{$lang.Monthly}</option>
                            <option value="Quarterly"
                                    {if $addonedit.billingcycle=='Quarterly'}selected='selected'{/if}>{$lang.Quarterly}</option>
                            <option value="Semi-Annually"
                                    {if $addonedit.billingcycle=='Semi-Annually'}selected='selected'{/if}>{$lang.SemiAnnually}</option>
                            <option value="Annually"
                                    {if $addonedit.billingcycle=='Annually'}selected='selected'{/if}>{$lang.Annually}</option>
                            <option value="Biennially"
                                    {if $addonedit.billingcycle=='Biennially'}selected='selected'{/if}>{$lang.Biennially}</option>
                            <option value="Triennially"
                                    {if $addonedit.billingcycle=='Triennially'}selected='selected'{/if}>{$lang.Triennially}</option>
                        </select></td>

                </tr>

                <tr>
                    <td><strong>{$lang.nextdue}</strong></td>
                    <td><input name="addon_next_due" value="{$addonedit.next_due|dateformat:$date_format}"
                               readonly="readonly"
                               class="haspicker" size="14"/></td>
                    <td><strong>{$lang.regdate2}</strong></td>

                    <td><input name="addon_regdate" value="{$addonedit.regdate|dateformat:$date_format}"
                               readonly="readonly"
                               class="haspicker" size="14"/></td>
                    <td></td>
                    <td></td>
                </tr>


                <tr>
                    <td colspan="6" style="text-align:right">
                        {if $addonedit.methods} {foreach from=$addonedit.methods item=met}<input type="submit"
                                                                                                 value="{$met}"
                                                                                                 name="addonmethod"
                                                                                                 class="btn {if $met=='Terminate'}btn-danger{else}btn-default{/if} btn-sm"
                                                                                                 onclick="return submitAddon({$addon.id});"/>{/foreach}{/if}
                        {if $addonedit.templated}{foreach from=$addonedit.templated item=met}<input type="submit"
                                                                                                    value="{$met}"
                                                                                                    name="addontemplated"
                                                                                                    class="btn {if $met=='Terminate'}btn-danger{else}btn-default{/if} btn-sm"
                                                                                                    onclick="return loadTemplate({$addonedit.id},'{$met}');"/>{/foreach}{/if}
                        <input type="button" onclick="saveChanges({$addonedit.id})" class="btn btn-success btn-sm" style="font-weight:bold"
                               value="{$lang.savechanges}"/>
                        <span class="orspace">{$lang.Or} <a href="#" class="editbtn"
                                                            onclick="cancelChanges({$addonedit.id});return false;">{$lang.Cancel}</a></span>

                    </td>
                </tr>

            </table>
            {securitytoken}</form>
    </td>
    <script type="text/javascript">{literal} $('.haspicker').datePicker({
            startDate: startDate
        });{/literal}</script>
    {if $newaddon}</tr>{/if}
{/if}

{if $addonrow}    {if $newaddon}<tr id="addonedit_{$addonrow.id}">{/if}
    <td>{$addonrow.name}</td>
    <td>{if $addonrow.billingcycle=='Free'} {$lang.Free}  {else}{$addonrow.recurring_amount|price:$currency} {$lang[$addonrow.billingcycle]} {if $addonrow.setup_fee>0}+ {$addonrow.setup_fee|price:$currency} {$lang.setupfee}{/if}{/if}</td>
    <td><span class="{$addonrow.status}">{$lang[$addonrow.status]}</span></td>
    <td>{if $addonrow.methods} {foreach from=$addonrow.methods item=met}<input type="submit" value="{$met}"
                                                                               name="addonmethod"
                                                                               class="btn {if $met=='Terminate'}btn-danger{else}btn-default{/if} btn-sm"
                                                                               onclick="return submitAddon({$addonrow.id});"/>{/foreach}{/if}
        {if $addonrow.templated}{foreach from=$addonrow.templated item=met}<input type="submit" value="{$met}"
                                                                                  name="addontemplated"
                                                                                  class="btn {if $met=='Terminate'}btn-danger{else}btn-default{/if} btn-sm"
                                                                                  onclick="return loadTemplate({$addonrow.id},'{$met}');"/>{/foreach}{/if}
    </td>
    <td><a href="javascript:void(0);" onclick="editaddon({$addonrow.id})" class="editbtn">{$lang.Edit}</a></td>
    <td><a href="javascript:void(0);" onclick="deleteaddon({$addonrow.id})" class="delbtn">{$lang.Remove}</a></td>
    {if $newaddon}</tr>{/if}
{/if}

