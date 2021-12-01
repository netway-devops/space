{if !$ajax}
    <div id="newshelfnav" class="newhorizontalnav">
        <div class="list-1">
            <ul>
                <li class="{if $action != 'rates'}active{/if}">
                    <a href="?cmd=tickettimetracking"><span class="ico money">Ticket Billing</span></a>
                </li>
                <li class="{if $action == 'rates'}active{/if} last">
                    <a href="?cmd=tickettimetracking&action=rates"><span class="ico money">Support Rates</span></a>
                </li>
            </ul>
        </div>
        <div class="list-2">
            {if $action == 'rates'}
                <div class="navsubmenu haveitems" style="display: block;">
                    <ul>
                        {if !$forbidAccess.editSupportRates }
                            <li class="list-2elem"><a href="?cmd={$cmd}&action=add" onclick="track.newRate();
                                    return false;"><span>Create New Rate</span></a></li>
                            <li class="list-2elem"><a onclick="return confirm('Are you sure you want to delete selected entries?');" class="submiter" name="delete" href="?cmd=ticketbans&amp;action=add&amp;type=pre"><span>Delete Selected</span></a></li>
                            {/if}
                    </ul>
                    <div class="right"><div class="pagination"></div></div>
                </div>
            {/if}
            <div class="clear"></div>
        </div>
    </div>
{/if}
{if $action=="default"}
    {if !$ajax}
        <input type="hidden" id="picked_tab" name="picked_tab" value="0">
        <form id="testform">
            <input type="hidden" value="{$totalpages}" name="totalpages2" id="totalpages"/>
            <a href="?cmd={$cmd}&action={$action}" id="currentlist" style="display:none" updater="#updater"></a>
            <div class="blu clearfix">
                <div class="right"><div class="pagination"></div></div>
            </div>
            <table cellspacing="0" cellpadding="3" border="0" width="100%" class="table glike hover">
                <thead>
                    <tr>
                        <th width="20">
                            <!--<input id="checkall" type="checkbox" />-->
                            <a class="sortorder" href="?cmd={$cmd}&orderby=id|ASC">#</a>
                        </th>
                        <th ><a class="sortorder" href="?cmd={$cmd}&orderby=date|ASC">Added</a></th>
                        <th ><a class="sortorder" href="?cmd={$cmd}&orderby=name|ASC">Client</a></th>
                        <th ><a class="sortorder" href="?cmd={$cmd}&orderby=ticket_number|ASC">Ticket</a></th>
                        <th ><a class="sortorder" href="?cmd={$cmd}&orderby=diff|ASC">Time Period</a></th>
                        <th ><a class="sortorder" href="?cmd={$cmd}&orderby=price|ASC">Price</a></th>
                        <th ><a class="sortorder" href="?cmd={$cmd}&orderby=rate_id|ASC">Rate</a></th>
                        <th ><a class="sortorder" href="?cmd={$cmd}&orderby=status|ASC">Status</a></th>
                        <th ><a class="sortorder" href="?cmd={$cmd}&orderby=admin|ASC">Staff</a></th>
                    </tr>
                </thead>
                <tbody id="updater">
                {/if}
                {foreach from=$items item=item}
                    <tr>
                        <td>
                            <!--<input class="check" type="checkbox" name="selected[]" value="{$item.id}" />-->
                            {$item.id}
                        </td>
                        <td>{$item.date|dateformat:$date_format}</td>
                        <td>
                            {if $item.client_id}
                                <a href="?cmd=clients&action=show&id={$item.client_id}" target="_blank">#{$item.client_id} - {$item.clientname}</a>
                            {else}
                                {$item.clientname}
                            {/if}
                        </td>
                        <td><a href="?cmd=tickets&action=view&num={$item.ticket_number}">#{$item.ticket_number}</a></td>
                        <td>{$item.diff|convert:'second'}</td>
                        <td>
                            {if $item.type == 'flat'}
                                {$item.rate|price:$currency}
                            {else}
                                {$item.ratextime|price:$currency}
                            {/if}
                        </td>
                        <td>
                            {$item.name|default:'-'}
                        </td>
                        <td>
                            {if !$item.status}<span class="Draft">{$lang.Draft}</span>
                            {elseif $item.status == 1 }
                                <span class="Active">Invoiced 
                                    {if $item.invoice_id} <small>
                                        <a href="?cmd=invoices&action=edit&id={$item.invoice_id}&list=all" style="color: #4D89AB" >#{$item.invoice_id}</a>
                                    </small>{/if}
                                </span>
                            {elseif $item.status == 4}
                                <span class="Active">Billed</span>
                                {elseif $item.status == 2}
                                {if $item.queue_id}<span class="Pending" title="Billed with next client invoice">On next invoice</span>
                                {else}<span class="Pending" title="Billed when ticket is closed">On ticket close</span> 
                                {/if}
                            {else}<span class="Cancelled">{$lang.Cancelled}</span>
                            {/if}
                        </td>
                        <td>
                            {$item.admin}
                        </td>
                    </tr>
                    {foreachelse}
                        <tr>
                            <td colspan="9">{$lang.nothingtodisplay}</td>
                        </tr>
                {/foreach}
                {if !$ajax}
                </tbody>
                <tbody id="psummary">
                    <tr>
                        <th colspan="92">
                            {$lang.showing} <span id="sorterlow">{$sorterlow}</span> - <span id="sorterhigh">{$sorterhigh}</span> {$lang.of} <span id="sorterrecords">{$sorterrecords}</span>
                        </th>
                    </tr>
                </tbody>
            </table>
            <div class="blu clearfix">
                <div class="right"><div class="pagination"></div></div>
            </div>
        </form>
    {/if}
{elseif $action=="rates"}
    {if !$ajax}
        <div {if !$rates}style="display: none"{/if} id="ratelist">
            <input type="hidden" id="picked_tab" name="picked_tab" value="0">
            <form id="testform">
                <input type="hidden" value="{$totalpages}" name="totalpages2" id="totalpages"/>
                <a href="?cmd={$cmd}&action={$action}" id="currentlist" style="display:none" updater="#updater"></a>
                <table cellspacing="0" cellpadding="3" border="0" width="100%" class="table glike hover">
                    <thead>
                        <tr>
                            <th width="20"><input id="checkall" type="checkbox" /></th>
                            <th><a class="sortorder" href="?cmd={$cmd}&orderby=id|ASC">ID</a></th>
                            <th><a class="sortorder" href="?cmd={$cmd}&orderby=name|ASC">Name</a></th>
                            <th>Description</th>
                            <th width="160"><a class="sortorder" href="?cmd={$cmd}&orderby=price|ASC">Price</a></th>
                            <th width="50"></th>
                        </tr>
                    </thead>
                    <tbody id="updater">
                    {/if}
                    {foreach from=$rates item=rate}
                        <tr>
                            <td><input class="check" type="checkbox" name="selected[]" value="{$rate.id}" /></td>
                            <td><a href="?cmd={$cmd}&action=edit&id={$rate.id}" title="edit" onclick="track.editRate({$rate.id}); return false;">#{$rate.id}</a></td>
                            <td><a href="?cmd={$cmd}&action=edit&id={$rate.id}" title="edit" onclick="track.editRate({$rate.id}); return false;">{$rate.name}</a></td>

                            <td>{$rate.description|escape}</td>
                            <td>

                                {if $rate.type == 'flat'}
                                    {$rate.price|price:$currency}
                                {else}
                                    {$rate.price|price:$currency} per Hour
                                {/if}
                            </td>
                            <td>
                                <a onclick="return confirm('Are you sure you want to delete this entry?');" class="menuitm" href="?cmd={$cmd}&action=delete&id={$rate.id}&security_token={$security_token}"><span class="delsth"></span></a>
                            </td>
                        </tr>
                    {/foreach}
                    {if !$ajax}
                    </tbody>
                    <tbody id="psummary">
                        <tr>
                            <th colspan="92">
                                {$lang.showing} <span id="sorterlow">{$sorterlow}</span> - <span id="sorterhigh">{$sorterhigh}</span> {$lang.of} <span id="sorterrecords">{$sorterrecords}</span>
                            </th>
                        </tr>
                    </tbody>
                </table>
            </form>
            <div class="newhorizontalnav">
                <div class="list-2">
                    <div class="navsubmenu haveitems" style="display: block;">

                        <div class="right"><div class="pagination"></div></div>
                    </div>
                </div>
            </div>
        </div>
        <div class="blank_state blank_services" {if $rates}style="display: none"{/if} id="blanklist">
            <div class="blank_info">
                <h1>Ticket billing / time tracking</h1>
                You don't have any support rates defined yet, you will need to create at least one before you will be able to create support bills.
                <div class="clear"></div>
                {if !$forbidAccess.editSupportRates }
                    <a style="margin-top:10px" href="?cmd={$cmd}" class="new_add new_menu" onclick="track.newRate();
                            return false;">
                        <span>New Support rate</span>
                    </a>
                {/if}
                <div class="clear"></div>
            </div>
        </div>
    {/if}
{elseif $action=='add' || $action=='edit'}
    <div class="content" style="display: block;">
        <form method="post" action="?cmd={$cmd}&action={$action}" method="post" onsubmit="track.saveRate(this);
                return false;" id="saveform">
            <input type="hidden" name="save" value="1" />
            {if $entry.id}
                <input type="hidden" name="id" value="{$entry.id}" />
            {/if}
            <table width="100%" cellspacing="0" cellpadding="0" border="0">
                <tbody>
                    <tr>
                        <td id="s_menu" style="width: 200px">
                            <div id="initial-desc"><strong>Name</strong>
                                <br><small>Name will be used for invoice item description. </small>
                            </div><br>
                            <div id="initial-desc"><strong>Type</strong>
                                <br><small>Pricing type, either flat rate or price for each hour of work.</small>
                            </div><br>
                            <div id="initial-desc"><strong>Price</strong>
                                <br><small>Price for service that will be used for calculation.</small>
                            </div><br>
                            <div id="initial-desc"><strong>Description</strong>
                                <br><small>Describe this entry in few words, only visible in admin area.</small>
                            </div>
                        </td>
                        <td class="conv_content faceform" style="vertical-align: top">
                            <h3 style="margin-bottom:0px;">Add new support rate</h3><br>
                            <fieldset>
                                <legend>Name</legend>
                                <input type="text" name="name" value="{$entry.name}">
                            </fieldset>
                            <fieldset>
                                <legend>Type</legend>

                                <select name="type">
                                    <option value="hourly">Hourly rate</option>
                                    <option {if $entry.type=='flat'}selected{/if} value="flat">Flat rate</option>
                                </select>
                            </fieldset>
                            <fieldset>
                                <legend>Price</legend>
                                <div class="clear"></div>
                                <label>
                                    {$currency.sign} 
                                    <input type="text" name="price" value="{if $entry.price}{$entry.price|price:$currency:false}{else}{0|price:$currency:false}{/if}" size="4"/> 
                                    {if $currency.code}{$currency.code}
                                    {else}{$currency.iso}
                                    {/if}
                                </label>
                                <div class="clear"></div>
                            </fieldset>
                            <fieldset>
                                <legend>Description</legend>
                                <div class="clear"></div>
                                <textarea name="description" style="width: 98%">{$entry.description|escape}</textarea>
                                <div class="clear"></div>
                            </fieldset>
                        </td>
                    </tr>
                </tbody>
            </table>
            <div class="dark_shelf dbottom clear">
                <div class="left spinner">
                    <img src="ajax-loading2.gif">
                </div>
                <div class="right">
                    <span class="bcontainer ">
                        <a href="#" onclick="$('.spinner').show();
                                $('#saveform').submit();
                                return false;" class="new_control greenbtn">
                            <span>Save Changes</span>
                        </a>
                    </span>
                    <span>&nbsp;</span>
                    <span class="bcontainer">
                        <a href="#" onclick="$(document).trigger('close.facebox');
                                return false;" class="submiter menuitm">
                            <span>Close</span>
                        </a>
                    </span>
                </div>
                <div class="clear"></div>
                {securitytoken}
            </div>
        </form>
    </div> 
{elseif $action=='ticket'}
    {if $edit_bill}
        {foreach from=$items item=entry}
            {if $entry.id == $edit_bill}
                <td colspan="5">
                    <div id="ticketbilsedit" style="margin-left: -15px; margin-right: -5px;">
                        <div class="col-lg-2 col-sm-6">
                            <div class="form-group">
                                <label>Start time</label>
                                <div class="no-wrap">
                                    <input type="text" name="startdate" value="{$entry.startdate|default:$initial.date|dateformat:$date_format}"
                                           class="inp haspicker"
                                           placeholder="eg. {$initial.date|dateformat:$date_format}" style="width:90px">
                                    <input type="text" name="startime" value="{$entry.starttime|default:$initial.starttime}"
                                           class="timepicker inp"
                                           placeholder="eg. {$initial.starttime}" style="width:45px">
                                    <div class="inp-controls">
                                        <a class="btn btn-default btn-xs plus"><i class="fa fa-plus"></i></a>
                                        <a class="btn btn-default btn-xs minus"><i class="fa fa-minus"></i></a>
                                    </div>
                                </div>
                            </div>
                        </div>

                        <div class="col-lg-2 col-sm-6">
                            <div class="form-group">
                                <label>Finish time</label>
                                <div class="no-wrap">

                                    <input type="text" name="enddate" value="{$entry.enddate|default:$initial.date|dateformat:$date_format}"
                                           class="inp haspicker"
                                           placeholder="eg. {$initial.date|dateformat:$date_format}" style="width:90px">

                                    <input type="text" name="endtime" value="{$entry.endtime|default:$initial.endtime}"
                                           class="inp timepicker"
                                           placeholder="eg. {$initial.endtime}" style="width:45px">

                                    <div class="inp-controls">
                                        <a class="btn btn-default btn-xs plus"><i class="fa fa-plus"></i></a>
                                        <a class="btn btn-default btn-xs minus"><i class="fa fa-minus"></i></a>
                                    </div>

                                </div>
                            </div>
                        </div>
                        <div class="col-lg-4 col-sm-6">
                            <div class="form-group">
                                <label>Rate</label>
                                <select class="form-control chosenedge" name="rate_id">
                                    {foreach from=$rates item=rate}
                                        <option {if $entry.rate_id == $rate.id}selected="selected"{/if} value="{$rate.id}">
                                            {$rate.name} {if !$forbidAccess.viewSupportRates}({$rate.price|price:$currency:true:2:false}{if $rate.type == 'hourly'}/h{/if}) {/if}
                                        </option>
                                    {/foreach}
                                </select>
                            </div>
                        </div>
                        <div class="col-lg-3 col-sm-6">
                            <div class="form-group">
                                <label>Note</label>
                                <textarea name="note" class="form-control" style="height: 2.6em;">{$entry.note}</textarea>
                            </div>
                        </div>
                        <div class="col-lg-1 col-sm-12">
                            <div class="visible-lg-block"><label>&nbsp;</label></div>
                            <button class="btn btn-primary" onclick="ticket.saveBilling('{$edit_bill}');
                                    return false;">{$lang.Save}</button>
                        </div>
                        <input type="hidden" name="bill_id" value="{$entry.id}">
                    </div>
                </td>
                {break}
            {/if}
        {/foreach}
    {elseif $rates}
        <form action="?cmd={$cmd}&action={$action}" method="POST">
            <div class="table-responsive">
                <table class="table" border="0" cellpadding="0" cellspacing="0" width="100%" style="text-align: left">
                    <tbody>
                        <tr>
                            <th class="col-md-2">Time period</th>
                            <th >Details</th>
                            {if !$forbidAccess.viewSupportRates}<th>Price</th>{/if}
                            <th>Billing</th>
                            <th style=" width: 60px"></th>
                        </tr>
                        {foreach from=$items item=entry}
                            {if !$pendingitems && !$entry.status}
                                {assign value=true var=pendingitems}
                            {/if}
                            <tr>
                                <td>
                                    {if $entry.startdate == $entry.enddate}
                                        {$entry.startdate|dateformat:$date_format} 
                                        {$entry.starttime} - {$entry.endtime} 
                                    {else}
                                        {$entry.startdate|dateformat:$date_format}
                                        {$entry.starttime} -
                                        {$entry.enddate|dateformat:$date_format} 
                                        {$entry.endtime} 
                                    {/if}
                                    <br />
                                    <small>({$entry.diff|convert:'second'})</small></td>
                                <td>
                                    <div><strong>{$entry.name}</strong> {if !$forbidAccess.viewSupportRates}<small>({$entry.rate|price:$currency:true:2:false}{if $entry.type =='hourly'}/h{/if})</small>{/if}</div>
                                    <div><span>Added by:</span> {$entry.admin}</div>
                                    {if $entry.note}
                                        <div><span>Note:</span> {$entry.note}</div>
                                    {/if}
                                </td>
                                {if !$forbidAccess.viewSupportRates} <td>
                                    {if $entry.type == 'flat'}
                                        {$entry.rate|price:$currency}
                                    {else}
                                        {$entry.ratextime|price:$currency}
                                    {/if}
                                </td>{/if}
                                <td>
                                    {if !$entry.status}<span class="Draft">{$lang.Draft}</span>
                                    {elseif $entry.status == 1}
                                        <span class="Active">Invoiced 
                                           {if $item.invoice_id} <small>
                                               <a href="?cmd=invoices&action=edit&id={$item.invoice_id}&list=all" style="color: #4D89AB" >#{$item.invoice_id}</a>
                                               </small>{/if}
                                        </span>
                                    {elseif $entry.status == 4}
                                        <span class="Active">Billed</span>
                                    {elseif $entry.status == 2}
                                        {if $entry.queue_id}<span class="Pending" title="Billed with next client invoice">On next invoice</span>
                                        {else}<span class="Pending" title="Billed when ticket is closed">On ticket close</span> 
                                        {/if}
                                    {else}<span class="Cancelled">{$lang.Cancelled}</span>
                                    {/if}
                                </td>

                                <td>
                                    {if !$entry.status}
                                        <a href="#{$entry.id}" onclick="ticket.editBilling(this, '{$entry.id}');" class="btn btn-danger btn-xs"> <i class="fa fa-pencil"></i></a>
                                    {/if}
                                    {if $entry.cancellable}
                                        <a href="#{$entry.id}" class="btn btn-default btn-xs" 
                                           onclick="if (confirm('Are you sure you want to {if $entry.status}cancel{else}delete{/if} this entry?'))
                                                       ticket.delBilling('{$entry.id}');
                                                   return false;">
                                            {if $entry.status}
                                                <i class="fa fa-ban"></i>
                                            {else}
                                                <i class="fa fa-trash"></i>
                                            {/if}
                                        </a>
                                    {/if}
                                </td>
                            </tr>
                        {foreachelse}
                            <tr>
                                <td>
                                    {$lang.nothingtodisplay}
                                </td>
                                <td></td><td></td><td></td>
                            </tr>
                        {/foreach}
                    </tbody>
                </table>
            </div>
            <hr />
            <div class="row ">
                <div class="col-lg-2 col-sm-6">
                    <div class="form-group">
                        <label>Start time</label>
                        <div class="no-wrap">
                            <input type="text" name="startdate" value="{$submit.startdate|default:$initial.date|dateformat:$date_format}" 
                                   class="inp haspicker" 
                                   placeholder="eg. {$initial.date|dateformat:$date_format}" style="width:90px">
                            <input type="text" name="startime" value="{$submit.startimet|default:$initial.starttime}" 
                                   class="timepicker inp" 
                                   placeholder="eg. {$initial.starttime}" style="width:45px"> 
                            <div class="inp-controls">
                                <a class="btn btn-default btn-xs plus"><i class="fa fa-plus"></i></a>
                                <a class="btn btn-default btn-xs minus"><i class="fa fa-minus"></i></a>
                            </div>
                        </div>
                    </div>
                </div>

                <div class="col-lg-2 col-sm-6">
                    <div class="form-group">
                        <label>Finish time</label>
                        <div class="no-wrap">

                            <input type="text" name="enddate" value="{$submit.enddate|default:$initial.date|dateformat:$date_format}" 
                                   class="inp haspicker" 
                                   placeholder="eg. {$initial.date|dateformat:$date_format}" style="width:90px">

                            <input type="text" name="endtime" value="{$submit.endtime|default:$initial.endtime}" 
                                   class="inp timepicker" 
                                   placeholder="eg. {$initial.endtime}" style="width:45px">

                            <div class="inp-controls">
                                <a class="btn btn-default btn-xs plus"><i class="fa fa-plus"></i></a>
                                <a class="btn btn-default btn-xs minus"><i class="fa fa-minus"></i></a>
                            </div>

                        </div>
                    </div>
                </div>
                <div class="col-lg-4 col-sm-6">
                    <div class="form-group">
                        <label>Rate</label>
                        <select class="form-control chosenedge" name="rate_id">
                            {foreach from=$rates item=rate}
                                <option {if $submit.rate == $rate.id}selected="selected"{elseif $default_rate && $default_rate == $rate.id}selected="selected"{/if} value="{$rate.id}">
                                    {$rate.name} {if !$forbidAccess.viewSupportRates}({$rate.price|price:$currency:true:2:false}{if $rate.type == 'hourly'}/h{/if}) {/if}
                                </option>
                            {/foreach}
                        </select>
                    </div>
                </div>
                <div class="col-lg-3 col-sm-6">
                    <div class="form-group">
                        <label>Note</label>
                        <textarea name="note" class="form-control" style="height: 2.6em;">{if $details}#{$details.ticket_number} - {$details.subject}{/if}</textarea>
                    </div>
                </div>
                <div class="col-lg-1 col-sm-12">
                    <div class="visible-lg-block"><label>&nbsp;</label></div>
                    <button class="btn btn-default" onclick="ticket.addBilling();
                            return false;">{$lang.Add}</button>
                </div>

            </div>

            {if $pendingitems && !$forbidAccess.billPendingItems}
                <hr />
                <div class="row">
                    <div class="col-lg-5 col-sm-6 form-group">
                        <label>Bill pending items</label>
                        <select id="billtype" name="type" class="form-control" >
                            <option value="2">After closing ticket</option>
                            <option value="0">Immediately</option>
                            <option value="1">Add to next client invoice</option>
                        </select>
                    </div>
                    <div class="col-lg-5 col-sm-6 form-group" style="display: none" id="billingservices">
                        <label>Client Service</label>
                        <select  class="form-control chosenedge" >
                            <option value="0">{$lang.Any}</option>
                            {foreach from=$services item=service}
                                <option value="{$service.id}">#{$service.id} {$service.name}{if $service.domain} {$service.domain}{/if}</option>
                            {/foreach}
                        </select>
                    </div>
                    <div class="col-lg-2 col-sm-12 form-group" >
                        <label class="visible-lg-block">&nbsp;</label>
                        <button class="btn btn-default" onclick="ticket.startBilling($('#billtype').val(), $('#billingservices select').val());
                                return false;">Bill items</button>
                    </div>

                </div>
                {literal}
                    <script>
                        $('#billtype').on('change', function () {
                            $('#billingservices').toggle(this.value == 1)
                        })
                    </script>
                {/literal}
            {/if}
        </form>
        {if $init}
            <script type="text/javascript" src="{$template_dir}js/timepicker/jquery.timepicker.min.js?v={$hb_version}" ></script>
        {/if}
        <link media="all" rel="stylesheet" href="{$template_dir}js/timepicker/jquery.timepicker.css" />
        <script type="text/javascript" src="{$template_dir}js/tickettimetracking.js?v={$hb_version}" ></script>
    {else}
        <div class="blank_services">
            <div class="blank_info" style="padding: 10px;">
                <h1>Ticket billing / time tracking</h1>
                You don't have any support rates defined yet, you will need to create at least one before you will be able to create support bills.
                <div class="clear"></div>
                {if !$forbidAccess.editSupportRates }
                    <a style="margin-top:10px" href="?cmd={$cmd}" class="new_add new_menu" onclick="track.newRate();
                                return false;">
                        <span>New Support rate</span>
                    </a>
                {/if}
                <div class="clear"></div>
            </div>
        </div>
    {/if}
{elseif $action=="getadvanced"}
    <a href="?cmd=tickettimetracking&resetfilter=1"  {if $currentfilter}style="display:inline"{/if}  class="freseter">{$lang.filterisactive}</a>
    <form class="searchform filterform" action="?cmd=tickettimetracking" method="post" onsubmit="return filter(this)">
        {include file="_common/filters.tpl"}
        {securitytoken}
    </form>
    <script type="text/javascript">bindFreseter();</script>
{/if}
{if ($action=='ticket' && !$rates && 'acl:editSupportRates'|checkcondition) || $action=='rates'}
    {literal}
        <script type="text/javascript">
            var track = {
                newRate: function () {
                    $.facebox({ajax: "?cmd=tickettimetracking&action=add", width: 900, nofooter: true, opacity: 0.5, addclass: 'modernfacebox'});
                },
                editRate: function (id) {
                    $.facebox({ajax: "?cmd=tickettimetracking&action=edit&id=" + id, width: 900, nofooter: true, opacity: 0.5, addclass: 'modernfacebox'});
                },
                saveRate: function (form) {
                    var that = $(form);
                    $.post(that.attr('action'), that.serializeObject(), function (data) {
                        data = parse_response(data);
                        if (typeof ticket !== 'undefined' && typeof ticket.getBilling !== 'undefined') {
                            $(document).trigger('close.facebox');
                            ticket.getBilling();
                        }

                        $('#updater').html(data);

                        if ($('#updater tr').length) {
                            $('#ratelist').show();
                            $('#blanklist').hide();
                        }
                    })
                }
            }
        </script>
    {/literal}
{/if}