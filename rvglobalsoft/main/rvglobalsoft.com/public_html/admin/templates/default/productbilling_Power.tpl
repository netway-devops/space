<div id="Power_b" {if $product.paytype!='Power'}style="display:none"{/if} class="p5 boption">
    {if $typetemplates.productconfig.bandwidth.replace}
        {include file=$typetemplates.productconfig.bandwidth.replace}
    {else}


        <div id="bandwidthmgr" >
            <div style="">

                {*   <b>Following variables can be measued and billed automatically: <a title="Note: Fill price rules below with amounts you wish to charge <b>over</b> whats offered with this package as standard. Ending QTY set to 0 means &infin; (infinity)
                <br/> I.e. 100GB traffic/month is free with package, everything over that should be configured with metered billing table." class="vtip_description"></a></b>
                <div class="clear"></div>
                *}




                <div class="clear"></div>
                <table width="100%" cellspacing="0" cellpadding="6" border="0">
                    <tr>
                        <td width="160" >Generate usage invoices</td>
                        <td >
                            <select name="config[PowerCycle]" class="inp">
                                <option value="Monthly" {if $configuration.PowerCycle=='Monthly'}selected="selected"{/if}>{$lang.Monthly}</option>
                                <option value="Quarterly" {if $configuration.PowerCycle=='Quarterly'}selected="selected"{/if}>{$lang.Quarterly}</option>
                                <option value="Semi-Annually" {if $configuration.PowerCycle=='Semi-Annually'}selected="selected"{/if}>{$lang.SemiAnnually}</option>
                                <option value="Annually" {if $configuration.PowerCycle=='Annually'}selected="selected"{/if}>{$lang.Annually}</option>
                            </select>

                        </td>
                    </tr>
                    <tr>
                        <td >kW/h Price</td>
                        <td>{$currency.sign} <input type="text" class="inp" size="6"  value="{if $configuration.kwh}{$configuration.kwh|price:$currency:false}{else}{0.00|price:$currency:false}{/if}" name="config[kwh]" /> {$currency.code}</td>
                    </tr>
                    <tr>
                        <td >Setup fee</td>
                        <td>{$currency.sign} <input type="text" class="inp" size="6"  value="{if $configuration.SetupFee}{$configuration.SetupFee|price:$currency:false}{else}{0.00|price:$currency:false}{/if}" name="config[SetupFee]" /> {$currency.code}</td>
                    </tr>
                    <tr>
                        <td>Fixed recurring fee <a title="Fixed amount, recurring charge for service" class="vtip_description"></a></td>
                        <td>{$currency.sign} <input type="text" class="inp" size="6" value="{if $configuration.RecurringFee}{$configuration.RecurringFee|price:$currency:false}{else}{0.00|price:$currency:false}{/if}" name="config[RecurringFee]" /> {$currency.code}</td>
                    </tr>

                </table></div></div>

        {literal}
            <script type="text/javascript">
                function change_measurement(select) {
                    $('#byte').hide();
                    $('#bit').hide();
                    $('#obyte').hide();
                    $('#obit').hide();
                    if ($(select).val() == '95th' || $(select).val() == 'average') {
                        $('#bit').show();
                        $('#obit').show();
                    } else {
                        $('#byte').show();
                        $('#obyte').show();
                    }
                }

                function importPowerForm(filename) {

                    if ($('#product_id').val() == 'new') {
                        alert('Please save your product first');
                        return;
                    }
                    var field = false;
                    switch (filename) {
                        case 'transfer_by_admin':
                            field = '#configvar_tw_override';
                            break;
                        case 'overage_by_admin':
                            field = '#configvar_bw_override';
                            break;
                        default:
                            field = '#configvar_bandwidth_method';
                            filename = 'bandwidth_form';
                            $('#bwclient_info').show();
                            $('.bw_tohide').hide();
                            break;
                    }
                    if ($(field).length) {
                        $('#components_tab a').click();
                        editCustomFieldForm($(field).val(), $('#product_id').val());
                        return;
                    }

                    $.post('?cmd=coloutils&action=importbandwidthforms', {product_id: $('#product_id').val(), file: filename}, function() {
                        refreshConfigView($('#product_id').val());
                        $('#components_tab a').click();

                    });
                    return;
                }
                $(document).ready(function() {
                    if ($('#configvar_bandwidth_method').length) {
                        $('#bandwidth_by_client').attr('checked', 'checked');
                        $('#bwclient_info').show();
                        $('.bw_tohide').hide();
                    }

                    if ($('#configvar_tw_override').length) {
                        $('#transfer_by_admin').attr('checked', 'checked');
                    }

                    if ($('#configvar_bw_override').length) {
                        $('#overage_by_admin').attr('checked', 'checked');
                    }
                });
            </script>
            <style type="text/css">
                .scheme_container {
                    margin:10px 0px 10px 80px;
                    padding:10px;
                    background:#F0F0F3;
                    border-radius:5px;
                    float:left;
                    color:#767679;
                }
            </style>
        {/literal}




    {/if}
</div>