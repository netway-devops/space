<script type="text/javascript" src="{$system_url}templates/common/facebox/facebox.js"></script>
<link rel="stylesheet" href="{$system_url}templates/common/facebox/facebox.css" type="text/css"/>

<link href="templates/default/dist/plugins/datatables/dataTables.bootstrap.min.css" type="text/css" rel="stylesheet">
<script src="templates/default/dist/plugins/chartjs/Chartjs.min.js"></script>
<script src="templates/default/dist/plugins/datatables/jquery.dataTables.min.js"></script>
<script src="templates/default/dist/plugins/datatables/dataTables.bootstrap.min.js"></script>
<script type="text/javascript">{literal}
    var bPaginate = {
        "bFilter": false,
        "sPaginationType": "full_numbers",
        "bLengthChange": false,
        "iDisplayLength": 24,
        "aaSorting": []
    };
    function metteredBillinghistory() {
        $('#meteredusagelog').addLoader();
        var url = {/literal}'?cmd=accounts&action=edit&id={$details.id}&service={$details.id}&vpsdo=metered_history';{literal};
        $.post(url, {
            metered_period: $('#metered_period').val(),
            metered_interval: $('#metered_interval').val()
        }, function (data) {
            var r = parse_response(data);
            if (r) {
                var c = $('#meteredusagelog').empty().html(r).find('th');
                c.width(Math.floor(100 / c.length) + '%');
                if ($('#meteredusagelog table').length)
                    $('#meteredusagelog table').eq(0).dataTable(bPaginate);
            }
        });
        return false;
    }
    function bindMe() {
        $('#tabbedmenu').TabbedMenu({elem: '.tab_content', picker: 'li.tpicker', aclass: 'active'});
        if ($('#meteredusagelog table').length)
            $('#meteredusagelog table').eq(0).dataTable(bPaginate);
    }
    appendLoader('bindMe');
    {/literal}</script>
<form action="" method="post" id="account_form">
    <input type="hidden" value="{$details.firstpayment}" name="firstpayment"/>
    <input type="hidden" name="account_id" value="{$details.id}" id="account_id"/>
    <div class="blu">{include file='_common/accounts_nav.tpl'}</div>
    <div class="lighterblue" id="ChangeOwner" style="display:none;padding:5px;"></div>
    <div id="ticketbody">
        {include file='_common/accounts_billing.tpl'}
        <ul class="tabs" id="tabbedmenu">
            <li class="tpicker active"><a href="#tab1" onclick="return false">Provisioning</a></li>
            <li class="tpicker tab-license"><a href="#tab2" onclick="return false">License Info</a></li>
            <li class="tpicker tab-metered"><a href="#tab3" onclick="return false">Metered Billing</a></li>
            <li class="tpicker tab-metered"><a href="#tab4" onclick="return false">Quotas</a></li>
            <li class="tpicker">
                <a href="#tab5" onclick="return false">
                    Addons
                    <span id="numaddons" class="top_menu_count">{$details.addons}</span>
                </a>
            </li>
        </ul>
        <div class="tab_container">
            <div class="tab_content" style="display: block;">
                {include file='_common/accounts_details.tpl'}
            </div>
            <div class="tab_content" style="display: none;">
                <div class="sor" id="lcd_content">
                    <center><img src="{$template_dir}img/ajax-loading.gif"</center>
                    {literal}
                    <script type="text/javascript">
                        setTimeout(function () {
                            $.get('?cmd=accounts&action=edit&id={/literal}{$details.id}{literal}&do=getLicenseDetails', function (data) {
                                data = parse_response(data);
                                $('#lcd_content').html(data);
                            });
                        }, 500);
                    </script>
                    {/literal}
                </div>
            </div>
            <div class="tab_content" style="display: none;">
                {if !$metered_enable}
                    Metered billing is disabled for this package,
                    <a href="?cmd=services&action=product&id={$details.product_id}" target="_blank">click here to manage
                        metered billing pricing.</a>
                {else}
                    <table class="whitetable" width="100%" cellspacing="0" cellpadding="3">
                        {if $details.metered_type!='PrePay'}
                            <tr class="odd">
                                <td width="16%" align="right"><b>Billing period</b></td>
                                <td width="16%">{$details.previous_invoice|dateformat:$date_format}
                                    - {$details.next_invoice|dateformat:$date_format}</td>
                                <td width="16%" align="right"><b>Next invoice total</b></td>
                                <td width="16%"><b>{$details.metered_total|price:$details.currency}</b></td>

                                <td width="16%" align="right"><b>Fixed recurring charge</b></td>
                                <td width="16%">{$details.currency.sign}<input value="{$details.total}" name="total" size="4"/></td>
                            </tr>
                        {else}
                            <input value="{$details.total}" name="total" size="4" type="hidden"/>
                        {/if}
                        <tr class="odd">
                            <td colspan="6">
                                {if $details.metered_type!='PrePay'}
                                    <b>Next invoice details</b>
                                    <span class="fs11">updated hourly</span>
                                    <br/>
                                {/if}
                                <div class="report">
                                    {if $details.total>0}
                                        <div class="button">
                                            <span class="attr">{$lang[$details.billingcycle]}:</span>
                                            <span class="value">{$details.total|price:$details.currency_id}</span>
                                        </div>
                                    {/if}
                                    {foreach from=$metered_summary item=vr}
                                        <div class="button">
                                            <span class="attr">{$vr.name}:</span>
                                            <span class="value">{$vr.charge|price:$details.currency_id:true:false:true:4}</span>
                                        </div>
                                    {/foreach}
                                </div>
                            </td>
                        </tr>
                        <tr class="even">
                            <td colspan="4"></td>
                            <td colspan="2" style="text-align:right">
                                Interval: <select name="metered_interval" id="metered_interval" onchange="metteredBillinghistory()">
                                    <option value="1h">1 Hour</option>
                                    <option value="1d">1 Day</option>
                                </select>
                                Month (yyyy-mm): <select name="metered_period" id="metered_period" onchange="metteredBillinghistory()">
                                    {foreach from=$metered_periods item=p}
                                        <option value="{$p}">{$p}</option>
                                    {/foreach}
                                </select>
                            </td>
                        </tr>
                    </table>
                    {if $metered_usage_log}
                        <div id="meteredusagelog" style="width:100%">
                            {include file="`$cpanelmanagedir`metered_table.tpl"}
                        </div>
                    {else}
                        <table class="whitetable" width="100%" cellspacing="0" cellpadding="3">
                            <tr class="odd havecontrols">
                                <td align="center"><b>No data reported yet</b></td>
                            </tr>
                        </table>
                    {/if}
                {/if}
            </div>
            {if $showmetrics}
                <div class="tab_content" style="display: block;">
                    {include file='_common/accounts_metrics.tpl'}
                </div>
            {/if}
            <div class="tab_content" style="display: none;">
                {include file='_common/accounts_addons.tpl'}
            </div>
        </div>
        <div class="clear"></div>
        {include file='_common/accounts_multimodules.tpl'}
        {include file='_common/noteseditor.tpl'}
    </div>
    <div class="blu">{include file='_common/accounts_nav.tpl'}</div>
    {securitytoken}
</form>