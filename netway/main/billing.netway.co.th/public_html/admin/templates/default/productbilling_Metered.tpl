<div id="Metered_b" {if $product.paytype!='Metered'}style="display:none"{/if} class="p5 boption">
    {if $typetemplates.productconfig.metered.replace}
        {include file=$typetemplates.productconfig.metered.replace}
    {else}
        <div id="meteredmgr">

            <div style="">
            <b>Following variables can be measued and billed automatically: <a title="Note: Fill price rules below with amounts you wish to charge <b>over</b> whats offered with this package as standard. Ending QTY set to 0 means &infin; (infinity)
            <br/> I.e. 100GB traffic/month is free with package, everything over that should be configured with metered billing table." class="vtip_description"></a></b>
                <div class="clear"></div>

                <a style="margin: 20px 0;" href="#" class="new_control" onclick="$('#metered-add-variable').show();$(this).hide();return false;">
                    <span class="addsth"><strong>Add new variable</strong></span>
                </a>

                <ul style="list-style:none;padding:0px;margin:20px 0;display: none;" id="metered-add-variable">
                    <li style="background:#fff5df; padding: 10px 0;">
                        <div>
                            <table width="100%" cellspacing="0" cellpadding="5" border="0">
                                <tbody>
                                <tr>
                                    <td></td>
                                    <td colspan="2"><b>New variable</b></td>
                                </tr>
                                <tr>
                                    <td></td>
                                    <td colspan="2">
                                        <div class="form-inline" style="margin-bottom: 10px;">
                                            <div class="form-group" style="margin-right: 10px;">
                                                <div  class="fs11">Name</div>
                                                <input type="text" style="width: 300px;" placeholder="Name" class="form-control" name="metered[new][name]">
                                            </div>
                                            <div class="form-group" style="margin-right: 10px;">
                                                <div  class="fs11">Unit</div>
                                                <input type="text" style="width: 120px;" placeholder="Example: Hour" class="form-control metered_unit_set" name="metered[new][unit]">
                                            </div>
                                            <div class="form-group" style="margin-right: 10px;">
                                                <div  class="fs11">Variable</div>
                                                <input type="text" style="width: 300px;" placeholder="Example: metered_variable" class="form-control" name="metered[new][variable]">
                                            </div>
                                        </div>
                                        <div class="form-inline" style="margin-bottom: 15px;">
                                            <div class="form-group" style="margin-right: 15px;">
                                                <input id="dont_accumulate" type="checkbox" name="metered[new][options][]" value="8">
                                                <label for="dont_accumulate">Don't accumulate <i class="vtip_description" title="When enabled previous readouts within given billing cycle would not accumulate. This will cause only last readout to be billed"></i></label>
                                            </div>
                                            <div class="form-group" style="margin-right: 15px;">
                                                <input id="reset_each_period" type="checkbox" name="metered[new][options][]" value="2">
                                                <label for="reset_each_period">Reset each period <i class="vtip_description" title="When enabled HostBill will remove data from previous variable values for given account during invoice generation"></i></label>
                                            </div>
                                        </div>
                                        <table border="0" cellpadding="3" class="left" cellspacing="0" id="new_table" >
                                            <tr>
                                                <td width="100" class="fs11">Starting QTY</td>
                                                <td width="100" class="fs11">Ending QTY</td>
                                                <td width="150" class="fs11">Unit price</td>
                                            </tr>
                                            <tr >
                                                <td><input type="text" class="inp" size="6" value="0" name="metered[new][prices][0][qty]" /></td>
                                                <td><input type="text" class="inp" size="6" value="" name="metered[new][prices][0][qty_max]"  /></td>
                                                <td><input type="text" class="inp" size="6" value="{0.000|price:$currency:false:false}"  name="metered[new][prices][0][price]" /> /<span class="metered_unit_new"></span></td>
                                                <td><a class="fs11" href="#" onclick="return removeRow(this)">Remove</a></td>
                                            </tr>
                                        </table>
                                        <div class="scheme_container" >
                                            <div>
                                                Pricing scheme:
                                                <select class="inp metered_scheme" data-rel="new" name="metered[new][scheme]">
                                                    <option {if $varx.scheme=='tiered'}selected="selected"{/if} value="tiered">Tiered</option>
                                                    <option {if $varx.scheme=='overage'}selected="selected"{/if} value="overage">Overage</option>
                                                    <option {if $varx.scheme=='volume'}selected="selected"{/if} value="volume">Volume</option>
                                                    <option {if $varx.scheme=='peak'}selected="selected"{/if} value="peak">Peak</option>
                                                    <option {if $varx.scheme=='stairstep'}selected="selected"{/if} value="stairstep">Stairstep</option>
                                                </select>
                                                <a class="vtip_description" title="{$lang.metteredschemes}"></a>
                                            </div>
                                        </div>
                                        <div class="clear"></div>
                                        <div class="bracketsummary">
                                            <a onclick="return addBracket('new',' /<span class=\'metered_unit_new\'></span>');" class="prices menuitm" href="#" >
                                                <span  class="addsth">Add price bracket</span>
                                            </a>
                                        </div>
                                    </td></tr>
                                </tbody>
                            </table>
                        </div>
                    </li>
                </ul>

                <hr>

                <ul style="list-style:none;padding:0px;margin:0px;"  >
                    {foreach from=$product.metered item=varx key=k}
                        <li style="background:#ffffff">
                            <div >
                                <table width="100%" cellspacing="0" cellpadding="5" border="0">
                                    <tbody>
                                    <tr>
                                        <td width="70" valign="top"><div style="padding:10px 0px;"><a onclick="return var_toggle('{$k}',true);"  id="enabler_{$k}" class="prices menuitm " {if $varx.enable}style="display:none"{/if} href="#"><span  class="addsth">Enable</span></a>
                                                <a onclick="return var_toggle('{$k}',false);" class="prices menuitm " href="#" {if !$varx.enable}style="display:none"{/if} id="disabler_{$k}"><span  class="rmsth">Disable</span></a></div></td>
                                        <td width="300"><b>{$varx.name}</b></td>
                                        <td valign="top" {if $varx.description}style="background:#F0F0F3;color:#767679;font-size:11px"{/if}>{$varx.description}
                                            {if $varx.user_defined}
                                                <span class="right fs11">API variable: <b>{$k}</b>
                                                <a class="editbtn" onclick="return rmMeteredVar('{$k}')" href="">Delete this var</a></span>
                                            {/if}
                                        </td>
                                    </tr>
                                    <tr id="var_{$k}"  {if !$varx.enable}style="display:none"{/if}>
                                        <td></td>
                                        <td colspan="2">
                                            <input type="hidden" name="metered[{$k}][enable]" value="{if !$varx.enable}0{else}1{/if}" id="{$k}_enable" class="enablr" />
                                            <input type="hidden" name="metered[{$k}][id]" value="{$varx.id}"  />
                                            <table border="0" cellpadding="3" class="left" cellspacing="0" id="{$k}_table" >
                                                <tr>
                                                    <td width="100" class="fs11">Starting QTY</td>
                                                    <td width="100" class="fs11">Ending QTY</td>
                                                    <td width="150" class="fs11"><span class="metered_unit_{$k}">Unit</span> price</td>
                                                </tr>
                                                {if !$varx.prices}
                                                    <tr >
                                                        <td><input type="text" class="inp" size="6" value="0" name="metered[{$k}][prices][0][qty]" /></td>
                                                        <td><input type="text" class="inp" size="6" value="" name="metered[{$k}][prices][0][qty_max]"  /></td>
                                                        <td><input type="text" class="inp" size="6" value="{0.000|price:$currency:false:false}"  name="metered[{$k}][prices][0][price]" /> <span class="metered_unit_{$k}">/{$varx.unit_name}</span></td>
                                                        <td><a class="fs11" href="#" onclick="return removeRow(this)">Remove</a></td>
                                                    </tr>
                                                {/if}
                                                {foreach from =$varx.prices item=p key=kx}
                                                    <tr >
                                                        <td><input type="text" class="inp" size="6" value="{$p.qty}" name="metered[{$k}][prices][{$kx}][qty]" /></td>
                                                        <td><input type="text" class="inp" size="6" value="{$p.qty_max}" name="metered[{$k}][prices][{$kx}][qty_max]"  /></td>
                                                        <td><input type="text" class="inp" size="6" value="{$p.price|price:$currency:false}"  name="metered[{$k}][prices][{$kx}][price]" /> <span class="metered_unit_{$k}">/{$varx.unit_name}</span></td>
                                                        <td><a class="fs11" href="#" onclick="return removeRow(this)">Remove</a></td>
                                                    </tr>
                                                {/foreach}
                                            </table>
                                            <div class="scheme_container" >
                                                <div>
                                                    Pricing scheme:
                                                    <select class="inp metered_scheme" data-rel="{$k}" name="metered[{$k}][scheme]">
                                                        <option {if $varx.scheme=='tiered'}selected="selected"{/if} value="tiered">Tiered</option>
                                                        <option {if $varx.scheme=='overage'}selected="selected"{/if} value="overage">Overage</option>
                                                        <option {if $varx.scheme=='volume'}selected="selected"{/if} value="volume">Volume</option>
                                                        <option {if $varx.scheme=='peak'}selected="selected"{/if} value="peak">Peak</option>
                                                        <option {if $varx.scheme=='stairstep'}selected="selected"{/if} value="stairstep">Stairstep</option>
                                                    </select>
                                                    <a class="vtip_description" title="{$lang.metteredschemes}"></a>
                                                </div>

                                            </div>

                                            <div class="clear"></div>
                                            <div class="bracketsummary">
                                                <a onclick="return addBracket('{$k}',' <span class=\'metered_unit_{$k}\'>/{$varx.unit_name}</span>');"   class="prices menuitm" href="#" ><span  class="addsth">Add price bracket</span></a>
                                               <label {if !$varx.id}title="Save this variable first"{/if}>
                                                   <input type="checkbox" {if $varx.id}rel="{$varx.id}"
                                                          data-relname="{$varx.name}"
                                                          id="checkb_meteredoverride_{$varx.id}"
                                                          {else}disabled{/if}
                                                          class="meteredformchecker">
                                                   Enable price override per account
                                               </label>
                                            </div>
                                            {if $varx.options & 32}
                                                <div class="alert alert-info" role="alert">
                                                    Add usage for metered billing variable: <br>
                                                    <input style="width: 100%; margin-bottom: 5px;" type="text" readonly="readonly" value="{$system_url}admin/api.php?call=meteredAddUsage&variable={$varx.variable_name}&account_id=[ACCOUNT_ID]&qty=[QTY]&api_id=[API_ID]&api_key=[API_KEY]">
                                                    See more: <a href="http://api.hostbillapp.com/invoices/meteredAddUsage/ " target="_blank"  rel="noreferrer noopener nofollow">Metered Billing: Add usage</a>
                                                </div>
                                            {/if}
                                        </td>
                                    </tr>
                                    </tbody>
                                </table>
                            </div>

                            <hr>
                        </li>
                    {/foreach}
                </ul>

                {if $product.metered_editor}
                    {include file=$product.metered_editor}
                {/if}

                <div class="clear"></div>
                <table width="100%" cellspacing="0" cellpadding="6" border="0">
                    <tr>
                        <td width="160" style="background:#F0F0F3">Generate usage invoices</td>
                        <td style="background:#F0F0F3">
                            <select name="config[MeteredCycle]" class="inp">
                                <option value="Monthly" {if $configuration.MeteredCycle=='Monthly'}selected="selected"{/if}>{$lang.Monthly}</option>
                                <option value="Semi-Annually" {if $configuration.MeteredCycle=='Semi-Annually'}selected="selected"{/if}>{$lang.SemiAnnually}</option>
                                <option value="Annually" {if $configuration.MeteredCycle=='Annually'}selected="selected"{/if}>{$lang.Annually}</option>
                            </select>

                        </td>
                    </tr>
                    <tr>
                        <td >Setup fee</td>
                        <td>{$currency.sign} <input type="text" class="inp" size="6"  value="{if $configuration.MeteredSetupFee}{$configuration.MeteredSetupFee|price:$currency:false}{else}{0|price:$currency:false:false}{/if}" name="config[MeteredSetupFee]" /> {$currency.code}</td>
                    </tr>
                    <tr>
                        <td>Fixed recurring fee <a title="Additional, fixed amount, recurring charge for service" class="vtip_description"></a></td>
                        <td>{$currency.sign} <input type="text" class="inp" size="6" value="{if $configuration.MeteredRecurringFee}{$configuration.MeteredRecurringFee|price:$currency:false}{else}{0|price:$currency:false:false}{/if}" name="config[MeteredRecurringFee]" /> {$currency.code}</td>
                    </tr>

                </table>
            </div>
        </div>

        <script type="text/javascript">
            var zeroamount = '{0.000|price:$currency:false:false}';;
            {literal}
            function removeRow(el) {
                $(el).parents('tr').eq(0).remove();
                return false;
            }
            $('.metered_scheme').change(
                function(){
                    var target = '.metered_unit_' + $(this).data('rel');
                    if($(this).val() == 'stairstep') {
                        $(target).hide();
                    } else {

                        $(target).show();
                    }
                }
            );
            $('.meteredformchecker').unbind('click').click(function () {
                var self = $(this),
                    index = self.attr('rel'),
                    relname = self.data('relname');
                var pid = $('#product_id').val();

                if (!index) {
                    alert('Please save changes for default pricing first');
                    return false;
                }


                var rel = 'meteredoverride_' + self.attr('rel').replace(/[^a-z0-9A-Z_\-]/g, '');


                if (!self.is(':checked')) {
                    if (!confirm('Are you sure you want to remove related Form element?')) {
                        return false;
                    }
                    if ($('#configvar_' + rel).length) {
                        ajax_update('?cmd=configfields&make=delete', {
                            id: $('#configvar_' + rel).val(),
                            product_id: pid
                        }, '#configeditor_content');
                    }
                } else {
                    NProgress.start();

                    var fields = $('form#productedit').serialize();

                    $.post('?cmd=metteredbilling&action=addmeteredoverride',
                        {
                            variableid: rel,
                            metered_id: index,
                            variablename: relname,
                            id: pid
                        }, function (data) {
                            var r = parse_response(data);
                            if (r) {
                                ajax_update('?cmd=configfields', {
                                    product_id: pid,
                                    action: 'loadproduct'
                                }, '#configeditor_content');
                            }
                        });
                }
            })
            $(document).ready(function () {
                $('.metered_scheme').change();
            })
            function addBracket(v,j) {
                var t = $('#'+v+'_table');
                if(!t.length)
                    return false;
                var i = t.find('tr').length;
                var br=t.find('tr:last').find('input').eq(1).val()?parseInt(t.find('tr:last').find('input').eq(1).val()):'';
                var ht='<tr >'
                    +'<td><input type="text" class="inp" size="6" value="'+br+'"  name="metered['+v+'][prices]['+i+'][qty]" /></td>'
                    +'<td><input type="text" class="inp" size="6" value=""   name="metered['+v+'][prices]['+i+'][qty_max]" /></td>'
                    +'<td><input type="text" class="inp" size="6" value="'+zeroamount+'"   name="metered['+v+'][prices]['+i+'][price]" /> '+j+'</td>'
                    +'<td><a class="fs11" href="#"  onclick="return removeRow(this)">Remove</a></td>'
                    +'</tr>';
                t.append(ht);
                t.find('.metered_unit_new').html($('.metered_unit_set').val());
                return false;
            }
            function var_toggle(v,e) {
                if(e) {
                    $('#enabler_'+v).hide();
                    $('#disabler_'+v).show();
                    $('#var_'+v).show();
                    $('#'+v+'_enable').val(1);
                } else {
                    $('#enabler_'+v).show();
                    $('#disabler_'+v).hide();
                    $('#var_'+v).hide();
                    $('#'+v+'_enable').val(0);
                }
                return false;
            }

            $('.metered_unit_set').on('change input', function () {
               $('.metered_unit_new').html($(this).val());
            });
            {/literal}
        </script>

    {/if}
</div>