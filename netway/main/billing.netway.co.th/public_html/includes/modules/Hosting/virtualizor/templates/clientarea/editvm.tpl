<div class="header-bar">
    <h3 class="{$vpsdo} hasicon">{$lang.scalevm}</h3>
    <div class="clear"></div>
</div>
<div class="content-bar nopadding" style="position:relative">
    <form method="post" action="">
        <input type="hidden" value="editmachine" name="make" />
        <table width="100%" cellspacing="0" cellpadding="0" border="0" class="checker vm-scale table-rw-stack table-label-value">
            <tr>
                <td>{$lang.RAM}</td>
                <td>
                    <div class='input-with-slider'>

                        <span class="slider-value">
                            <input type="text" size="4" required="required"
                                   name="CreateVM[memory]" class="styled"
                                   value="{if $VMDetails.ram}{$VMDetails.ram}{else}{$CreateVM.limits.mem}{/if}"
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
                                       value="{if $VMDetails.burstmem}{$VMDetails.burstmem}{else}{$CreateVM.limits.burstmem}{/if}"
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
                                   value="{if $VMDetails.cores}{$VMDetails.cores}{else}{$CreateVM.limits.cores}{/if}"
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
                                   value="{if $VMDetails.space}{$VMDetails.space}{else}{$CreateVM.limits.disk}{/if}"
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
                                   value="{if $VMDetails.bandwidth}{$VMDetails.bandwidth}{else}{$CreateVM.limits.baw}{/if}"
                                   id="virtual_machine_bandwidth"/>
                            GB
                        </span>
                        <div class='slider' max='{$CreateVM.limits.baw}' total='{$CreateVM.limits.baw}' min='1' step='1'
                             target='#virtual_machine_bandwidth'></div>
                    </div>
                </td>
            </tr>
            {if $CreateVM.limits.ips !== false}
                <tr>
                    <td>{$lang.ipcount}</td>
                    <td>
                        <div class='input-with-slider'>
                            <span class="slider-value">
                                <input type="text" size="4" required="required" name="CreateVM[ips]" class="styled"
                                       value="{if $VMDetails.ipv4}{$VMDetails.ipv4}{else}{$CreateVM.limits.ips}{/if}"
                                       id="virtual_machine_ips"/>
                            </span>
                            <div class='slider' max='{$CreateVM.limits.ips}' total='{$CreateVM.limits.ips}' min='0' step='1'
                                 target='#virtual_machine_ips'></div>
                        </div>
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
                                       value="{if $VMDetails.ipv6}{$VMDetails.ipv6}{else}{$CreateVM.limits.ipv6}{/if}"
                                       id="virtual_machine_ipv6"/>
                            </span>
                            <div class='slider' max='{$CreateVM.limits.ipv6}' total='{$CreateVM.limits.ipv6}' min='0' step='1'
                                 target='#virtual_machine_ipv6'></div>
                        </div>
                    </td>
                </tr>
            {/if}

            <tr>
                <td align="center" style="border:none" colspan="2">
                    <input type="submit" value="{$lang.adjresall}" class="btn btn-info"/>
                    <a class="btn btn-default" href="{$service_url}&vpsdo=vmdetails&vpsid={$vpsid}" >{$lang.cancel}</a>
                </td>
            </tr>
        </table>
        {securitytoken} </form>

    <script type="text/javascript">
        {literal}
        $(document).ready(function () {
            init_sliders();
        });
        {/literal}
    </script>

</div>