{include file="`$onappdir`header.cloud.tpl"}
<div class="header-bar">
    <h3 class="{$vpsdo} hasicon">{$lang.createnewserver}</h3>
    <div class="clear"></div>
</div>
<div class="content-bar nopadding">
    <div class="vm-available-resources-outer">
        <div class="resources_box vm-available-resources">
            <strong class="vm-available-resources-header">
                {$lang.availableresources}
            </strong>
            <table cellspacing="0" cellpadding="0" width="100%" class="vm-available-resources-table ttable">
                <tbody>
                <tr>
                    <td width="70" align="right" class="">{$lang.memory}</td>
                    <td><b {if $CreateVM.limits.mem<1}style="color:red"{/if}>{$CreateVM.limits.mem} {$CreateVM.mem_unit}B</b>
                    </td>
                </tr>
                {if $CreateVM.limits.burst}
                    <tr>
                        <td width="90" align="right">
                            <span class="vt_type type_xen type_kvm type_xcp">{$lang.burstable_ram}</span>
                            <span class="vt_type type_openvz type_lxc">{$lang.swapdisk}</span>
                        </td>
                        <td><b>{$CreateVM.limits.burst}</b></td>
                    </tr>
                {/if}
                <tr>
                    <td width="70" align="right">{$lang.storage}</td>
                    <td><b {if $CreateVM.limits.disk<1}style="color:red"{/if}>{$CreateVM.limits.disk} GB</b></td>
                </tr>
                <tr>
                    <td width="70" align="right">{$lang.cpucores}</td>
                    <td><b {if $CreateVM.limits.cpu<1}style="color:red"{/if}>{$CreateVM.limits.cpu}</b></td>
                </tr>
                {if $CreateVM.limits.ips !== false}
                <tr>
                    <td width="90" align="right">{$lang.ipcount}</td>
                    <td><b {if $CreateVM.limits.ips<1}style="color:red"{/if}>{$CreateVM.limits.ips}</b></td>
                </tr>
                {/if}
                {if $CreateVM.limits.ipv6 !== false}
                    <tr>
                        <td width="90" align="right">IP v6</td>
                        <td><b {if $CreateVM.limits.ipv6<1}style="color:red"{/if}>{$CreateVM.limits.ipv6}</b></td>
                    </tr>
                {/if}
                {if $CreateVM.limits.ipv6_subnet !== false}
                    <tr>
                        <td width="90" align="right">IP v6 Subnets</td>
                        <td><b {if $CreateVM.limits.ipv6_subnet<1}style="color:red"{/if}>{$CreateVM.limits.ipv6_subnet}</b></td>
                    </tr>
                {/if}
                {if $CreateVM.limits.baw !== false}
                    <tr>
                        <td width="90" align="right">{$lang.bandwidth}</td>
                        <td><b {if $CreateVM.limits.baw<1}style="color:red"{/if}>{$CreateVM.limits.baw}</b></td>
                    </tr>
                {/if}
                {if $CreateVM.limits.vps !== false}
                    <tr>
                        <td width="90" align="right">{$lang.vpslimit}</td>
                        <td><b {if $CreateVM.limits.vps<1}style="color:red"{/if}>{$CreateVM.limits.vps}</b></td>
                    </tr>
                {/if}

                </tbody>
            </table>
            <div class="right vm-available-resources-increase">
                <a href="{$service_url}&vpsdo=resources" class="fs11">{$lang.increaselimits}</a>
            </div>
            <div class="clear"></div>
        </div>
    </div>

    <form method="post" action="" class="create-vm-form form-horizontal">
        <input type="hidden" value="createmachine" name="make"/>
        {if $CreateVM.types && count($CreateVM.types) < 2}
            <input type="hidden" value="{$CreateVM.types[0]}" name="CreateVM[type]" id="virtual_machine_type"/>
        {/if}
        {if $CreateVM.zones && count($CreateVM.zones) < 2}
            <input type="hidden" name="CreateVM[group_id]" value="{$CreateVM.zones[0].id}"/>
        {/if}
        <table width="100%" cellspacing="0" cellpadding="0" border="0"
               class="vm-create-attr table-label-value table-rw-stack checker">
            {if count($CreateVM.zones) > 1}
                <tr>
                    <td>{$lang.Zone}</td>
                    <td>
                        <select name="CreateVM[group_id]"
                                class="rw-100"
                                id="virtual_machine_zone_id">
                            {foreach from=$CreateVM.zones item=zone}
                                <option value="{$zone.id}"
                                        {if $submit.CreateVM.group_id==$zone[0]}selected="selected"{/if}>{$zone.name}</option>
                            {/foreach}
                        </select>
                    </td>
                </tr>
            {/if}
            {if $CreateVM.types && count($CreateVM.types) > 1}
                <tr>
                    <td>
                        {$lang.type}
                    </td>
                    <td>
                        <select class="rw-100" required="required" name="CreateVM[type]"
                                onchange="type_changeos();" id="virtual_machine_type">
                            {foreach from=$CreateVM.types item=type}
                                <option value="{$type}"
                                        {if $submit.CreateVM.type==$type}selected="selected"{/if}>{$virttype[$type]}</option>
                            {/foreach}
                        </select>
                    </td>
                </tr>
            {/if}
            <tr>
                <td>
                    {$lang.hostname}
                </td>
                <td>
                    <input type="text" size="30" class="rw-100"
                           required="required" name="CreateVM[hostname]"
                           class="styled" value="{$submit.CreateVM.hostname}"/>
                </td>
            </tr>
            <tr>
                <td>
                    {$lang.os}
                </td>
                <td>
                    <select required="required" name="CreateVM[ostemplate]"
                            class="rw-100" id="virtual_machine_ostemplate">
                        <option value="" disabled>Select os template</option>
                        {foreach from=$CreateVM.ostemplates item=templaes key=type}
                            {foreach from=$templaes item=templa}
                                <option class="vt_type type_{$type}"
                                        value="{$templa[0]}"
                                        {if $submit.CreateVM.ostemplate==$templa[0]}selected="selected"{/if}>
                                    {$templa[1]}
                                    {if $templa[2] && $templa[2]>0}
                                        ( {$templa[2]|price:$currency} )
                                    {/if}
                                </option>
                            {/foreach}
                        {/foreach}
                    </select>
                </td>

            </tr>
            <tr>
                <td>
                    {$lang.password}
                </td>
                <td>
                    <input type="text" size="30" name="CreateVM[initial_root_password]"
                           class="styled rw-100" value="{$submit.CreateVM.initial_root_password}"/>
                </td>
            </tr>
            <tr>
                <td>
                    {$lang.RAM}
                </td>
                <td>
                    <div class='input-with-slider'>

                        <span class="slider-value">
                            <input type="text" size="4" required="required" name="CreateVM[memory]" class="styled"
                                   value="{if $submit.CreateVM.memory}{$submit.CreateVM.memory}{else}{$CreateVM.limits.mem}{/if}"
                                   id="virtual_machine_memory"/>
                            {$CreateVM.mem_unit}B
                        </span>
                        <div class='slider' max='{$CreateVM.limits.mem}'
                             min='{if $CreateVM.mem_unit == 'M'}256{else}1{/if}'
                             step='{if $CreateVM.mem_unit == 'M'}4{else}1{/if}'
                             target='#virtual_machine_memory'></div>
                    </div>
                </td>
            </tr>
            {if $CreateVM.limits.burstmem}
                <tr>
                    <td>
                        <span class="vt_type type_xen type_kvm type_xcp">{$lang.burstable_ram}</span>
                        <span class="vt_type type_openvz type_lxc">{$lang.swapdisk}</span>
                    </td>
                    <td>
                        <div class='input-with-slider'>
                            <span class="slider-value">
                            <input type="text" size="4" name="CreateVM[burstmem]" class="styled"
                                   value="{if $submit.CreateVM.burstmem}{$submit.CreateVM.burstmem}{else}{$CreateVM.limits.burstmem}{/if}"
                                   id="virtual_machine_burstmem"/>
                            MB
                            </span>
                            <div class='slider' max='{$CreateVM.limits.burstmem}'
                                 min='{if $CreateVM.mem_unit == 'M'}0{else}1{/if}'
                                 step='{if $CreateVM.mem_unit == 'M'}4{else}1{/if}'
                                 target='#virtual_machine_burstmem'></div>
                        </div>
                    </td>
                </tr>
            {/if}

            <tr>
                <td>
                    {$lang.cpucores}
                </td>
                <td>
                    <div class='input-with-slider'>
                        <span class="slider-value">
                            <input type="text" size="4" required="required"
                                   name="CreateVM[cpus]" class="styled"
                                   value="{if $submit.CreateVM.cpus}{$submit.CreateVM.cpus}{else}{$CreateVM.limits.cores}{/if}"
                                   id="virtual_machine_cpus"/>
                        </span>
                        <div class='slider' max='{$CreateVM.limits.cores}'
                             min='1' step='1' total="{$CreateVM.limits.cores}"
                             target='#virtual_machine_cpus'></div>
                    </div>
                </td>
            </tr>

            <tr id="disk-row">
                <td>
                    {$lang.disk_limit}
                </td>
                <td>
                    <div class='input-with-slider'>
                        <span class="slider-value">
                            <input type="text" size="4" required="required"
                                   name="CreateVM[primary_disk_size]" class="styled"
                                   value="{if $submit.CreateVM.primary_disk_size}{$submit.CreateVM.primary_disk_size}{else}{$CreateVM.limits.disk}{/if}"
                                   id="virtual_machine_cpu_primary_disk_size"/>
                            GB
                        </span>
                        <div class='slider' max='{$CreateVM.limits.disk}'
                             total='{$CreateVM.limits.disk}'
                             min='1' step='1'
                             target='#virtual_machine_cpu_primary_disk_size'></div>
                    </div>
                </td>
            </tr>
            <tr>
                <td>{$lang.bandwidth}</td>
                <td>
                    <div class='input-with-slider'>

                        <span class="slider-value">
                            <input type="text" size="4" required="required" name="CreateVM[bandwidth]" class="styled"
                                   value="{if $submit.CreateVM.bandwidth}{$submit.CreateVM.bandwidth}{else}{$CreateVM.limits.baw}{/if}"
                                   id="virtual_machine_bandwidth"/>
                        GB
                        </span>
                        <div class='slider' max='{$CreateVM.limits.baw}' total='{$CreateVM.limits.baw}' min='1' step='1'
                             target='#virtual_machine_bandwidth'></div>
                    </div>
                    <div class="clear"></div>
                </td>
            </tr>
            {if $CreateVM.limits.ips !== false}
            <tr>
                <td>{$lang.ipcount}</td>
                <td>
                    <div class='input-with-slider'>
                        <span class="slider-value">
                        <input type="text" size="4" required="required" name="CreateVM[ips]" class="styled"
                               value="{if $submit.CreateVM.ips}{$submit.CreateVM.ips}{else}{$CreateVM.limits.ips}{/if}"
                               id="virtual_machine_ips"/>
                        </span>
                        <div class='slider' max='{$CreateVM.limits.ips}' total='{$CreateVM.limits.ips}' min='0' step='1'
                             target='#virtual_machine_ips'></div>
                    </div>
                    <div class="clear"></div>
                </td>
            </tr>
            {/if}
            {if $CreateVM.limits.ipv6 !== false}
            <tr>
                <td>{$lang.ipcount} v6</td>
                <td>
                    <div class='input-with-slider'>
                        <span class="slider-value">
                        <input type="text" size="4" required="required" name="CreateVM[ipv6]" class="styled"
                               value="{if $submit.CreateVM.ipv6}{$submit.CreateVM.ipv6}{else}{$CreateVM.limits.ipv6}{/if}"
                               id="virtual_machine_ipv6"/>
                        </span>
                        <div class='slider' max='{$CreateVM.limits.ipv6}' total='{$CreateVM.limits.ipv6}' min='0' step='1'
                             target='#virtual_machine_ipv6'></div>
                    </div>
                    <div class="clear"></div>
                </td>
            </tr>
            {/if}
            {if $CreateVM.limits.ipv6_subnet !== false}
            <tr>
                <td>IP v6 Subnets</td>
                <td>
                    <div class='input-with-slider'>
                        <span class="slider-value">
                        <input type="text" size="4" required="required" name="CreateVM[ipv6_subnet]" class="styled"
                               value="{if $submit.CreateVM.ipv6_subnet}{$submit.CreateVM.ipv6_subnet}{else}{$CreateVM.limits.ipv6_subnet}{/if}"
                               id="virtual_machine_ipv6_subnet"/>
                        </span>
                        <div class='slider' max='{$CreateVM.limits.ipv6_subnet}' total='{$CreateVM.limits.ipv6_subnet}' min='0' step='1'
                             target='#virtual_machine_ipv6_subnet'></div>
                    </div>
                    <div class="clear"></div>
                </td>
            </tr>
            {/if}

            <tr>
                <td align="center" colspan="2">
                    <input type="submit" value="{$lang.CreateVM}" style="font-weight:bold" class=" blue"/>
                </td>
            </tr>
        </table>

        {securitytoken}
    </form>
</div>
{literal}
    <script type="text/javascript">
        $(document).ready(function () {
            type_changeos();
            init_sliders();
        });

        function type_changeos() {

            var typ = $('#virtual_machine_type').val();
            if (!typ.length)
                return;

            var vtypes = $('.vt_type').hide();
            vtypes.filter('option, input, select').prop('disabled', true);
            vtypes.filter('.type_' + typ).show()
                .filter('option, input, select').prop('disabled', false);

            var select = $('#virtual_machine_ostemplate');
            if (!select.children(':selected').length)
                select.val('');
        }
    </script>
{/literal}
{include file="`$onappdir`footer.cloud.tpl"}