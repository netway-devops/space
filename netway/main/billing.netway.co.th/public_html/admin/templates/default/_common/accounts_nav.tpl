<table border="0" cellpadding="2" cellspacing="0">
    <tr>
        <td>
            <a href="?cmd=accounts&list={$currentlist}"><strong>&laquo; {$lang.backto} {$lang.accounts}</strong></a>&nbsp;
        </td>
        <td class="menubar">
            {*if isset($admindata.access.editAccounts)*}
            <a class="menuitm" href="#" onclick="$('#formsubmiter').click();
                    return false"><span><strong>{$lang.savechanges}</strong></span></a>

            {if !$forbidAccess.deleteServices}
                <a class=" menuitm menu-auto" href="#" onclick="confirm1();
                        return false;"><span style="color:#FF0000">{$lang.Delete}</span>
                </a>
            {/if}
            <a class="setStatus menuitm menu-auto" id="hd1" onclick="return false;" href="#">
                <span class="morbtn">{$lang.moreactions}</span>
            </a>
            {adminwidget module="accounts" section="accountheader"}
        </td>
    </tr>
</table>

{once}
    <input type="checkbox" name="manual" value="1" class="changeMode" id="changeMode" style="display:none;"
           {if $details.manual == '1'}checked="checked" {/if} />
    <input type="submit" name="save" value="{$lang.savechanges}"
           style="font-weight:bold;display:none" id="formsubmiter"/>
    <ul id="hd1_m" class="ddmenu">
        <li><a href="AdminNotes">{$lang.editadminnotes}</a></li>
        <li><a href="OverrideSuspension">Override Suspension</a></li>
        <li><a href="SetCommitmentPeriod">{$lang.set_commitment_period}</a></li>
        <li><a href="ChangeOwner">{$lang.changeowner}</a></li>
        <li><a href="ChangeContract">{$lang.changecontract}</a></li>
        <li><a href="?cmd=accounts&action=clone_account&id={$details.id}&client_id={$details.client_id}" class="directly">Clone Service</a></li>
        {if $admindata.access.loginAsClient}
        <li><a href="../?action=adminlogin&id={$details.client_id}&redirect={"?cmd=clientarea&action=services&service=`$details.id`"|urlencode}"
               class="directly">View in client area</a></li>
        {/if}
        <li {if $details.status != 'Active' && $details.status != 'Suspended'}class="disabled"{/if}><a href="RequestCancellation">{$lang.cancelrequest}</a></li>
    </ul>
    <div id="RequestCancellation" style="display:none;" bootbox data-title="{$lang.cancelrequest}"
         data-formaction="?cmd=accounts&action=add_cancellation&id={$details.id}">
        <link media="all" rel="stylesheet" href="{$template_dir}js/timepicker/jquery.timepicker.css" />
        <script type="text/javascript" src="{$template_dir}js/timepicker/jquery.timepicker.min.js?v={$hb_version}" ></script>
        <div class="request_cancellation_modal">
            <div class="form-group">
                <label>{$lang.SubmissionDate}</label>
                <div class="no-wrap">
                    <input type="text" name="submission_date" value="{$curdate|dateformat:$date_format}" class="inp haspicker" placeholder="" style="width:90px">
                    <input type="text" name="submission_time" value="{$smarty.now|date_format:"%H:%M"}" class="timepicker inp" placeholder="" style="width:45px">
                    <div class="inp-controls">
                        <a class="btn btn-default btn-xs plus"><i class="fa fa-plus"></i></a>
                        <a class="btn btn-default btn-xs minus"><i class="fa fa-minus"></i></a>
                    </div>
                </div>
            </div>
            <div class="form-group">
                <label>{$lang.canceltype}</label>
                <select name="type" class="form-control" style="min-width:180px">
                    <option value="Admin submitted">{$lang.adminsubmitted}</option>
                    <option value="Immediate">{$lang.Immediate}</option>
                    <option value="End of billing period">{$lang.endbillingperiod}</option>
                </select>
            </div>
            <div class="form-group">
                <label>{$lang.ProcessAutomatically}</label>
                <br>
                <input type="checkbox" name="process_automatically"> {$lang.ProcessAutomaticallyInfo}
            </div>
            <div class="form-group">
                <label>{$lang.ProcessAt}</label>
                <div class="no-wrap request_at">
                    <input type="text" name="process_date" class="inp haspicker" placeholder="" style="width:90px">
                    <input type="text" name="process_time" class="timepicker inp" placeholder="" style="width:45px">
                    <div class="inp-controls">
                        <a class="btn btn-default btn-xs plus"><i class="fa fa-plus"></i></a>
                        <a class="btn btn-default btn-xs minus"><i class="fa fa-minus"></i></a>
                    </div>
                </div>
            </div>
            <div class="form-group">
                <label>{$lang.Reason}</label>
                {if $reasons}
                    {foreach from=$reasons item=reason name=foo}
                        <div class="radio" {if $smarty.foreach.foo.first}style="margin-top: 0;" {/if}>
                            <label>
                                <input type="radio" name="reason" value="{$reason.id}">
                                {$reason.reason}
                            </label>
                        </div>
                    {/foreach}
                    <div class="radio">
                        <label>
                            <input type="radio" name="reason" value="other">
                            {$lang.Other}
                        </label>
                    </div>
                    <textarea name="other_reason" class="form-control" style="min-height: 60px;"></textarea>
                {else}
                    <textarea name="reason" class="form-control" style="min-height: 60px;"></textarea>
                {/if}
            </div>
        </div>
        {securitytoken}

        {literal}
            <style>
                .request_cancellation_modal .inp-controls {
                    display: inline-block;
                    vertical-align: top;
                    border: 1px solid #ccc;
                    border-left: none;
                    margin-left: -5px;
                    border-radius: 0 2px 2px 0;
                }
                .request_cancellation_modal .inp-controls .btn + .btn {
                    margin-top: 0;
                }
                .request_cancellation_modal .inp-controls .btn {
                    display: block;
                    line-height: 1em;
                    height: 1em;
                    border: none;
                    padding: 1px 4px;
                    border-radius: 0 2px 2px 0;
                }
            </style>
        {/literal}
    </div>
    <div id="ChangeOwner" style="display:none;" bootbox data-title="{$lang.changeowner}"
         data-formaction="?cmd=accounts&action=edit&id={$details.id}&submit=1&changeowner=1">
        <div class="form-group">
            <label>{$lang.newowner}</label>
            <select name="new_owner_id" class="form-control" style="min-width:180px"></select>
        </div>
        {securitytoken}
    </div>
    <div id="ChangeContract" style="display:none;" bootbox data-title="{$lang.changecontract}"
         data-formaction="?cmd=accounts&action=edit&id={$details.id}&submit=1&changecontract=1">
        <div class="form-group">
            <label>{$lang.newcontract}</label>
            <select name="new_contract_id" class="form-control" style="min-width:180px">
                <option value="">-None-</option>
                {foreach from=$contracts item=contract}
                    <option value="{$contract.id}" {if $contract.id==$details.contract_id}selected="selected"{/if}>#{$contract.id} ({$contract.template_name})</option>
                {/foreach}
            </select>
        </div>
        {securitytoken}
    </div>
    <div id="OverrideSuspension" style="display:none;" bootbox data-title="Override Suspension"
         data-formaction="?cmd=accounts&action=edit&id={$details.id}&submit=1&overridesuspension=1"
         data-btntitle="Override"
         {if $details.autosuspend}data-active="{$details.autosuspend_date|dateformat:$date_format}"{/if} >
        <p>
            This option allows you to disable account suspension for some time or until specific
            date.
        </p>

        {if $details.autosuspend}
            <p>
                Suspension override was previously set to
                <strong>{$details.autosuspend_date|dateformat:$date_format}</strong><br/>
            </p>
        {/if}

        <div class="form-group">
            <label>Prevent automated suspension</label>
            <select class="form-control">
                <option value="3d">{$lang.for_3_days}</option>
                <option value="7d">{$lang.for_7_days}</option>
                <option value="14d">{$lang.for_14_days}</option>
                <option value="1m">{$lang.for_1_month}</option>
                <option value="c">{$lang.custom_date}</option>
            </select>
        </div>
        <div class="form-group">
            <label>{$lang.Date}</label>
            <div class="clearfix">
                <input type="text" name="date" class="form-control haspicker"/>
            </div>
        </div>
        {securitytoken}
    </div>
    <div id="SetCommitmentPeriod" style="display:none;" bootbox data-title="{$lang.set_commitment_period}"
         data-formaction="?cmd=accounts&action=edit&id={$details.id}&submit=1&setcommitmentperiod=1"
         data-btntitle="{$lang.set_period}"
         {if $details.commitment_date != '0000-00-00'}data-active="{$details.commitment_date|dateformat:$date_format}"{/if} >
        <p>
            {$lang.set_commitment_period_desc}
        </p>

        {if $details.commitment_date != '0000-00-00'}
            <p>
                {$lang.commitment_period_set_to}
                <strong>{$details.commitment_date|dateformat:$date_format}</strong><br/>
            </p>
        {/if}

        <div class="form-group">
            <label>{$lang.prevent_cancellation_request}</label>
            <select class="form-control">
                <option value="3d">{$lang.for_3_days}</option>
                <option value="7d">{$lang.for_7_days}</option>
                <option value="14d">{$lang.for_14_days}</option>
                <option value="1m">{$lang.for_1_month}</option>
                <option value="c">{$lang.custom_date}</option>
            </select>
        </div>
        <div class="form-group">
            <label>{$lang.Date}</label>
            <div class="clearfix">
                <input type="text" name="date" class="form-control haspicker"/>
            </div>
        </div>
        {securitytoken}
    </div>

    <div id="ConfirmUpdate" hidden bootbox data-title="Update Account"
         data-btnclass="btn-primary" data-btntitle="{$lang.savechanges}">
            <p><strong>Account form value change detected, please select what should happen next.</strong></p>
            <input type="radio" name="update_remote" value="1"/>
            <span> Attempt to change related values in connected App </span><br/>
            <input type="radio" name="update_remote" value="0" checked/>
            <span> Just save changes in HostBill account details </span>
    </div>

    <div id="ConfirmNewInvoice" hidden bootbox data-title="Generate Invoice"
         data-btnclass="btn-primary" data-btntitle="{$lang.savechanges}">
        <p>
            This will generate new invoice for selected service with the setting below.
        </p>
        <div class="checkbox">
            <label>
                <input type="checkbox" name="move_due" value="1" checked/>
                Update service due date
            </label>
        </div>
        <div class="checkbox">
            <label>
                <input type="checkbox" name="unlock" value="1" checked/>
                Send invoice to client
            </label>
        </div>
        <div class="checkbox">
            <label>
                <input type="checkbox" name="prorata[enable]" value="1"/>
                Generate pro-rata invoice
            </label>
        </div>
        <div class="row prorata-row" style="display: none">
            <hr />
            <div class="col-md-12">
                <strong>Pro-rata settings</strong>
            </div>
            <div class="form-group col-md-6">
                <div class="checkbox">
                    <label>
                        <input type="checkbox" class="prorata-date-toggle" rel="date-from"/>
                        Date From
                    </label>
                </div>
                <div class="datepicker">
                    <input type="text" value="{'now'|dateformat:$date_format}"
                           name="prorata[from]"  class="form-control haspicker date-from" disabled>
                </div>
            </div>
            <div class="form-group col-md-6">
                <div class="checkbox">
                    <label>
                        <input type="checkbox" class="prorata-date-toggle" rel="date-to" />
                        Date To
                    </label>
                </div>
                <div class="datepicker">
                    <input type="text" value="{$details.next_due|dateformat:$date_format}"
                           name="prorata[to]" class="form-control haspicker date-to" disabled>
                </div>
            </div>
        </div>

    </div>

    <script>
        lang['upgrconf'] = '{$lang.upgrconf|escape:'javascript'}';
        lang['empty_reason'] = '{$lang.empty_reason|escape:'javascript'}';
    </script>
    <script type="text/javascript"  src="{$template_dir}js/accounts.js?v={$hb_version}"></script>
{/once}