
<div id="meteredmgr" >
    <div style="padding: 5px;">

        Following variables can be measued and billed automatically: <a title="Note: With this feature you can bill customer for actual resources usage/overusage. Usage is automatically updated hourly" class="vtip_description"></a>

        <div class="clear" style="margin-top:10px;"></div>

        <ul id="tabbedmenu2" class="tabs">
            <li class="tpicker active"><a onclick="return false" href="#tab1">Resources pricing<span  class="top_menu_count">0</span></a></li>
            <li class="tpicker"><a onclick="return false" href="#tab2">Usage pricing<span  class="top_menu_count">0</span></a></li>
            <li class="tpicker"><a onclick="return false" href="#tab3">Off pricing<span  class="top_menu_count">0</span></a></li>
        </ul>
        <div class="clear"></div>
        <div style="border: solid 1px #CCCCCC;border-top:none;border-bottom:none;">
            <ul style="list-style:none;padding:0px;margin:0px;"  id="list_resources" class="tab_content">
                {foreach from=$product.metered item=varx key=k} {if $varx.group=='resources'}
                <li style="background:#ffffff"><div >
                        <table width="100%" cellspacing="0" cellpadding="5" border="0">
                            <tbody><tr>
                                    <td width="70" valign="top"><div style="padding:10px 0px;"><a onclick="return var_toggle('{$k}',true);"  id="enabler_{$k}" class="prices menuitm " {if $varx.enable}style="display:none"{/if} href="#"><span  class="addsth">Enable</span></a>
                                            <a onclick="return var_toggle('{$k}',false);" class="prices menuitm " href="#" {if !$varx.enable}style="display:none"{/if} id="disabler_{$k}"><span  class="rmsth">Disable</span></a></div></td>
                                    <td width="150"><b>{$varx.name}</b></td>
                                    <td >
                                        <div id="var_{$k}"  {if !$varx.enable}style="display:none"{/if}>
                                             <input type="hidden" name="metered[{$k}][enable]" value="{if !$varx.enable}0{else}1{/if}" id="{$k}_enable" class="enablr" />
                                            <input type="hidden" name="metered[{$k}][id]" value="{$varx.id}"  />
                                            <input type="hidden"  value="0" name="metered[{$k}][prices][0][qty_max]"  />
                                            <input type="hidden"  value="unit" name="metered[{$k}][scheme]"  />
                                            <input value="0" name="metered[{$k}][prices][0][qty]"  type="hidden"/>
                                            Price per hour: <input type="text" class="inp" size="4" value="{if !$varx.prices}{0.000|price:$currency:false:false}{else}{$varx.prices[0].price|price:$currency:false}{/if}"  name="metered[{$k}][prices][0][price]" /> per 1  {$varx.unit_name}
                                        </div>
                                    </td>
                                </tr>

                            </tbody></table></div></li>
                {/if}

                {/foreach}
            </ul>


            <ul style="list-style:none;padding:0px;margin:0px; display: none"   id="list_usage" class="tab_content">
                {foreach from=$product.metered item=varx key=k} {if $varx.group=='usage'}
                <li style="background:#ffffff"><div >
                        <table width="100%" cellspacing="0" cellpadding="5" border="0">
                            <tbody><tr>
                                    <td width="70" valign="top"><div style="padding:10px 0px;"><a onclick="return var_toggle('{$k}',true);"  id="enabler_{$k}" class="prices menuitm " {if $varx.enable}style="display:none"{/if} href="#"><span  class="addsth">Enable</span></a>
                                            <a onclick="return var_toggle('{$k}',false);" class="prices menuitm " href="#" {if !$varx.enable}style="display:none"{/if} id="disabler_{$k}"><span  class="rmsth">Disable</span></a></div></td>
                                    <td width="300"><b>{$varx.name}</b></td>
                                    <td valign="top" {if $varx.description}style="background:#F0F0F3;color:#767679;font-size:11px"{/if}>{$varx.description}</td>
                                </tr>
                                <tr  id="var_{$k}"  {if !$varx.enable}style="display:none"{/if}><td></td><td colspan="2">
                                        <input type="hidden" name="metered[{$k}][enable]" value="{if !$varx.enable}0{else}1{/if}" id="{$k}_enable" class="enablr" />
                                        <input type="hidden" name="metered[{$k}][id]" value="{$varx.id}"  />
                                        <table border="0" cellpadding="3" class="left" cellspacing="0" id="{$k}_table" >
                                            <tr>
                                                <td width="100" class="fs11">Starting QTY</td>
                                                <td width="100" class="fs11">Ending QTY</td>
                                                <td width="150" class="fs11">Unit price</td>
                                            </tr>
                                            {if !$varx.prices}
                                            <tr >
                                                <td><input type="text" class="inp" size="3" value="0" name="metered[{$k}][prices][0][qty]" /></td>
                                                <td><input type="text" class="inp" size="3" value="" name="metered[{$k}][prices][0][qty_max]"  /></td>
                                            <td><input type="text" class="inp" size="3" value="{0.000|price:$currency:false:false}"  name="metered[{$k}][prices][0][price]" /> /{$varx.unit_name}</td>
                                                <td><a class="fs11" href="#" onclick="return removeRow(this)">Remove</a></td>
                                            </tr>
                                            {/if}
                                            {foreach from =$varx.prices item=p key=kx}
                                            <tr >
                                                <td><input type="text" class="inp" size="3" value="{$p.qty}" name="metered[{$k}][prices][{$kx}][qty]" /></td>
                                                <td><input type="text" class="inp" size="3" value="{$p.qty_max}" name="metered[{$k}][prices][{$kx}][qty_max]"  /></td>
                                            <td><input type="text" class="inp" size="3" value="{$p.price|price:$currency:false}"  name="metered[{$k}][prices][{$kx}][price]" /> /{$varx.unit_name}</td>
                                                <td><a class="fs11" href="#" onclick="return removeRow(this)">Remove</a></td>
                                            </tr>
                                            {/foreach}
                                        </table>
                                        <div class="scheme_container" >
                                            Pricing scheme:
                                            <select class="inp" name="metered[{$k}][scheme]">
                                                <option {if $varx.scheme=='tiered'}selected="selected"{/if} value="tiered">Tiered</option>
                                                <option {if $varx.scheme=='overage'}selected="selected"{/if} value="overage">Overage</option>
                                                <option {if $varx.scheme=='volume'}selected="selected"{/if} value="volume">Volume</option>
                                                <option {if $varx.scheme=='stairstep'}selected="selected"{/if} value="stairstep">Stairstep</option>
                                            </select>
                                            <a class="vtip_description" title="{$lang.metteredschemes}"></a>
                                        </div>

                                        <div class="clear"></div><div style="padding:15px 0px 10px;"><a onclick="return addBracket('{$k}',' /{$varx.unit_name}');"   class="prices menuitm " href="#"><span  class="addsth">Add price bracket</span></a></div>
                                    </td></tr>
                            </tbody></table></div></li>
                {/if}{/foreach}
            </ul>


            <ul style="list-style:none;padding:0px;margin:0px;"  id="list_resources_off" class="tab_content">
                <li style="background:#ffffff"><div >
                        You can additionally set prices per resource below when VM is powered off. Set to 0 if no charge should be applied.
                    </div></li>
                {foreach from=$product.metered item=varx key=k} {if $varx.group=='resources_off'}
                <li style="background:#ffffff"><div >
                        <table width="100%" cellspacing="0" cellpadding="5" border="0">
                            <tbody><tr>
                                    <td width="70" valign="top"><div style="padding:10px 0px;"><a onclick="return var_toggle('{$k}',true);"  id="enabler_{$k}" class="prices menuitm " {if $varx.enable}style="display:none"{/if} href="#"><span  class="addsth">Enable</span></a>
                                            <a onclick="return var_toggle('{$k}',false);" class="prices menuitm " href="#" {if !$varx.enable}style="display:none"{/if} id="disabler_{$k}"><span  class="rmsth">Disable</span></a></div></td>
                                    <td width="150"><b>{$varx.name}</b></td>
                                    <td >
                                        <div id="var_{$k}"  {if !$varx.enable}style="display:none"{/if}>
                                             <input type="hidden" name="metered[{$k}][enable]" value="{if !$varx.enable}0{else}1{/if}" id="{$k}_enable" class="enablr" />
                                            <input type="hidden" name="metered[{$k}][id]" value="{$varx.id}"  />
                                            <input type="hidden"  value="0" name="metered[{$k}][prices][0][qty_max]"  />
                                            <input type="hidden"  value="unit" name="metered[{$k}][scheme]"  />
                                            <input value="0" name="metered[{$k}][prices][0][qty]"  type="hidden"/>
                                            Price per hour: <input type="text" class="inp" size="4" value="{if !$varx.prices}{0.000|price:$currency:false:false}{else}{$varx.prices[0].price|price:$currency:false}{/if}"  name="metered[{$k}][prices][0][price]" /> per 1  {$varx.unit_name}
                                        </div>
                                    </td>
                                </tr>

                            </tbody></table></div></li>
                {/if}

                {/foreach}
            </ul>
        </div>

        <div class="clear"></div>
        <div style="background:#F0F0F3;border: solid 1px #CCCCCC;">
            <table width="100%" cellspacing="0" cellpadding="6" border="0">
                <tr>
                    <td width="160" >Billing type <a title="<b>Post Pay</b> - Client pays for used resources by the end of billing period<br><br>
                     <b>Pre Pay</b> - Initial fee is used as credit, which will be deducted automatically based on resources usage. Min. credit threshold can be set that will automatically generate next invoice, to avoid sudden suspension/downtimes. 
                     <br>Once account credit reach 0 account will be suspended <br/>Do not use Form elements with pre-paid billing.
                     " class="vtip_description"></a></td>
                    <td >
                        <select name="config[MeteredBType]" class="inp" onchange="c_btype(this)"  id="metered_btype">
                            <option value="PostPay" {if $configuration.MeteredBType=='PostPay' || !$configuration.MeteredBType}selected="selected"{/if}>Post-Paid</option>
                            <option value="PrePay" {if $configuration.MeteredBType=='PrePay'}selected="selected"{/if}>Pre-Paid</option>
                        </select>
                    </td>
                </tr>
                <tr>
                    <td width="160" >Generate invoices <a title="Determines how often invoices should be generated for this service" class="vtip_description"></a></td>
                    <td >
                        <select name="config[MeteredCycle]" class="inp">
                            <option value="Monthly" {if $configuration.MeteredCycle=='Monthly'}selected="selected"{/if}>{$lang.Monthly}</option>
                            <option value="Semi-Annually" {if $configuration.MeteredCycle=='Semi-Annually'}selected="selected"{/if}>{$lang.SemiAnnually}</option>
                            <option value="Annually" {if $configuration.MeteredCycle=='Annually'}selected="selected"{/if}>{$lang.Annually}</option>
                        </select>
                    </td>
                </tr>
                <tr>
                    <td ><span id="sfee" {if $configuration.MeteredBType=='PrePay'}style="display:none"{/if}>Setup fee</span><span {if $configuration.MeteredBType!='PrePay'}style="display:none"{/if} id="ifee">Initial credit <a title="This is initial funds client will be asked to add during signup" class="vtip_description"></a></span></td>
                    <td>{$currency.sign} <input type="text" class="inp" size="4"  value="{if $configuration.MeteredSetupFee}{$configuration.MeteredSetupFee|price:$currency:false}{else}{0.000|price:$currency:false:false}{/if}" name="config[MeteredSetupFee]" /> {$currency.code}</td>
                </tr>

                <tr {if $configuration.MeteredBType!='PrePay'}style="display:none"{/if} id="metered_threshold">
                    <td >Credit treshold <a title="Once account credit balance will reach this level, new invoice to top-up credit will be generated" class="vtip_description"></a></td>
                    <td>{$currency.sign} <input type="text" class="inp" size="4"  value="{if $configuration.MeteredThreshold}{$configuration.MeteredThreshold|price:$currency:false}{else}{0.000|price:$currency:false:false}{/if}" name="config[MeteredThreshold]" /> {$currency.code}</td>
                </tr>
                <tr {if $configuration.MeteredBType=='PrePay'}style="display:none"{/if} id="metered_recurring_fee">
                    <td>Fixed recurring fee <a title="Additional, fixed amount, recurring charge for service" class="vtip_description"></a></td>
                    <td>{$currency.sign} <input type="text" class="inp" size="4" value="{if $configuration.MeteredRecurringFee}{$configuration.MeteredRecurringFee|price:$currency:false}{else}{0.000|price:$currency:false:false}{/if}" name="config[MeteredRecurringFee]" /> {$currency.code}</td>
                </tr>

            </table>
        </div></div>
</div>
{literal}
<script type="text/javascript">
var zeroamount = {/literal}'{0.000|price:$currency:false:false}'{literal};;
function c_btype(el) {
    var v = $(el).val();
    if(v=='PrePay') {
       $('#metered_recurring_fee').hide();
       $('#metered_threshold').show();
       $('#sfee').hide();
       $('#ifee').show();
       $('#metered_invoice_generation').val('Monthly');
    } else {
       $('#metered_recurring_fee').show();
       $('#metered_threshold').hide();
       $('#sfee').show();
       $('#ifee').hide();
    }
}
    function bindMee() {
        $('#tabbedmenu2').TabbedMenu({elem:'.tab_content',picker:'li.tpicker',aclass:'active',picker_id:'nan'});
        var r = $('#list_resources .enablr[value=1]').length;
        var u = $('#list_usage .enablr[value=1]').length;
        var x = $('#list_resources_off .enablr[value=1]').length;
        $('#tabbedmenu2 .top_menu_count').eq(0).text(r);
        $('#tabbedmenu2 .top_menu_count').eq(1).text(u);
        $('#tabbedmenu2 .top_menu_count').eq(2).text(x);

    }
    appendLoader('bindMee');
    function removeRow(el) {
        $(el).parents('tr').eq(0).remove();
        return false;
    }

    function addBracket(v,j) {
        var t = $('#'+v+'_table');
        if(!t.length)
            return false;
        var i = t.find('tr').length;
        var br=t.find('tr:last').find('input').eq(1).val()?parseInt(t.find('tr:last').find('input').eq(1).val()):'';
        var ht='<tr >'
            +'<td><input type="text" class="inp" size="3" value="'+br+'"  name="metered['+v+'][prices]['+i+'][qty]" /></td>'
            +'<td><input type="text" class="inp" size="3" value=""   name="metered['+v+'][prices]['+i+'][qty_max]" /></td>'
            +'<td><input type="text" class="inp" size="3" value="'+zeroamount+'"   name="metered['+v+'][prices]['+i+'][price]" /> '+j+'</td>'
            +'<td><a class="fs11" href="#"  onclick="return removeRow(this)">Remove</a></td>'
            +'</tr>';
        t.append(ht);

        return false;
    }
    function var_toggle(v,e,xyz) {
        if(typeof(xyz)=='undefined' && $.inArray(v,['memory','cpus','cpu_shares','disk_size','ip_addresses'])>-1) {
            var_toggle(v+'_off',e,true);
        }
        if(typeof(xyz)=='undefined' && $.inArray(v,['memory_off','cpus_off','cpu_shares_off','disk_size_off','ip_addresses_off'])>-1) {
            var_toggle(v.replace('_off',''),e,true);
        }
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
        var r = $('#list_resources .enablr[value=1]').length;
        var u = $('#list_usage .enablr[value=1]').length;
        var x = $('#list_resources_off .enablr[value=1]').length;
        $('#tabbedmenu2 .top_menu_count').eq(0).text(r);
        $('#tabbedmenu2 .top_menu_count').eq(1).text(u);
        $('#tabbedmenu2 .top_menu_count').eq(2).text(x);
        return false;
    }
</script>
<style type="text/css">
    ul.tabs {
        border-bottom: 1px solid #CCCCCC;
        border-left: 1px solid #CCCCCC;
        float: left;
        height: 32px;
        list-style: none outside none;
        margin: 0;
        padding: 0;
        width: 100%;
    }

    .top_menu_count {
        -moz-border-bottom-colors: none;
        -moz-border-image: none;
        -moz-border-left-colors: none;
        -moz-border-right-colors: none;
        -moz-border-top-colors: none;
        background: none repeat scroll 0 0 #FFF6BF;
        border-color: -moz-use-text-color #DDDDDD #DDDDDD;
        border-right: 1px solid #DDDDDD;
        border-style: none solid solid;
        border-width: medium 1px 1px;
        color: #514721;
        font-size: 11px;
        left: 10px;
        padding: 2px;
        position: relative;
        top: -8px;
    }
    ul.tabs li {
        background: none repeat scroll 0 0 #E0E0E0;
        border-color: #CCCCCC;
        border-style: solid solid solid none;
        border-width: 1px;
        float: left;
        height: 31px;
        line-height: 31px;
        margin: 0 0 -1px;
        overflow: hidden;
        padding: 0;
        position: relative;
    }
    ul.tabs li a {
        border: 1px solid #FFFFFF;
        color: #000000;
        display: block;
        font-size: 12px;
        outline: medium none;
        padding: 0 20px;
        text-decoration: none;
    }
    ul.tabs li a:hover {
        background: none repeat scroll 0 0 #CCCCCC;
    }
    html ul.tabs li.active, html ul.tabs li.active a:hover {
        background:  #FFF;
        border-bottom: 1px solid #FFF;
    }
    .tab_container {
        background: #F5F9FF;
        border-color: #CCCCCC;
        border-style: none solid solid;
        border-width: 1px;
        clear: both;
        float: left;
        overflow: hidden;
        margin-bottom: 10px;
        width: 100%;
    }
    .tab_content {
        padding:10px;
    }

    .scheme_container {
        margin:10px 0px 10px 80px;
        padding:10px;
        background:#F0F0F3;
        border-radius:5px;
        float:left;
        color:#767679;
    }

</style>    {/literal}

