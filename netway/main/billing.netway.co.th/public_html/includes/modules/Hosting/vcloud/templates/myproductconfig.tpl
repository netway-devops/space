<tr>
    <td id="getvaluesloader">{if $test_connection_result}
            <span style="margin-left: 10px; font-weight: bold;text-transform: capitalize; color: {if $test_connection_result.result == 'Success'}#009900{else}#990000{/if}">
                {$lang.test_configuration}:
                {if $lang[$test_connection_result.result]}{$lang[$test_connection_result.result]}{else}{$test_connection_result.result}{/if}
                {if $test_connection_result.error}: {$test_connection_result.error}{/if}
            </span>
        {/if}
    </td>
    <td id="onappconfig_">
        <div id="">
            <ul class="breadcrumb-nav" style="margin-top:10px;">
                <li><a href="#" class="active disabled" onclick="load_onapp_section('provisioning')">Start</a></li>
                <li><a href="#" class="disabled" onclick="load_onapp_section('resources')">General</a></li>
                <li><a href="#" class="disabled" onclick="load_onapp_section('vdc')">vDC</a></li>
                <li><a href="#" class="disabled" onclick="load_onapp_section('network')">Network</a></li>
                <li><a href="#" class="disabled" onclick="load_onapp_section('finish')">Finish</a></li>
            </ul>
            <div style="margin-top:-1px;border: solid 1px #DDDDDD;padding:10px;margin-bottom:10px;background:#fff"
                 id="onapptabcontainer">
                <div class="onapptab" id="provisioning_tab">
                    To start please configure and select server above.<br/>
                </div>
                <div class="onapptab form" id="resources_tab">
                    <table border="0" cellspacing="0" cellpadding="6" width="100%">
                        <tr>
                            <td colspan="2" class="onapp-preloader" style=""><img
                                        src="templates/default/img/ajax-loader3.gif"> Fetching data from vCloud
                                Director, please wait...
                            </td>
                        </tr>

                        <tr>
                            <td width="160"><label>User Role<a class="vtip_description"
                                                               title="HostBill will add default user to new organization with this role."></a></label>
                            </td>
                            <td id="rolecontainer" class="tofetch"><input type="text" size="3" name="options[role]"
                                                                          value="{$default.role}" id="role"/>
                            </td>
                        </tr>
                        <tr>
                            <td width="160"><label>Allocation Model</label></td>
                            <td id="allocationcontainer">
                                <select name="options[allocation]">
                                    <option value="AllocationPool"
                                            {if $default.allocation=='AllocationPool'}selected="selected"{/if}>
                                        Allocation Pool
                                    </option>
                                    <option value="AllocationVApp"
                                            {if $default.allocation=='AllocationVApp'}selected="selected"{/if}>
                                        Pay as you go
                                    </option>
                                    <option value="ReservationPool"
                                            {if $default.allocation=='ReservationPool'}selected="selected"{/if}>
                                        Reservation pool
                                    </option>
                                </select>
                            </td>
                        </tr>

                        <tr>
                            <td width="160" style="vertical-align: top;">
                                <label>Shared organization/user</label>

                            </td>
                            <td id="organizationcontainer">
                                <input type="checkbox" name="options[sharedorg]" value="1" id="sharedorg"
                                       {if $default.sharedorg}checked{/if}/> Enable<br/>
                                <span class="fs11">Subsequent customer signups for any package with this option enabled
                                    will use only one, shared, organization and user per client</span>
                            </td>
                        </tr>

                        <tr>
                            <td width="160"><label>Organization Name</label></td>
                            <td id="organizationcontainer">
                                <div class="clearfix">
                                    <select name="options[organization]" id="organization">
                                        <option value="">Generate from Client Name</option>
                                        <option value="$id" {if $default.organization === '$id'}selected{/if}
                                        >Generate from Client ID
                                        </option>
                                    </select>
                                </div>
                                <span class="fs11">
                                    <input type="checkbox" class="formchecker" rel="organization"/>
                                    Allow client to enter during order (otherwise use client company name)
                                </span>
                            </td>
                        </tr>
                    </table>
                    <div class="nav-er" id="step-2">
                        <a href="#" class="prev-step">Previous step</a>
                        <a href="#" class="next-step">Next step</a>
                    </div>

                </div>

                <div class="onapptab form" id="vdc_tab">
                    <table border="0" cellspacing="0" cellpadding="6" width="100%">
                        <tr>
                            <td colspan="2" class="onapp-preloader" style=""><img
                                        src="templates/default/img/ajax-loader3.gif">
                                Fetching data from vCloud Director, please wait...
                            </td>
                        </tr>


                        <tr>
                            <td width="160"><label>Provider vDC</label></td>
                            <td id="vdccontainer" class="tofetch"><input type="text" size="3" name="options[vdc]"
                                                                         value="{$default.vdc}" id="vdc"/>
                            </td>
                        </tr>
                        <tr>
                            <td><label>Storage Unit</label></td>
                            <td>
                                <select name="options[unitstorage]" id="unitstorage">
                                    <option value="1024">GB</option>
                                    <option value="1048576" {if $default.unitstorage == 1048576}selected{/if}>TB
                                    </option>
                                </select>
                            </td>
                        </tr>

                        <tr>
                            <td style="vertical-align: top;">
                                <label>
                                    Storage Profile / Policy
                                </label>
                                <input type="hidden" size="3" name="options[profile]" value="{$default.profile}"
                                       id="profile"/>
                                <input type="hidden" size="3" name="options[disk_size]" value="{$default.disk_size}"
                                       id="disk_size"/>
                            </td>
                            <td>
                                <div id="storageprofilecontainer" class="tofetch">
                                    {include file="`$module_templates`ajax.myproductconfig.tpl"
                                    defval=$default.storageprofile
                                    modvalues=$default.storageprofile
                                    valx='storageprofile' make='getonappval'}
                                </div>
                            </td>
                        </tr>

                        <tr>
                            <td width="160"><label>Default storage profile</label></td>
                            <td id="profilecontainer" class="tofetch">
                                <input type="text" size="3" name="options[profile]" value="{$default.profile}"
                                       id="profile"/>
                            </td>
                        </tr>

                        <tr>
                            <td>
                                <label>Max VMs
                                    <a class="vtip_description" title="Limit of VMs client can create"></a>
                                </label>
                            </td>
                            <td id="maxvms">
                                <input type="text" size="3" name="options[maxvms]" value="{$default.maxvms}"
                                       id="maxvms"/>
                            </td>
                        </tr>
                        <tr>
                            <td><label>CPU Unit</label></td>
                            <td id="cpucontainer">
                                <select name="options[unitcpu]" id="unitcpu">
                                    <option value="1">MHz</option>
                                    <option value="1000" {if $default.unitcpu == 1000}selected{/if} >GHz</option>
                                </select>
                            </td>
                        </tr>
                        <tr>
                            <td><label>Enable "vCPU"</label></td>
                            <td id="vcpucontainer">
                                <input type="checkbox" size="3" name="options[vcpuenabled]"
                                       {if $default.vcpuenabled}checked{/if}
                                       value="1" id="vcpuenabled"/>
                                Calculate VDC CPU Allocation quota based on selected <b>vCPU Speed</b> and CPU Limit
                            </td>
                        </tr>
                        <tr>
                            <td>
                                <label>
                                    CPU
                                    <span class="vcpu vcpu-disabled">Allocation</span>
                                    <span class="vcpu vcpu-enabled">Limit</span>
                                </label>
                            </td>
                            <td id="cpucontainer">
                                <div class="formcheck">
                                    <input type="text" size="3" name="options[cpu]" value="{$default.cpu}" id="cpu"/>
                                    <span class="fs11"><input type="checkbox" class="formchecker" rel="cpu"/>
                                        Allow client to adjust with slider during order
                                    </span>
                                </div>
                                <div class="overhead">
                                    Increase CPU Allocation by
                                    <input type="text" size="3" name="options[overhead][cpu]"
                                           value="{$default.overhead.cpu|default:0}" pattern="^[\d\.\,]+%?$"/>
                                    <a class="vtip_description">
                                        <span>
                                            Increase CPU allocation by specific amount.
                                            You can use percentage or fixed value, for example:
                                            <ul>
                                                <li>10% - will increase allocation by 10 percent</li>
                                                <li>10 - will increase allocation by 10 units</li>
                                            </ul>
                                        </span>
                                    </a>
                                </div>
                            </td>
                        </tr>

                        <tr>
                            <td width="160">
                                <label>vCPU Speed</label>
                            </td>
                            <td id="vcpuspeedcontainer">
                                <input type="text" size="3" name="options[vcpuspeed]" value="{$default.vcpuspeed}"
                                       id="vcpuspeed"/>
                                <span class="fs11"><input type="checkbox" class="formchecker" rel="vcpuspeed"/>
                                    Allow client to adjust with slider during order
                                </span>
                            </td>
                        </tr>

                        <tr>
                            <td width="160"><label>Memory Unit</label></td>
                            <td>
                                <select name="options[unitmemory]" id="unitmemory">
                                    <option value="1">MB</option>
                                    <option value="1024" {if $default.unitmemory == 1024}selected{/if}>GB</option>
                                </select>
                            </td>
                        </tr>

                        <tr>
                            <td width="160"><label>Memory Allocation</label></td>
                            <td id="memorycontainer">
                                <div class="formcheck">
                                    <input type="text" size="3" name="options[memory]" value="{$default.memory}"
                                           id="memory"/>
                                    <span class="fs11"><input type="checkbox" class="formchecker" rel="memory"/>
                                        Allow client to adjust with slider during order
                                    </span>
                                </div>
                                <div class="overhead">
                                    Increase Memory Allocation by
                                    <input type="text" size="3" name="options[overhead][memory]"
                                           value="{$default.overhead.memory|default:0}" pattern="^[\d\.\,]+%?$"/>
                                    <a class="vtip_description">
                                        <span>
                                            Increase memory allocation by specific amount.
                                            You can use percentage or fixed value, for example:
                                            <ul>
                                                <li>10% - will increase allocation by 10 percent</li>
                                                <li>10 - will increase allocation by 10 units</li>
                                            </ul>
                                        </span>
                                    </a>
                                </div>
                            </td>
                        </tr>
                        <tr>
                            <td width="160"><label>Enable thin provisioning</label></td>
                            <td id="memorycontainer">
                                <input type="checkbox" name="options[provthin]" value="1" id="provthin"
                                       {if $default.provthin}checked{/if} />
                            </td>
                        </tr>
                        <tr>
                            <td width="160"><label><u>Disable</u> fast provisioning</label></td>
                            <td id="memorycontainer">
                                <input type="checkbox" name="options[provslow]" value="1" id="provfast"
                                       {if $default.provslow}checked{/if} />
                            </td>
                        </tr>


                    </table>
                    <div class="nav-er" id="step-4">
                        <a href="#" class="prev-step">Previous step</a>
                        <a href="#" class="next-step">Next step</a>
                    </div>

                </div>
                <div class="onapptab form" id="network_tab">
                    <table border="0" cellspacing="0" cellpadding="6" width="100%">
                        <tr>
                            <td colspan="2" class="onapp-preloader" style="">
                                <img src="templates/default/img/ajax-loader3.gif">
                                Fetching data from vCloud Director, please wait...
                            </td>
                        </tr>
                        <tr>
                            <td width="160"><label>Network Pool</label></td>
                            <td id="poolcontainer" class="tofetch">
                                <input type="text" size="3" name="options[pool]"
                                       value="{$default.pool}" id="pool"/>
                            </td>
                        </tr>
                        <tr>
                            <td width="160"><label>Network Quota</label></td>
                            <td id="networkscontainer">
                                <input type="number" min="0" name="options[networks]"
                                       value="{$default.networks}" id="networks"/>
                                <span class="fs11"><input type="checkbox" class="formchecker" rel="networks"/>
                                    Allow client to adjust with slider during order
                                </span>
                            </td>
                        </tr>

                        <tr>
                            <td width="160">
                                <label>Network Provisioning</label>
                            </td>
                            <td>
                                <select name="options[network_opt]" id="network_opt">
                                    <option value="">None</option>
                                    <option value="edgegate"
                                            {if $default.network_opt == 'edgegate' || $default.edgegate}selected{/if} >
                                        Create Edge gateway for VDC
                                    </option>
                                    <option value="orgvdcnet"
                                            {if $default.network_opt == 'orgvdcnet'}selected{/if}>
                                        Create Organization VDC Network connected to external network
                                    </option>
                                </select>
                            </td>
                        </tr>
                        <tr class="netopt net-edgegate net-orgvdcnet">
                            <td width="160" style="vertical-align: top">
                                <label>External network</label>
                            </td>
                            <td>
                                <div id="externalnetcontainer" class="tofetch clearfix">
                                    <select name="options[externalnet][]" multiple id="externalnet"
                                            class="form-control">
                                        <option value=""
                                                {if !$default.externalnet || in_array('', $default.externalnet)}selected{/if}
                                        > Auto
                                        </option>
                                        {if !in_array('', $default.externalnet)}
                                            {foreach from=$default.externalnet item=value}
                                                <option selected>{$value}</option>
                                            {/foreach}
                                        {/if}
                                    </select>
                                </div>
                                <div class="netopt net-orgvdcnet">
                                    <div class="checkbox">
                                        <label>
                                            <input type="checkbox" value="1" name="options[separate_net]"
                                                {if $default.separate_net}checked{/if} />
                                            Use separate external network for each VDC.
                                        </label>
                                    </div>
                                </div>
                            </td>
                        </tr>
                        <tr class="netopt net-edgegate">
                            <td width="160">
                                <label>IP Allocation</label>
                            </td>
                            <td>
                                <input type="text" size="3" name="options[allocateips]"
                                       value="{$default.allocateips}" id="allocateips"/>
                                <span class="fs11"><input type="checkbox" class="formchecker" rel="allocateips"/> Allow
                                    client to adjust with slider during order</span>
                            </td>
                        </tr>
                        <tr class="netopt net-edgegate">
                            <td width="160"><label>Enable Rate Limit</label></td>
                            <td>
                                <div class="checkbox">
                                    <label>
                                        <input type="checkbox" size="3" name="options[ratelimit]"
                                               value="1" id="ratelimit" {if $default.ratelimit}checked{/if} />
                                        Enable this if you want to apply rate limit on edge gateway.
                                    </label>
                                </div>
                            </td>
                        </tr>
                        <tr class="netopt net-edgegate">
                            <td width="160"><label>Incoming Rate Limit [Gbps]</label></td>
                            <td>
                                <input type="text" size="3" name="options[inratelimit]"
                                       value="{$default.inratelimit}" id="inratelimit"/>
                                <span class="fs11"><input type="checkbox" class="formchecker" rel="inratelimit"/> Allow
                                    client to adjust with slider during order</span>
                            </td>
                        </tr>
                        <tr class="netopt net-edgegate">
                            <td width="160"><label>Outgoing Rate Limit [Gbps]</label></td>
                            <td>
                                <input type="text" size="3" name="options[outratelimit]"
                                       value="{$default.outratelimit}" id="outratelimit"/>
                                <span class="fs11"><input type="checkbox" class="formchecker" rel="outratelimit"/> Allow
                                    client to adjust with slider during order</span>
                            </td>
                        </tr>
                        <tr class="netopt net-edgegate">
                            <td width="160"><label>Org VDC Network</label></td>
                            <td>
                                <div class="checkbox">
                                    <label>
                                        <input type="checkbox" size="3" name="options[orgvdcnet]"
                                               value="1" id="orgnet" {if $default.orgvdcnet}checked{/if}/>
                                        Create a routed network for VDC
                                    </label>
                                </div>
                            </td>
                        </tr>
                    </table>
                    <div class="nav-er" id="step-5">
                        <a href="#" class="prev-step">Previous step</a>
                        <a href="#" class="next-step">Next step</a>
                    </div>
                </div>
                <div class="onapptab form" id="finish_tab">
                    <table border="0" cellspacing="0" width="100%" cellpadding="6">
                        <tr>
                            <td colspan="2" class="onapp-preloader" style=""><img
                                        src="templates/default/img/ajax-loader3.gif"> Fetching data from vCloud
                                Director, please wait...
                            </td>
                        </tr>
                        <tr>
                            <td valign="top" width="160" style="border-right:1px solid #E9E9E9">
                                <h4 class="finish">Finish</h4>
                                <span class="fs11" style="color:#C2C2C2">Save &amp; start selling</span>
                            </td>
                            <td valign="top">
                                Your VMWare vCloud Director package is ready to be purchased. <br/>
                            </td>
                        </tr>
                    </table>
                </div>
            </div>

            <link href="../includes/modules/Hosting/vcloud/templates/product.css" rel="stylesheet" media="all">
            <script src="../includes/modules/Hosting/vcloud/templates/product.js" type="text/javascript"></script>
            <script type="text/javascript">
                {if $_isajax}setTimeout('append_onapp()', 50);
                {else}appendLoader('append_onapp');{/if}
            </script>
        </div>
    </td>
</tr>