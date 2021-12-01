{include file="`$onappdir`header.cloud.tpl"}
<div class="header-bar">
    <h3 class="{$vpsdo} hasicon">{$lang.createnewserver}</h3>
    <div class="clear"></div>
</div>
<div class="content-bar nopadding" style="position:relative">
    <div class="resources_box">
        <strong><em>{$lang.availableresources}</em></strong>
        <table cellspacing="0" cellpadding="0" width="100%" class="ttable">
            <tbody>
                <tr>
                    <td width="70" align="right">{$lang.memory}</td>
                    <td ><b {if $CreateVM.limits.mem<1}style="color:red"{/if}>{$CreateVM.limits.mem} MB</b></td>
                </tr>
                <tr>
                    <td width="70" align="right">{$lang.storage}</td>
                    <td ><b {if $CreateVM.limits.disk<1}style="color:red"{/if}>{$CreateVM.limits.disk} GB</b></td>
                </tr>
                <tr>
                    <td width="70" align="right">{$lang.cpucores}</td>
                    <td ><b {if $CreateVM.limits.cpu<1}style="color:red"{/if}>{$CreateVM.limits.cpu}</b></td>
                </tr>
                {if !$vcpu} <tr>
                        <td width="70" align="right">{$lang.cpuprio}</td>
                        <td ><b {if $CreateVM.limits.cpus<1}style="color:red"{/if}>{$CreateVM.limits.cpus} %</b></td>
                    </tr> {/if}
                    <tr>
                        <td width="70" align="right">IPs</td>
                        <td ><b {if $CreateVM.limits.ips<1}style="color:red"{/if}>{$CreateVM.limits.ips}</b></td>
                    </tr>

                </tbody></table>
            <div style="text-align: right"><a href="?cmd=clientarea&action=services&service={$service.id}&vpsdo=resources" class="fs11">{$lang.increaselimits}</a></div>
        </div>
        <script type="text/javascript" >

            {literal}
                var ostemplates = [];
                var windows = [];
                var distributions = {
                    linux: [],
                    freebsd: [],
                    windows: []
                };{/literal}

        {foreach from=$CreateVM.ostemplates item=templa}{if $templa.swap=='false'}windows[{$templa[0]}] = true;{/if}{/foreach}

    {foreach from=$CreateVM.distributions.linux item=i key=k}distributions.linux[{$k}] = "{$i}";{/foreach}
{foreach from=$CreateVM.distributions.freebsd item=i key=k}distributions.freebsd[{$k}] = "{$i}";{/foreach}
{foreach from=$CreateVM.distributions.windows item=i key=k}distributions.windows[{$k}] = "{$i}";{/foreach}

{foreach from=$CreateVM.ostemplates item=i key=k}ostemplates[{$k}] ={literal} {{/literal}id: "{$i[0]}", name: "{$i[1]} {if $i[2] && $i[2]>0}( {$i[2]|price:$currency} ){/if}", distro: "{$i.distro}", family: "{$i.family}"{literal}}{/literal};{/foreach}
</script>

<form method="post" action="">
    <input type="hidden" value="createmachine" name="make" />
{if !$CreateVM.hv_zones}<input type="hidden" name="CreateVM[hypervisor_group_id]" value="{$CreateVM.hv_zone_id}"/>{/if}
{if !$CreateVM.network_zones}<input type="hidden" name="CreateVM[primary_network_group_id]" value="{$CreateVM.network_zone_id}"/>{/if}
{if !$CreateVM.data_zones}<input type="hidden" name="CreateVM[data_store_group_primary_id]" value="{$CreateVM.data_zone_id}"/>{/if}
{if !$CreateVM.swap_zones}<input type="hidden" name="CreateVM[data_store_group_swap_id]" value="{$CreateVM.swap_zone_id}"/>{/if}
<table width="100%" cellspacing="0" cellpadding="0" border="0" class="checker">
    {if $CreateVM.hv_zones}
        <tr>
            <td colspan="2"><span class="slabel">{$lang.Zone}</span>
                <select name="CreateVM[hypervisor_group_id]" id="virtual_machine_hypervisor_zone_id"  style="min-width:250px;" >
                    <option value="0" {if $submit.CreateVM.hypervisor_group_id=='0' || !$submit.CreateVM.hypervisor_group_id}selected="selected"{/if}>{$lang.firstavailable}</option>
                    {foreach from=$CreateVM.hv_zones item=zone}
                        <option value="{$zone[0]}" {if $submit.CreateVM.hypervisor_zone_id==$zone[0]}selected="selected"{/if}>{$zone[1]}</option>
                    {/foreach}
                </select></td>
        </tr>
    {/if}
    <tr>
        <td colspan="2"><span class="slabel">{$lang.hostname}</span><input type="text" size="30" required="required" name="CreateVM[hostname]"  class="styled" value="{$submit.CreateVM.hostname}"/></td>
    </tr>
    <tr>
        <td colspan="2"><span class="slabel">{$lang.os}</span><select required="required" name="CreateVM[operating_system]" id="virtual_machine_operating_system" onchange="filtertemplates('family')" style="min-width:250px;" >
        {if $CreateVM.distributions.linux}<option value="linux" {if $submit.CreateVM.operating_system=='linux'}selected="selected"{/if}>Linux</option>{/if}
{if $CreateVM.distributions.windows}<option value="windows" {if $submit.CreateVM.operating_system=='windows'}selected="selected"{/if}>Windows</option>{/if}
{if $CreateVM.distributions.freebsd}<option value="freebsd" {if $submit.CreateVM.operating_system=='freebsd'}selected="selected"{/if}>FreeBSD</option>{/if}
</select></td>

</tr>
<tr>
    <td colspan="2"><span class="slabel">{$lang.osdistro}</span><select required="required" name="CreateVM[operating_system_distro]" id="virtual_machine_operating_system_distro" onchange="filtertemplates('distro')"style="min-width:250px;" >
            {if $submit.CreateVM.operating_system}
                {foreach from=$CreateVM.distributions[$submit.CreateVM.operating_system] item=d}
                    <option value="{$d}" {if $submit.CreateVM.operating_system_distro==$d}selected="selected"{/if}>{$d|ucfirst}</option>
                {/foreach}
            {else}
                {if $CreateVM.distributions.linux}
                    {foreach from=$CreateVM.distributions.linux item=d}
                        <option value="{$d}">{$d|ucfirst}</option>
                    {/foreach}
                {elseif $CreateVM.distributions.windows}}
                    {foreach from=$CreateVM.distributions.windows item=d}
                        <option value="{$d}">{$d|ucfirst}</option>
                    {/foreach}
                {elseif $CreateVM.distributions.freebsd}}
                    {foreach from=$CreateVM.distributions.freebsd item=d}
                        <option value="{$d}">{$d|ucfirst}</option>
                    {/foreach}
                {/if}
            {/if}
        </select>
    </td>
</tr>
<tr>
    <td colspan="2">
        <span class="slabel">{$lang.ostemplate}</span>
        <select style="min-width:250px;" required="required" name="CreateVM[template_id]" id="virtual_machine_template_id" onchange="swapcheck($(this).val());
            licesecheck($(this).val())" >
            {if $submit.CreateVM.operating_system_distro}
                {foreach from=$CreateVM.ostemplates item=templa}{if  $templa.family==$submit.CreateVM.operating_system && $templa.distro==$submit.CreateVM.operating_system_distro}
                        <option value="{$templa[0]}" {if $submit.CreateVM.template_id==$templa[0]}selected="selected"{/if}>{$templa[1]} {if $templa[2] && $templa[2]>0}( {$templa[2]|price:$currency:true} ){/if}</option>
                {/if} {/foreach}
            {else}
                {foreach from=$CreateVM.ostemplates item=templa}{if $templa.family=='linux' && $templa.distro==$CreateVM.distributions.linux[0]}
                        <option value="{$templa[0]}" >{$templa[1]} {if $templa[2] && $templa[2]>0}( {$templa[2]|price:$currency:true} ){/if}</option>
                {/if}{/foreach}
            {/if}

        </select>
        <span id="ospreloader" style="display:none;"><img src="includes/types/onappcloud/images/ajax-loader.gif" style="margin-bottom: 9px;" /></span>
    </td>
</tr>
<tr id="license_type">
    <td colspan="2">
        <span class="slabel">Licensing Type</span>
        <select style="min-width:250px;" required="required" name="CreateVM[license_type]" id="virtual_machine_license_type" onchange="licesetypecheck($(this).val())" >
            <option value="mak" {if $submit.CreateVM.license_type=="mak"}selected="selected"{/if}> MAK</option>
            <option value="kms" {if $submit.CreateVM.license_type=="kms"}selected="selected"{/if}> KMS</option>
            <option value="own" {if $submit.CreateVM.license_type=="own"}selected="selected"{/if}> Your own license</option>
        </select>
    </td>
</tr>
<tr id="license_own">
    <td colspan="2">
        <span class="slabel">License Key</span>
        <input type="text" size="30" name="CreateVM[license_key]" class="styled" value="{$submit.CreateVM.license_key}"/>
    </td>
</tr>
<tr>
    <td colspan="2">
        <span class="slabel">{$lang.password}</span>
        <input type="text" size="30" name="CreateVM[initial_root_password]" class="styled" value="{$submit.CreateVM.initial_root_password}"/>
    </td>
</tr>

<tr>
    <td colspan="2">
        <div class='input-with-slider'>
            <span class="slabel">{$lang.RAM}</span>
            <input type="text" size="4" required="required" name="CreateVM[memory]" class="styled" value="{if $submit.CreateVM.memory}{$submit.CreateVM.memory}{else}{$CreateVM.limits.mem}{/if}" id="virtual_machine_memory"/>
            MB
            <div class='slider' max='{$CreateVM.limits.mem}' min='0' step='4' target='#virtual_machine_memory'></div>
        </div>

    </td>

</tr>

<tr>
    <td colspan="2">
        <div class='input-with-slider'>
            <span class="slabel">{$lang.cpucores}</span>
            <input type="text" size="4" required="required" name="CreateVM[cpus]" class="styled" value="{if $submit.CreateVM.cpus}{$submit.CreateVM.cpus}{else}{$disklimits.cores}{/if}" id="virtual_machine_cpus"/>

            <div class='slider' max='{$disklimits.cores}' min='1' step='1' total="{$disklimits.cores}" divide="#virtual_machine_cpu_shares" target='#virtual_machine_cpus'></div>
        </div>

    </td>

</tr>

{if !$vcpu}<tr>
        <td colspan="2">
            <div class='input-with-slider'>
                <span class="slabel">{$lang.cpuprio} <a class="vtip_description" title="{$lang.priotitile}"></a></span>
                <input type="text" size="4" required="required" name="CreateVM[cpu_shares]" class="styled" value="{if $submit.CreateVM.cpu_shares}{$submit.CreateVM.cpu_shares}{else}{$CreateVM.limits.cpus_pc}{/if}" id="virtual_machine_cpu_shares"/>
                %
                <div class='slider' max='{$CreateVM.limits.cpus_pc}' min='1' step='1' target='#virtual_machine_cpu_shares'></div>
            </div>

        </td>

    </tr>{/if}
    <tr>
        <td colspan="2" id="disk-row">
            <div class='input-with-slider'>
                <span class="slabel">{$lang.disk_limit}</span>
                <input type="text" size="4" required="required" name="CreateVM[primary_disk_size]" class="styled" value="{if $submit.CreateVM.primary_disk_size}{$submit.CreateVM.primary_disk_size}{else}{$CreateVM.limits.disk-1}{/if}" id="virtual_machine_cpu_primary_disk_size"/>
                GB
                <div class='slider' max='{$disklimits.disk_max}' total='{$disklimits.disk_total}' minus='#virtual_machine_swap_disk_size' min='1' step='1' target='#virtual_machine_cpu_primary_disk_size'></div>
            </div>
            <div class="clear"></div>
            {if $CreateVM.data_zones}

                <span class="slabel">{$lang.storagedc}</span>
                <select name="CreateVM[data_store_group_primary_id]" id="virtual_machine_data_zone_id"  style="min-width:250px;" >
                    <option value="0" {if $submit.CreateVM.data_store_group_primary_id=='0' || !$submit.CreateVM.data_store_group_primary_id}selected="selected"{/if}>{$lang.autoassign}</option>
                    {foreach from=$CreateVM.data_zones item=zone}
                        <option value="{$zone[0]}" {if $submit.CreateVM.data_zone_id==$zone[0]}selected="selected"{/if}>{$zone[1]}</option>
                    {/foreach}
                </select>

            {/if}
        </td>

    </tr>
    <tr id="swap-row" {if $submit && $submit.CreateVM.swap_disk_size==0}style="display:none"{/if}>
        <td colspan="2">
            <div class='input-with-slider'>
                <span class="slabel">{$lang.swapdisk}</span>
                <input type="text" size="4" required="required" name="CreateVM[swap_disk_size]" class="styled" value="0" id="virtual_machine_swap_disk_size"/>
                GB
                <div class='slider' max='{$disklimits.swap_max}' min='1' step='1' total='{$disklimits.swap_total}' minus='#virtual_machine_cpu_primary_disk_size'  target='#virtual_machine_swap_disk_size'></div>
            </div>
            <div class="clear"></div>
            {if $CreateVM.swap_zones}

                <span class="slabel">{$lang.swapdc}</span>
                <select name="CreateVM[data_store_group_swap_id]" id="virtual_machine_swap_zone_id"  style="min-width:250px;" >
                    <option value="0" {if $submit.CreateVM.data_store_group_swap_id=='0' || !$submit.CreateVM.data_store_group_swap_id}selected="selected"{/if}>{$lang.autoassign}</option>
                    {foreach from=$CreateVM.swap_zones item=zone}
                        <option value="{$zone[0]}" {if $submit.CreateVM.swap_zone_id==$zone[0]}selected="selected"{/if}>{$zone[1]}</option>
                    {/foreach}
                </select>

            {/if}
        </td>

    </tr>
    {if $CreateVM.network_zones}
        <tr>
            <td colspan="2"><span class="slabel">{$lang.networkzone}</span>
                <select name="CreateVM[primary_network_group_id]" id="virtual_machine_primary_network_group_id"  style="min-width:250px;" >
                    <option value="0" {if $submit.CreateVM.primary_network_group_id=='0' || !$submit.CreateVM.primary_network_group_id}selected="selected"{/if}>{$lang.autoassign}</option>
                    {foreach from=$CreateVM.network_zones item=zone}
                        <option value="{$zone[0]}" {if $submit.CreateVM.network_zone_id==$zone[0]}selected="selected"{/if}>{$zone[1]}</option>
                    {/foreach}
                </select></td>
        </tr>
    {/if}

    {if $CreateVM.limits.allowautobackup}
        <tr>
            <td colspan="2"><span class="slabel">{$lang.enableautobackup}</span>
                <input name="CreateVM[required_automatic_backup]" id="virtual_machine_required_automatic_backu"  value="1" type="checkbox" style="margin:8px 20px 0px;"/></td>
        </tr>
    {/if}



    {if $metered_variables}
        <tr>
            <td colspan="2"><span class="slabel">{$lang.priceperhour}</span>
                <span class="slabel">{$currency.sign}<span id="hourly_price">0.00</span>{$currency.code}</span>
                <script type="text/javascript">
        {literal}  var mvar = {};{/literal}
                {foreach from=$metered_variables item=v}
        mvar['{$v.variable_name}'] = parseFloat('{$v.prices[0].price}');
                {/foreach}

                {literal}
                                function update_metered_totals() {
                                    var target = $('#hourly_price');
                                    var total = 0;
                                    if (mvar.memory) {
                                        total += parseInt($('#virtual_machine_memory').val()) * mvar.memory;
                                    }
                                    if (mvar.cpus) {
                                        total += parseInt($('#virtual_machine_cpus').val()) * mvar.cpus;
                                    }
                                    if (mvar.cpu_shares) {
                                        total += parseInt($('#virtual_machine_cpu_shares').val()) * mvar.cpu_shares;
                                    }
                                    if (mvar.ip_addresses) {
                                        total += 1 * mvar.ip_addresses;
                                    }
                                    if (mvar.disk_size) {
                                        total += (parseInt($('#virtual_machine_cpu_primary_disk_size').val()) + parseInt($('#virtual_machine_swap_disk_size').val())) * mvar.disk_size;
                                    }
                                    target.text(total.toFixed(2));
                                }

                                if (typeof('appendLoader') == 'function') {
                                    appendLoader('update_metered_totals');
                                } else {
                                    $(document).ready(function() {
                                        update_metered_totals();
                                    });
                                }
                </script>
            {/literal}
        </td>
    </tr>
{/if}


<tr>
    <td align="center" style="border:none" colspan="2">

        <input type="submit" value="{$lang.CreateVM}" style="font-weight:bold" class=" blue" />
    </td>
</tr>
</table>


<script type="text/javascript">
    {$passwordv.length};{literal}
            $(document).ready(function() {
                init_sliders();
                licesecheck();
                
                var timeout = false;
                function updateTitle(elm, title){
                    if(title){
                        if(timeout)
                            clearTimeout(timeout);
                        timeout = setTimeout(function(){
                            elm.attr('title',title);
                            if(typeof jQuery.fn.tooltip == 'function')
                               elm.tooltip({placement:'right', animation:false}).tooltip('fixTitle').tooltip('enable');
                            if($('.tooltip:visible').length){
                                elm.tooltip('show');
                            }
                                 
                        }, 100);
                    }else{
                        elm.removeAttr('title');
                        if(typeof jQuery.fn.tooltip == 'function')
                           elm.tooltip('hide').tooltip('disable');
                    }
                }
                
                {/literal}{if $passwordv.length}{literal}
                $('input[name="CreateVM[initial_root_password]"]').unbind('keyup input change').bind('keyup input change',function() {
                    var that = $(this),
                            val = that.val(),
                            btn = $('input[type="submit"]'),
                            invalid = false
                            title = [],
                            lang = {};
                    {/literal} 
                    lang['len'] = '{$lang.passistooshort|replace:'%d':$passwordv.length}';
                    lang['loweruppercase'] = '{$lang.uppercaselowercase}';
                    lang['lettersnumbers'] = '{$lang.lettersanddigits}';
                    lang['symbols'] = '{$lang.specialcharacters}';
                    if (val.length < {$passwordv.length}){literal}{
                        invalid = true;
                        title.push(lang.len);
                    }{/literal}
                    {if $passwordv.lettersnumbers}{literal}if (val.match(/([a-zA-Z].*\d)|(\d.*[a-zA-Z])/) == null){
                        invalid = true;
                        title.push(lang.lettersnumbers);
                    }{/literal}{/if}
                    {if $passwordv.loweruppercase}{literal}if (val.match(/([a-z].*[A-Z])|([A-Z].*[a-z])/) == null){
                        invalid = true;
                        title.push(lang.loweruppercase);
                    }{/literal}{/if} 
                    {if $passwordv.symbols}{literal}if (val.match(/[~!@#$%^&*_\-+=`|\(){}[\]:;"'<>,.?\/]/) == null){
                        invalid = true;
                        title.push(lang.symbols);
                    }{/literal}{/if}{literal}
                    if(invalid){
                        that.parent().addClass('error');
                        btn.prop('disabled', true).fadeTo(200, 0.5);
                        updateTitle(that, title.join('. '))
                    } else {
                        btn.prop('disabled', false).fadeTo(200, 1);
                        that.parent().removeClass('error').fadeTo(200, 1);
                        updateTitle(that);
                    }
                }).keyup().parent().addClass('control-group');
                {/literal}{/if}{literal}
            });
    {/literal}
</script>



{securitytoken}
</form>
</div>
{include file="`$onappdir`footer.cloud.tpl"}