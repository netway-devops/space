<div id="confirm_cacc_close" hidden bootbox data-title="{$lang.closeheading}" data-btnclass="btn-danger">

    <form action="?cmd=clients&make=close" method="post">
        <p><strong>{$lang.closedescr}</strong></p>

        <input type="radio" checked="checked" name="hardclose" value="true" id="cc_hard"/> {$lang.closeopt1}<br/>
        <input type="radio" name="hardclose" value="false" id="cc_soft"/> {$lang.closeopt2}<br/>

        <input type="hidden" name="id" value="{$client.id}"/>
        {securitytoken}
    </form>

</div>

<div id="confirm_cacc_archive" hidden bootbox data-title="{$lang.archiveheading}" data-btnclass="btn-danger">

    <form action="?cmd=clients&action=archive" method="post">
        <div>
            Using this function will result in:
            <ul>
                <li>marking unpaid client invoices as cancelled</li>
                <li>suspending & canceling client services</li>
                <li>closing client tickets</li>
            </ul>
        </div>
        <input type="hidden" name="id" value="{$client.id}"/>
        {securitytoken}
    </form>
</div>

<div id="confirm_cacc_anonymize" hidden bootbox data-title="{$lang.anonymizeheading}" data-btnclass="btn-danger">

    <form action="?cmd=clients&action=anonymize" method="post">
        <div>
            Using this function will result in:
            <ul>
                <li>closing client profile</li>
                <li>terminating client services</li>
                <li>clearing client changes log, emails and tickets</li>
                <li>removing ALL non-billing data</li>
            </ul>
        </div>
        <input type="hidden" name="id" value="{$client.id}"/>
        {securitytoken}
    </form>

</div>

<div id="confirm_cacc_delete" hidden bootbox data-title="{$lang.deleteheading}" data-btnclass="btn-danger">

    <form action="?cmd=clients&make=delete" method="post">
        <p><strong>{$lang.deletedescr}</strong></p>

        <input type="radio" checked="checked" name="harddelete" value="true"/> {$lang.deleteopt1}<br/>
        <input type="radio" name="harddelete" value="false"/> {$lang.deleteopt2}<br/>


        <input type="hidden" name="id" value="{$client.id}"/>
        {securitytoken}
    </form>

</div>
<div id="adjust_credit_balance" hidden bootbox data-title="Edit Credit Balance" data-btntitle="{$lang.savechanges}" data-btnclass="btn-primary">

    <form action="?cmd=clients&action=adjustcredit" method="post">

        <div class="form-group">
            <label>Set client credit to:</label>
            <input type="text" class="form-control" name="credit" value="{$client.credit}" />
        </div>
        <input type="hidden" name="id" value="{$client.id}"/>
        {securitytoken}
    </form>

</div>

<div id="gdpr_request" hidden bootbox data-title="Details Request" data-btntitle="Download" data-btnclass="btn-primary">

    <form action="?cmd=clients&action=pdfdetails" method="post">
        <div class="form-group">
            <label>This information was requested by</label>
            <input type="text" class="form-control" name="name"/>
        </div>
        <div class="form-group">
            <label>Purpose</label>
            <textarea class="form-control" name="purpose"></textarea>
        </div>
        <input type="hidden" name="id" value="{$client.id}"/>
        {securitytoken}
    </form>

</div>

<div id="confirm_curr_change" hidden bootbox data-title="{$lang.currheading}" data-callback="confirmsubmit"
     data-btnclass="btn-primary">

    <div>
        <p><strong>{$lang.currdescr}</strong></p>

        <div id="conf_c_b_1">
            <input type="radio" checked="checked" name="curchange" value="recalculate"/> {$lang.curropt1}<br/>
            <input type="radio" name="curchange" value="change"/> {$lang.curropt2}<br/>
        </div>


    </div>
    <script type="text/javascript">
        {literal}
        function confirmsubmit() {
            var val = $('.bootbox-body input[name=curchange]:checked').val();
            $('#clientform').append('<input type="hidden" name="curchange" value="' + val + '" />');
            $('#clientform').unbind('submit');
            $('#clientsavechanges').click();
        }

        {/literal}
    </script>
</div>

<form action='' method='post' id="clientform" enctype="multipart/form-data">

    <div id="bodycont">

        <div class="blu">
            <div class="menubar">
                <a href="?cmd=clients"><strong>&laquo; {$lang.backtoallcl}</strong></a>
                {*if isset($admindata.access.editClients)*}
                <a onclick="$('.nav_el').eq(0).click();
                        $('#tdetail a').click();
                        return false;" class="menuitm" href="#">
                    <span>{$lang.editclientdetails}</span>
                </a>

                {if $admindata.access.loginAsClient}
                    <a class=" menuitm menu-auto" href="{$system_url2}?action=adminlogin&id={$client.client_id}"
                       target="_blank">
                        <span><strong>{$lang.loginasclient}</strong></span>
                    </a>
                {/if}
                <a class="menuitm menu-auto" onclick="$('#ccinfo').toggle();
                        return false" href="#">
                    <span>{$lang.ccardach}</span>
                </a>
                <a class="menuitm clDropdown menu-auto" id="hd1" onclick="return false" href="#">
                    <span class="morbtn">{$lang.moreactions}</span>
                </a>

                <ul id="hd1_m" class="ddmenu">
                    <li><a href="EditNotes">{$lang.editclientnotes}</a></li>
                    <li><a href="OpenTicket">{$lang.opennewticket}</a></li>
                    <li><a href="PlaceOrder">{$lang.PlaceOrder}</a></li>
                    <li><a href="CreateInvoice">{$lang.CreateInvoice}</a></li>
                    {if !$client.affiliate_id}
                        <li><a href="EnableAffiliate">{$lang.EnableAffiliate}</a></li>
                    {/if}
                    <li><a href="DetailsRequest">{$lang.GDPRDetailsRequest}</a></li>
                    <li><a href="SendNewPass">{$lang.SendNewPass}</a></li>
                    <li><a href="CloseAccount">{$lang.CloseAccount}</a></li>
                    <li><a href="ArchiveAccount">{$lang.ArchiveAccount}</a></li>
                    <li><a href="AnonymizeAccount">{$lang.AnonymizeAccount}</a></li>
                    <li><a href="DeleteAccount" style="color:#ff0000">{$lang.DeleteProfile}</a></li>
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
                {adminwidget module="clients" section="profileheader"}
            </div>
        </div>


        <input type="hidden" value="{$client.currency_id}" name="old_currency_id" id="old_currency_id"/>

        {if count($currencies)<=1}
            <input type="hidden" id="currency_id" value="{$client.currency_id}" />
        {/if}

        <input type="hidden" value="{$client.client_id}" name="id" id="client_id"/>

        <div class="lighterblue" style="padding:5px;display:none" id="ccinfo">
            {if !$admindata.access.viewCC && !$admindata.access.editCC}
                {$lang.lackpriviliges}
            {else}
                {if $client.cardnum!='' || $ach.account}
                    <div id="cc_cont" style="min-height: 2em">
                        <div class="left">
                            <strong>{$lang.ccard}</strong> {if $admindata.access.viewCCLog}<a href="?cmd=logs&action=ccardlog&filter[client_id]={$client.id}" target="_blank">View log</a>{/if}<br/>
                            {include file='ajax.clients.tpl' action=ccshow cmake=ccshow cardcode=$client verify=1}
                            <div class="o1" style="padding: 5px 0">
                                {if $admindata.access.editCC}
                                    <a href="#" onclick="return load_cc_verify('ccadd');"
                                       class="menuitm">{$lang.editcardnumber}</a>
                                {elseif $admindata.access.viewCC}
                                    <a href="#" onclick="return load_cc_verify('ccshow');"
                                       class="menuitm">{$lang.viewcardnumber}</a>
                                {/if}
                    {if $admindata.access.viewCCLog}
                        <a href="?cmd=logs&action=ccardlog&filter[client_id]={$client.id}&resetfilter=1"  target="_blank"  class="menuitm">Card Changes Log</a>
                        {/if}
                            </div>

                        </div>
                        <div class="left" style="margin-left:60px;">
                            <strong>{$lang.ACHecheck}</strong><br/>
                            {include file='ajax.clients.tpl' action=achshow cmake=achshow cardcode=$ach verify=1}

                            <div class="o1" style="padding: 5px 0">
                                {if $admindata.access.editCC}
                                    <a href="#" onclick="return load_cc_verify('achadd');" class="menuitm">Update bank
                                        account</a>
                                {elseif $admindata.access.viewCC}
                                    <a href="#" onclick="return load_cc_verify('achshow');" class="menuitm">View bank
                                        account</a>
                                {/if}
                            </div>
                        </div>
                        <div style="clear:both"></div>

                        <div class="o2" style="display:none; padding: 5px 0">
                            {$lang.provideyourpassword}
                            <input type="password" autocomplete="off" name="admin_pass" id="admin_pass"/>
                            <input type="button" id="ccbutton"
                                   data-action="{if $admindata.access.editCC}ccadd{else}ccshow{/if}"
                                   onclick="return verify_pass({if $admindata.access.editCC}'ccadd'{else}'ccshow'{/if})"
                                   value="{$lang.submit}" style="font-weight:bold"/>
                        </div>
                    </div>
                {else}
                    <div id="cc_cont" style="min-height: 2em">
                        <div class="o1">
                            This client do not have credit card nor bank account added <br/>
                            {if $admindata.access.editCC}
                                <a href="#" onclick="return add_cc();">Click to add Credit Card</a>
                                |
                                <a href="#" onclick="return add_ach();">Click to add Bank Account</a>
                            {/if}
                        </div>
                        {if $admindata.access.editCC}
                            <div class="o2" style="display:none"></div>
                        {/if}
                    </div>
                {/if}
            {/if}

            <script type="text/javascript">
                {literal}
                function verify_pass(act) {
                    act = $('#ccbutton').attr('data-action');
                    //act = act || 'ccard';
                    if ($('#admin_pass').val() == '')
                        $('#admin_pass').val('none');
                    $('#cc_cont').addLoader();
                    ajax_update('?cmd=clients', {
                        action: act,
                        client_id: $('#client_id').val(),
                        passprompt: $('#admin_pass').val()
                    }, '#cc_cont');
                    return false;
                }

                function edit_cc() {
                    return add_cc();
                }

                function load_cc_verify(action) {
                    $('#cc_cont .o1').hide();
                    $('#ccbutton').attr('data-action', action)
                    $('#cc_cont .o2').show();
                    return false;
                }

                function view_cc() {

                }

                function add_cc() {
                    $('#cc_cont .o1').hide();
                    $('#cc_cont').addLoader();
                    ajax_update('?cmd=clients&action=ccadd', {client_id: $('#client_id').val()}, '#cc_cont');
                    return false;
                }

                function add_ach() {
                    $('#cc_cont .o1').hide();
                    $('#cc_cont').addLoader();
                    ajax_update('?cmd=clients&action=achadd', {client_id: $('#client_id').val()}, '#cc_cont');
                    return false;
                }

                $(document).on('keydown', '#admin_pass', function (e) {
                    if (e.keyCode == 13) {
                        verify_pass();
                        return false;
                    }
                })
                {/literal}
            </script>
        </div>
        {if $picked_tab}
            <script type="text/javascript">
                {literal}
                function fireme() {
                    $('#{/literal}{$picked_tab}{literal}_tab').click();
                }

                appendLoader('fireme');
                {/literal}
            </script>
        {/if}
        <div id="ticketbody">

            {if $ccard_banned}
                <div class="alert alert-warning">
                    Client credit card was declined multiple times and is currently disabled from automated payments.
                    {if $admindata.access.editCC}
                        <a href="?cmd=logs&action=declinedcards&filter[client_id]={$client.id}&resetfilter=1"
                           target="_blank">View Logs</a>
                    {/if}
                    {if $admindata.access.editCC}
                        <br>
                        <a href="?cmd=clients&action=ccardunban&id={$client.id}&security_token={$security_token}">
                            Enable automatic payments
                        </a>
                    {/if}
                </div>
            {/if}

            <h1>
                #{$client.client_id} {$client.companyname} {if $client.firstname || $client.lastname} - {/if} {$client.firstname} {$client.lastname}</h1>
            <div id="client_nav">
                <!--navigation-->
                <a class="nav_el nav_sel left" href="#">{$lang.clientprofile}</a>
                {include file="_common/quicklists.tpl" _client=$client.client_id _parent=$client.parent_id}

                <div class="clear"></div>
            </div>

            <div class="ticketmsg ticketmain" id="client_tab">

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

                <div class="slide" style="display:block">
                    <div class="" id="tdetail" style="display: none"><a href="#"><!-- legacy --></a></div>

                    <div id="detcont" style="padding:10px 0px">
                        <div class="tdetails">
                            {include file='clients/_drawprofile.tpl'}

                            <div class="row">
                                <div class="col-md-12" style="text-align: center;">
                                    <a href="#" onclick="$('#tdetail a').click(); return false;" class="btn btn-primary">Edit client details</a>
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
                {include file="_common/quicklists.tpl" _placeholder=true}
            </div>

            <div class="row" style="color: #777">
                <div class="col-md-4"><label>{$lang.signupdate}:</label> {$client.datecreated|dateformat:$date_format}</div>
                <div class="col-md-6"><label>{$lang.clientlastlogin}:</label> {if $client.lastlogin == '0000-00-00 00:00:00'}{$lang.never}{else}{$client.lastlogin|dateformat:$date_format}{/if} {$lang.From} {$client.ip} {$lang.Host}: {$client.host}</div>

            </div>


            {securitytoken}
        </div>
    </div>
    <div class="row no-gutter" style="margin-top:20px;">

        <div class="col-md-6 mainleftcol">

            <div class="box box-primary  " style="min-height: 73px;">
                <div class="box-header">
                    <h3 class="box-title">Client notes <i class="fa fa-sticky-note-o pull-left"></i></h3>

                </div>
                <div class="box-body">
                    <div id="clientnotes">
                        {include file='_common/noteseditor.tpl'}

                    </div>
                </div>
            </div>

            <div class="box box-primary ">
                <div class="box-header">
                    <div class="pull-right">

                    </div>
                    <h3 class="box-title">Settings & Automation <i class="fa fa-cog pull-left"></i></h3>
                </div>
                <div class="box-body">
                {include file="clients/settings.tpl"}
                </div>
                <div class="box-footer clearfix no-border box-footer-transparent">
                    {if !$forbidAccess.editClients}
                        <a class="btn btn-default btn-sm" href="?cmd=clients&action=overrides&id={$client.id}">
                            Edit client automation settings
                        </a>
                    {/if}
                    {if !$forbidAccess.manageClientGroups}
                        {if $client.group_id}<a class="btn btn-default btn-sm" href="?cmd=clients&action=editgroup&id={$client.group_id}" target="_blank">
                                Edit group settings
                            </a>{/if}
                    {/if}
                    <div class="bborder-legend"><span class="bg-warning"></span> Group overrides</div>
                    <div class="bborder-legend"><span class="bg-danger"></span> Client overrides</div>

                </div>
            </div>

            {if !$forbidAccess.clientBalance}
                <div class="box box-primary  ">
                <div class="box-header">
                    <h3 class="box-title">Client balance <i class="fa fa-money pull-left"></i></h3>
                </div>
                <div class="box-body">
                    <div>

                        <div class="row" style="margin-bottom: 20px;">

                            <div class="col-sm-4">
                                <div class="stat-item">
                                    <span><strong>{$lang.Credit}</strong></span>
                                    <div class="stat-data "><span class="Paid">{$client.credit|price:$stats.currency_id}</span></div>
                                </div>
                            </div>
                            <div class="col-sm-4">
                                <div class="stat-item">
                                    <span><strong>{$stats.unpaid}</strong> {$lang.invoicesdue}</span>
                                    <div class="stat-data "><span class="Unpaid">{$stats.invoice_unpaid|price:$stats.currency_id}</span></div>
                                </div>
                            </div>
                            <div class="col-sm-4">
                                <div class="stat-item">
                                    <span><strong>{$stats.paid}</strong> {$lang.invoicespaid}</span>
                                    <div class="stat-data Paid"><span class="Paid">{$stats.invoice_paid|price:$stats.currency_id}</span></div>
                                </div>
                            </div>



                        </div>





                    </div>
                </div>
                    <div class="box-footer clearfix no-border box-footer-transparent">
                        {if !$forbidAccess.editClientsCredit}
                            <a id="edit-credit-balance" class="btn btn-primary btn-sm" href="#" onclick="$('#adjust_credit_balance').trigger('show'); return false;">
                                Edit Credit Balance
                            </a>
                        {/if}

                        <div class="pull-right">
                            <a class="btn btn-default btn-sm" href="?cmd=transactions&amp;action=add&amp;related_client_id={$client_id}"><i class="fa fa-plus"></i> {$lang.addcredit|capitalize}</a>
                            <a class="btn btn-default btn-sm " href="?cmd=clientcredit&filter[client_id]={$client_id}&resetfilter=1" target="_blank">Credit Log</a>

                        </div>


                    </div>
                </div>
            {/if}

            {if !$forbidAccess.clientBalance}
                <div class="box box-primary  ">
                    <div class="box-header">
                        <h3 class="box-title">Client stats <i class="fa fa-line-chart pull-left"></i></h3>
                    </div>
                    <div class="box-body">
                        <div>
                            {include file="clients/statistics.tpl"}
                        </div>
                    </div>
                    <div class="box-footer-transparent box-footer">
                        <a class="btn btn-default btn-sm" href="?cmd=clients&action=show&id={$client_id}&refresh=1" >
                           Refresh
                        </a>
                    </div>
                </div>
            {/if}



            {if $enableFeatures.affiliates || $stats.affiliate || $client.assigned_affiliate}
                <div class="box box-primary  ">
                    <div class="box-header">
                        <h3 class="box-title">Affiliate <i class="fa fa-user pull-left"></i></h3>

                    </div>
                    <div class="box-body">
                        <div>


                            <div class="client-settings">

                                <div class="client-setting-row">
                                    <div class="client-setting-title">
                                        Is Affiliate?:
                                    </div>
                                    <div class="client-setting-value ">
 <span class="label {if $stats.affiliate}label-success-invert{else}label-default-invert{/if}">
                        {if $stats.affiliate}{$lang.Yes}{else}{$lang.No}{/if}

                                    </span>
     {if $stats.affiliate.id}
                                        <a href="?cmd=affiliates&action=affiliate&id={$stats.affiliate.id}" target="_blank" class="external">#{$stats.affiliate.id}</a>
     {/if}
                                    </div>
                                </div>

                                <div class="client-setting-row">
                                    <div class="client-setting-title">
                                        Assigned to Affiliate?:
                                    </div>
                                    <div class="client-setting-value ">
 <span class="label {if $client.assigned_affiliate}label-success-invert{else}label-default-invert{/if}">
                        {if $client.assigned_affiliate}{$lang.Yes}{else}{$lang.No}{/if}
</span>
                                        {if $client.assigned_affiliate}
                                        <a href="?cmd=affiliates&action=affiliate&id={$client.assigned_affiliate.id}" target="_blank" class="external">
                                        #{$client.assigned_affiliate.id} {$client.assigned_affiliate.firstname} {$client.assigned_affiliate.lastname}
                                        </a>
                                        {/if}
                                    </div>
                                </div>



                            </div>
                            {if $stats.affiliate}
                                <div class="client-settings">

                                <div class="client-setting-row">
                                        <div class="client-setting-title">
                                            {$lang.affsince}:
                                        </div>
                                        <div class="client-setting-value ">
                                            {$stats.affiliate.date_created|dateformat:$date_format}
                                        </div>
                                    </div>
                                    <div class="client-setting-row">
                                        <div class="client-setting-title">
                                            {$lang.convrate}:
                                        </div>
                                        <div class="client-setting-value ">
                                            {$stats.affiliate.conversion} %
                                        </div>
                                    </div>
                                    <div class="client-setting-row">
                                        <div class="client-setting-title">
                                            {$lang.balance}:
                                        </div>
                                        <div class="client-setting-value ">
                                            {$stats.affiliate.balance|price:$stats.currency_id}
                                        </div>
                                    </div>


                                </div>
                            {/if}


                        </div>
                    </div>
                </div>
            {/if}

        </div>

        <div class="col-md-6 mainrightcol">
            <div class="box box-primary  ">
                <div class="box-header">
                    <h3 class="box-title">Client Files <i class="fa fa-paperclip pull-left"></i></h3>

                </div>
                <div class="box-body">
                    <div id="clientfiles">
                        {include file="ajax.clientfiles.tpl"}
                    </div>
                </div>
            </div>

            {adminwidget module="clients" section="profilewidgets"}
            <div class="box box-primary">
                <div class="box-header">
                    <h3 class="box-title">Contact Client <i class="fa fa-envelope pull-left"></i></h3>
                </div>
                <div class="box-body">
                    <div id="" class="form-horizontal">
                        <div class="form-group">
                            <div class="col-sm-2">
                                <label>{$lang.SendMessage}</label>
                            </div>
                            <div class="col-sm-8">
                                <select name="mail_id" id="mail_id" style="width: 100%">
                                    <option value="1">Details:Signup</option>
                                    {foreach from=$client_emails item=send_email}
                                        <option value="{$send_email.id}">{$send_email.tplname}</option>
                                    {/foreach}
                                    <option value="custom" style="font-weight:bold">{$lang.newmess}</option>

                                </select>
                            </div>
                            <div class="col-sm-2">
                                <input type="button" name="sendmail" value="{$lang.Send}" id="sendmail"
                                       class="btn btn-primary btn-sm"/>
                            </div>
                        </div>
                        {if $mobilenotify}
                            <div class="form-group">
                                <div class="col-sm-2">
                                    <label>{$lang.SendTextMessage}</label>
                                </div>
                                <div class="col-sm-8">
                                    <select name="sms_id" id="sms_id" style="width: 100%">
                                        {foreach from=$client_sms.All item=send_email}
                                            {if $send_email.for!='Client'}{continue}{/if}
                                            <option value="{$send_email.id}">{$send_email.tplname}</option>
                                        {/foreach}
                                        {foreach from=$client_sms.Custom item=send_email}
                                            {if $send_email.for!='Client'}{continue}{/if}
                                            <option value="{$send_email.id}">{$send_email.tplname}</option>
                                        {/foreach}
                                        <option value="custom" style="font-weight:bold">{$lang.newmess}</option>
                                    </select>
                                </div>
                                <div class="col-sm-2">
                                    <input type="button" name="sendsms" value="{$lang.Send}" id="sendsms"
                                           class="btn btn-primary btn-sm"/>
                                </div>
                            </div>
                        {/if}
                    </div>
                </div>
                <div class="box-footer box-footer-transparent">
                    <a href="?cmd=sendmessage&type=clients&selected={$client_id}" class="btn btn-default btn-sm"
                       target="_blank">Compose Email</a>
                    {if 'config:MobileNotificationsClient:on'|checkcondition}
                        <a href="?cmd=sendmessage&action=asmobile&type=clients&selected={$client_id}"
                           class="btn btn-default btn-sm" target="_blank">{$lang.send_notification}</a>
                    {/if}
                    <a href="?cmd=tickets&action=new&client_id={$client_id}" class="btn btn-default btn-sm"
                       target="_blank">{$lang.opennewticket}</a>
                    {if 'config:EnablePortalNotifications:on'|checkcondition}
                        <a href="?cmd=sendmessage&action=asnotification&type=clients&selected={$client_id}"
                           class="btn btn-default btn-sm" target="_blank">{$lang.SendNotification}</a>
                    {/if}
                </div>
            </div>

            <div class="box box-primary  ">
                <div class="box-header">
                    <h3 class="box-title">Queued Invoice Items <i class="fa fa-list pull-left"></i></h3>

                </div>
                <div class="box-body">
                    <div id="itemqueue">
                        {include file="ajax.itemqueue.tpl" currency=$client_currency}
                    </div>
                </div>
            </div>





            <div class="box box-primary  no-padding">
                <div class="box-header">
                    <h3 class="box-title">Client Profile Changes <i class="fa fa-clock-o pull-left"></i></h3>

                </div>
                <div class="box-body">
                    <div id="clienthistory">
                        {include file="clients/ajax.changeslog.tpl"}
                    </div>
                </div>
            </div>


        </div>
    </div>

</form>
