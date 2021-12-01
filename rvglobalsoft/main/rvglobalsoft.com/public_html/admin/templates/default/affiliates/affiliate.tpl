<script src="{$template_dir}/js/affiliates.js" type="text/javascript"></script>
<script src="{$template_dir}/js/chosen/chosen.min.js" type="text/javascript"></script>
<link rel="stylesheet" href="{$template_dir}/js/chosen/chosen.css">
{literal}
    <script>
        $(function () {
            $('select[name="invoice_id"]').chosensearch({
                width: "100%",
                url: '?cmd=search&action=single',
                placeholder_text: "Search for invoice",
                enable_split_word_search: true,
                search_contains: true,
                type: 'Invoices',
                args: {type: 'Invoices'},
            });
        })
    </script>
{/literal}
<div id="bodycont">
    <input type="hidden" id="affiliate_id" value="{$affiliate.id}"/>
    <div class="modal fade" tabindex="-1" role="dialog" id="batch-status">
        <form action="?cmd=affiliates&action=affiliate&id={$affiliate.id}" method="post">
            <input type="hidden" name="make" value="manualcommission"/>
            <div class="modal-dialog" role="document">
                <div class="modal-content">
                    <div class="modal-header">
                        <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span
                                    aria-hidden="true">&times;</span></button>
                        <h4 class="modal-title">Add manual commission</h4>
                    </div>
                    <div class="modal-body">
                        <div class="row">
                            <div class="form-group col-md-6">
                                <p>Enter related invoice id</p>
                                <select name="invoice_id" class="inp" style="width: 270px"></select>
                            </div>
                            <div class="form-group col-md-6">
                                <p>Commisson amount</p>
                                <input class="form-control" type="text" name="commission" value="0.00"/>
                            </div>
                        </div>
                        <div class="row">
                            <div class="form-group col-md-12">
                                <p>Public note</p>
                                <textarea class="form-control"  name="description" style="min-height: 70px;"></textarea>
                            </div>
                        </div>
                    </div>
                    <div class="modal-footer">
                        <button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
                        <button type="submit" class="btn btn-primary">Add Commission</button>
                    </div>
                </div><!-- /.modal-content -->
            </div>
            {securitytoken}
        </form>
    </div>

    <div class="modal fade" tabindex="-1" role="dialog" id="withdrawal_tab">
        <form action="?cmd=affiliates&action=affiliate&id={$affiliate.id}" method="post">
            <div class="modal-dialog" role="document">
                <div class="modal-content">
                    <div class="modal-header">
                        <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span
                                    aria-hidden="true">&times;</span></button>
                        <h4 class="modal-title">{$lang.makewithd}</h4>
                    </div>
                    <div class="modal-body">
                        <div class="form-group">
                            <label>{$lang.amount}</label>
                            <input class="form-control" type="text" value="{$affiliate.balance}" name="payout"/>
                        </div>
                        <div class="form-group">
                            <label>{$lang.Type}</label>
                            <select class="form-control" name="type">
                                <option value="0">{$lang.manualmode}</option>
                                <option value="1">{$lang.addtransaction}</option>
                                <option value="2">{$lang.addcredit|capitalize}</option>
                            </select>
                        </div>
                        <div class="form-group">
                            <label>{$lang.notes}</label>
                            <textarea class="form-control" name="note"></textarea>
                        </div>
                    </div>
                    <div class="modal-footer">
                        <button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
                        <button type="submit" name="withok" class="btn btn-primary">{$lang.makewithd}</button>
                    </div>
                </div><!-- /.modal-content -->
            </div>
            {securitytoken}
        </form>
    </div>

    <div class="modal fade" tabindex="-1" role="dialog" id="assign-client">
        <form action="?cmd=affiliates&action=affiliate&id={$affiliate.id}&assign" method="post">
            <div class="modal-dialog" role="document">
                <div class="modal-content">
                    <div class="modal-header">
                        <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span
                                    aria-hidden="true">&times;</span></button>
                        <h4 class="modal-title">Assign client</h4>
                    </div>
                    <div class="modal-body">
                        <div class="form-group">
                            <label>Select client to assign.</label>
                            <select class="form-control" name="client_id"></select>
                            <div class="help-block"></div>
                        </div>
                    </div>
                    <div class="modal-footer">
                        <button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
                        <button type="submit" class="btn btn-primary client-assign">Assign</button>
                    </div>
                </div><!-- /.modal-content -->
            </div>
            {securitytoken}
        </form>
    </div>

    <div class="blu">
        <a href="?cmd=affiliates"><strong>{$lang.backtoaffi}</strong></a>
        <a href="#" onclick="$('#affiliateform').submit();
                return false;" class="menuitm"><span>{$lang.savechanges}</span></a>
        <a href="#" class="menuitm" data-toggle="modal" data-target="#batch-status">Add commission</a>
        <a class="menuitm clDropdown" id="hd1" onclick="return false;" href="#"><span class="morbtn">More actions</span></a>
        <ul class="ddmenu" id="hd1_m">
            <li>
                <a onclick="$('#withdrawal_tab').modal('show');
                    return false;" href="#">{$lang.makewithd}</a>
            </li>
            <li>
                <a class="directly"
                   href="?cmd=affiliates&action=toggle&id={$affiliate.id}&security_token={$security_token}">
                    {if $affiliate.status == 'Active'}
                        Disable Affiliate
                    {else}
                        Enable Affiliate
                    {/if}
                </a>
            </li>
            <li>
                <a onclick="confirm('{$lang.affdelconf}') && (window.location = '?cmd=affiliates&make=delete&id={$affiliate.id}&security_token={$security_token}');
                        return false;"
                   href="#AffDelete"> Delete Affiliate</a>
            </li>

        </ul>
    </div>
    <div id="ticketbody">
        <h1>{$lang.affiliatehash}{$affiliate.id} {$affiliate.firstname} {$affiliate.lastname}</h1>
        <div id="client_nav">
            <!--navigation-->
            <a class="nav_el nav_sel left" href="#">{$lang.affdetails}</a>
            {include file="_common/quicklists.tpl" _client=$affiliate.client_id}
            <div class="clear"></div>
        </div>

        <div class="ticketmsg ticketmain" id="client_tab">
            <div class="slide" style="display:block">
                <form action='' method='post' id="affiliateform">
                    <table cellspacing="2" cellpadding="3" border="0" width="100%">
                        <tbody>
                            <tr>
                                <td style="width: 15%; text-align: right">{$lang.affiliatehash}</td>
                                <td>#{$affiliate.id}</td>
                                <td style="width: 15%; text-align: right">{$lang.pendingcom}</td>
                                <td>{$pending|price:$affiliate.currency_id}</td>
                            </tr>
                            <tr>
                                <td style="width: 15%; text-align: right">{$lang.Client}</td>
                                <td>
                                    <a href="?cmd=clients&action=show&id={$affiliate.client_id}">{$affiliate.firstname} {$affiliate.lastname}</a>
                                </td>

                                <td style="width: 15%; text-align: right">{$lang.affsince}</td>
                                <td>{$affiliate.date_created|dateformat:$date_format}</td>
                            </tr>
                            <tr>
                                <td style="width: 15%; text-align: right">{$lang.status}</td>
                                <td><span class="{$affiliate.status}">{$lang[$affiliate.status]}</span></td>

                                <td style="width: 15%; text-align: right">{$lang.convrate}</td>
                                <td>{$affiliate.conversion} %</td>

                            </tr>
                            <tr>
                                <td style="width: 15%; text-align: right">{$lang.visitors}</td>
                                <td><input size="3" value="{$affiliate.visits}" name="visits"/></td>

                                <td style="width: 15%; text-align: right">{$lang.withdrawn}</td>
                                <td>
                                    <input size="3" value="{$affiliate.total_withdrawn}" name="total_withdrawn"/>
                                </td>
                            </tr>
                            <tr>
                                <td style="width: 15%; text-align: right">Parent Affiliate</td>
                                <td>
                                    <select name="parent_id">
                                        <option value="0"> -</option>
                                        {foreach from=$affiliates item=aff}
                                            {if $aff.id != $affiliate.id}
                                                <option value="{$aff.id}"
                                                        {if $affiliate.parent_id==$aff.id}selected="selected"{/if} >
                                                    #{$aff.id} {$aff.firstname} {$aff.lastname}
                                                </option>
                                            {/if}
                                        {/foreach}
                                    </select>
                                </td>

                                <td style="width: 15%; text-align: right">Auto Withdraw</td>
                                <td>
                                    <select name="withdraw_method">
                                        <option {if $affiliate.withdraw_method==0}selected="selected"{/if} value="0">
                                            Disabled
                                        </option>
                                        <option {if $affiliate.withdraw_method==1}selected="selected"{/if} value="1">
                                            Mailed Check
                                        </option>
                                        <option {if $affiliate.withdraw_method==2}selected="selected"{/if} value="2">
                                            Account Credit
                                        </option>
                                    </select>
                                </td>

                            </tr>
                            <tr>
                                <td style="width: 15%; text-align: right;">{$lang.commissions}</td>
                                <td>
                                    <input size="3" value="{$affiliate.total_commissions}" name="total_commissions" {if !$editCommissionBalance}readonly="readonly"{/if}/>
                                </td>
                                <td style="width: 15%; text-align: right; vertical-align: top; line-height: 23px"
                                    rowspan="2">Available Commission plans
                                </td>
                                <td rowspan="2" style="vertical-align: top">
                                    <select name="commision_plans[]" {if $AffMultiplePlans}multiple="multiple"
                                            size=3{/if} style="min-width:200px">
                                        {if $AffMultiplePlans}
                                            <option value="all"
                                                    {if !$affiliate.commision_plans}selected="selected"{/if}>All
                                                Commission plans
                                            </option>
                                        {/if}
                                        {foreach from=$commisionsplans item=cp}
                                            <option value="{$cp.id}"
                                                    {if in_array($cp.id, $affiliate.commision_plans)}selected="selected"{/if}>{$cp.name}</option>
                                        {/foreach}
                                    </select>
                                </td>
                            </tr>
                            <tr>
                                <td style="width: 15%; text-align: right;">{$lang.balance} <span class="vtip_description" title="{$lang.balance} = {$lang.commissions} - {$lang.withdrawn}"></span></td>
                                <td>
                                    <input size="3" value="{$affiliate.balance}" name="balance" readonly="readonly"/>
                                </td>
                            </tr>
                            <tr>
                                <td style="width: 15%; text-align: right">{$lang.affiliateurl}</td>
                                <td><input value="{$system_url}?affid={$affiliate.id}" readonly="readonly"
                                           style="width:300px"/></td>

                            </tr>
                            <tr>
                                <td style="width: 15%; text-align: right; vertical-align: top">
                                    {$lang.AffLandingPage}
                                </td>
                                <td>
                                    <input value="{$landingurl}" name="landingurl" type="text"
                                           style="width:300px"/><br/>
                                    <input id="landingurl_disable" type="checkbox" name="landingurl_disable" value="1"
                                           {if $landingurl_disabled}checked{/if} />
                                    Disable landing page redirect for this affiliate
                                    <br/>
                                </td>
                            </tr>
                        <tr>
                            <td></td>
                            <td>
                                <input id="domainverification_disable" type="checkbox" name="options[1]" value="1"
                                       {if $affiliate.options & 1}checked{/if} />
                                Disable domain verification check for this affiliate landing page
                                <br/>
                            </td>
                        </tr>
                        </tbody>
                    </table>
                    <input type="hidden" value="{$lang.savechanges}" name="savechanges"/>
                    {securitytoken}
                </form>
            </div>

            {include file="_common/quicklists.tpl" _placeholder=true}
        </div>
        <div style="padding: 0 5px 5px 0">
            <a href="#" onclick="$('#affiliateform').submit();
                    return false;" class="menuitm"><span>{$lang.savechanges}</span></a>

            <a href="#" class="menuitm" data-toggle="modal" data-target="#batch-status">Add commission</a>
            <a class="menuitm clDropdown" id="hd1" onclick="return false;" href="#"><span class="morbtn">More
                    actions</span></a>

        </div>
    </div>

</div>

<div class="row no-gutter" style="margin-top: 20px">

    <div class="col-md-6 mainleftcol">
        <div class="box ">
            <div class="box-header">
                <div class="pull-right">
                    <a href="#" class="btn btn-success btn-xs" data-toggle="modal" data-target="#withdrawal_tab"><i
                                class="fa fa-usd"></i> {$lang.makewithd}</a>
                </div>
                <h3 class="box-title">
                    <i class="fa fa-clock-o"></i>
                    {$lang.withhistory}
                </h3>
            </div>
            <div class="box-body">

                <table width="100%" cellspacing="0" cellpadding="3" border="0" style="" class="table glike">
                    <tbody>
                        {if $withdrawals}
                            <tr>
                                <th width="130">{$lang.Date}</th>
                                <th width="160">{$lang.amount}</th>
                                <th>{$lang.notes}</th>
                                <th width="20"></th>
                            </tr>
                            {foreach from=$withdrawals item=wid}
                                <tr>
                                    <td width="130">{$wid.date|dateformat:$date_format}</td>
                                    <td>{$wid.amount|price:$affiliate.currency_id}</td>
                                    <td>{$wid.note}</td>
                                    <td>
                                        <a href="?cmd=affiliates&action=affiliate&id={$affiliate.id}&removelog={$wid.id}&security_token={$security_token}"
                                           class="btn btn-danger btn-xs"
                                           onclick="return confirm('{$lang.confirmloga}')"><span
                                                    class="fa fa-trash-o"></span></a>
                                    </td>
                                </tr>
                            {/foreach}
                        {else}
                            <tr>
                                <td>
                                    <center>{$lang.nothingtodisplay}</center>
                                </td>
                            </tr>
                        {/if}

                    </tbody>
                </table>
            </div>
        </div>
    </div>
    <div class="col-md-6 mainrightcol">
        <div class="box ">
            <div class="box-header">
                <div class="pull-right">
                    <a class="btn btn-default btn-xs" data-toggle="modal" data-target="#assign-client"><span
                                class="fa fa-plus"></span> Add Client</a>
                </div>
                <h3 class="box-title">
                    <i class="fa fa-users"></i>
                    Assigned Clients
                </h3>
            </div>
            <div class="box-body">
                <table width="100%" cellspacing="0" cellpadding="3" border="0" style="" class="table glike">
                    <tbody>
                        {if $clients}
                            <tr>
                                <th width="130">ID</th>
                                <th>{$lang.Client}</th>
                                <th>Assigned by</th>
                                <th width="20"></th>
                            </tr>
                            {foreach from=$clients item=client}
                                <tr>
                                    <td width="130"><a
                                                href="?cmd=clients&action=show&id={$client.client_id}">#{$client.client_id}</a>
                                    </td>
                                    <td>
                                        <a href="?cmd=clients&action=show&id={$client.client_id}">{$client.firstname} {$client.lastname}</a>
                                    </td>
                                    <td>{$client.by}</td>
                                    <td>
                                        <a href="?cmd=affiliates&action=affiliate&id={$affiliate.id}&unassign={$client.client_id}&security_token={$security_token}"
                                           class="btn btn-danger btn-xs"><span class="fa fa-trash-o"></span></a></td>
                                </tr>
                            {/foreach}
                        {else}
                            <tr>
                                <td>
                                    <center>{$lang.nothingtodisplay}</center>
                                </td>
                            </tr>
                        {/if}

                    </tbody>
                </table>
            </div>
        </div>
    </div>
    <div class="col-md-12">
        <div class="box box-commissions">
            <div class="box-header">
                <h3 class="box-title">
                    <i class="fa fa-line-chart pull-left"></i>
                    {$lang.commissions}
                </h3>
                <div class="pull-right">
                    <div class="pull-left" style="margin-right: 20px;">
                        <a href="?cmd={$cmd}&action=getadvanced&subaction=orders" class="btn {if $currentfilter}btn-danger{else}btn-default{/if} btn-xs btn-is-filter" style="margin-right: 10px" onclick="return FilterAffiliateModal.modal('affiliatesfilter',this);">
                            <i class="fa fa-search-plus"></i> Filter Data
                        </a>
                        <div class="modal fade" id="affiliatesfilter" tabindex="-1" role="dialog"  aria-hidden="true" data-url="?cmd=affiliates&action=orders&id={$affiliate.id}">
                            <div class="modal-dialog">
                                <div class="modal-content">
                                    <div class="modal-header">
                                        <button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
                                        <h4 class="modal-title">Search / Filter</h4>
                                    </div>
                                    <div class="modal-body" ></div>
                                    <div class="modal-footer">
                                        <button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
                                        <button type="button" class="btn btn-primary" onclick="return FilterAffiliateModal.submit('affiliatesfilter');">Apply filter</button>
                                        <button type="button" class="btn btn-danger" onclick="return FilterAffiliateModal.reset('affiliatesfilter');" {if !$currentfilter}style="display: none"{/if}>Reset filter</button>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                    <div class="pull-left">
                        <span style="font-weight: normal; font-size: 11px; color: rgb(83, 83, 83);"><span style="margin-top: 4px;" class="pord"></span>&nbsp; {$lang.paidcommissions}</span>
                    </div>
                </div>
            </div>

            <div class="box-body">
                <a href="?cmd={$cmd}&action=orders&id={$affiliate.id}" id="currentlist" style="display:none" updater="#updater"></a>
                <input type="hidden" value="{$totalpages}" name="totalpages2" id="totalpages"/>

                <div class="clearfix" style="padding-bottom:5px">
                    <div class="pagination"></div>
                </div>

                <table width="100%" cellspacing="0" cellpadding="3" border="0" class="table glike"
                       style="line-height: 20px;" id="afforders">
                    <thead>
                        <tr>
                            <th style="width: 50px">ID</th>
                            <th style="width: 130px">{$lang.signupdate}</th>
                            <th>{$lang.Client}</th>
                            <th>Type</th>
                            <th>{$lang.commission}</th>
                            <th style="width: 180px">Status</th>
                            <th>Public note</th>
                            <th></th>
                        </tr>
                    </thead>

                    <tbody id="updater" class="orders_updater">
                        {if $orders}
                            {include file="affiliates/ajax.affiliate_orders.tpl"}
                        {else}
                            <tr>
                                <td colspan="7">
                                    {$lang.nothingtodisplay}
                                </td>
                            </tr>
                        {/if}
                    </tbody>
                    <tbody id="psummary">
                        <tr>
                            <th></th>
                            <th colspan="7">
                                {$lang.showing}
                                <span id="sorterlow">{$sorterlow}</span> - <span
                                        id="sorterhigh">{$sorterhigh}</span> {$lang.of} <span
                                        id="sorterrecords">{$sorterrecords}</span>
                            </th>
                        </tr>
                    </tbody>
                </table>
                <div class="pagination"></div>
            </div>
        </div>
    </div>
    <script src="templates/default/dist/plugins/chartjs/Chartjs.min.js"></script>
    {foreach from=$widgets item=widget name=widgets}
        <div class="col-md-6 {if $smarty.foreach.widgets.index % 2} mainrightcol{else} mainleftcol{/if}">
            {include file="affiliates/affiliate_widget.tpl" widget=$widget}
        </div>
    {/foreach}
</div>
<div class="blu">
    <a href="?cmd=affiliates"><strong>{$lang.backtoaffi}</strong></a>
    <a href="#" onclick="$('#affiliateform').submit();
            return false;" class="menuitm"><span>{$lang.savechanges}</span></a>
    <a class="menuitm clDropdown" id="hd1" onclick="return false;" href="#"><span class="morbtn">More actions</span></a>
</div>

<div id="ReviewComission" style="display:none;" bootbox data-title="Review Commission">
    <form method="POST" action="">
        <input type="hidden" name="acceptref" value="" id="acceptref">
        <div class="form-group" id="affamount">
            <label>Commission Amount</label>
            <div class="input-group">
                <input type="text" value="0" name="amount" class="form-control"/>
                <span class="input-group-addon">{$affiliate.currency.iso}</span>
            </div>
        </div>
        {securitytoken}
    </form>
    <div id="affdetails">
        <p><i class="fa fa-spin fa-spinner"></i> Loading order details ..</p>
    </div>
</div>
<div id="ComissionDetails" style="display:none;" bootbox data-title="Commission Details">
    <div id="affdetails">
        <p><i class="fa fa-spin fa-spinner"></i> Loading order details ..</p>
    </div>
</div>


