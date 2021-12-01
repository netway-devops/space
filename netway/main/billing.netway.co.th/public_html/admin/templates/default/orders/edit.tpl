{php}
$templatePath   = $this->get_template_vars('template_path');
include($templatePath . '/orders/edit.tpl.php');
{/php}

<link href="{$template_dir}css/fileuploader.css?v={$hb_version}" rel="stylesheet" media="all" />
<script src="{$template_dir}js/fileuploader.js"></script>

<form  id="orderForm" name="orderForm" action="" method="post">
    <div class="blu"><a
             href="?cmd=orders&list={$currentlist}" ><strong>&laquo; {$lang.backto} {$currentlist} {$lang.orders}</strong></a>

    </div>
    <div id="ticketbody">
        <h1>{$lang.orderhash}{$details.id}  {$lang.numabbrev}{$details.number} </h1>

        <div id="client_nav">
            <!--navigation-->
            <a class="nav_el nav_sel left" href="#">{$lang.orderdetails}</a>
            <a class="nav_el  left" href="?cmd=orders&action=orderlogs&id={$details.id}"
               onclick="return false">{$lang.orderlog}</a>
            {include file="_common/quicklists.tpl" _client=$details.client_id}
            <div class="clear"></div>
        </div>
        {if $details.total < 0 && $details.status == 'Pending'}
        <div style="padding: 10px; margin-top: 10px; margin-bottom: 10px; border: 2px solid #EBB95B; background-color: #FFFCCC; color: #FF0000; font-size: 1.2em; ">
            <p align="center"> ยอดรวมของ order ติดลบ การ accept order ระบบจะทำการโอนยอดรวมเข้าเป็น credit ของลูกค้าทันที </p>
        </div>
        {/if}
        <div class="ticketmsg ticketmain" id="client_tab" style="margin-bottom:10px;">
            <div class="slide" style="display:block">
                <table cellspacing="2" cellpadding="3" border="0" width="100%" style="table-layout: fixed">
                    <tbody>
                        <tr>
                            <td width="15%" >{$lang.orderid}</td>
                            <td >{$details.id}</td>
                            <td width="15%" >{$lang.paymethod}</td>
                            <td >
                                <div class="manumode" hidden>
                                    <select name="payment_module">
                                        {foreach from=$gateways item=module key=id}
                                            <option value="{$id}" {if $details.payment_module==$id}selected{/if}>
                                                {$module}
                                            </option>
                                        {/foreach}
                                    </select>
                                </div>
                                <div class="livemode">
                                    {if $details.total<0}
                                        <span class="fs11">{$lang.amountcredited}</span>
                                    {elseif $details.invcredit>0 && $details.invcredit>=$details.invsubtotal2}
                                        {$lang.paidbybalance}
                                    {else}
                                        {$details.module|default:"`$lang.none`"}
                                        {if $details.invcredit>0}<span class="fs11">+ {$lang.paidbybalance}</span>{/if}
                                    {/if}
                                </div>
                            </td>
                        </tr>
                        <tr>
                            <td >{$lang.Client}</td>
                            <td>{$details|@profilelink:true}</td>
                            <td >{$lang.Amount}</td>
                            {if $admindata.access.viewOrdersPrices}
                                <td>
                                    <div class="manumode" hidden>
                                        {$details.currency.sign}
                                        <input type="text" value="{$details.total}" name="total" size="10"/>
                                    </div>
                                    <div class="livemode">
                                        {$details.total|price:$details.currency_id}
                                    </div>
                                </td>
                            {else}
                                <td>-</td>
                            {/if}
                        </tr>
                        <tr>
                            <td >{$lang.ordernumber}</td>
                            <td >{$details.number}</td>
                            <td >{$lang.invoicehash}</td>
                            <td class="row no-gutter">
                                <div class="manumode col-md-6 form-group-sm" hidden>
                                    <select name="invoice_id">
                                        {if $details.invoice_id!='0'}
                                            <option value="{$details.invoice_id}">
                                                {if $invoice}{$invoice|@invoice}
                                                {else}{$details.invoice_id}
                                                {/if}
                                            </option>
                                        {/if}
                                    </select>
                                </div>
                                <div class="livemode">
                                    {if $details.invoice_id!='0'}
                                        <a href="?cmd=invoices&action=edit&id={$details.invoice_id}">
                                            {if $invoice}{$invoice|@invoice}
                                            {else}{$details.invoice_id}
                                            {/if}
                                        </a>
                                    {else}{$lang.noinvoice}{/if}
                                </div>
                            </td>
                        </tr>
                        <tr>
                            <td >Contracts</td>
                            <td >
                                <span>
                                    {foreach from=$details.contracts item=contract}
                                        <a href="#" onclick="
                                                $('.nav_el_contracts').click().addClass('nav_sel minim');
                                                $('.nav_el').not('.nav_el_contracts').removeClass('nav_sel');
                                                $('.slide').hide().eq(parseInt($('.nav_el_contracts').attr('tab-id'))+1).show();
                                                $('html > head').append($('<style>.contractlist-{$contract.id} td{literal}{background-color:#fff8bc;}{/literal}</style>'));
                                                return false;">{$contract.number} ({$contract.name})</a>
                                    <br />
                                    {foreachelse}
                                       None
                                    {/foreach}
                                </span>
                            </td>
                            <td >{$lang.orderstatus}</td>
                            <td>
                                <div class="manumode" hidden>
                                    <select name="status">
                                        {foreach from=$order_status_list item=status}
                                            <option {if $details.status == $status}selected{/if} value="{$status}">
                                                {$lang.$status}
                                            </option>
                                        {/foreach}
                                    </select>
                                </div>
                                <div class="livemode">
                                    <span class="{$details.status}">{$details.status}</span>
                                </div>
                            </td>
                        </tr>
                        <tr>
                            <td >{$lang.orderdate}</td>
                            <td>
                                <div class="manumode" hidden>
                                    <input class="haspicker"
                                           value="{$details.date_created|dateformat:$date_format|regex_replace:'! [^\s]*$!':''}"
                                           name="orderdate"/>
                                    <input size="5" value="{$details.date_created|regex_replace:'!^[^\s]* !':''}"
                                           name="ordertime"/>
                                </div>
                                <div class="livemode">
                                    {$details.date_created|dateformat:$date_format}
                                </div>
                            </td>
                            <td>{$lang.paymentstatus}</td>
                            <td><span class="{$details.balance}">{$lang[$details.balance]}</span></td>
                        </tr>
                        <tr>
                            <td>{$lang.orderip}</td>
                            <td>
                                <div class="manumode" hidden>
                                    <input type="text" name="order_ip" value="{$details.order_ip}"/>
                                </div>
                                <div class="livemode">
                                    {$details.order_ip}
                                    {if !$forbidAccess.fastBan && $details.order_ip && $details.order_ip !== 'Automation'}
                                        (
                                        <a class="ban_ip_btn" {if $is_ip_banned} style="display: none;" {/if}
                                           href="?cmd=security&action=fastban&type=order&id={$details.id}"
                                           onclick="ajax_update($(this).attr('href'));$(this).hide();$('.unban_ip_btn').show();return false;">{$lang.banthisip}</a>
                                        <a class="unban_ip_btn" {if !$is_ip_banned} style="display: none;" {/if}
                                           href="?cmd=security&action=fastunban&type=order&id={$details.id}"
                                           onclick="ajax_update($(this).attr('href'));$(this).hide();$('.ban_ip_btn').show();return false;">{$lang.unbanthisip}</a>
                                        )
                                    {/if}
                                </div>
                            </td>
                            {if $affiliates }
                                <td>{$lang.referral}</td>
                                <td class="row no-gutter">
                                    {if $referral || $referrals}
                                        {if $referrals}
                                            <div class="manumode col-md-6 form-group-sm" hidden>
                                                <select name="referral">
                                                    <option value="0" {if !$referral}selected{/if}>{$lang.none}</option>
                                                    {foreach from=$referrals item=ref}
                                                        <option value="{$ref.id}" {if $referral.id == $ref.id}selected{/if}>
                                                            #{$ref.id} {$ref.firstname} {$ref.lastname}</option>
                                                    {/foreach}
                                                </select>
                                            </div>
                                        {/if}
                                        <div {if $referrals}class="livemode"{/if}>
                                            {if $referral}
                                                <a href="?cmd=affiliates&action=affiliate&id={$referral.id}">
                                                    {$referral.firstname} {$referral.lastname}
                                                </a>
                                            {else}
                                                {$lang.none}
                                            {/if}
                                        </div>
                                    {/if}
                                </td>
                            {else}
                                <td colspan="2"></td>
                            {/if}
                        </tr>
                        <tr>
                            <td>{$lang.staffownership}</td>
                            <td class="row no-gutter">

                                <div class="manumode col-md-6 form-group-sm" hidden>
                                    <select name="staff_member_id" data-chosenedge>
                                        <option value="0">{$lang.none}</option>
                                        {foreach from=$staff item=adm}
                                            <option value="{$adm.id}"
                                                    {if $details.staff_member_id==$adm.id}selected{/if} >
                                                {$adm.firstname} {$adm.lastname}
                                            </option>
                                        {/foreach}
                                    </select>
                                </div>
                                <div class="livemode">
                                    {if $details.staff_member_id}
                                        <a href="?cmd=editadmins&action=administrator&id={$details.staff_member_id}">
                                            {$details.admin_firstname} {$details.admin_lastname}
                                        </a>
                                    {else}
                                        {$lang.none}
                                    {/if}
                                    <button type="submit" name="takeownership"
                                            class="btn btn-default btn-sm">{$lang.takeownership}</button>
                                </div>

                            </td>
                            <td>Commitment date</td>
                            <td>
                                <div class="manumode" hidden>
                                    <input class="haspicker" value="{if $details.commitment_date}{$details.commitment_date|dateformat:$date_format}{else}{/if}" name="commitment_date"/>
                                </div>
                                <div class="livemode">
                                    {if $details.commitment_date}
                                        {if $details.commitment_date|@strtotime > $timestamp}
                                            <span style="color: #0C0">{$details.commitment_date|dateformat:$date_format}</span>
                                        {else}
                                            <span style="color: red">{$details.commitment_date|dateformat:$date_format}</span>
                                        {/if}
                                    {else}
                                        None
                                    {/if}
                                </div>
                            </td>
                        </tr>
                        <tr class="div-recipients">
                            {include file="orders/ajax.edit.tpl"}
                        </tr>
                    </tbody>
                </table>
                <div class="manumode text-center" hidden>
                    <button type="submit" name="make" value="save" id="save" class="btn btn-success btn-sm">
                        {$lang.savechanges}
                    </button>
                    <a href="?cmd=orders&action=edit&id={$details.id}" class="btn btn-default btn-sm">
                        {$lang.Cancel}
                    </a>
                </div>

            </div>
            <div class="slide">Loading</div>
            {include file="_common/quicklists.tpl" _placeholder=true}
        </div>

{* custom code สามารถที่จะ add note ได้ *}


        {if $details.status=='Pending'}
            <input type="hidden" name="manual" value="1" />
        {/if}

{literal}
            <script type="text/javascript">

{* custome code มีการเช็คเรื่อง isAcceptableOrder *}

                function _cunc(ele) {
                    if (!$(ele).is(':checked')) {
                        $('.provision').removeAttr('checked');
                        $('.provisioning').hide();
                    } else {
                        $('.provision').attr('checked', 'checked');
                        $('.provisioning').show();
                    }
                    return false;
                }
                $(document).ready(function () {
                    $('.provision').click(function () {
                        var rel = $(this).attr('rel');
                        if ($(this).is(':checked')) {
                            $('.' + rel).show();
                        } else {
                            $('.' + rel).hide();
                        }
                    });
                    var is = false;
                    $('.ordertable > tbody > tr:gt(0)').each(function () {
                        if ($(this).hasClass('provisioning')) {
                            if (is) {
                                $(this).addClass('even');
                            }
                        } else {
                            if (!is) {
                                $(this).addClass('even');
                            }
                            is = !is;
                        }
                    });
                });
            </script>
{/literal}


            <h1>Order items</h1>

            <table width="100%" class="ordertable" cellpadding="3" cellspacing="0" border="0"
                   style="border:solid 1px #ddd;border-bottom: none;">
                <tbody>
                    <tr  >
                        {if $details.status=='Pending'}
                            <th width="80" style="padding-left:3px">
                                <input type="checkbox" onclick="_cunc(this)"/><span
                                        style="font-size:11px; font-weight: normal">{$lang.Provision}</span>
                            </th>
                        {/if}
                        <th align="left">{$lang.Item}</th>
                        <th width="100" style="text-align: center;">{$lang.billingcycle}</th>
                        <th width="100" style="text-align: center;">{$lang.Amount}</th>
                        <th width="100" style="text-align: center;">{$lang.Status}</th>
                    </tr>

                    {if $isProvisionCompleted && $details.status=='Pending'}
                    <tr>
                        <td colspan="5" style="background-color:#FFDFDF;">
                        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Order lifecycle step <strong>Provistion</strong> complete แล้วไม่ควรทำ Provistion ร่วมกับ Accept Order อีก เช่น กรณี renew domain มันจะต่ออายุอีกใน order เดิม
                        </td>
                    </tr>
                    {/if}
                    {if $details.hosting}
                        {foreach from=$details.hosting item=account}
                            {assign var="descr" value="_hosting"}
                            {assign var="baz2" value=$account.ptype}
                            {assign var="baz" value="$baz2$descr"}

                            <tr  class="havecontrols">
                                {if $details.status=='Pending'}
                                    <td>
                                        <input type="checkbox" name="oaccounts[{$account.id}][modulecreate]" value="1"
                                               class="provision account"
                                               rel="accountrow{$account.id}" checked="checked"/>
                                    </td>
                                {/if}
                                <td >
                                    <a href="?cmd=accounts&action=edit&id={$account.id}">
                                        <b>
                                            {if $lang.$baz}{$lang.$baz}
                                            {else}{$account.ptype}
                                            {/if}:
                                        </b>
                                        {$account.catname} - {$account.name}
                                        {if $account.domain!=''}{$account.domain}
                                        {/if}
                                    </a>
                                   {if $steps[2].status == 'Completed' && $steps[3].status != 'Completed' && $aProvisionWithCapture.hosting[$account.id]}
                                   <div style="color: red;">ไม่อนุญาติให้ทำ Provision โดย Authorize Payment อย่างเดียวโดยที่ยังไม่ Capture Payment</div>
                                   {/if}
                                   {if isset($aFulfillmentTicket.Hosting[$account.id])}
                                   <div class="right">
                                       [Fulfillment: {$aFulfillmentTicket.Hosting[$account.id].status}] <a href="?cmd=redirecthandle&cmd_=tickets&action_=view&num={$aFulfillmentTicket.Hosting[$account.id].ticket_number}" style="color:gray" target="_blank">{$aFulfillmentTicket.Hosting[$account.id].subject} <img src="images/icon_new_window.gif" width="10" border="0"></a>
                                   </div>
                                   {/if}
                                </td>
                                <td align="center">{$lang[$account.billingcycle]}</td>
                                <td align="center">
                                    {if $admindata.access.viewAccountsPrices && $admindata.access.viewOrdersPrices}
                                        {$account.total|price:$details.currency_id}
                                    {else}
                                        -
                                    {/if}
                                </td>
                                <td align="center"><span class="{$account.status}"
                                                         id="acc_{$account.id}">{$lang[$account.status]}</span></td>
                            </tr>
                            {if $account.status=='Pending' && $details.status=='Pending' && $account.module!=0 && $account.module!=''}
                                <tr id="" class="accountrow{$account.id} provisioning">
                                    <td></td>
                                    <td colspan="4" >
                                        <table border="0" width="100%" cellpadding="2" cellspacing="0">

                                            <tr {if $account.domain==''}style="display:none"{/if}>
                                                <td width="160">{$lang.Hostname}:</td>
                                                <td><input name="oaccounts[{$account.id}][domain]" value="{$account.domain}"/>
                                                </td>
                                            </tr>

                                            <tr>
                                                <td width="160" >{$lang.Username}:</td>
                                            <td><input name="oaccounts[{$account.id}][username]"
                                                       value="{$account.username}"/></td>
                                            </tr>
                                        {if $admindata.access.passwordSettings}
                                            <tr>
                                                <td width="160" >{$lang.Password}:</td>
                                                <td><input name="oaccounts[{$account.id}][password]"
                                                           value="{$account.password}"/></td>
                                            </tr>
                                            <tr {if $account.ptype!='dedicated'}style="display:none"{/if}>
                                                <td width="160" >{$lang.rootpass}:</td>
                                                <td><input name="oaccounts[{$account.id}][rootpassword]"
                                                           value="{$account.rootpassword}"/></td>
                                            </tr>
                                        {else}
                                            <input type="hidden" name="oaccounts[{$account.id}][password]"
                                                   value="{$account.password}"/>
                                            <input type="hidden" name="oaccounts[{$account.id}][rootpassword]"
                                                   value="{$account.rootpassword}"/>
                                        {/if}
                                            <tr>
                                                <td width="160"  >{$lang.Server}:</td>
                                                <td >
                                                    <select name="oaccounts[{$account.id}][server_id]">
                                                        {foreach from=$servers[$account.id] item=server}
                                                            <option value="{$server.id}"
                                                                    {if $account.server_id==$server.id}selected="selected"{/if}>
                                                                {$server.name}
                                                                ({$server.accounts}{if $server.max_accounts>0}/{$server.max_accounts}{/if}
                                                                Accounts)
                                                            </option>
                                                        {/foreach}
                                                    </select>
                                                </td>
                                            </tr>
                                        </table>
                                    </td>
                                </tr>
                            {/if}
                        {/foreach}
                    {/if}

                    {if $details.addons}
                        {foreach from=$details.addons item=addon}
                            <tr  class="havecontrols">
                            {if $details.status=='Pending'}
                                <td></td>
                            {/if}
                            <td><a href="?cmd=accounts&action=edit&id={$addon.account_id}"><b>{$lang.accountaddon}
                                        :</b> {$addon.name}</a></td>
                                <td align="center">{$lang[$addon.billingcycle]}</td>
                                <td align="center">
                                    {if $admindata.access.viewOrdersPrices}
                                        {$addon.recurring_amount|price:$details.currency_id}
                                    {else}
                                        -
                                    {/if}
                                </td>
                                <td align="center"><span class="{$addon.status}">{$lang[$addon.status]}</span></td>
                            </tr>
                        {/foreach}
                    {/if}


                    {if $details.upgrades}
                        {foreach from=$details.upgrades item=upgrade}
                            <tr  class="havecontrols">
                                {if $details.status=='Pending'}
                                    <td></td>
                                {/if}
                                <td ><a href="?cmd=accounts&action=edit&id={$upgrade.account_id}">
                                        <b>Upgrade / Downgrade to:</b> {$upgrade.name}</a>
                                </td>
                                <td align="center"> </td>
                                <td align="center">
                                    {if $admindata.access.viewOrdersPrices}
                                        {$upgrade.total|price:$details.currency_id}
                                    {else}
                                        -
                                    {/if}
                                </td>
                                <td align="center"><span class="{$upgrade.status}">{$lang[$upgrade.status]}</span></td>
                            </tr>
                        {/foreach}
                    {/if}

                    {if $details.fieldupgrades}
                        {foreach from=$details.fieldupgrades item=upgrade}
                            <tr  class="havecontrols">
                                {if $details.status=='Pending'}
                                    <td></td>
                                {/if}
                                <td >
                                    <a href="?cmd={if $upgrade.rel_type=='Domain'}domains{else}accounts{/if}&action=edit&id={$upgrade.account_id}">
                                        <b>Upgrade / Downgrade</b>
                                        {$upgrade.category_name}{*
                                        *}{if $upgrade.description}: {$upgrade.description}{/if}
                                    </a>
                                </td>
                                <td align="center"> </td>
                                <td align="center">-</td>
                                <td align="center"><span class="{$upgrade.status}">{$lang[$upgrade.status]}</span></td>
                            </tr>
                        {/foreach}
                    {/if}

                    {if $details.domains}
                        {foreach from=$details.domains item=domain}
                            <tr  class="havecontrols">
                                {if $details.status=='Pending'}
                                    <td>
                                        <input type="checkbox" name="domainregister[{$domain.id}]" value="1" checked="checked"
                                               value="1" rel="domainrow{$domain.id}" class="provision domain"/>
                                    </td>
                                {/if}

                                <td >
                                    <a href="?cmd=domains&action=edit&id={$domain.id}"><b>Domain:</b> {$domain.type} - {$domain.name}</a>

                                   {if $steps[2].status == 'Completed' && $steps[3].status != 'Completed' && $aProvisionWithCapture.hosting[$account.id]}
                                   <div style="color: red;">ไม่อนุญาติให้ทำ Provision โดย Authorize Payment อย่างเดียวโดยที่ยังไม่ Capture Payment</div>
                                   {/if}
                                   {if isset($aFulfillmentTicket.Domain[$domain.id])}
                                   <div class="right">
                                       [Fulfillment: {$aFulfillmentTicket.Domain[$domain.id].status}] <a href="?cmd=redirecthandle&cmd_=tickets&action_=view&num={$aFulfillmentTicket.Domain[$domain.id].ticket_number}" style="color:gray" target="_blank">{$aFulfillmentTicket.Domain[$domain.id].subject} <img src="images/icon_new_window.gif" width="10" border="0"></a>
                                   </div>
                                   {/if}

                                </td>
                                <td align="center">{$domain.period} {$lang.yearslash}</td>
                                <td align="center">
                                    {if $admindata.access.viewDomainsPrices && $admindata.access.viewOrdersPrices}
                                        {$domain.firstpayment|price:$details.currency_id}
                                    {else}
                                        -
                                    {/if}
                                </td>
                                <td align="center"><span class="{$domain.status}">{$lang[$domain.status]}</span></td>
                            </tr>
                            {if $domain.status=='Pending' && $details.status!='Active' }
                                <tr class="domainrow{$domain.id} provisioning">
                                    <td></td>
                                    <td colspan="4" style="">
                                        <table border="0" cellspacing="0" cellpadding="3" width="100%">
                                            <tr>
                                                <td width="160">{$lang.Registrar}:</td>
                                                <td>
                                                    <select name="domainmodule[{$domain.id}]">
                                                        {foreach from=$domainmodules item=dom key=id}
                                                            <option value="{$id}"
                                                                    {if $id==$domain.reg_module}selected="selected"{/if}>{$dom}</option>
                                                        {/foreach}
                                                    </select>
                                                </td>
                                            </tr>
                                            {foreach item=i from=0|@range:9}
                                                <tr>
                                                    <td width="160">Nameserver {$i+1}</td>
                                                    <td><input name="nameservers[{$domain.id}][{$i}]"
                                                               value="{$domain.nameservers[$i]}"/></td>
                                                </tr>
                                            {/foreach}
                                        </table>
                                    </td>
                                </tr>
                            {/if}
                        {/foreach}
                    {/if}
                </tbody>
            </table>
            <div style="text-align:center;margin-bottom:7px;padding:15px 0px;" class="p6 secondtd">


                <a onclick="$('input[name=markaccepted]').click();
                            return false;" href="#"
                   class="btn btn-sm btn-success {if $details.status=='Active' || $details.balance=='Completed'}disabled{/if}">
                    <span>{$lang.acceptorder}</span>
                </a>
                <a onclick="$('input[name=markcancelled]').click();
                            return false;" href="#"
                   class="btn btn-sm btn-danger {if $details.status=='Cancelled' || $details.status=='Active'}disabled{/if}">
                    <span>{$lang.cancelorder}</span>
                </a>
                <span class="orspace">{$lang.Or}</span>

                <a onclick="$('input[name=markpending]').click();
                            return false;" href="#"
                   class="btn btn-sm btn-default {if $details.status=='Pending'}disabled{/if}">
                    <span>{$lang.settopending}</span>
                </a>
                <a onclick="$('input[name=markfraud]').click();
                            return false;" href="#"
                   class="btn btn-sm btn-default {if $details.status=='Fraud'}disabled{/if}">
                    <span>{$lang.setasfraud}</span>
                </a>
                        {if !$forbidAccess.deleteOrders}
                    <a href="#" class="btn btn-sm btn-danger"  onclick="return confirm1();">{$lang.deleteorder}</a>
                {/if}
            </div>

            {include file='orders/scenario.tpl'}


            {include file='_common/noteseditor.tpl'}
            <script type="text/javascript">
                AdminNotes.show();
                AdminNotes.hide();
            </script>


            {if $details.fraudmodule && !$steps}

                {if $details.status=='Fraud'}

                    <div class="bigger" style="margin-bottom:10px;"><strong>{$lang.fraudscore}: <span
                                    style="color:#FF0000">{$details.fraudout.riskScore}%</span></strong></div>
                    <div style="padding:5px;font-size:11px;"  class="lighterblue">
                        <table width="100%" cellpadding="2" cellspacing="0">
                            {foreach from=$details.fraudout item=f key=k name=checker}
                                {if $smarty.foreach.checker.index%3=='0'}<tr>{/if}
                                {if $k!='explanation'}
                                    <td width="16%" align="right"><strong>{$k}</strong></td>
                                    <td width="16%" align="left">{$f}</td>{/if}
                                    {if $smarty.foreach.checker.index%3=='5'}</tr>{/if}

                            {/foreach}

                        </table>

                        {if $details.fraudout.explanation}
                            <br/>
                            <b>{$lang.Explanation}: </b>{$details.fraudout.explanation}{/if}
                    </div>


                {else}
                    <div class="bigger" style="margin-bottom:10px;">
                        <strong>{$lang.fraudscore}:
                            <span style="color:#00FF00">{$details.fraudout.riskScore}%</span>
                        </strong>
                        <a href="?cmd=orders&action=frauddetails&fraudmodule={$details.fraudmodule}&id={$details.id}"
                           class="fraud-details">{$lang.getdetailedinfo} </a>
                    </div>
                    <div style="padding:5px;display:none;font-size:11px;" id="frauddetails" class="lighterblue"></div>

                {/if}

            {/if}

        </div>

        <div class="blu"><a
                    href="?cmd=orders&list={$currentlist}"><strong>&laquo; {$lang.backto} {$currentlist} {$lang.orders}</strong></a>
            <div style="display:none"><input type="submit" {if $details.status=='Active'}disabled=""
                                             {/if}name="markaccepted"
                                             value="{$lang.acceptorder}" onclick="$('#ticketbody').addLoader()"/>
                <input type="submit" {if $details.status=='Cancelled'}disabled=""{/if} name="markcancelled"
                       value="{$lang.cancelorder}"/>
                <input type="submit" {if $details.status=='Fraud'}disabled=""{/if} name="markfraud"
                       value="{$lang.setasfraud}"/>
                <input type="submit" {if $details.status=='Pending'}disabled=""{/if} name="markpending"
                       value="{$lang.settopending}"/>
                <input type="submit" style="color: #ff0000;" name="delete" value="{$lang.deleteorder}"
                       onclick="return confirm1();"/>
                <input type="submit" name="send" value="{$lang.SendMessage}"></div>
        </div>

        {securitytoken}</form>
    <div id="confirm_ord_delete" hidden bootbox data-title="{$lang.orddelheading}" data-btnclass="btn-danger"  >
        <form action="?cmd=orders&delete=1&action=edit" method="post">
            <p><strong>{$lang.orddeldescr}</strong></p>

            <input type="radio" checked="checked" name="harddelete" value="true" class="cc_hard"/>
            <span> {$lang.deleteopt1}</span><br/>
            <input type="radio"  name="harddelete" value="false" /> <span> {$lang.deleteopt2}</span><br />
            {securitytoken}
            <input type="hidden" name="id" value="{$details.id}"/>

        </form>
    </div>

{literal}
    <script>
        function _cunc(ele) {
            if (!$(ele).is(':checked')) {
                $('.provision').removeAttr('checked');
                $('.provisioning').hide();
            } else {
                $('.provision').attr('checked', 'checked');
                $('.provisioning').show();
            }
            return false;
        }

        function confirm1() {
            $('#confirm_ord_delete').trigger('show');
            return false;
        }

        $('body').bootboxform();

        $(function () {
            $('.provision').click(function () {
                var rel = $(this).attr('rel');
                if ($(this).is(':checked')) {
                    $('.' + rel).show();
                } else {
                    $('.' + rel).hide();
                }
            });

            var is = false;
            $('.ordertable > tbody > tr:gt(0)').each(function () {
                if ($(this).hasClass('provisioning')) {
                    if (is) {
                        $(this).addClass('even');
                    }
                } else {
                    if (!is) {
                        $(this).addClass('even');
                    }
                    is = !is;
                }
            });

            $('.fraud-details').on('click', function () {
                $('#frauddetails').show();
                ajax_update(this.getAttribute('href'), {}, '#frauddetails', true);
                $(this).hide();
                return false;
            })

            var edit_btn = '<a href="#" onclick="return false;" class="manuedit" style="visibility: hidden">'
                + lang['edit'] + '</a>';

            $('div.livemode').not('tr').each(function(){
                var btn = $(edit_btn);
                btn.appendTo(this);

                $(this).hover(function () {
                    btn.css('visibility', 'visible')
                }, function () {
                    btn.css('visibility', 'hidden');
                })

                btn.click(function () {
                    $('.livemode').hide();
                    $('.manumode').show();
                })
            });

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