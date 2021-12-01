{php}
$templatePath   = $this->get_template_vars('template_path');
include($templatePath . 'accounts.tpl.php');
{/php}

<script type="text/javascript">loadelements.accounts = true;</script>
<table border="0" cellspacing="0" cellpadding="0" width="100%" id="content_tb"
       {if $currentfilter && !$details.manual}class="searchon"{/if}>
    <tr>
        <td>
            <h3>{$lang.Accounts}</h3>
        </td>
        <td class="searchbox">
            <div id="hider2" style="text-align:right">
                <a href="?cmd=accounts&action=getadvanced{if $list_type}&list={$list_type}{/if}"
                   class="fadvanced">{$lang.filterdata}</a>
                <a href="?cmd=accounts&resetfilter=1" {if $currentfilter}style="display:inline"{/if}
                   class="freseter">{$lang.filterisactive}</a>
            </div>
            <div id="hider" style="display:none"></div>
        </td>
    </tr>
    <tr>
        <td class="leftNav">

            <a href="?cmd=orders&action=createdraft" class="tstyled btn btn-success"><strong>{$lang.newaccount}</strong></a><br>


            <a href="?cmd=accounts&amp;list=all"
               class="tstyled {if $currentlist=='all'  || $plist=='all'}selected{/if}">{$lang.allaccounts}
                <span>({$stats.All.total})</span></a>
            {if $currentlist=='all' || $plist=='all'}
                <a href="?cmd=accounts&amp;list=all_active"
                   class="tstyled tsubit {if $plist=='all' && $flist=='active'}selected{/if}">{$lang.Active}
                    <span>({if $stats.All.Active}{$stats.All.Active}{else}0{/if})</span></a>
                <a href="?cmd=accounts&amp;list=all_pending"
                   class="tstyled tsubit {if $plist=='all' && $flist=='pending'}selected{/if}">{$lang.Pending}
                    <span>({if $stats.All.Pending}{$stats.All.Pending}{else}0{/if})</span></a>
                <a href="?cmd=accounts&amp;list=all_suspended"
                   class="tstyled tsubit {if $plist=='all' && $flist=='suspended'}selected{/if}">{$lang.Suspended}
                    <span>({if $stats.All.Suspended}{$stats.All.Suspended}{else}0{/if})</span></a>
                <a href="?cmd=accounts&amp;list=all_terminated"
                   class="tstyled tsubit {if $plist=='all' && $flist=='terminated'}selected{/if}">{$lang.Terminated}
                    <span>({if $stats.All.Terminated}{$stats.All.Terminated}{else}0{/if})</span></a>
                <a href="?cmd=accounts&amp;list=all_cancelled"
                   class="tstyled tsubit {if $plist=='all' && $flist=='cancelled'}selected{/if}">{$lang.Cancelled}
                    <span>({if $stats.All.Cancelled}{$stats.All.Cancelled}{else}0{/if})</span></a>
                <a href="?cmd=accounts&amp;list=all_fraud"
                   class="tstyled tsubit {if $plist=='all' && $flist=='fraud'}selected{/if}">{$lang.Fraud}
                    <span>({if $stats.All.Fraud}{$stats.All.Fraud}{else}0{/if})</span></a>
            {/if}

            {foreach from=$stats item=stat key=k}
                {if $k!='All'}

                    {assign var="descr" value="_hosting"}
                    {assign var="baz" value="$k$descr"}
                    <a href="?cmd=accounts&amp;list={$k}"
                       class="tstyled {if $currentlist==$k || $plist==$k}selected{/if}">{if $lang.$baz}{$lang.$baz}{else}{$k}{/if}
                        <span>({$stat.total})</span></a>
                    {if $currentlist==$k || $plist==$k}
                        <a href="?cmd=accounts&amp;list={$k}_active"
                           class="tstyled tsubit {if $plist==$k && $flist=='active' }selected{/if}">{$lang.Active}
                            <span>({if $stat.Active}{$stat.Active}{else}0{/if})</span></a>
                        <a href="?cmd=accounts&amp;list={$k}_pending"
                           class="tstyled tsubit {if  $plist==$k && $flist=='pending'}selected{/if}">{$lang.Pending}
                            <span>({if $stat.Pending}{$stat.Pending}{else}0{/if})</span></a>
                        <a href="?cmd=accounts&amp;list={$k}_suspended"
                           class="tstyled tsubit {if  $plist==$k && $flist=='suspended'}selected{/if}">{$lang.Suspended}
                            <span>({if $stat.Suspended}{$stat.Suspended}{else}0{/if})</span></a>
                        <a href="?cmd=accounts&amp;list={$k}_terminated"
                           class="tstyled tsubit {if  $plist==$k && $flist=='terminated'}selected{/if}">{$lang.Terminated}
                            <span>({if $stat.Terminated}{$stat.Terminated}{else}0{/if})</span></a>
                        <a href="?cmd=accounts&amp;list={$k}_cancelled"
                           class="tstyled tsubit {if  $plist==$k && $flist=='cancelled'}selected{/if}">{$lang.Cancelled}
                            <span>({if $stat.Cancelled}{$stat.Cancelled}{else}0{/if})</span></a>
                        <a href="?cmd=accounts&amp;list={$k}_fraud"
                           class="tstyled tsubit {if  $plist==$k && $flist=='fraud'}selected{/if}">{$lang.Fraud}
                            <span>({if $stat.Fraud}{$stat.Fraud}{else}0{/if})</span>
                        </a>
                    {/if}
                {/if}
            {/foreach}

            {literal}
                <script type="text/javascript">
                    appendLoader('loadCancelRequests');

                    function loadCancelRequests() {
                        ajax_update('?cmd=accounts&action=cancelrequests', false, '#cancel_requests');
                    }
                </script>
            {/literal}
            <div id="cancel_requests" style="padding-right:10px"></div>
        </td>

        <td valign="top" class="bordered">
            <div id="bodycont">


                {if $action=='edit' && $details}


                {if $typetemplates.adminaccounts.details.replace}
                    {include file=$typetemplates.adminaccounts.details.replace}
                {else}
                    {assign var="descr" value="_hosting"}
                    {assign var="baz" value="$plist$descr"}
                    
<script type="text/javascript">
{literal}
$(document).ready(function() {
    {/literal}{if ! isset($admindata.access.editInvoices)}$('.livemode').removeClass('livemode');{/if}{literal}
});
{/literal}
</script>
                    
                    <form action="" method="post" id="account_form" onsubmit="{if ! isset($admindata.access.editAccounts)}return false;{/if}">

                        <input type="hidden" name="account_id" value="{$details.id}" id="account_id"/>
                        <div class="blu">{include file='_common/accounts_nav.tpl'}</div>




                        <div id="ticketbody">

                            {include file='_common/accounts_billing.tpl'}

                            <table border="0" cellpadding="0" cellspacing="0" width="100%">
                                <tr>
                                    <td width="100%" valign="top">
                                        <ul class="accor">
                                            <li><a href="#">{$lang.accountdetails}</a>
                                                <div class="sor">

                                                    {include file='_common/accounts_details.tpl'}

                                                </div>
                                            </li>
                                        </ul>
                                        <ul class="accor" id="dommanager" style="display:none;margin-bottom:5px;">
                                            <li><a href="#" id="man_title"></a>
                                                <div class="sor" id="man_content"></div>
                                            </li>
                                        </ul>


                                    </td>
                                </tr>
                                <tr>


                                    <td valign="top" width="100%">

                                        {if $custom_template}
                                            {include file=$custom_template}
                                        {/if}

                                        {if $showmetrics}
                                            <ul class="accor">
                                                <li><a href="#">{$lang.quotaussage}</a>
                                                    {include file='_common/accounts_metrics.tpl'}
                                                </li>
                                            </ul>
                                        {/if}

                                        <ul class="accor">
                                            <li><a href="#">{$lang.accaddons}</a>
                                                {include file='_common/accounts_addons.tpl'}
                                            </li>
                                        </ul>
                                        <br/>
                                        {include file='_common/accounts_extrabilling.tpl'}
                                        {include file='_common/accounts_multimodules.tpl'}
                                        {include file='_common/noteseditor.tpl'}

                                    </td>
                                </tr>
                                
                        {if $symantecviptabs}
                        <tr>
                              <td  valign="top" width="100%">
                                  <ul class="accor">
                                    <li><a href="#">symantec vip</a>
                                        <div class="sor">
                                            {include file=$symantecviptabs}
                                        </div>
                                    </li>
                                </ul>
                              </td>
                        </tr>
                        {/if}
                        {if $template_cpanel_dtl}
                        <tr>
                              <td  valign="top" width="100%">
                                  <ul class="accor">
                                    <li><a href="#">Cpanel license</a>
                                        <div class="sor">
                                            {include file=$template_cpanel_dtl}
                                        </div>
                                    </li>
                                </ul>
                              </td>
                        </tr>
                        {/if}
                                
                            </table>
                        </div>
                        <div class="blu">{include file='_common/accounts_nav.tpl'}</div>
                        {securitytoken}
                    </form>
                {/if}
                    <div id="confirm_ord_delete" hidden bootbox data-title="{$lang.accdelheading}"
                         data-btnclass="btn-danger">
                        <form action="?cmd=accounts&make=delete&action=edit" method="post">
                            <p><strong>{$lang.accdeldescr}</strong></p>

                            <input type="radio" checked="checked" name="harddelete" value="true"/>
                            <span> {$lang.deleteopt1} </span><br/>
                            <input type="radio" name="harddelete" value="false"/> <span> {$lang.deleteopt2}</span><br/>
                            <input type="hidden" name="id" value="{$details.id}"/>
                            {securitytoken}

                        </form>
                    </div>
                {else}
                    <form action="" method="post" id="testform">
                        <input type="hidden" value="{$totalpages}" name="totalpages2" id="totalpages"/>
                        <div class="blu">
                            <div class="right">
                                <div class="pagination"></div>
                            </div>
                            <div class="left menubar">
                                {$lang.withselected}
                                
                                {if isset($admindata.access.editAccounts)}
                                <!--
                                <a class="submiter menuitm menu-auto" name="create" {if $enablequeue}queue='push'{/if}
                                   href="#"><span><strong>{$lang.Activate}</strong></span></a>
                                <a class="submiter menuitm menu-auto" name="suspend" {if $enablequeue}queue='push'{/if}
                                   href="#"><span>{$lang.Suspend}</span></a>
                                <a class="submiter menuitm menu-auto" {if $enablequeue}queue='push'{/if}
                                   name="unsuspend" href="#"><span>{$lang.Unsuspend}</span></a>
                                <a class="submiter menuitm confirm menu-auto" name="delete"
                                   {if $enablequeue}queue='push'{/if} href="#"><span
                                            style="color:#FF0000">{$lang.Terminate}</span></a>
                                -->
                                {/if}
                                            
                                <span class="menu-auto-reset"></span>

                                <a class="menuitm setStatus" id="hd1" onclick="return false;" href="#"><span
                                            class="morbtn">{$lang.moreactions}</span></a>
                                <ul id="hd1_m" class="ddmenu">
                                    <li><a href="#" onclick="return send_msg('accounts')">{$lang.SendMessage}</a></li>
                                    <li><a href="#" onclick="return send_msg('accounts_ticket')">Create Tickets</a></li>
                                    {if !$forbidAccess.deleteServices}
                                        <li><a href="Delete">{$lang.delete|ucfirst}</a></li>
                                    {/if}
                                </ul>
                            </div>
                            <div class="clear"></div>
                        </div>

                        <a href="?cmd=accounts&list={$currentlist}" id="currentlist" style="display:none"
                           updater="#updater"></a>
                        {if $custolist_dir}
                            {include file="`$custolist_dir`admin_list.tpl"}
                        {else}
                            <table cellspacing="0" cellpadding="3" border="0" width="100%" class="table glike hover">
                                <tbody>
                                    <tr>
                                        <th width="20"><input type="checkbox" id="checkall"/></th>
                                        <th width="20" class="text-nowrap"><a
                                                    href="?cmd=accounts&list={$currentlist}&orderby=id|ASC"
                                                    class="sortorder">{$lang.accounthash}</a></th>
                                        <th><a href="?cmd=accounts&list={$currentlist}&orderby=lastname|ASC"
                                               class="sortorder">{$lang.clientname}</a></th>
                                        <th><a href="?cmd=accounts&list={$currentlist}&orderby=domain|ASC"
                                               class="sortorder">IP Address<!--{$lang.Domain}--></a></th>
                                        <th><a href="?cmd=accounts&list={$currentlist}&orderby=name|ASC"
                                               class="sortorder">{$lang.Service}</a></th>
                                        {if $admindata.access.viewAccountsPrices}
                                            <th><a href="?cmd=accounts&list={$currentlist}&orderby=total|ASC"
                                                   class="sortorder">{$lang.Price}</a></th>
                                        {/if}
                                        <th><a href="?cmd=accounts&list={$currentlist}&orderby=billingcycle|ASC"
                                               class="sortorder">{$lang.billingcycle}</a></th>
                                        <th><a href="?cmd=accounts&list={$currentlist}&orderby=status|ASC"
                                               class="sortorder">{$lang.Status}</a></th>
                                        <th><a href="?cmd=accounts&list={$currentlist}&orderby=next_due|ASC"
                                               class="sortorder">{$lang.nextdue}</a></th>
                                        <th width="20"/>
                                    </tr>
                                </tbody>
                                <tbody id="updater">

                                    {include file='ajax.accounts.tpl'}
                                </tbody>
                                <tbody id="psummary">
                                    <tr>
                                        <th></th>
                                        <th colspan="9">
                                            {$lang.showing} <span id="sorterlow">{$sorterlow}</span> - <span
                                                    id="sorterhigh">{$sorterhigh}</span> {$lang.of} <span
                                                    id="sorterrecords">{$sorterrecords}</span>
                                        </th>
                                    </tr>
                                </tbody>
                            </table>
                        {/if}
                        <div class="blu">
                            <div class="right">
                                <div class="pagination"></div>
                            </div>
                            <div class="left menubar">

                                {$lang.withselected}
                                
                                {if isset($admindata.access.editAccounts)}
                                <!--
                                <a class="submiter menuitm menu-auto" name="create" {if $enablequeue}queue='push'{/if}
                                   href="#"><span><strong>{$lang.Activate}</strong></span></a>
                                <a class="submiter menuitm menu-auto" name="suspend" {if $enablequeue}queue='push'{/if}
                                   href="#"><span>{$lang.Suspend}</span></a>
                                <a class="submiter menuitm menu-auto" {if $enablequeue}queue='push'{/if}
                                   name="unsuspend" href="#"><span>{$lang.Unsuspend}</span></a>
                                <a class="submiter menuitm confirm menu-auto" name="delete"
                                   {if $enablequeue}queue='push'{/if} href="#"><span
                                            style="color:#FF0000">{$lang.Terminate}</span></a>
                                -->
                                {/if}
                                
                                <span class="menu-auto-reset"></span>
                                <a class="menuitm setStatus" id="hd1" onclick="return false;" href="#"><span
                                            class="morbtn">{$lang.moreactions}</span></a>
                            </div>
                            <div class="clear"></div>
                        </div>
                        {securitytoken}
                    </form>
                    <div id="confirm_ord_delete" hidden bootbox data-title="{$lang.accdelheading}"
                         data-callback="confirmsubmit2" data-btnclass="btn-danger">

                        <form action="?cmd=accounts&make=fulldelete" method="post">
                            <p><strong>{$lang.accdeldescr}</strong></p>

                            <input type="radio" checked="checked" name="harddelete" value="true"
                                   class="cc_hard"/> {$lang.deleteopt1}<br/>
                            <input type="radio" name="harddelete" value="false" id="cc_soft"/> {$lang.deleteopt2}<br/>

                            {securitytoken}
                        </form>

                    </div>
                {literal}
                    <script type="text/javascript">

                        function confirm1() {
                            $('#confirm_ord_delete').trigger('show');
                            return false;
                        }

                        function confirmsubmit2() {
                            var add = '';
                            if ($('.bootbox-body input.cc_hard').is(':checked'))
                                add = '&harddelete=true';
                            ajax_update('?cmd=accounts&make=fulldelete&' + $.param($("#testform input[class=check]:checked")) + add, {stack: 'push'});
                            bootbox.hideAll()
                            return false;
                        }

                        function cancelsubmit2() {
                            $('#confirm_ord_delete').hide().parent().css('position', 'inherit');
                            return false;
                        }
                    </script>
                {/literal}
                {/if}
            </div>
        </td>
    </tr>
</table>