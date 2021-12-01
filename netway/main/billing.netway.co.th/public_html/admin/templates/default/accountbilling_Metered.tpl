<ul class="accor">
    <li><a href="#">{if $lang[$billingmodel_name]}{$lang[$billingmodel_name]}{else}{$billingmodel_name}{/if}</a>
        <div class="sor">
                                                         
            <!--metered billing start-->
            {if !$metered_enable}
                    Metered billing is disabled for this package, <a href="?cmd=services&action=product&id={$details.product_id}" target="_blank">click here to manage metered billing pricing.</a>
            {else}
                <table class="whitetable" width="100%" cellspacing="0" cellpadding="3">
                     {if $details.metered_type!='PrePay'}<tr class="odd">
                        <td width="16%" align="right"><b>Billing period</b></td>
                        <td width="16%">{$details.previous_invoice|dateformat:$date_format} - {$details.next_invoice|dateformat:$date_format}</td>

                        <td width="16%" align="right"><b>Next invoice total</b></td>
                        <td width="16%"><b>{$details.metered_total|price:$details.currency}</b></td>

                        <td width="16%" align="right"></td>
                        <td width="16%"></td>
                        </tr>
                    {else}
                    {/if}
                    <tr class="odd">
                        <td colspan="6">
                            {if $details.metered_type!='PrePay'}<b>Next invoice details</b><br/>{/if}
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

                                <div data-toggle="modal" data-target="#add-usage" class="button"
                                     style="background: #8bc34a; color: white; cursor: pointer; box-shadow: none;">
                                    <span class="attr"><i class="fa fa-plus" aria-hidden="true"></i></span>
                                    <span class="value">Add usage</span>
                                </div>
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
                            </select></td>
                    </tr>
                </table>
                {if $metered_usage_log}<div id="meteredusagelog" style="width:100%">
                        {include file="ajax.accountbilling_Metered.tpl"}

                    </div>
                    <div class="clear"></div>
                <br/><b>Legend</b>
                    <table class="whitetable fs11" width="100%" cellspacing="0" cellpadding="3">
                        {foreach from=$metered_usage_log.variables item=vr}
                            <tr class="even">
                                <td width="150"><b>{$vr.name}</b></td>
                                <td>{$vr.description}</td>

                            </tr>
                        {/foreach}
                    </table>

                {else}
                    <table class="whitetable" width="100%" cellspacing="0" cellpadding="3">
                        <tr class="odd havecontrols">
                            <td align="center"><b>No data reported yet</b></td>
                        </tr>

                    </table>

                {/if}
              
               
            {/if}
            <!--eof: metered billing -->
        </div>
    </li>
</ul>


<div class="modal fade" tabindex="-1" role="dialog" id="add-usage">
    <div class="modal-dialog" role="document">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                    <span aria-hidden="true">&times;</span>
                </button>
                <h4 class="modal-title">Add usage</h4>
            </div>
            <div class="modal-body">
                {foreach from=$pricebrackets item=var}
                    <div style="margin-bottom: 15px;">
                        <div style="font-weight: bold">{$var.name}</div>
                        <div class="input-group">
                            <input type="number" class="form-control" name="usage[{$var.variable_name}]">
                            <span class="input-group-addon">/{$var.unit_name}</span>
                        </div>
                    </div>
                {/foreach}
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
                <button class="btn btn-primary" onclick="metteredBillingAddUsage();return false;">Add usage</button>
            </div>
        </div>
    </div>
    {securitytoken}
</div>

<br/>
{literal}
<link rel="stylesheet" href="../includes/types/widgets/meteredwidget/demo_table.css" type="text/css"/>
<script type="text/javascript" src="../includes/types/widgets/meteredwidget/jquery.dataTables.min.js?v={/literal}{$hb_version}{literal}"></script>
<script type="text/javascript">
    var bPaginate = {
        "bFilter": false,
        "sPaginationType": "full_numbers",
        "bLengthChange": false,
        "iDisplayLength": 24,
        "aaSorting": []
    };
    function metteredBillinghistory() {
        $('#meteredusagelog').addLoader();
        var url = {/literal}'?cmd=accounts&action=edit&id={$details.id}&service={$details.id}&do=metered_history';{literal};
                $.post(url,{metered_period:$('#metered_period').val(),metered_interval:$('#metered_interval').val()},function(data){
            var r = parse_response(data);
            if (r) {
                var c = $('#meteredusagelog').empty().html(r).find('th');
                c.width(Math.floor(100 / c.length) + '%');
                $('#meteredusagelog table').eq(0).dataTable(bPaginate);
            }
        });
        return false;
    }

    function metteredBillingAddUsage() {
        $('#account_form').addLoader();
        var url = {/literal}'?cmd=accounts&action=edit&id={$details.id}&service={$details.id}&do=add_usage';{literal}
        var post = $('#add-usage .modal-body :input').serialize();
        $.post(url, post, function (data) {$('#add-usage').modal('hide');location.reload();});
        return false;
    }

    function bindMe() {
        $('#tabbedmenu').TabbedMenu({elem: '.tab_content', picker: 'li.tpicker', aclass: 'active'});
        $('#meteredusagelog table').eq(0).dataTable(bPaginate);
    }
    appendLoader('bindMe');
</script>
{/literal}